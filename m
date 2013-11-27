From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH liburcu 5/5] Added implementation for
	rand_r()
Date: Wed, 27 Nov 2013 09:36:35 +0000 (UTC)
Message-ID: <734300697.76533.1385544995507.JavaMail.zimbra__31800.2074411654$1385545032$gmane$org@efficios.com>
References: <1385528902-4797-1-git-send-email-charlesbriere.flatzo@gmail.com>
	<1385528902-4797-5-git-send-email-charlesbriere.flatzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VlbXw-0006rT-Fs
	for lttng-dev@lists.lttng.org; Wed, 27 Nov 2013 04:36:37 -0500
In-Reply-To: <1385528902-4797-5-git-send-email-charlesbriere.flatzo@gmail.com>
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
> Sent: Wednesday, November 27, 2013 12:08:22 AM
> Subject: [PATCH liburcu 5/5] Added implementation for rand_r()
> 
> From: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>
> 
> stdlib.h doesn't implement rand_r() on Android.
> 
> Signed-off-by: Charles Briere <charlesbriere.flatzo@gmail.com>
> ---
>  Makefile.am                      |  1 +
>  tests/benchmark/test_urcu_hash.h |  1 +
>  urcu/rand-compat.h               | 60
>  ++++++++++++++++++++++++++++++++++++++++
>  urcu/static/urcu.h               |  1 +
>  4 files changed, 63 insertions(+)
>  create mode 100644 urcu/rand-compat.h
> 
> diff --git a/Makefile.am b/Makefile.am
> index 64073a1..38ff543 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -23,6 +23,7 @@ nobase_dist_include_HEADERS = urcu/compiler.h urcu/hlist.h
> urcu/list.h \
>  		urcu/lfstack.h urcu/syscall-compat.h \
>  		$(top_srcdir)/urcu/map/*.h \
>  		$(top_srcdir)/urcu/static/*.h \
> +		urcu/rand-compat.h \
>  		urcu/tls-compat.h
>  nobase_nodist_include_HEADERS = urcu/arch.h urcu/uatomic.h urcu/config.h
>  
> diff --git a/tests/benchmark/test_urcu_hash.h
> b/tests/benchmark/test_urcu_hash.h
> index c0727b7..b35acdb 100644
> --- a/tests/benchmark/test_urcu_hash.h
> +++ b/tests/benchmark/test_urcu_hash.h
> @@ -37,6 +37,7 @@
>  #include <signal.h>
>  
>  #include <urcu/tls-compat.h>
> +#include <urcu/rand-compat.h>
>  #include "cpuset.h"
>  #include "thread-id.h"
>  
> diff --git a/urcu/rand-compat.h b/urcu/rand-compat.h
> new file mode 100644
> index 0000000..b9545c8
> --- /dev/null
> +++ b/urcu/rand-compat.h
> @@ -0,0 +1,60 @@
> +#ifndef _URCU_RAND_COMPAT_H
> +#define _URCU_RAND_COMPAT_H
> +
> +/*
> + * urcu/rand-compat.h
> + *
> + * Userspace RCU library - rand/rand_r Compatibility Header
> + *

Also missing copyright line. You probably want to put both your own
copyright, and the copyright from Ulrich Drepper here.

Thanks,

Mathieu

> + * Note: this file is only used to simplify the code required to
> + * use the 'rand_r(...)' system function across multiple platforms,
> + * which might not always be referenced the same way.
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
> +#ifdef __ANDROID__
> +/*
> + * Reentrant random function from POSIX.1c.
> + * Copyright (C) 1996, 1999 Free Software Foundation, Inc.
> + * This file is part of the GNU C Library.
> + * Contributed by Ulrich Drepper <drepper@cygnus.com
> <mailto:drepper@cygnus.com>>, 1996.
> + */
> +static inline int rand_r(unsigned int *seed)
> +{
> +       unsigned int next = *seed;
> +       int result;
> +
> +       next *= 1103515245;
> +       next += 12345;
> +       result = (unsigned int) (next / 65536) % 2048;
> +
> +       next *= 1103515245;
> +       next += 12345;
> +       result <<= 10;
> +       result ^= (unsigned int) (next / 65536) % 1024;
> +
> +       next *= 1103515245;
> +       next += 12345;
> +       result <<= 10;
> +       result ^= (unsigned int) (next / 65536) % 1024;
> +
> +       *seed = next;
> +
> +       return result;
> +}
> +#endif /* __ANDROID__ */
> +
> +#endif /* _URCU_RAND_COMPAT_H */
> diff --git a/urcu/static/urcu.h b/urcu/static/urcu.h
> index 53d2610..33545b7 100644
> --- a/urcu/static/urcu.h
> +++ b/urcu/static/urcu.h
> @@ -41,6 +41,7 @@
>  #include <urcu/list.h>
>  #include <urcu/futex.h>
>  #include <urcu/tls-compat.h>
> +#include <urcu/rand-compat.h>
>  
>  #ifdef __cplusplus
>  extern "C" {
> --
> 1.8.4.2
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
