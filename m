From: Nicholas Sadjoli <nick.sadjoli@gmail.com>
Subject: Problems setting up lttng on PREEMPT_RT Raspberry Pi
Date: Mon, 15 Apr 2019 19:07:43 +0800
Message-ID: <CAKUXLvdNYPitwKb8D5VDC7nXA4-z3OiApGX=qbVxV5LWFkDyJw__21110.3091061645$1555326491$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5586000169427430650=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it1-x135.google.com (mail-it1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 by lists.lttng.org (Postfix) with ESMTPS id 44jQhW6jTkz1Jp2
 for <lttng-dev@lists.lttng.org>; Mon, 15 Apr 2019 07:07:55 -0400 (EDT)
Received: by mail-it1-x135.google.com with SMTP id w15so25934574itc.0
 for <lttng-dev@lists.lttng.org>; Mon, 15 Apr 2019 04:07:55 -0700 (PDT)
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

--===============5586000169427430650==
Content-Type: multipart/alternative; boundary="00000000000005de8705868faafa"

--00000000000005de8705868faafa
Content-Type: text/plain; charset="UTF-8"

Dear Lttng dev Team,

I am currently interested in using lttng to measure the interrupt or
hardware real-time latencies experienced within my user-space applications.
Unfortunately I have been having issues installing lttng on my Raspberry Pi
that is using the PREEMPT_RT patched kernel, version 4.14.91-rt49-v7+. The
problems so far can be seen documented in the RPi Linux github forum page
here: https://github.com/raspberrypi/linux/issues/2930

Initially I was about to just install the Debian package of the lttng onto
the RPi, and just proceeded with the commands 'sudo apt-get install
lttng-modules-dkms liblttng-ust-dev lttng-tools' However, I was unable to
use lttng package at all and found out that for the RPi, a build from
source is necessary for lttng, as described here:
https://stackoverflow.com/questions/52386448/linux-trace-tool-lttng-on-raspbian-kernel-tracer-not-available


Following their suggestion, I then tried to build the lttng packages from
source, and even re-building the RPi kernel locally to ensure the kernel
headers are in the RPi and linked up properly to the source packages.

Unfortunately when I tried to do this for the lttng-modules package, it
instead gave me the following warning in my latest attempt:

In file included from
/home/pi/BangEco_rvmscan/stagelight_project/lttng/lttng-modules/probes/lttng-kprobes.c:31:0:
/home/pi/BangEco_rvmscan/stagelight_project/lttng/lttng-modules/probes/../blacklist/kprobes.h:19:4:
error: #error "Your kernel is known to have buggy optimized kprobes
implementation. Fixed by commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c
\"ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction\" in
Linux. Disable CONFIG_OPTPROBES or upgrade your kernel."
 #  error "Your kernel is known to have buggy optimized kprobes
implementation. Fixed by commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c
\"ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction\" in
Linux. Disable CONFIG_OPTPROBES or upgrade your kernel."

I then tried to turn off the CONFIG_OPTPROBES kernel config, but it seemed
to be automatically overwritten during kernel building and is considered an
important part of the real-time RPi kernels. Has such problems been
reported with this version of the PREEMPT_RT kernel in the past (again, the
current kernel version that I am using is 4.14.91-rt49-v7+)? If there are I
would like to know how this issue was resolved so that I can properly build
and use the lttng package for my project.


Thank you so much for your attention and looking forward to your reply soon.



Best Regards,



Nicholas Sadjoli

--00000000000005de8705868faafa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Dear Lt=
tng dev Team,<div><br></div><div>I am currently interested in using lttng t=
o measure the interrupt or hardware real-time latencies experienced within =
my user-space applications. Unfortunately I have been having issues install=
ing lttng on my Raspberry Pi that is using the PREEMPT_RT patched kernel, v=
ersion=C2=A0<span style=3D"color:rgb(36,41,46);font-family:-apple-system,Bl=
inkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&quot;Appl=
e Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;;=
font-size:14px">4.14.91-rt49-v7+. The problems so far can be seen documente=
d in the RPi Linux github forum page here:=C2=A0</span><font color=3D"#2429=
2e" face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, =
sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol"><span style=
=3D"font-size:14px"><a href=3D"https://github.com/raspberrypi/linux/issues/=
2930">https://github.com/raspberrypi/linux/issues/2930</a></span></font></d=
iv><div><span style=3D"color:rgb(36,41,46);font-family:-apple-system,BlinkM=
acSystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Co=
lor Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;;font=
-size:14px"><br></span></div><div><span style=3D"color:rgb(36,41,46);font-f=
amily:-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,Arial=
,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;=
Segoe UI Symbol&quot;;font-size:14px">Initially I was about to just install=
 the Debian package of the lttng onto the RPi, and just proceeded with the =
commands &#39;</span><font color=3D"rgba(0, 0, 0, 0.749019607843137)" face=
=3D"Andale Mono WT, Andale Mono, Bitstream Vera Sans Mono, Liberation Mono,=
 Nimbus Mono L, Ubuntu Mono, Monaco, Consolas, Lucida Console, Lucida Sans =
Typewriter, Courier New, Courier, monospace">sudo apt-get install lttng-mod=
ules-dkms liblttng-ust-dev lttng-tools&#39; </font>However, I was unable to=
 use lttng package at all and found out that for the RPi, a build from sour=
ce is necessary for lttng, as described here:=C2=A0<span style=3D"backgroun=
d-color:transparent"><font color=3D"#24292e" face=3D"-apple-system, BlinkMa=
cSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Seg=
oe UI Emoji, Segoe UI Symbol"><span style=3D"font-size:14px"><a href=3D"htt=
ps://stackoverflow.com/questions/52386448/linux-trace-tool-lttng-on-raspbia=
n-kernel-tracer-not-available">https://stackoverflow.com/questions/52386448=
/linux-trace-tool-lttng-on-raspbian-kernel-tracer-not-available</a>=C2=A0</=
span></font></span></div><div><span style=3D"background-color:transparent">=
<font color=3D"#24292e" face=3D"-apple-system, BlinkMacSystemFont, Segoe UI=
, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI=
 Symbol"><span style=3D"font-size:14px"><br></span></font></span></div><div=
><span style=3D"background-color:transparent"><font color=3D"#24292e" face=
=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-ser=
if, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol"><span style=3D"font=
-size:14px">Following their suggestion, I then tried to build the lttng pac=
kages from source, and even re-building the RPi kernel locally to ensure th=
e kernel headers are in the RPi and linked up properly to the source packag=
es.=C2=A0</span></font></span></div><div><span style=3D"background-color:tr=
ansparent"><font color=3D"#24292e" face=3D"-apple-system, BlinkMacSystemFon=
t, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoj=
i, Segoe UI Symbol"><span style=3D"font-size:14px"><br></span></font></span=
></div><div><span style=3D"background-color:transparent"><font color=3D"#24=
292e" face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial=
, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol"><span sty=
le=3D"font-size:14px">Unfortunately when I tried to do this for the lttng-m=
odules package, it instead gave me the following warning in my latest attem=
pt:=C2=A0</span></font></span></div><div><font color=3D"#24292e" face=3D"-a=
pple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Ap=
ple Color Emoji, Segoe UI Emoji, Segoe UI Symbol"><span style=3D"font-size:=
14px"><br></span></font></div><div><font color=3D"#24292e" face=3D"-apple-s=
ystem, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Co=
lor Emoji, Segoe UI Emoji, Segoe UI Symbol"><span style=3D"font-size:14px">=
I</span></font><span style=3D"font-size:14px;color:rgb(36,41,46);font-famil=
y:-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,san=
s-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Sego=
e UI Symbol&quot;">n file included from /home/pi/BangEco_rvmscan/stagelight=
_project/lttng/lttng-modules/probes/lttng-kprobes.c:31:0:</span></div><div>=
<font color=3D"#24292e" face=3D"-apple-system, BlinkMacSystemFont, Segoe UI=
, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI=
 Symbol"><span style=3D"font-size:14px">/home/pi/BangEco_rvmscan/stagelight=
_project/lttng/lttng-modules/probes/../blacklist/kprobes.h:19:4: error: #er=
ror &quot;Your kernel is known to have buggy optimized kprobes implementati=
on. Fixed by commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c \&quot;ARM: 88=
34/1: Fix: kprobes: optimized kprobes illegal instruction\&quot; in Linux. =
Disable CONFIG_OPTPROBES or upgrade your kernel.&quot;</span></font></div><=
div><font color=3D"#24292e" face=3D"-apple-system, BlinkMacSystemFont, Sego=
e UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Sego=
e UI Symbol"><span style=3D"font-size:14px">=C2=A0#=C2=A0 error &quot;Your =
kernel is known to have buggy optimized kprobes implementation. Fixed by co=
mmit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c \&quot;ARM: 8834/1: Fix: kpro=
bes: optimized kprobes illegal instruction\&quot; in Linux. Disable CONFIG_=
OPTPROBES or upgrade your kernel.&quot;</span></font></div><div><font color=
=3D"#24292e" face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica=
, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol"><s=
pan style=3D"font-size:14px"><br></span></font></div><div><font color=3D"#2=
4292e" face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Aria=
l, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol"><span st=
yle=3D"font-size:14px">I then tried to turn off the CONFIG_OPTPROBES kernel=
 config, but it seemed to be automatically overwritten during kernel buildi=
ng and is considered an important part of the real-time RPi kernels. Has su=
ch problems been reported with this version of the PREEMPT_RT kernel in the=
 past (again, the current kernel version that I am using is=C2=A0</span></f=
ont><span style=3D"color:rgb(36,41,46);font-family:-apple-system,BlinkMacSy=
stemFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color =
Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;;font-siz=
e:14px">4.14.91-rt49-v7+)? If there are I would like to know how this issue=
 was resolved so that I can properly build and use the lttng package for my=
 project.</span></div><div><span style=3D"color:rgb(36,41,46);font-family:-=
apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans-s=
erif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe U=
I Symbol&quot;;font-size:14px"><br></span></div><div><span style=3D"color:r=
gb(36,41,46);font-family:-apple-system,BlinkMacSystemFont,&quot;Segoe UI&qu=
ot;,Helvetica,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI=
 Emoji&quot;,&quot;Segoe UI Symbol&quot;;font-size:14px"><br></span></div><=
div><font color=3D"#24292e" face=3D"-apple-system, BlinkMacSystemFont, Sego=
e UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Sego=
e UI Symbol"><span style=3D"font-size:14px">Thank you so much for your atte=
ntion and looking forward to your reply soon.</span></font></div><div><font=
 color=3D"#24292e" face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Hel=
vetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symb=
ol"><span style=3D"font-size:14px"><br></span></font></div><div><font color=
=3D"#24292e" face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica=
, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol"><s=
pan style=3D"font-size:14px"><br></span></font></div><div><font color=3D"#2=
4292e" face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Aria=
l, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol"><span st=
yle=3D"font-size:14px"><br></span></font></div><div><font color=3D"#24292e"=
 face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, san=
s-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol"><span style=3D=
"font-size:14px">Best Regards,</span></font></div><div><font color=3D"#2429=
2e" face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, =
sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol"><span style=
=3D"font-size:14px"><br></span></font></div><div><font color=3D"#24292e" fa=
ce=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-s=
erif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol"><span style=3D"fo=
nt-size:14px"><br></span></font></div><div><font color=3D"#24292e" face=3D"=
-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, =
Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol"><span style=3D"font-siz=
e:14px"><br></span></font></div><div><font color=3D"#24292e" face=3D"-apple=
-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple =
Color Emoji, Segoe UI Emoji, Segoe UI Symbol"><span style=3D"font-size:14px=
">Nicholas Sadjoli</span></font></div></div></div></div></div>

--00000000000005de8705868faafa--

--===============5586000169427430650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5586000169427430650==--
