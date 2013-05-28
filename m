From: "Ionut D." <ionut5001@gmail.com>
Subject: Re: LTTNG on Android ICS
Date: Tue, 28 May 2013 15:18:47 +0300
Message-ID: <CAGNqz8LqyHSUZGA0z_NWnERAQ6uJUybk1Ms2=HTo8uHsrND1CA__20635.9726064422$1369743580$gmane$org@mail.gmail.com>
References: <CAGNqz8L+Kat-C+3RLRknPHOiGXX8_1zYcKCm1j1s5tet3AsEqA@mail.gmail.com>
	<CA+umk=qVWLKUymH9pvY9vSg_Hjf0Ynn1ccP+jyPYjtfvb3H2bg@mail.gmail.com>
	<CAGNqz8L5oWTzq_g4McOWoU4e3TMpJnYDpD_5v9M1oQQaCSzCCA@mail.gmail.com>
	<CAGNqz8L-4YCUAxH+MCib1TWuP7mHH4260jXwmPwrhbwZitdySw@mail.gmail.com>
	<CA+umk=o5GqX8cmufHhR7LUM6HCtRCwyy71WK4+Tc4COV4J-FSQ@mail.gmail.com>
	<CAGNqz8J9zquePawnY==m4xd17cfybseep=0O=tO_VQpxmr7pnQ@mail.gmail.com>
	<CA+umk=rnCFfeg2UY6yd0kegm7MAzPmm79Hei46U4oYskGs5qKg@mail.gmail.com>
	<CAGNqz8+0p5gGptqYaUWfnZYAw-DeM647R-5vMp1Bn+oi5F2Eyw@mail.gmail.com>
	<CAGNqz8+++M1D6rfDPasSifG-ApEBbDUi6+5y7BcVXHH6w+cF_w@mail.gmail.com>
	<CACnpWGSpcdOp0Y=5Yj_zAms2rOwP2Uai3HUZtzwRp1vYMeoY5g@mail.gmail.com>
	<CAGNqz8LgNvc1KUeNKRi1rWBQg+qENJNmumPGA9Zc+yeHYQi_4Q@mail.gmail.com>
	<CAGNqz8+Lq4GvD=nPosEj5+ppTfa+jXputMQcLrwnhs1s1LuQPQ@mail.gmail.com>
	<CA+umk=p4R8tDfBXKRQ7O8EoafBu6R1TH7KnskP1QGnOJ_f+kjA@mail.gmail.com>
	<CAC6yHM7H654Ox3PYPqLPNcfU-g=pENNzF-C5KBkRiA62GYpbug@mail.gmail.com>
	<CA+umk=qqfkcQyD1f8NvL=N0Vd=C2B_pdjh+o-r=Hoq7Z_=vThw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0226949901=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f180.google.com ([209.85.128.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <ionut5001@gmail.com>) id 1UhIrd-0000SY-KI
	for lttng-dev@lists.lttng.org; Tue, 28 May 2013 08:18:53 -0400
Received: by mail-ve0-f180.google.com with SMTP id pa12so872612veb.11
	for <lttng-dev@lists.lttng.org>; Tue, 28 May 2013 05:18:48 -0700 (PDT)
In-Reply-To: <CA+umk=qqfkcQyD1f8NvL=N0Vd=C2B_pdjh+o-r=Hoq7Z_=vThw@mail.gmail.com>
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

--===============0226949901==
Content-Type: multipart/alternative; boundary=089e0122ef786a079804ddc64470

--089e0122ef786a079804ddc64470
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

lttng-relayd is functional? Because I want to start it and fails with:

DEBUG3 [3661/3661]: URI string: tcp://0.0.0.0:5342 (in uri_parse() at
uri.c:250)
DEBUG3 [3661/3661]: URI dtype: 1, proto: 1, host: 0.0.0.0, subdir: , ctrl:
5342, data: 0 (in uri_parse() at uri.c:464)
DEBUG3 [3661/3661]: URI string: tcp://0.0.0.0:5343 (in uri_parse() at
uri.c:250)
DEBUG3 [3661/3661]: URI dtype: 1, proto: 1, host: 0.0.0.0, subdir: , ctrl:
5343, data: 0 (in uri_parse() at uri.c:464)
DEBUG1 [3661/3661]: Signal handler set for SIGTERM, SIGPIPE and SIGINT (in
set_signal_handler() at main.c:346)
DEBUG1 [3661/3661]: epoll set max size is 76382 (in
compat_epoll_set_max_size() at compat-epoll.c:270)
DEBUG1 [3661/3662]: [thread] Relay dispatcher started (in
relay_thread_dispatcher() at main.c:646)
DEBUG1 [3661/3662]: Futex n to 1 prepare done (in futex_nto1_prepare() at
futex.c:75)
DEBUG1 [3661/3662]: Woken up but nothing in the relay command queue (in
relay_thread_dispatcher() at main.c:656)
DEBUG1 [3661/3664]: [thread] Relay listener started (in
relay_thread_listener() at main.c:484)
DEBUG1 [3661/3663]: [thread] Relay worker started (in relay_thread_worker()
at main.c:1772)
DEBUG1 [3661/3664]: Listening on sock 7 (in relay_init_sock() at main.c:430=
)
assertion "URCU_TLS(rcu_reader).need_mb =3D=3D 0" failed: file "urcu.c", li=
ne
435, function "rcu_register_thread_mb"
DEBUG1 [3661/3664]: Listening on sock 9 (in relay_init_sock() at main.c:430=
)
DEBUG1 [3661/3664]: Listener accepting connections (in
relay_thread_listener() at main.c:517)
Segmentation fault



