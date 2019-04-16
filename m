From: Nicholas Sadjoli <nick.sadjoli@gmail.com>
Subject: Re: Problems setting up lttng on PREEMPT_RT Raspberry Pi
Date: Wed, 17 Apr 2019 03:05:57 +0800
Message-ID: <CAKUXLvcs+dCUn1-LqGRpL2AAH6SamOLob2kUcOZRfeuC=-TmKQ__38856.1363144376$1555441587$gmane$org@mail.gmail.com>
References: <CAKUXLvdNYPitwKb8D5VDC7nXA4-z3OiApGX=qbVxV5LWFkDyJw@mail.gmail.com>
 <725895933.460.1555337504175.JavaMail.zimbra@efficios.com>
 <CAKUXLveyWXTsh6vG0V-isbj2YptT_r8vtMuUF-V2Aysb9SRBKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5664938991771351210=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 by lists.lttng.org (Postfix) with ESMTPS id 44kFFt0gjxz1KrJ
 for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2019 15:06:10 -0400 (EDT)
Received: by mail-it1-x143.google.com with SMTP id k64so496955itb.5
 for <lttng-dev@lists.lttng.org>; Tue, 16 Apr 2019 12:06:10 -0700 (PDT)
In-Reply-To: <CAKUXLveyWXTsh6vG0V-isbj2YptT_r8vtMuUF-V2Aysb9SRBKg@mail.gmail.com>
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

--===============5664938991771351210==
Content-Type: multipart/alternative; boundary="0000000000002d82d10586aa7655"

--0000000000002d82d10586aa7655
Content-Type: text/plain; charset="UTF-8"

Dear Mathieu,

Apoplogies but please ignore my previous email as it wasn't properly
finished.

Thank you so much for your reply Mathieu! I have actually asked about this
to the raspberry pi github forum, but unfortunately it seems that I have
not gotten any reply from them on this matter yet. I'll be asking about how
to turn off the CONFIG_OPTPROBES from them again if that's the case.

If this still fails then I'll be trying out Tom Zanussi's upstream version
of the kernel as you suggested then.

Thank you so much for your help once again and keep up the nice support
that you have for lttng!


Best Regards,


Nicholas Sadjoli

On Wed, Apr 17, 2019 at 3:04 AM Nicholas Sadjoli <nick.sadjoli@gmail.com>
wrote:

