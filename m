From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC-PATCH] Adding trap tracepoints definitions
Date: Wed, 20 Mar 2013 16:14:06 -0400
Message-ID: <20130320201406.GA27044__6864.61549853465$1363810509$gmane$org@Krystal>
References: <CADcCL0j+_N-6b4QvbLRnpC_DvpH3K8U9G2yQsb1ACzqqz3vQSA@mail.gmail.com>
	<1363809323-12154-1-git-send-email-fdeslaur@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UIPOm-0003gJ-Fr
	for lttng-dev@lists.lttng.org; Wed, 20 Mar 2013 16:14:12 -0400
Content-Disposition: inline
In-Reply-To: <1363809323-12154-1-git-send-email-fdeslaur@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Francis Deslauriers <fdeslaur@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Francis Deslauriers (fdeslaur@gmail.com) wrote:
> This patch adds new trap tracepoint definitions. Both trap entry and trap exit
> tracepoints can be added.
> 
> Signed-off-by: Francis Deslauriers <fdeslaur@gmail.com>
> ---
>  include/trace/events/trap.h |   45 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 include/trace/events/trap.h
> 
> diff --git a/include/trace/events/trap.h b/include/trace/events/trap.h
> new file mode 100644
> index 0000000..e79e8c0
> --- /dev/null
> +++ b/include/trace/events/trap.h
> @@ -0,0 +1,45 @@
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM trap
> +
> +#if !defined(_TRACE_TRAP_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_TRAP_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(trap_entry,
> +
> +	TP_PROTO(struct pt_regs *regs, long trap),
> +
> +	TP_ARGS(regs, trap),
> +	
> +	TP_STRUCT__entry(
> +		__field(    long,    trap )
> +		__field(  unsigned long,	ip)

many lines are using spaces instead of tabs.

> +	),
> +	TP_fast_assign(
> +		__entry->trap = trap;
> +		__entry->ip = regs ? instruction_pointer(regs) : 0UL;
> +	),
> +
> +	TP_printk("number=%ld, ip = %lu", __entry->trap, __entry->ip)
> +);
> +
> +TRACE_EVENT(trap_exit,
> +
> +	TP_PROTO(long trap),
> +
> +	TP_ARGS(trap),
> +	
> +	TP_STRUCT__entry(
> +		__field(    long,    trap )

here too.

Thanks,

Mathieu

> +	),
> +	TP_fast_assign(
> +		__entry->trap = trap;
> +	),
> +
> +	TP_printk("number=%ld", __entry->trap)
> +);
> +
> +#endif /* _TRACE_TRAP_H */
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
