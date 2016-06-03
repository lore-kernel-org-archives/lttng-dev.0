From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: LTTng user mode performance observation
Date: Fri, 3 Jun 2016 06:23:34 +0000 (UTC)
Message-ID: <576554794.26523.1464935014956.JavaMail.zimbra__20772.2466010184$1464935042$gmane$org@efficios.com>
References: <D6EA0E80-F341-43D1-9C4B-780366947A19@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3792535596690791251=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 8D439A3799
 for <lttng-dev@lists.lttng.org>; Fri,  3 Jun 2016 06:23:39 +0000 (UTC)
In-Reply-To: <D6EA0E80-F341-43D1-9C4B-780366947A19@nxp.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Richard Schmitt <richard.schmitt@nxp.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, "Nghia (Tommy) Huynh" <nghia.huynh@utexas.edu>
List-Id: lttng-dev@lists.lttng.org

--===============3792535596690791251==
Content-Type: multipart/alternative;
	boundary="----=_Part_26522_1933404280.1464935014955"

------=_Part_26522_1933404280.1464935014955
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

---- On Jun 2, 2016, at 1:29 AM, Richard Schmitt <richard.schmitt@nxp.com> =
wrote:=20

> We are trying to use user space LTTng to perform some performance analysi=
s of
> fast-path layer 3 forwarding. We have seen that with the tracepoints enab=
led,
> we experience about a 30% increase in service time. This is spread out ov=
er two
> tracepoints so each one is still contributing a good amount.

> This fast path is fast, about 300 cycles so we are asking a lot of effici=
ency of
> the tracepoint but for comparison, we implemented a simple ring buffer. W=
hen we
> run with this type of capture, we only experience a 5% increase in servic=
e
> time.

> I=E2=80=99m looking for pointers. We=E2=80=99d rather use LTTng. Are ther=
e ways to tune LTTng
> ust for ultra high performance requirements. Perhaps there is a way we co=
uld
> write directly to ust=E2=80=99s ring buffers, or perhaps preallocate the =
buffers?

What is the target architecture ?=20

I'm currently working on proposing restartable sequence system call to the =
kernel to=20
improve the speed of getcpu and remove atomic operations from the fast path=
=20
on arm32, intel 32/64. This will be portable to other architectures too.=20

Make sure you run a kernel with sys_membarrier available, and that you have=
=20
a recent liburcu 0.9.x. This should take care of removing memory barriers f=
rom=20
the tracing fast path.=20

Thanks,=20

Mathieu=20

> Rich

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_26522_1933404280.1464935014955
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">---- On Jun 2, 2016, at 1:29 AM, Richard Schmitt &lt;richard.schmitt@nx=
p.com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><bloc=
kquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:=
5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;fo=
nt-family:Helvetica,Arial,sans-serif;font-size:12pt;"><style><!--

@font-face
=09{font-family:"Cambria Math";
=09panose-1:0 0 0 0 0 0 0 0 0 0;}
@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}

p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0in;
=09margin-bottom:.0001pt;
=09font-size:12.0pt;
=09font-family:Calibri;}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:#0563C1;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:#954F72;
=09text-decoration:underline;}
span.EmailStyle17
=09{mso-style-type:personal-compose;
=09font-family:Calibri;
=09color:windowtext;}
span.msoIns
=09{mso-style-type:export-only;
=09mso-style-name:"";
=09text-decoration:underline;
=09color:teal;}
.MsoChpDefault
=09{mso-style-type:export-only;
=09font-family:Calibri;}
@page WordSection1
=09{size:8.5in 11.0in;
=09margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
=09{page:WordSection1;}
--></style><div class=3D"WordSection1"><p class=3D"MsoNormal"><span style=
=3D"font-size:11.0pt">We are trying to use user space LTTng to perform some=
 performance analysis of fast-path layer 3 forwarding.&nbsp; We have seen t=
hat with the tracepoints enabled, we experience about a 30% increase in ser=
vice time.&nbsp;
 This is spread out over two tracepoints so each one is still contributing =
a good amount.</span></p><p class=3D"MsoNormal"><span style=3D"font-size:11=
.0pt">&nbsp;</span></p><p class=3D"MsoNormal"><span style=3D"font-size:11.0=
pt">This fast path is fast, about 300 cycles so we are asking a lot of effi=
ciency of the tracepoint but for comparison, we implemented a simple ring b=
uffer.&nbsp; When we run with this type of capture, we only experience
 a 5% increase in service time.</span></p><p class=3D"MsoNormal"><span styl=
e=3D"font-size:11.0pt">&nbsp;</span></p><p class=3D"MsoNormal"><span style=
=3D"font-size:11.0pt">I=E2=80=99m looking for pointers.&nbsp; We=E2=80=99d =
rather use LTTng.&nbsp; Are there ways to tune LTTng ust for ultra high per=
formance requirements.&nbsp; Perhaps there is &nbsp;a way we could write di=
rectly to ust=E2=80=99s ring buffers, or perhaps
 preallocate the buffers?</span></p></div></blockquote><div>What is the tar=
get architecture ?<br></div><div><br data-mce-bogus=3D"1"></div><div>I'm cu=
rrently working on proposing restartable sequence system call to the kernel=
 to<br data-mce-bogus=3D"1"></div><div>improve the speed of getcpu and remo=
ve atomic operations from the fast path<br data-mce-bogus=3D"1"></div><div>=
on arm32, intel 32/64. This will be portable to other architectures too.<br=
 data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Make s=
ure you run a kernel with sys_membarrier available, and that you have<br da=
ta-mce-bogus=3D"1"></div><div>a recent liburcu 0.9.x. This should take care=
 of removing memory barriers from<br data-mce-bogus=3D"1"></div><div>the tr=
acing fast path.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1=
"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-b=
ogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"b=
order-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;fo=
nt-weight:normal;font-style:normal;text-decoration:none;font-family:Helveti=
ca,Arial,sans-serif;font-size:12pt;"><div class=3D"WordSection1"><p class=
=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;</span></p><p class=
=3D"MsoNormal"><span style=3D"font-size:11.0pt">Rich</span></p></div><br>__=
_____________________________________________<br>lttng-dev mailing list<br>=
lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/listin=
fo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D"__SIG=
_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www=
.efficios.com</div></div></body></html>
------=_Part_26522_1933404280.1464935014955--

--===============3792535596690791251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3792535596690791251==--
