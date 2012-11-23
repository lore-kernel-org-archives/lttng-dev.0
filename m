From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules 1/2] Fix compilation for
	3.0	branch (>= 3.0.39).
Date: Fri, 23 Nov 2012 18:12:04 -0500
Message-ID: <20121123231203.GA15053__24257.8497775414$1353712359$gmane$org@Krystal>
References: <1353711369-8449-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Tc2Pm-0002j5-80
	for lttng-dev@lists.lttng.org; Fri, 23 Nov 2012 18:12:06 -0500
Content-Disposition: inline
In-Reply-To: <1353711369-8449-1-git-send-email-simon.marchi@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Simon Marchi (simon.marchi@polymtl.ca) wrote:
> The isolate_mode_t type that appeared in 3.2 was backported to 3.0.39 so
> the version check must be fixed. It was not backported to the 3.1 branch
> though, so it must be excluded.

Merged, thanks!

Mathieu

> 
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> ---
>  probes/lttng-probe-vmscan.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/probes/lttng-probe-vmscan.c b/probes/lttng-probe-vmscan.c
> index 2abd0e4..0205c7e 100644
> --- a/probes/lttng-probe-vmscan.c
> +++ b/probes/lttng-probe-vmscan.c
> @@ -30,6 +30,8 @@
>   */
>  #include <trace/events/vmscan.h>
>  
> +#include "../lttng-kernel-version.h"
> +
>  /*
>   * Create LTTng tracepoint probes.
>   */
> @@ -37,7 +39,8 @@
>  #define CREATE_TRACE_POINTS
>  #define TRACE_INCLUDE_PATH ../instrumentation/events/lttng-module
>  
> -#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0))
> +#if (LINUX_VERSION_CODE <= KERNEL_VERSION(3,0,38)) || \
> +	LTTNG_KERNEL_RANGE(3,1,0, 3,1,10)
>  typedef int isolate_mode_t;
>  #endif
>  
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
