From: kumar s <skumar.m226@gmail.com>
Subject: lttng-tools build error: non-dynamic relocations refer
 to dynamic symbol lttcomm_inet_tcp_timeout
Date: Wed, 27 Nov 2013 15:37:10 +0530
Message-ID: <CAO_ArvpzYu+bVKKi956eiObSd+sg-6Aarhy+h5MZqcDk5S-eqg__16553.6392866217$1385546884$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0635698130=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <skumar.m226@gmail.com>) id 1Vlc1d-00048t-3x
	for lttng-dev@lists.lttng.org; Wed, 27 Nov 2013 05:07:20 -0500
Received: by mail-lb0-f173.google.com with SMTP id u14so5265583lbd.18
	for <lttng-dev@lists.lttng.org>; Wed, 27 Nov 2013 02:07:11 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0635698130==
Content-Type: multipart/alternative; boundary=001a11c2662eae8d8f04ec25c227

--001a11c2662eae8d8f04ec25c227
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am getting non dynamic relocation error while trying to build
lttng-tools. I have configured the lttng-tools for mips-gcc.

Making all in src
make[1]: Entering directory `/home/shkumar/lttng-tools/lttng-tools/src'
Making all in common
make[2]: Entering directory
`/home/shkumar/lttng-tools/lttng-tools/src/common'
Making all in compat
make[3]: Entering directory
`/home/shkumar/lttng-tools/lttng-tools/src/common/compat'
  CC     compat-fcntl.lo
  CC     compat-epoll.lo
  CCLD   libcompat.la
make[3]: Leaving directory
`/home/shkumar/lttng-tools/lttng-tools/src/common/compat'
Making all in health
make[3]: Entering directory
`/home/shkumar/lttng-tools/lttng-tools/src/common/health'
  CC     health.lo
  CCLD   libhealth.la
make[3]: Leaving directory
`/home/shkumar/lttng-tools/lttng-tools/src/common/health'
Making all in hashtable
make[3]: Entering directory
`/home/shkumar/lttng-tools/lttng-tools/src/common/hashtable'
  CC     hashtable.lo
  CC     utils.lo
  CC     rculfhash.lo
  CC     rculfhash-mm-chunk.lo
  CC     rculfhash-mm-mmap.lo
  CC     rculfhash-mm-order.lo
  CCLD   libhashtable.la
make[3]: Leaving directory
`/home/shkumar/lttng-tools/lttng-tools/src/common/hashtable'
Making all in kernel-ctl
make[3]: Entering directory
`/home/shkumar/lttng-tools/lttng-tools/src/common/kernel-ctl'
  CC     kernel-ctl.lo
  CCLD   libkernel-ctl.la
make[3]: Leaving directory
`/home/shkumar/lttng-tools/lttng-tools/src/common/kernel-ctl'
Making all in sessiond-comm
make[3]: Entering directory
`/home/shkumar/lttng-tools/lttng-tools/src/common/sessiond-comm'
  CC     sessiond-comm.lo
  CC     unix.lo
  CC     inet.lo
  CC     inet6.lo
  CCLD   libsessiond-comm.la
make[3]: Leaving directory
`/home/shkumar/lttng-tools/lttng-tools/src/common/sessiond-comm'
Making all in relayd
make[3]: Entering directory
`/home/shkumar/lttng-tools/lttng-tools/src/common/relayd'
  CC     relayd.lo
  CCLD   librelayd.la
make[3]: Leaving directory
`/home/shkumar/lttng-tools/lttng-tools/src/common/relayd'
Making all in kernel-consumer
make[3]: Entering directory
`/home/shkumar/lttng-tools/lttng-tools/src/common/kernel-consumer'
  CC     kernel-consumer.lo
  CCLD   libkernel-consumer.la
make[3]: Leaving directory
`/home/shkumar/lttng-tools/lttng-tools/src/common/kernel-consumer'
Making all in ust-consumer
make[3]: Entering directory
`/home/shkumar/lttng-tools/lttng-tools/src/common/ust-consumer'
make[3]: Nothing to be done for `all'.
make[3]: Leaving directory
`/home/shkumar/lttng-tools/lttng-tools/src/common/ust-consumer'
Making all in testpoint
make[3]: Entering directory
`/home/shkumar/lttng-tools/lttng-tools/src/common/testpoint'
  CC     testpoint.lo
  CCLD   libtestpoint.la
