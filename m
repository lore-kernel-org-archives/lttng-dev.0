From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC-Patch 1/2] Add page fault trace
	event	definitions
Date: Mon, 8 Apr 2013 06:57:58 -0400
Message-ID: <20130408105758.GA24595__1527.88515338234$1365437383$gmane$org@Krystal>
References: <1365398358-23374-1-git-send-email-fdeslaur@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UP9lw-0004h7-4j
	for lttng-dev@lists.lttng.org; Mon, 08 Apr 2013 06:58:00 -0400
Content-Disposition: inline
In-Reply-To: <1365398358-23374-1-git-send-email-fdeslaur@gmail.com>
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
> Add page_fault_entry and page_fault_exit event definitions. It will
> allow each architecture to instrument their page faults.
> =

> Signed-off-by: Francis Deslauriers <fdeslaur@gmail.com>
> Reviewed-by: Rapha=EBl Beamonte <raphael.beamonte@polymtl.ca>
> ---
>  include/trace/events/fault.h |   51 ++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 include/trace/events/fault.h
> =

> diff --git a/include/trace/events/fault.h b/include/trace/events/fault.h
> new file mode 100644
> index 0000000..7256b40
> --- /dev/null
> +++ b/include/trace/events/fault.h
> @@ -0,0 +1,51 @@
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM fault
> +
> +#if !defined(_TRACE_FAULT_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_FAULT_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(page_fault_entry,
> +
> +	TP_PROTO(struct pt_regs *regs, unsigned long address,
> +					int write_access),
> +
> +	TP_ARGS(regs, address, write_access),
> +
> +	TP_STRUCT__entry(
> +		__field(	unsigned long,	ip	)
> +		__field(	unsigned long,	addr	)
> +		__field(	int,		write	)

uint8_t,      write

will save some space.

> +	),
> +
> +	TP_fast_assign(
> +		__entry->ip	=3D regs ? instruction_pointer(regs) : 0UL;
> +		__entry->addr	=3D address;
> +		__entry->write	=3D write_access;

Just to be clean, if we use uint8_t:

__entry->write  =3D !!write_access;

It will map zero/nonzero values to 0 and 1, and thus ensure it can be
represented on a uint8_t.

Thanks,

Mathieu


> +	),
> +
> +	TP_printk("ip=3D%lu addr=3D%lu write_access=3D%d",
> +		__entry->ip, __entry->addr, __entry->write)
> +);
> +
> +TRACE_EVENT(page_fault_exit,
> +
> +	TP_PROTO(int result),
> +
> +	TP_ARGS(result),
> +
> +	TP_STRUCT__entry(
> +		__field(	int,	res	)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->res	=3D result;
> +	),
> +
> +	TP_printk("result=3D%d", __entry->res)
> +);
> +
> +#endif /* _TRACE_FAULT_H */
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> -- =

> 1.7.10.4
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
