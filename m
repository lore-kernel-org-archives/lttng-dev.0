From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] lttng-module: sched.h: Fix compilation on
	3.9 kernel
Date: Fri, 22 Mar 2013 10:00:45 -0400
Message-ID: <20130322140045.GA2275__22415.5095209882$1363960896$gmane$org@Krystal>
References: <1363957095-54785-1-git-send-email-maxin.john@enea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UJ2WV-000754-06
	for lttng-dev@lists.lttng.org; Fri, 22 Mar 2013 10:00:47 -0400
Content-Disposition: inline
In-Reply-To: <1363957095-54785-1-git-send-email-maxin.john@enea.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: maxin.john@enea.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* maxin.john@enea.com (maxin.john@enea.com) wrote:
> From: "Maxin B. John" <maxin.john@enea.com>
> 
> With commit 8bd75c77b7c6a3954140dd2e20346aef3efe4a35
> included in 3.9-rc1 kernel, rt specific bits in "linux/sched.h"
> were moved into new header file "linux/sched/rt.h".

merged into both master and stable-2.1 branches, thanks!

Mathieu

> 
> Fixes this compilation error:
>  CC [M]  /home/majo/lttng/lttng-modules/probes/lttng-probe-sched.o
> ...
> /home/majo/lttng/lttng-modules/probes/../instrumentation/events/lttng-module
> /../../../probes/../instrumentation/events/lttng-module/sched.h:
> In function '__event_probe__sched_switch':
> /home/majo/lttng/lttng-modules/probes/../instrumentation/events/lttng-module
> /../../../probes/../instrumentation/events/lttng-module/sched.h:164:1:
> error: 'MAX_RT_PRIO' undeclared (first use in this function)
> ...
> 
> Signed-off-by: Maxin B. John <maxin.john@enea.com>
> ---
>  instrumentation/events/lttng-module/sched.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/instrumentation/events/lttng-module/sched.h b/instrumentation/events/lttng-module/sched.h
> index e42acd2..25faad0 100644
> --- a/instrumentation/events/lttng-module/sched.h
> +++ b/instrumentation/events/lttng-module/sched.h
> @@ -8,6 +8,9 @@
>  #include <linux/tracepoint.h>
>  #include <linux/binfmts.h>
>  #include <linux/version.h>
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0))
> +#include <linux/sched/rt.h>
> +#endif
>  
>  #ifndef _TRACE_SCHED_DEF_
>  #define _TRACE_SCHED_DEF_
> -- 
> 1.7.5.4
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