make[3]: Leaving directory
`/home/shkumar/lttng-tools/lttng-tools/src/common/testpoint'
Making all in index
make[3]: Entering directory
`/home/shkumar/lttng-tools/lttng-tools/src/common/index'
  CC     index.lo
  CCLD   libindex.la
make[3]: Leaving directory
`/home/shkumar/lttng-tools/lttng-tools/src/common/index'
make[3]: Entering directory
`/home/shkumar/lttng-tools/lttng-tools/src/common'
  CC     error.lo
  CC     utils.lo
  CC     runas.lo
  CC     futex.lo
  CC     uri.lo
  CC     defaults.lo
  CC     pipe.lo
  CC     readwrite.lo
  CCLD   libcommon.la
  CC     consumer.lo
  CC     consumer-metadata-cache.lo
  CC     consumer-timer.lo
  CC     consumer-stream.lo
  CCLD   libconsumer.la
copying selected object files to avoid basename conflicts...
make[3]: Leaving directory
`/home/shkumar/lttng-tools/lttng-tools/src/common'
make[2]: Leaving directory
`/home/shkumar/lttng-tools/lttng-tools/src/common'
Making all in lib
make[2]: Entering directory `/home/shkumar/lttng-tools/lttng-tools/src/lib'
Making all in lttng-ctl
make[3]: Entering directory
`/home/shkumar/lttng-tools/lttng-tools/src/lib/lttng-ctl'
Making all in filter
make[4]: Entering directory
`/home/shkumar/lttng-tools/lttng-tools/src/lib/lttng-ctl/filter'
  YACC   filter-parser.c
updating filter-parser.h
updating filter-parser.output
make  all-am
make[5]: Entering directory
`/home/shkumar/lttng-tools/lttng-tools/src/lib/lttng-ctl/filter'
  LEX    filter-lexer.c
  CC     libfilter_la-filter-lexer.lo
  CC     libfilter_la-filter-parser.lo
  CC     libfilter_la-filter-visitor-set-parent.lo
  CC     libfilter_la-filter-visitor-xml.lo
  CC     libfilter_la-filter-visitor-generate-ir.lo
  CC     libfilter_la-filter-visitor-ir-check-binary-op-nesting.lo
  CC     libfilter_la-filter-visitor-generate-bytecode.lo
  CCLD   libfilter.la
  CC     filter-grammar-test.o
  CCLD   filter-grammar-test
