From: Otavio Salvador <otavio@ossystems.com.br>
Subject: lttng-modules build failure for 3.12-rc6
Date: Mon, 28 Oct 2013 11:47:01 -0200
Message-ID: <CAP9ODKoqhtXmS94ZtV8hNPs=kUXWLU9msN+GR7Zf9DQrdQUmSg__14621.1821855561$1382971522$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <otavio.salvador@gmail.com>) id 1Van9v-0000yD-8X
	for lttng-dev@lists.lttng.org; Mon, 28 Oct 2013 09:47:12 -0400
Received: by mail-ob0-f170.google.com with SMTP id wp18so3597462obc.15
	for <lttng-dev@lists.lttng.org>; Mon, 28 Oct 2013 06:47:01 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hello,

Part of build issues are now fixed in master (thanks Mathieu for
applying the need changes) but we're still not good:

  CC [M]  /home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git/probes/lttng-probe-kmem.o
In file included from
/home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git/probes/../instrumentation/events/lttng-module/../../../probes/define_trace.h:148:0,
                 from
/home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git/probes/../instrumentation/events/lttng-module/kmem.h:331,
                 from
/home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git/probes/lttng-probe-kmem.c:41:
/home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git/probes/../instrumentation/events/lttng-module/../../../probes/lttng-events.h:151:6:
error: conflicting types for 'trace_mm_page_alloc_extfrag'
 void trace_##_name(_proto);
      ^
/home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git/probes/../instrumentation/events/lttng-module/../../../probes/lttng-events.h:47:2:
note: in expansion of macro 'DEFINE_EVENT_MAP'
  DEFINE_EVENT_MAP(map, name, map, PARAMS(proto), PARAMS(args))
  ^
/home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git/probes/../instrumentation/events/lttng-module/../../../probes/lttng-events.h:89:2:
note: in expansion of macro 'TRACE_EVENT_MAP'
  TRACE_EVENT_MAP(name, name,    \
  ^
/home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git/probes/../instrumentation/events/lttng-module/../../../probes/../instrumentation/events/lttng-module/kmem.h:289:1:
note: in expansion of macro 'TRACE_EVENT'
 TRACE_EVENT(mm_page_alloc_extfrag,
 ^
In file included from include/linux/module.h:18:0,
                 from
/home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git/probes/lttng-probe-kmem.c:24:
include/linux/tracepoint.h:162:21: note: previous definition of
'trace_mm_page_alloc_extfrag' was here
  static inline void trace_##name(proto)    \
                     ^
include/linux/tracepoint.h:259:3: note: in expansion of macro '__DECLARE_TRACE'
   __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args), 1, \
   ^
include/linux/tracepoint.h:391:2: note: in expansion of macro 'DECLARE_TRACE'
  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
  ^
include/trace/events/kmem.h:267:1: note: in expansion of macro 'TRACE_EVENT'
 TRACE_EVENT(mm_page_alloc_extfrag,
 ^
make[3]: *** [/home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git/probes/lttng-probe-kmem.o]
Error 1
make[2]: *** [/home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git/probes]
Error 2
make[1]: *** [_module_/home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git]
Error 2
make[1]: Leaving directory
`/home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/sysroots/imx23evk/usr/src/kernel'
make: *** [default] Error 2
ERROR: oe_runmake failed

This is 'too advanced' for me to grasp in a small amount of time and
being new to lttng I think I'd end doing the wrong thing anyway. Could
someone advice?

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
