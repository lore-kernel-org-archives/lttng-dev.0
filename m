From: Douglas Graham <douglas.graham@ericsson.com>
Subject: What is the effect of not preloading lttng-ust-fork?
Date: Mon, 24 Apr 2017 01:56:42 +0000
Message-ID: <DB5PR07MB09496A86EB5F24D58FFBE029F01F0__2051.69109763137$1492999020$gmane$org@DB5PR07MB0949.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5116397337644670770=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sessmg22.ericsson.net (sessmg22.ericsson.net [193.180.251.58])
 by lists.lttng.org (Postfix) with ESMTPS id 3wB8c725lDzC4Y
 for <lttng-dev@lists.lttng.org>; Mon, 24 Apr 2017 01:57:26 +0000 (UTC)
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============5116397337644670770==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DB5PR07MB09496A86EB5F24D58FFBE029F01F0DB5PR07MB0949eurp_"

--_000_DB5PR07MB09496A86EB5F24D58FFBE029F01F0DB5PR07MB0949eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

We have an init-like top-level application that starts a bunch of other dae=
mons. This top-level daemon is started with LD_PRELOAD=3D /usr/lib/liblttng=
-ust-fork.so.0 so all the daemons that it starts inherit that.  Sometimes w=
e want to debug one of these child applications, so we arrange that instead=
 of starting it directly, the top-level daemon starts it like so: "gdbserve=
r :23 <path/to/real/daemon>".  This arranges that the child daemon not actu=
ally run until a remote debugger attaches.  This scheme seemed to work reas=
onably well until recently.  It still works maybe half the time, but the ot=
her half, gdbserver crashes in lttng related code.  The backtrace is below.=
  As a quick fix, I have tried starting gdbserver and the child application=
 like so: "/usr/bin/env -u LD_PRELOAD gdbserver :23 <path/to/real/daemon>".=
  In the limited testing I've done so far, this is looking good, but I'm wo=
ndering what other problems might turn up if I don't preload liblttng-ust-f=
ork into gdbserver and the application it is debugging.  Gdbserver does for=
k after all, and the application might as well.  Does this seem like a reas=
onable long-term solution for using the remote debugger?

Here's the crash backtrace:

(gdb) bt
#0  0xb6e8c810 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/=
linux/raise.c:55
#1  0xb6e9028c in __GI_abort () at abort.c:89
#2  0xb6e08198 in lttng_ust_elf_destroy (elf=3D0x2, elf@entry=3D0xb6f9a088 =
<lock>)
    at /usr/src/debug/lttng-ust/2.8.2-r3.eriR0/git/liblttng-ust/lttng-ust-e=
lf.c:342
#3  0xb6e08bec in get_elf_info (bin_data=3D0xb6541308) at /usr/src/debug/lt=
tng-ust/2.8.2-r3.eriR0/git/liblttng-ust/lttng-ust-statedump.c:165
#4  trace_baddr (bin_data=3D0xb6541308) at /usr/src/debug/lttng-ust/2.8.2-r=
3.eriR0/git/liblttng-ust/lttng-ust-statedump.c:175
#5  extract_bin_info_events (info=3Dinfo@entry=3D0xb6542360, size=3Dsize@en=
try=3D40, _data=3D_data@entry=3D0xb65423b8)
    at /usr/src/debug/lttng-ust/2.8.2-r3.eriR0/git/liblttng-ust/lttng-ust-s=
tatedump.c:298
#6  0xb6f65a78 in __GI___dl_iterate_phdr (callback=3D0xb6e08a34 <extract_bi=
n_info_events>, data=3Ddata@entry=3D0xb65423b8) at dl-iteratephdr.c:76
#7  0xb6e09c9c in do_baddr_statedump (owner=3D0xb6e5a618 <global_apps>)
    at /usr/src/debug/lttng-ust/2.8.2-r3.eriR0/git/liblttng-ust/lttng-ust-s=
tatedump.c:332
#8  do_lttng_ust_statedump (owner=3Downer@entry=3D0xb6e5a618 <global_apps>)
    at /usr/src/debug/lttng-ust/2.8.2-r3.eriR0/git/liblttng-ust/lttng-ust-s=
tatedump.c:355
#9  0xb6e007dc in lttng_handle_pending_statedump (owner=3Downer@entry=3D0xb=
6e5a618 <global_apps>)
    at /usr/src/debug/lttng-ust/2.8.2-r3.eriR0/git/liblttng-ust/lttng-event=
