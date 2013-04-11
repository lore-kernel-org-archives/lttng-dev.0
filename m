From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC-Patch 2/2] x86:Instruments page fault
	trace	event
Date: Thu, 11 Apr 2013 14:17:58 -0400
Message-ID: <20130411181758.GA21484__42222.5293507383$1365704309$gmane$org@Krystal>
References: <1365398358-23374-1-git-send-email-fdeslaur@gmail.com>
	<1365566360-7206-1-git-send-email-fdeslaur@gmail.com>
	<1365566360-7206-2-git-send-email-fdeslaur@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UQM4Q-0001nf-Bm
	for lttng-dev@lists.lttng.org; Thu, 11 Apr 2013 14:18:02 -0400
Content-Disposition: inline
In-Reply-To: <1365566360-7206-2-git-send-email-fdeslaur@gmail.com>
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
> Reviewed-by: Rapha=EBl Beamonte <raphael.beamonte@gmail.com>
> ---
>  arch/x86/mm/fault.c |    7 +++++++
>  mm/memory.c         |    5 +++++
>  2 files changed, 12 insertions(+)
> =

> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 2b97525..6ceaaaa 100644
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
> @@ -754,12 +757,14 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsign=
ed long error_code,
>  =

>  		if (likely(show_unhandled_signals))
>  			show_signal_msg(regs, error_code, address, tsk);
> +		trace_page_fault_entry(regs, address, error_code & PF_WRITE);
>  =

>  		tsk->thread.cr2		=3D address;
>  		tsk->thread.error_code	=3D error_code;
>  		tsk->thread.trap_nr	=3D X86_TRAP_PF;
>  =

>  		force_sig_info_fault(SIGSEGV, si_code, address, tsk, 0);

maybe we should put a comment in the patch when sending to LKML, e.g.:

        /*
         * Using -1 here, since there is no VM_FAULT flag to identify
         * user accesses triggering SIGSEGV.
         */

> +		trace_page_fault_exit(-1);

And maybe interesting hints will come from LKML.

The rest looks good,

Thanks,

Mathieu

>  =

>  		return;
>  	}
> @@ -1183,7 +1188,9 @@ good_area:
>  	 * make sure we exit gracefully rather than endlessly redo
>  	 * the fault:
>  	 */
> +	trace_page_fault_entry(regs, address, write);
>  	fault =3D handle_mm_fault(mm, vma, address, flags);
> +	trace_page_fault_exit(fault);
>  =

>  	if (unlikely(fault & (VM_FAULT_RETRY|VM_FAULT_ERROR))) {
>  		if (mm_fault_error(regs, error_code, address, fault))
> diff --git a/mm/memory.c b/mm/memory.c
> index 494526a..49a8119 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -67,6 +67,8 @@
>  #include <asm/tlbflush.h>
>  #include <asm/pgtable.h>
>  =

> +#include <trace/events/fault.h>
> +
>  #include "internal.h"
>  =

>  #ifdef LAST_NID_NOT_IN_PAGE_FLAGS
> @@ -1828,8 +1830,11 @@ long __get_user_pages(struct task_struct *tsk, str=
uct mm_struct *mm,
>  				if (foll_flags & FOLL_NOWAIT)
>  					fault_flags |=3D (FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_RETRY_NOWAIT);
>  =

> +				trace_page_fault_entry(0, start,
> +						foll_flags & FOLL_WRITE);
>  				ret =3D handle_mm_fault(mm, vma, start,
>  							fault_flags);
> +				trace_page_fault_exit(ret);
>  =

>  				if (ret & VM_FAULT_ERROR) {
>  					if (ret & VM_FAULT_OOM)
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