> Dear Mathieu,
>
> Thank you so much for your reply Mathieu! I have actually asked about this
> to the raspberry pi github forum, but unfortunately it seems that I have
> not gotten any reply from them on this matter yet. I'll be asking about how
> to turn off the CONFIG_OPTPROBES from them again if that's the case.
>
> If this still fails then I'll be trying out Tom Zanussi's upstream version
> of the kernel as you suggested then. Thank you so much for your help once
> again
>
> On Mon, Apr 15, 2019 at 10:11 PM Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com> wrote:
>
>> ----- On Apr 15, 2019, at 7:07 AM, Nicholas Sadjoli <
>> nick.sadjoli@gmail.com> wrote:
>>
>> Dear Lttng dev Team,
>> I am currently interested in using lttng to measure the interrupt or
>> hardware real-time latencies experienced within my user-space applications.
>> Unfortunately I have been having issues installing lttng on my Raspberry Pi
>> that is using the PREEMPT_RT patched kernel, version 4.14.91-rt49-v7+.
>> The problems so far can be seen documented in the RPi Linux github forum
>> page here: https://github.com/raspberrypi/linux/issues/2930
>>
>> Initially I was about to just install the Debian package of the lttng
>> onto the RPi, and just proceeded with the commands 'sudo apt-get install
>> lttng-modules-dkms liblttng-ust-dev lttng-tools' However, I was unable
>> to use lttng package at all and found out that for the RPi, a build from
>> source is necessary for lttng, as described here:
>> https://stackoverflow.com/questions/52386448/linux-trace-tool-lttng-on-raspbian-kernel-tracer-not-available
>>
>> Following their suggestion, I then tried to build the lttng packages from
>> source, and even re-building the RPi kernel locally to ensure the kernel
>> headers are in the RPi and linked up properly to the source packages.
>>
>> Unfortunately when I tried to do this for the lttng-modules package, it
>> instead gave me the following warning in my latest attempt:
>>
>> In file included from
>> /home/pi/BangEco_rvmscan/stagelight_project/lttng/lttng-modules/probes/lttng-kprobes.c:31:0:
>> /home/pi/BangEco_rvmscan/stagelight_project/lttng/lttng-modules/probes/../blacklist/kprobes.h:19:4:
>> error: #error "Your kernel is known to have buggy optimized kprobes
>> implementation. Fixed by commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c
>> \"ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction\" in
>> Linux. Disable CONFIG_OPTPROBES or upgrade your kernel."
>>  #  error "Your kernel is known to have buggy optimized kprobes
>> implementation. Fixed by commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c
>> \"ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction\" in
>> Linux. Disable CONFIG_OPTPROBES or upgrade your kernel."
>>
>> I then tried to turn off the CONFIG_OPTPROBES kernel config, but it
>> seemed to be automatically overwritten during kernel building and is
>> considered an important part of the real-time RPi kernels. Has such
>> problems been reported with this version of the PREEMPT_RT kernel in the
>> past (again, the current kernel version that I am using is 4.14.91-rt49-v7+)?
>> If there are I would like to know how this issue was resolved so that I can
>> properly build and use the lttng package for my project.
>>
>> Hi Nicholas,
>>
>> It looks like our lttng-modules kernel version blacklist is acting
>> exactly as it should. Looking at this
>> git tree:
>>
>> git clone https://github.com/raspberrypi/linux.git -b rpi-4.14.y-rt
>>
>> I notice that in the git log, we find this bogus commit:
>>
>> commit f9e0bc710347fadad55910846ee36f0681d0dca8
>> Author: Kees Cook <keescook@chromium.org>
>> Date:   Tue Oct 30 22:12:56 2018 +0100
>>
>>     ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE
>>
>>     commit e46daee53bb50bde38805f1823a182979724c229 upstream.
>>
>> But not the fix for it (upstream):
>>
>> commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c
>> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Date:   Tue Feb 5 16:37:40 2019 +0100
>>
>>     ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction
>>
>> So lttng-modules refuses to build against your kernel configuration with
>> CONFIG_OPTPROBES=y
>> to save you the trouble of having kprobes trigger illegal instruction
>> OOPS at runtime.
>>
>> I'm unusure who maintains that raspberrypi rt kernel tree. However, the
>> upstream rt tree
>> for 4.14-rt maintained by Tom Zanussi seems to contain the fix:
>>
>>
>> https://kernel.googlesource.com/pub/scm/linux/kernel/git/rt/linux-stable-rt/+/refs/heads/v4.14-rt
>>
>> (currently at 4.14.109-rt57).
>>
>> So you should contact your raspberrypi linux rt tree clone maintainer and
>> ask him
>> to upgrade, or, as stated in the #error generated by lttng-modules,
>> simply ensure
>> CONFIG_OPTPROBES is unset when you build your kernel. You should ask the
>> raspberrypi community advice on how to ensure this configuration option
>> is not
>> overridden by the raspberrypi build system.
>>
>> Thanks,
>>
>> Mathieu
>>
>>
>>
>> Thank you so much for your attention and looking forward to your reply
>> soon.
>>
>>
>>
>> Best Regards,
>>
>>
>>
>> Nicholas Sadjoli
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>

--0000000000002d82d10586aa7655
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Mathieu,<div><br></div><div>Apoplogies but please ign=
ore my previous email as it wasn&#39;t properly finished.</div><div><br></d=
iv><div>Thank you so much for your reply Mathieu! I have actually asked abo=
ut this to the raspberry pi github forum, but unfortunately it seems that I=
 have not gotten any reply from them on this matter yet. I&#39;ll be asking=
 about how to turn off the CONFIG_OPTPROBES from them again if that&#39;s t=
he case.</div><div><br></div><div>If this still fails then I&#39;ll be tryi=
ng out Tom Zanussi&#39;s upstream version of the kernel as you suggested th=
en.=C2=A0</div><div><br></div><div>Thank you so much for your help once aga=
in and keep up the nice support that you have for lttng!</div><div><br></di=
v><div><br></div><div>Best Regards,</div><div><br></div><div><br></div><div=
>Nicholas Sadjoli</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr=
" class=3D"gmail_attr">On Wed, Apr 17, 2019 at 3:04 AM Nicholas Sadjoli &lt=
;<a href=3D"mailto:nick.sadjoli@gmail.com">nick.sadjoli@gmail.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr">Dear Mathieu,<div><br></div><div>Thank you so much for your reply =
Mathieu! I have actually asked about this to the raspberry pi github forum,=
 but unfortunately it seems that I have not gotten any reply from them on t=