s.c:857
#10 0xb6df864c in handle_pending_statedump (sock_info=3D0xb6e5a618 <global_=
apps>)
    at /usr/src/debug/lttng-ust/2.8.2-r3.eriR0/git/liblttng-ust/lttng-ust-c=
omm.c:599
#11 handle_message (lum=3D0xb654286c, sock=3D<optimized out>, sock_info=3D<=
optimized out>)
    at /usr/src/debug/lttng-ust/2.8.2-r3.eriR0/git/liblttng-ust/lttng-ust-c=
omm.c:957
#12 ust_listener_thread (arg=3D0xb6e5a618 <global_apps>) at /usr/src/debug/=
lttng-ust/2.8.2-r3.eriR0/git/liblttng-ust/lttng-ust-comm.c:1520
#13 0xb6d49f6c in start_thread (arg=3D0xb6543420) at pthread_create.c:339

I am not able to easily examine the data in lttng_ust_elf_destroy() because=
 as you can see from the argument list to that function, gdb is confused ab=
out the value of the "elf" pointer (I find that gdb often gets confused on =
ARM when unwinding from a call to abort()).  But I can see that it aborted =
 because a close() failed:

        if (close(elf->fd)) {
                abort();
        }

The two other threads in the gdbserver application were here at the time of=
 the crash:

#0  syscall () at ../sysdeps/unix/sysv/linux/arm/syscall.S:37
#1  0xb6df7cd0 in futex (val3=3D0, uaddr2=3D0x0, timeout=3D0x0, val=3D0, op=
=3D0, uaddr=3D<optimized out>)
    at /repo/ngrbuilder/jenkins/ProductionBuild_0/xcs-build/build/xenon/bit=
bake_build/tmp/sysroots/xenon/usr/include/urcu/futex.h:65
#2  futex_async (op=3D0, val=3D0, timeout=3D0x0, uaddr2=3D0x0, val3=3D0, ua=
ddr=3D<optimized out>)
    at /repo/ngrbuilder/jenkins/ProductionBuild_0/xcs-build/build/xenon/bit=
bake_build/tmp/sysroots/xenon/usr/include/urcu/futex.h:97
#3  wait_for_sessiond (sock_info=3D<optimized out>) at /usr/src/debug/lttng=
-ust/2.8.2-r3.eriR0/git/liblttng-ust/lttng-ust-comm.c:1276
#4  ust_listener_thread (arg=3D0xb6e585ec <local_apps>) at /usr/src/debug/l=
ttng-ust/2.8.2-r3.eriR0/git/liblttng-ust/lttng-ust-comm.c:1330
#5  0xb6d49f6c in start_thread (arg=3D0xb6d43420) at pthread_create.c:339

#0  0xb6efd7b8 in execve () at ../sysdeps/unix/syscall-template.S:84
#1  0xb6efd8c8 in execv (path=3D<optimized out>, argv=3D<optimized out>) at=
 execv.c:25
#2  0x00035b40 in linux_create_inferior (program=3D0x6bc80 "/opt/radiosw/bi=
n/ngr2mpw.elf", allargs=3D0x6bc70)
    at /usr/src/debug/gdb/7.10.1-r0/gdb-7.10.1/gdb/gdbserver/linux-low.c:88=
9
#3  0x00018e30 in start_inferior (argv=3D0x6bc70) at /usr/src/debug/gdb/7.1=
0.1-r0/gdb-7.10.1/gdb/gdbserver/server.c:233
#4  0x0001aa58 in captured_main (argc=3Dargc@entry=3D-1225151608, argv=3Dar=
gv@entry=3D0x3fda8 <__libc_csu_init+32>)
    at /usr/src/debug/gdb/7.10.1-r0/gdb-7.10.1/gdb/gdbserver/server.c:3516
#5  0x0001250c in main (argc=3D-1225151608, argv=3D0x3fda8 <__libc_csu_init=
+32>)

Thanks,
Doug




--_000_DB5PR07MB09496A86EB5F24D58FFBE029F01F0DB5PR07MB0949eurp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-CA">Hi,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">We have an init-like top-level =
application that starts a bunch of other daemons. This top-level daemon is =
started with LD_PRELOAD=3D /usr/lib/liblttng-ust-fork.so.0 so all the daemo=
ns that it starts inherit that.&nbsp; Sometimes
 we want to debug one of these child applications, so we arrange that inste=
