From: "Ionut D." <ionut5001@gmail.com>
Subject: Re: LTTNG on Android ICS
Date: Thu, 23 May 2013 17:40:38 +0300
Message-ID: <CAGNqz8+++M1D6rfDPasSifG-ApEBbDUi6+5y7BcVXHH6w+cF_w__416.627599816088$1369320077$gmane$org@mail.gmail.com>
References: <CAGNqz8L+Kat-C+3RLRknPHOiGXX8_1zYcKCm1j1s5tet3AsEqA@mail.gmail.com>
	<CA+umk=qVWLKUymH9pvY9vSg_Hjf0Ynn1ccP+jyPYjtfvb3H2bg@mail.gmail.com>
	<CAGNqz8L5oWTzq_g4McOWoU4e3TMpJnYDpD_5v9M1oQQaCSzCCA@mail.gmail.com>
	<CAGNqz8L-4YCUAxH+MCib1TWuP7mHH4260jXwmPwrhbwZitdySw@mail.gmail.com>
	<CA+umk=o5GqX8cmufHhR7LUM6HCtRCwyy71WK4+Tc4COV4J-FSQ@mail.gmail.com>
	<CAGNqz8J9zquePawnY==m4xd17cfybseep=0O=tO_VQpxmr7pnQ@mail.gmail.com>
	<CA+umk=rnCFfeg2UY6yd0kegm7MAzPmm79Hei46U4oYskGs5qKg@mail.gmail.com>
	<CAGNqz8+0p5gGptqYaUWfnZYAw-DeM647R-5vMp1Bn+oi5F2Eyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1036221867=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f67.google.com ([209.85.212.67])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <ionut5001@gmail.com>) id 1UfWhA-00059N-49
	for lttng-dev@lists.lttng.org; Thu, 23 May 2013 10:40:44 -0400
Received: by mail-vb0-f67.google.com with SMTP id w15so355713vbf.2
	for <lttng-dev@lists.lttng.org>; Thu, 23 May 2013 07:40:38 -0700 (PDT)
In-Reply-To: <CAGNqz8+0p5gGptqYaUWfnZYAw-DeM647R-5vMp1Bn+oi5F2Eyw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1036221867==
Content-Type: multipart/alternative; boundary=089e0122ef787b6a9d04dd63aac1

--089e0122ef787b6a9d04dd63aac1
Content-Type: text/plain; charset=ISO-8859-1

About the kernel modules. Where should they be located on the target?
Should I have modprobe or insmod it is enough?


On Thu, May 23, 2013 at 2:19 PM, Ionut D. <ionut5001@gmail.com> wrote:

