From: Shehab Elsayed <shehabyomn@gmail.com>
Subject: Re: Babeltrace with python bindings unable to read ust
	trace
Date: Mon, 5 Mar 2018 21:39:19 -0500
Message-ID: <CAC-H6tteVhfxzwfHk2-NDUgjox8FwoKFAZueFztJDVqMVR_Mww__48132.4031170972$1520303851$gmane$org@mail.gmail.com>
References: <CAC-H6tt_0gWE2dGWRe1KMkO4J0HsbiubiQ3bys60n_p__8=49A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1429906181767805409=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-x233.google.com (mail-lf0-x233.google.com
 [IPv6:2a00:1450:4010:c07::233])
 by lists.lttng.org (Postfix) with ESMTPS id 3zwLZf2qWdzqdV
 for <lttng-dev@lists.lttng.org>; Mon,  5 Mar 2018 21:39:21 -0500 (EST)
Received: by mail-lf0-x233.google.com with SMTP id y19so26233586lfd.4
 for <lttng-dev@lists.lttng.org>; Mon, 05 Mar 2018 18:39:21 -0800 (PST)
In-Reply-To: <CAC-H6tt_0gWE2dGWRe1KMkO4J0HsbiubiQ3bys60n_p__8=49A@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1429906181767805409==
Content-Type: multipart/alternative; boundary="f4f5e807ff147829c50566b5597f"

--f4f5e807ff147829c50566b5597f
Content-Type: text/plain; charset="UTF-8"

Never mind. I figured out the problem. I was only passing the ust trace
path up to /ust when I should have gone all the way to the actual subfolder
that holds the metadata file.

Shehab Y. Elsayed, MSc.
PhD Student
The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
University of Toronto
E-mail: shehabyomn@gmail.com
<https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11#>

On Mon, Mar 5, 2018 at 9:07 PM, Shehab Elsayed <shehabyomn@gmail.com> wrote:

> Hello All,
>
> I am running into this problem where using babeltrace with python bindings
> is unable to read a ust trace even though the trace can be processed
> normally if I run babeltrace from the command line.
>
> I have tried the example given in the LTTng documentation for using
> babeltrace with python bindings. It works normally with a kernel trace.
> However, when I give it a ust trace (just to see if it can open it) I get
> the following error:
>
> Unable to open metadata.
> [warning] Unable to open trace metadata for path "/md1200/home/elsayed9/
> LTTng/lttng-traces/hello-test-session-20180219-184952/ust/".
> [warning] [Context] Cannot open_trace of format ctf at path
> /md1200/home/elsayed9/LTTng/lttng-traces/hello-test-session-
> 20180219-184952/ust/.
> Traceback (most recent call last):
>   File "test.py", line 70, in <module>
>     sys.exit(0 if top5proc() else 1)
>   File "test.py", line 18, in top5proc
>     raise RuntimeError('Cannot add trace')
> RuntimeError: Cannot add trace
>
> Any ideas on how to solve this problem are greatly appreciated.
>
> Thanks,
> Shehab
>

--f4f5e807ff147829c50566b5597f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Never mind. I figured out the problem. I was only passing =
the ust trace path up to /ust when I should have gone all the way to the ac=
tual subfolder that holds the metadata file.<br></div><div class=3D"gmail_e=
xtra"><br clear=3D"all"><div><div class=3D"gmail_signature" data-smartmail=
=3D"gmail_signature"><div dir=3D"ltr"><font color=3D"#888888">Shehab Y. Els=
ayed, MSc.<br>
PhD Student<br>The Edwards S. Rogers Sr. Dept. of Electrical and Computer E=
ngineering<br>University of Toronto </font><font color=3D"#888888"><a value=
=3D"+20124498360"><span dir=3D"ltr"></span></a><br>
E-mail: <a href=3D"https://webmail.rice.edu/imp/message.php?mailbox=3DINBOX=
&amp;index=3D11#" target=3D"_blank">shehabyomn@gmail.com</a></font></div></=
div></div>
<br><div class=3D"gmail_quote">On Mon, Mar 5, 2018 at 9:07 PM, Shehab Elsay=
ed <span dir=3D"ltr">&lt;<a href=3D"mailto:shehabyomn@gmail.com" target=3D"=
_blank">shehabyomn@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"><div dir=3D"ltr"><div><div><div><div><div>Hello All,<br><br></div=
>I am running into this problem where using babeltrace with python bindings=
 is unable to read a <span id=3D"m_-6348648304892788267:3iy.1">ust</span> t=
race even though the trace can be processed normally if I run <span id=3D"m=
_-6348648304892788267:3iy.2">babeltrace</span> from the command line.<br><b=
r></div>I have tried the example given in the <span id=3D"m_-63486483048927=
88267:3iy.3">LTTng</span> documentation for using <span id=3D"m_-6348648304=
892788267:3iy.4">babeltrace</span> with python bindings. It works normally =
with a kernel trace. However, when I give it a <span id=3D"m_-6348648304892=
788267:3iy.5">ust</span> trace (just to see if it can open it) I get the fo=
llowing error:<br><br>Unable to open <span id=3D"m_-6348648304892788267:3iy=
.6">metadata</span>.<br>[warning] Unable to open trace <span id=3D"m_-63486=
48304892788267:3iy.7">metadata</span> for path &quot;/md1200/home/elsayed9/=
<span id=3D"m_-6348648304892788267:3iy.8">LTTng</span>/<span id=3D"m_-63486=
48304892788267:3iy.9">l<wbr>ttng</span>-traces/hello-test-<wbr>session-2018=
0219-184952/<span id=3D"m_-6348648304892788267:3iy.10">ust</span>/&quot;.<b=
r>[warning] [Context] Cannot open_trace of format <span id=3D"m_-6348648304=
892788267:3iy.11">ctf</span> at path /md1200/home/elsayed9/<span id=3D"m_-6=
348648304892788267:3iy.12">LTTng</span>/<span id=3D"m_-6348648304892788267:=
3iy.13">lt<wbr>tng</span>-traces/hello-test-session-<wbr>20180219-184952/<s=
pan id=3D"m_-6348648304892788267:3iy.14">ust</span>/.<br><span id=3D"m_-634=
8648304892788267:3iy.15">Traceback</span> (most recent call last):<br>=C2=
=A0 File &quot;test.<span id=3D"m_-6348648304892788267:3iy.16">py</span>&qu=
ot;, line 70, in &lt;module&gt;<br>=C2=A0=C2=A0=C2=A0 <span id=3D"m_-634864=
8304892788267:3iy.17">sys</span>.exit(0 if top5proc() else 1)<br>=C2=A0 Fil=
e &quot;test.<span id=3D"m_-6348648304892788267:3iy.18">py</span>&quot;, li=
ne 18, in top5proc<br>=C2=A0=C2=A0=C2=A0 raise <span id=3D"m_-6348648304892=
788267:3iy.19">RuntimeError</span>(&#39;Cannot add trace&#39;)<br><span id=
=3D"m_-6348648304892788267:3iy.20">RuntimeError</span>: Cannot add trace<br=
><br></div>Any ideas on how to solve this problem are greatly appreciated.<=
br><br></div>Thanks,<br></div><span id=3D"m_-6348648304892788267:3iy.21">Sh=
ehab</span><br></div>
</blockquote></div><br></div>

--f4f5e807ff147829c50566b5597f--

--===============1429906181767805409==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1429906181767805409==--
