From: "Chang, Zheng" <Zheng.Chang@emc.com>
Subject: Deaklock in liblttng-ust
Date: Thu, 13 Sep 2012 03:27:11 -0400
Message-ID: <6539770C71C3814BB0BFC2DBEBD1050801062B20__41704.9219519415$1347521338$gmane$org@CORPUSMX30B.corp.emc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1111082465=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from hop-nat-141.emc.com ([168.159.213.141]
	helo=mexforward.lss.emc.com) by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Zheng.Chang@emc.com>) id 1TC3qd-0002dO-5j
	for lttng-dev@lists.lttng.org; Thu, 13 Sep 2012 03:28:27 -0400
Received: from hop04-l1d11-si02.isus.emc.com (HOP04-L1D11-SI02.isus.emc.com
	[10.254.111.55])
	by mexforward.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	q8D7SLIZ005074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <lttng-dev@lists.lttng.org>; Thu, 13 Sep 2012 03:28:21 -0400
Received: from mailhub.lss.emc.com (mailhub.lss.emc.com [10.254.222.130]) by
	hop04-l1d11-si02.isus.emc.com (RSA Interceptor) for
	<lttng-dev@lists.lttng.org>; Thu, 13 Sep 2012 03:28:13 -0400
Received: from corpussmtp3.corp.emc.com (corpussmtp3.corp.emc.com
	[10.254.169.196])
	by mailhub.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	q8D7SCdv018726
	for <lttng-dev@lists.lttng.org>; Thu, 13 Sep 2012 03:28:12 -0400
Content-class: urn:content-classes:message
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

This is a multi-part message in MIME format.

--===============1111082465==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CD9181.315F2495"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CD9181.315F2495
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

I built a trace.so as a wrapper of lttng-ust, which predefines some
events and APIs based on lttng-ust.

And here is demo application linked to this share library.=20

=20

Sometimes the demo hung at launch time. I did test with the demo and
easy-ust of lttng-ust on both IA32 and X64 and got the same result.

Lttng-ust version is 2.02.=20

=20

I collect some debuging info with gdb here:

=20

Parent process:

=20

gdb) thread 3  (constructor of liblttng-ust.so)

[Switching to thread 3 (Thread 0x7f91d5487950 (LWP 21901))]#0
0x00007f91d82ad400 in wait () from /lib64/libpthread.so.0

(gdb) bt

#0  0x00007f91d82ad400 in wait () from /lib64/libpthread.so.0

#1  0x00007f91d64a8c4b in wait_for_sessiond (sock_info=3D0x7f91d66cc640)
at lttng-ust-comm.c:481

#2  0x00007f91d64a9545 in ust_listener_thread (arg=3D<value optimized
out>) at lttng-ust-comm.c:669

#3  0x00007f91d82a5650 in start_thread () from /lib64/libpthread.so.0

#4  0x00007f91d7b0315d in clone () from /lib64/libc.so.6

=20

(gdb) thread 5    (constructor of demo)

[Switching to thread 5 (Thread 0x7f91d690e950 (LWP 21899))]#0
0x00007f91d82ac344 in __lll_lock_wait () from /lib64/libpthread.so.0

(gdb) bt

#0  0x00007f91d82ac344 in __lll_lock_wait () from /lib64/libpthread.so.0

#1  0x00007f91d82a72d0 in _L_lock_102 () from /lib64/libpthread.so.0

#2  0x00007f91d82a6bbe in pthread_mutex_lock () from
/lib64/libpthread.so.0

#3  0x00007f91d64abf8b in ltt_probe_register (desc=3D0x7f91d66d0ce0) at
ltt-probes.c:77

#4  0x00007f91d66e0cfb in __lttng_events_init__sample_component () at
/usr/include/lttng/ust-tracepoint-event.h:550

#5  0x00007f91d66e71b6 in __do_global_ctors_aux () from mytrace.so

#6  0x00007f91d66e03c3 in _init () from mytrace.so

#7  0x00007f91d66df3d4 in ?? () from mytrace.so

#8  0x00007f91d94f78d8 in ?? () from /lib64/ld-linux-x86-64.so.2

#9  0x00007f91d94f7a07 in ?? () from /lib64/ld-linux-x86-64.so.2

#10 0x00007f91d94fbbde in ?? () from /lib64/ld-linux-x86-64.so.2

#11 0x00007f91d94f7566 in ?? () from /lib64/ld-linux-x86-64.so.2