> Sorry for my late response. At the end after different some adds (defines
> in libc) I managed to compile them for ICS with NDK r7c. I was a problem of
> environment.
>
>
> On Tue, May 21, 2013 at 9:26 PM, Pierre-Luc St-Charles <
> pierre-luc.st-charles@polymtl.ca> wrote:
>
>> Well, I cannot get my hands on a R7 NDK this very moment, but I'm
>> surprised there are no grep hits in the ./platforms/android-XX/arch-arm
>> directory; can you verify that the NDK you have does include an ARM
>> architecture sysroot? That's the the one you should be compiling with, and
>> I believe you'll find the asm/unistd.h header there (as there is no 32/64
>> bit difference on Android+ARM yet).
>>
>>
>> On Tue, May 21, 2013 at 11:29 AM, Ionut D. <ionut5001@gmail.com> wrote:
>>
>>> The problem is that I am trying to build it on ICS with NDK r7 and I
>>> tried to build it in the both ways with the ndk and also by creating
>>> Android.mk files and it looks like is not working. I searched with grep
>>> firstly through NDK and second through bionic and these are the results:
>>>
>>> NDK:
>>> #grep -r __NR_splice .
>>> ./platforms/android-9/arch-x86/usr/include/asm/unistd_32.h:#define
>>> __NR_splice 313
>>> ./platforms/android-14/arch-x86/usr/include/asm/unistd_32.h:#define
>>> __NR_splice 313
>>>
>>> bionic:
>>> grep -r __NR_splice bionic
>>> bionic/libc/kernel/arch-sh/asm/unistd_32.h:#define __NR_splice 313
>>> bionic/libc/kernel/arch-sh/asm/unistd_64.h:#define __NR_splice 341
>>> bionic/libc/kernel/arch-x86/asm/unistd_32.h:#define __NR_splice 313
>>>
>>> Looking through results I see that '__NR_splice' it not in unistd.h and
>>> I know this is important.
>>>
>>> Ionut
>>>
>>>
>>> On Tue, May 21, 2013 at 5:15 PM, Pierre-Luc St-Charles <
>>> pierre-luc.st-charles@polymtl.ca> wrote:
>>>
>>>> The first error refers to __NR_splice, which should be declared once
>>>> asm/unistd.h is included; in this case, it is included right above the
>>>> problematic line (src/common/compat/fcntl.h @ L35). Could you verify that
>>>> __NR_splice is defined somewhere in that file? If not, it might be a little
>>>> more problematic.
>>>>
>>>> As for the second error, I believe it is also caused by a missing
>>>> symbol that should be included in asm/signal.h, which is in turn usually
>>>> included via signal.h itself.
>>>>
>>>> Compiling with the NDK (v8, platform 14) is successful here, and I can
>>>> find all these missing symbols in the default system includes there. Are
>>>> you sure you specified the target sysroot when compiling?
>>>>
>>>> -PL
>>>>
>>>>
>>>> On Tue, May 21, 2013 at 6:26 AM, Ionut D. <ionut5001@gmail.com> wrote:
>>>>
>>>>> I tried to compile lttng-tools and at compile time exits with the
>>>>> bellow error. I looked in the sources and it looks like for arm this is not
>>>>> implemented. Do you have any idea about how could this be fixed?
>>>>>
>>>>>
>>>>> In file included from
>>>>> external/lttng-tools/src/common/compat/compat-fcntl.c:19:
>>>>> external/lttng-tools/src/common/compat/../../../src/common/compat/fcntl.h:
>>>>> In function 'splice':
>>>>> external/lttng-tools/src/common/compat/../../../src/common/compat/fcntl.h:44:
>>>>> error: '__NR_splice' undeclared (first use in this function)
>>>>> external/lttng-tools/src/common/compat/../../../src/common/compat/fcntl.h:44:
>>>>> error: (Each undeclared identifier is reported only once
>>>>> external/lttng-tools/src/common/compat/../../../src/common/compat/fcntl.h:44:
>>>>> error: for each function it appears in.)
>>>>> In file included from
>>>>> external/lttng-tools/src/common/compat/compat-fcntl.c:19:
>>>>> external/lttng-tools/src/common/compat/../../../src/common/compat/fcntl.h:48:1:
>>>>> warning: "POSIX_FADV_DONTNEED" redefined
>>>>> In file included from
>>>>> external/lttng-tools/src/common/compat/../../../src/common/compat/fcntl.h:47,
>>>>>                  from
>>>>> external/lttng-tools/src/common/compat/compat-fcntl.c:19:
>>>>> bionic/libc/kernel/common/linux/fadvise.h:24:1: warning: this is the
>>>>> location of the previous definition
>>>>> In file included from bionic/libc/include/sys/select.h:34,
>>>>>                  from bionic/libc/include/unistd.h:34,
>>>>>                  from
>>>>> external/lttng-tools/src/common/compat/compat-fcntl.c:20:
>>>>> external/lttng-tools/src/common/compat/signal.h: At top level:
>>>>> external/lttng-tools/src/common/compat/signal.h:27: error: expected
>>>>> ';', ',' or ')' before '*' token
>>>>> external/lttng-tools/src/common/compat/signal.h:28: error: expected
>>>>> ';', ',' or ')' before '*' token
>>>>> external/lttng-tools/src/common/compat/signal.h:29: error: expected
>>>>> ';', ',' or ')' before '*' token
>>>>> In file included from bionic/libc/include/unistd.h:34,
>>>>>                  from
>>>>> external/lttng-tools/src/common/compat/compat-fcntl.c:20:
>>>>> bionic/libc/include/sys/select.h:42: error: expected ';', ',' or ')'
>>>>> before '*' token
>>>>>
>>>>>
>>>>>
>>>>> On Sat, May 18, 2013 at 10:21 AM, Ionut D. <ionut5001@gmail.com>wrote:
>>>>>
>>>>>> Great informations! I will post back the results.
>>>>>>
>>>>>>
>>>>>> On Fri, May 17, 2013 at 4:47 PM, Pierre-Luc St-Charles <
>>>>>> pierre-luc.st-charles@polymtl.ca> wrote:
>>>>>>
>>>>>>> Alright, small update for all following a quick (non-mailing-list)
>>>>>>> exchange:
>>>>>>>
>>>>>>> We did successfully complete a kernel-tracing port of LTTng for
>>>>>>> Android (somewhat old news), but we are still working on bringing our
>>>>>>> patches back up to date with the current version of the different projects
>>>>>>> (soon-ish still applies here, we're talking days). So far, we dwelled a
>>>>>>> little bit in LTTng-UST, but haven't done much changes, so userspace
>>>>>>> tracing is still not functional. Device that ran kernel traces successfully
>>>>>>> so far were the Nexus S and the Nexus 7 (example Nexus S trace available
>>>>>>> here<https://drive.google.com/folderview?id=0B55Ba7lWTLh4U0hGeTQ4bmRYRjQ&usp=sharing>;
>>>>>>> still not perfect).
>>>>>>>
>>>>>>> Basically, we cross-compiled everything via the Android NDK (no
>>>>>>> Android makefiles involved here), and pushed all required bins to a device
>>>>>>> without having to flash it (unless the default kernel config didn't allow
>>>>>>> tracing -- then we'd have to flash). This approach is not compatible with
>>>>>>> the official Android build system (meaning we wouldn't be able to add it to
>>>>>>> Android like this), but we might eventually get working on the damned
>>>>>>> Android makefiles (they're extremely painful to write, especially since
>>>>>>> LTTng uses Autotools).
>>>>>>>
>>>>>>> The librairies required by LTTng that are not already included in a
>>>>>>> regular Android build (uuid/popt) can actually be found/compiled from the
>>>>>>> official repo, in its 'external' directory (see oprofile and e2fsprog --
>>>>>>> from memory). That might not be the easiest way to get them (full repo
>>>>>>> download is BIG), but compatibility is assured, and you can skip a full
>>>>>>> build by simply making those two individually for your device (if that's
>>>>>>> all you need).
>>>>>>>
>>>>>>> You'll also need your device to be rooted to use LTTng at all; then,
>>>>>>> most initializations are done via scripts (we'll also provide those with
>>>>>>> our patches). We still had some trouble automating everything via daemons,
>>>>>>> so we always ran the sessiond locally (with success).
>>>>>>>
>>>>>>> Major problems we encountered so far were missing posix functions,
>>>>>>> and sysv shared memory. Basically, Android relies on Bionic for its system
>>>>>>> calls and other low-level functions, and since Bionic is pretty
>>>>>>> 'lightweight', they trimmed most of the fat out for performance. We had to
>>>>>>> make some more-or-less sketchy replacements here and there, but everything
>>>>>>> seems to be working decently now.
>>>>>>>
>>>>>>> So, simple 'how do I put LTTng on Android' workflow would be this:
>>>>>>>
>>>>>>>   - Compile modules (using NDK) against device's kernel, making sure
>>>>>>> its config is appropriate, ship them over via ADB
>>>>>>>
>>>>>>>   - Compile required external libraries (using repo build system)
>>>>>>> for the device, ship them over via ADB
>>>>>>>
>>>>>>>   - Patch up LTTng-* (soon-ish! I could send you the outdated
>>>>>>> patches right now if you're interested though, they might be a month behind
>>>>>>> or so on the current trunks)
>>>>>>>
>>>>>>>   - Cross-compile LTTng-* for the device (using NDK), ship binaries
>>>>>>> over via ADB
>>>>>>>
>>>>>>> Then, on the device, start up the sessiond manually & start tracing.
>>>>>>>
>>>>>>>
>>>>>>> I think I went over everything, but if there's a part that's still
>>>>>>> cloudy, don't hesitate.
>>>>>>>
>>>>>>>
>>>>>>> -PL
>>>>>>>
>>>>>>>
>>>>>>> On May 17, 2013 1:32 AM, "Ionut D." <ionut5001@gmail.com> wrote:
>>>>>>>
>>>>>>>> Hello all,
>>>>>>>>
>>>>>>>> Recently I started to integrate LTTNG in Android ICS by compiling
>>>>>>>> each package, each dependency, by using the Android build system. It is a
>>>>>>>> lot of work because I met different problems and to be sincere, I do not
>>>>>>>> know if at the end will work and I do not know how much I will need to
>>>>>>>> modify the sources in order to work.
>>>>>>>>
>>>>>>>> My questions are about this integration. I mention that I read a
>>>>>>>> lot of discussions about this on Internet, on this mailing list, but the
>>>>>>>> things are still not very clear for me.
>>>>>>>>
>>>>>>>> It is ok? what I am trying to do ? to integrate and build by using
>>>>>>>> the Android build system.
>>>>>>>> Could you give me some guidelines, indications about how I should
>>>>>>>> proceed, maybe a tutorial or maybe some android make files/patches that
>>>>>>>> would help me to see how the job must be done and if I am doing it right ?
>>>>>>>>
>>>>>>>> Until now I managed to build lttng-modules, liburcu, libuuid from
>>>>>>>> util-linux and configure lttng-ust by using the android toolchain for arm.
>>>>>>>> I got a lot of errors but until now I managed to configure/make these
>>>>>>>> packages.
>>>>>>>>
>>>>>>>> I mention that I am trying to build lttng 2.x on ICS 4.0.3.
>>>>>>>>
>>>>>>>> Would be great if you will give me a tutorial about how to do it.
>>>>>>>>
>>>>>>>> Ionut
>>>>>>>>
>>>>>>>> _______________________________________________
>>>>>>>> lttng-dev mailing list
>>>>>>>> lttng-dev@lists.lttng.org
>>>>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>>>>>
>>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
>

--089e0122ef787b6a9d04dd63aac1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">About the kernel modules. Where should they be located on =
the target? Should I have modprobe or insmod it is enough?</div><div class=
=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Thu, May 23, 2013 at=
 2:19 PM, Ionut D. <span dir=3D"ltr">&lt;<a href=3D"mailto:ionut5001@gmail.=
com" target=3D"_blank">ionut5001@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">Sorry for my late response.=
 At the end after different some adds (defines in libc) I managed to compil=
e them for ICS with NDK r7c. I was a problem of environment.</div>
<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">
On Tue, May 21, 2013 at 9:26 PM, Pierre-Luc St-Charles <span dir=3D"ltr">&l=
t;<a href=3D"mailto:pierre-luc.st-charles@polymtl.ca" target=3D"_blank">pie=
rre-luc.st-charles@polymtl.ca</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">

<div dir=3D"ltr">Well, I cannot get my hands on a R7 NDK this very moment, =
but I&#39;m surprised there are no grep hits in the ./platforms/android-XX/=
arch-arm directory; can you verify that the NDK you have does include an AR=
M architecture sysroot? That&#39;s the the one you should be compiling with=
, and I believe you&#39;ll find the asm/unistd.h header there (as there is =
no 32/64 bit difference on Android+ARM yet).</div>


<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Tue, May 2=
1, 2013 at 11:29 AM, Ionut D. <span dir=3D"ltr">&lt;<a href=3D"mailto:ionut=
5001@gmail.com" target=3D"_blank">ionut5001@gmail.com</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">


<div><div dir=3D"ltr"><span style=3D"font-family:arial,sans-serif;font-size=
:13px">The problem is that I am trying to build it on ICS with NDK r7 and I=
 tried to build it in the both ways with the ndk and also by creating Andro=
id.mk files and it looks like is not working. I searched with grep firstly =
through NDK and second through bionic and these are the results:</span><div=
 style=3D"font-family:arial,sans-serif;font-size:13px">



<br></div><div style=3D"font-family:arial,sans-serif;font-size:13px">NDK:</=
div><div style=3D"font-family:arial,sans-serif;font-size:13px"><div>#grep -=
r __NR_splice .</div><div>./platforms/android-9/arch-x86/usr/include/asm/un=
istd_32.h:#define __NR_splice 313</div>



<div>./platforms/android-14/arch-x86/usr/include/asm/unistd_32.h:#define __=
NR_splice 313</div><div><br></div><div>bionic:</div><div><div>grep -r __NR_=
splice bionic=A0</div><div>bionic/libc/kernel/arch-sh/asm/unistd_32.h:#defi=
ne __NR_splice 313</div>



<div>bionic/libc/kernel/arch-sh/asm/unistd_64.h:#define __NR_splice 341</di=
v><div>bionic/libc/kernel/arch-x86/asm/unistd_32.h:#define __NR_splice 313<=
/div><div><br></div><div>Looking through results I see that &#39;__NR_splic=
e&#39; it not in unistd.h and I know this is important.</div>



<div><br></div><div>Ionut</div></div></div></div></div><div><div><div class=
=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Tue, May 21, 2013 at=
 5:15 PM, Pierre-Luc St-Charles <span dir=3D"ltr">&lt;<a href=3D"mailto:pie=
rre-luc.st-charles@polymtl.ca" target=3D"_blank">pierre-luc.st-charles@poly=
mtl.ca</a>&gt;</span> wrote:<br>



<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>The first error refers=
 to __NR_splice, which should be declared once asm/unistd.h is included; in=
 this case, it is included right above the problematic line (src/common/com=
pat/fcntl.h @ L35). Could you verify that __NR_splice is defined somewhere =
in that file? If not, it might be a little more problematic.<br>




</div><div><br></div><div>As for the second error, I believe it is also cau=
sed by a missing symbol that should be included in asm/signal.h, which is i=
n turn usually included via signal.h itself.</div><div><br>
</div><div>Compiling with the NDK (v8, platform 14) is successful here, and=
 I can find all these missing symbols in the default system includes there.=
 Are you sure you specified the target sysroot when compiling?</div>
<div><br></div><div>-PL</div></div><div class=3D"gmail_extra"><br><br><div =
class=3D"gmail_quote">On Tue, May 21, 2013 at 6:26 AM, Ionut D. <span dir=
=3D"ltr">&lt;<a href=3D"mailto:ionut5001@gmail.com" target=3D"_blank">ionut=
5001@gmail.com</a>&gt;</span> wrote:<br>




<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>I tried to compile ltt=
ng-tools and at compile time exits with the bellow error. I looked in the s=
ources and it looks like for arm this is not implemented. Do you have any i=
dea about how could this be fixed?</div>





<div><br></div><div><br></div><div>In file included from external/lttng-too=
ls/src/common/compat/compat-fcntl.c:19:</div><div>external/lttng-tools/src/=
common/compat/../../../src/common/compat/fcntl.h: In function &#39;splice&#=
39;:</div>





<div>external/lttng-tools/src/common/compat/../../../src/common/compat/fcnt=
l.h:44: error: &#39;__NR_splice&#39; undeclared (first use in this function=
)</div><div>external/lttng-tools/src/common/compat/../../../src/common/comp=
at/fcntl.h:44: error: (Each undeclared identifier is reported only once</di=
v>





<div>external/lttng-tools/src/common/compat/../../../src/common/compat/fcnt=
l.h:44: error: for each function it appears in.)</div><div>In file included=
 from external/lttng-tools/src/common/compat/compat-fcntl.c:19:</div><div>





