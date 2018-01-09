From: Majid Rezazadeh <majid3612@gmail.com>
Subject: LD_PRELOAD applications using lttng-ust-pthread
Date: Mon, 8 Jan 2018 22:35:39 -0500
Message-ID: <CACbQsw8qxK=8sFZqUs_9KL_bRy+-bTY70PE3kKHEMeSyZHmjaA__4707.56872459805$1515468844$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5761794222637885432=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pf0-x22f.google.com (mail-pf0-x22f.google.com
 [IPv6:2607:f8b0:400e:c00::22f])
 by lists.lttng.org (Postfix) with ESMTPS id 3zFyTV2DVpzp76
 for <lttng-dev@lists.lttng.org>; Tue,  9 Jan 2018 03:35:41 +0000 (UTC)
Received: by mail-pf0-x22f.google.com with SMTP id y5so3707608pff.13
 for <lttng-dev@lists.lttng.org>; Mon, 08 Jan 2018 19:35:41 -0800 (PST)
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

--===============5761794222637885432==
Content-Type: multipart/alternative; boundary="089e08210ae0dce7d005624f9bfc"

--089e08210ae0dce7d005624f9bfc
Content-Type: text/plain; charset="UTF-8"

Hi all

I am using lttng-ust-libc-wrapper for instrumenting some calls to libc for
some applications like Firefox and Chrome, but I receive "Segmentation
fault (core dumped)". I compile lttng-ust-pthread.c (gcc -fPIC -shared  -o
test.so lttng-ust-pthread.c -ldl) and then I use "LD_PRELOAD=test.so
firefox" but I receive segmentation fault (I have exported LD_LIBRARY_PATH
to the absolute path of test.so file). I found out that when I replace
tracepoints with printf in lttng_ust_pthread.c, I receive no error. It
seems that hooking tracepoints in this wrapper makes some problems. Do you
have any idea in this regard?

Thanks

Majid

--089e08210ae0dce7d005624f9bfc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:12.8px">Hi all</span><br><br><spa=
n style=3D"font-size:12.8px">I am using lttng-ust-libc-wr</span><font face=
=3D"arial, helvetica, sans-serif">apper=C2=A0<span style=3D"color:rgb(36,41=
,46);white-space:pre-wrap">for instrumenting</span>=C2=A0</font><span style=
=3D"color:rgb(36,41,46);white-space:pre-wrap"><font face=3D"arial, helvetic=
a, sans-serif">some calls to libc for </font></span><font face=3D"arial, he=
lvetica, sans-serif">som<span style=3D"font-size:12.8px">e applica</span></=
font><span style=3D"font-size:12.8px">tions like Firefox and Chrome, but I =
receive &quot;Segmentation fault (core dumped)&quot;. I compile lttng-ust-p=
thread.c (gcc -fPIC -shared=C2=A0 -o test.so lttng-ust-pthread.c -ldl) and =
then I use &quot;LD_PRELOAD=3Dtest.so firefox&quot; but I receive segmentat=
ion fault (I have exported LD_LIBRARY_PATH to the absolute path of test.so =
file). I found out that when I replace tracepoints with printf in lttng_ust=
_pthread.c, I receive no error. It seems that hooking tracepoints in this w=
rapper makes some problems. Do you have any idea in this regard?</span><br>=
<div><div style=3D"font-size:12.8px"><br></div><div style=3D"font-size:12.8=
px"><span style=3D"font-size:12.8px"><font color=3D"#000000">Thanks<br><br>=
</font></span></div></div><div style=3D"font-size:12.8px"><span style=3D"fo=
nt-size:12.8px"><font color=3D"#000000">Majid</font></span></div></div>

--089e08210ae0dce7d005624f9bfc--

--===============5761794222637885432==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5761794222637885432==--
