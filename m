From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Problems setting up lttng on PREEMPT_RT Raspberry Pi
Date: Sun, 28 Apr 2019 09:58:55 -0400 (EDT)
Message-ID: <305872197.537.1556459935039.JavaMail.zimbra__23747.0527574018$1556459982$gmane$org@efficios.com>
References: <CAKUXLvdNYPitwKb8D5VDC7nXA4-z3OiApGX=qbVxV5LWFkDyJw@mail.gmail.com>
 <725895933.460.1555337504175.JavaMail.zimbra@efficios.com>
 <CAKUXLvdQ0ELiGLDg-gQGh4Ja1+q3_Jpc8GcB6Pnvh522=FE_fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5511765844198300550=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44sTsz0zMHz1KL4
 for <lttng-dev@lists.lttng.org>; Sun, 28 Apr 2019 09:59:02 -0400 (EDT)
In-Reply-To: <CAKUXLvdQ0ELiGLDg-gQGh4Ja1+q3_Jpc8GcB6Pnvh522=FE_fw@mail.gmail.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Tom Zanussi <tom.zanussi@linux.intel.com>, linux-rt-users <linux-rt-users@vger.kernel.org>, rostedt <rostedt@goodmis.org>, dev-raspberry-pi <dev-raspberry-pi@lists.mozilla.org>
List-Id: lttng-dev@lists.lttng.org

--===============5511765844198300550==
Content-Type: multipart/alternative;
	boundary="=_777d5491-4554-4af6-89fa-4c98b9177629"

--=_777d5491-4554-4af6-89fa-4c98b9177629
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Apr 28, 2019, at 6:11 AM, Nicholas Sadjoli <nick.sadjoli@gmail.com> wrote: 

> Hello again Mathieu,
> I apologize that this is a rather late re-opening of the topic again. However,
> after consulting with the RPi kernel side, it seems that even after trying to
> fix for the mentioned issue (i.e. by upgrading to the listed 'fixed' commit), I
> am still having issues installing the lttng-modules. The following link is the
> thread that I am having with the RPi kernel github: [
> https://github.com/raspberrypi/linux/issues/2930 |
> https://github.com/raspberrypi/linux/issues/2930 ]

As replied by "pelwell" on the tracker: 

"I think that the problem isn't with how you applied the back-ported patch, but with the detection of the problem by lttng. It seems that the obvious course of action is not sufficient to fix the problem, and I can't spare the time to start building lttng just to debug it for you - sorry." 

Cherry-picking the kernel fix is not sufficient to let the lttng-modules kernel version blacklist mechanism know that 
the kernel indeed has the fix. That's because the blacklist is based on the kernel version ranges, and you did 
not change the kernel version. 

> Even though it is listed that version 2.9 seems to be okay, recently I tried to
> re-install the lttng-modules onto another RPi, but this time even with the
> 'fixed' commit as suggested in the thread, lttng-modules still give the same
> 'buggy kernel implementation' error. Please do note that it seems
> CONFIG_OPTPROBES cannot be turned off at all during the kernel build, as it
> will be overriden by default and seems to be integral to the build of the RPi's
> RT kernel as well, hence this is not really an option either.

I my prior response, I never recommended to just cherry-pick the fix. I recommended that 
you upgrade your kernel tree to one that contains the fix (and has a version tag which 
guarantees that). 

> Is there a specific way on how to upgrade to the mentioned 'fixed' commit
> without requiring a complete kernel overhaul? I am getting rather desparate as
> I need this to work for an upcoming assignment deadline this week. So I'm
> hoping that there is still potential solution to this.

If you just cherry-picked the fix without changing the kernel version, the lttng-modules blacklist will still refuse to compile 
against your kernel, because the blacklist is based on kernel version range checks. 

There are a few solutions here: 

1) Turn off CONFIG_OPTPROBES with the help of the RPi community, 

2) Upgrade your kernel tree to a kernel version that is outside of the blacklist range. Not just cherry-picking the specific fix. 

