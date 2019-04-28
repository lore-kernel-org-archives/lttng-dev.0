From: Nicholas Sadjoli <nick.sadjoli@gmail.com>
Subject: Re: Problems setting up lttng on PREEMPT_RT Raspberry Pi
Date: Sun, 28 Apr 2019 18:11:26 +0800
Message-ID: <CAKUXLvdQ0ELiGLDg-gQGh4Ja1+q3_Jpc8GcB6Pnvh522=FE_fw__16783.2691733324$1556446466$gmane$org@mail.gmail.com>
References: <CAKUXLvdNYPitwKb8D5VDC7nXA4-z3OiApGX=qbVxV5LWFkDyJw@mail.gmail.com>
 <725895933.460.1555337504175.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6164888423423465612=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it1-x144.google.com (mail-it1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 by lists.lttng.org (Postfix) with ESMTPS id 44sNqd1NLXz1JyP
 for <lttng-dev@lists.lttng.org>; Sun, 28 Apr 2019 06:11:40 -0400 (EDT)
Received: by mail-it1-x144.google.com with SMTP id r85so3416560itc.2
 for <lttng-dev@lists.lttng.org>; Sun, 28 Apr 2019 03:11:40 -0700 (PDT)
In-Reply-To: <725895933.460.1555337504175.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Tom Zanussi <tom.zanussi@linux.intel.com>, linux-rt-users <linux-rt-users@vger.kernel.org>, rostedt <rostedt@goodmis.org>, dev-raspberry-pi@lists.mozilla.org
List-Id: lttng-dev@lists.lttng.org

--===============6164888423423465612==
Content-Type: multipart/alternative; boundary="000000000000d114d90587946491"

--000000000000d114d90587946491
Content-Type: text/plain; charset="UTF-8"

Hello again Mathieu,

I apologize that this is a rather late re-opening of the topic again.
However, after consulting with the RPi kernel side, it seems that even
after trying to fix for the mentioned issue (i.e. by upgrading to the
listed 'fixed' commit), I am still having issues installing the
lttng-modules. The following link is the thread that I am having with the
RPi kernel github: https://github.com/raspberrypi/linux/issues/2930

Even though it is listed that version 2.9 seems to be okay, recently I
tried to re-install the lttng-modules onto another RPi, but this time even
with the 'fixed' commit as suggested in the thread, lttng-modules still
give the same 'buggy kernel implementation' error. Please do note that it
seems CONFIG_OPTPROBES cannot be turned off at all during the kernel build,
as it will be overriden by default and seems to be integral to the build of
the RPi's RT kernel as well, hence this is not really an option either.

Is there a specific way on how to upgrade to the mentioned 'fixed' commit
without requiring a complete kernel overhaul? I am getting rather desparate
as I need this to work for an upcoming assignment deadline this week. So
I'm hoping that there is still potential solution to this.


Best Regards,



Nicholas Sadjoli

On Mon, Apr 15, 2019 at 10:11 PM Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> ----- On Apr 15, 2019, at 7:07 AM, Nicholas Sadjoli <
> nick.sadjoli@gmail.com> wrote:
>
> Dear Lttng dev Team,
> I am currently interested in using lttng to measure the interrupt or
> hardware real-time latencies experienced within my user-space applications.
> Unfortunately I have been having issues installing lttng on my Raspberry Pi
> that is using the PREEMPT_RT patched kernel, version 4.14.91-rt49-v7+.
> The problems so far can be seen documented in the RPi Linux github forum
> page here: https://github.com/raspberrypi/linux/issues/2930
>
> Initially I was about to just install the Debian package of the lttng onto
> the RPi, and just proceeded with the commands 'sudo apt-get install
> lttng-modules-dkms liblttng-ust-dev lttng-tools' However, I was unable to
> use lttng package at all and found out that for the RPi, a build from
> source is necessary for lttng, as described here:
> https://stackoverflow.com/questions/52386448/linux-trace-tool-lttng-on-raspbian-kernel-tracer-not-available
>
> Following their suggestion, I then tried to build the lttng packages from
> source, and even re-building the RPi kernel locally to ensure the kernel
> headers are in the RPi and linked up properly to the source packages.
>
> Unfortunately when I tried to do this for the lttng-modules package, it
> instead gave me the following warning in my latest attempt:
>
> In file included from
> /home/pi/BangEco_rvmscan/stagelight_project/lttng/lttng-modules/probes/lttng-kprobes.c:31:0:
> /home/pi/BangEco_rvmscan/stagelight_project/lttng/lttng-modules/probes/../blacklist/kprobes.h:19:4:
> error: #error "Your kernel is known to have buggy optimized kprobes
> implementation. Fixed by commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c
> \"ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction\" in
> Linux. Disable CONFIG_OPTPROBES or upgrade your kernel."
>  #  error "Your kernel is known to have buggy optimized kprobes
> implementation. Fixed by commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c
> \"ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction\" in
> Linux. Disable CONFIG_OPTPROBES or upgrade your kernel."
>
> I then tried to turn off the CONFIG_OPTPROBES kernel config, but it seemed
> to be automatically overwritten during kernel building and is considered an
> important part of the real-time RPi kernels. Has such problems been
> reported with this version of the PREEMPT_RT kernel in the past (again, the
> current kernel version that I am using is 4.14.91-rt49-v7+)? If there are
> I would like to know how this issue was resolved so that I can properly
> build and use the lttng package for my project.
>
> Hi Nicholas,
>
> It looks like our lttng-modules kernel version blacklist is acting exactly
> as it should. Looking at this
> git tree:
>
> git clone https://github.com/raspberrypi/linux.git -b rpi-4.14.y-rt
>
> I notice that in the git log, we find this bogus commit:
>
> commit f9e0bc710347fadad55910846ee36f0681d0dca8
> Author: Kees Cook <keescook@chromium.org>
> Date:   Tue Oct 30 22:12:56 2018 +0100
>
>     ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE
>
>     commit e46daee53bb50bde38805f1823a182979724c229 upstream.
>
> But not the fix for it (upstream):
>
> commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Tue Feb 5 16:37:40 2019 +0100
>
>     ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction
>
> So lttng-modules refuses to build against your kernel configuration with
> CONFIG_OPTPROBES=y
> to save you the trouble of having kprobes trigger illegal instruction OOPS
> at runtime.
>
> I'm unusure who maintains that raspberrypi rt kernel tree. However, the
> upstream rt tree
> for 4.14-rt maintained by Tom Zanussi seems to contain the fix:
>
>
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/rt/linux-stable-rt/+/refs/heads/v4.14-rt
>
> (currently at 4.14.109-rt57).
>
> So you should contact your raspberrypi linux rt tree clone maintainer and
> ask him
> to upgrade, or, as stated in the #error generated by lttng-modules, simply
> ensure
> CONFIG_OPTPROBES is unset when you build your kernel. You should ask the
> raspberrypi community advice on how to ensure this configuration option is
> not
> overridden by the raspberrypi build system.
>
> Thanks,
>
> Mathieu
>
>
>
> Thank you so much for your attention and looking forward to your reply
> soon.
>
>
>
> Best Regards,
>
>
>
> Nicholas Sadjoli
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--000000000000d114d90587946491
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello again Mathieu,<div><br></div><div>I apologize that t=
his is a rather late re-opening of the topic again. However, after consulti=
ng with the RPi kernel side, it seems that even after trying to fix for the=
 mentioned issue (i.e. by upgrading to the listed &#39;fixed&#39; commit), =
I am still having issues installing the lttng-modules. The following link i=
s the thread that I am having with the RPi kernel github:=C2=A0<a href=3D"h=
ttps://github.com/raspberrypi/linux/issues/2930">https://github.com/raspber=
rypi/linux/issues/2930</a></div><div><br></div><div>Even though it is liste=
d that version 2.9 seems to be okay, recently I tried to re-install the ltt=
ng-modules onto another RPi, but this time even with the &#39;fixed&#39; co=
mmit as suggested in the thread, lttng-modules still give the same &#39;bug=
gy kernel implementation&#39; error. Please do note that it seems CONFIG_OP=
TPROBES cannot be turned off at all during the kernel build, as it will be =
overriden by default and seems to be integral to the build of the RPi&#39;s=
 RT kernel as well, hence this is not really an option either.</div><div><b=
r></div><div>Is there a specific way on how to upgrade to the mentioned &#3=
9;fixed&#39; commit without requiring a complete kernel overhaul? I am gett=
ing rather desparate as I need this to work for an upcoming assignment dead=
line this week. So I&#39;m hoping that there is still potential solution to=
 this.</div><div><br></div><div><br></div><div>Best Regards,</div><div><br>=
</div><div><br></div><div><br></div><div>Nicholas Sadjoli</div></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr =
15, 2019 at 10:11 PM Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoy=
ers@efficios.com">mathieu.desnoyers@efficios.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><div><div style=3D"font-fam=
ily:arial,helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><div><span =
id=3D"gmail-m_9106008346192568069zwchr">----- On Apr 15, 2019, at 7:07 AM, =
Nicholas Sadjoli &lt;<a href=3D"mailto:nick.sadjoli@gmail.com" target=3D"_b=
lank">nick.sadjoli@gmail.com</a>&gt; wrote:<br></span></div><div><blockquot=
e style=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;padding-lef=
t:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration=
:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"lt=
r"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Dear Lttng dev Team,<=
br><div>I am currently interested in using lttng to measure the interrupt o=
r hardware real-time latencies experienced within my user-space application=
s. Unfortunately I have been having issues installing lttng on my Raspberry=
 Pi that is using the PREEMPT_RT patched kernel, version=C2=A0<span style=
=3D"color:rgb(36,41,46);font-family:-apple-system,BlinkMacSystemFont,&quot;=
Segoe UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&qu=
ot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;;font-size:14px">4.14.91=
-rt49-v7+. The problems so far can be seen documented in the RPi Linux gith=
ub forum page here:=C2=A0</span><font face=3D"-apple-system, BlinkMacSystem=
Font, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI E=
moji, Segoe UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px"><a =
href=3D"https://github.com/raspberrypi/linux/issues/2930" target=3D"_blank"=
>https://github.com/raspberrypi/linux/issues/2930</a></span></font><br></di=
v><div><span style=3D"color:rgb(36,41,46);font-family:-apple-system,BlinkMa=
cSystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Col=
or Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;;font-=
size:14px"><br></span></div><div><span style=3D"color:rgb(36,41,46);font-fa=
mily:-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,=
sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;S=
egoe UI Symbol&quot;;font-size:14px">Initially I was about to just install =
the Debian package of the lttng onto the RPi, and just proceeded with the c=
ommands &#39;</span><font face=3D"Andale Mono WT, Andale Mono, Bitstream Ve=
ra Sans Mono, Liberation Mono, Nimbus Mono L, Ubuntu Mono, Monaco, Consolas=
, Lucida Console, Lucida Sans Typewriter, Courier New, Courier, monospace" =
color=3D"rgba(0, 0, 0, 0.749019607843137)">sudo apt-get install lttng-modul=
es-dkms liblttng-ust-dev lttng-tools&#39; </font>However, I was unable to u=
se lttng package at all and found out that for the RPi, a build from source=
 is necessary for lttng, as described here:=C2=A0<span style=3D"background-=
color:transparent"><font face=3D"-apple-system, BlinkMacSystemFont, Segoe U=
I, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe U=
I Symbol" color=3D"#24292e"><span style=3D"font-size:14px"><a href=3D"https=
://stackoverflow.com/questions/52386448/linux-trace-tool-lttng-on-raspbian-=
kernel-tracer-not-available" target=3D"_blank">https://stackoverflow.com/qu=
estions/52386448/linux-trace-tool-lttng-on-raspbian-kernel-tracer-not-avail=
able</a></span></font></span><br></div><div><span style=3D"background-color=
:transparent"><font face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, He=
lvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Sym=
bol" color=3D"#24292e"><span style=3D"font-size:14px"><br></span></font></s=
pan></div><div><span style=3D"background-color:transparent"><font face=3D"-=
apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, A=
pple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span =
style=3D"font-size:14px">Following their suggestion, I then tried to build =
the lttng packages from source, and even re-building the RPi kernel locally=
 to ensure the kernel headers are in the RPi and linked up properly to the =
source packages.=C2=A0</span></font></span></div><div><span style=3D"backgr=
ound-color:transparent"><font face=3D"-apple-system, BlinkMacSystemFont, Se=
goe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Se=
goe UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px"><br></span>=
</font></span></div><div><span style=3D"background-color:transparent"><font=
 face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, san=
s-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#2429=
2e"><span style=3D"font-size:14px">Unfortunately when I tried to do this fo=
r the lttng-modules package, it instead gave me the following warning in my=
 latest attempt:=C2=A0</span></font></span></div><div><font face=3D"-apple-=
system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple C=
olor Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=
=3D"font-size:14px"><br></span></font></div><div><font face=3D"-apple-syste=
m, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Color =
Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=3D"fo=
nt-size:14px">I</span></font><span style=3D"font-size:14px;color:rgb(36,41,=
46);font-family:-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helve=
tica,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&qu=
ot;,&quot;Segoe UI Symbol&quot;">n file included from /home/pi/BangEco_rvms=
can/stagelight_project/lttng/lttng-modules/probes/lttng-kprobes.c:31:0:</sp=
an></div><div><font face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, He=
lvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Sym=
bol" color=3D"#24292e"><span style=3D"font-size:14px">/home/pi/BangEco_rvms=
can/stagelight_project/lttng/lttng-modules/probes/../blacklist/kprobes.h:19=
:4: error: #error &quot;Your kernel is known to have buggy optimized kprobe=
s implementation. Fixed by commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c =
\&quot;ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction\&qu=
ot; in Linux. Disable CONFIG_OPTPROBES or upgrade your kernel.&quot;</span>=
</font></div><div><font face=3D"-apple-system, BlinkMacSystemFont, Segoe UI=
, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI=
 Symbol" color=3D"#24292e"><span style=3D"font-size:14px">=C2=A0#=C2=A0 err=
or &quot;Your kernel is known to have buggy optimized kprobes implementatio=
n. Fixed by commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c \&quot;ARM: 883=
4/1: Fix: kprobes: optimized kprobes illegal instruction\&quot; in Linux. D=
isable CONFIG_OPTPROBES or upgrade your kernel.&quot;</span></font></div><d=
iv><font face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Ar=
ial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=
=3D"#24292e"><span style=3D"font-size:14px"><br></span></font></div><div><f=
ont face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, =
sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#2=
4292e"><span style=3D"font-size:14px">I then tried to turn off the CONFIG_O=
PTPROBES kernel config, but it seemed to be automatically overwritten durin=
g kernel building and is considered an important part of the real-time RPi =
kernels. Has such problems been reported with this version of the PREEMPT_R=
T kernel in the past (again, the current kernel version that I am using is=
=C2=A0</span></font><span style=3D"color:rgb(36,41,46);font-family:-apple-s=
ystem,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&q=
uot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbo=
l&quot;;font-size:14px">4.14.91-rt49-v7+)? If there are I would like to kno=
w how this issue was resolved so that I can properly build and use the lttn=
g package for my project.</span></div></div></div></div></div></blockquote>=
<div>Hi Nicholas,<br></div><div><br></div><div>It looks like our lttng-modu=
les kernel version blacklist is acting exactly as it should. Looking at thi=
s<br></div><div>git tree:<br></div><div><br></div><div>git clone <a href=3D=
"https://github.com/raspberrypi/linux.git" target=3D"_blank">https://github=
.com/raspberrypi/linux.git</a> -b rpi-4.14.y-rt<br></div><div><pre><code cl=
ass=3D"gmail-m_9106008346192568069language-sh gmail-m_9106008346192568069hl=
js gmail-m_9106008346192568069bash"></code></pre></div><div>I notice that i=
n the git log, we find this bogus commit:<br></div><div><br></div><div>comm=
it f9e0bc710347fadad55910846ee36f0681d0dca8<br>Author: Kees Cook &lt;<a hre=
f=3D"mailto:keescook@chromium.org" target=3D"_blank">keescook@chromium.org<=
/a>&gt;<br>Date:=C2=A0=C2=A0 Tue Oct 30 22:12:56 2018 +0100<br><br>=C2=A0=
=C2=A0=C2=A0 ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE<b=
r>=C2=A0=C2=A0=C2=A0 <br>=C2=A0=C2=A0=C2=A0 commit e46daee53bb50bde38805f18=
23a182979724c229 upstream.<br><br></div><div>But not the fix for it (upstre=
am):<br></div><div><br></div><div>commit 0ac569bf6a7983c0c5747d6df8db9dc05b=
c92b6c<br>Author: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers=
@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<br>=
Date:=C2=A0=C2=A0 Tue Feb 5 16:37:40 2019 +0100<br><br>=C2=A0=C2=A0=C2=A0 A=
RM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction<br><br></di=
v><div>So lttng-modules refuses to build against your kernel configuration =
with CONFIG_OPTPROBES=3Dy</div><div>to save you the trouble of having kprob=
es trigger illegal instruction OOPS at runtime.<br></div><div><br></div><di=
v>I&#39;m unusure who maintains that raspberrypi rt kernel tree. However, t=
he upstream rt tree<br></div><div>for 4.14-rt maintained by Tom Zanussi see=
ms to contain the fix:<br></div><div><br></div><div><a href=3D"https://kern=
el.googlesource.com/pub/scm/linux/kernel/git/rt/linux-stable-rt/+/refs/head=
s/v4.14-rt" target=3D"_blank">https://kernel.googlesource.com/pub/scm/linux=
/kernel/git/rt/linux-stable-rt/+/refs/heads/v4.14-rt</a><br></div><div><br>=
</div><div>(currently at 4.14.109-rt57).<br></div><div><br></div><div>So yo=
u should contact your raspberrypi linux rt tree clone maintainer and ask hi=
m<br></div><div>to upgrade, or, as stated in the #error generated by lttng-=
modules, simply ensure<br></div><div>CONFIG_OPTPROBES is unset when you bui=
ld your kernel. You should ask the<br></div><div>raspberrypi community advi=
ce on how to ensure this configuration option is not</div><div>overridden b=
y the raspberrypi build system.<br></div><div><br></div><div>Thanks,<br></d=
iv><div><br></div><div>Mathieu</div><div><br></div><blockquote style=3D"bor=
der-left:2px solid rgb(16,16,255);margin-left:5px;padding-left:5px;color:rg=
b(0,0,0);font-weight:normal;font-style:normal;text-decoration:none;font-fam=
ily:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div dir=3D=
"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div><span style=3D"color:rgb(36,41=
,46);font-family:-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helv=
etica,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&q=
uot;,&quot;Segoe UI Symbol&quot;;font-size:14px"><br></span></div><div><spa=
n style=3D"color:rgb(36,41,46);font-family:-apple-system,BlinkMacSystemFont=
,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color Emoji&qu=
ot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;;font-size:14px">=
<br></span></div><div><font face=3D"-apple-system, BlinkMacSystemFont, Sego=
e UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Sego=
e UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px">Thank you so =
much for your attention and looking forward to your reply soon.</span></fon=
t></div><div><font face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Hel=
vetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symb=
ol" color=3D"#24292e"><span style=3D"font-size:14px"><br></span></font></di=
v><div><font face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica=
, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" co=
lor=3D"#24292e"><span style=3D"font-size:14px"><br></span></font></div><div=
><font face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Aria=
l, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D=
"#24292e"><span style=3D"font-size:14px"><br></span></font></div><div><font=
 face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, san=
s-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#2429=
2e"><span style=3D"font-size:14px">Best Regards,</span></font></div><div><f=
ont face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, =
sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#2=
4292e"><span style=3D"font-size:14px"><br></span></font></div><div><font fa=
ce=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-s=
erif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"=
><span style=3D"font-size:14px"><br></span></font></div><div><font face=3D"=
-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, =
Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span=
 style=3D"font-size:14px"><br></span></font></div><div><font face=3D"-apple=
-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple =
Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=
=3D"font-size:14px">Nicholas Sadjoli</span></font></div></div></div></div><=
/div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-=
dev@lists.lttng.org</a><br><a href=3D"https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-bin/ma=
ilman/listinfo/lttng-dev</a><br></blockquote></div><div><br></div><div>-- <=
br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.e=
fficios.com" target=3D"_blank">http://www.efficios.com</a></div></div></div=
></blockquote></div>

--000000000000d114d90587946491--

--===============6164888423423465612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6164888423423465612==--
