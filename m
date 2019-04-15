From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Problems setting up lttng on PREEMPT_RT Raspberry Pi
Date: Mon, 15 Apr 2019 10:11:44 -0400 (EDT)
Message-ID: <725895933.460.1555337504175.JavaMail.zimbra__25929.1254494869$1555337531$gmane$org@efficios.com>
References: <CAKUXLvdNYPitwKb8D5VDC7nXA4-z3OiApGX=qbVxV5LWFkDyJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0615773132001657866=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44jVmm1vG7z1Jtc
 for <lttng-dev@lists.lttng.org>; Mon, 15 Apr 2019 10:11:52 -0400 (EDT)
In-Reply-To: <CAKUXLvdNYPitwKb8D5VDC7nXA4-z3OiApGX=qbVxV5LWFkDyJw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Nicholas Sadjoli <nick.sadjoli@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Tom Zanussi <tom.zanussi@linux.intel.com>, linux-rt-users <linux-rt-users@vger.kernel.org>, rostedt <rostedt@goodmis.org>, dev-raspberry-pi@lists.mozilla.org
List-Id: lttng-dev@lists.lttng.org

--===============0615773132001657866==
Content-Type: multipart/alternative;
	boundary="=_b837e101-6bbc-424c-b7b2-efb71475e083"

--=_b837e101-6bbc-424c-b7b2-efb71475e083
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Apr 15, 2019, at 7:07 AM, Nicholas Sadjoli <nick.sadjoli@gmail.com> wrote: 