3) If you choose to just cherry-pick the fix and not change the kernel version, you 
can force lttng-modules to build against a blacklisted kernel version by removing 
those lines in the lttng-modules source tree: 

blacklist/kprobes.h: 

#if LTTNG_KERNEL_RANGE(4,20,0, 4,20,13) \ 
|| LTTNG_KERNEL_RANGE(4,19,9, 4,19,26) \ 
|| LTTNG_KERNEL_RANGE(4,14,87, 4,14,104) 
# if defined(CONFIG_ARM) && defined(CONFIG_OPTPROBES) 
# error "Your kernel is known to have buggy optimized kprobes implementation. Fixed by commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c \"ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction\" in Linux. Disable CONFIG_OPTPROBES or upgrade your kernel." 
# endif /* #if defined(CONFIG_ARM) && defined(CONFIG_OPTPROBES) */ 
#endif 

This will ensure lttng-modules builds against your kernel even though it's in the range 
of kernel versions known to cause issues. But considering you cherry-picked the 
fix, then you should be fine. 

However, doing so removes the "belts and suspenders" we put in place to ensure 
you don't try to use a bogus kprobes. I therefore recommend solutions 1 or 2 rather 
than 3, but solution 3 might do the trick considering your short time-frame. 

Good luck, 

Mathieu 

> Best Regards,

> Nicholas Sadjoli

