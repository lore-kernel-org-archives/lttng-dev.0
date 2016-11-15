From: Aravind HT <aravind.ht@gmail.com>
Subject: lttng upgrade to 2.8.1, need help.
Date: Wed, 16 Nov 2016 00:44:29 +0530
Message-ID: <CACd+_b4L0gDZac7c-pFY170C6kXEPCV5ugrf9zhprjYAwCAshQ__40120.3357534998$1479237288$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0162277448598966464=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it0-x229.google.com (mail-it0-x229.google.com
 [IPv6:2607:f8b0:4001:c0b::229])
 by lists.lttng.org (Postfix) with ESMTPS id 3tJHCr23pGzlQF
 for <lttng-dev@lists.lttng.org>; Tue, 15 Nov 2016 19:15:36 +0000 (UTC)
Received: by mail-it0-x229.google.com with SMTP id l8so22103517iti.1
 for <lttng-dev@lists.lttng.org>; Tue, 15 Nov 2016 11:14:31 -0800 (PST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0162277448598966464==
Content-Type: multipart/alternative; boundary=001a114c9ccc06515005415bc459

--001a114c9ccc06515005415bc459
Content-Type: text/plain; charset=UTF-8

Hi,


I was trying to upgrade to lttng-2.8.1 on my yocto build ( using
http://cgit.openembedded.org/cgit.cgi/openembedded-core/tree/meta/recipes-kernel/lttng/lttng-tools_git.bb?h=master)
and I am running into two sets of problems
1) "lttng stop <session-name>"command hanging/waiting for ever. ( Focus of
this mail )
2) hash-table related crashes being seen.( asserts, segmentation faults ) (
Not focussing on this in this mail. Will try to follow up with the details
for this. )



LTTNG HANGING :

With both versions of liburcu 0.8.6 and 0.9.2 (
http://cgit.openembedded.org/openembedded-core/tree/meta/recipes-support/liburcu/liburcu_0.9.2.bb)
I see this hang. I started out with 0.8.6 and saw issues and tried with
 0.9.2 but still the same.

1) 'lttng stop <session-name>' command just wait for data. I think the
hang has already happened and its just that we discover it at a user
level via this command.

A couple of markers to see that consumerd is hanging are :-

a. gdb'ing into consumerd ( 32bit and 64 bit, which ever as per the
above ) will show its doing a recvmsg() without returning

Thread 5 (Thread 0x7f43e27c5700 (LWP 3024)):
#0  0x00007f43e90b0b6d in recvmsg () at ../sysdeps/unix/syscall-template.S:81
#1  0x000000000042d2e7 in lttng_recvmsg_nosigpipe (msg=<optimized
out>, sockfd=<optimized out>) at ../../src/common/compat/socket.h:36
#2  lttcomm_recv_unix_sock (sock=26, buf=0x7f43e27c15c0, len=12668) at
unix.c:186
#3  0x00000000004231d1 in lttng_ustconsumer_request_metadata
(ctx=0x64f030, channel=0x7f43d00d5e90, timer=16384, timer@entry=0,
wait=0) at ust-consumer.c:2855
#4  0x000000000042655b in lttng_ustconsumer_sync_metadata
(ctx=0x64f030, metadata=0x7f43d00d9630) at ust-consumer.c:2275
#5  0x0000000000413350 in do_sync_metadata (ctx=<optimized out>,
metadata=<optimized out>) at consumer-stream.c:462
#6  consumer_stream_sync_metadata (ctx=0x64f030, session_id=0) at
consumer-stream.c:539
#7  0x0000000000422101 in lttng_ustconsumer_read_subbuffer
(stream=0x7f43d0088a90, ctx=0x64f030) at ust-consumer.c:2573

b. Launch a new app such that its part of an active session during this period.

The backend directory for this app will get created ( on the node on
which lttng_relayd is collecting traces <live-streaming> ), but the
directory itself will be empty (trace files of 0 bytes) and does not
show any traces.


2) The hang is partial where parts of sesssiond and consumerd are
found working ( ????, many threads in these components are working
while some are hung ).
1.b-above shows that its a partial hang. Some parts of tracing (
registration ) are working fine, while the flushing/clearing of traces
from subbuffers is not happening.


I have tried upgrading urcu libs, 0.8.6.x to 0.9.2.y and it doesnt seem to help.


3) The health-check feature is not picking this up immediately.

Complete stack traces for sessiond and consumerd below, not sure who
is hanging to whose neck :-)

####################################### COMPLETE STACK TRACES
##########################################

