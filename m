From: Brian Robbins <brianrob@microsoft.com>
Subject: CTF Compact Header Timestamps
Date: Wed, 16 Mar 2016 22:55:13 +0000
Message-ID: <BN3PR00MB00034381CC2491E679BD1371C88A0__12801.5299830169$1458168963$gmane$org@BN3PR00MB0003.namprd00.prod.outlook.com>
References: <BLUPR03MB1180BF1909497239E300878D38A0@BLUPR03MB118.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7063285061322980508=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0110.outbound.protection.outlook.com [157.56.110.110])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 4EC79A0951
 for <lttng-dev@lists.lttng.org>; Wed, 16 Mar 2016 22:55:37 +0000 (UTC)
In-Reply-To: <BLUPR03MB1180BF1909497239E300878D38A0@BLUPR03MB118.namprd03.prod.outlook.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: Lee Culver <leculver@microsoft.com>
List-Id: lttng-dev@lists.lttng.org

--===============7063285061322980508==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN3PR00MB00034381CC2491E679BD1371C88A0BN3PR00MB0003namp_"

--_000_BN3PR00MB00034381CC2491E679BD1371C88A0BN3PR00MB0003namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I'm forwarding this on-behalf of one of my colleagues who is trying to pars=
e CTF.  Any help you can provide is greatly appreciated.

Thanks.
-Brian

From: Lee Culver
Sent: Wednesday, March 16, 2016 11:06 AM
To: Brian Robbins <brianrob@microsoft.com>
Subject: CTF Compact Header Timestamps

Event headers in LTTng can have a 27-bit clock or a 64-bit clock.  I have b=
een able to properly map the 64-bit clock back to a real timestamp, but I'm=
 not sure how to interpret the 27-bit clock value.  I've dug through the CT=
F specification but can't find the relevant text.  I have pasted the releva=
nt metadata at the bottom of this email.

For 64-bit clocks, this calculation gets us to the proper DateTime in C#:

            var clock =3D _metadata.Clocks.Single();
            var offset =3D new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKin=
d.Utc).AddSeconds(clock.Offset / clock.Frequency);

            long ticks =3D (long)(header.Timestamp * 10000000.0 / clock.Fre=
quency);
            var time =3D new DateTime(offset.Ticks + ticks, DateTimeKind.Ut=
c);

However, for the 'compact' variant (see below), we end up with a timestamp =
that's far lower than the frequency, such as '0x55363b9' and I'm simply not=
 sure how to interpret this.  It does NOT seem to be an offset from the pre=
vious event since if I treat it as such we get events that are out of order=
.  One such example is the following:

                Event #11 - Extended header timestamp (64-bit): 0x00098a754=
555ea28
Event #12 - Compact header timestamp (27-bit): 0x04ecc38c
Event #13 - Extended header timestamp (64-bit): 0x00098a75369cc5e4

As you can see, Event[11].Timestamp + Event[12].Timestamp > Event[13].Times=
tamp.  Which means it cannot be a simple "offset from previous event", sinc=
e we would be getting events out of order.

Here is the relevant metadata:

clock {
       name =3D "monotonic";
       uuid =3D "9fb57333-ada2-4c73-a7ce-334f46437c74";
       description =3D "Monotonic Clock";
       freq =3D 1000000000; /* Frequency, in Hz */
       /* clock value offset from Epoch is: offset * (1/freq) */
       offset =3D 1451946230228988436;
};


typealias integer {
       size =3D 27; align =3D 1; signed =3D false;
       map =3D clock.monotonic.value;
} :=3D uint27_clock_monotonic_t;

typealias integer {
       size =3D 64; align =3D 8; signed =3D false;
       map =3D clock.monotonic.value;
} :=3D uint64_clock_monotonic_t;

struct event_header_compact {
       enum : uint5_t { compact =3D 0 ... 30, extended =3D 31 } id;
       variant <id> {
              struct {
                     uint27_clock_monotonic_t timestamp;
              } compact;
              struct {
                     uint32_t id;
                     uint64_clock_monotonic_t timestamp;
              } extended;
       } v;
} align(8);

How should we be treating these uint27_clock_monotonic_t values?

Thanks!
-Lee Culver
CLR Reliability and Performance


