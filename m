From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] compat: work around broken
 _SC_NPROCESSORS_CONF on MUSL libc
Date: Wed, 20 Mar 2019 11:49:53 -0400 (EDT)
Message-ID: <870406020.4260.1553096993582.JavaMail.zimbra__35685.0558471464$1553097014$gmane$org@efficios.com>
References: <20190320150735.29865-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44PZ9v5T0rz17QL
 for <lttng-dev@lists.lttng.org>; Wed, 20 Mar 2019 11:49:55 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 9C616AE649
 for <lttng-dev@lists.lttng.org>; Wed, 20 Mar 2019 11:49:54 -0400 (EDT)
In-Reply-To: <20190320150735.29865-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged into lttng-ust master, 2.11, 2.10, 2.9, thanks!

Mathieu

----- On Mar 20, 2019, at 11:07 AM, Michael Jeanson mjeanson@efficios.com wrote:

> On MUSL libc the _SC_NPROCESSORS_CONF sysconf will report the number of
> CPUs allocated to the task based on the affinity mask instead of the
> total number of CPUs configured on the system.
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> libringbuffer/smp.c | 66 +++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 66 insertions(+)
> 
> diff --git a/libringbuffer/smp.c b/libringbuffer/smp.c
> index 9e7114be..656a75da 100644
> --- a/libringbuffer/smp.c
> +++ b/libringbuffer/smp.c
> @@ -2,6 +2,7 @@
>  * libringbuffer/smp.c
>  *
>  * Copyright (C) 2011-2012 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + * Copyright (C) 2019 Michael Jeanson <mjeanson@efficios.com>
>  *
>  * This library is free software; you can redistribute it and/or
>  * modify it under the terms of the GNU Lesser General Public
> @@ -26,6 +27,7 @@
> 
> int __num_possible_cpus;
> 
> +#if (defined(__GLIBC__) || defined( __UCLIBC__))
> void _get_num_possible_cpus(void)
> {
> 	int result;
> @@ -43,3 +45,67 @@ void _get_num_possible_cpus(void)
> 		return;
> 	__num_possible_cpus = result;
> }
> +
> +#else
> +
> +/*
> + * The MUSL libc implementation of the _SC_NPROCESSORS_CONF sysconf does not
> + * return the number of configured CPUs in the system but relies on the cpu
> + * affinity mask of the current task.
> + *
> + * So instead we use a strategy similar to GLIBC's, counting the cpu
> + * directories in "/sys/devices/system/cpu" and fallback on the value from
> + * sysconf if it fails.
> + */
> +
> +#include <dirent.h>
> +#include <limits.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/types.h>
> +
> +#define __max(a,b) ((a)>(b)?(a):(b))
> +
> +void _get_num_possible_cpus(void)
> +{
> +	int result, count = 0;
> +	DIR *cpudir;
> +	struct dirent *entry;
> +
> +	cpudir = opendir("/sys/devices/system/cpu");
> +	if (cpudir == NULL)
> +		goto end;
> +
> +	/*
> +	 * Count the number of directories named "cpu" followed by and
> +	 * integer. This is the same strategy as glibc uses.
> +	 */
> +	while ((entry = readdir(cpudir))) {
> +		if (entry->d_type == DT_DIR &&
> +			strncmp(entry->d_name, "cpu", 3) == 0) {
> +
> +			char *endptr;
> +			unsigned long cpu_num;
> +
> +			cpu_num = strtoul(entry->d_name + 3, &endptr, 10);
> +			if ((cpu_num < ULONG_MAX) && (endptr != entry->d_name + 3)
> +					&& (*endptr == '\0')) {
> +				count++;
> +			}
> +		}
> +	}
> +
> +end:
> +	/*
> +	 * Get the sysconf value as a fallback. Keep the highest number.
> +	 */
> +	result = __max(sysconf(_SC_NPROCESSORS_CONF), count);
> +
> +	/*
> +	 * If both methods failed, don't store the value.
> +	 */
> +	if (result < 1)
> +		return;
> +	__num_possible_cpus = result;
> +}
> +#endif
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