> On Mon, Apr 15, 2019 at 10:11 PM Mathieu Desnoyers < [
> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
> wrote:

>> ----- On Apr 15, 2019, at 7:07 AM, Nicholas Sadjoli < [
>> mailto:nick.sadjoli@gmail.com | nick.sadjoli@gmail.com ] > wrote:

>>> Dear Lttng dev Team,
>>> I am currently interested in using lttng to measure the interrupt or hardware
>>> real-time latencies experienced within my user-space applications.
>>> Unfortunately I have been having issues installing lttng on my Raspberry Pi
>>> that is using the PREEMPT_RT patched kernel, version 4.14.91-rt49-v7+. The
>>> problems so far can be seen documented in the RPi Linux github forum page here:
>>> [ https://github.com/raspberrypi/linux/issues/2930 |
>>> https://github.com/raspberrypi/linux/issues/2930 ]

>>> Initially I was about to just install the Debian package of the lttng onto the
>>> RPi, and just proceeded with the commands ' sudo apt-get install
>>> lttng-modules-dkms liblttng-ust-dev lttng-tools' However, I was unable to use
>>> lttng package at all and found out that for the RPi, a build from source is
>>> necessary for lttng, as described here: [
>>> https://stackoverflow.com/questions/52386448/linux-trace-tool-lttng-on-raspbian-kernel-tracer-not-available
>>> |
>>> https://stackoverflow.com/questions/52386448/linux-trace-tool-lttng-on-raspbian-kernel-tracer-not-available
>>> ]

>>> Following their suggestion, I then tried to build the lttng packages from
>>> source, and even re-building the RPi kernel locally to ensure the kernel
>>> headers are in the RPi and linked up properly to the source packages.

>>> Unfortunately when I tried to do this for the lttng-modules package, it instead
>>> gave me the following warning in my latest attempt:

>>> I n file included from
>>> /home/pi/BangEco_rvmscan/stagelight_project/lttng/lttng-modules/probes/lttng-kprobes.c:31:0:
>>> /home/pi/BangEco_rvmscan/stagelight_project/lttng/lttng-modules/probes/../blacklist/kprobes.h:19:4:
>>> error: #error "Your kernel is known to have buggy optimized kprobes
>>> implementation. Fixed by commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c \"ARM:
>>> 8834/1: Fix: kprobes: optimized kprobes illegal instruction\" in Linux. Disable
>>> CONFIG_OPTPROBES or upgrade your kernel."
>>> # error "Your kernel is known to have buggy optimized kprobes implementation.
>>> Fixed by commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c \"ARM: 8834/1: Fix:
>>> kprobes: optimized kprobes illegal instruction\" in Linux. Disable
>>> CONFIG_OPTPROBES or upgrade your kernel."

>>> I then tried to turn off the CONFIG_OPTPROBES kernel config, but it seemed to be
>>> automatically overwritten during kernel building and is considered an important
>>> part of the real-time RPi kernels. Has such problems been reported with this
>>> version of the PREEMPT_RT kernel in the past (again, the current kernel version
>>> that I am using is 4.14.91-rt49-v7+)? If there are I would like to know how
>>> this issue was resolved so that I can properly build and use the lttng package
>>> for my project.

>> Hi Nicholas,

>> It looks like our lttng-modules kernel version blacklist is acting exactly as it
>> should. Looking at this
>> git tree:

>> git clone [ https://github.com/raspberrypi/linux.git |
>> https://github.com/raspberrypi/linux.git ] -b rpi-4.14.y-rt
>> I notice that in the git log, we find this bogus commit:

>> commit f9e0bc710347fadad55910846ee36f0681d0dca8
>> Author: Kees Cook < [ mailto:keescook@chromium.org | keescook@chromium.org ] >
>> Date: Tue Oct 30 22:12:56 2018 +0100

>> ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE

>> commit e46daee53bb50bde38805f1823a182979724c229 upstream.

>> But not the fix for it (upstream):

>> commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c
>> Author: Mathieu Desnoyers < [ mailto:mathieu.desnoyers@efficios.com |
>> mathieu.desnoyers@efficios.com ] >
>> Date: Tue Feb 5 16:37:40 2019 +0100

>> ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction

>> So lttng-modules refuses to build against your kernel configuration with
>> CONFIG_OPTPROBES=y
>> to save you the trouble of having kprobes trigger illegal instruction OOPS at
>> runtime.

>> I'm unusure who maintains that raspberrypi rt kernel tree. However, the upstream
>> rt tree
>> for 4.14-rt maintained by Tom Zanussi seems to contain the fix:

>> [
>> https://kernel.googlesource.com/pub/scm/linux/kernel/git/rt/linux-stable-rt/+/refs/heads/v4.14-rt
>> |
>> https://kernel.googlesource.com/pub/scm/linux/kernel/git/rt/linux-stable-rt/+/refs/heads/v4.14-rt
>> ]

>> (currently at 4.14.109-rt57).

>> So you should contact your raspberrypi linux rt tree clone maintainer and ask
>> him
>> to upgrade, or, as stated in the #error generated by lttng-modules, simply
>> ensure
>> CONFIG_OPTPROBES is unset when you build your kernel. You should ask the
>> raspberrypi community advice on how to ensure this configuration option is not
>> overridden by the raspberrypi build system.

>> Thanks,

>> Mathieu

>>> Thank you so much for your attention and looking forward to your reply soon.

>>> Best Regards,

>>> Nicholas Sadjoli

>>> _______________________________________________
>>> lttng-dev mailing list
>>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]

>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> [ http://www.efficios.com/ | http://www.efficios.com ]

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_777d5491-4554-4af6-89fa-4c98b9177629
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Apr 28, 2019, at 6:11 AM, Nicholas Sadjoli &lt;nick.sadjoli@gm=
ail.com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><bl=
ockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-lef=
t:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;=
font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr">He=
llo again Mathieu,<br><div>I apologize that this is a rather late re-openin=
g of the topic again. However, after consulting with the RPi kernel side, i=
t seems that even after trying to fix for the mentioned issue (i.e. by upgr=
ading to the listed 'fixed' commit), I am still having issues installing th=
e lttng-modules. The following link is the thread that I am having with the=
 RPi kernel github:&nbsp;<a href=3D"https://github.com/raspberrypi/linux/is=
sues/2930" target=3D"_blank">https://github.com/raspberrypi/linux/issues/29=
30</a><br data-mce-bogus=3D"1"></div></div></blockquote><div>As replied by =
"pelwell" on the tracker:<br></div><div><br data-mce-bogus=3D"1"></div><div=
>"I think that the problem isn't with how you applied the back-ported patch=
, but with the detection of the problem by lttng. It seems that the obvious=
 course of action is not sufficient to fix the problem, and I can't spare t=
he time to start building lttng just to debug it for you - sorry."</div><di=
v><br></div><div>Cherry-picking the kernel fix is not sufficient to let the=
 lttng-modules kernel version blacklist mechanism know that<br data-mce-bog=
us=3D"1"></div><div>the kernel indeed has the fix. That's because the black=
list is based on the kernel version ranges, and you did<br data-mce-bogus=
=3D"1"></div><div>not change the kernel version.<br data-mce-bogus=3D"1"></=
div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2p=
x solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:nor=
mal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans=
-serif;font-size:12pt;"><div dir=3D"ltr"><br><div>Even though it is listed =
that version 2.9 seems to be okay, recently I tried to re-install the lttng=
-modules onto another RPi, but this time even with the 'fixed' commit as su=
ggested in the thread, lttng-modules still give the same 'buggy kernel impl=
ementation' error. Please do note that it seems CONFIG_OPTPROBES cannot be =
turned off at all during the kernel build, as it will be overriden by defau=
lt and seems to be integral to the build of the RPi's RT kernel as well, he=
nce this is not really an option either.</div></div></blockquote><div>I my =
prior response, I never recommended to just cherry-pick the fix. I recommen=
ded that<br></div><div>you upgrade your kernel tree to one that contains th=
e fix (and has a version tag which<br data-mce-bogus=3D"1"></div><div>guara=
ntees that).<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></=
div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2p=
x solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:nor=
mal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans=
-serif;font-size:12pt;"><div dir=3D"ltr"><br><div>Is there a specific way o=
n how to upgrade to the mentioned 'fixed' commit without requiring a comple=
te kernel overhaul? I am getting rather desparate as I need this to work fo=
r an upcoming assignment deadline this week. So I'm hoping that there is st=
ill potential solution to this.</div></div></blockquote><div>If you just ch=
erry-picked the fix without changing the kernel version, the lttng-modules =
blacklist will still refuse to compile<br></div><div>against your kernel, b=
ecause the blacklist is based on kernel version range checks.<br data-mce-b=
ogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>There are a few s=
olutions here:<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1">=
</div><div>1) Turn off CONFIG_OPTPROBES with the help of the RPi community,=
<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>2) =
Upgrade your kernel tree to a kernel version that is outside of the blackli=
st range. Not just cherry-picking the specific fix.<br data-mce-bogus=3D"1"=
></div><div><br data-mce-bogus=3D"1"></div><div>3) If you choose to just ch=
erry-pick the fix and not change the kernel version, you<br data-mce-bogus=
=3D"1"></div><div>&nbsp;&nbsp;&nbsp; can force lttng-modules to build again=
st a blacklisted kernel version by removing<br data-mce-bogus=3D"1"></div><=
div>&nbsp;&nbsp;&nbsp; those lines in the lttng-modules source tree:<br dat=
a-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>blacklist/=
kprobes.h:<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></di=
v><div>#if LTTNG_KERNEL_RANGE(4,20,0, 4,20,13) \<br>&nbsp;&nbsp;&nbsp; || L=
TTNG_KERNEL_RANGE(4,19,9, 4,19,26) \<br>&nbsp;&nbsp;&nbsp; || LTTNG_KERNEL_=
RANGE(4,14,87, 4,14,104)<br># if defined(CONFIG_ARM) &amp;&amp; defined(CON=
FIG_OPTPROBES)<br>#&nbsp; error "Your kernel is known to have buggy optimiz=
ed kprobes implementation. Fixed by commit 0ac569bf6a7983c0c5747d6df8db9dc0=
5bc92b6c \"ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction=
\" in Linux. Disable CONFIG_OPTPROBES or upgrade your kernel."<br># endif /=
* #if defined(CONFIG_ARM) &amp;&amp; defined(CONFIG_OPTPROBES) */<br>#endif=
<br><br data-mce-bogus=3D"1"></div><div>This will ensure lttng-modules buil=
ds against your kernel even though it's in the range<br data-mce-bogus=3D"1=
"></div><div>of kernel versions known to cause issues. But considering you =
cherry-picked the<br data-mce-bogus=3D"1"></div><div>fix, then you should b=
e fine.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><=
div>However, doing so removes the "belts and suspenders" we put in place to=
 ensure<br data-mce-bogus=3D"1"></div><div>you don't try to use a bogus kpr=