his matter yet. I&#39;ll be asking about how to turn off the CONFIG_OPTPROB=
ES from them again if that&#39;s the case.</div><div><br></div><div>If this=
 still fails then I&#39;ll be trying out Tom Zanussi&#39;s upstream version=
 of the kernel as you suggested then. Thank you so much for your help once =
again</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Mon, Apr 15, 2019 at 10:11 PM Mathieu Desnoyers &lt;<a href=
=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoy=
ers@efficios.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><div><div style=3D"font-family:arial,helvetica,sans-serif;f=
ont-size:12pt;color:rgb(0,0,0)"><div><span id=3D"gmail-m_-83453649305563690=
8gmail-m_-6063565989240103262zwchr">----- On Apr 15, 2019, at 7:07 AM, Nich=
olas Sadjoli &lt;<a href=3D"mailto:nick.sadjoli@gmail.com" target=3D"_blank=
">nick.sadjoli@gmail.com</a>&gt; wrote:<br></span></div><div><blockquote st=
yle=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;padding-left:5p=
x;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-decoration:non=
e;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><=
div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Dear Lttng dev Team,<br><=
div>I am currently interested in using lttng to measure the interrupt or ha=
rdware real-time latencies experienced within my user-space applications. U=
nfortunately I have been having issues installing lttng on my Raspberry Pi =
that is using the PREEMPT_RT patched kernel, version=C2=A0<span style=3D"co=
lor:rgb(36,41,46);font-family:-apple-system,BlinkMacSystemFont,&quot;Segoe =
UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Seg=
oe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;;font-size:14px">4.14.91-rt49-=
v7+. The problems so far can be seen documented in the RPi Linux github for=
um page here:=C2=A0</span><font face=3D"-apple-system, BlinkMacSystemFont, =
Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, =
Segoe UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px"><a href=
=3D"https://github.com/raspberrypi/linux/issues/2930" target=3D"_blank">htt=
ps://github.com/raspberrypi/linux/issues/2930</a></span></font><br></div><d=
iv><span style=3D"color:rgb(36,41,46);font-family:-apple-system,BlinkMacSys=
temFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color E=
moji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;;font-size=
:14px"><br></span></div><div><span style=3D"color:rgb(36,41,46);font-family=
:-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans=
-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe=
 UI Symbol&quot;;font-size:14px">Initially I was about to just install the =
Debian package of the lttng onto the RPi, and just proceeded with the comma=
nds &#39;</span><font face=3D"Andale Mono WT, Andale Mono, Bitstream Vera S=
ans Mono, Liberation Mono, Nimbus Mono L, Ubuntu Mono, Monaco, Consolas, Lu=
cida Console, Lucida Sans Typewriter, Courier New, Courier, monospace" colo=
r=3D"rgba(0, 0, 0, 0.749019607843137)">sudo apt-get install lttng-modules-d=
kms liblttng-ust-dev lttng-tools&#39; </font>However, I was unable to use l=
ttng package at all and found out that for the RPi, a build from source is =
necessary for lttng, as described here:=C2=A0<span style=3D"background-colo=
r:transparent"><font face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, H=
elvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Sy=
mbol" color=3D"#24292e"><span style=3D"font-size:14px"><a href=3D"https://s=
tackoverflow.com/questions/52386448/linux-trace-tool-lttng-on-raspbian-kern=
el-tracer-not-available" target=3D"_blank">https://stackoverflow.com/questi=
ons/52386448/linux-trace-tool-lttng-on-raspbian-kernel-tracer-not-available=
</a></span></font></span><br></div><div><span style=3D"background-color:tra=
nsparent"><font face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvet=
ica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol"=
 color=3D"#24292e"><span style=3D"font-size:14px"><br></span></font></span>=
</div><div><span style=3D"background-color:transparent"><font face=3D"-appl=
e-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple=
 Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span styl=