On Fri, May 24, 2013 at 11:36 PM, Pierre-Luc St-Charles <
pierre-luc.st-charles@polymtl.ca> wrote:

> Good news: you (most likely) won't need to recompile the whole platform t=
o
> fix the problem!
>
> I think we bumped in a similar bitter-sweet-awful error a while back:
> after some hefty searches, we found it might have something to do with th=
e
> Android build system globally 'fortifying' the sources against unsafe
> functions when compiling some of the most recent versions of the platform=
.
> I believe adding -D_FORTIFY_SOURCE=3D0 to the CPPFLAGS when building the
> tools solved it for us.
>
> -PL
>
>
> On Fri, May 24, 2013 at 3:04 PM, Francis Giraldeau <
> francis.giraldeau@gmail.com> wrote:
>
>> Hi,
>>
>> I got some problem compiling required libraries for lttng-tools. I did a
>> full android build within repo:
>>
>> $ source build/envsetup.sh
>> $ lunch # with full_maguro-eng
>> $ m
>>
>> Build is fine, but when trying to run configure in lttng-tools, it can't
>> find liboprofile_popt. Here is the error message in config.log:
>>
>> /home/francis/android/android-ndk-r8e/toolchains/arm-linux-androideabi-4=
.6/prebuilt/linux-x86_64/bin/../lib/gcc/arm-linux-androideabi/4.6/../../../=
../arm-linux-androideabi/bin/ld:
>> /home/francis/android/repo/out/target/product/maguro/obj/STATIC_LIBRARIE=
S/liboprofile_popt_intermediates/liboprofile_popt.a(popthelp.o):
>> in function singleOptionHelp.isra.4:bionic/libc/include/stdio.h:483: err=
or:
>> undefined reference to '__sprintf_chk'
>>
>> It seems that only the static library of liboprofile_popt is compiled.
>>
>> The symbol is defined in libc.a and libc.so:
>>
>> $ nm
>> ./out/target/product/maguro/obj/SHARED_LIBRARIES/libc_intermediates/LINK=
ED/libc.so
>> | grep -E "__strlen_chk|__sprintf_chk"
>> 0001395d T __sprintf_chk
>> 00012df1 T __strlen_chk
>>
>> I tried to compile the configtest.c file by hand and it worked, so it
>> really seems to be some kind of environment variable that make it fail.
>>
>> For the people who managed to do the configure, what arguments should be
>> supplied to configure? Or maybe it's my android build that is incomplete=
?
>> Should I build sub-directories in addition to the build in the root andr=
oid
>> repo sources?
>>
>> Cheers!
>>
>> Francis
>>
>>
>> 2013/5/24 Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>
>>
>>> The required kernel configuration options for the modules are listed in
>>> the lttng-module README file, located in its project root directory. So=
me
>>> of the 'optional' options also listed there are simply not supported by
>>> 3.0.x ARM kernels (such as HAVE_SYSCALL_TRACEPOINTS), so you might be
>>> missing some modules compared to what you would get on a (x86 arch w/
>>> recent kernel) platform.
>>>
>>> You can find more information on syscall tracing on ARM here:
>>> http://comments.gmane.org/gmane.linux.kernel.tracing.lttng.devel/5086
>>>
>>>
>>> On Fri, May 24, 2013 at 6:44 AM, Ionut D. <ionut5001@gmail.com> wrote:
>>>
>>>> I managed to fix it. It was not finding `lttng-consumerd`, I fixed it
>>>> by configuring the package with the right path. But, about the kernel
>>>> modules the question is still pertinent. What options should I check
>>>> in the kernel configuration? I saw that in my case not all the lttng k=
ernel
>>>> modules have been compiled.
>>>>
>>>>
>>>> On Fri, May 24, 2013 at 11:07 AM, Ionut D. <ionut5001@gmail.com> wrote=
:
>>>>
>>>>> Hello,
>>>>>
>>>>> Thank you for the slides. I manged to build the kernel modules and I
>>>>> insmod them manually. On the device I copied in /data/lttng following
>>>>> binaries `lttng`, `lttng-relayd` and `lttng-sessiond`. If I execute
>>>>> `./lttng list -k` it shows me a list of available kernel events. I cr=
eate a
>>>>> session called mysession with `./lttng create mysession` and I enable
>>>>> tracing on all the event with `./lttng enable-event -a -k`. But here =
starts
>>>>> my problem.
>>>>>
>>>>> The output of the last command is the following:
>>>>>
>>>>> root@android:/data/lttng # ./lttng enable-event -a -k
>>>>> PERROR [3681/3681]: kernel start consumer exec: (null) (in
>>>>> spawn_consumerd() at main.c:2007)
>>>>> Error: Condition timed out. The consumer thread was never ready.
>>>>> Killing it
>>>>> Warning: Using pthread_kill as pthread_cancel is missing on the
>>>>> current platform
>>>>> PERROR [3608/3658]: write poll pipe: (null) (in notify_thread_pipe()
>>>>> at utils.c:43)
>>>>> Error: Events: Fatal error of the session daemon (channel channel0,
>>>>> session mysession)
>>>>>
>>>>> Do you have any idea about what could be wrong? What options should I
>>>>> check in the kernel configuration? (I checked all that is under Traci=
ng)
>>>>>
>>>>> --Ionut
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> On Thu, May 23, 2013 at 6:09 PM, Charles Bri=E8re <
>>>>> charles.briere@polymtl.ca> wrote:
>>>>>
>>>>>> Module location doesn't really matter, we used to push them to
>>>>>> /data/... or /sdcard/... .
>>>>>>
>>>>>>  Modprobe doesn't exists on Android so you'll need to use insmod. We
>>>>>> used this script<https://docs.google.com/file/d/0B56W2viIJ4oqOU1qTHJ=
ZY0V2MzQ/edit>in order to compile, push to device and load modules.
>>>>>>
>>>>>> We also made a presentation you might be interested in that can be
>>>>>> viewed on
>>>>>> https://docs.google.com/presentation/d/14lte2AchEAyxMk3WSQ53SdbBm2tf=
mABBFQojuUhxg7Y/pub?start=3Dfalse&loop=3Dfalse&delayms=3D3000
>>>>>>
>>>>>>
>>>>>> On Thu, May 23, 2013 at 10:40 AM, Ionut D. <ionut5001@gmail.com>wrot=
e:
>>>>>>
>>>>>>> About the kernel modules. Where should they be located on the
>>>>>>> target? Should I have modprobe or insmod it is enough?
>>>>>>>
>>>>>>>
>>>>>>> On Thu, May 23, 2013 at 2:19 PM, Ionut D. <ionut5001@gmail.com>wrot=
e:
>>>>>>>
>>>>>>>> Sorry for my late response. At the end after different some adds
>>>>>>>> (defines in libc) I managed to compile them for ICS with NDK r7c. =
I was a
>>>>>>>> problem of environment.
>>>>>>>>
>>>>>>>>
>>>>>>>> On Tue, May 21, 2013 at 9:26 PM, Pierre-Luc St-Charles <
>>>>>>>> pierre-luc.st-charles@polymtl.ca> wrote:
>>>>>>>>
>>>>>>>>> Well, I cannot get my hands on a R7 NDK this very moment, but I'm
>>>>>>>>> surprised there are no grep hits in the ./platforms/android-XX/ar=
ch-arm
>>>>>>>>> directory; can you verify that the NDK you have does include an A=
RM
>>>>>>>>> architecture sysroot? That's the the one you should be compiling =
with, and
>>>>>>>>> I believe you'll find the asm/unistd.h header there (as there is =
no 32/64
>>>>>>>>> bit difference on Android+ARM yet).
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On Tue, May 21, 2013 at 11:29 AM, Ionut D. <ionut5001@gmail.com>w=
rote:
>>>>>>>>>
>>>>>>>>>> The problem is that I am trying to build it on ICS with NDK r7
>>>>>>>>>> and I tried to build it in the both ways with the ndk and also b=
y creating
>>>>>>>>>> Android.mk files and it looks like is not working. I searched wi=
th grep
>>>>>>>>>> firstly through NDK and second through bionic and these are the =
results:
>>>>>>>>>>
>>>>>>>>>> NDK:
>>>>>>>>>> #grep -r __NR_splice .
>>>>>>>>>> ./platforms/android-9/arch-x86/usr/include/asm/unistd_32.h:#defi=
ne
>>>>>>>>>> __NR_splice 313
>>>>>>>>>> ./platforms/android-14/arch-x86/usr/include/asm/unistd_32.h:#def=
ine
>>>>>>>>>> __NR_splice 313
>>>>>>>>>>
>>>>>>>>>> bionic:
>>>>>>>>>> grep -r __NR_splice bionic
>>>>>>>>>> bionic/libc/kernel/arch-sh/asm/unistd_32.h:#define __NR_splice 3=
13
>>>>>>>>>> bionic/libc/kernel/arch-sh/asm/unistd_64.h:#define __NR_splice 3=
41
>>>>>>>>>> bionic/libc/kernel/arch-x86/asm/unistd_32.h:#define __NR_splice
>>>>>>>>>> 313
>>>>>>>>>>
>>>>>>>>>> Looking through results I see that '__NR_splice' it not in
>>>>>>>>>> unistd.h and I know this is important.
>>>>>>>>>>
>>>>>>>>>> Ionut
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On Tue, May 21, 2013 at 5:15 PM, Pierre-Luc St-Charles <
>>>>>>>>>> pierre-luc.st-charles@polymtl.ca> wrote:
>>>>>>>>>>
>>>>>>>>>>> The first error refers to __NR_splice, which should be declared
>>>>>>>>>>> once asm/unistd.h is included; in this case, it is included rig=
ht above the
>>>>>>>>>>> problematic line (src/common/compat/fcntl.h @ L35). Could you v=
erify that
>>>>>>>>>>> __NR_splice is defined somewhere in that file? If not, it might=
 be a little