obes. I therefore recommend solutions 1 or 2 rather<br data-mce-bogus=3D"1"=
></div><div>than 3, but solution 3 might do the trick considering your shor=
t time-frame.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"><=
/div><div>Good luck,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-b=
ogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"b=
order-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;fo=
nt-weight:normal;font-style:normal;text-decoration:none;font-family:Helveti=
ca,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><br><br><div>Best Reg=
ards,</div><br><br><br><div>Nicholas Sadjoli</div></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 15, 2019 at 1=
0:11 PM Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.=
com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><div><div style=3D"fon=
t-family:arial,helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><div><=
span id=3D"gmail-m_9106008346192568069zwchr">----- On Apr 15, 2019, at 7:07=
 AM, Nicholas Sadjoli &lt;<a href=3D"mailto:nick.sadjoli@gmail.com" target=
=3D"_blank">nick.sadjoli@gmail.com</a>&gt; wrote:<br></span></div><div><blo=
ckquote style=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;paddi=
ng-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-deco=
ration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=
=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Dear Lttng dev =
Team,<br><div>I am currently interested in using lttng to measure the inter=
rupt or hardware real-time latencies experienced within my user-space appli=
cations. Unfortunately I have been having issues installing lttng on my Ras=
pberry Pi that is using the PREEMPT_RT patched kernel, version&nbsp;<span s=
tyle=3D"color:rgb(36,41,46);font-family:-apple-system,BlinkMacSystemFont,&q=
uot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple Color Emoji&quot;=
,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;;font-size:14px">4.1=
4.91-rt49-v7+. The problems so far can be seen documented in the RPi Linux =
github forum page here:&nbsp;</span><font face=3D"-apple-system, BlinkMacSy=
stemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe =
UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px"=
><a href=3D"https://github.com/raspberrypi/linux/issues/2930" target=3D"_bl=
ank">https://github.com/raspberrypi/linux/issues/2930</a></span></font><br>=
</div><div><span style=3D"color:rgb(36,41,46);font-family:-apple-system,Bli=
nkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans-serif,&quot;Apple=
 Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;;f=
