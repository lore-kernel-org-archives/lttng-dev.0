From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC-PATCH] Adding trap tracepoints definitions
Date: Fri, 15 Mar 2013 09:08:09 -0400
Message-ID: <20130315130809.GA31329__13741.1848795184$1363352950$gmane$org@Krystal>
References: <CADcCL0j+_N-6b4QvbLRnpC_DvpH3K8U9G2yQsb1ACzqqz3vQSA@mail.gmail.com>
	<1363307192-14522-1-git-send-email-fdeslaur@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UGUMk-0000pi-SL
	for lttng-dev@lists.lttng.org; Fri, 15 Mar 2013 09:08:10 -0400
Content-Disposition: inline
In-Reply-To: <1363307192-14522-1-git-send-email-fdeslaur@gmail.com>
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
>  include/trace/events/trap.h |   39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 include/trace/events/trap.h
> 
> diff --git a/include/trace/events/trap.h b/include/trace/events/trap.h
> new file mode 100644
> index 0000000..869c512
> --- /dev/null
> +++ b/include/trace/events/trap.h
> @@ -0,0 +1,39 @@
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM trap
> +
> +#if !defined(_TRACE_TRAP_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_TRAP_H
> +
> +#include <linux/tracepoint.h>
> +
> +DECLARE_EVENT_CLASS(trap,
> +	TP_PROTO(int trap_nb),
> +
> +	TP_ARGS(trap_nb),

you might want

        TP_PROTO(struct pt_regs *regs, long trap);

why trap instead of trap_nb: based on include/trace/events/irq.h. "irq"
is used and not "irq_nb".

Why long instead of int ?

Because s390 represents its trap number in a long.

why having the regs there ? It's the context of the trap, was passed as
parameter to the original lttng 0.x patchset. See
https://git.lttng.org/?p=linux-2.6-lttng.git;a=shortlog;h=refs/heads/2.6.38.6-lttng-0.249

> +
> +	TP_STRUCT__entry(
> +		__field(    int,    trap_nb )

Please split entry and exit events into two different event (without
class).

And add, for entry:

        __field(  unsigned long,        ip)

> +	),
> +	TP_fast_assign(
> +		__entry->trap_nb = trap_nb;

entry:

        __entry->ip = regs ? instruction_pointer(regs) : 0UL;

This would be a good generic starting point to make the trap
instrumentation useful. In a later step, this will allow us to dump all
registers if need be as we specialize the trap header on a
per-architecture basis. But this should come later: let's start simple,
get the entire chain working and push the feature into mainline Linux,
and only then expand if necessary.

With the "ip" field, we'd get the same feature set as lttng 0.x, see
e.g.

https://git.lttng.org/?p=lttng-modules.git;a=blob;f=probes/trap-trace.c;h=397254cd700779b3333d7593c33f9660eec2ffc5;hb=refs/heads/v0.19-stable

Thanks,

Mathieu


> +),
> +
> +	TP_printk("number=%d", __entry->trap_nb)
> +);
> +
> +DEFINE_EVENT(trap, trap_entry,
> +
> +	TP_PROTO(int trap_nb),
> +
> +	TP_ARGS(trap_nb)
> +);
> +DEFINE_EVENT(trap, trap_exit,
> +
> +	TP_PROTO(int trap_nb),
> +
> +	TP_ARGS(trap_nb)
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
