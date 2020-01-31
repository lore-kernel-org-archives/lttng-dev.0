From: "s.v.l.srinivasa raghavan" <svlsr2000@gmail.com>
Subject: logs from 32bit binary in live session
Date: Fri, 31 Jan 2020 10:23:08 +0530
Message-ID: <CAGjfqVnrvd1X-yqNawneidaRhGV8gAh8cd-nFkF2XWa_JF030Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0275783757553348343=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by lists.lttng.org (Postfix) with ESMTPS id 4884c10KZSz22xB
 for <lttng-dev@lists.lttng.org>; Thu, 30 Jan 2020 23:53:20 -0500 (EST)
Received: by mail-pl1-x631.google.com with SMTP id t6so2233524plj.5
 for <lttng-dev@lists.lttng.org>; Thu, 30 Jan 2020 20:53:20 -0800 (PST)
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

--===============0275783757553348343==
Content-Type: multipart/alternative; boundary="000000000000384c35059d685a31"

--000000000000384c35059d685a31
Content-Type: text/plain; charset="UTF-8"

Hello,

I am trying to setup a live debugging session in environment with both 32
bit and 64 bit binaries. I am currenlty using Debian buster. After setting
up, i am observing that i am not able to see 32 bit logs. I tried with the
examples given in document. Did few modifications to setup live session.
Initial compilation and installation is done as per


https://lttng.org/docs/v2.11/#doc-instrumenting-32-bit-app-on-64-bit-system

After this i am starting sessiond using

lttng-sessiond
--consumerd32-path=/usr/local/lib32/lttng/libexec/lttng-consumerd
--consumerd64-path=/usr/local/lib/lttng/libexec/lttng-consumerd \
--ustconsumerd32-err-sock=/home/user/.lttng/ustconsumerd32/error \
--ustconsumerd64-err-sock=/home/user/.lttng/ustconsumerd64/error \
--ustconsumerd32-cmd-sock=/home/user/.lttng/ustconsumerd32/command \
--ustconsumerd64-cmd-sock=/home/user/.lttng/ustconsumerd64/command \
--daemonize

Starting relayd using

lttng-relayd -o /tmp/lttng


Starting live session (In the same machine) using

  lttng create my-session3 --live
  lttng enable-event -u hello:*
  lttng start
  babeltrace --input-format=lttng-live
net://localhost/host/debianServer/my-session3



Now executing 64 bit binary is producing logs in live session where as
executing 32 bit version is not producing any log. I am also observing that
both the logs (ie logs from 32bit and 64 bit binaries) are getting captured
in non live sessions, ie when i write to file.


Do i need to pass some additional parameters to relayd / babeltrace to get
both the logs?
-- 
Cheers
Srinivas

--000000000000384c35059d685a31
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div>=C2=A0<br></div><div><div>I am trying to setup =
a live debugging session in environment=C2=A0with both 32 bit and 64 bit bi=
naries. I am currenlty using Debian buster. After setting up, i am observin=
g that i am not able to see 32 bit logs. I tried with the examples given in=
 document. Did few modifications to setup live session.=C2=A0</div><div>Ini=
tial=C2=A0compilation and installation is done as per</div><div><br></div><=
div></div><div><br></div><div><a href=3D"https://lttng.org/docs/v2.11/#doc-=
instrumenting-32-bit-app-on-64-bit-system">https://lttng.org/docs/v2.11/#do=
c-instrumenting-32-bit-app-on-64-bit-system</a>=C2=A0</div><div><br></div><=
div>After this i am starting sessiond using=C2=A0</div><blockquote style=3D=
"margin:0 0 0 40px;border:none;padding:0px">lttng-sessiond --consumerd32-pa=
th=3D/usr/local/lib32/lttng/libexec/lttng-consumerd --consumerd64-path=3D/u=
sr/local/lib/lttng/libexec/lttng-consumerd \<br>--ustconsumerd32-err-sock=
=3D/home/user/.lttng/ustconsumerd32/error \<br>--ustconsumerd64-err-sock=3D=
/home/user/.lttng/ustconsumerd64/error \<br> --ustconsumerd32-cmd-sock=3D/h=
ome/user/.lttng/ustconsumerd32/command \<br>--ustconsumerd64-cmd-sock=3D/ho=
me/user/.lttng/ustconsumerd64/command \<div>--daemonize=C2=A0</div></blockq=
uote><div><div>Starting relayd using</div><div><br></div></div></div><block=
quote style=3D"margin:0 0 0 40px;border:none;padding:0px"><div><div><div>lt=
tng-relayd -o /tmp/lttng</div></div></div></blockquote><div><div><br></div>=
<div>Starting live session (In the same machine) using=C2=A0</div></div><bl=
ockquote style=3D"margin:0 0 0 40px;border:none;padding:0px"><div><div>=C2=
=A0 lttng create my-session3 --live</div></div><div><div>=C2=A0 lttng enabl=
e-event -u hello:*</div></div><div><div>=C2=A0 lttng start</div></div><div>=
<div>=C2=A0 babeltrace --input-format=3Dlttng-live net://localhost/host/deb=
ianServer/my-session3</div></div></blockquote><div><br></div><div><br></div=
><div>Now executing 64 bit binary is producing logs in live session where a=
s executing 32 bit version is not producing any log. I am also observing th=
at both the logs (ie logs from 32bit and 64 bit binaries) are getting captu=
red in non live sessions, ie when i write to file.=C2=A0</div><div><br></di=
v><div><br></div><div>Do i need to pass some additional parameters to relay=
d / babeltrace to get both the logs?=C2=A0</div><div>-- <br><div dir=3D"ltr=
" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"=
ltr">Cheers <br>Srinivas</div></div></div></div>

--000000000000384c35059d685a31--

--===============0275783757553348343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0275783757553348343==--