#12 0x00007f91d94fb38b in ?? () from /lib64/ld-linux-x86-64.so.2

#13 0x00007f91d84bbf9b in ?? () from /lib64/libdl.so.2

#14 0x00007f91d94f7566 in ?? () from /lib64/ld-linux-x86-64.so.2

#15 0x00007f91d84bc34c in ?? () from /lib64/libdl.so.2

#16 0x00007f91d84bbf01 in dlopen () from /lib64/libdl.so.2

..............................................

#24 0x00007f91d82a5650 in start_thread () from /lib64/libpthread.so.0

#25 0x00007f91d7b0315d in clone () from /lib64/libc.so.6

=20

(gdb) p sessions_mutex

$4 =3D {__data =3D {__lock =3D 2, __count =3D 0, __owner =3D 21901, =
__nusers =3D 1,
__kind =3D 0, __spins =3D 0, __list =3D {__prev =3D 0x0, __next =3D =
0x0}},=20

  __size =3D "\002\000\000\000\000\000\000\000\215U\000\000\001", '\0'
<repeats 26 times>, __align =3D 2}

=20

Child process:

=20

(gdb) info thread    (forked from 21901)

* 1 Thread 0x7f91d5487950 (LWP 21902)  0x00007f91d82ac344 in
__lll_lock_wait () from /lib64/libpthread.so.0

(gdb) bt

#0  0x00007f91d82ac344 in __lll_lock_wait () from /lib64/libpthread.so.0

#1  0x00007f91d82a72d0 in _L_lock_102 () from /lib64/libpthread.so.0

#2  0x00007f91d82a6bbe in pthread_mutex_lock () from
/lib64/libpthread.so.0

#3  0x00007f91d64abe58 in ltt_probe_unregister (desc=3D0x7f91d66d0ce0) =
at
ltt-probes.c:129

#4  0x00007f91d66e0d10 in __lttng_events_exit__sample_component () at
/usr/include/lttng/ust-tracepoint-event.h:557

#5  0x00007f91d66e07cf in __do_global_dtors_aux () from mytrace.so

#6  0x00007f91d66cd664 in global_apps () from /usr/lib/liblttng-ust.so.0

#7  0x00007f91d5479df0 in ?? ()

#8  0x00007f91d66e71dd in _real_fini () from mytrace.so

#9  0x00007f91d66e71d2 in _fini () from mytrace.so

#10 0x00007f91d94f7f54 in ?? () from /lib64/ld-linux-x86-64.so.2

#11 0x00007f91d7a652ed in exit () from /lib64/libc.so.6

#12 0x00007f91d64a9207 in wait_for_sessiond (sock_info=3D0x7f91d66cc640)
at lttng-ust-comm.c:542

#13 0x00007f91d64a9545 in ust_listener_thread (arg=3D<value optimized
out>) at lttng-ust-comm.c:669

#14 0x00007f91d82a5650 in start_thread () from /lib64/libpthread.so.0

#15 0x00007f91d7b0315d in clone () from /lib64/libc.so.6

#16 0x0000000000000000 in ?? ()

(gdb) p sessions_mutex

$1 =3D {__data =3D {__lock =3D 2, __count =3D 0, __owner =3D 21901, =
__nusers =3D 1,
__kind =3D 0, __spins =3D 0, __list =3D {__prev =3D 0x0, __next =3D =
0x0}},=20

  __size =3D "\002\000\000\000\000\000\000\000\215U\000\000\001", '\0'
<repeats 26 times>, __align =3D 2}

=20

What happened seems like this:

=20

lttng_ust_init

       |

       |-> ust_listener_thread=20

                                            |

                                            |-> wait_for_sessiond=20

                                                                   |

                                                                   |->
ust_lock
(1)

                                                                   |->
get_map_shm=20

                                                                   |
|

                                                                   |
|-> get_wait_shm=20

                                                                   |
|

                                                                   |
|-> fork

                                                                   |
parent -> wait
(2)

                                                                   |
child  -> exit -> _fini -> __do_global_dtors_aux -> ...... ->
ltt_probe_unregister -> ust_lock            (3)

                                                                   |->
ust_unlock
(4)

=20

Deadlock happened at point (1) and (3). Parent waited for child's
termination and child waited for parent to release the lock.

=20

Reproduction conditions:

