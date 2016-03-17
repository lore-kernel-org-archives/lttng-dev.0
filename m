From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: CTF Compact Header Timestamps
Date: Thu, 17 Mar 2016 00:15:36 +0000 (UTC)
Message-ID: <1330593963.27772.1458173736972.JavaMail.zimbra__23926.6069759198$1458173776$gmane$org@efficios.com>
References: <BLUPR03MB1180BF1909497239E300878D38A0@BLUPR03MB118.namprd03.prod.outlook.com>
 <BN3PR00MB00034381CC2491E679BD1371C88A0@BN3PR00MB0003.namprd00.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8779872987636427401=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 9A020A0818
 for <lttng-dev@lists.lttng.org>; Thu, 17 Mar 2016 00:15:46 +0000 (UTC)
In-Reply-To: <BN3PR00MB00034381CC2491E679BD1371C88A0@BN3PR00MB0003.namprd00.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Brian Robbins <brianrob@microsoft.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Lee Culver <leculver@microsoft.com>
List-Id: lttng-dev@lists.lttng.org

--===============8779872987636427401==
Content-Type: multipart/alternative;
	boundary="----=_Part_27771_2004620774.1458173736971"

------=_Part_27771_2004620774.1458173736971
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Brian,=20

You should think about those 27 bits as the "new lowest significant bits"=
=20
of the 64-bit clock.=20

Quoting the CTF spec to understand how to deal with 27-bit overflow=20
between two consecutive time-stamps in the same stream (here N =3D 27):=20

"For a N-bit integer type referring to a clock, if the integer overflows co=
mpared to the N low order bits of the clock prior value found in the same s=
tream, then it is assumed that one, and only one, overflow occurred. It is =
therefore important that events encoding time on a small number of bits hap=
pen frequently enough to detect when more than one N-bit overflow occurs."=
=20

Those 27 bits are _not_ an offset from the previous timestamp. They update =
the=20
current notion of time (based on all prior timestamps read for this stream)=
 by=20
setting the low 27 bits to the new value. If that value happens to be lower=
 than the=20
previous 27 low bits of the current time, this means we had one 27-bit over=
flow, so=20
we need to increment the 28th bit by one.=20

In each packet header, you will find the full 64-bit timestamps, so we alwa=
ys=20
have a full 64-bit base from which to start.=20

It is up to the tracer (lttng) to ensure that there is never more than a si=
ngle 27-bit=20
overflow preceding a 27-bit compact timestamp. If lttng detects that there =
would=20
be more than a single 27-bit overflow prior to a timestamp, it will use an =
extended=20
header which stores the full 64-bit of the new timestamp.=20

We rely on this time-compaction scheme rather than offsetting from the prio=
r=20
64-bit timestamp because it allows us to weaken the sequential inter-depend=
ency=20
between consecutive events, which is useful for lock-free ring buffers.=20

Let me know if you still have questions,=20

Thanks,=20

Mathieu=20

----- On Mar 16, 2016, at 6:55 PM, Brian Robbins <brianrob@microsoft.com> w=
rote:=20

> Hello,

> I=E2=80=99m forwarding this on-behalf of one of my colleagues who is tryi=
ng to parse
> CTF. Any help you can provide is greatly appreciated.

> Thanks.

> -Brian

> From: Lee Culver
> Sent: Wednesday, March 16, 2016 11:06 AM
> To: Brian Robbins <brianrob@microsoft.com>
> Subject: CTF Compact Header Timestamps

> Event headers in LTTng can have a 27-bit clock or a 64-bit clock. I have =
been
> able to properly map the 64-bit clock back to a real timestamp, but I=E2=
=80=99m not
> sure how to interpret the 27-bit clock value. I=E2=80=99ve dug through th=
e CTF
> specification but can=E2=80=99t find the relevant text. I have pasted the=
 relevant
> metadata at the bottom of this email.

> For 64-bit clocks, this calculation gets us to the proper DateTime in C#:

> var clock =3D _metadata.Clocks.Single();

> var offset =3D new DateTime(1970, 1, 1, 0, 0, 0, 0,
> DateTimeKind.Utc).AddSeconds(clock.Offset / clock.Frequency);

> long ticks =3D (long)(header.Timestamp * 10000000.0 / clock.Frequency);

> var time =3D new DateTime(offset.Ticks + ticks, DateTimeKind.Utc);

> However, for the =E2=80=98compact=E2=80=99 variant (see below), we end up=
 with a timestamp
> that=E2=80=99s far lower than the frequency, such as =E2=80=980x55363b9=
=E2=80=99 and I=E2=80=99m simply not
> sure how to interpret this. It does NOT seem to be an offset from the pre=
vious
> event since if I treat it as such we get events that are out of order. On=
e such
> example is the following:

> Event #11 - Extended header timestamp (64-bit): 0x00098a754555ea28

> Event #12 - Compact header timestamp (27-bit): 0x04ecc38c

> Event #13 - Extended header timestamp (64-bit): 0x00098a75369cc5e4