external/lttng-tools/src/common/compat/../../../src/common/compat/fcntl.h:4=
8:1: warning: &quot;POSIX_FADV_DONTNEED&quot; redefined</div><div>In file i=
ncluded from external/lttng-tools/src/common/compat/../../../src/common/com=
pat/fcntl.h:47,</div>





<div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0from external/lttng-tools/src/commo=
n/compat/compat-fcntl.c:19:</div><div>bionic/libc/kernel/common/linux/fadvi=
se.h:24:1: warning: this is the location of the previous definition</div><d=
iv>In file included from bionic/libc/include/sys/select.h:34,</div>





<div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0from bionic/libc/include/unistd.h:3=
4,</div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0from external/lttng-tools/s=
rc/common/compat/compat-fcntl.c:20:</div><div>external/lttng-tools/src/comm=
on/compat/signal.h: At top level:</div>





<div>external/lttng-tools/src/common/compat/signal.h:27: error: expected &#=
39;;&#39;, &#39;,&#39; or &#39;)&#39; before &#39;*&#39; token</div><div>ex=
ternal/lttng-tools/src/common/compat/signal.h:28: error: expected &#39;;&#3=
9;, &#39;,&#39; or &#39;)&#39; before &#39;*&#39; token</div>





<div>external/lttng-tools/src/common/compat/signal.h:29: error: expected &#=
39;;&#39;, &#39;,&#39; or &#39;)&#39; before &#39;*&#39; token</div><div>In=
 file included from bionic/libc/include/unistd.h:34,</div><div>=A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0from external/lttng-tools/src/common/compat/compat-f=
