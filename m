From: Adel Belkhiri <adel.belkhiri@ensi-uma.tn>
Subject: Tracing network events in the kernel using lttng
Date: Thu, 11 Aug 2016 23:50:10 -0500
Message-ID: <CAFMzwX6csrXt6aQwy0b7oW7CzfEKRr28uXYZcE4NhPrOWyCr4g__37424.9981985942$1470977424$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3857394231990764507=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ua0-f194.google.com (mail-ua0-f194.google.com
 [209.85.217.194])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 42D1BA3A05
 for <lttng-dev@lists.lttng.org>; Fri, 12 Aug 2016 04:50:12 +0000 (UTC)
Received: by mail-ua0-f194.google.com with SMTP id 74so1240098uau.3
 for <lttng-dev@lists.lttng.org>; Thu, 11 Aug 2016 21:50:12 -0700 (PDT)
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

--===============3857394231990764507==
Content-Type: multipart/alternative; boundary=001a113bd2041351ff0539d89eec

--001a113bd2041351ff0539d89eec
Content-Type: text/plain; charset=UTF-8

Hello,


I'm, from some time, working on tracing linux kernel using lttng to get
some information about the system' network activities. Tracing bare system
calls (--syscall) didn't give me much information so I realized that i
should first place some static probes in the kernel source files to be able
to trace (mainly) *TCP socket operations* (bind, accept, create, ...).
Running out of time in my project, I wonder if there are *any patch for the
kernel* that place those probes in the right source files.

My linux Kernel version is 3.2.0-4-486 and I'm using Lttng 2.7.


Thank very much you for your help.



Adel Belkhiri

--001a113bd2041351ff0539d89eec
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><font face=3D"arial, helvetica, sans-serif">Hello,</font><=
div><font face=3D"arial, helvetica, sans-serif"><br></font></div><div><font=
 face=3D"arial, helvetica, sans-serif"><br></font></div><div><font face=3D"=
arial, helvetica, sans-serif">I&#39;m, from some time, working on tracing l=
inux kernel using lttng to get some information about the system&#39; netwo=
rk activities.=C2=A0Tracing bare system calls (--syscall) didn&#39;t give m=
e much information so I realized that i should first place some static prob=
es in the kernel source files to be able to trace (mainly) <b>TCP socket op=
erations</b> (bind, accept, create, ...). Running out of time in my project=
, I wonder if there are <b>any patch for the kernel</b> that place those pr=
obes in the right source files.=C2=A0</font></div><div><font face=3D"arial,=
 helvetica, sans-serif"><br></font></div><div><font face=3D"arial, helvetic=
a, sans-serif">My linux Kernel version is=C2=A03.2.0-4-486 and I&#39;m usin=
g Lttng 2.7.</font></div><div><font face=3D"arial, helvetica, sans-serif"><=
br></font></div><div><font face=3D"arial, helvetica, sans-serif"><br></font=
></div><div><font face=3D"arial, helvetica, sans-serif">Thank very much you=
 for your help.</font></div><div><br></div><div><br></div><div><br></div><d=
iv>Adel Belkhiri</div></div>

--001a113bd2041351ff0539d89eec--

--===============3857394231990764507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3857394231990764507==--