> As you can see, Event[11].Timestamp + Event[12].Timestamp > Event[13].Tim=
estamp.
> Which means it cannot be a simple =E2=80=9Coffset from previous event=E2=
=80=9D, since we would
> be getting events out of order.

> Here is the relevant metadata:

> clock {

> name =3D "monotonic";

> uuid =3D "9fb57333-ada2-4c73-a7ce-334f46437c74";

> description =3D "Monotonic Clock";

> freq =3D 1000000000; /* Frequency, in Hz */

> /* clock value offset from Epoch is: offset * (1/freq) */

> offset =3D 1451946230228988436;

> };

> typealias integer {

> size =3D 27; align =3D 1; signed =3D false;

> map =3D clock.monotonic.value;

> } :=3D uint27_clock_monotonic_t;

> typealias integer {

> size =3D 64; align =3D 8; signed =3D false;

> map =3D clock.monotonic.value;

> } :=3D uint64_clock_monotonic_t;

> struct event_header_compact {

> enum : uint5_t { compact =3D 0 ... 30, extended =3D 31 } id;

> variant <id> {

> struct {

> uint27_clock_monotonic_t timestamp;

> } compact;

> struct {

> uint32_t id;

> uint64_clock_monotonic_t timestamp;

> } extended;

> } v;

> } align(8);

> How should we be treating these uint27_clock_monotonic_t values?

> Thanks!

> -Lee Culver

> CLR Reliability and Performance

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_27771_2004620774.1458173736971
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi Brian,</div><div><br data-mce-bogus=3D"1=
"></div><div>You should think about those 27 bits as the "new lowest signif=
icant bits"</div><div>of the 64-bit clock.<br></div><div><br data-mce-bogus=
=3D"1"></div><div>Quoting the CTF spec to understand how to deal with 27-bi=
t overflow</div><div>between two consecutive time-stamps in the same stream=
 (here N =3D 27):<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"=
1"></div><div>"For a N-bit integer type referring to a clock, if the intege=
r overflows compared to the N low order bits of the clock prior value found=
 in the same stream, then it is assumed that one, and only one, overflow oc=
curred. It is therefore important that events encoding time on a small numb=
er of bits happen frequently enough to detect when more than one N-bit over=
flow occurs."<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"><=
/div><div>Those 27 bits are _not_ an offset from the previous timestamp. Th=
ey update the<br data-mce-bogus=3D"1"></div><div>current notion of time (ba=
sed on all prior timestamps read for this stream) by<br data-mce-bogus=3D"1=
"></div><div>setting the low 27 bits to the new value. If that value happen=
s to be lower than the<br data-mce-bogus=3D"1"></div><div>previous 27 low b=
its of the current time, this means we had one 27-bit overflow, so<br data-=
mce-bogus=3D"1"></div><div>we need to increment the 28th bit by one.<br dat=
a-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>In each pa=
cket header, you will find the full 64-bit timestamps, so we always<br data=
-mce-bogus=3D"1"></div><div>have a full 64-bit base from which to start.<br=
 data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>It is =
up to the tracer (lttng) to ensure that there is never more than a single 2=
7-bit<br data-mce-bogus=3D"1"></div><div>overflow preceding a 27-bit compac=
t timestamp. If lttng detects that there would<br data-mce-bogus=3D"1"></di=
v><div>be more than a single 27-bit overflow prior to a timestamp, it will =
use an extended<br data-mce-bogus=3D"1"></div><div>header which stores the =
full 64-bit of the new timestamp.<br data-mce-bogus=3D"1"></div><div><br></=
div><div>We rely on this time-compaction scheme rather than offsetting from=
 the prior<br data-mce-bogus=3D"1"></div><div>64-bit timestamp because it a=
llows us to weaken the sequential inter-dependency<br data-mce-bogus=3D"1">=
</div><div>between consecutive events, which is useful for lock-free ring b=
uffers.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><=
div>Let me know if you still have questions,<br data-mce-bogus=3D"1"></div>=
<div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></=
div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1=
"></div><div><br data-mce-bogus=3D"1"></div><div><span id=3D"zwchr" data-ma=
rker=3D"__DIVIDER__">----- On Mar 16, 2016, at 6:55 PM, Brian Robbins &lt;b=
rianrob@microsoft.com&gt; wrote:<br></span></div><div data-marker=3D"__QUOT=
ED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5=
px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-de=
coration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;">



<style><!--