#### CONSUMERD-64 threads ####
Thread 8 (Thread 0x7f43e88f1700 (LWP 3021)):
#0  0x00007f43e8de6733 in epoll_wait () at ../sysdeps/unix/syscall-template.S:81
#1  0x000000000041f7c9 in compat_epoll_wait (events=0x7f43e88f0bc0,
timeout=-1) at compat-epoll.c:233
#2  0x00000000004056cd in thread_manage_health (data=0x14) at
health-consumerd.c:244
#3  0x00007f43e90a8294 in start_thread (arg=0x7f43e88f1700) at
pthread_create.c:336
#4  0x00007f43e8de613d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 7 (Thread 0x7f43e37c7700 (LWP 3022)):
#0  0x00007f43e8de6733 in epoll_wait () at ../sysdeps/unix/syscall-template.S:81
#1  0x000000000041f7c9 in compat_epoll_wait (events=0x7f43e37c6bb0,
timeout=-1) at compat-epoll.c:233
#2  0x000000000040d8af in consumer_thread_channel_poll (data=0x16) at
consumer.c:2855
#3  0x00007f43e90a8294 in start_thread (arg=0x7f43e37c7700) at
pthread_create.c:336
#4  0x00007f43e8de613d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 6 (Thread 0x7f43e2fc6700 (LWP 3023)):
#0  0x00007f43e8de6733 in epoll_wait () at ../sysdeps/unix/syscall-template.S:81
#1  0x000000000041f7c9 in compat_epoll_wait (events=0x7f43e2fc5bb0,
timeout=-1) at compat-epoll.c:233
#2  0x000000000040b4ae in consumer_thread_metadata_poll
(data=0x64f030) at consumer.c:2272
#3  0x00007f43e90a8294 in start_thread (arg=0x7f43e2fc6700) at
pthread_create.c:336
#4  0x00007f43e8de613d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 5 (Thread 0x7f43e27c5700 (LWP 3024)):
#0  0x00007f43e90b0b6d in recvmsg () at ../sysdeps/unix/syscall-template.S:81
#1  0x000000000042d2e7 in lttng_recvmsg_nosigpipe (msg=<optimized
out>, sockfd=<optimized out>) at ../../src/common/compat/socket.h:36
#2  lttcomm_recv_unix_sock (sock=26, buf=0x7f43e27c15c0, len=12668) at
unix.c:186
#3  0x00000000004231d1 in lttng_ustconsumer_request_metadata
(ctx=0x64f030, channel=0x7f43d00d5e90, timer=16384, timer@entry=0,
wait=0) at ust-consumer.c:2855
#4  0x000000000042655b in lttng_ustconsumer_sync_metadata
(ctx=0x64f030, metadata=0x7f43d00d9630) at ust-consumer.c:2275
#5  0x0000000000413350 in do_sync_metadata (ctx=<optimized out>,
metadata=<optimized out>) at consumer-stream.c:462
#6  consumer_stream_sync_metadata (ctx=0x64f030, session_id=0) at
consumer-stream.c:539
#7  0x0000000000422101 in lttng_ustconsumer_read_subbuffer
(stream=0x7f43d0088a90, ctx=0x64f030) at ust-consumer.c:2573
#8  0x000000000040f75c in lttng_consumer_read_subbuffer
(stream=0x7f43d0088a90, ctx=0x64f030) at consumer.c:3271
#9  0x000000000040c765 in consumer_thread_data_poll (data=0x1a) at
consumer.c:2637
#10 0x00007f43e90a8294 in start_thread (arg=0x7f43e27c5700) at
pthread_create.c:336
#11 0x00007f43e8de613d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 4 (Thread 0x7f43dbfff700 (LWP 3025)):
#0  0x00007f43e8ddabcd in poll () at ../sysdeps/unix/syscall-template.S:81
#1  0x0000000000408992 in lttng_consumer_poll_socket
(consumer_sockpoll=0x7f43dbffebc0) at consumer.c:1134
#2  0x000000000040f23b in consumer_thread_sessiond_poll
(data=0x64f030) at consumer.c:3173
#3  0x00007f43e90a8294 in start_thread (arg=0x7f43dbfff700) at
pthread_create.c:336
#4  0x00007f43e8de613d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 3 (Thread 0x7f43e1fc4700 (LWP 3026)):
#0  0x00007f43e8d3219f in do_sigwaitinfo (set=<optimized out>,
set@entry=0x7f43e1fc3ad0, info=info@entry=0x7f43e1fc3b50) at
../sysdeps/unix/sysv/linux/sigwaitinfo.c:55
#1  0x00007f43e8d3223d in __GI___sigwaitinfo (set=0x7f43e1fc3ad0,
info=0x7f43e1fc3b50) at ../sysdeps/unix/sysv/linux/sigwaitinfo.c:80
#2  0x0000000000411996 in consumer_timer_thread (data=0x64f030) at
consumer-timer.c:576
#3  0x00007f43e90a8294 in start_thread (arg=0x7f43e1fc4700) at
pthread_create.c:336
#4  0x00007f43e8de613d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 2 (Thread 0x7f43cbafd700 (LWP 8020)):
---Type <return> to continue, or q <return> to quit---
#0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
#1  0x00007f43e9b1aa00 in futex (val3=<optimized out>,
uaddr2=<optimized out>, timeout=<optimized out>, val=<optimized out>,
op=<optimized out>, uaddr=<optimized out>)
    at /usr/src/debug/liburcu/0.9.2-r0/userspace-rcu-0.9.2/urcu/futex.h:65
#2  futex_async (timeout=<optimized out>, uaddr2=<optimized out>,
val3=<optimized out>, val=<optimized out>, op=<optimized out>,
uaddr=<optimized out>)
    at /usr/src/debug/liburcu/0.9.2-r0/userspace-rcu-0.9.2/urcu/futex.h:97