ont-size:14px"><br></span></div><div><span style=3D"color:rgb(36,41,46);fon=
t-family:-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,Ar=
ial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&qu=
ot;Segoe UI Symbol&quot;;font-size:14px">Initially I was about to just inst=
all the Debian package of the lttng onto the RPi, and just proceeded with t=
he commands '</span><font face=3D"Andale Mono WT, Andale Mono, Bitstream Ve=
ra Sans Mono, Liberation Mono, Nimbus Mono L, Ubuntu Mono, Monaco, Consolas=
, Lucida Console, Lucida Sans Typewriter, Courier New, Courier, monospace" =
color=3D"rgba(0, 0, 0, 0.749019607843137)">sudo apt-get install lttng-modul=
es-dkms liblttng-ust-dev lttng-tools' </font>However, I was unable to use l=
ttng package at all and found out that for the RPi, a build from source is =
necessary for lttng, as described here:&nbsp;<span style=3D"background-colo=
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
ce packages.&nbsp;</span></font></span></div><div><span style=3D"background=
-color:transparent"><font face=3D"-apple-system, BlinkMacSystemFont, Segoe =
UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe =
UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px"><br></span></fo=
nt></span></div><div><span style=3D"background-color:transparent"><font fac=
e=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-se=
rif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e">=
<span style=3D"font-size:14px">Unfortunately when I tried to do this for th=
e lttng-modules package, it instead gave me the following warning in my lat=
est attempt:&nbsp;</span></font></span></div><div><font face=3D"-apple-syst=
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
rror: #error "Your kernel is known to have buggy optimized kprobes implemen=
tation. Fixed by commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c \"ARM: 883=
4/1: Fix: kprobes: optimized kprobes illegal instruction\" in Linux. Disabl=
e CONFIG_OPTPROBES or upgrade your kernel."</span></font></div><div><font f=
ace=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-=
serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e=
"><span style=3D"font-size:14px">&nbsp;#&nbsp; error "Your kernel is known =
to have buggy optimized kprobes implementation. Fixed by commit 0ac569bf6a7=
983c0c5747d6df8db9dc05bc92b6c \"ARM: 8834/1: Fix: kprobes: optimized kprobe=
s illegal instruction\" in Linux. Disable CONFIG_OPTPROBES or upgrade your =
kernel."</span></font></div><div><font face=3D"-apple-system, BlinkMacSyste=
mFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI =
Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px"><b=
r></span></font></div><div><font face=3D"-apple-system, BlinkMacSystemFont,=
 Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji,=
 Segoe UI Symbol" color=3D"#24292e"><span style=3D"font-size:14px">I then t=