make[5]: Leaving directory
`/home/shkumar/lttng-tools/lttng-tools/src/lib/lttng-ctl/filter'
make[4]: Leaving directory
`/home/shkumar/lttng-tools/lttng-tools/src/lib/lttng-ctl/filter'
make[4]: Entering directory
`/home/shkumar/lttng-tools/lttng-tools/src/lib/lttng-ctl'
  CC     lttng-ctl.lo
  CC     snapshot.lo
  CC     lttng-ctl-health.lo
  CCLD   liblttng-ctl.la
copying selected object files to avoid basename conflicts...
make[4]: Leaving directory
`/home/shkumar/lttng-tools/lttng-tools/src/lib/lttng-ctl'
make[3]: Leaving directory
`/home/shkumar/lttng-tools/lttng-tools/src/lib/lttng-ctl'
make[3]: Entering directory `/home/shkumar/lttng-tools/lttng-tools/src/lib'
make[3]: Nothing to be done for `all-am'.
make[3]: Leaving directory `/home/shkumar/lttng-tools/lttng-tools/src/lib'
make[2]: Leaving directory `/home/shkumar/lttng-tools/lttng-tools/src/lib'
Making all in bin
make[2]: Entering directory `/home/shkumar/lttng-tools/lttng-tools/src/bin'
Making all in lttng-consumerd
make[3]: Entering directory
`/home/shkumar/lttng-tools/lttng-tools/src/bin/lttng-consumerd'
  CC     lttng-consumerd.o
  CC     health-consumerd.o
  CCLD   lttng-consumerd
make[3]: Leaving directory
`/home/shkumar/lttng-tools/lttng-tools/src/bin/lttng-consumerd'
Making all in lttng
make[3]: Entering directory
`/home/shkumar/lttng-tools/lttng-tools/src/bin/lttng'
  CC     conf.o
  CC     commands/start.o
  CC     commands/list.o
  CC     commands/create.o
  CC     commands/destroy.o
  CC     commands/stop.o
  CC     commands/enable_events.o
  CC     commands/disable_events.o
  CC     commands/enable_channels.o
  CC     commands/disable_channels.o
  CC     commands/add_context.o
  CC     commands/set_session.o
  CC     commands/version.o
  CC     commands/calibrate.o
  CC     commands/view.o
  CC     commands/enable_consumer.o
  CC     commands/disable_consumer.o
  CC     commands/snapshot.o
  CC     utils.o
  CC     lttng.o
  CCLD   lttng
make[3]: Leaving directory
`/home/shkumar/lttng-tools/lttng-tools/src/bin/lttng'
Making all in lttng-sessiond
make[3]: Entering directory
`/home/shkumar/lttng-tools/lttng-tools/src/bin/lttng-sessiond'
  CC     utils.o
  CC     trace-kernel.o
  CC     kernel.o
  CC     context.o
  CC     channel.o
  CC     event.o
  CC     shm.o
  CC     consumer.o
  CC     session.o
  CC     modprobe.o
  CC     fd-limit.o
  CC     kernel-consumer.o
  CC     cmd.o
  CC     buffer-registry.o
  CC     ht-cleanup.o
  CC     snapshot.o
  CC     jul.o
  CC     main.o
main.c: In function 'thread_dispatch_ust_registration':
main.c:1564: warning: 'cds_wfq_dequeue_blocking' is deprecated (declared at
/home/shkumar/Development_Merge/NewOCT/popt-1.16/popt_installed/include/urcu/wfqueue.h:88)
main.c: In function 'thread_registration_apps':
main.c:1917: warning: 'cds_wfq_enqueue' is deprecated (declared at
/home/shkumar/Development_Merge/NewOCT/popt-1.16/popt_installed/include/urcu/wfqueue.h:76)
main.c: In function 'main':
main.c:4891: warning: 'cds_wfq_init' is deprecated (declared at
/home/shkumar/Development_Merge/NewOCT/popt-1.16/popt_installed/include/urcu/wfqueue.h:70)
  CCLD   lttng-sessiond
/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/tools-gcc-4.3/bin/../lib/gcc/mips64-octeon-linux-gnu/4.3.3/../../../../mips64-octeon-linux-gnu/bin/ld:
non-dynamic relocations refer to dynamic symbol lttcomm_inet_tcp_timeout
/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/tools-gcc-4.3/bin/../lib/gcc/mips64-octeon-linux-gnu/4.3.3/../../../../mips64-octeon-linux-gnu/bin/ld:
failed to set dynamic section sizes: Bad value
collect2: ld returned 1 exit status
make[3]: *** [lttng-sessiond] Error 1
make[3]: Leaving directory
`/home/shkumar/lttng-tools/lttng-tools/src/bin/lttng-sessiond'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/home/shkumar/lttng-tools/lttng-tools/src/bin'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/shkumar/lttng-tools/lttng-tools/src'
make: *** [all-recursive] Error 1

Thank you
Skumar

--001a11c2662eae8d8f04ec25c227
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>I am getting non dynamic=
 relocation error while trying to build lttng-tools. I have configured the =
lttng-tools for mips-gcc.</div><div><br></div><div>Making all in src</div>
<div>make[1]: Entering directory `/home/shkumar/lttng-tools/lttng-tools/src=
&#39;</div><div>Making all in common</div><div>make[2]: Entering directory =
`/home/shkumar/lttng-tools/lttng-tools/src/common&#39;</div><div>Making all=
 in compat</div>