#3  wait_gp () at /usr/src/debug/liburcu/0.9.2-r0/userspace-rcu-0.9.2/urcu.c:244
#4  wait_for_readers (input_readers=0x7f43cbafcbe0,
cur_snap_readers=0x0, qsreaders=0x7f43cbafcbf0) at
/usr/src/debug/liburcu/0.9.2-r0/userspace-rcu-0.9.2/urcu.c:327
#5  0x00007f43e9b1abd0 in synchronize_rcu_memb () at
/usr/src/debug/liburcu/0.9.2-r0/userspace-rcu-0.9.2/urcu.c:468
#6  0x00007f43e9b1b254 in call_rcu_thread (arg=0x7f43d0012bd0) at
/usr/src/debug/liburcu/0.9.2-r0/userspace-rcu-0.9.2/urcu-call-rcu-impl.h:362
#7  0x00007f43e90a8294 in start_thread (arg=0x7f43cbafd700) at
pthread_create.c:336
#8  0x00007f43e8de613d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 1 (Thread 0x7f43e9f39980 (LWP 3017)):
#0  0x00007f43e90a945d in pthread_join (threadid=139929430522320,
thread_return=0x0) at pthread_join.c:90
#1  0x0000000000404fc8 in main (argc=0, argv=0x0) at lttng-consumerd.c:590



################# sessiond threads ########################



Thread 12 (Thread 0x7ff72976b700 (LWP 1697)):
#0  0x00007ff72a386733 in epoll_wait () at ../sysdeps/unix/syscall-template.S:81
#1  0x000000000045f9c9 in compat_epoll_wait (events=0x7ff72976ab30,
timeout=-1) at compat-epoll.c:233
#2  0x000000000042528a in thread_ht_cleanup (data=0xc) at ht-cleanup.c:71
#3  0x00007ff72a84c294 in start_thread (arg=0x7ff72976b700) at
pthread_create.c:336
#4  0x00007ff72a38613d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 11 (Thread 0x7ff723fff700 (LWP 1699)):
#0  0x00007ff72a386733 in epoll_wait () at ../sysdeps/unix/syscall-template.S:81
#1  0x000000000045f9c9 in compat_epoll_wait (events=0x7ff723ffeb40,
timeout=-1) at compat-epoll.c:233
#2  0x000000000044c0cd in thread_manage_health (data=0x1c) at main.c:4264
#3  0x00007ff72a84c294 in start_thread (arg=0x7ff723fff700) at
pthread_create.c:336
#4  0x00007ff72a38613d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 10 (Thread 0x7ff7237fe700 (LWP 1700)):
#0  0x00007ff72a386733 in epoll_wait () at ../sysdeps/unix/syscall-template.S:81
#1  0x000000000045f9c9 in compat_epoll_wait (events=0x7ff7237fdb30,
timeout=-1) at compat-epoll.c:233
#2  0x000000000044b235 in thread_manage_clients (data=0x17) at main.c:4443
#3  0x00007ff72a84c294 in start_thread (arg=0x7ff7237fe700) at
pthread_create.c:336
#4  0x00007ff72a38613d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 9 (Thread 0x7ff722ffd700 (LWP 1701)):
#0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
#1  0x0000000000457962 in futex (val3=<optimized out>,
uaddr2=<optimized out>, timeout=<optimized out>, val=<optimized out>,
op=<optimized out>, uaddr=<optimized out>)
    at /build/home/htaravind/yocto-1.8/build/tmp/sysroots/re-64b/usr/include/urcu/futex.h:65
#2  futex_async (timeout=<optimized out>, uaddr2=<optimized out>,
val3=<optimized out>, val=<optimized out>, op=<optimized out>,
uaddr=<optimized out>)
    at /build/home/htaravind/yocto-1.8/build/tmp/sysroots/re-64b/usr/include/urcu/futex.h:97
