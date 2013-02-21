From: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>
Subject: Re: compiling LTTng for android
Date: Thu, 21 Feb 2013 13:37:57 -0500
Message-ID: <CA+umk=qr5ZDCJ8S7RoHRPgE0Q4RgYBGNOULKs3GYYCEunyshdA__14633.12947094$1361471955$gmane$org@mail.gmail.com>
References: <CAHg4Oy_bQHi7q6+Deb7AO_ZtJZj=9i5h+WyPTnaFO4uLxAwQXA@mail.gmail.com>
	<CA+umk=rPAR7uiHQjL9FRE1UtVOEQ7J5xM46rfb_be7ZXoNC2MA@mail.gmail.com>
	<CAHg4Oy-=fuTYU=5p0MPWJ9wQ+71NpoAWvzcHuB7rw4UesWUe-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0280957552=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <b0mb00z.it@gmail.com>) id 1U8b27-0005Qn-N3
	for lttng-dev@lists.lttng.org; Thu, 21 Feb 2013 13:38:15 -0500
Received: by mail-vc0-f176.google.com with SMTP id fk10so5879962vcb.7
	for <lttng-dev@lists.lttng.org>; Thu, 21 Feb 2013 10:38:10 -0800 (PST)
In-Reply-To: <CAHg4Oy-=fuTYU=5p0MPWJ9wQ+71NpoAWvzcHuB7rw4UesWUe-Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Balboul <amit.balboul@shinesec.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0280957552==
Content-Type: multipart/alternative; boundary=20cf307ca0f49e69bf04d6405fdf

--20cf307ca0f49e69bf04d6405fdf
Content-Type: text/plain; charset=ISO-8859-1

Hey Amit,

For the gettid issue, we were considering adding a #ifndef __ANDROID__ (all
mentions of gettid in urcu) #endif type of solution (which seems to work
for us at the moment), which also brings us to the last point: __ANDROID__
should be defined by default whenever you compile with the NDK's toolchain
(we have not added this variable anywhere ourselves and so far, it's been
very useful in all the projects). As for the patch itself, I personally
have no clue if this would break any convention already in place for
liburcu/LTTng in general; we have not been pushing any part of our
progression so far as nothing as been tested, and some changes we made
locally are extremely device/version specific (and would most likely
break functionalities in other environments).

For the syscall.h issue, we avoided including directly
"$SYSROOT/usr/include/sys",
since some files in that folder are not safe to use directly (see errno.h
and statfs.h for example). This seems to be the 'agreed-upon' logic used in
the AOSP source tree; possible alternatives are setting up new Android
#ifdef barriers in liburcu itself, or trying to push an empty, logically
linked  syscall.h file (identical the above errno.h and statfs.h) to
"$SYSROOT/usr/include"
(which would probably not be accepted in the AOSP source).

If your next plan after liburcu is porting the LTTng modules to Android,
you'll most likely hit the missing kernel config options (syscall/hook
related) in 3.0.x like we did; this will require some specific patching we
have yet to complete. This work has been done in Torvalds's kernel
(post-3.5 I believe, see his git for more info), but considering how
different the current Android device kernels still are from the official
ones, we might still have a lot to do.

On another note, we peeked a little bit into porting UST to Android, but
here again, replacing the SysV shmem implementation by Android's ashmem
proved a lot more complicated than we had anticipated. Currently, we are
only focusing on kernel tracing, so LTTng-modules + liburcu + LTTng-tools.
So far, we successfully built the modules (with limited support), liburcu
and the tools (also with limited support), but we have yet to start tracing.

Feel free to ask away if you have any more questions, although other people
on the mailing list might have better answers for LTTng-related questions.

-PL

On Thu, Feb 21, 2013 at 12:08 PM, Amit Balboul <amit.balboul@shinesec.com>wrote:

> Hey Pierre,
> Thank you for the fast response.
>
> I'm also using the pre-built NDK environment (r8d),
> I continue to work on it, I'll let you know if I'm still having those
> errors.
> About the "static inline pid_t gettid(void)" issue:
> I cannot find any better solution than modifying the userspace-rcu sources
> to avoid static declaration.
> I dont see the connection to building to Android, because unistd.h
> "extern"s gettid anyway, so it cannot be defined as static in any of the
> files (i just removed the "static" from the inline definition).
>
> How do you want me to make this patch ?
>
> About the syscall.h issue:
> applying the SYSROOT/usr/include/sys folder AFTER the SYSROOT/usr/include
> in the CPPFLAGS solves the issue (looks like it is better than the link
> solution).
>
> About the __ANDROID__ definition:
> May I add this symbol to configure.ac and use it in the sources, ?
>
>
> Amit.
>
>
>
>
> On Thu, Feb 21, 2013 at 3:18 PM, Pierre-Luc St-Charles <
> pierre-luc.st-charles@polymtl.ca> wrote:
>
>> Forwarded to mailing list:
>>
>> Hey Amil,
>>
>> Sorry we kept you out of the loop, we've been struggling on some issues
>> in the later projects; as for liburcu, we've come across the same problems
>> you cited, except the last one:
>>     - syscall.h / lpthread / gettid : your solutions, or a #ifdef
>> __ANDROID__ barrier, seems to work as a temp fix.
>>     - rand_r : after substituting for the regular (not-thread-safe) rand,
>> we decide to go with our own implementation, but the one you found might
>> actually be better
>>     - rpl_malloc : same fix here, but we also found
>> that ac_cv_func_realloc_0_nonnull *might* also help in some cases (along
>> with ac_cv_func_malloc_0_nonnull)
>>
>> As for the __sync_synchronize error, we haven't encountered those and we
>> managed to successfully build the library.
>>
>> Possible differences:
>> We opted for AOSP's own pre-built & packaged NDK toolchain, (which can be
>> found here: http://developer.android.com/tools/sdk/ndk/index.html) and
>> pointed the sysroot variable to its platforms/android-14/arch-arm/
>> directory (latest). By default, it doesn't include some
>> module/kernel headers, but it should be enough for liburcu. We are
>> currently considering adding the liburcu project itself (along with the
>> others) directly in the android external modules, so that it may be
>> compiled with exactly the SAME settings as the rest of the
>> libraries/binaries/modules, using the same NDK (but for that, we'll need to
>> drop the autoconf/automake stuff, and that's another story).
>>
>> The rest should be identical, we might have used some extra parameters
>> here and there that might be based on our environment in the build process,
>> but here they are anyway:
>>     in ./configure, add : --target=arm-linux-androideabi
>> --prefix=$SYSROOT/usr
>>     make sure you provide $SYSROOT/usr/lib instead of $SYSROOT/lib as the
>> default library path
>>
>> Keep us informed if the problem still happens, we'll try to debug your
>> issue further.
>>
>> On Thu, Feb 21, 2013 at 5:13 AM, Amit Balboul <amit.balboul@shinesec.com>wrote:
>>
>>> Hi all,
>>>
>>> In continue to posts from
>>> http://www.mail-archive.com/lttng-dev@lists.lttng.org/msg02542.html,
>>>
>>> I'm trying to build the LTTng kernel-tracer for Android on ARM:
>>> (JB4.2.1 - kernel 3.0.31 - on Galaxy Nexus).
>>> I'm having some trouble completing the process, didn't find any usable
>>> information so far, maybe u can help.
>>>
>>> I want to build the: (I've managed in the past to build the modules for
>>> goldfish's 2.6.29 but this required patching the kernel).
>>> (1) userspace-rcu
>>> (2) modules
>>> (3) tools
>>> I'm currently stuck in the first phase (building userspace-rcu).
>>>
>>> My steps and the issues I've encountered are:
>>> 1. Clone the userspace-rcu git repository
>>> 2. Generate a sysroot for arm-linux-androideabi from google's NDK (using
>>> its "make-standalone-toolchain.sh" script with arm-linux-androideabi-4.4.3
>>> toolchain).
>>> 3. Run ./bootstrap - creating config.h.in, Makefile.in, configure, ...
>>> 4. Run ./configure with --host=arm-linux-androideabi and the relevant
>>> environment variables (CC, LD, CPPFLAGS, CFLAGS, LDFLAGS, LIB), pointing to
>>> the NDK ARM SYSROOT.
>>> 5. Run make
>>>
>>> Some errors I encoutered and their fixes (workarounds), while trying as
>>> much as I can leave the sources untouched:
>>> 1. syscall.h not found. In some files, the <syscall.h> is included. In
>>> NDK SYSROOT the syscall.h lays in sys/
>>> FIX: created a link: SYSROOT/include/syscall.h ->
>>> SYSROOT/include/sys/syscall.h
>>> 2. Android's libraries includes the pthread lib automatically, thus not
>>> having a stand-alone pthread library.
>>> FIX: removed "-lpthread" from Makefile.am, tests/Makefile.am
>>> 3. static declaration of "gettid" follows non-static declaration (in
>>> SYSROOT/include/unistd.h, "gettid" is declared as "external")
>>> For the mean time I commented this declaration... Maybe adding "#ifndef
>>> gettid" before the declaration of  "static gettid" in the sources will fix
>>> it ?
>>> 4. rand_r not declared - added a module that implements rand_r (as seen
>>> in
>>> https://github.com/xbmc/xbmc/tree/master/xbmc/android/bionic_supplement)
>>> 5. undefined reference to rpl_malloc
>>> FIX: setting ac_cv_func_malloc_0_nonnull=yes before launching
>>> ./configure.
>>>
>>> now, after running ./configure and make, still not completed. I get many
>>> "undefined reference to __sync_syncronize" messages. the
>>> urcu/arch/generic.h defines the memory barriers functions as cmm_* but
>>> their implementation is not taken from urcu/arch/arm.h but from Line 46 in
>>> the same file (generic.h).
>>> Can u help with this?
>>> Am I missing something here ?
>>>
>>> Also, how does the build system use the kernel 3.0.31 (or any other)
>>> sysroot ?
>>>
>>> Thank you
>>>
>>> Amit.
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>>>
>>
>

--20cf307ca0f49e69bf04d6405fdf
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hey Amit,<div><br></div><div>For the gettid issue, we were considering addi=
ng a #ifndef __ANDROID__ (all mentions of gettid in urcu) #endif type of so=
lution (which seems to work for us at the moment), which also brings us to =
the last point: __ANDROID__ should be defined by default whenever you compi=
le with the NDK&#39;s toolchain (we have not added this variable anywhere o=
urselves and so far, it&#39;s been very useful in all the projects). As for=
 the patch itself, I personally have no clue if this would break any conven=
tion already in place for liburcu/LTTng in general; we have not been pushin=
g any part of our progression so far as nothing as been tested, and some ch=
anges we made locally are extremely device/version specific (and would most=
 likely break=A0functionalities=A0in other environments).</div>
<div><br></div><div>For the syscall.h issue, we avoided including directly =
&quot;$<span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font=
-size:13.333333969116211px;background-color:rgb(255,255,255)">SYSROOT/usr/i=
nclude/sys&quot;, since some files in that folder are not safe to use direc=
tly (see errno.h and statfs.h for example). This seems to be the &#39;agree=
d-upon&#39; logic used in the AOSP source tree; possible alternatives are s=
etting up new Android #ifdef barriers in liburcu itself, or trying to push =
an empty, logically linked =A0syscall.h file (identical the above errno.h a=
nd statfs.h) to &quot;</span>$<span style=3D"font-size:13.333333969116211px=
;color:rgb(34,34,34);font-family:arial,sans-serif;background-color:rgb(255,=
255,255)">SYSROOT/usr/include&quot; (which would probably not be accepted i=
n the AOSP source).</span></div>
<div><font color=3D"#222222" face=3D"arial, sans-serif"><br></font></div><d=
iv><font color=3D"#222222" face=3D"arial, sans-serif">If your next plan aft=
er liburcu is porting the LTTng modules to Android, you&#39;ll most likely =
hit the missing kernel config options (syscall/hook related) in 3.0.x like =
we did; this will require some specific patching we have yet to complete. T=
his work has been done in Torvalds&#39;s kernel (post-3.5 I believe, see hi=
s git for more info), but considering how different the current Android dev=
ice kernels still are from the official ones, we might still have a lot to =
do.</font></div>
<div><font color=3D"#222222" face=3D"arial, sans-serif"><br></font></div><d=
iv><font color=3D"#222222" face=3D"arial, sans-serif">On another note, we p=
eeked a little bit into porting UST to Android, but here again, replacing t=
he SysV shmem implementation by Android&#39;s ashmem proved a lot more comp=
licated than we had anticipated. Currently, we are only focusing on kernel =
tracing, so LTTng-modules + liburcu + LTTng-tools. So far, we successfully =
built the modules (with limited support), liburcu and the tools (also with =
limited support), but we have yet to start tracing.</font></div>
<div><font color=3D"#222222" face=3D"arial, sans-serif"><br></font></div><d=
iv><font color=3D"#222222" face=3D"arial, sans-serif">Feel free to ask away=
 if you have any more questions, although other people on the mailing list =