<div>make[3]: Entering directory `/home/shkumar/lttng-tools/lttng-tools/src=
/common/compat&#39;</div><div>=A0 CC =A0 =A0 compat-fcntl.lo</div><div>=A0 =
CC =A0 =A0 compat-epoll.lo</div><div>=A0 CCLD =A0 <a href=3D"http://libcomp=
at.la">libcompat.la</a></div>
<div>make[3]: Leaving directory `/home/shkumar/lttng-tools/lttng-tools/src/=
common/compat&#39;</div><div>Making all in health</div><div>make[3]: Enteri=
ng directory `/home/shkumar/lttng-tools/lttng-tools/src/common/health&#39;<=
/div>
<div>=A0 CC =A0 =A0 health.lo</div><div>=A0 CCLD =A0 <a href=3D"http://libh=
ealth.la">libhealth.la</a></div><div>make[3]: Leaving directory `/home/shku=
mar/lttng-tools/lttng-tools/src/common/health&#39;</div><div>Making all in =
hashtable</div>
<div>make[3]: Entering directory `/home/shkumar/lttng-tools/lttng-tools/src=
/common/hashtable&#39;</div><div>=A0 CC =A0 =A0 hashtable.lo</div><div>=A0 =
CC =A0 =A0 utils.lo</div><div>=A0 CC =A0 =A0 rculfhash.lo</div><div>=A0 CC =
=A0 =A0 rculfhash-mm-chunk.lo</div>
<div>=A0 CC =A0 =A0 rculfhash-mm-mmap.lo</div><div>=A0 CC =A0 =A0 rculfhash=
-mm-order.lo</div><div>=A0 CCLD =A0 <a href=3D"http://libhashtable.la">libh=
ashtable.la</a></div><div>make[3]: Leaving directory `/home/shkumar/lttng-t=
ools/lttng-tools/src/common/hashtable&#39;</div>
<div>Making all in kernel-ctl</div><div>make[3]: Entering directory `/home/=
shkumar/lttng-tools/lttng-tools/src/common/kernel-ctl&#39;</div><div>=A0 CC=
 =A0 =A0 kernel-ctl.lo</div><div>=A0 CCLD =A0 <a href=3D"http://libkernel-c=
tl.la">libkernel-ctl.la</a></div>
<div>make[3]: Leaving directory `/home/shkumar/lttng-tools/lttng-tools/src/=
common/kernel-ctl&#39;</div><div>Making all in sessiond-comm</div><div>make=
[3]: Entering directory `/home/shkumar/lttng-tools/lttng-tools/src/common/s=
essiond-comm&#39;</div>
<div>=A0 CC =A0 =A0 sessiond-comm.lo</div><div>=A0 CC =A0 =A0 unix.lo</div>=
<div>=A0 CC =A0 =A0 inet.lo</div><div>=A0 CC =A0 =A0 inet6.lo</div><div>=A0=
 CCLD =A0 <a href=3D"http://libsessiond-comm.la">libsessiond-comm.la</a></d=
iv><div>make[3]: Leaving directory `/home/shkumar/lttng-tools/lttng-tools/s=
rc/common/sessiond-comm&#39;</div>
<div>Making all in relayd</div><div>make[3]: Entering directory `/home/shku=
mar/lttng-tools/lttng-tools/src/common/relayd&#39;</div><div>=A0 CC =A0 =A0=
 relayd.lo</div><div>=A0 CCLD =A0 <a href=3D"http://librelayd.la">librelayd=
.la</a></div>
<div>make[3]: Leaving directory `/home/shkumar/lttng-tools/lttng-tools/src/=
common/relayd&#39;</div><div>Making all in kernel-consumer</div><div>make[3=
]: Entering directory `/home/shkumar/lttng-tools/lttng-tools/src/common/ker=
nel-consumer&#39;</div>
<div>=A0 CC =A0 =A0 kernel-consumer.lo</div><div>=A0 CCLD =A0 <a href=3D"ht=
tp://libkernel-consumer.la">libkernel-consumer.la</a></div><div>make[3]: Le=
aving directory `/home/shkumar/lttng-tools/lttng-tools/src/common/kernel-co=
nsumer&#39;</div>
<div>Making all in ust-consumer</div><div>make[3]: Entering directory `/hom=
e/shkumar/lttng-tools/lttng-tools/src/common/ust-consumer&#39;</div><div>ma=
ke[3]: Nothing to be done for `all&#39;.</div><div>make[3]: Leaving directo=
ry `/home/shkumar/lttng-tools/lttng-tools/src/common/ust-consumer&#39;</div=
>
<div>Making all in testpoint</div><div>make[3]: Entering directory `/home/s=
hkumar/lttng-tools/lttng-tools/src/common/testpoint&#39;</div><div>=A0 CC =
=A0 =A0 testpoint.lo</div><div>=A0 CCLD =A0 <a href=3D"http://libtestpoint.=
la">libtestpoint.la</a></div>
<div>make[3]: Leaving directory `/home/shkumar/lttng-tools/lttng-tools/src/=
common/testpoint&#39;</div><div>Making all in index</div><div>make[3]: Ente=
ring directory `/home/shkumar/lttng-tools/lttng-tools/src/common/index&#39;=
</div>
<div>=A0 CC =A0 =A0 index.lo</div><div>=A0 CCLD =A0 <a href=3D"http://libin=
dex.la">libindex.la</a></div><div>make[3]: Leaving directory `/home/shkumar=
/lttng-tools/lttng-tools/src/common/index&#39;</div><div>make[3]: Entering =
directory `/home/shkumar/lttng-tools/lttng-tools/src/common&#39;</div>
<div>=A0 CC =A0 =A0 error.lo</div><div>=A0 CC =A0 =A0 utils.lo</div><div>=
=A0 CC =A0 =A0 runas.lo</div><div>=A0 CC =A0 =A0 futex.lo</div><div>=A0 CC =
=A0 =A0 uri.lo</div><div>=A0 CC =A0 =A0 defaults.lo</div><div>=A0 CC =A0 =
=A0 pipe.lo</div><div>=A0 CC =A0 =A0 readwrite.lo</div>
<div>=A0 CCLD =A0 <a href=3D"http://libcommon.la">libcommon.la</a></div><di=
v>=A0 CC =A0 =A0 consumer.lo</div><div>=A0 CC =A0 =A0 consumer-metadata-cac=
he.lo</div><div>=A0 CC =A0 =A0 consumer-timer.lo</div><div>=A0 CC =A0 =A0 c=
onsumer-stream.lo</div><div>
=A0 CCLD =A0 <a href=3D"http://libconsumer.la">libconsumer.la</a></div><div=
>copying selected object files to avoid basename conflicts...</div><div>mak=
e[3]: Leaving directory `/home/shkumar/lttng-tools/lttng-tools/src/common&#=
39;</div>
<div>make[2]: Leaving directory `/home/shkumar/lttng-tools/lttng-tools/src/=
common&#39;</div><div>Making all in lib</div><div>make[2]: Entering directo=
ry `/home/shkumar/lttng-tools/lttng-tools/src/lib&#39;</div><div>Making all=
 in lttng-ctl</div>