#3  futex_nto1_wait (futex=0x69e0c0 <ust_cmd_queue>) at futex.c:91
#4  0x0000000000444d24 in thread_dispatch_ust_registration
(data=0x69e0c0 <ust_cmd_queue>) at main.c:2100
#5  0x00007ff72a84c294 in start_thread (arg=0x7ff722ffd700) at
pthread_create.c:336
#6  0x00007ff72a38613d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 8 (Thread 0x7ff7227fc700 (LWP 1702)):
#0  0x00007ff72a386733 in epoll_wait () at ../sysdeps/unix/syscall-template.S:81
#1  0x000000000045f9c9 in compat_epoll_wait (events=0x7ff7227fbb30,
timeout=-1) at compat-epoll.c:233
#2  0x000000000044323a in thread_registration_apps (data=0x16) at main.c:2197
#3  0x00007ff72a84c294 in start_thread (arg=0x7ff7227fc700) at
pthread_create.c:336
#4  0x00007ff72a38613d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 7 (Thread 0x7ff721ffb700 (LWP 1703)):
#0  0x00007ff72a386733 in epoll_wait () at ../sysdeps/unix/syscall-template.S:81
#1  0x000000000045f9c9 in compat_epoll_wait (events=0x7ff721ffab30,
timeout=-1) at compat-epoll.c:233
#2  0x0000000000442b7a in thread_manage_apps (data=0x1a) at main.c:1638
#3  0x00007ff72a84c294 in start_thread (arg=0x7ff721ffb700) at
pthread_create.c:336
#4  0x00007ff72a38613d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 6 (Thread 0x7ff7217fa700 (LWP 1704)):
#0  0x00007ff72a386733 in epoll_wait () at ../sysdeps/unix/syscall-template.S:81
#1  0x000000000045f9c9 in compat_epoll_wait (events=0x7ff7217f9b30,
timeout=-1) at compat-epoll.c:233
#2  0x000000000043f554 in ust_thread_manage_notify (data=0x15) at
ust-thread.c:74
---Type <return> to continue, or q <return> to quit---
#3  0x00007ff72a84c294 in start_thread (arg=0x7ff7217fa700) at
pthread_create.c:336
#4  0x00007ff72a38613d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 5 (Thread 0x7ff720ff9700 (LWP 1705)):
#0  0x00007ff72a386733 in epoll_wait () at ../sysdeps/unix/syscall-template.S:81
#1  0x000000000045f9c9 in compat_epoll_wait (events=0x7ff720ff8b30,
timeout=-1) at compat-epoll.c:233
#2  0x00000000004412cd in agent_thread_manage_registration (data=0x18)
at agent-thread.c:267
#3  0x00007ff72a84c294 in start_thread (arg=0x7ff720ff9700) at
pthread_create.c:336
#4  0x00007ff72a38613d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 4 (Thread 0x7ff7207f8700 (LWP 3018)):
#0  0x00007ff72a386733 in epoll_wait () at ../sysdeps/unix/syscall-template.S:81
#1  0x000000000045f9c9 in compat_epoll_wait (events=0x7ff7207f7b30,
timeout=-1) at compat-epoll.c:233
#2  0x0000000000446528 in thread_manage_consumer (data=0x699a40
<ustconsumer64_data>) at main.c:1449
#3  0x00007ff72a84c294 in start_thread (arg=0x7ff7207f8700) at
pthread_create.c:336
#4  0x00007ff72a38613d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 3 (Thread 0x7ff71fff7700 (LWP 3028)):
#0  0x00007ff72a386733 in epoll_wait () at ../sysdeps/unix/syscall-template.S:81
#1  0x000000000045f9c9 in compat_epoll_wait (events=0x7ff71fff6b30,
timeout=-1) at compat-epoll.c:233
#2  0x0000000000446528 in thread_manage_consumer (data=0x697900
<ustconsumer32_data>) at main.c:1449
#3  0x00007ff72a84c294 in start_thread (arg=0x7ff71fff7700) at
pthread_create.c:336
#4  0x00007ff72a38613d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 2 (Thread 0x7ff71f7f6700 (LWP 3036)):
#0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
#1  0x00007ff72b61256a in futex (val3=<optimized out>,
uaddr2=<optimized out>, timeout=<optimized out>, val=<optimized out>,
op=<optimized out>, uaddr=<optimized out>)
    at /usr/src/debug/liburcu/0.9.2-r0/userspace-rcu-0.9.2/urcu/futex.h:65
#2  futex_async (timeout=<optimized out>, uaddr2=<optimized out>,
val3=<optimized out>, val=<optimized out>, op=<optimized out>,
uaddr=<optimized out>)
    at /usr/src/debug/liburcu/0.9.2-r0/userspace-rcu-0.9.2/urcu/futex.h:97
#3  call_rcu_wait (crdp=<optimized out>) at
/usr/src/debug/liburcu/0.9.2-r0/userspace-rcu-0.9.2/urcu-call-rcu-impl.h:246
#4  call_rcu_thread (arg=0x7ff71402dbb0) at
/usr/src/debug/liburcu/0.9.2-r0/userspace-rcu-0.9.2/urcu-call-rcu-impl.h:381
#5  0x00007ff72a84c294 in start_thread (arg=0x7ff71f7f6700) at
pthread_create.c:336
#6  0x00007ff72a38613d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Thread 1 (Thread 0x7ff72bc6ca00 (LWP 1611)):
#0  0x00007ff72a84d45d in pthread_join (threadid=140699387271632,
thread_return=0x0) at pthread_join.c:90
#1  0x000000000040c136 in main (argc=0, argv=0x0) at main.c:6161




Kindly let me know if you need more info, this is blocking my upgrade.


Regards,
Aravind.

--001a114c9ccc06515005415bc459
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div><br></div><div>I was trying to upgr=
ade to lttng-2.8.1 on my yocto build ( using <a href=3D"http://cgit.openemb=
edded.org/cgit.cgi/openembedded-core/tree/meta/recipes-kernel/lttng/lttng-t=
ools_git.bb?h=3Dmaster">http://cgit.openembedded.org/cgit.cgi/openembedded-=
core/tree/meta/recipes-kernel/lttng/lttng-tools_git.bb?h=3Dmaster</a>) and =
I am running into two sets of problems</div><div>1) &quot;lttng stop &lt;se=
ssion-name&gt;&quot;command hanging/waiting for ever. ( Focus of this mail =
)</div><div>2) hash-table related crashes being seen.( asserts, segmentatio=
n faults ) ( Not focussing on this in this mail. Will try to follow up with=
 the details for this. )</div><div><br></div><div><br></div><div><br></div>=
<div>LTTNG HANGING :</div><div><br></div><div>With both versions of liburcu=
 0.8.6 and 0.9.2 (<a href=3D"http://cgit.openembedded.org/openembedded-core=
/tree/meta/recipes-support/liburcu/liburcu_0.9.2.bb">http://cgit.openembedd=
ed.org/openembedded-core/tree/meta/recipes-support/liburcu/liburcu_0.9.2.bb=
</a>) I see this hang. I started out with 0.8.6 and saw issues and tried wi=
th =C2=A00.9.2 but still the same.</div><div><br></div><div><pre style=3D"m=
argin-top:0px;margin-bottom:0px;padding:0px;white-space:pre-wrap;word-wrap:=
break-word;font-size:13px;word-break:normal;color:black">1) &#39;lttng stop=
 &lt;session-name&gt;&#39; command just wait for data. I think the hang has=
 already happened and its just that we discover it at a user level via this=
 command.