might have better answers for LTTng-related questions.</font></div>
<div><font color=3D"#222222" face=3D"arial, sans-serif"><br></font></div><d=
iv><font color=3D"#222222" face=3D"arial, sans-serif">-PL</font></div><div>=
<br><div class=3D"gmail_quote">On Thu, Feb 21, 2013 at 12:08 PM, Amit Balbo=
ul <span dir=3D"ltr">&lt;<a href=3D"mailto:amit.balboul@shinesec.com" targe=
t=3D"_blank">amit.balboul@shinesec.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hey Pierre,<div>Thank you f=
or the fast response.</div><div><br></div><div>I&#39;m also using the pre-b=
uilt NDK environment (r8d),</div>
<div>I continue to work on it, I&#39;ll let you know if I&#39;m still havin=
g those errors.</div>
<div>About the &quot;static inline pid_t gettid(void)&quot; issue:</div><di=
v>I cannot find any better solution than modifying the userspace-rcu source=
s to avoid static declaration.</div><div>I dont see the connection to build=
ing to Android, because unistd.h &quot;extern&quot;s gettid anyway, so it c=
annot be defined as static in any of the files (i just removed the &quot;st=
atic&quot; from the inline definition).</div>

<div><br></div><div>How do you want me to make this patch ?</div><div><br><=
/div><div>About the syscall.h issue:</div><div>applying the SYSROOT/usr/inc=
lude/sys folder AFTER the SYSROOT/usr/include in the CPPFLAGS solves the is=
sue (looks like it is better than the link solution).</div>