ad of starting it directly, the top-level daemon starts it like so: &#8220;=
gdbserver :23 &lt;path/to/real/daemon&gt;&#8221;.&nbsp; This arranges that =
the child daemon not actually run until a remote debugger
 attaches.&nbsp; This scheme seemed to work reasonably well until recently.=
&nbsp; It still works maybe half the time, but the other half, gdbserver cr=
ashes in lttng related code.&nbsp; The backtrace is below.&nbsp; As a quick=
 fix, I have tried starting gdbserver and the child
 application like so: &#8220;/usr/bin/env -u LD_PRELOAD gdbserver :23 &lt;p=
ath/to/real/daemon&gt;&#8221;.&nbsp; In the limited testing I&#8217;ve done=
 so far, this is looking good, but I&#8217;m wondering what other problems =
might turn up if I don&#8217;t preload liblttng-ust-fork into gdbserver and
 the application it is debugging.&nbsp; Gdbserver does fork after all, and =
the application might as well.&nbsp; Does this seem like a reasonable long-=
term solution for using the remote debugger?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">Here&#8217;s the crash backtrac=
e:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">(gdb) bt<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#0&nbsp; 0xb6e8c810 in __GI_rai=
se (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux/raise.c:55<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#1&nbsp; 0xb6e9028c in __GI_abo=
rt () at abort.c:89<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#2&nbsp; 0xb6e08198 in lttng_us=
t_elf_destroy (elf=3D0x2, elf@entry=3D0xb6f9a088 &lt;lock&gt;)<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp; at /usr/src/=
debug/lttng-ust/2.8.2-r3.eriR0/git/liblttng-ust/lttng-ust-elf.c:342<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#3&nbsp; 0xb6e08bec in get_elf_=
info (bin_data=3D0xb6541308) at /usr/src/debug/lttng-ust/2.8.2-r3.eriR0/git=
/liblttng-ust/lttng-ust-statedump.c:165<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#4&nbsp; trace_baddr (bin_data=
=3D0xb6541308) at /usr/src/debug/lttng-ust/2.8.2-r3.eriR0/git/liblttng-ust/=
lttng-ust-statedump.c:175<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#5&nbsp; extract_bin_info_event=
s (info=3Dinfo@entry=3D0xb6542360, size=3Dsize@entry=3D40, _data=3D_data@en=
try=3D0xb65423b8)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp; at /usr/src/=
debug/lttng-ust/2.8.2-r3.eriR0/git/liblttng-ust/lttng-ust-statedump.c:298<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#6&nbsp; 0xb6f65a78 in __GI___d=
l_iterate_phdr (callback=3D0xb6e08a34 &lt;extract_bin_info_events&gt;, data=
=3Ddata@entry=3D0xb65423b8) at dl-iteratephdr.c:76<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#7&nbsp; 0xb6e09c9c in do_baddr=
_statedump (owner=3D0xb6e5a618 &lt;global_apps&gt;)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp; at /usr/src/=
debug/lttng-ust/2.8.2-r3.eriR0/git/liblttng-ust/lttng-ust-statedump.c:332<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#8&nbsp; do_lttng_ust_statedump=
 (owner=3Downer@entry=3D0xb6e5a618 &lt;global_apps&gt;)<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp; at /usr/src/=
debug/lttng-ust/2.8.2-r3.eriR0/git/liblttng-ust/lttng-ust-statedump.c:355<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#9&nbsp; 0xb6e007dc in lttng_ha=
ndle_pending_statedump (owner=3Downer@entry=3D0xb6e5a618 &lt;global_apps&gt=
;)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp; at /usr/src/=
debug/lttng-ust/2.8.2-r3.eriR0/git/liblttng-ust/lttng-events.c:857<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#10 0xb6df864c in handle_pendin=
g_statedump (sock_info=3D0xb6e5a618 &lt;global_apps&gt;)<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp; at /usr/src/=
debug/lttng-ust/2.8.2-r3.eriR0/git/liblttng-ust/lttng-ust-comm.c:599<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#11 handle_message (lum=3D0xb65=
4286c, sock=3D&lt;optimized out&gt;, sock_info=3D&lt;optimized out&gt;)<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp; at /usr/src/=
debug/lttng-ust/2.8.2-r3.eriR0/git/liblttng-ust/lttng-ust-comm.c:957<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#12 ust_listener_thread (arg=3D=
0xb6e5a618 &lt;global_apps&gt;) at /usr/src/debug/lttng-ust/2.8.2-r3.eriR0/=
git/liblttng-ust/lttng-ust-comm.c:1520<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#13 0xb6d49f6c in start_thread =
(arg=3D0xb6543420) at pthread_create.c:339<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">I am not able to easily examine=
 the data in lttng_ust_elf_destroy() because as you can see from the argume=