>>>>>>>>>>> more problematic.
>>>>>>>>>>>
>>>>>>>>>>> As for the second error, I believe it is also caused by a
>>>>>>>>>>> missing symbol that should be included in asm/signal.h, which i=
s in turn
>>>>>>>>>>> usually included via signal.h itself.
>>>>>>>>>>>
>>>>>>>>>>> Compiling with the NDK (v8, platform 14) is successful here, an=
d
>>>>>>>>>>> I can find all these missing symbols in the default system incl=
udes there.
>>>>>>>>>>> Are you sure you specified the target sysroot when compiling?
>>>>>>>>>>>
>>>>>>>>>>> -PL
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On Tue, May 21, 2013 at 6:26 AM, Ionut D. <ionut5001@gmail.com>=
wrote:
>>>>>>>>>>>
>>>>>>>>>>>> I tried to compile lttng-tools and at compile time exits with
>>>>>>>>>>>> the bellow error. I looked in the sources and it looks like fo=
r arm this is
>>>>>>>>>>>> not implemented. Do you have any idea about how could this be =
fixed?
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> In file included from
>>>>>>>>>>>> external/lttng-tools/src/common/compat/compat-fcntl.c:19:
>>>>>>>>>>>> external/lttng-tools/src/common/compat/../../../src/common/com=
pat/fcntl.h:
>>>>>>>>>>>> In function 'splice':
>>>>>>>>>>>> external/lttng-tools/src/common/compat/../../../src/common/com=
pat/fcntl.h:44:
>>>>>>>>>>>> error: '__NR_splice' undeclared (first use in this function)
>>>>>>>>>>>> external/lttng-tools/src/common/compat/../../../src/common/com=
pat/fcntl.h:44:
>>>>>>>>>>>> error: (Each undeclared identifier is reported only once
>>>>>>>>>>>> external/lttng-tools/src/common/compat/../../../src/common/com=
pat/fcntl.h:44:
>>>>>>>>>>>> error: for each function it appears in.)
>>>>>>>>>>>> In file included from
>>>>>>>>>>>> external/lttng-tools/src/common/compat/compat-fcntl.c:19:
>>>>>>>>>>>> external/lttng-tools/src/common/compat/../../../src/common/com=
pat/fcntl.h:48:1:
>>>>>>>>>>>> warning: "POSIX_FADV_DONTNEED" redefined
>>>>>>>>>>>> In file included from
>>>>>>>>>>>> external/lttng-tools/src/common/compat/../../../src/common/com=
pat/fcntl.h:47,
>>>>>>>>>>>>                  from
>>>>>>>>>>>> external/lttng-tools/src/common/compat/compat-fcntl.c:19:
>>>>>>>>>>>> bionic/libc/kernel/common/linux/fadvise.h:24:1: warning: this
>>>>>>>>>>>> is the location of the previous definition
>>>>>>>>>>>> In file included from bionic/libc/include/sys/select.h:34,
>>>>>>>>>>>>                  from bionic/libc/include/unistd.h:34,
>>>>>>>>>>>>                  from
>>>>>>>>>>>> external/lttng-tools/src/common/compat/compat-fcntl.c:20:
>>>>>>>>>>>> external/lttng-tools/src/common/compat/signal.h: At top level:
>>>>>>>>>>>> external/lttng-tools/src/common/compat/signal.h:27: error:
>>>>>>>>>>>> expected ';', ',' or ')' before '*' token
>>>>>>>>>>>> external/lttng-tools/src/common/compat/signal.h:28: error:
>>>>>>>>>>>> expected ';', ',' or ')' before '*' token
>>>>>>>>>>>> external/lttng-tools/src/common/compat/signal.h:29: error:
>>>>>>>>>>>> expected ';', ',' or ')' before '*' token
>>>>>>>>>>>> In file included from bionic/libc/include/unistd.h:34,
>>>>>>>>>>>>                  from
>>>>>>>>>>>> external/lttng-tools/src/common/compat/compat-fcntl.c:20:
>>>>>>>>>>>> bionic/libc/include/sys/select.h:42: error: expected ';', ','
>>>>>>>>>>>> or ')' before '*' token
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> On Sat, May 18, 2013 at 10:21 AM, Ionut D. <ionut5001@gmail.co=
m
>>>>>>>>>>>> > wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>> Great informations! I will post back the results.
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Fri, May 17, 2013 at 4:47 PM, Pierre-Luc St-Charles <
>>>>>>>>>>>>> pierre-luc.st-charles@polymtl.ca> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>> Alright, small update for all following a quick
>>>>>>>>>>>>>> (non-mailing-list) exchange:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> We did successfully complete a kernel-tracing port of LTTng
>>>>>>>>>>>>>> for Android (somewhat old news), but we are still working on=
 bringing our