<br></pre><pre style=3D"margin-top:0px;margin-bottom:0px;padding:0px;white-=
space:pre-wrap;word-wrap:break-word;font-size:13px;word-break:normal;color:=
black">A couple of markers to see that consumerd is hanging are :-
<br></pre><pre style=3D"margin-top:0px;margin-bottom:0px;padding:0px;white-=
space:pre-wrap;word-wrap:break-word;font-size:13px;word-break:normal;color:=
black">a. gdb&#39;ing into consumerd ( 32bit and 64 bit, which ever as per =
the above ) will show its doing a recvmsg() without returning<br></pre><pre=
 style=3D"margin-top:0px;margin-bottom:0px;padding:0px;white-space:pre-wrap=
;word-wrap:break-word;font-size:13px;word-break:normal;color:black">Thread =
5 (Thread 0x7f43e27c5700 (LWP 3024)):
#0  0x00007f43e90b0b6d in recvmsg () at ../sysdeps/unix/syscall-template.S:=
81
#1  0x000000000042d2e7 in lttng_recvmsg_nosigpipe (msg=3D&lt;optimized out&=
gt;, sockfd=3D&lt;optimized out&gt;) at ../../src/common/compat/socket.h:36
#2  lttcomm_recv_unix_sock (sock=3D26, buf=3D0x7f43e27c15c0, len=3D12668) a=
t unix.c:186
#3  0x00000000004231d1 in lttng_ustconsumer_request_metadata (ctx=3D0x64f03=
0, channel=3D0x7f43d00d5e90, timer=3D16384, timer@entry=3D0, wait=3D0) at u=
st-consumer.c:2855
#4  0x000000000042655b in lttng_ustconsumer_sync_metadata (ctx=3D0x64f030, =
metadata=3D0x7f43d00d9630) at ust-consumer.c:2275
#5  0x0000000000413350 in do_sync_metadata (ctx=3D&lt;optimized out&gt;, me=
tadata=3D&lt;optimized out&gt;) at consumer-stream.c:462
#6  consumer_stream_sync_metadata (ctx=3D0x64f030, session_id=3D0) at consu=
mer-stream.c:539
#7  0x0000000000422101 in lttng_ustconsumer_read_subbuffer (stream=3D0x7f43=
d0088a90, ctx=3D0x64f030) at ust-consumer.c:2573

b. Launch a new app such that its part of an active session during this per=
iod.</pre><pre style=3D"margin-top:0px;margin-bottom:0px;padding:0px;white-=
space:pre-wrap;word-wrap:break-word;font-size:13px;word-break:normal;color:=
black">The backend directory for this app will get created ( on the node on=
 which lttng_relayd is collecting traces &lt;live-streaming&gt; ), but the =
directory itself will be empty (trace files of 0 bytes) and does not show a=
ny traces. </pre><pre style=3D"margin-top:0px;margin-bottom:0px;padding:0px=
;white-space:pre-wrap;word-wrap:break-word;font-size:13px;word-break:normal=
;color:black"><br></pre><pre style=3D"margin-top:0px;margin-bottom:0px;padd=
ing:0px;white-space:pre-wrap;word-wrap:break-word;font-size:13px;word-break=
:normal;color:black">2) The hang is partial where parts of sesssiond and co=
nsumerd are found working ( ????, many threads in these components are work=
ing while some are hung ).=20
1.b-above shows that its a partial hang. Some parts of tracing ( registrati=
on ) are working fine, while the flushing/clearing of traces from subbuffer=
s is not happening.


I have tried upgrading urcu libs, 0.8.6.x to 0.9.2.y and it doesnt seem to =
help.


3) The health-check feature is not picking this up immediately.

Complete stack traces for sessiond and consumerd below, not sure who is han=
ging to whose neck :-)</pre><pre style=3D"margin-top:0px;margin-bottom:0px;=
padding:0px;white-space:pre-wrap;word-wrap:break-word;font-size:13px;word-b=
reak:normal;color:black">####################################### COMPLETE S=
TACK TRACES ##########################################

#### CONSUMERD-64 threads ####
Thread 8 (Thread 0x7f43e88f1700 (LWP 3021)):
#0  0x00007f43e8de6733 in epoll_wait () at ../sysdeps/unix/syscall-template=
.S:81
#1  0x000000000041f7c9 in compat_epoll_wait (events=3D0x7f43e88f0bc0, timeo=
ut=3D-1) at compat-epoll.c:233
#2  0x00000000004056cd in thread_manage_health (data=3D0x14) at health-cons=
umerd.c:244
#3  0x00007f43e90a8294 in start_thread (arg=3D0x7f43e88f1700) at pthread_cr=
eate.c:336
#4  0x00007f43e8de613d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:109

Thread 7 (Thread 0x7f43e37c7700 (LWP 3022)):
#0  0x00007f43e8de6733 in epoll_wait () at ../sysdeps/unix/syscall-template=
.S:81
#1  0x000000000041f7c9 in compat_epoll_wait (events=3D0x7f43e37c6bb0, timeo=
ut=3D-1) at compat-epoll.c:233
#2  0x000000000040d8af in consumer_thread_channel_poll (data=3D0x16) at con=
sumer.c:2855
#3  0x00007f43e90a8294 in start_thread (arg=3D0x7f43e37c7700) at pthread_cr=
eate.c:336
#4  0x00007f43e8de613d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:109