nt list to that function, gdb is confused about the value of the &#8220;elf=
&#8221; pointer (I find that gdb often gets confused
 on ARM when unwinding from a call to abort()).&nbsp; But I can see that it=
 aborted&nbsp; because a close() failed:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; if (close(elf-&gt;fd)) {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; abort();<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; }<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">The two other threads in the gd=
bserver application were here at the time of the crash:<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#0&nbsp; syscall () at ../sysde=
ps/unix/sysv/linux/arm/syscall.S:37<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#1&nbsp; 0xb6df7cd0 in futex (v=
al3=3D0, uaddr2=3D0x0, timeout=3D0x0, val=3D0, op=3D0, uaddr=3D&lt;optimize=
d out&gt;)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp; at /repo/ngr=
builder/jenkins/ProductionBuild_0/xcs-build/build/xenon/bitbake_build/tmp/s=
ysroots/xenon/usr/include/urcu/futex.h:65<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#2&nbsp; futex_async (op=3D0, v=
al=3D0, timeout=3D0x0, uaddr2=3D0x0, val3=3D0, uaddr=3D&lt;optimized out&gt=
;)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp; at /repo/ngr=
builder/jenkins/ProductionBuild_0/xcs-build/build/xenon/bitbake_build/tmp/s=
ysroots/xenon/usr/include/urcu/futex.h:97<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#3&nbsp; wait_for_sessiond (soc=
k_info=3D&lt;optimized out&gt;) at /usr/src/debug/lttng-ust/2.8.2-r3.eriR0/=
git/liblttng-ust/lttng-ust-comm.c:1276<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#4&nbsp; ust_listener_thread (a=
rg=3D0xb6e585ec &lt;local_apps&gt;) at /usr/src/debug/lttng-ust/2.8.2-r3.er=
iR0/git/liblttng-ust/lttng-ust-comm.c:1330<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#5&nbsp; 0xb6d49f6c in start_th=
read (arg=3D0xb6d43420) at pthread_create.c:339<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#0&nbsp; 0xb6efd7b8 in execve (=
) at ../sysdeps/unix/syscall-template.S:84<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#1&nbsp; 0xb6efd8c8 in execv (p=
ath=3D&lt;optimized out&gt;, argv=3D&lt;optimized out&gt;) at execv.c:25<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#2&nbsp; 0x00035b40 in linux_cr=
eate_inferior (program=3D0x6bc80 &quot;/opt/radiosw/bin/ngr2mpw.elf&quot;, =
allargs=3D0x6bc70)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp; at /usr/src/=
debug/gdb/7.10.1-r0/gdb-7.10.1/gdb/gdbserver/linux-low.c:889<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#3&nbsp; 0x00018e30 in start_in=
ferior (argv=3D0x6bc70) at /usr/src/debug/gdb/7.10.1-r0/gdb-7.10.1/gdb/gdbs=
erver/server.c:233<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#4&nbsp; 0x0001aa58 in captured=
_main (argc=3Dargc@entry=3D-1225151608, argv=3Dargv@entry=3D0x3fda8 &lt;__l=
ibc_csu_init&#43;32&gt;)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">&nbsp;&nbsp;&nbsp; at /usr/src/=
debug/gdb/7.10.1-r0/gdb-7.10.1/gdb/gdbserver/server.c:3516<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">#5&nbsp; 0x0001250c in main (ar=
gc=3D-1225151608, argv=3D0x3fda8 &lt;__libc_csu_init&#43;32&gt;)<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">Thanks,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA">Doug<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-CA"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_DB5PR07MB09496A86EB5F24D58FFBE029F01F0DB5PR07MB0949eurp_--

--===============5116397337644670770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5116397337644670770==--
