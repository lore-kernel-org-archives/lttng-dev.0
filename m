From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lttng-modules build failure for 3.12-rc6
Date: Thu, 31 Oct 2013 14:26:17 +0000 (UTC)
Message-ID: <1567008261.54443.1383229577346.JavaMail.zimbra__38449.608142446$1383229652$gmane$org@efficios.com>
References: <CAP9ODKoqhtXmS94ZtV8hNPs=kUXWLU9msN+GR7Zf9DQrdQUmSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VbtCa-0007R3-PK
	for lttng-dev@lists.lttng.org; Thu, 31 Oct 2013 10:26:30 -0400
In-Reply-To: <CAP9ODKoqhtXmS94ZtV8hNPs=kUXWLU9msN+GR7Zf9DQrdQUmSg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Otavio Salvador <otavio@ossystems.com.br>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Otavio Salvador" <otavio@ossystems.com.br>
> To: "lttng-dev" <lttng-dev@lists.lttng.org>
> Cc: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Sent: Monday, October 28, 2013 9:47:01 AM
> Subject: lttng-modules build failure for 3.12-rc6
> 
> Hello,
> 
> Part of build issues are now fixed in master (thanks Mathieu for
> applying the need changes) but we're still not good:

All fixed by this string of commits in lttng-modules master:

commit 8e6213127497f61d85c3c8cdd9f2e245b00a734a
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Thu Oct 31 10:25:01 2013 -0400

    Update RCU instrumentation to Linux 3.12
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit 1fbc5fe2d07fc7710e5f59e76b08dab384a34f39
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Thu Oct 31 10:22:22 2013 -0400

    Update btrfs instrumentation to 3.12 kernel
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit 5465fedd5ec3b3d510767667d7810edca9d7ca5a
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Thu Oct 31 10:20:52 2013 -0400

    Update vmscan instrumentation to Linux 3.12
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit 926b925690602310917356ebcac2fde83e8b354c
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Thu Oct 31 10:14:32 2013 -0400

    update: kmem instrumentation 3.12 kernel support
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks for reporting these issues. 3.12 seems to build fine now.

Thanks,

Mathieu

> 
>   CC [M]
>   /home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git/probes/lttng-probe-kmem.o
> In file included from
> /home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git/probes/../instrumentation/events/lttng-module/../../../probes/define_trace.h:148:0,
>                  from
> /home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git/probes/../instrumentation/events/lttng-module/kmem.h:331,
>                  from
> /home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git/probes/lttng-probe-kmem.c:41:
> /home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git/probes/../instrumentation/events/lttng-module/../../../probes/lttng-events.h:151:6:
> error: conflicting types for 'trace_mm_page_alloc_extfrag'
>  void trace_##_name(_proto);
>       ^
> /home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git/probes/../instrumentation/events/lttng-module/../../../probes/lttng-events.h:47:2:
> note: in expansion of macro 'DEFINE_EVENT_MAP'
>   DEFINE_EVENT_MAP(map, name, map, PARAMS(proto), PARAMS(args))
>   ^
> /home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git/probes/../instrumentation/events/lttng-module/../../../probes/lttng-events.h:89:2:
> note: in expansion of macro 'TRACE_EVENT_MAP'
>   TRACE_EVENT_MAP(name, name,    \
>   ^
> /home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git/probes/../instrumentation/events/lttng-module/../../../probes/../instrumentation/events/lttng-module/kmem.h:289:1:
> note: in expansion of macro 'TRACE_EVENT'
>  TRACE_EVENT(mm_page_alloc_extfrag,
>  ^
> In file included from include/linux/module.h:18:0,
>                  from
> /home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git/probes/lttng-probe-kmem.c:24:
> include/linux/tracepoint.h:162:21: note: previous definition of
> 'trace_mm_page_alloc_extfrag' was here
>   static inline void trace_##name(proto)    \
>                      ^
> include/linux/tracepoint.h:259:3: note: in expansion of macro
> '__DECLARE_TRACE'
>    __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args), 1, \
>    ^
> include/linux/tracepoint.h:391:2: note: in expansion of macro 'DECLARE_TRACE'
>   DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
>   ^
> include/trace/events/kmem.h:267:1: note: in expansion of macro 'TRACE_EVENT'
>  TRACE_EVENT(mm_page_alloc_extfrag,
>  ^
> make[3]: ***
> [/home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git/probes/lttng-probe-kmem.o]
> Error 1
> make[2]: ***
> [/home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git/probes]
> Error 2
> make[1]: ***
> [_module_/home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/work/imx23evk-poky-linux-gnueabi/lttng-modules/2.3.2+gitAUTOINC+4f1217f8ce-r0/git]
> Error 2
> make[1]: Leaving directory
> `/home/otavio/hacking/fsl-community-bsp/build-mx23evk/tmp/sysroots/imx23evk/usr/src/kernel'
> make: *** [default] Error 2
> ERROR: oe_runmake failed
> 
> This is 'too advanced' for me to grasp in a small amount of time and
> being new to lttng I think I'd end doing the wrong thing anyway. Could
> someone advice?
> 
> --
> Otavio Salvador                             O.S. Systems
> http://www.ossystems.com.br        http://code.ossystems.com.br
> Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