-          First time to create share memory
(/dev/shm/lttng-ust-apps-wait* don't exist)

-          Child process got delayed( I'm not quite sure with this, I
used gdb to hold child process for a while and it happened either)

=20

In normal case, child process didn't call _fini when it exited so that
no deadlock happened.

=20

Is this a known issue?

=20

Thanks

-Zheng

=20


------_=_NextPart_001_01CD9181.315F2495
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 12 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:933053302;
	mso-list-type:hybrid;
	mso-list-template-ids:1501617316 945345500 67698691 67698693 67698689 =
67698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Calibri","sans-serif";
	mso-fareast-font-family:SimSun;}
@list l0:level2
	{mso-level-tab-stop:1.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-tab-stop:1.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level4
	{mso-level-tab-stop:2.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-tab-stop:2.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-tab-stop:3.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level7
	{mso-level-tab-stop:3.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-tab-stop:4.0in;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-tab-stop:4.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p =
class=3DMsoNormal>Hi,<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I built a =
trace.so as a wrapper of lttng-ust, which predefines some events and =
APIs based on lttng-ust.<o:p></o:p></p><p class=3DMsoNormal>And here is =
demo application linked to this share library. <o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Sometimes =
the demo hung at launch time. I did test with the demo and easy-ust of =
lttng-ust on both IA32 and X64 and got the same result.<o:p></o:p></p><p =
class=3DMsoNormal>Lttng-ust version is 2.02. <o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I collect =
some debuging info with gdb here:<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Parent =
process:<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>gdb) thread 3 &nbsp;(constructor of =
liblttng-ust.so)<o:p></o:p></p><p class=3DMsoNormal>[Switching to thread =
3 (Thread 0x7f91d5487950 (LWP 21901))]#0&nbsp; 0x00007f91d82ad400 in =
wait () from /lib64/libpthread.so.0<o:p></o:p></p><p =
class=3DMsoNormal>(gdb) bt<o:p></o:p></p><p class=3DMsoNormal>#0&nbsp; =
0x00007f91d82ad400 in wait () from =
/lib64/libpthread.so.0<o:p></o:p></p><p class=3DMsoNormal>#1&nbsp; =
0x00007f91d64a8c4b in wait_for_sessiond (sock_info=3D0x7f91d66cc640) at =
lttng-ust-comm.c:481<o:p></o:p></p><p class=3DMsoNormal>#2&nbsp; =
0x00007f91d64a9545 in ust_listener_thread (arg=3D&lt;value optimized =
out&gt;) at lttng-ust-comm.c:669<o:p></o:p></p><p =
class=3DMsoNormal>#3&nbsp; 0x00007f91d82a5650 in start_thread () from =
/lib64/libpthread.so.0<o:p></o:p></p><p class=3DMsoNormal>#4&nbsp; =
0x00007f91d7b0315d in clone () from /lib64/libc.so.6<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>(gdb) thread =
5&nbsp;&nbsp; &nbsp;(constructor of demo)<o:p></o:p></p><p =
class=3DMsoNormal>[Switching to thread 5 (Thread 0x7f91d690e950 (LWP =
21899))]#0&nbsp; 0x00007f91d82ac344 in __lll_lock_wait () from =
/lib64/libpthread.so.0<o:p></o:p></p><p class=3DMsoNormal>(gdb) =
bt<o:p></o:p></p><p class=3DMsoNormal>#0&nbsp; 0x00007f91d82ac344 in =
__lll_lock_wait () from /lib64/libpthread.so.0<o:p></o:p></p><p =
class=3DMsoNormal>#1&nbsp; 0x00007f91d82a72d0 in _L_lock_102 () from =
/lib64/libpthread.so.0<o:p></o:p></p><p class=3DMsoNormal>#2&nbsp; =
0x00007f91d82a6bbe in pthread_mutex_lock () from =
/lib64/libpthread.so.0<o:p></o:p></p><p class=3DMsoNormal>#3&nbsp; =
0x00007f91d64abf8b in ltt_probe_register (desc=3D0x7f91d66d0ce0) at =
ltt-probes.c:77<o:p></o:p></p><p class=3DMsoNormal>#4&nbsp; =
0x00007f91d66e0cfb in __lttng_events_init__sample_component () at =
/usr/include/lttng/ust-tracepoint-event.h:550<o:p></o:p></p><p =
class=3DMsoNormal>#5&nbsp; 0x00007f91d66e71b6 in __do_global_ctors_aux =
() from mytrace.so<o:p></o:p></p><p class=3DMsoNormal>#6&nbsp; =
0x00007f91d66e03c3 in _init () from mytrace.so<o:p></o:p></p><p =
class=3DMsoNormal>#7&nbsp; 0x00007f91d66df3d4 in ?? () from =
mytrace.so<o:p></o:p></p><p class=3DMsoNormal>#8&nbsp; =
0x00007f91d94f78d8 in ?? () from =
/lib64/ld-linux-x86-64.so.2<o:p></o:p></p><p class=3DMsoNormal>#9&nbsp; =
0x00007f91d94f7a07 in ?? () from =
/lib64/ld-linux-x86-64.so.2<o:p></o:p></p><p class=3DMsoNormal>#10 =
0x00007f91d94fbbde in ?? () from =
/lib64/ld-linux-x86-64.so.2<o:p></o:p></p><p class=3DMsoNormal>#11 =
0x00007f91d94f7566 in ?? () from =
/lib64/ld-linux-x86-64.so.2<o:p></o:p></p><p class=3DMsoNormal>#12 =
0x00007f91d94fb38b in ?? () from =
/lib64/ld-linux-x86-64.so.2<o:p></o:p></p><p class=3DMsoNormal>#13 =
0x00007f91d84bbf9b in ?? () from /lib64/libdl.so.2<o:p></o:p></p><p =
class=3DMsoNormal>#14 0x00007f91d94f7566 in ?? () from =
/lib64/ld-linux-x86-64.so.2<o:p></o:p></p><p class=3DMsoNormal>#15 =
0x00007f91d84bc34c in ?? () from /lib64/libdl.so.2<o:p></o:p></p><p =
class=3DMsoNormal>#16 0x00007f91d84bbf01 in dlopen () from =
/lib64/libdl.so.2<o:p></o:p></p><p =
class=3DMsoNormal>..............................................<o:p></o:=
p></p><p class=3DMsoNormal>#24 0x00007f91d82a5650 in start_thread () =
from /lib64/libpthread.so.0<o:p></o:p></p><p class=3DMsoNormal>#25 =
0x00007f91d7b0315d in clone () from /lib64/libc.so.6<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>(gdb) p =
sessions_mutex<o:p></o:p></p><p class=3DMsoNormal>$4 =3D {__data =3D =
{__lock =3D 2, __count =3D 0, __owner =3D 21901, __nusers =3D 1, __kind =
=3D 0, __spins =3D 0, __list =3D {__prev =3D 0x0, __next =3D 0x0}}, =
<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;__size =3D =
&quot;\002\000\000\000\000\000\000\000\215U\000\000\001&quot;, '\0' =
&lt;repeats 26 times&gt;, __align =3D 2}<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Child =
process:<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>(gdb) info thread&nbsp;&nbsp;&nbsp; (forked from =
21901)<o:p></o:p></p><p class=3DMsoNormal>* 1 Thread 0x7f91d5487950 (LWP =
21902)&nbsp; 0x00007f91d82ac344 in __lll_lock_wait () from =
/lib64/libpthread.so.0<o:p></o:p></p><p class=3DMsoNormal>(gdb) =
bt<o:p></o:p></p><p class=3DMsoNormal>#0&nbsp; 0x00007f91d82ac344 in =
__lll_lock_wait () from /lib64/libpthread.so.0<o:p></o:p></p><p =
class=3DMsoNormal>#1&nbsp; 0x00007f91d82a72d0 in _L_lock_102 () from =
/lib64/libpthread.so.0<o:p></o:p></p><p class=3DMsoNormal>#2&nbsp; =
0x00007f91d82a6bbe in pthread_mutex_lock () from =
/lib64/libpthread.so.0<o:p></o:p></p><p class=3DMsoNormal>#3&nbsp; =
0x00007f91d64abe58 in ltt_probe_unregister (desc=3D0x7f91d66d0ce0) at =
ltt-probes.c:129<o:p></o:p></p><p class=3DMsoNormal>#4&nbsp; =
0x00007f91d66e0d10 in __lttng_events_exit__sample_component () at =
/usr/include/lttng/ust-tracepoint-event.h:557<o:p></o:p></p><p =
class=3DMsoNormal>#5&nbsp; 0x00007f91d66e07cf in __do_global_dtors_aux =
() from mytrace.so<o:p></o:p></p><p class=3DMsoNormal>#6&nbsp; =
0x00007f91d66cd664 in global_apps () from =
/usr/lib/liblttng-ust.so.0<o:p></o:p></p><p class=3DMsoNormal>#7&nbsp; =
0x00007f91d5479df0 in ?? ()<o:p></o:p></p><p class=3DMsoNormal>#8&nbsp; =
0x00007f91d66e71dd in _real_fini () from mytrace.so<o:p></o:p></p><p =
class=3DMsoNormal>#9&nbsp; 0x00007f91d66e71d2 in _fini () from =
mytrace.so<o:p></o:p></p><p class=3DMsoNormal>#10 0x00007f91d94f7f54 in =
?? () from /lib64/ld-linux-x86-64.so.2<o:p></o:p></p><p =
class=3DMsoNormal>#11 0x00007f91d7a652ed in exit () from =
/lib64/libc.so.6<o:p></o:p></p><p class=3DMsoNormal>#12 =
0x00007f91d64a9207 in wait_for_sessiond (sock_info=3D0x7f91d66cc640) at =
lttng-ust-comm.c:542<o:p></o:p></p><p class=3DMsoNormal>#13 =
0x00007f91d64a9545 in ust_listener_thread (arg=3D&lt;value optimized =
out&gt;) at lttng-ust-comm.c:669<o:p></o:p></p><p class=3DMsoNormal>#14 =
0x00007f91d82a5650 in start_thread () from =
/lib64/libpthread.so.0<o:p></o:p></p><p class=3DMsoNormal>#15 =
0x00007f91d7b0315d in clone () from /lib64/libc.so.6<o:p></o:p></p><p =
class=3DMsoNormal>#16 0x0000000000000000 in ?? ()<o:p></o:p></p><p =
class=3DMsoNormal>(gdb) p sessions_mutex<o:p></o:p></p><p =
class=3DMsoNormal>$1 =3D {__data =3D {__lock =3D 2, __count =3D 0, =
__owner =3D 21901, __nusers =3D 1, __kind =3D 0, __spins =3D 0, __list =
=3D {__prev =3D 0x0, __next =3D 0x0}}, <o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;__size =3D =
&quot;\002\000\000\000\000\000\000\000\215U\000\000\001&quot;, '\0' =
&lt;repeats 26 times&gt;, __align =3D 2}<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>What =
happened seems like this:<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>lttng_ust_init<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |-&gt; =
ust_listener_thread <o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<o:p></o:=
p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |-&gt; =
wait_for_sessiond <o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<o:p></o:p></p><p=
 =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;|-&gt; =
ust_lock&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:#1F497D'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;</span>(1)<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |-&gt; get_map_shm =
<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|=
<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |-&gt; get_wait_shm <o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-&gt; =
fork<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; parent -&gt; wait<span =
style=3D'color:#1F497D'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(2)=
<o:p></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; child&nbsp; -&gt; exit -&gt; _fini =
-&gt; __do_global_dtors_aux -&gt; ...... -&gt; ltt_probe_unregister =
-&gt; ust_lock =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(3)<o:p=
></o:p></p><p =
class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-&gt; =
ust_unlock&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span =
style=3D'color:#1F497D'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>(4)<o:p></o:p></=
p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Deadlock happened at point (1) and (3). Parent waited =
for child&#8217;s termination and child waited for parent to release the =
lock.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Reproduction conditions:<o:p></o:p></p><p =
class=3DMsoListParagraph style=3D'text-indent:-.25in;mso-list:l0 level1 =
lfo2'><![if !supportLists]><span style=3D'mso-list:Ignore'>-<span =
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></span><![endif]>First time to create share memory =
(/dev/shm/lttng-ust-apps-wait* don&#8217;t exist)<o:p></o:p></p><p =
class=3DMsoListParagraph style=3D'text-indent:-.25in;mso-list:l0 level1 =
lfo2'><![if !supportLists]><span style=3D'mso-list:Ignore'>-<span =
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></span><![endif]>Child process got delayed( I&#8217;m not quite =
sure with this, I used gdb to hold child process for a while and it =
happened either)<o:p></o:p></p><p class=3DMsoNormal><span =
style=3D'color:#1F497D'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal>In normal case, child process didn&#8217;t call _fini =
when it exited so that no deadlock happened.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Is this a =
known issue?<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>Thanks<o:p></o:p></p><p =
class=3DMsoNormal>-Zheng<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
------_=_NextPart_001_01CD9181.315F2495--


--===============1111082465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1111082465==--