<div>make[3]: Entering directory `/home/shkumar/lttng-tools/lttng-tools/src=
/lib/lttng-ctl&#39;</div><div>Making all in filter</div><div>make[4]: Enter=
ing directory `/home/shkumar/lttng-tools/lttng-tools/src/lib/lttng-ctl/filt=
er&#39;</div>
<div>=A0 YACC =A0 filter-parser.c</div><div>updating filter-parser.h</div><=
div>updating filter-parser.output</div><div>make =A0all-am</div><div>make[5=
]: Entering directory `/home/shkumar/lttng-tools/lttng-tools/src/lib/lttng-=
ctl/filter&#39;</div>
<div>=A0 LEX =A0 =A0filter-lexer.c</div><div>=A0 CC =A0 =A0 libfilter_la-fi=
lter-lexer.lo</div><div>=A0 CC =A0 =A0 libfilter_la-filter-parser.lo</div><=
div>=A0 CC =A0 =A0 libfilter_la-filter-visitor-set-parent.lo</div><div>=A0 =
CC =A0 =A0 libfilter_la-filter-visitor-xml.lo</div>
<div>=A0 CC =A0 =A0 libfilter_la-filter-visitor-generate-ir.lo</div><div>=
=A0 CC =A0 =A0 libfilter_la-filter-visitor-ir-check-binary-op-nesting.lo</d=
iv><div>=A0 CC =A0 =A0 libfilter_la-filter-visitor-generate-bytecode.lo</di=
v><div>=A0 CCLD =A0 <a href=3D"http://libfilter.la">libfilter.la</a></div>
<div>=A0 CC =A0 =A0 filter-grammar-test.o</div><div>=A0 CCLD =A0 filter-gra=
mmar-test</div><div>make[5]: Leaving directory `/home/shkumar/lttng-tools/l=
ttng-tools/src/lib/lttng-ctl/filter&#39;</div><div>make[4]: Leaving directo=
ry `/home/shkumar/lttng-tools/lttng-tools/src/lib/lttng-ctl/filter&#39;</di=
v>
<div>make[4]: Entering directory `/home/shkumar/lttng-tools/lttng-tools/src=
/lib/lttng-ctl&#39;</div><div>=A0 CC =A0 =A0 lttng-ctl.lo</div><div>=A0 CC =
=A0 =A0 snapshot.lo</div><div>=A0 CC =A0 =A0 lttng-ctl-health.lo</div><div>=
=A0 CCLD =A0 <a href=3D"http://liblttng-ctl.la">liblttng-ctl.la</a></div>
<div>copying selected object files to avoid basename conflicts...</div><div=
>make[4]: Leaving directory `/home/shkumar/lttng-tools/lttng-tools/src/lib/=
lttng-ctl&#39;</div><div>make[3]: Leaving directory `/home/shkumar/lttng-to=
ols/lttng-tools/src/lib/lttng-ctl&#39;</div>
<div>make[3]: Entering directory `/home/shkumar/lttng-tools/lttng-tools/src=
/lib&#39;</div><div>make[3]: Nothing to be done for `all-am&#39;.</div><div=
>make[3]: Leaving directory `/home/shkumar/lttng-tools/lttng-tools/src/lib&=
#39;</div>
<div>make[2]: Leaving directory `/home/shkumar/lttng-tools/lttng-tools/src/=
lib&#39;</div><div>Making all in bin</div><div>make[2]: Entering directory =
`/home/shkumar/lttng-tools/lttng-tools/src/bin&#39;</div><div>Making all in=
 lttng-consumerd</div>
<div>make[3]: Entering directory `/home/shkumar/lttng-tools/lttng-tools/src=
/bin/lttng-consumerd&#39;</div><div>=A0 CC =A0 =A0 lttng-consumerd.o</div><=
div>=A0 CC =A0 =A0 health-consumerd.o</div><div>=A0 CCLD =A0 lttng-consumer=
d</div><div>
make[3]: Leaving directory `/home/shkumar/lttng-tools/lttng-tools/src/bin/l=
ttng-consumerd&#39;</div><div>Making all in lttng</div><div>make[3]: Enteri=
ng directory `/home/shkumar/lttng-tools/lttng-tools/src/bin/lttng&#39;</div=
>
<div>=A0 CC =A0 =A0 conf.o</div><div>=A0 CC =A0 =A0 commands/start.o</div><=
div>=A0 CC =A0 =A0 commands/list.o</div><div>=A0 CC =A0 =A0 commands/create=
.o</div><div>=A0 CC =A0 =A0 commands/destroy.o</div><div>=A0 CC =A0 =A0 com=
mands/stop.o</div><div>=A0 CC =A0 =A0 commands/enable_events.o</div>
<div>=A0 CC =A0 =A0 commands/disable_events.o</div><div>=A0 CC =A0 =A0 comm=
ands/enable_channels.o</div><div>=A0 CC =A0 =A0 commands/disable_channels.o=
</div><div>=A0 CC =A0 =A0 commands/add_context.o</div><div>=A0 CC =A0 =A0 c=
ommands/set_session.o</div>
<div>=A0 CC =A0 =A0 commands/version.o</div><div>=A0 CC =A0 =A0 commands/ca=
librate.o</div><div>=A0 CC =A0 =A0 commands/view.o</div><div>=A0 CC =A0 =A0=
 commands/enable_consumer.o</div><div>=A0 CC =A0 =A0 commands/disable_consu=
