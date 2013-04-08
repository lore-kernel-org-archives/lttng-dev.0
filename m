From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC-Patch 2/2] x86:Instruments page fault
	trace	event
Date: Mon, 8 Apr 2013 06:58:54 -0400
Message-ID: <20130408105854.GB24595__24566.5760165595$1365437377$gmane$org@Krystal>
References: <1365398358-23374-1-git-send-email-fdeslaur@gmail.com>
	<1365398358-23374-2-git-send-email-fdeslaur@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UP9mp-0004iT-DX
	for lttng-dev@lists.lttng.org; Mon, 08 Apr 2013 06:58:55 -0400
Content-Disposition: inline
In-Reply-To: <1365398358-23374-2-git-send-email-fdeslaur@gmail.com>
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
> Signed-off-by: Francis Deslauriers <fdeslaur@gmail.com>
> Reviewed-by: Rapha=EBl Beamonte <raphael.beamonte@polymtl.ca>
> ---
>  arch/x86/mm/fault.c |    5 +++++
>  1 file changed, 5 insertions(+)
> =

> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 2b97525..f41a5a0 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -20,6 +20,9 @@
>  #include <asm/fixmap.h>			/* VSYSCALL_START		*/
>  #include <asm/context_tracking.h>	/* exception_enter(), ...	*/
>  =

> +#define CREATE_TRACE_POINTS
> +#include <trace/events/fault.h>		/* trace_page_fault_*(), ...	*/
> +
>  /*
>   * Page fault error code bits:
>   *
> @@ -1183,7 +1186,9 @@ good_area:
>  	 * make sure we exit gracefully rather than endlessly redo
>  	 * the fault:
>  	 */
> +	trace_page_fault_entry(regs, address, write);
>  	fault =3D handle_mm_fault(mm, vma, address, flags);
> +	trace_page_fault_exit(fault);

If you look at the lttng 0.x instrumentation, I think there are other
tracepoints in get user pages too ?

Thanks,

Mathieu

>  =

>  	if (unlikely(fault & (VM_FAULT_RETRY|VM_FAULT_ERROR))) {
>  		if (mm_fault_error(regs, error_code, address, fault))
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