> Dear Lttng dev Team,
> I am currently interested in using lttng to measure the interrupt or hardware
> real-time latencies experienced within my user-space applications.
> Unfortunately I have been having issues installing lttng on my Raspberry Pi
> that is using the PREEMPT_RT patched kernel, version 4.14.91-rt49-v7+. The
> problems so far can be seen documented in the RPi Linux github forum page here:
> [ https://github.com/raspberrypi/linux/issues/2930 |
> https://github.com/raspberrypi/linux/issues/2930 ]

> Initially I was about to just install the Debian package of the lttng onto the
> RPi, and just proceeded with the commands ' sudo apt-get install
> lttng-modules-dkms liblttng-ust-dev lttng-tools' However, I was unable to use
> lttng package at all and found out that for the RPi, a build from source is
> necessary for lttng, as described here: [
> https://stackoverflow.com/questions/52386448/linux-trace-tool-lttng-on-raspbian-kernel-tracer-not-available
> |
> https://stackoverflow.com/questions/52386448/linux-trace-tool-lttng-on-raspbian-kernel-tracer-not-available
> ]

> Following their suggestion, I then tried to build the lttng packages from
> source, and even re-building the RPi kernel locally to ensure the kernel
> headers are in the RPi and linked up properly to the source packages.

> Unfortunately when I tried to do this for the lttng-modules package, it instead
> gave me the following warning in my latest attempt:

> I n file included from
> /home/pi/BangEco_rvmscan/stagelight_project/lttng/lttng-modules/probes/lttng-kprobes.c:31:0:
> /home/pi/BangEco_rvmscan/stagelight_project/lttng/lttng-modules/probes/../blacklist/kprobes.h:19:4:
> error: #error "Your kernel is known to have buggy optimized kprobes
> implementation. Fixed by commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c \"ARM:
> 8834/1: Fix: kprobes: optimized kprobes illegal instruction\" in Linux. Disable
> CONFIG_OPTPROBES or upgrade your kernel."
> # error "Your kernel is known to have buggy optimized kprobes implementation.
> Fixed by commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c \"ARM: 8834/1: Fix:
> kprobes: optimized kprobes illegal instruction\" in Linux. Disable
> CONFIG_OPTPROBES or upgrade your kernel."

> I then tried to turn off the CONFIG_OPTPROBES kernel config, but it seemed to be
> automatically overwritten during kernel building and is considered an important
> part of the real-time RPi kernels. Has such problems been reported with this
> version of the PREEMPT_RT kernel in the past (again, the current kernel version
> that I am using is 4.14.91-rt49-v7+)? If there are I would like to know how
> this issue was resolved so that I can properly build and use the lttng package
> for my project.

Hi Nicholas, 

It looks like our lttng-modules kernel version blacklist is acting exactly as it should. Looking at this 
git tree: 

git clone https://github.com/raspberrypi/linux.git -b rpi-4.14.y-rt 
I notice that in the git log, we find this bogus commit: 

commit f9e0bc710347fadad55910846ee36f0681d0dca8 
Author: Kees Cook <keescook@chromium.org> 
Date: Tue Oct 30 22:12:56 2018 +0100 

ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE 

commit e46daee53bb50bde38805f1823a182979724c229 upstream. 

But not the fix for it (upstream): 

commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c 
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> 
Date: Tue Feb 5 16:37:40 2019 +0100 

ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction 

So lttng-modules refuses to build against your kernel configuration with CONFIG_OPTPROBES=y 
to save you the trouble of having kprobes trigger illegal instruction OOPS at runtime. 

I'm unusure who maintains that raspberrypi rt kernel tree. However, the upstream rt tree 
for 4.14-rt maintained by Tom Zanussi seems to contain the fix: 

[ https://kernel.googlesource.com/pub/scm/linux/kernel/git/rt/linux-stable-rt/+/refs/heads/v4.14-rt | https://kernel.googlesource.com/pub/scm/linux/kernel/git/rt/linux-stable-rt/+/refs/heads/v4.14-rt ] 

(currently at 4.14.109-rt57). 

So you should contact your raspberrypi linux rt tree clone maintainer and ask him 
to upgrade, or, as stated in the #error generated by lttng-modules, simply ensure 
CONFIG_OPTPROBES is unset when you build your kernel. You should ask the 
raspberrypi community advice on how to ensure this configuration option is not 
overridden by the raspberrypi build system. 

Thanks, 

Mathieu 

> Thank you so much for your attention and looking forward to your reply soon.

> Best Regards,

> Nicholas Sadjoli

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_b837e101-6bbc-424c-b7b2-efb71475e083
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Apr 15, 2019, at 7:07 AM, Nicholas Sadjoli &lt;nick.sadjoli@gm=
ail.com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><bl=
ockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-lef=
t:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;=
font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><d=
iv dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Dear Lttng dev Team,<br><d=
iv>I am currently interested in using lttng to measure the interrupt or har=
dware real-time latencies experienced within my user-space applications. Un=
fortunately I have been having issues installing lttng on my Raspberry Pi t=
hat is using the PREEMPT_RT patched kernel, version&nbsp;<span style=3D"col=
or:rgb(36,41,46);font-family:-apple-system,BlinkMacSystemFont,&quot;Segoe U=
I&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Sego=
e UI Emoji&quot;,&quot;Segoe UI Symbol&quot;;font-size:14px">4.14.91-rt49-v=
7+. The problems so far can be seen documented in the RPi Linux github foru=
m page here:&nbsp;</span><font face=3D"-apple-system, BlinkMacSystemFont, S=
egoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, S=
egoe UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px"><a href=3D=
"https://github.com/raspberrypi/linux/issues/2930" target=3D"_blank">https:=
//github.com/raspberrypi/linux/issues/2930</a></span></font><br data-mce-bo=
gus=3D"1"></div><div><span style=3D"color:rgb(36,41,46);font-family:-apple-=
system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&=
quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symb=
ol&quot;;font-size:14px"><br></span></div><div><span style=3D"color:rgb(36,=
41,46);font-family:-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,He=
lvetica,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji=
&quot;,&quot;Segoe UI Symbol&quot;;font-size:14px">Initially I was about to=
 just install the Debian package of the lttng onto the RPi, and just procee=
ded with the commands '</span><font face=3D"Andale Mono WT, Andale Mono, Bi=
tstream Vera Sans Mono, Liberation Mono, Nimbus Mono L, Ubuntu Mono, Monaco=
, Consolas, Lucida Console, Lucida Sans Typewriter, Courier New, Courier, m=
onospace" color=3D"rgba(0, 0, 0, 0.749019607843137)">sudo apt-get install l=
ttng-modules-dkms liblttng-ust-dev lttng-tools' </font>However, I was unabl=
e to use lttng package at all and found out that for the RPi, a build from =
source is necessary for lttng, as described here:&nbsp;<span style=3D"backg=
round-color:transparent"><font face=3D"-apple-system, BlinkMacSystemFont, S=
egoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, S=
egoe UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px"><a href=3D=
"https://stackoverflow.com/questions/52386448/linux-trace-tool-lttng-on-ras=
pbian-kernel-tracer-not-available" target=3D"_blank">https://stackoverflow.=
com/questions/52386448/linux-trace-tool-lttng-on-raspbian-kernel-tracer-not=
-available</a></span></font></span><br data-mce-bogus=3D"1"></div><div><spa=
n style=3D"background-color:transparent"><font face=3D"-apple-system, Blink=
MacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, S=
egoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=3D"font-size:=
14px"><br></span></font></span></div><div><span style=3D"background-color:t=
ransparent"><font face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helv=
etica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbo=
l" color=3D"#24292e"><span style=3D"font-size:14px">Following their suggest=
ion, I then tried to build the lttng packages from source, and even re-buil=
ding the RPi kernel locally to ensure the kernel headers are in the RPi and=
 linked up properly to the source packages.&nbsp;</span></font></span></div=
><div><span style=3D"background-color:transparent"><font face=3D"-apple-sys=
tem, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Colo=
r Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=3D"=
font-size:14px"><br></span></font></span></div><div><span style=3D"backgrou=
nd-color:transparent"><font face=3D"-apple-system, BlinkMacSystemFont, Sego=
e UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Sego=
e UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px">Unfortunately=
 when I tried to do this for the lttng-modules package, it instead gave me =
the following warning in my latest attempt:&nbsp;</span></font></span></div=
><div><font face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica,=
 Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" col=
or=3D"#24292e"><span style=3D"font-size:14px"><br></span></font></div><div>=
<font face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial=
, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"=
#24292e"><span style=3D"font-size:14px">I</span></font><span style=3D"font-=
size:14px;color:rgb(36,41,46);font-family:-apple-system,BlinkMacSystemFont,=
&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color Emoji&quo=
t;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;">n file included =
from /home/pi/BangEco_rvmscan/stagelight_project/lttng/lttng-modules/probes=
/lttng-kprobes.c:31:0:</span></div><div><font face=3D"-apple-system, BlinkM=
acSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Se=
goe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=3D"font-size:1=
4px">/home/pi/BangEco_rvmscan/stagelight_project/lttng/lttng-modules/probes=
/../blacklist/kprobes.h:19:4: error: #error "Your kernel is known to have b=
uggy optimized kprobes implementation. Fixed by commit 0ac569bf6a7983c0c574=
7d6df8db9dc05bc92b6c \"ARM: 8834/1: Fix: kprobes: optimized kprobes illegal=
 instruction\" in Linux. Disable CONFIG_OPTPROBES or upgrade your kernel."<=
/span></font></div><div><font face=3D"-apple-system, BlinkMacSystemFont, Se=
goe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Se=
goe UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px">&nbsp;#&nbs=
p; error "Your kernel is known to have buggy optimized kprobes implementati=
on. Fixed by commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c \"ARM: 8834/1:=
 Fix: kprobes: optimized kprobes illegal instruction\" in Linux. Disable CO=
NFIG_OPTPROBES or upgrade your kernel."</span></font></div><div><font face=
=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-ser=
if, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><=
span style=3D"font-size:14px"><br></span></font></div><div><font face=3D"-a=
pple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Ap=
ple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span s=
tyle=3D"font-size:14px">I then tried to turn off the CONFIG_OPTPROBES kerne=
l config, but it seemed to be automatically overwritten during kernel build=
ing and is considered an important part of the real-time RPi kernels. Has s=
uch problems been reported with this version of the PREEMPT_RT kernel in th=
e past (again, the current kernel version that I am using is&nbsp;</span></=
font><span style=3D"color:rgb(36,41,46);font-family:-apple-system,BlinkMacS=
ystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color=
 Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;;font-si=
ze:14px">4.14.91-rt49-v7+)? If there are I would like to know how this issu=
e was resolved so that I can properly build and use the lttng package for m=
y project.</span></div></div></div></div></div></blockquote><div>Hi Nichola=
s,<br></div><div><br data-mce-bogus=3D"1"></div><div>It looks like our lttn=
g-modules kernel version blacklist is acting exactly as it should. Looking =
at this<br data-mce-bogus=3D"1"></div><div>git tree:<br data-mce-bogus=3D"1=
"></div><div><br data-mce-bogus=3D"1"></div><div>git clone https://github.c=
om/raspberrypi/linux.git -b rpi-4.14.y-rt<br data-mce-bogus=3D"1"></div><di=
v><pre><code class=3D"language-sh hljs bash"></code></pre></div><div>I noti=
ce that in the git log, we find this bogus commit:<br data-mce-bogus=3D"1">=
</div><div><br data-mce-bogus=3D"1"></div><div>commit f9e0bc710347fadad5591=
0846ee36f0681d0dca8<br>Author: Kees Cook &lt;keescook@chromium.org&gt;<br>D=
ate:&nbsp;&nbsp; Tue Oct 30 22:12:56 2018 +0100<br><br>&nbsp;&nbsp;&nbsp; A=
RM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE<br>&nbsp;&nbsp;=
&nbsp; <br>&nbsp;&nbsp;&nbsp; commit e46daee53bb50bde38805f1823a182979724c2=
29 upstream.<br><br data-mce-bogus=3D"1"></div><div>But not the fix for it =
(upstream):<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></d=
iv><div>commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c<br>Author: Mathieu =
Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;<br>Date:&nbsp;&nbsp; Tue F=
eb 5 16:37:40 2019 +0100<br><br>&nbsp;&nbsp;&nbsp; ARM: 8834/1: Fix: kprobe=
s: optimized kprobes illegal instruction<br><br data-mce-bogus=3D"1"></div>=
<div>So lttng-modules refuses to build against your kernel configuration wi=
th CONFIG_OPTPROBES=3Dy</div><div>to save you the trouble of having kprobes=
 trigger illegal instruction OOPS at runtime.<br data-mce-bogus=3D"1"></div=
><div><br data-mce-bogus=3D"1"></div><div>I'm unusure who maintains that ra=
spberrypi rt kernel tree. However, the upstream rt tree<br data-mce-bogus=
=3D"1"></div><div>for 4.14-rt maintained by Tom Zanussi seems to contain th=
e fix:<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><d=
iv><a href=3D"https://kernel.googlesource.com/pub/scm/linux/kernel/git/rt/l=
inux-stable-rt/+/refs/heads/v4.14-rt">https://kernel.googlesource.com/pub/s=
cm/linux/kernel/git/rt/linux-stable-rt/+/refs/heads/v4.14-rt</a><br data-mc=
e-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>(currently at =
4.14.109-rt57).<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"=
></div><div>So you should contact your raspberrypi linux rt tree clone main=
tainer and ask him<br data-mce-bogus=3D"1"></div><div>to upgrade, or, as st=
ated in the #error generated by lttng-modules, simply ensure<br data-mce-bo=
gus=3D"1"></div><div>CONFIG_OPTPROBES is unset when you build your kernel. =
You should ask the<br data-mce-bogus=3D"1"></div><div>raspberrypi community=
 advice on how to ensure this configuration option is not</div><div>overrid=
den by the raspberrypi build system.<br data-mce-bogus=3D"1"></div><div><br=
 data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div=
><br data-mce-bogus=3D"1"></div><div>Mathieu</div><div><br data-mce-bogus=
=3D"1"></div><blockquote style=3D"border-left:2px solid #1010FF;margin-left=
:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-=
decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><di=
v dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div><span=
 style=3D"color:rgb(36,41,46);font-family:-apple-system,BlinkMacSystemFont,=
&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color Emoji&quo=
t;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;;font-size:14px"><=
br></span></div><div><span style=3D"color:rgb(36,41,46);font-family:-apple-=
system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&=
quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symb=
ol&quot;;font-size:14px"><br></span></div><div><font face=3D"-apple-system,=
 BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Em=
oji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=3D"font=
-size:14px">Thank you so much for your attention and looking forward to you=
r reply soon.</span></font></div><div><font face=3D"-apple-system, BlinkMac=
SystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Sego=
e UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=3D"font-size:14p=
x"><br></span></font></div><div><font face=3D"-apple-system, BlinkMacSystem=
Font, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI E=
moji, Segoe UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px"><br=
></span></font></div><div><font face=3D"-apple-system, BlinkMacSystemFont, =
Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, =
Segoe UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px"><br></spa=
n></font></div><div><font face=3D"-apple-system, BlinkMacSystemFont, Segoe =
UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe =
UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px">Best Regards,</=
span></font></div><div><font face=3D"-apple-system, BlinkMacSystemFont, Seg=
oe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Seg=
oe UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px"><br></span><=
/font></div><div><font face=3D"-apple-system, BlinkMacSystemFont, Segoe UI,=
 Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI =
Symbol" color=3D"#24292e"><span style=3D"font-size:14px"><br></span></font>=
</div><div><font face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helve=
tica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol=
" color=3D"#24292e"><span style=3D"font-size:14px"><br></span></font></div>=
<div><font face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, =
Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" colo=
r=3D"#24292e"><span style=3D"font-size:14px">Nicholas Sadjoli</span></font>=
</div></div></div></div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_b837e101-6bbc-424c-b7b2-efb71475e083--

--===============0615773132001657866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0615773132001657866==--