Thread 6 (Thread 0x7f43e2fc6700 (LWP 3023)):
#0  0x00007f43e8de6733 in epoll_wait () at ../sysdeps/unix/syscall-template=
.S:81
#1  0x000000000041f7c9 in compat_epoll_wait (events=3D0x7f43e2fc5bb0, timeo=
ut=3D-1) at compat-epoll.c:233
#2  0x000000000040b4ae in consumer_thread_metadata_poll (data=3D0x64f030) a=
t consumer.c:2272
#3  0x00007f43e90a8294 in start_thread (arg=3D0x7f43e2fc6700) at pthread_cr=
eate.c:336
#4  0x00007f43e8de613d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:109

Thread 5 (Thread 0x7f43e27c5700 (LWP 3024)):
#0  0x00007f43e90b0b6d in recvmsg () at ../sysdeps/unix/syscall-template.S:=
81
#1  0x000000000042d2e7 in lttng_recvmsg_nosigpipe (msg=3D&lt;optimized out&=
gt;, sockfd=3D&lt;optimized out&gt;) at ../../src/common/compat/socket.h:36
#2  lttcomm_recv_unix_sock (sock=3D26, buf=3D0x7f43e27c15c0, len=3D12668) a=
t unix.c:186
#3  0x00000000004231d1 in lttng_ustconsumer_request_metadata (ctx=3D0x64f03=
0, channel=3D0x7f43d00d5e90, timer=3D16384, timer@entry=3D0, wait=3D0) at u=
st-consumer.c:2855
#4  0x000000000042655b in lttng_ustconsumer_sync_metadata (ctx=3D0x64f030, =
metadata=3D0x7f43d00d9630) at ust-consumer.c:2275
#5  0x0000000000413350 in do_sync_metadata (ctx=3D&lt;optimized out&gt;, me=
tadata=3D&lt;optimized out&gt;) at consumer-stream.c:462
#6  consumer_stream_sync_metadata (ctx=3D0x64f030, session_id=3D0) at consu=
mer-stream.c:539
#7  0x0000000000422101 in lttng_ustconsumer_read_subbuffer (stream=3D0x7f43=
d0088a90, ctx=3D0x64f030) at ust-consumer.c:2573
#8  0x000000000040f75c in lttng_consumer_read_subbuffer (stream=3D0x7f43d00=
88a90, ctx=3D0x64f030) at consumer.c:3271
#9  0x000000000040c765 in consumer_thread_data_poll (data=3D0x1a) at consum=
er.c:2637
#10 0x00007f43e90a8294 in start_thread (arg=3D0x7f43e27c5700) at pthread_cr=
eate.c:336
#11 0x00007f43e8de613d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:109

Thread 4 (Thread 0x7f43dbfff700 (LWP 3025)):
#0  0x00007f43e8ddabcd in poll () at ../sysdeps/unix/syscall-template.S:81
#1  0x0000000000408992 in lttng_consumer_poll_socket (consumer_sockpoll=3D0=
x7f43dbffebc0) at consumer.c:1134
#2  0x000000000040f23b in consumer_thread_sessiond_poll (data=3D0x64f030) a=
t consumer.c:3173
#3  0x00007f43e90a8294 in start_thread (arg=3D0x7f43dbfff700) at pthread_cr=
eate.c:336
#4  0x00007f43e8de613d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:109

Thread 3 (Thread 0x7f43e1fc4700 (LWP 3026)):
#0  0x00007f43e8d3219f in do_sigwaitinfo (set=3D&lt;optimized out&gt;, set@=
entry=3D0x7f43e1fc3ad0, info=3Dinfo@entry=3D0x7f43e1fc3b50) at ../sysdeps/u=
nix/sysv/linux/sigwaitinfo.c:55
#1  0x00007f43e8d3223d in __GI___sigwaitinfo (set=3D0x7f43e1fc3ad0, info=3D=
0x7f43e1fc3b50) at ../sysdeps/unix/sysv/linux/sigwaitinfo.c:80
#2  0x0000000000411996 in consumer_timer_thread (data=3D0x64f030) at consum=
er-timer.c:576
#3  0x00007f43e90a8294 in start_thread (arg=3D0x7f43e1fc4700) at pthread_cr=
eate.c:336
#4  0x00007f43e8de613d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:109

Thread 2 (Thread 0x7f43cbafd700 (LWP 8020)):
---Type &lt;return&gt; to continue, or q &lt;return&gt; to quit---
#0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
#1  0x00007f43e9b1aa00 in futex (val3=3D&lt;optimized out&gt;, uaddr2=3D&lt=
;optimized out&gt;, timeout=3D&lt;optimized out&gt;, val=3D&lt;optimized ou=
t&gt;, op=3D&lt;optimized out&gt;, uaddr=3D&lt;optimized out&gt;)
    at /usr/src/debug/liburcu/0.9.2-r0/userspace-rcu-0.9.2/urcu/futex.h:65
#2  futex_async (timeout=3D&lt;optimized out&gt;, uaddr2=3D&lt;optimized ou=
t&gt;, val3=3D&lt;optimized out&gt;, val=3D&lt;optimized out&gt;, op=3D&lt;=
optimized out&gt;, uaddr=3D&lt;optimized out&gt;)
    at /usr/src/debug/liburcu/0.9.2-r0/userspace-rcu-0.9.2/urcu/futex.h:97