>>>>>>>>>>>>>> patches back up to date with the current version of the diff=
erent projects
>>>>>>>>>>>>>> (soon-ish still applies here, we're talking days). So far, w=
e dwelled a
>>>>>>>>>>>>>> little bit in LTTng-UST, but haven't done much changes, so u=
serspace
>>>>>>>>>>>>>> tracing is still not functional. Device that ran kernel trac=
es successfully
>>>>>>>>>>>>>> so far were the Nexus S and the Nexus 7 (example Nexus S tra=
ce available
>>>>>>>>>>>>>> here<https://drive.google.com/folderview?id=3D0B55Ba7lWTLh4U=
0hGeTQ4bmRYRjQ&usp=3Dsharing>;
>>>>>>>>>>>>>> still not perfect).
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Basically, we cross-compiled everything via the Android NDK
>>>>>>>>>>>>>> (no Android makefiles involved here), and pushed all require=
d bins to a
>>>>>>>>>>>>>> device without having to flash it (unless the default kernel=
 config didn't
>>>>>>>>>>>>>> allow tracing -- then we'd have to flash). This approach is =
not compatible
>>>>>>>>>>>>>> with the official Android build system (meaning we wouldn't =
be able to add
>>>>>>>>>>>>>> it to Android like this), but we might eventually get workin=
g on the damned
>>>>>>>>>>>>>> Android makefiles (they're extremely painful to write, espec=
ially since
>>>>>>>>>>>>>> LTTng uses Autotools).
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The librairies required by LTTng that are not already
>>>>>>>>>>>>>> included in a regular Android build (uuid/popt) can actually=
 be
>>>>>>>>>>>>>> found/compiled from the official repo, in its 'external' dir=
ectory (see
>>>>>>>>>>>>>> oprofile and e2fsprog -- from memory). That might not be the=
 easiest way to
>>>>>>>>>>>>>> get them (full repo download is BIG), but compatibility is a=
ssured, and you
>>>>>>>>>>>>>> can skip a full build by simply making those two individuall=
y for your
>>>>>>>>>>>>>> device (if that's all you need).
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> You'll also need your device to be rooted to use LTTng at
>>>>>>>>>>>>>> all; then, most initializations are done via scripts (we'll =
also provide
>>>>>>>>>>>>>> those with our patches). We still had some trouble automatin=
g everything
>>>>>>>>>>>>>> via daemons, so we always ran the sessiond locally (with suc=
cess).
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Major problems we encountered so far were missing posix
>>>>>>>>>>>>>> functions, and sysv shared memory. Basically, Android relies=
 on Bionic for
>>>>>>>>>>>>>> its system calls and other low-level functions, and since Bi=
onic is pretty
>>>>>>>>>>>>>> 'lightweight', they trimmed most of the fat out for performa=
nce. We had to
>>>>>>>>>>>>>> make some more-or-less sketchy replacements here and there, =
but everything
>>>>>>>>>>>>>> seems to be working decently now.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> So, simple 'how do I put LTTng on Android' workflow would be
>>>>>>>>>>>>>> this:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>   - Compile modules (using NDK) against device's kernel,
>>>>>>>>>>>>>> making sure its config is appropriate, ship them over via AD=
B
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>   - Compile required external libraries (using repo build
>>>>>>>>>>>>>> system) for the device, ship them over via ADB
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>   - Patch up LTTng-* (soon-ish! I could send you the outdate=
d
>>>>>>>>>>>>>> patches right now if you're interested though, they might be=
 a month behind
>>>>>>>>>>>>>> or so on the current trunks)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>   - Cross-compile LTTng-* for the device (using NDK), ship
>>>>>>>>>>>>>> binaries over via ADB
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Then, on the device, start up the sessiond manually & start
>>>>>>>>>>>>>> tracing.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I think I went over everything, but if there's a part that's
>>>>>>>>>>>>>> still cloudy, don't hesitate.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -PL
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On May 17, 2013 1:32 AM, "Ionut D." <ionut5001@gmail.com>
>>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Hello all,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Recently I started to integrate LTTNG in Android ICS by
>>>>>>>>>>>>>>> compiling each package, each dependency, by using the Andro=
id build system.
>>>>>>>>>>>>>>> It is a lot of work because I met different problems and to=
 be sincere, I
>>>>>>>>>>>>>>> do not know if at the end will work and I do not know how m=
uch I will need
>>>>>>>>>>>>>>> to modify the sources in order to work.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> My questions are about this integration. I mention that I
>>>>>>>>>>>>>>> read a lot of discussions about this on Internet, on this m=
ailing list, but
>>>>>>>>>>>>>>> the things are still not very clear for me.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> It is ok? what I am trying to do ? to integrate and build b=
y
>>>>>>>>>>>>>>> using the Android build system.
>>>>>>>>>>>>>>> Could you give me some guidelines, indications about how I
>>>>>>>>>>>>>>> should proceed, maybe a tutorial or maybe some android make=
 files/patches
>>>>>>>>>>>>>>> that would help me to see how the job must be done and if I=
 am doing it
>>>>>>>>>>>>>>> right ?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Until now I managed to build lttng-modules, liburcu, libuui=
d
>>>>>>>>>>>>>>> from util-linux and configure lttng-ust by using the androi=
d toolchain for
>>>>>>>>>>>>>>> arm. I got a lot of errors but until now I managed to confi=
gure/make these
>>>>>>>>>>>>>>> packages.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I mention that I am trying to build lttng 2.x on ICS 4.0.3.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Would be great if you will give me a tutorial about how to
>>>>>>>>>>>>>>> do it.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Ionut
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> _______________________________________________
>>>>>>>>>>>>>>> lttng-dev mailing list
>>>>>>>>>>>>>>> lttng-dev@lists.lttng.org
>>>>>>>>>>>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> lttng-dev mailing list
>>>>>>> lttng-dev@lists.lttng.org
>>>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>

--089e0122ef786a079804ddc64470
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">lttng-relayd is functional? Because I want to start it and=
 fails with:<div><br></div><div><div>DEBUG3 [3661/3661]: URI string: tcp://=
<a href=3D"http://0.0.0.0:5342">0.0.0.0:5342</a> (in uri_parse() at uri.c:2=
50)</div>
<div>DEBUG3 [3661/3661]: URI dtype: 1, proto: 1, host: 0.0.0.0, subdir: , c=
trl: 5342, data: 0 (in uri_parse() at uri.c:464)</div><div>DEBUG3 [3661/366=
1]: URI string: tcp://<a href=3D"http://0.0.0.0:5343">0.0.0.0:5343</a> (in =
uri_parse() at uri.c:250)</div>
<div>DEBUG3 [3661/3661]: URI dtype: 1, proto: 1, host: 0.0.0.0, subdir: , c=
trl: 5343, data: 0 (in uri_parse() at uri.c:464)</div><div>DEBUG1 [3661/366=
1]: Signal handler set for SIGTERM, SIGPIPE and SIGINT (in set_signal_handl=
er() at main.c:346)</div>
<div>DEBUG1 [3661/3661]: epoll set max size is 76382 (in compat_epoll_set_m=
ax_size() at compat-epoll.c:270)</div><div>DEBUG1 [3661/3662]: [thread] Rel=
ay dispatcher started (in relay_thread_dispatcher() at main.c:646)</div>
<div>DEBUG1 [3661/3662]: Futex n to 1 prepare done (in futex_nto1_prepare()=
 at futex.c:75)</div><div>DEBUG1 [3661/3662]: Woken up but nothing in the r=
elay command queue (in relay_thread_dispatcher() at main.c:656)</div><div>
DEBUG1 [3661/3664]: [thread] Relay listener started (in relay_thread_listen=
er() at main.c:484)</div><div>DEBUG1 [3661/3663]: [thread] Relay worker sta=
rted (in relay_thread_worker() at main.c:1772)</div><div>DEBUG1 [3661/3664]=
: Listening on sock 7 (in relay_init_sock() at main.c:430)</div>
<div>assertion &quot;URCU_TLS(rcu_reader).need_mb =3D=3D 0&quot; failed: fi=
le &quot;urcu.c&quot;, line 435, function &quot;rcu_register_thread_mb&quot=
;</div><div>DEBUG1 [3661/3664]: Listening on sock 9 (in relay_init_sock() a=
t main.c:430)</div>
<div>DEBUG1 [3661/3664]: Listener accepting connections (in relay_thread_li=
stener() at main.c:517)</div><div>Segmentation fault=A0</div></div><div><br=
></div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">=
On Fri, May 24, 2013 at 11:36 PM, Pierre-Luc St-Charles <span dir=3D"ltr">&=
lt;<a href=3D"mailto:pierre-luc.st-charles@polymtl.ca" target=3D"_blank">pi=
erre-luc.st-charles@polymtl.ca</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>Good news: you (most l=
ikely) won&#39;t need to recompile the whole platform to fix the problem!<b=
r>
</div><div><br></div>I think we bumped in a similar bitter-sweet-awful erro=
r a while back: after some hefty searches, we found it might have something=
 to do with the Android build system globally &#39;fortifying&#39; the sour=
ces against unsafe functions when compiling some of the most recent version=
s of the platform. I believe adding=A0-D_FORTIFY_SOURCE=3D0 to the CPPFLAGS=
 when building the tools solved it for us.<div>

<br></div><div>-PL</div></div><div class=3D"gmail_extra"><br><br><div class=
=3D"gmail_quote">On Fri, May 24, 2013 at 3:04 PM, Francis Giraldeau <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:francis.giraldeau@gmail.com" target=3D"_bl=
ank">francis.giraldeau@gmail.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi,<div><br></div><div>I go=
t some problem compiling required libraries for lttng-tools. I did a full a=
ndroid build within repo:</div>

<div><br></div><div>$ source build/envsetup.sh</div><div>
$ lunch # with full_maguro-eng</div><div>$ m</div><div><br></div><div>Build=
 is fine, but when trying to run configure in lttng-tools, it can&#39;t fin=
d liboprofile_popt. Here is the error message in config.log:</div>
<div><br></div><div><div>/home/francis/android/android-ndk-r8e/toolchains/a=
rm-linux-androideabi-4.6/prebuilt/linux-x86_64/bin/../lib/gcc/arm-linux-and=
roideabi/4.6/../../../../arm-linux-androideabi/bin/ld: /home/francis/androi=
d/repo/out/target/product/maguro/obj/STATIC_LIBRARIES/liboprofile_popt_inte=
rmediates/liboprofile_popt.a(popthelp.o): in function singleOptionHelp.isra=
.4:bionic/libc/include/stdio.h:483: error: undefined reference to &#39;__sp=
rintf_chk&#39;</div>


<div><br></div><div>It seems that only the static library of liboprofile_po=
pt is compiled.</div><div><br></div><div>The symbol is defined in libc.a an=
d libc.so:</div><div><br></div></div><div><div>$ nm ./out/target/product/ma=
guro/obj/SHARED_LIBRARIES/libc_intermediates/LINKED/libc.so | grep -E &quot=
;__strlen_chk|__sprintf_chk&quot;</div>


<div>0001395d T __sprintf_chk</div><div>00012df1 T __strlen_chk</div><div><=
br></div><div>I tried to compile the configtest.c file by hand and it worke=
d, so it really seems to be some kind of environment variable that make it =
fail.=A0</div>


<div><br></div><div>For the people who managed to do the configure, what ar=
guments should be supplied to configure? Or maybe it&#39;s my android build=
 that is incomplete? Should I build sub-directories in addition to the buil=
d in the root android repo sources?</div>


<div><br></div><div>Cheers!</div><span><font color=3D"#888888"><div><br></d=
iv><div>Francis</div></font></span></div></div><div><div><div class=3D"gmai=
l_extra"><br><br><div class=3D"gmail_quote">
2013/5/24 Pierre-Luc St-Charles <span dir=3D"ltr">&lt;<a href=3D"mailto:pie=
rre-luc.st-charles@polymtl.ca" target=3D"_blank">pierre-luc.st-charles@poly=
mtl.ca</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">The required kernel configu=
ration options for the modules are listed in the lttng-module README file, =
located in its project root directory. Some of the &#39;optional&#39; optio=
ns also listed there are simply not supported by 3.0.x ARM kernels (such as=
 HAVE_SYSCALL_TRACEPOINTS), so you might be missing some modules compared t=
o what you would get on a (x86 arch w/ recent kernel) platform.<div>



<br></div><div>You can find more information on syscall tracing on ARM here=
:=A0<a href=3D"http://comments.gmane.org/gmane.linux.kernel.tracing.lttng.d=
evel/5086" target=3D"_blank">http://comments.gmane.org/gmane.linux.kernel.t=
racing.lttng.devel/5086</a></div>



</div><div><div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quot=
e">On Fri, May 24, 2013 at 6:44 AM, Ionut D. <span dir=3D"ltr">&lt;<a href=
=3D"mailto:ionut5001@gmail.com" target=3D"_blank">ionut5001@gmail.com</a>&g=
t;</span> wrote:<br>



<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">I managed to fix it. It was=
 not finding `lttng-consumerd`, I fixed it by configuring the package with =
the right path. But, about the kernel modules the question is still pertine=
nt.=A0<span style=3D"font-family:arial,sans-serif;font-size:13px">What opti=
ons should I check in the kernel configuration? I saw that in my case not a=
ll the lttng kernel modules have been compiled.</span></div>



<div><div>
<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Fri, May 2=
4, 2013 at 11:07 AM, Ionut D. <span dir=3D"ltr">&lt;<a href=3D"mailto:ionut=
5001@gmail.com" target=3D"_blank">ionut5001@gmail.com</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">




<div dir=3D"ltr">Hello,<div><br></div><div>Thank you for the slides. I mang=
ed to build the kernel modules and I insmod them manually. On the device I =
copied in /data/lttng following binaries `lttng`, `lttng-relayd` and `lttng=
-sessiond`. If I execute `./lttng list -k` it shows me a list of available =
kernel events. I create a session called mysession with `./lttng create mys=
ession` and I enable tracing on all the event with `./lttng enable-event -a=
 -k`. But here starts my problem.</div>





<div><br></div><div>The output of the last command is the following:</div><=
div><br></div><div><div>root@android:/data/lttng # ./lttng enable-event -a =
-k</div><div>PERROR [3681/3681]: kernel start consumer exec: (null) (in spa=
wn_consumerd() at main.c:2007)</div>





<div>Error: Condition timed out. The consumer thread was never ready. Killi=
ng it</div><div>Warning: Using pthread_kill as pthread_cancel is missing on=
 the current platform</div><div>PERROR [3608/3658]: write poll pipe: (null)=
 (in notify_thread_pipe() at utils.c:43)</div>





<div>Error: Events: Fatal error of the session daemon (channel channel0, se=
ssion mysession)</div><div><br></div><div>Do you have any idea about what c=
ould be wrong? What options should I check in the kernel configuration? (I =
checked all that is under Tracing)</div>





<div><br></div><div>--Ionut</div><div><br></div></div><div><br></div><div><=
br></div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote=
">On Thu, May 23, 2013 at 6:09 PM, Charles Bri=E8re <span dir=3D"ltr">&lt;<=
a href=3D"mailto:charles.briere@polymtl.ca" target=3D"_blank">charles.brier=
e@polymtl.ca</a>&gt;</span> wrote:<br>





<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">Module location doesn&#39;t=
 really matter, we used to push them to /data/... or /sdcard/... .=A0<div><=
br>




<div>
Modprobe doesn&#39;t exists on Android so you&#39;ll need to use insmod. We=
 used <a href=3D"https://docs.google.com/file/d/0B56W2viIJ4oqOU1qTHJZY0V2Mz=
Q/edit" target=3D"_blank">this script</a> in order to compile, push to devi=
ce and load modules.=A0</div>






<div><br></div><div>We also made a=A0presentation you might be interested i=
n=A0that can be viewed on=A0<a href=3D"https://docs.google.com/presentation=
/d/14lte2AchEAyxMk3WSQ53SdbBm2tfmABBFQojuUhxg7Y/pub?start=3Dfalse&amp;loop=
=3Dfalse&amp;delayms=3D3000" target=3D"_blank">https://docs.google.com/pres=
entation/d/14lte2AchEAyxMk3WSQ53SdbBm2tfmABBFQojuUhxg7Y/pub?start=3Dfalse&a=
mp;loop=3Dfalse&amp;delayms=3D3000</a></div>






</div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">O=
n Thu, May 23, 2013 at 10:40 AM, Ionut D. <span dir=3D"ltr">&lt;<a href=3D"=
mailto:ionut5001@gmail.com" target=3D"_blank">ionut5001@gmail.com</a>&gt;</=
span> wrote:<br>






<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">About the kernel modules. W=
here should they be located on the target? Should I have modprobe or insmod=
 it is enough?</div>






<div><div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On =
Thu, May 23, 2013 at 2:19 PM, Ionut D. <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:ionut5001@gmail.com" target=3D"_blank">ionut5001@gmail.com</a>&gt;</spa=
n> wrote:<br>







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
</div></div><br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><br></div>
</blockquote></div><br></div>
</blockquote></div><br></div>
</div></div></blockquote></div><br></div>
</div></div><br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><br></div>
</div></div><br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><br></div>
<br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><br></div>

--089e0122ef786a079804ddc64470--


--===============0226949901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0226949901==--
