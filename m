From: Nicholas Sadjoli <nick.sadjoli@gmail.com>
Subject: Re: Problems setting up lttng on PREEMPT_RT Raspberry Pi
Date: Wed, 17 Apr 2019 03:04:24 +0800
Message-ID: <CAKUXLveyWXTsh6vG0V-isbj2YptT_r8vtMuUF-V2Aysb9SRBKg__19869.0787119389$1555441495$gmane$org@mail.gmail.com>
References: <CAKUXLvdNYPitwKb8D5VDC7nXA4-z3OiApGX=qbVxV5LWFkDyJw@mail.gmail.com>
 <725895933.460.1555337504175.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2736216029117668531=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 by lists.lttng.org (Postfix) with ESMTPS id 44kFD43SkYz1KqS
 for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2019 15:04:36 -0400 (EDT)
Received: by mail-it1-x143.google.com with SMTP id y204so519157itf.3
 for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2019 12:04:36 -0700 (PDT)
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

--===============2736216029117668531==
Content-Type: multipart/alternative; boundary="0000000000009822080586aa70dc"

--0000000000009822080586aa70dc
Content-Type: text/plain; charset="UTF-8"

Dear Mathieu,

Thank you so much for your reply Mathieu! I have actually asked about this
to the raspberry pi github forum, but unfortunately it seems that I have
not gotten any reply from them on this matter yet. I'll be asking about how
to turn off the CONFIG_OPTPROBES from them again if that's the case.

If this still fails then I'll be trying out Tom Zanussi's upstream version
of the kernel as you suggested then. Thank you so much for your help once
again

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

--0000000000009822080586aa70dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Mathieu,<div><br></div><div>Thank you so much for you=
r reply Mathieu! I have actually asked about this to the raspberry pi githu=
b forum, but unfortunately it seems that I have not gotten any reply from t=
hem on this matter yet. I&#39;ll be asking about how to turn off the CONFIG=
_OPTPROBES from them again if that&#39;s the case.</div><div><br></div><div=
>If this still fails then I&#39;ll be trying out Tom Zanussi&#39;s upstream=
 version of the kernel as you suggested then. Thank you so much for your he=
lp once again</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Mon, Apr 15, 2019 at 10:11 PM Mathieu Desnoyers &lt;<=
a href=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.desnoyers@efficios=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><div><div style=3D"font-family:arial,helvetica,sans-serif;font-size:12p=
t;color:rgb(0,0,0)"><div><span id=3D"gmail-m_-6063565989240103262zwchr">---=
-- On Apr 15, 2019, at 7:07 AM, Nicholas Sadjoli &lt;<a href=3D"mailto:nick=
.sadjoli@gmail.com" target=3D"_blank">nick.sadjoli@gmail.com</a>&gt; wrote:=
<br></span></div><div><blockquote style=3D"border-left:2px solid rgb(16,16,=
255);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:normal;f=
ont-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-seri=
f;font-size:12pt"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div d=
ir=3D"ltr">Dear Lttng dev Team,<br><div>I am currently interested in using =
lttng to measure the interrupt or hardware real-time latencies experienced =
within my user-space applications. Unfortunately I have been having issues =
installing lttng on my Raspberry Pi that is using the PREEMPT_RT patched ke=
rnel, version=C2=A0<span style=3D"color:rgb(36,41,46);font-family:-apple-sy=
stem,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&qu=
ot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol=
&quot;;font-size:14px">4.14.91-rt49-v7+. The problems so far can be seen do=
cumented in the RPi Linux github forum page here:=C2=A0</span><font face=3D=
"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif,=
 Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><spa=
n style=3D"font-size:14px"><a href=3D"https://github.com/raspberrypi/linux/=
issues/2930" target=3D"_blank">https://github.com/raspberrypi/linux/issues/=
2930</a></span></font><br></div><div><span style=3D"color:rgb(36,41,46);fon=
t-family:-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,Ar=
ial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&qu=
ot;Segoe UI Symbol&quot;;font-size:14px"><br></span></div><div><span style=
=3D"color:rgb(36,41,46);font-family:-apple-system,BlinkMacSystemFont,&quot;=
Segoe UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&qu=
ot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;;font-size:14px">Initial=
ly I was about to just install the Debian package of the lttng onto the RPi=
, and just proceeded with the commands &#39;</span><font face=3D"Andale Mon=
o WT, Andale Mono, Bitstream Vera Sans Mono, Liberation Mono, Nimbus Mono L=
, Ubuntu Mono, Monaco, Consolas, Lucida Console, Lucida Sans Typewriter, Co=
urier New, Courier, monospace" color=3D"rgba(0, 0, 0, 0.749019607843137)">s=
udo apt-get install lttng-modules-dkms liblttng-ust-dev lttng-tools&#39; </=
font>However, I was unable to use lttng package at all and found out that f=
or the RPi, a build from source is necessary for lttng, as described here:=
=C2=A0<span style=3D"background-color:transparent"><font face=3D"-apple-sys=
tem, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Colo=
r Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=3D"=
font-size:14px"><a href=3D"https://stackoverflow.com/questions/52386448/lin=
ux-trace-tool-lttng-on-raspbian-kernel-tracer-not-available" target=3D"_bla=
nk">https://stackoverflow.com/questions/52386448/linux-trace-tool-lttng-on-=
raspbian-kernel-tracer-not-available</a></span></font></span><br></div><div=
><span style=3D"background-color:transparent"><font face=3D"-apple-system, =
BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emo=
ji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=3D"font-=
size:14px"><br></span></font></span></div><div><span style=3D"background-co=
lor:transparent"><font face=3D"-apple-system, BlinkMacSystemFont, Segoe UI,=
 Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI =
Symbol" color=3D"#24292e"><span style=3D"font-size:14px">Following their su=
ggestion, I then tried to build the lttng packages from source, and even re=
-building the RPi kernel locally to ensure the kernel headers are in the RP=
i and linked up properly to the source packages.=C2=A0</span></font></span>=
</div><div><span style=3D"background-color:transparent"><font face=3D"-appl=
e-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple=
 Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span styl=
e=3D"font-size:14px"><br></span></font></span></div><div><span style=3D"bac=
kground-color:transparent"><font face=3D"-apple-system, BlinkMacSystemFont,=
 Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji,=
 Segoe UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px">Unfortun=
ately when I tried to do this for the lttng-modules package, it instead gav=
e me the following warning in my latest attempt:=C2=A0</span></font></span>=
</div><div><font face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helve=
tica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol=
" color=3D"#24292e"><span style=3D"font-size:14px"><br></span></font></div>=
<div><font face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, =
Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" colo=
r=3D"#24292e"><span style=3D"font-size:14px">I</span></font><span style=3D"=
font-size:14px;color:rgb(36,41,46);font-family:-apple-system,BlinkMacSystem=
Font,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color Emoj=
i&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;">n file incl=
uded from /home/pi/BangEco_rvmscan/stagelight_project/lttng/lttng-modules/p=
robes/lttng-kprobes.c:31:0:</span></div><div><font face=3D"-apple-system, B=
linkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoj=
i, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=3D"font-s=
ize:14px">/home/pi/BangEco_rvmscan/stagelight_project/lttng/lttng-modules/p=
robes/../blacklist/kprobes.h:19:4: error: #error &quot;Your kernel is known=
 to have buggy optimized kprobes implementation. Fixed by commit 0ac569bf6a=
7983c0c5747d6df8db9dc05bc92b6c \&quot;ARM: 8834/1: Fix: kprobes: optimized =
kprobes illegal instruction\&quot; in Linux. Disable CONFIG_OPTPROBES or up=
grade your kernel.&quot;</span></font></div><div><font face=3D"-apple-syste=
m, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Color =
Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=3D"fo=
nt-size:14px">=C2=A0#=C2=A0 error &quot;Your kernel is known to have buggy =
optimized kprobes implementation. Fixed by commit 0ac569bf6a7983c0c5747d6df=
8db9dc05bc92b6c \&quot;ARM: 8834/1: Fix: kprobes: optimized kprobes illegal=
 instruction\&quot; in Linux. Disable CONFIG_OPTPROBES or upgrade your kern=
el.&quot;</span></font></div><div><font face=3D"-apple-system, BlinkMacSyst=
emFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI=
 Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px"><=
br></span></font></div><div><font face=3D"-apple-system, BlinkMacSystemFont=
, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji=
, Segoe UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px">I then =
tried to turn off the CONFIG_OPTPROBES kernel config, but it seemed to be a=
utomatically overwritten during kernel building and is considered an import=
ant part of the real-time RPi kernels. Has such problems been reported with=
 this version of the PREEMPT_RT kernel in the past (again, the current kern=
el version that I am using is=C2=A0</span></font><span style=3D"color:rgb(3=
6,41,46);font-family:-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,=
Helvetica,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emo=
ji&quot;,&quot;Segoe UI Symbol&quot;;font-size:14px">4.14.91-rt49-v7+)? If =
there are I would like to know how this issue was resolved so that I can pr=
operly build and use the lttng package for my project.</span></div></div></=
div></div></div></blockquote><div>Hi Nicholas,<br></div><div><br></div><div=
>It looks like our lttng-modules kernel version blacklist is acting exactly=
 as it should. Looking at this<br></div><div>git tree:<br></div><div><br></=
div><div>git clone <a href=3D"https://github.com/raspberrypi/linux.git" tar=
get=3D"_blank">https://github.com/raspberrypi/linux.git</a> -b rpi-4.14.y-r=
t<br></div><div><pre><code class=3D"gmail-m_-6063565989240103262language-sh=
 gmail-m_-6063565989240103262hljs gmail-m_-6063565989240103262bash"></code>=