<div><br></div><div>About the __ANDROID__ definition:</div><div>May I add t=
his symbol to <a href=3D"http://configure.ac" target=3D"_blank">configure.a=
c</a> and use it in the sources, ?</div><span class=3D"HOEnZb"><font color=
=3D"#888888"><div>
<br></div><div><br>
</div><div>Amit.</div></font></span><div><div class=3D"h5"><div><br></div><=
div><br></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote"=
>On Thu, Feb 21, 2013 at 3:18 PM, Pierre-Luc St-Charles <span dir=3D"ltr">&=
lt;<a href=3D"mailto:pierre-luc.st-charles@polymtl.ca" target=3D"_blank">pi=
erre-luc.st-charles@polymtl.ca</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Forwarded to mailing list:<div><br></div><di=
v><div><span style=3D"color:rgb(34,34,34);font-size:13.333333969116211px;fo=
nt-family:arial,sans-serif">Hey Amil,</span><div style=3D"color:rgb(34,34,3=
4);font-size:13.333333969116211px;font-family:arial,sans-serif">


<br></div><div style=3D"color:rgb(34,34,34);font-size:13.333333969116211px;=
font-family:arial,sans-serif">Sorry we kept you out of the loop, we&#39;ve =
been struggling on some issues in the later projects; as for liburcu, we&#3=
9;ve come across the same problems you cited, except the last one:</div>


