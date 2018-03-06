From: Shehab Elsayed <shehabyomn@gmail.com>
Subject: Babeltrace with python bindings unable to read ust trace
Date: Mon, 5 Mar 2018 21:07:29 -0500
Message-ID: <CAC-H6tt_0gWE2dGWRe1KMkO4J0HsbiubiQ3bys60n_p__8=49A__34253.3882860609$1520301939$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1506539425118799793=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-x231.google.com (mail-lf0-x231.google.com
 [IPv6:2a00:1450:4010:c07::231])
 by lists.lttng.org (Postfix) with ESMTPS id 3zwKsv5sqGzqYY
 for <lttng-dev@lists.lttng.org>; Mon,  5 Mar 2018 21:07:31 -0500 (EST)
Received: by mail-lf0-x231.google.com with SMTP id i80so26164740lfg.5
 for <lttng-dev@lists.lttng.org>; Mon, 05 Mar 2018 18:07:31 -0800 (PST)
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

--===============1506539425118799793==
Content-Type: multipart/alternative; boundary="94eb2c1c22229df4b40566b4e761"

--94eb2c1c22229df4b40566b4e761
Content-Type: text/plain; charset="UTF-8"

Hello All,

I am running into this problem where using babeltrace with python bindings
is unable to read a ust trace even though the trace can be processed
normally if I run babeltrace from the command line.

I have tried the example given in the LTTng documentation for using
babeltrace with python bindings. It works normally with a kernel trace.
However, when I give it a ust trace (just to see if it can open it) I get
the following error:

Unable to open metadata.
[warning] Unable to open trace metadata for path "/md1200/home/elsayed9/
LTTng/lttng-traces/hello-test-session-20180219-184952/ust/".
[warning] [Context] Cannot open_trace of format ctf at path
/md1200/home/elsayed9/LTTng/lttng-traces/hello-test-session-20180219-184952/
ust/.
Traceback (most recent call last):
  File "test.py", line 70, in <module>
    sys.exit(0 if top5proc() else 1)
  File "test.py", line 18, in top5proc
    raise RuntimeError('Cannot add trace')
RuntimeError: Cannot add trace

Any ideas on how to solve this problem are greatly appreciated.

Thanks,
Shehab

--94eb2c1c22229df4b40566b4e761
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>Hello All,<br><br></div>I am runn=
ing into this problem where using babeltrace with python bindings is unable=
 to read a <span class=3D"" style=3D"" id=3D":3iy.1" tabindex=3D"-1">ust</s=
pan> trace even though the trace can be processed normally if I run <span c=
lass=3D"" style=3D"" id=3D":3iy.2" tabindex=3D"-1">babeltrace</span> from t=
he command line.<br><br></div>I have tried the example given in the <span c=
lass=3D"" style=3D"" id=3D":3iy.3" tabindex=3D"-1">LTTng</span> documentati=
on for using <span class=3D"" style=3D"" id=3D":3iy.4" tabindex=3D"-1">babe=
ltrace</span> with python bindings. It works normally with a kernel trace. =
However, when I give it a <span class=3D"" style=3D"" id=3D":3iy.5" tabinde=
x=3D"-1">ust</span> trace (just to see if it can open it) I get the followi=
ng error:<br><br>Unable to open <span class=3D"" style=3D"" id=3D":3iy.6" t=
abindex=3D"-1">metadata</span>.<br>[warning] Unable to open trace <span cla=
ss=3D"" style=3D"" id=3D":3iy.7" tabindex=3D"-1">metadata</span> for path &=
quot;/md1200/home/elsayed9/<span class=3D"" style=3D"" id=3D":3iy.8" tabind=
ex=3D"-1">LTTng</span>/<span class=3D"" style=3D"" id=3D":3iy.9" tabindex=
=3D"-1">lttng</span>-traces/hello-test-session-20180219-184952/<span class=
=3D"" style=3D"" id=3D":3iy.10" tabindex=3D"-1">ust</span>/&quot;.<br>[warn=
ing] [Context] Cannot open_trace of format <span class=3D"" style=3D"" id=
=3D":3iy.11" tabindex=3D"-1">ctf</span> at path /md1200/home/elsayed9/<span=
 class=3D"" style=3D"" id=3D":3iy.12" tabindex=3D"-1">LTTng</span>/<span cl=
ass=3D"" style=3D"" id=3D":3iy.13" tabindex=3D"-1">lttng</span>-traces/hell=
o-test-session-20180219-184952/<span class=3D"" style=3D"" id=3D":3iy.14" t=
abindex=3D"-1">ust</span>/.<br><span class=3D"" style=3D"" id=3D":3iy.15" t=
abindex=3D"-1">Traceback</span> (most recent call last):<br>=C2=A0 File &qu=
ot;test.<span class=3D"" style=3D"" id=3D":3iy.16" tabindex=3D"-1">py</span=
>&quot;, line 70, in &lt;module&gt;<br>=C2=A0=C2=A0=C2=A0 <span class=3D"" =
style=3D"" id=3D":3iy.17" tabindex=3D"-1">sys</span>.exit(0 if top5proc() e=
lse 1)<br>=C2=A0 File &quot;test.<span class=3D"" style=3D"" id=3D":3iy.18"=
 tabindex=3D"-1">py</span>&quot;, line 18, in top5proc<br>=C2=A0=C2=A0=C2=
=A0 raise <span class=3D"" style=3D"" id=3D":3iy.19" tabindex=3D"-1">Runtim=
eError</span>(&#39;Cannot add trace&#39;)<br><span class=3D"" style=3D"" id=
=3D":3iy.20" tabindex=3D"-1">RuntimeError</span>: Cannot add trace<br><br><=
/div>Any ideas on how to solve this problem are greatly appreciated.<br><br=
></div>Thanks,<br></div><span class=3D"" style=3D"" id=3D":3iy.21" tabindex=
=3D"-1">Shehab</span><br></div>

--94eb2c1c22229df4b40566b4e761--

--===============1506539425118799793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1506539425118799793==--
