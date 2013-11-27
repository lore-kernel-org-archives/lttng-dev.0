From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH liburcu 3/5] Added a compat layer for
	'syscall.h'
Date: Wed, 27 Nov 2013 09:35:25 +0000 (UTC)
Message-ID: <671378965.76529.1385544925575.JavaMail.zimbra__43491.0919088454$1385544965$gmane$org@efficios.com>
References: <1385528902-4797-1-git-send-email-charlesbriere.flatzo@gmail.com>
	<1385528902-4797-3-git-send-email-charlesbriere.flatzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VlbWo-0006Il-VT
	for lttng-dev@lists.lttng.org; Wed, 27 Nov 2013 04:35:28 -0500
In-Reply-To: <1385528902-4797-3-git-send-email-charlesbriere.flatzo@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Charles Briere <charlesbriere.flatzo@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Charles Briere" <charlesbriere.flatzo@gmail.com>
> To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org, "Pierre-Luc St-Charles" <pierre-luc.st-charles@polymtl.ca>, "Charles Briere"
> <charlesbriere.flatzo@gmail.com>
> Sent: Wednesday, November 27, 2013 12:08:20 AM
> Subject: [PATCH liburcu 3/5] Added a compat layer for 'syscall.h'
> 
> From: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>
> 
> Path to include syscall.h is different on Android
> 
> Signed-off-by: Charles Briere <charlesbriere.flatzo@gmail.com>
> ---
>  Makefile.am              |  2 +-
>  tests/common/thread-id.h |  5 ++---
>  urcu.c                   |  2 +-
>  urcu/futex.h             |  2 +-
>  urcu/syscall-compat.h    | 34 ++++++++++++++++++++++++++++++++++
>  5 files changed, 39 insertions(+), 6 deletions(-)
>  create mode 100644 urcu/syscall-compat.h
> 
> diff --git a/Makefile.am b/Makefile.am
> index baac8b9..64073a1 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -20,7 +20,7 @@ nobase_dist_include_HEADERS = urcu/compiler.h urcu/hlist.h
> urcu/list.h \
>  		urcu/wfqueue.h urcu/rculfstack.h urcu/rculfqueue.h \
>  		urcu/ref.h urcu/cds.h urcu/urcu_ref.h urcu/urcu-futex.h \
>  		urcu/uatomic_arch.h urcu/rculfhash.h urcu/wfcqueue.h \
> -		urcu/lfstack.h \
> +		urcu/lfstack.h urcu/syscall-compat.h \
>  		$(top_srcdir)/urcu/map/*.h \
>  		$(top_srcdir)/urcu/static/*.h \
>  		urcu/tls-compat.h
> diff --git a/tests/common/thread-id.h b/tests/common/thread-id.h
> index 9378edc..bad3006 100644
> --- a/tests/common/thread-id.h
> +++ b/tests/common/thread-id.h
> @@ -17,9 +17,8 @@
>   * provided the above notices are retained, and a notice that the code was
>   * modified is included with the above copyright notice.
>   */
> -
> -#ifdef __linux__
> -# include <syscall.h>
> +#ifdef __Linux__
> +# include <urcu/syscall-compat.h>
>  
>  # if defined(_syscall0)
>  _syscall0(pid_t, gettid)
> diff --git a/urcu.c b/urcu.c
> index 759b94b..69ebcaa 100644
> --- a/urcu.c
> +++ b/urcu.c
> @@ -66,7 +66,7 @@
>   * RCU_MEMBARRIER is only possibly available on Linux.
>   */
>  #if defined(RCU_MEMBARRIER) && defined(__linux__)
> -#include <syscall.h>
> +#include <urcu/syscall-compat.h>
>  #endif
>  
>  /* If the headers do not support SYS_membarrier, fall back on RCU_MB */
> diff --git a/urcu/futex.h b/urcu/futex.h
> index cdaa430..bb270c2 100644
> --- a/urcu/futex.h
> +++ b/urcu/futex.h
> @@ -45,7 +45,7 @@ extern "C" {
>   */
>  
>  #ifdef CONFIG_RCU_HAVE_FUTEX
> -#include <syscall.h>
> +#include <urcu/syscall-compat.h>
>  #define futex(...)	syscall(__NR_futex, __VA_ARGS__)
>  #define futex_noasync(uaddr, op, val, timeout, uaddr2, val3)	\
>  		futex(uaddr, op, val, timeout, uaddr2, val3)
> diff --git a/urcu/syscall-compat.h b/urcu/syscall-compat.h
> new file mode 100644
> index 0000000..96cfa3a
> --- /dev/null
> +++ b/urcu/syscall-compat.h
> @@ -0,0 +1,34 @@
> +#ifndef _URCU_SYSCALL_COMPAT_H
> +#define _URCU_SYSCALL_COMPAT_H
> +
> +/*
> + * urcu/syscall-compat.h
> + *
> + * Userspace RCU library - Syscall Compatibility Header
> + *

Please add your

Copyright - First Last <email>

Line.

Thanks,

Mathieu

> + * Note: this file is only used to simplify the code required to
> + * include the 'syscall.h' system header across multiple platforms,
> + * which might not always be located at the same place (or needed at all).
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301
> USA
> + */
> +
> +#if defined(__ANDROID__)
> +#include <sys/syscall.h>
> +#elif defined(__linux__)
> +#include <syscall.h>
> +#endif
> +
> +#endif /* _URCU_SYSCALL_COMPAT_H */
> --
> 1.8.4.2
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