#3  wait_gp () at /usr/src/debug/liburcu/0.9.2-r0/userspace-rcu-0.9.2/urcu.=
c:244
#4  wait_for_readers (input_readers=3D0x7f43cbafcbe0, cur_snap_readers=3D0x=
0, qsreaders=3D0x7f43cbafcbf0) at /usr/src/debug/liburcu/0.9.2-r0/userspace=
-rcu-0.9.2/urcu.c:327
#5  0x00007f43e9b1abd0 in synchronize_rcu_memb () at /usr/src/debug/liburcu=
/0.9.2-r0/userspace-rcu-0.9.2/urcu.c:468
#6  0x00007f43e9b1b254 in call_rcu_thread (arg=3D0x7f43d0012bd0) at /usr/sr=
c/debug/liburcu/0.9.2-r0/userspace-rcu-0.9.2/urcu-call-rcu-impl.h:362
#7  0x00007f43e90a8294 in start_thread (arg=3D0x7f43cbafd700) at pthread_cr=
eate.c:336
#8  0x00007f43e8de613d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:109

Thread 1 (Thread 0x7f43e9f39980 (LWP 3017)):
#0  0x00007f43e90a945d in pthread_join (threadid=3D139929430522320, thread_=
return=3D0x0) at pthread_join.c:90
#1  0x0000000000404fc8 in main (argc=3D0, argv=3D0x0) at lttng-consumerd.c:=
590



################# sessiond threads ########################



Thread 12 (Thread 0x7ff72976b700 (LWP 1697)):
#0  0x00007ff72a386733 in epoll_wait () at ../sysdeps/unix/syscall-template=
.S:81
#1  0x000000000045f9c9 in compat_epoll_wait (events=3D0x7ff72976ab30, timeo=
ut=3D-1) at compat-epoll.c:233
#2  0x000000000042528a in thread_ht_cleanup (data=3D0xc) at ht-cleanup.c:71
#3  0x00007ff72a84c294 in start_thread (arg=3D0x7ff72976b700) at pthread_cr=
eate.c:336
#4  0x00007ff72a38613d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:109

Thread 11 (Thread 0x7ff723fff700 (LWP 1699)):
#0  0x00007ff72a386733 in epoll_wait () at ../sysdeps/unix/syscall-template=
.S:81
#1  0x000000000045f9c9 in compat_epoll_wait (events=3D0x7ff723ffeb40, timeo=
ut=3D-1) at compat-epoll.c:233
#2  0x000000000044c0cd in thread_manage_health (data=3D0x1c) at main.c:4264
#3  0x00007ff72a84c294 in start_thread (arg=3D0x7ff723fff700) at pthread_cr=
eate.c:336
#4  0x00007ff72a38613d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:109

Thread 10 (Thread 0x7ff7237fe700 (LWP 1700)):
#0  0x00007ff72a386733 in epoll_wait () at ../sysdeps/unix/syscall-template=
.S:81
#1  0x000000000045f9c9 in compat_epoll_wait (events=3D0x7ff7237fdb30, timeo=
ut=3D-1) at compat-epoll.c:233
#2  0x000000000044b235 in thread_manage_clients (data=3D0x17) at main.c:444=
3
#3  0x00007ff72a84c294 in start_thread (arg=3D0x7ff7237fe700) at pthread_cr=
eate.c:336
#4  0x00007ff72a38613d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:109

Thread 9 (Thread 0x7ff722ffd700 (LWP 1701)):
#0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
#1  0x0000000000457962 in futex (val3=3D&lt;optimized out&gt;, uaddr2=3D&lt=
;optimized out&gt;, timeout=3D&lt;optimized out&gt;, val=3D&lt;optimized ou=
t&gt;, op=3D&lt;optimized out&gt;, uaddr=3D&lt;optimized out&gt;)
    at /build/home/htaravind/yocto-1.8/build/tmp/sysroots/re-64b/usr/includ=
e/urcu/futex.h:65
#2  futex_async (timeout=3D&lt;optimized out&gt;, uaddr2=3D&lt;optimized ou=
t&gt;, val3=3D&lt;optimized out&gt;, val=3D&lt;optimized out&gt;, op=3D&lt;=
optimized out&gt;, uaddr=3D&lt;optimized out&gt;)
    at /build/home/htaravind/yocto-1.8/build/tmp/sysroots/re-64b/usr/includ=
e/urcu/futex.h:97
#3  futex_nto1_wait (futex=3D0x69e0c0 &lt;ust_cmd_queue&gt;) at futex.c:91
#4  0x0000000000444d24 in thread_dispatch_ust_registration (data=3D0x69e0c0=
 &lt;ust_cmd_queue&gt;) at main.c:2100
#5  0x00007ff72a84c294 in start_thread (arg=3D0x7ff722ffd700) at pthread_cr=
eate.c:336
#6  0x00007ff72a38613d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:109

Thread 8 (Thread 0x7ff7227fc700 (LWP 1702)):
#0  0x00007ff72a386733 in epoll_wait () at ../sysdeps/unix/syscall-template=
.S:81
#1  0x000000000045f9c9 in compat_epoll_wait (events=3D0x7ff7227fbb30, timeo=
ut=3D-1) at compat-epoll.c:233
#2  0x000000000044323a in thread_registration_apps (data=3D0x16) at main.c:=
2197
#3  0x00007ff72a84c294 in start_thread (arg=3D0x7ff7227fc700) at pthread_cr=
eate.c:336
#4  0x00007ff72a38613d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:109