e=3D"font-size:14px">Following their suggestion, I then tried to build the =
lttng packages from source, and even re-building the RPi kernel locally to =
ensure the kernel headers are in the RPi and linked up properly to the sour=
ce packages.=C2=A0</span></font></span></div><div><span style=3D"background=
-color:transparent"><font face=3D"-apple-system, BlinkMacSystemFont, Segoe =
UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe =
UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px"><br></span></fo=
nt></span></div><div><span style=3D"background-color:transparent"><font fac=
e=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-se=
rif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e">=
<span style=3D"font-size:14px">Unfortunately when I tried to do this for th=
e lttng-modules package, it instead gave me the following warning in my lat=
est attempt:=C2=A0</span></font></span></div><div><font face=3D"-apple-syst=
em, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Color=
 Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=3D"f=
ont-size:14px"><br></span></font></div><div><font face=3D"-apple-system, Bl=
inkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji=
, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=3D"font-si=
ze:14px">I</span></font><span style=3D"font-size:14px;color:rgb(36,41,46);f=
ont-family:-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,=
Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&=
quot;Segoe UI Symbol&quot;">n file included from /home/pi/BangEco_rvmscan/s=
tagelight_project/lttng/lttng-modules/probes/lttng-kprobes.c:31:0:</span></=
div><div><font face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helveti=
ca, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" =
color=3D"#24292e"><span style=3D"font-size:14px">/home/pi/BangEco_rvmscan/s=
tagelight_project/lttng/lttng-modules/probes/../blacklist/kprobes.h:19:4: e=
rror: #error &quot;Your kernel is known to have buggy optimized kprobes imp=
lementation. Fixed by commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c \&quo=
t;ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction\&quot; i=
n Linux. Disable CONFIG_OPTPROBES or upgrade your kernel.&quot;</span></fon=
t></div><div><font face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Hel=
vetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symb=
ol" color=3D"#24292e"><span style=3D"font-size:14px">=C2=A0#=C2=A0 error &q=
uot;Your kernel is known to have buggy optimized kprobes implementation. Fi=
xed by commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c \&quot;ARM: 8834/1: =
Fix: kprobes: optimized kprobes illegal instruction\&quot; in Linux. Disabl=
e CONFIG_OPTPROBES or upgrade your kernel.&quot;</span></font></div><div><f=
ont face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, =
sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#2=
4292e"><span style=3D"font-size:14px"><br></span></font></div><div><font fa=
ce=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-s=
erif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"=
><span style=3D"font-size:14px">I then tried to turn off the CONFIG_OPTPROB=
ES kernel config, but it seemed to be automatically overwritten during kern=
el building and is considered an important part of the real-time RPi kernel=
s. Has such problems been reported with this version of the PREEMPT_RT kern=
el in the past (again, the current kernel version that I am using is=C2=A0<=
/span></font><span style=3D"color:rgb(36,41,46);font-family:-apple-system,B=
linkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&quot;App=
le Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;=
;font-size:14px">4.14.91-rt49-v7+)? If there are I would like to know how t=
his issue was resolved so that I can properly build and use the lttng packa=
ge for my project.</span></div></div></div></div></div></blockquote><div>Hi=
 Nicholas,<br></div><div><br></div><div>It looks like our lttng-modules ker=
nel version blacklist is acting exactly as it should. Looking at this<br></=
div><div>git tree:<br></div><div><br></div><div>git clone <a href=3D"https:=
//github.com/raspberrypi/linux.git" target=3D"_blank">https://github.com/ra=
spberrypi/linux.git</a> -b rpi-4.14.y-rt<br></div><div><pre><code class=3D"=
gmail-m_-834536493055636908gmail-m_-6063565989240103262language-sh gmail-m_=
-834536493055636908gmail-m_-6063565989240103262hljs gmail-m_-83453649305563=
6908gmail-m_-6063565989240103262bash"></code></pre></div><div>I notice that=
 in the git log, we find this bogus commit:<br></div><div><br></div><div>co=
mmit f9e0bc710347fadad55910846ee36f0681d0dca8<br>Author: Kees Cook &lt;<a h=
ref=3D"mailto:keescook@chromium.org" target=3D"_blank">keescook@chromium.or=
g</a>&gt;<br>Date:=C2=A0=C2=A0 Tue Oct 30 22:12:56 2018 +0100<br><br>=C2=A0=
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
</blockquote></div>

--0000000000002d82d10586aa7655--

--===============5664938991771351210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5664938991771351210==--