</pre></div><div>I notice that in the git log, we find this bogus commit:<b=
r></div><div><br></div><div>commit f9e0bc710347fadad55910846ee36f0681d0dca8=
<br>Author: Kees Cook &lt;<a href=3D"mailto:keescook@chromium.org" target=
=3D"_blank">keescook@chromium.org</a>&gt;<br>Date:=C2=A0=C2=A0 Tue Oct 30 2=
2:12:56 2018 +0100<br><br>=C2=A0=C2=A0=C2=A0 ARM: 8806/1: kprobes: Fix fals=
e positive with FORTIFY_SOURCE<br>=C2=A0=C2=A0=C2=A0 <br>=C2=A0=C2=A0=C2=A0=
 commit e46daee53bb50bde38805f1823a182979724c229 upstream.<br><br></div><di=
v>But not the fix for it (upstream):<br></div><div><br></div><div>commit 0a=
c569bf6a7983c0c5747d6df8db9dc05bc92b6c<br>Author: Mathieu Desnoyers &lt;<a =
href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.de=
snoyers@efficios.com</a>&gt;<br>Date:=C2=A0=C2=A0 Tue Feb 5 16:37:40 2019 +=
0100<br><br>=C2=A0=C2=A0=C2=A0 ARM: 8834/1: Fix: kprobes: optimized kprobes=
 illegal instruction<br><br></div><div>So lttng-modules refuses to build ag=
ainst your kernel configuration with CONFIG_OPTPROBES=3Dy</div><div>to save=
 you the trouble of having kprobes trigger illegal instruction OOPS at runt=
ime.<br></div><div><br></div><div>I&#39;m unusure who maintains that raspbe=
rrypi rt kernel tree. However, the upstream rt tree<br></div><div>for 4.14-=
rt maintained by Tom Zanussi seems to contain the fix:<br></div><div><br></=
div><div><a href=3D"https://kernel.googlesource.com/pub/scm/linux/kernel/gi=
t/rt/linux-stable-rt/+/refs/heads/v4.14-rt" target=3D"_blank">https://kerne=
l.googlesource.com/pub/scm/linux/kernel/git/rt/linux-stable-rt/+/refs/heads=
/v4.14-rt</a><br></div><div><br></div><div>(currently at 4.14.109-rt57).<br=
></div><div><br></div><div>So you should contact your raspberrypi linux rt =
tree clone maintainer and ask him<br></div><div>to upgrade, or, as stated i=
n the #error generated by lttng-modules, simply ensure<br></div><div>CONFIG=
_OPTPROBES is unset when you build your kernel. You should ask the<br></div=
><div>raspberrypi community advice on how to ensure this configuration opti=
on is not</div><div>overridden by the raspberrypi build system.<br></div><d=
iv><br></div><div>Thanks,<br></div><div><br></div><div>Mathieu</div><div><b=
r></div><blockquote style=3D"border-left:2px solid rgb(16,16,255);margin-le=
ft:5px;padding-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:norm=
al;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12=
pt"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><di=
v><span style=3D"color:rgb(36,41,46);font-family:-apple-system,BlinkMacSyst=
emFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color Em=
oji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;;font-size:=
14px"><br></span></div><div><span style=3D"color:rgb(36,41,46);font-family:=
-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans-=
serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe =
UI Symbol&quot;;font-size:14px"><br></span></div><div><font face=3D"-apple-=
system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple C=
olor Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=
=3D"font-size:14px">Thank you so much for your attention and looking forwar=
d to your reply soon.</span></font></div><div><font face=3D"-apple-system, =
BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emo=
ji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=3D"font-=
size:14px"><br></span></font></div><div><font face=3D"-apple-system, BlinkM=
acSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Se=
goe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=3D"font-size:1=
4px"><br></span></font></div><div><font face=3D"-apple-system, BlinkMacSyst=
emFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI=
 Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px"><=
br></span></font></div><div><font face=3D"-apple-system, BlinkMacSystemFont=
, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji=
, Segoe UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px">Best Re=
gards,</span></font></div><div><font face=3D"-apple-system, BlinkMacSystemF=
ont, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Em=
oji, Segoe UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px"><br>=
</span></font></div><div><font face=3D"-apple-system, BlinkMacSystemFont, S=
egoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, S=
egoe UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px"><br></span=
></font></div><div><font face=3D"-apple-system, BlinkMacSystemFont, Segoe U=
I, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe U=
I Symbol" color=3D"#24292e"><span style=3D"font-size:14px"><br></span></fon=
t></div><div><font face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Hel=
vetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symb=
ol" color=3D"#24292e"><span style=3D"font-size:14px">Nicholas Sadjoli</span=
></font></div></div></div></div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-=
dev@lists.lttng.org</a><br><a href=3D"https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-bin/ma=
ilman/listinfo/lttng-dev</a><br></blockquote></div><div><br></div><div>-- <=
br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.e=
fficios.com" target=3D"_blank">http://www.efficios.com</a></div></div></div=
></blockquote></div>

--0000000000009822080586aa70dc--

--===============2736216029117668531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2736216029117668531==--