Thread 7 (Thread 0x7ff721ffb700 (LWP 1703)):
#0  0x00007ff72a386733 in epoll_wait () at ../sysdeps/unix/syscall-template=
.S:81
#1  0x000000000045f9c9 in compat_epoll_wait (events=3D0x7ff721ffab30, timeo=
ut=3D-1) at compat-epoll.c:233
#2  0x0000000000442b7a in thread_manage_apps (data=3D0x1a) at main.c:1638
#3  0x00007ff72a84c294 in start_thread (arg=3D0x7ff721ffb700) at pthread_cr=
eate.c:336
#4  0x00007ff72a38613d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:109

Thread 6 (Thread 0x7ff7217fa700 (LWP 1704)):
#0  0x00007ff72a386733 in epoll_wait () at ../sysdeps/unix/syscall-template=
.S:81
#1  0x000000000045f9c9 in compat_epoll_wait (events=3D0x7ff7217f9b30, timeo=
ut=3D-1) at compat-epoll.c:233
#2  0x000000000043f554 in ust_thread_manage_notify (data=3D0x15) at ust-thr=
ead.c:74
---Type &lt;return&gt; to continue, or q &lt;return&gt; to quit---
#3  0x00007ff72a84c294 in start_thread (arg=3D0x7ff7217fa700) at pthread_cr=
eate.c:336
#4  0x00007ff72a38613d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:109

Thread 5 (Thread 0x7ff720ff9700 (LWP 1705)):
#0  0x00007ff72a386733 in epoll_wait () at ../sysdeps/unix/syscall-template=
.S:81
#1  0x000000000045f9c9 in compat_epoll_wait (events=3D0x7ff720ff8b30, timeo=
ut=3D-1) at compat-epoll.c:233
#2  0x00000000004412cd in agent_thread_manage_registration (data=3D0x18) at=
 agent-thread.c:267
#3  0x00007ff72a84c294 in start_thread (arg=3D0x7ff720ff9700) at pthread_cr=
eate.c:336
#4  0x00007ff72a38613d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:109

Thread 4 (Thread 0x7ff7207f8700 (LWP 3018)):
#0  0x00007ff72a386733 in epoll_wait () at ../sysdeps/unix/syscall-template=
.S:81
#1  0x000000000045f9c9 in compat_epoll_wait (events=3D0x7ff7207f7b30, timeo=
ut=3D-1) at compat-epoll.c:233
#2  0x0000000000446528 in thread_manage_consumer (data=3D0x699a40 &lt;ustco=
nsumer64_data&gt;) at main.c:1449
#3  0x00007ff72a84c294 in start_thread (arg=3D0x7ff7207f8700) at pthread_cr=
eate.c:336
#4  0x00007ff72a38613d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:109

Thread 3 (Thread 0x7ff71fff7700 (LWP 3028)):
#0  0x00007ff72a386733 in epoll_wait () at ../sysdeps/unix/syscall-template=
.S:81
#1  0x000000000045f9c9 in compat_epoll_wait (events=3D0x7ff71fff6b30, timeo=
ut=3D-1) at compat-epoll.c:233
#2  0x0000000000446528 in thread_manage_consumer (data=3D0x697900 &lt;ustco=
nsumer32_data&gt;) at main.c:1449
#3  0x00007ff72a84c294 in start_thread (arg=3D0x7ff71fff7700) at pthread_cr=
eate.c:336
#4  0x00007ff72a38613d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:109

Thread 2 (Thread 0x7ff71f7f6700 (LWP 3036)):
#0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
#1  0x00007ff72b61256a in futex (val3=3D&lt;optimized out&gt;, uaddr2=3D&lt=
;optimized out&gt;, timeout=3D&lt;optimized out&gt;, val=3D&lt;optimized ou=
t&gt;, op=3D&lt;optimized out&gt;, uaddr=3D&lt;optimized out&gt;)
    at /usr/src/debug/liburcu/0.9.2-r0/userspace-rcu-0.9.2/urcu/futex.h:65
#2  futex_async (timeout=3D&lt;optimized out&gt;, uaddr2=3D&lt;optimized ou=
t&gt;, val3=3D&lt;optimized out&gt;, val=3D&lt;optimized out&gt;, op=3D&lt;=
optimized out&gt;, uaddr=3D&lt;optimized out&gt;)
    at /usr/src/debug/liburcu/0.9.2-r0/userspace-rcu-0.9.2/urcu/futex.h:97
#3  call_rcu_wait (crdp=3D&lt;optimized out&gt;) at /usr/src/debug/liburcu/=
0.9.2-r0/userspace-rcu-0.9.2/urcu-call-rcu-impl.h:246
#4  call_rcu_thread (arg=3D0x7ff71402dbb0) at /usr/src/debug/liburcu/0.9.2-=
r0/userspace-rcu-0.9.2/urcu-call-rcu-impl.h:381
#5  0x00007ff72a84c294 in start_thread (arg=3D0x7ff71f7f6700) at pthread_cr=
eate.c:336
#6  0x00007ff72a38613d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:109

Thread 1 (Thread 0x7ff72bc6ca00 (LWP 1611)):
#0  0x00007ff72a84d45d in pthread_join (threadid=3D140699387271632, thread_=
return=3D0x0) at pthread_join.c:90
#1  0x000000000040c136 in main (argc=3D0, argv=3D0x0) at main.c:6161</pre><=
/div><div><br></div><div><br></div><div><br></div><div>Kindly let me know i=
f you need more info, this is blocking my upgrade.</div><div><br></div><div=
><br></div><div>Regards,</div><div>Aravind.<br><br></div><div><br></div></d=
iv>

--001a114c9ccc06515005415bc459--

--===============0162277448598966464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0162277448598966464==--