ried to turn off the CONFIG_OPTPROBES kernel config, but it seemed to be au=
tomatically overwritten during kernel building and is considered an importa=
nt part of the real-time RPi kernels. Has such problems been reported with =
this version of the PREEMPT_RT kernel in the past (again, the current kerne=
l version that I am using is&nbsp;</span></font><span style=3D"color:rgb(36=
,41,46);font-family:-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,H=
elvetica,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoj=
i&quot;,&quot;Segoe UI Symbol&quot;;font-size:14px">4.14.91-rt49-v7+)? If t=
here are I would like to know how this issue was resolved so that I can pro=
perly build and use the lttng package for my project.</span></div></div></d=
iv></div></div></blockquote><div>Hi Nicholas,<br></div><br><div>It looks li=
ke our lttng-modules kernel version blacklist is acting exactly as it shoul=
d. Looking at this<br></div><div>git tree:<br></div><br><div>git clone <a h=
ref=3D"https://github.com/raspberrypi/linux.git" target=3D"_blank">https://=
github.com/raspberrypi/linux.git</a> -b rpi-4.14.y-rt<br></div><div>I notic=
e that in the git log, we find this bogus commit:<br></div><br><div>commit =
f9e0bc710347fadad55910846ee36f0681d0dca8<br>Author: Kees Cook &lt;<a href=
=3D"mailto:keescook@chromium.org" target=3D"_blank">keescook@chromium.org</=
a>&gt;<br>Date:&nbsp;&nbsp; Tue Oct 30 22:12:56 2018 +0100<br><br>&nbsp;&nb=
sp;&nbsp; ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE<br>&=
nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; commit e46daee53bb50bde38805f1823a=
182979724c229 upstream.<br><br></div><div>But not the fix for it (upstream)=
:<br></div><br><div>commit 0ac569bf6a7983c0c5747d6df8db9dc05bc92b6c<br>Auth=
or: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com"=
 target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<br>Date:&nbsp;&nb=