@font-face
=09{font-family:"Cambria Math";
=09panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
=09{font-family:Consolas;
=09panose-1:2 11 6 9 2 2 4 3 2 4;}

p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0in;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri",sans-serif;
=09color:#7030A0;}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:#0563C1;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:#954F72;
=09text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
=09{mso-style-name:msonormal;
=09mso-margin-top-alt:auto;
=09margin-right:0in;
=09mso-margin-bottom-alt:auto;
=09margin-left:0in;
=09font-size:12.0pt;
=09font-family:"Times New Roman",serif;}
span.EmailStyle18
=09{mso-style-type:personal;
=09font-family:"Calibri",sans-serif;
=09color:windowtext;}
span.EmailStyle19
=09{mso-style-type:personal-reply;
=09font-family:"Calibri",sans-serif;
=09color:windowtext;}
.MsoChpDefault
=09{mso-style-type:export-only;
=09font-size:10.0pt;}
@page WordSection1
=09{size:8.5in 11.0in;
=09margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
=09{page:WordSection1;}
--></style>


<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:windowtext">Hello,</span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">&nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">I=E2=80=99m forward=
ing this on-behalf of one of my colleagues who is trying to parse CTF.&nbsp=
; Any help you can provide is greatly appreciated.</span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">&nbsp;</span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">Thanks.</span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">-Brian</span></p>
<p class=3D"MsoNormal"><a name=3D"_MailEndCompose"><span style=3D"color:win=
dowtext">&nbsp;</span></a><br data-mce-bogus=3D"1"></p>
<span style=3D"mso-bookmark:_MailEndCompose"></span>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"color:windowtext">From:</span></b>=
<span style=3D"color:windowtext"> Lee Culver
<br>
<b>Sent:</b> Wednesday, March 16, 2016 11:06 AM<br>
<b>To:</b> Brian Robbins &lt;brianrob@microsoft.com&gt;<br>
<b>Subject:</b> CTF Compact Header Timestamps</span></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">Event headers in LTTng can have a 27-bit clock or a =
64-bit clock.&nbsp; I have been able to properly map the 64-bit clock back =
to a real timestamp, but I=E2=80=99m not sure how to interpret the 27-bit c=
lock value.&nbsp; I=E2=80=99ve dug through the CTF specification
 but can=E2=80=99t find the relevant text.&nbsp; I have pasted the relevant=
 metadata at the bottom of this email.</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">For 64-bit clocks, this calculation gets us to the p=
roper DateTime in C#:</p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;background:white;mso-highlight:white">&nbsp;<=
/span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;background:white;mso-highlight:white">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; var clock =3D _=
metadata.Clocks.Single();</span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;background:white;mso-highlight:white">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; var offset =3D =
new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc).AddSeconds(clock.Off=
set / clock.Frequency);</span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;background:white;mso-highlight:white">&nbsp;<=
/span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;background:white;mso-highlight:white">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long ticks =3D =
(long)(header.Timestamp * 10000000.0 / clock.Frequency);</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.5pt;font-family:Consolas;=
background:white;mso-highlight:white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; var time =3D new DateTime(offset.Ticks + tick=
s, DateTimeKind.Utc);</span></p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">However, for the =E2=80=98compact=E2=80=99 variant (=
see below), we end up with a timestamp that=E2=80=99s far lower than the fr=
equency, such as =E2=80=980x55363b9=E2=80=99 and I=E2=80=99m simply not sur=
e how to interpret this.&nbsp; It does NOT seem to be an offset from the pr=
evious event
 since if I treat it as such we get events that are out of order.&nbsp; One=
 such example is the following:</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Event #11 - Extended header timestam=
p (64-bit): 0x00098a754555ea28</p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">Event #12 - Compact heade=
r timestamp (27-bit): 0x04ecc38c</p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">Event #13 - Extended head=
er timestamp (64-bit): 0x00098a75369cc5e4</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">As you can see, Event[11].Timestamp + Event[12].Time=
stamp &gt; Event[13].Timestamp.&nbsp; Which means it cannot be a simple =E2=
=80=9Coffset from previous event=E2=80=9D, since we would be getting events=
 out of order.</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">Here is the relevant metadata:</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">clock {</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; name =3D "monotonic";</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; uuid =3D "9fb57333-ada2-4c73-a7ce-334f46437c74";</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; description =3D "Monotonic Clock";</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; freq =3D 1000000000; /* Frequency, in Hz */</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* clock value offset from Epoch is: offset * (1/freq) */</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; offset =3D 1451946230228988436;</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">};</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">typealias integer {</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; size =3D 27; align =3D 1; signed =3D false;</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; map =3D clock.monotonic.value;</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">} :=3D uint27_clock_monotonic_=
t;</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">typealias integer {</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; size =3D 64; align =3D 8; signed =3D false;</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; map =3D clock.monotonic.value;</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">} :=3D uint64_clock_monotonic_=
t;</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">struct event_header_compact {<=
/span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; enum : uint5_t { compact =3D 0 ... 30, extended =3D 31 } id;</span><=
/p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; variant &lt;id&gt; {</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint27_clock_monotonic_t timestamp;</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } compact;</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t id;</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint64_clock_monotonic_t timestamp;</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } extended;</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; } v;</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">} align(8);</span><span style=
=3D"color:windowtext"></span></p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">How should we be treating these <span style=3D"font-=
size:9.5pt;font-family:Consolas">
uint27_clock_monotonic_t</span> values?</p>
<p class=3D"MsoNormal">&nbsp;</p>
<p class=3D"MsoNormal">Thanks!</p>
<p class=3D"MsoNormal">-Lee Culver</p>
<p class=3D"MsoNormal">CLR Reliability and Performance</p>
<p class=3D"MsoNormal">&nbsp;</p>
</div>


<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
------=_Part_27771_2004620774.1458173736971--

--===============8779872987636427401==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8779872987636427401==--