mer.o</div><div>=A0 CC =A0 =A0 commands/snapshot.o</div>
<div>=A0 CC =A0 =A0 utils.o</div><div>=A0 CC =A0 =A0 lttng.o</div><div>=A0 =
CCLD =A0 lttng</div><div>make[3]: Leaving directory `/home/shkumar/lttng-to=
ols/lttng-tools/src/bin/lttng&#39;</div><div>Making all in lttng-sessiond</=
div><div>make[3]: Entering directory `/home/shkumar/lttng-tools/lttng-tools=
/src/bin/lttng-sessiond&#39;</div>
<div>=A0 CC =A0 =A0 utils.o</div><div>=A0 CC =A0 =A0 trace-kernel.o</div><d=
iv>=A0 CC =A0 =A0 kernel.o</div><div>=A0 CC =A0 =A0 context.o</div><div>=A0=
 CC =A0 =A0 channel.o</div><div>=A0 CC =A0 =A0 event.o</div><div>=A0 CC =A0=
 =A0 shm.o</div><div>=A0 CC =A0 =A0 consumer.o</div>
<div>=A0 CC =A0 =A0 session.o</div><div>=A0 CC =A0 =A0 modprobe.o</div><div=
>=A0 CC =A0 =A0 fd-limit.o</div><div>=A0 CC =A0 =A0 kernel-consumer.o</div>=
<div>=A0 CC =A0 =A0 cmd.o</div><div>=A0 CC =A0 =A0 buffer-registry.o</div><=
div>=A0 CC =A0 =A0 ht-cleanup.o</div><div>
=A0 CC =A0 =A0 snapshot.o</div><div>=A0 CC =A0 =A0 jul.o</div><div>=A0 CC =
=A0 =A0 main.o</div><div>main.c: In function &#39;thread_dispatch_ust_regis=
tration&#39;:</div><div>main.c:1564: warning: &#39;cds_wfq_dequeue_blocking=
&#39; is deprecated (declared at /home/shkumar/Development_Merge/NewOCT/pop=
t-1.16/popt_installed/include/urcu/wfqueue.h:88)</div>
<div>main.c: In function &#39;thread_registration_apps&#39;:</div><div>main=
.c:1917: warning: &#39;cds_wfq_enqueue&#39; is deprecated (declared at /hom=
e/shkumar/Development_Merge/NewOCT/popt-1.16/popt_installed/include/urcu/wf=
queue.h:76)</div>
<div>main.c: In function &#39;main&#39;:</div><div>main.c:4891: warning: &#=
39;cds_wfq_init&#39; is deprecated (declared at /home/shkumar/Development_M=
erge/NewOCT/popt-1.16/popt_installed/include/urcu/wfqueue.h:70)</div><div>
=A0 CCLD =A0 lttng-sessiond</div><div>/home/shkumar/Development_Merge/NewOC=
T/OCTEON_SDK/octeon_sdk/OCTEON-SDK/tools-gcc-4.3/bin/../lib/gcc/mips64-octe=
on-linux-gnu/4.3.3/../../../../mips64-octeon-linux-gnu/bin/ld: non-dynamic =
relocations refer to dynamic symbol lttcomm_inet_tcp_timeout</div>
<div>/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SD=
K/tools-gcc-4.3/bin/../lib/gcc/mips64-octeon-linux-gnu/4.3.3/../../../../mi=
ps64-octeon-linux-gnu/bin/ld: failed to set dynamic section sizes: Bad valu=
e</div>
<div>collect2: ld returned 1 exit status</div><div>make[3]: *** [lttng-sess=
iond] Error 1</div><div>make[3]: Leaving directory `/home/shkumar/lttng-too=
ls/lttng-tools/src/bin/lttng-sessiond&#39;</div><div>make[2]: *** [all-recu=
rsive] Error 1</div>
<div>make[2]: Leaving directory `/home/shkumar/lttng-tools/lttng-tools/src/=
bin&#39;</div><div>make[1]: *** [all-recursive] Error 1</div><div>make[1]: =
Leaving directory `/home/shkumar/lttng-tools/lttng-tools/src&#39;</div>
<div>make: *** [all-recursive] Error 1</div><div><br></div><div>Thank you</=
div><div>Skumar</div></div>

--001a11c2662eae8d8f04ec25c227--


--===============0635698130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0635698130==--