cntl.c:20:</div>





<div>bionic/libc/include/sys/select.h:42: error: expected &#39;;&#39;, &#39=
;,&#39; or &#39;)&#39; before &#39;*&#39; token</div><div><br></div></div><=
div><div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">
On Sat, May 18, 2013 at 10:21 AM, Ionut D. <span dir=3D"ltr">&lt;<a href=3D=
"mailto:ionut5001@gmail.com" target=3D"_blank">ionut5001@gmail.com</a>&gt;<=
/span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">Great informations! I will =
post back the results.</div><div class=3D"gmail_extra"><br><br><div class=
=3D"gmail_quote">





On Fri, May 17, 2013 at 4:47 PM, Pierre-Luc St-Charles <span dir=3D"ltr">&l=
t;<a href=3D"mailto:pierre-luc.st-charles@polymtl.ca" target=3D"_blank">pie=
rre-luc.st-charles@polymtl.ca</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr"><p dir=3D"ltr">Alright, sma=
ll update for all following a quick (non-mailing-list) exchange:</p>
<p dir=3D"ltr">We did successfully complete a kernel-tracing port of LTTng =
for Android (somewhat old news), but we are still working on bringing our p=
atches back up to date with the current version of the different projects (=
soon-ish still applies here, we&#39;re talking days). So far, we dwelled a =
little bit in LTTng-UST, but haven&#39;t done much changes, so userspace tr=
acing is still not functional. Device that ran kernel traces successfully s=
o far were the Nexus S and the Nexus 7 (example Nexus S trace available <a =
href=3D"https://drive.google.com/folderview?id=3D0B55Ba7lWTLh4U0hGeTQ4bmRYR=
jQ&amp;usp=3Dsharing" target=3D"_blank">here</a>; still not perfect).</p>










<p dir=3D"ltr">Basically, we cross-compiled everything via the Android NDK =
(no Android makefiles involved here), and pushed all required bins to a dev=
ice without having to flash it (unless the default kernel config didn&#39;t=
 allow tracing -- then we&#39;d have to flash). This approach is not compat=
ible with the official Android build system (meaning we wouldn&#39;t be abl=
e to add it to Android like this), but we might eventually get working on t=
he damned Android makefiles (they&#39;re extremely painful to write, especi=
ally since LTTng uses Autotools).</p>










<p dir=3D"ltr">The librairies required by LTTng that are not already includ=
ed in a regular Android build (uuid/popt) can actually be found/compiled fr=
om the official repo, in its &#39;external&#39; directory (see oprofile and=
 e2fsprog -- from memory). That might not be the easiest way to get them (f=
ull repo download is BIG), but compatibility is assured, and you can skip a=
 full build by simply making those two individually for your device (if tha=
t&#39;s all you need).</p>










<p dir=3D"ltr">You&#39;ll also need your device to be rooted to use LTTng a=
t all; then, most initializations are done via scripts (we&#39;ll also prov=
ide those with our patches). We still had some trouble automating everythin=
g via daemons, so we always ran the sessiond locally (with success).</p>







<p>Major problems we encountered so far were missing posix functions, and s=
ysv shared memory. Basically, Android relies on Bionic for its system calls=
 and other low-level functions, and since Bionic is pretty &#39;lightweight=
&#39;, they trimmed most of the fat out for performance. We had to make som=
e more-or-less sketchy replacements here and there, but everything seems to=
 be working decently now.</p>







<p>So, simple &#39;how do I put LTTng on Android&#39; workflow would be thi=
s:</p><p>=A0 - Compile modules=A0(using NDK)=A0against device&#39;s kernel,=
 making sure its config is appropriate, ship them over via ADB</p>
<p>=A0 - Compile required external libraries (using repo build system) for =
the device, ship them over via ADB</p><p>=A0 - Patch up LTTng-* (soon-ish! =
I could send you the outdated patches right now if you&#39;re interested th=
ough, they might be a month behind or so on the current trunks)</p>







<p>=A0 - Cross-compile LTTng-* for the device (using NDK), ship binaries ov=
er via ADB</p><p>Then, on the device, start up the sessiond manually &amp; =
start tracing.</p><p><br></p><p>I think I went over everything, but if ther=
e&#39;s a part that&#39;s still cloudy, don&#39;t hesitate.</p>







<p><br></p><p>-PL</p><p>=A0=A0</p>


<div class=3D"gmail_quote">On May 17, 2013 1:32 AM, &quot;Ionut D.&quot; &l=
t;<a href=3D"mailto:ionut5001@gmail.com" target=3D"_blank">ionut5001@gmail.=
com</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color=
:rgb(204,204,204);border-left-style:solid;padding-left:1ex">









<div dir=3D"ltr"><div>Hello all,</div><div><br></div><div>Recently I starte=
d to integrate LTTNG in Android ICS by compiling each package, each depende=
ncy, by using the Android build system. It is a lot of work because I met d=
ifferent problems and to be sincere,  I do not know if at the end will work=
 and I do not know how much I will need to modify the sources in order to w=
ork.<br>










</div><br>My questions are about this integration. I mention that I read a =
lot of discussions about this on Internet, on this mailing list, but the th=
ings are still not very clear for me.<br><br>It is ok? what I am trying to =
do ? to integrate and build by using the Android build system.<br>










Could you give me some guidelines, indications about how I should proceed, =
maybe a tutorial or maybe some android make files/patches that would help m=
e to see how the job must be done and if I am doing it right ?<br><br>









Until now I managed to build lttng-modules, liburcu, libuuid from util-linu=
x and configure lttng-ust by using the android toolchain for arm. I got a l=
ot of errors but until now I managed to configure/make these packages.<br>










<br>I mention that I am trying to build lttng 2.x on ICS 4.0.3.<br><br><div=
>Would be great if you will give me a tutorial about how to do it.</div><di=
v><br></div><div>Ionut</div></div>
<br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div>
</div>
</blockquote></div><br></div>
</blockquote></div><br></div>
</div></div></blockquote></div><br></div>
</blockquote></div><br></div>
</div></div></blockquote></div><br></div>
</blockquote></div><br></div>
</blockquote></div><br></div>

--089e0122ef787b6a9d04dd63aac1--


--===============1036221867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1036221867==--