--_000_BN3PR00MB00034381CC2491E679BD1371C88A0BN3PR00MB0003namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	color:#7030A0;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"color:windowtext">Hello,<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">I&#8217;m forwardin=
g this on-behalf of one of my colleagues who is trying to parse CTF.&nbsp; =
Any help you can provide is greatly appreciated.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">Thanks.<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"color:windowtext">-Brian<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><a name=3D"_MailEndCompose"><span style=3D"color:win=
dowtext"><o:p>&nbsp;</o:p></span></a></p>
<span style=3D"mso-bookmark:_MailEndCompose"></span>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"color:windowtext">From:</span></b>=
<span style=3D"color:windowtext"> Lee Culver
<br>
<b>Sent:</b> Wednesday, March 16, 2016 11:06 AM<br>
<b>To:</b> Brian Robbins &lt;brianrob@microsoft.com&gt;<br>
<b>Subject:</b> CTF Compact Header Timestamps<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Event headers in LTTng can have a 27-bit clock or a =
64-bit clock.&nbsp; I have been able to properly map the 64-bit clock back =
to a real timestamp, but I&#8217;m not sure how to interpret the 27-bit clo=
ck value.&nbsp; I&#8217;ve dug through the CTF specification
 but can&#8217;t find the relevant text.&nbsp; I have pasted the relevant m=
etadata at the bottom of this email.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">For 64-bit clocks, this calculation gets us to the p=
roper DateTime in C#:<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;background:white;mso-highlight:white"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;background:white;mso-highlight:white">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; var clock =3D _=
metadata.Clocks.Single();<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;background:white;mso-highlight:white">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; var offset =3D =
new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc).AddSeconds(clock.Off=
set / clock.Frequency);<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;background:white;mso-highlight:white"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-si=
ze:9.5pt;font-family:Consolas;background:white;mso-highlight:white">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long ticks =3D =
(long)(header.Timestamp * 10000000.0 / clock.Frequency);<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.5pt;font-family:Consolas;=
background:white;mso-highlight:white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; var time =3D new DateTime(offset.Ticks &#43; =
ticks, DateTimeKind.Utc);</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">However, for the &#8216;compact&#8217; variant (see =
below), we end up with a timestamp that&#8217;s far lower than the frequenc=
y, such as &#8216;0x55363b9&#8217; and I&#8217;m simply not sure how to int=
erpret this.&nbsp; It does NOT seem to be an offset from the previous event
 since if I treat it as such we get events that are out of order.&nbsp; One=
 such example is the following:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Event #11 - Extended header timestam=
p (64-bit): 0x00098a754555ea28<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">Event #12 - Compact heade=
r timestamp (27-bit): 0x04ecc38c<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in">Event #13 - Extended head=
er timestamp (64-bit): 0x00098a75369cc5e4<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">As you can see, Event[11].Timestamp &#43; Event[12].=
Timestamp &gt; Event[13].Timestamp.&nbsp; Which means it cannot be a simple=
 &#8220;offset from previous event&#8221;, since we would be getting events=
 out of order.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Here is the relevant metadata:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">clock {<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; name =3D &quot;monotonic&quot;;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; uuid =3D &quot;9fb57333-ada2-4c73-a7ce-334f46437c74&quot;;<o:p></o:p=
></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; description =3D &quot;Monotonic Clock&quot;;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; freq =3D 1000000000; /* Frequency, in Hz */<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* clock value offset from Epoch is: offset * (1/freq) */<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; offset =3D 1451946230228988436;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">};<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">typealias integer {<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; size =3D 27; align =3D 1; signed =3D false;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; map =3D clock.monotonic.value;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">} :=3D uint27_clock_monotonic_=
t;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">typealias integer {<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; size =3D 64; align =3D 8; signed =3D false;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; map =3D clock.monotonic.value;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">} :=3D uint64_clock_monotonic_=
t;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">struct event_header_compact {<=
o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; enum : uint5_t { compact =3D 0 ... 30, extended =3D 31 } id;<o:p></o=
:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; variant &lt;id&gt; {<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint27_clock_monotonic_t timestamp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } compact;<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint32_t id;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint64_clock_monotonic_t timestamp;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } extended;<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; } v;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in"><span style=3D"font-size:=
9.5pt;font-family:Consolas;color:windowtext">} align(8);</span><span style=
=3D"color:windowtext"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">How should we be treating these <span style=3D"font-=
size:9.5pt;font-family:Consolas">
uint27_clock_monotonic_t</span> values?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks!<o:p></o:p></p>
<p class=3D"MsoNormal">-Lee Culver<o:p></o:p></p>
<p class=3D"MsoNormal">CLR Reliability and Performance<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BN3PR00MB00034381CC2491E679BD1371C88A0BN3PR00MB0003namp_--

--===============7063285061322980508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7063285061322980508==--
