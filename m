From: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>
Subject: Re: compiling LTTng for android
Date: Thu, 21 Feb 2013 08:18:50 -0500
Message-ID: <CA+umk=rPAR7uiHQjL9FRE1UtVOEQ7J5xM46rfb_be7ZXoNC2MA__45278.5610141747$1361452797$gmane$org@mail.gmail.com>
References: <CAHg4Oy_bQHi7q6+Deb7AO_ZtJZj=9i5h+WyPTnaFO4uLxAwQXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0328556431=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f173.google.com ([209.85.128.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <b0mb00z.it@gmail.com>) id 1U8W3A-0002xR-4R
	for lttng-dev@lists.lttng.org; Thu, 21 Feb 2013 08:19:00 -0500
Received: by mail-ve0-f173.google.com with SMTP id oz10so7990920veb.32
	for <lttng-dev@lists.lttng.org>; Thu, 21 Feb 2013 05:18:54 -0800 (PST)
In-Reply-To: <CAHg4Oy_bQHi7q6+Deb7AO_ZtJZj=9i5h+WyPTnaFO4uLxAwQXA@mail.gmail.com>
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

--===============0328556431==
Content-Type: multipart/alternative; boundary=f46d043c7eb05e4c5d04d63bea72

--f46d043c7eb05e4c5d04d63bea72
Content-Type: text/plain; charset=ISO-8859-1

Forwarded to mailing list:

Hey Amil,

Sorry we kept you out of the loop, we've been struggling on some issues in
the later projects; as for liburcu, we've come across the same problems you
cited, except the last one:
    - syscall.h / lpthread / gettid : your solutions, or a #ifdef
__ANDROID__ barrier, seems to work as a temp fix.
    - rand_r : after substituting for the regular (not-thread-safe) rand,
we decide to go with our own implementation, but the one you found might
actually be better
    - rpl_malloc : same fix here, but we also found
that ac_cv_func_realloc_0_nonnull *might* also help in some cases (along
with ac_cv_func_malloc_0_nonnull)

As for the __sync_synchronize error, we haven't encountered those and we
managed to successfully build the library.

Possible differences:
We opted for AOSP's own pre-built & packaged NDK toolchain, (which can be
found here: http://developer.android.com/tools/sdk/ndk/index.html) and
pointed the sysroot variable to its platforms/android-14/arch-arm/
directory (latest). By default, it doesn't include some
module/kernel headers, but it should be enough for liburcu. We are
currently considering adding the liburcu project itself (along with the
others) directly in the android external modules, so that it may be
compiled with exactly the SAME settings as the rest of the
libraries/binaries/modules, using the same NDK (but for that, we'll need to
drop the autoconf/automake stuff, and that's another story).

The rest should be identical, we might have used some extra parameters here
and there that might be based on our environment in the build process, but
here they are anyway:
    in ./configure, add : --target=arm-linux-androideabi
--prefix=$SYSROOT/usr
    make sure you provide $SYSROOT/usr/lib instead of $SYSROOT/lib as the
default library path

Keep us informed if the problem still happens, we'll try to debug your
issue further.

On Thu, Feb 21, 2013 at 5:13 AM, Amit Balboul <amit.balboul@shinesec.com>wrote:

> Hi all,
>
> In continue to posts from
> http://www.mail-archive.com/lttng-dev@lists.lttng.org/msg02542.html,
>
> I'm trying to build the LTTng kernel-tracer for Android on ARM:
> (JB4.2.1 - kernel 3.0.31 - on Galaxy Nexus).
> I'm having some trouble completing the process, didn't find any usable
> information so far, maybe u can help.
>
> I want to build the: (I've managed in the past to build the modules for
> goldfish's 2.6.29 but this required patching the kernel).
> (1) userspace-rcu
> (2) modules
> (3) tools
> I'm currently stuck in the first phase (building userspace-rcu).
>
> My steps and the issues I've encountered are:
> 1. Clone the userspace-rcu git repository
> 2. Generate a sysroot for arm-linux-androideabi from google's NDK (using
> its "make-standalone-toolchain.sh" script with arm-linux-androideabi-4.4.3
> toolchain).
> 3. Run ./bootstrap - creating config.h.in, Makefile.in, configure, ...
> 4. Run ./configure with --host=arm-linux-androideabi and the relevant
> environment variables (CC, LD, CPPFLAGS, CFLAGS, LDFLAGS, LIB), pointing to
> the NDK ARM SYSROOT.
> 5. Run make
>
> Some errors I encoutered and their fixes (workarounds), while trying as
> much as I can leave the sources untouched:
> 1. syscall.h not found. In some files, the <syscall.h> is included. In NDK
> SYSROOT the syscall.h lays in sys/
> FIX: created a link: SYSROOT/include/syscall.h ->
> SYSROOT/include/sys/syscall.h
> 2. Android's libraries includes the pthread lib automatically, thus not
> having a stand-alone pthread library.
> FIX: removed "-lpthread" from Makefile.am, tests/Makefile.am
> 3. static declaration of "gettid" follows non-static declaration (in
> SYSROOT/include/unistd.h, "gettid" is declared as "external")
> For the mean time I commented this declaration... Maybe adding "#ifndef
> gettid" before the declaration of  "static gettid" in the sources will fix
> it ?
> 4. rand_r not declared - added a module that implements rand_r (as seen in
> https://github.com/xbmc/xbmc/tree/master/xbmc/android/bionic_supplement)
> 5. undefined reference to rpl_malloc
> FIX: setting ac_cv_func_malloc_0_nonnull=yes before launching ./configure.
>
> now, after running ./configure and make, still not completed. I get many
> "undefined reference to __sync_syncronize" messages. the
> urcu/arch/generic.h defines the memory barriers functions as cmm_* but
> their implementation is not taken from urcu/arch/arm.h but from Line 46 in
> the same file (generic.h).
> Can u help with this?
> Am I missing something here ?
>
> Also, how does the build system use the kernel 3.0.31 (or any other)
> sysroot ?
>
> Thank you
>
> Amit.
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>

--f46d043c7eb05e4c5d04d63bea72
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Forwarded to mailing list:<div><br></div><div><span style=3D"color:rgb(34,3=
4,34);font-family:arial,sans-serif;font-size:13.333333969116211px;backgroun=
d-color:rgb(255,255,255)">Hey Amil,</span><div style=3D"color:rgb(34,34,34)=
;font-family:arial,sans-serif;font-size:13.333333969116211px;background-col=
or:rgb(255,255,255)">
<br></div><div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;fo=
nt-size:13.333333969116211px;background-color:rgb(255,255,255)">Sorry we ke=
pt you out of the loop, we&#39;ve been struggling on some issues in the lat=
er projects; as for liburcu, we&#39;ve come across the same problems you ci=
ted, except the last one:</div>
<div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:13=
.333333969116211px;background-color:rgb(255,255,255)"><div>=A0 =A0 - syscal=
l.h / lpthread / gettid : your solutions, or a #ifdef __ANDROID__ barrier, =
seems to work as a temp fix.</div>
<div>=A0 =A0 - rand_r : after substituting for the regular (not-thread-safe=
) rand, we decide to go with our own implementation, but the one you found =
might actually be better</div><div>=A0 =A0 - rpl_malloc : same fix here, bu=
t we also found that=A0ac_cv_func_realloc_0_nonnull *might* also help in so=
me cases (along with=A0ac_cv_func_malloc_0_nonnull)</div>
<div><br></div></div><div style=3D"color:rgb(34,34,34);font-family:arial,sa=
ns-serif;font-size:13.333333969116211px;background-color:rgb(255,255,255)">=
As for the __sync_synchronize error, we haven&#39;t encountered those and w=
e managed to successfully build the library.</div>
<div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:13=
.333333969116211px;background-color:rgb(255,255,255)"><br></div><div style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:13.333333969=
116211px;background-color:rgb(255,255,255)">
Possible differences:</div><div style=3D"color:rgb(34,34,34);font-family:ar=
ial,sans-serif;font-size:13.333333969116211px;background-color:rgb(255,255,=
255)">We opted for AOSP&#39;s own pre-built &amp; packaged NDK toolchain, (=
which can be found here:=A0<a href=3D"http://developer.android.com/tools/sd=
k/ndk/index.html" target=3D"_blank" style=3D"color:rgb(17,85,204)">http://d=
eveloper.android.com/tools/sdk/ndk/index.html</a>) and pointed the sysroot =
variable to its platforms/android-14/arch-arm/ directory (latest). By defau=
lt, it doesn&#39;t include some module/kernel=A0headers,=A0but it should be=
 enough for liburcu. We are currently considering adding the liburcu projec=
t itself (along with the others) directly in the android external modules, =
so that it may be compiled with exactly the SAME settings as the rest of th=
e libraries/binaries/modules, using the same NDK (but for that, we&#39;ll n=
eed to drop the autoconf/automake stuff, and that&#39;s another story).</di=
v>
<div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:13=
.333333969116211px;background-color:rgb(255,255,255)"><br></div><div style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:13.333333969=
116211px;background-color:rgb(255,255,255)">
The rest should be identical, we might have used some extra parameters here=
 and there that might be based on our environment in the build process, but=
 here they are anyway:</div><div style=3D"color:rgb(34,34,34);font-family:a=
rial,sans-serif;font-size:13.333333969116211px;background-color:rgb(255,255=
,255)">
=A0 =A0 in ./configure, add :=A0--target=3Darm-linux-androideabi --prefix=
=3D$SYSROOT/usr</div><div style=3D"color:rgb(34,34,34);font-family:arial,sa=
ns-serif;font-size:13.333333969116211px;background-color:rgb(255,255,255)">=
=A0 =A0 make sure you provide=A0$SYSROOT/usr/lib instead of $SYSROOT/lib as=
 the default library path</div>
<div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:13=
.333333969116211px;background-color:rgb(255,255,255)">=A0 =A0=A0</div><div =
style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:13.3333=
33969116211px;background-color:rgb(255,255,255)">
Keep us informed if the problem still happens, we&#39;ll try to debug your =
issue=A0further.</div><br><div class=3D"gmail_quote">On Thu, Feb 21, 2013 a=
t 5:13 AM, Amit Balboul <span dir=3D"ltr">&lt;<a href=3D"mailto:amit.balbou=
l@shinesec.com" target=3D"_blank">amit.balboul@shinesec.com</a>&gt;</span> =
wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi all,<div><br></div><div>=
In continue to posts from=A0<a href=3D"http://www.mail-archive.com/lttng-de=
v@lists.lttng.org/msg02542.html" target=3D"_blank">http://www.mail-archive.=
com/lttng-dev@lists.lttng.org/msg02542.html</a>,<br>

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
Thank you</div></div><span class=3D"HOEnZb"><font color=3D"#888888"><div><b=
r></div><div>Amit.</div></font></span></div>
<br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><br></div>

--f46d043c7eb05e4c5d04d63bea72--


--===============0328556431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0328556431==--