<div style=3D"color:rgb(34,34,34);font-size:13.333333969116211px;font-famil=
y:arial,sans-serif"><div>=A0 =A0 - syscall.h / lpthread / gettid : your sol=
utions, or a #ifdef __ANDROID__ barrier, seems to work as a temp fix.</div>
<div>=A0 =A0 - rand_r : after substituting for the regular (not-thread-safe=
) rand, we decide to go with our own implementation, but the one you found =
might actually be better</div><div>=A0 =A0 - rpl_malloc : same fix here, bu=
t we also found that=A0ac_cv_func_realloc_0_nonnull *might* also help in so=
me cases (along with=A0ac_cv_func_malloc_0_nonnull)</div>


<div><br></div></div><div style=3D"color:rgb(34,34,34);font-size:13.3333339=
69116211px;font-family:arial,sans-serif">As for the __sync_synchronize erro=
r, we haven&#39;t encountered those and we managed to successfully build th=
e library.</div>


<div style=3D"color:rgb(34,34,34);font-size:13.333333969116211px;font-famil=
y:arial,sans-serif"><br></div><div style=3D"color:rgb(34,34,34);font-size:1=
3.333333969116211px;font-family:arial,sans-serif">
Possible differences:</div><div style=3D"color:rgb(34,34,34);font-size:13.3=
33333969116211px;font-family:arial,sans-serif">We opted for AOSP&#39;s own =
pre-built &amp; packaged NDK toolchain, (which can be found here:=A0<a href=
=3D"http://developer.android.com/tools/sdk/ndk/index.html" style=3D"color:r=
gb(17,85,204)" target=3D"_blank">http://developer.android.com/tools/sdk/ndk=
/index.html</a>) and pointed the sysroot variable to its platforms/android-=
14/arch-arm/ directory (latest). By default, it doesn&#39;t include some mo=
dule/kernel=A0headers,=A0but it should be enough for liburcu. We are curren=
tly considering adding the liburcu project itself (along with the others) d=
irectly in the android external modules, so that it may be compiled with ex=
actly the SAME settings as the rest of the libraries/binaries/modules, usin=
g the same NDK (but for that, we&#39;ll need to drop the autoconf/automake =
stuff, and that&#39;s another story).</div>


<div style=3D"color:rgb(34,34,34);font-size:13.333333969116211px;font-famil=
y:arial,sans-serif"><br></div><div style=3D"color:rgb(34,34,34);font-size:1=
3.333333969116211px;font-family:arial,sans-serif">
The rest should be identical, we might have used some extra parameters here=
 and there that might be based on our environment in the build process, but=
 here they are anyway:</div><div style=3D"color:rgb(34,34,34);font-size:13.=
333333969116211px;font-family:arial,sans-serif">


=A0 =A0 in ./configure, add :=A0--target=3Darm-linux-androideabi --prefix=
=3D$SYSROOT/usr</div><div style=3D"color:rgb(34,34,34);font-size:13.3333339=
69116211px;font-family:arial,sans-serif">=A0 =A0 make sure you provide=A0$S=
YSROOT/usr/lib instead of $SYSROOT/lib as the default library path</div>


<div style=3D"color:rgb(34,34,34);font-size:13.333333969116211px;font-famil=
y:arial,sans-serif">=A0 =A0=A0</div><div style=3D"color:rgb(34,34,34);font-=
size:13.333333969116211px;font-family:arial,sans-serif">
Keep us informed if the problem still happens, we&#39;ll try to debug your =
issue=A0further.</div><br></div><div class=3D"gmail_quote"><div>On Thu, Feb=
 21, 2013 at 5:13 AM, Amit Balboul <span dir=3D"ltr">&lt;<a href=3D"mailto:=
amit.balboul@shinesec.com" target=3D"_blank">amit.balboul@shinesec.com</a>&=
gt;</span> wrote:<br>


</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><div><div><div dir=3D"ltr">Hi all,<div=
><br></div><div>In continue to posts from=A0<a href=3D"http://www.mail-arch=
ive.com/lttng-dev@lists.lttng.org/msg02542.html" target=3D"_blank">http://w=
ww.mail-archive.com/lttng-dev@lists.lttng.org/msg02542.html</a>,<br>



<div><br></div><div>I&#39;m trying to build the LTTng kernel-tracer for And=
roid on ARM:</div><div>(JB4.2.1 - kernel 3.0.31 - on Galaxy Nexus).<br></di=
v><div>I&#39;m having some trouble completing the process, didn&#39;t find =
any usable information so far, maybe u can help.<br>




</div><div><br></div><div>I want to build the: (I&#39;ve managed in the pas=
t to build the modules for goldfish&#39;s 2.6.29 but this required patching=
 the kernel).</div><div>(1) userspace-rcu</div><div>(2) modules</div><div>



(3) tools</div><div>I&#39;m currently stuck in the first phase (building us=
erspace-rcu).</div>
<div><br></div><div>My steps and the issues I&#39;ve encountered are:</div>=
<div>1. Clone the userspace-rcu git repository</div><div>2. Generate a sysr=
oot for arm-linux-androideabi from google&#39;s NDK (using its &quot;make-s=
tandalone-toolchain.sh&quot; script with arm-linux-androideabi-4.4.3 toolch=
ain).</div>




