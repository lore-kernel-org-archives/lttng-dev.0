From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules 2/2] Use kernel 3.13
	syscall	tables for MIPS32
Date: Thu, 20 Mar 2014 14:06:17 +0000 (UTC)
Message-ID: <439412020.7491.1395324377475.JavaMail.zimbra__18573.8520035104$1395324841$gmane$org@efficios.com>
References: <1394987554-29338-1-git-send-email-larper@axis.com>
	<1394987554-29338-2-git-send-email-larper@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WQdbt-0000Ki-GE
	for lttng-dev@lists.lttng.org; Thu, 20 Mar 2014 10:06:22 -0400
In-Reply-To: <1394987554-29338-2-git-send-email-larper@axis.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lars Persson <lars.persson@axis.com>
Cc: lttng-dev@lists.lttng.org, Lars Persson <larper@axis.com>
List-Id: lttng-dev@lists.lttng.org

Merged, thanks!

Mathieu

----- Original Message -----
> From: "Lars Persson" <lars.persson@axis.com>
> To: lttng-dev@lists.lttng.org
> Cc: "Lars Persson" <larper@axis.com>
> Sent: Sunday, March 16, 2014 12:32:34 PM
> Subject: [lttng-dev] [PATCH lttng-modules 2/2] Use kernel 3.13 syscall	tables for MIPS32
> 
> Signed-off-by: Lars Persson <larper@axis.com>
> ---
>  .../syscalls/headers/syscalls_integers.h           |    4 ++++
>  .../syscalls/headers/syscalls_pointers.h           |    4 ++++
>  2 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/instrumentation/syscalls/headers/syscalls_integers.h
> b/instrumentation/syscalls/headers/syscalls_integers.h
> index ce0409f..2992439 100644
> --- a/instrumentation/syscalls/headers/syscalls_integers.h
> +++ b/instrumentation/syscalls/headers/syscalls_integers.h
> @@ -13,3 +13,7 @@
>  #ifdef CONFIG_PPC
>  #include "powerpc-32-syscalls-3.0.34_integers.h"
>  #endif
> +
> +#ifdef CONFIG_CPU_MIPS32
> +#include "mips-32-syscalls-3.13.0_integers.h"
> +#endif
> diff --git a/instrumentation/syscalls/headers/syscalls_pointers.h
> b/instrumentation/syscalls/headers/syscalls_pointers.h
> index f5ca566..9fde85a 100644
> --- a/instrumentation/syscalls/headers/syscalls_pointers.h
> +++ b/instrumentation/syscalls/headers/syscalls_pointers.h
> @@ -13,3 +13,7 @@
>  #ifdef CONFIG_PPC
>  #include "powerpc-32-syscalls-3.0.34_pointers.h"
>  #endif
> +
> +#ifdef CONFIG_CPU_MIPS32
> +#include "mips-32-syscalls-3.13.0_pointers.h"
> +#endif
> --
> 1.7.2.5
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