sp; Tue Feb 5 16:37:40 2019 +0100<br><br>&nbsp;&nbsp;&nbsp; ARM: 8834/1: Fi=
x: kprobes: optimized kprobes illegal instruction<br><br></div><div>So lttn=
g-modules refuses to build against your kernel configuration with CONFIG_OP=
TPROBES=3Dy</div><div>to save you the trouble of having kprobes trigger ill=
egal instruction OOPS at runtime.<br></div><br><div>I'm unusure who maintai=
ns that raspberrypi rt kernel tree. However, the upstream rt tree<br></div>=
<div>for 4.14-rt maintained by Tom Zanussi seems to contain the fix:<br></d=
iv><br><div><a href=3D"https://kernel.googlesource.com/pub/scm/linux/kernel=
/git/rt/linux-stable-rt/+/refs/heads/v4.14-rt" target=3D"_blank">https://ke=
rnel.googlesource.com/pub/scm/linux/kernel/git/rt/linux-stable-rt/+/refs/he=
ads/v4.14-rt</a><br></div><br><div>(currently at 4.14.109-rt57).<br></div><=
br><div>So you should contact your raspberrypi linux rt tree clone maintain=
er and ask him<br></div><div>to upgrade, or, as stated in the #error genera=
ted by lttng-modules, simply ensure<br></div><div>CONFIG_OPTPROBES is unset=
 when you build your kernel. You should ask the<br></div><div>raspberrypi c=
ommunity advice on how to ensure this configuration option is not</div><div=
>overridden by the raspberrypi build system.<br></div><br><div>Thanks,<br><=
/div><br><div>Mathieu</div><br><blockquote style=3D"border-left:2px solid r=
gb(16,16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight=
:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,=
sans-serif;font-size:12pt"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"lt=
r"><div dir=3D"ltr"><div><span style=3D"color:rgb(36,41,46);font-family:-ap=
ple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Helvetica,Arial,sans-ser=
if,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI =
Symbol&quot;;font-size:14px"><br></span></div><div><span style=3D"color:rgb=
(36,41,46);font-family:-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot=
;,Helvetica,Arial,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI E=
moji&quot;,&quot;Segoe UI Symbol&quot;;font-size:14px"><br></span></div><di=
v><font face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Ari=
al, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=
=3D"#24292e"><span style=3D"font-size:14px">Thank you so much for your atte=
ntion and looking forward to your reply soon.</span></font></div><div><font=
 face=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, san=
s-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#2429=
2e"><span style=3D"font-size:14px"><br></span></font></div><div><font face=
=3D"-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-ser=
if, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><=
span style=3D"font-size:14px"><br></span></font></div><div><font face=3D"-a=
pple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Ap=
ple Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span s=
tyle=3D"font-size:14px"><br></span></font></div><div><font face=3D"-apple-s=
ystem, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Co=
lor Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=
=3D"font-size:14px">Best Regards,</span></font></div><div><font face=3D"-ap=
ple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, App=
le Color Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span st=
yle=3D"font-size:14px"><br></span></font></div><div><font face=3D"-apple-sy=
stem, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Col=
or Emoji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=3D=
"font-size:14px"><br></span></font></div><div><font face=3D"-apple-system, =
BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emo=
ji, Segoe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=3D"font-=
size:14px"><br></span></font></div><div><font face=3D"-apple-system, BlinkM=
acSystemFont, Segoe UI, Helvetica, Arial, sans-serif, Apple Color Emoji, Se=
goe UI Emoji, Segoe UI Symbol" color=3D"#24292e"><span style=3D"font-size:1=
4px">Nicholas Sadjoli</span></font></div></div></div></div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-=
dev@lists.lttng.org</a><br><a href=3D"https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-bin/ma=
ilman/listinfo/lttng-dev</a><br></blockquote></div><br><div>-- <br></div><d=
iv>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com=
" target=3D"_blank">http://www.efficios.com</a><br data-mce-bogus=3D"1"></d=
iv></div></div></blockquote></div><br></blockquote></div><div><br></div><di=
v data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>Effic=
iOS Inc.<br>http://www.efficios.com</div></div></body></html>
--=_777d5491-4554-4af6-89fa-4c98b9177629--

--===============5511765844198300550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5511765844198300550==--