<div>3. Run ./bootstrap - creating <a href=3D"http://config.h.in" target=3D=
"_blank">config.h.in</a>, Makefile.in, configure, ...<br></div><div>4. Run =
./configure with --host=3Darm-linux-androideabi and the relevant environmen=
t variables (CC, LD, CPPFLAGS, CFLAGS, LDFLAGS, LIB), pointing to the NDK A=
RM SYSROOT.</div>



<div>5. Run make</div><div><br></div><div>Some errors I encoutered and thei=
r fixes (workarounds), while trying as much as I can leave the sources unto=
uched:</div><div>1. syscall.h not found. In some files, the &lt;syscall.h&g=
t; is included. In NDK SYSROOT the syscall.h lays in sys/</div>



<div>FIX: created a link: SYSROOT/include/syscall.h -&gt; SYSROOT/include/s=
ys/syscall.h</div><div>2. Android&#39;s libraries includes the pthread lib =
automatically, thus not having a stand-alone pthread library.</div>
<div>FIX: removed &quot;-lpthread&quot; from Makefile.am, tests/Makefile.am=
</div><div>3. static declaration of &quot;gettid&quot; follows non-static d=
eclaration (in SYSROOT/include/unistd.h, &quot;gettid&quot; is declared as =
&quot;external&quot;)<br>



</div><div>For the mean time I commented this declaration... Maybe adding &=
quot;#ifndef gettid&quot; before the declaration of =A0&quot;static gettid&=
quot; in the sources will fix it ?</div><div>4. rand_r not declared - added=
 a module that implements rand_r (as seen in=A0<a href=3D"https://github.co=
m/xbmc/xbmc/tree/master/xbmc/android/bionic_supplement" target=3D"_blank">h=
ttps://github.com/xbmc/xbmc/tree/master/xbmc/android/bionic_supplement</a>)=
</div>



<div>5. undefined reference to rpl_malloc<br></div><div>FIX: setting ac_cv_=
func_malloc_0_nonnull=3Dyes before launching ./configure.</div><div><br></d=
iv><div>now, after running ./configure and make, still not completed. I get=
 many &quot;undefined reference to __sync_syncronize&quot; messages. the ur=
cu/arch/generic.h defines the memory barriers functions as cmm_* but their =
implementation is not taken from urcu/arch/arm.h but from Line 46 in the sa=
me file (generic.h).</div>



<div>Can u help with this?</div><div>Am I missing something here ?</div><di=
v><br></div><div>Also, how does the build system use the kernel 3.0.31 (or =
any other) sysroot ?<br></div><div><br></div><div>
Thank you</div></div><span><font color=3D"#888888"><div><br></div><div>Amit=
.</div></font></span></div>
<br></div></div><div>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></div></blockquote></div><br></div>
</blockquote></div><br></div></div></div></div>
</blockquote></div><br></div>

--20cf307ca0f49e69bf04d6405fdf--


--===============0280957552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0280957552==--
