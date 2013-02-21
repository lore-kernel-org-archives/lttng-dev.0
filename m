From: Amit Balboul <amit.balboul@shinesec.com>
Subject: compiling LTTng for android
Date: Thu, 21 Feb 2013 12:13:29 +0200
Message-ID: <CAHg4Oy_bQHi7q6+Deb7AO_ZtJZj=9i5h+WyPTnaFO4uLxAwQXA__21045.6698122018$1361441671$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0211218823=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f43.google.com ([209.85.215.43])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amit.balboul@shinesec.com>) id 1U8T9j-0001Cu-Ra
	for lttng-dev@lists.lttng.org; Thu, 21 Feb 2013 05:13:36 -0500
Received: by mail-la0-f43.google.com with SMTP id ek20so8688267lab.30
	for <lttng-dev@lists.lttng.org>; Thu, 21 Feb 2013 02:13:29 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0211218823==
Content-Type: multipart/alternative; boundary=f46d042ef66181650f04d639532f

--f46d042ef66181650f04d639532f
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

In continue to posts from
http://www.mail-archive.com/lttng-dev@lists.lttng.org/msg02542.html,

I'm trying to build the LTTng kernel-tracer for Android on ARM:
(JB4.2.1 - kernel 3.0.31 - on Galaxy Nexus).
I'm having some trouble completing the process, didn't find any usable
information so far, maybe u can help.

I want to build the: (I've managed in the past to build the modules for
goldfish's 2.6.29 but this required patching the kernel).
(1) userspace-rcu
(2) modules
(3) tools
I'm currently stuck in the first phase (building userspace-rcu).

My steps and the issues I've encountered are:
1. Clone the userspace-rcu git repository
2. Generate a sysroot for arm-linux-androideabi from google's NDK (using
its "make-standalone-toolchain.sh" script with arm-linux-androideabi-4.4.3
toolchain).
3. Run ./bootstrap - creating config.h.in, Makefile.in, configure, ...
4. Run ./configure with --host=arm-linux-androideabi and the relevant
environment variables (CC, LD, CPPFLAGS, CFLAGS, LDFLAGS, LIB), pointing to
the NDK ARM SYSROOT.
5. Run make

Some errors I encoutered and their fixes (workarounds), while trying as
much as I can leave the sources untouched:
1. syscall.h not found. In some files, the <syscall.h> is included. In NDK
SYSROOT the syscall.h lays in sys/
FIX: created a link: SYSROOT/include/syscall.h ->
SYSROOT/include/sys/syscall.h
2. Android's libraries includes the pthread lib automatically, thus not
having a stand-alone pthread library.
FIX: removed "-lpthread" from Makefile.am, tests/Makefile.am
3. static declaration of "gettid" follows non-static declaration (in
SYSROOT/include/unistd.h, "gettid" is declared as "external")
For the mean time I commented this declaration... Maybe adding "#ifndef
gettid" before the declaration of  "static gettid" in the sources will fix
it ?
4. rand_r not declared - added a module that implements rand_r (as seen in
https://github.com/xbmc/xbmc/tree/master/xbmc/android/bionic_supplement)
5. undefined reference to rpl_malloc
FIX: setting ac_cv_func_malloc_0_nonnull=yes before launching ./configure.

now, after running ./configure and make, still not completed. I get many
"undefined reference to __sync_syncronize" messages. the
urcu/arch/generic.h defines the memory barriers functions as cmm_* but
their implementation is not taken from urcu/arch/arm.h but from Line 46 in
the same file (generic.h).
Can u help with this?
Am I missing something here ?

Also, how does the build system use the kernel 3.0.31 (or any other)
sysroot ?

Thank you

Amit.

--f46d042ef66181650f04d639532f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>In continue to posts from=A0<a =
href=3D"http://www.mail-archive.com/lttng-dev@lists.lttng.org/msg02542.html=
">http://www.mail-archive.com/lttng-dev@lists.lttng.org/msg02542.html</a>,<=
br>
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
<div style>5. Run make</div><div style><br></div><div style>Some errors I e=
ncoutered and their fixes (workarounds), while trying as much as I can leav=
e the sources untouched:</div><div style>1. syscall.h not found. In some fi=
les, the &lt;syscall.h&gt; is included. In NDK SYSROOT the syscall.h lays i=
n sys/</div>
<div style>FIX: created a link: SYSROOT/include/syscall.h -&gt; SYSROOT/inc=
lude/sys/syscall.h</div><div style>2. Android&#39;s libraries includes the =
pthread lib automatically, thus not having a stand-alone pthread library.</=
div>
<div style>FIX: removed &quot;-lpthread&quot; from Makefile.am, tests/Makef=
ile.am</div><div style>3. static declaration of &quot;gettid&quot; follows =
non-static declaration (in SYSROOT/include/unistd.h, &quot;gettid&quot; is =
declared as &quot;external&quot;)<br>
</div><div style>For the mean time I commented this declaration... Maybe ad=
ding &quot;#ifndef gettid&quot; before the declaration of =A0&quot;static g=
ettid&quot; in the sources will fix it ?</div><div style>4. rand_r not decl=
ared - added a module that implements rand_r (as seen in=A0<a href=3D"https=
://github.com/xbmc/xbmc/tree/master/xbmc/android/bionic_supplement">https:/=
/github.com/xbmc/xbmc/tree/master/xbmc/android/bionic_supplement</a>)</div>
<div style>5. undefined reference to rpl_malloc<br></div><div style>FIX: se=
tting ac_cv_func_malloc_0_nonnull=3Dyes before launching ./configure.</div>=
<div style><br></div><div style>now, after running ./configure and make, st=
ill not completed. I get many &quot;undefined reference to __sync_syncroniz=
e&quot; messages. the urcu/arch/generic.h defines the memory barriers funct=
ions as cmm_* but their implementation is not taken from urcu/arch/arm.h bu=
t from Line 46 in the same file (generic.h).</div>
<div style>Can u help with this?</div><div style>Am I missing something her=
e ?</div><div style><br></div><div style>Also, how does the build system us=
e the kernel 3.0.31 (or any other) sysroot ?<br></div><div><br></div><div s=
tyle>
Thank you</div></div><div style><br></div><div style>Amit.</div></div>

--f46d042ef66181650f04d639532f--


--===============0211218823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0211218823==--
