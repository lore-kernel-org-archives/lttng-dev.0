From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] RFC: fix: Remove start and
 number from syscall_get_arguments() args (v5.1)
Date: Wed, 10 Apr 2019 17:11:00 -0400 (EDT)
Message-ID: <574157952.3347.1554930660298.JavaMail.zimbra__41667.4603520491$1554930685$gmane$org@efficios.com>
References: <20190409181241.10294-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44fcJq60dKz1Kvj
 for <lttng-dev@lists.lttng.org>; Wed, 10 Apr 2019 17:11:07 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 058741D602C
 for <lttng-dev@lists.lttng.org>; Wed, 10 Apr 2019 17:11:01 -0400 (EDT)
In-Reply-To: <20190409181241.10294-1-mjeanson@efficios.com>
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

merged into master, 2.11, 2.10, 2.9, thanks!

Mathieu

----- On Apr 9, 2019, at 2:12 PM, Michael Jeanson mjeanson@efficios.com wrote:

> commit b35f549df1d7520d37ba1e6d4a8d4df6bd52d136
>  Author: Steven Rostedt (Red Hat) <rostedt@goodmis.org>
>  Date:   Mon Nov 7 16:26:37 2016 -0500
> 
>    syscalls: Remove start and number from syscall_get_arguments() args
> 
>    At Linux Plumbers, Andy Lutomirski approached me and pointed out that the
>    function call syscall_get_arguments() implemented in x86 was horribly
>    written and not optimized for the standard case of passing in 0 and 6 for
>    the starting index and the number of system calls to get. When looking at
>    all the users of this function, I discovered that all instances pass in only
>    0 and 6 for these arguments. Instead of having this function handle
>    different cases that are never used, simply rewrite it to return the first 6
>    arguments of a system call.
> 
>    This should help out the performance of tracing system calls by ptrace,
>    ftrace and perf.
> 
>    Link: http://lkml.kernel.org/r/20161107213233.754809394@goodmis.org
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> lttng-syscalls.c  | 57 ++++++++++++++++++++++++-----------------------
> wrapper/syscall.h | 34 ++++++++++++++++++++++++++++
> 2 files changed, 63 insertions(+), 28 deletions(-)
> create mode 100644 wrapper/syscall.h
> 
> diff --git a/lttng-syscalls.c b/lttng-syscalls.c
> index bcc06b5..ebd9246 100644
> --- a/lttng-syscalls.c
> +++ b/lttng-syscalls.c
> @@ -25,6 +25,7 @@
> #include <wrapper/tracepoint.h>
> #include <wrapper/file.h>
> #include <wrapper/rcu.h>
> +#include <wrapper/syscall.h>
> #include <lttng-events.h>
> 
> #ifndef CONFIG_COMPAT
> @@ -361,9 +362,9 @@ struct lttng_syscall_filter {
> static void syscall_entry_unknown(struct lttng_event *event,
> 	struct pt_regs *regs, unsigned int id)
> {
> -	unsigned long args[UNKNOWN_SYSCALL_NRARGS];
> +	unsigned long args[LTTNG_SYSCALL_NR_ARGS];
> 
> -	syscall_get_arguments(current, regs, 0, UNKNOWN_SYSCALL_NRARGS, args);
> +	lttng_syscall_get_arguments(current, regs, args);
> 	if (unlikely(in_compat_syscall()))
> 		__event_probe__compat_syscall_entry_unknown(event, id, args);
> 	else
> @@ -432,9 +433,9 @@ void syscall_entry_probe(void *__data, struct pt_regs *regs,
> long id)
> 	case 1:
> 	{
> 		void (*fptr)(void *__data, unsigned long arg0) = entry->func;
> -		unsigned long args[1];
> +		unsigned long args[LTTNG_SYSCALL_NR_ARGS];
> 
> -		syscall_get_arguments(current, regs, 0, entry->nrargs, args);
> +		lttng_syscall_get_arguments(current, regs, args);
> 		fptr(event, args[0]);
> 		break;
> 	}
> @@ -443,9 +444,9 @@ void syscall_entry_probe(void *__data, struct pt_regs *regs,
> long id)
> 		void (*fptr)(void *__data,
> 			unsigned long arg0,
> 			unsigned long arg1) = entry->func;
> -		unsigned long args[2];
> +		unsigned long args[LTTNG_SYSCALL_NR_ARGS];
> 
> -		syscall_get_arguments(current, regs, 0, entry->nrargs, args);
> +		lttng_syscall_get_arguments(current, regs, args);
> 		fptr(event, args[0], args[1]);
> 		break;
> 	}
> @@ -455,9 +456,9 @@ void syscall_entry_probe(void *__data, struct pt_regs *regs,
> long id)
> 			unsigned long arg0,
> 			unsigned long arg1,
> 			unsigned long arg2) = entry->func;
> -		unsigned long args[3];
> +		unsigned long args[LTTNG_SYSCALL_NR_ARGS];
> 
> -		syscall_get_arguments(current, regs, 0, entry->nrargs, args);
> +		lttng_syscall_get_arguments(current, regs, args);
> 		fptr(event, args[0], args[1], args[2]);
> 		break;
> 	}
> @@ -468,9 +469,9 @@ void syscall_entry_probe(void *__data, struct pt_regs *regs,
> long id)
> 			unsigned long arg1,
> 			unsigned long arg2,
> 			unsigned long arg3) = entry->func;
> -		unsigned long args[4];
> +		unsigned long args[LTTNG_SYSCALL_NR_ARGS];
> 
> -		syscall_get_arguments(current, regs, 0, entry->nrargs, args);
> +		lttng_syscall_get_arguments(current, regs, args);
> 		fptr(event, args[0], args[1], args[2], args[3]);
> 		break;
> 	}
> @@ -482,9 +483,9 @@ void syscall_entry_probe(void *__data, struct pt_regs *regs,
> long id)
> 			unsigned long arg2,
> 			unsigned long arg3,
> 			unsigned long arg4) = entry->func;
> -		unsigned long args[5];
> +		unsigned long args[LTTNG_SYSCALL_NR_ARGS];
> 
> -		syscall_get_arguments(current, regs, 0, entry->nrargs, args);
> +		lttng_syscall_get_arguments(current, regs, args);
> 		fptr(event, args[0], args[1], args[2], args[3], args[4]);
> 		break;
> 	}
> @@ -497,9 +498,9 @@ void syscall_entry_probe(void *__data, struct pt_regs *regs,
> long id)
> 			unsigned long arg3,
> 			unsigned long arg4,
> 			unsigned long arg5) = entry->func;
> -		unsigned long args[6];
> +		unsigned long args[LTTNG_SYSCALL_NR_ARGS];
> 
> -		syscall_get_arguments(current, regs, 0, entry->nrargs, args);
> +		lttng_syscall_get_arguments(current, regs, args);
> 		fptr(event, args[0], args[1], args[2],
> 			args[3], args[4], args[5]);
> 		break;
> @@ -512,9 +513,9 @@ void syscall_entry_probe(void *__data, struct pt_regs *regs,
> long id)
> static void syscall_exit_unknown(struct lttng_event *event,
> 	struct pt_regs *regs, int id, long ret)
> {
> -	unsigned long args[UNKNOWN_SYSCALL_NRARGS];
> +	unsigned long args[LTTNG_SYSCALL_NR_ARGS];
> 
> -	syscall_get_arguments(current, regs, 0, UNKNOWN_SYSCALL_NRARGS, args);
> +	lttng_syscall_get_arguments(current, regs, args);
> 	if (unlikely(in_compat_syscall()))
> 		__event_probe__compat_syscall_exit_unknown(event, id, ret,
> 			args);
> @@ -588,9 +589,9 @@ void syscall_exit_probe(void *__data, struct pt_regs *regs,
> long ret)
> 		void (*fptr)(void *__data,
> 			long ret,
> 			unsigned long arg0) = entry->func;
> -		unsigned long args[1];
> +		unsigned long args[LTTNG_SYSCALL_NR_ARGS];
> 
> -		syscall_get_arguments(current, regs, 0, entry->nrargs, args);
> +		lttng_syscall_get_arguments(current, regs, args);
> 		fptr(event, ret, args[0]);
> 		break;
> 	}
> @@ -600,9 +601,9 @@ void syscall_exit_probe(void *__data, struct pt_regs *regs,
> long ret)
> 			long ret,
> 			unsigned long arg0,
> 			unsigned long arg1) = entry->func;
> -		unsigned long args[2];
> +		unsigned long args[LTTNG_SYSCALL_NR_ARGS];
> 
> -		syscall_get_arguments(current, regs, 0, entry->nrargs, args);
> +		lttng_syscall_get_arguments(current, regs, args);
> 		fptr(event, ret, args[0], args[1]);
> 		break;
> 	}
> @@ -613,9 +614,9 @@ void syscall_exit_probe(void *__data, struct pt_regs *regs,
> long ret)
> 			unsigned long arg0,
> 			unsigned long arg1,
> 			unsigned long arg2) = entry->func;
> -		unsigned long args[3];
> +		unsigned long args[LTTNG_SYSCALL_NR_ARGS];
> 
> -		syscall_get_arguments(current, regs, 0, entry->nrargs, args);
> +		lttng_syscall_get_arguments(current, regs, args);
> 		fptr(event, ret, args[0], args[1], args[2]);
> 		break;
> 	}
> @@ -627,9 +628,9 @@ void syscall_exit_probe(void *__data, struct pt_regs *regs,
> long ret)
> 			unsigned long arg1,
> 			unsigned long arg2,
> 			unsigned long arg3) = entry->func;
> -		unsigned long args[4];
> +		unsigned long args[LTTNG_SYSCALL_NR_ARGS];
> 
> -		syscall_get_arguments(current, regs, 0, entry->nrargs, args);
> +		lttng_syscall_get_arguments(current, regs, args);
> 		fptr(event, ret, args[0], args[1], args[2], args[3]);
> 		break;
> 	}
> @@ -642,9 +643,9 @@ void syscall_exit_probe(void *__data, struct pt_regs *regs,
> long ret)
> 			unsigned long arg2,
> 			unsigned long arg3,
> 			unsigned long arg4) = entry->func;
> -		unsigned long args[5];
> +		unsigned long args[LTTNG_SYSCALL_NR_ARGS];
> 
> -		syscall_get_arguments(current, regs, 0, entry->nrargs, args);
> +		lttng_syscall_get_arguments(current, regs, args);
> 		fptr(event, ret, args[0], args[1], args[2], args[3], args[4]);
> 		break;
> 	}
> @@ -658,9 +659,9 @@ void syscall_exit_probe(void *__data, struct pt_regs *regs,
> long ret)
> 			unsigned long arg3,
> 			unsigned long arg4,
> 			unsigned long arg5) = entry->func;
> -		unsigned long args[6];
> +		unsigned long args[LTTNG_SYSCALL_NR_ARGS];
> 
> -		syscall_get_arguments(current, regs, 0, entry->nrargs, args);
> +		lttng_syscall_get_arguments(current, regs, args);
> 		fptr(event, ret, args[0], args[1], args[2],
> 			args[3], args[4], args[5]);
> 		break;
> diff --git a/wrapper/syscall.h b/wrapper/syscall.h
> new file mode 100644
> index 0000000..8715f0c
> --- /dev/null
> +++ b/wrapper/syscall.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: (GPL-2.0 or LGPL-2.1)
> + *
> + * wrapper/syscall.h
> + *
> + * wrapper around asm/syscall.h.
> + *
> + * Copyright (C) 2019 Michael Jeanson <mjeanson@efficios.com>
> + */
> +
> +#ifndef _LTTNG_WRAPPER_SYSCALL_H
> +#define _LTTNG_WRAPPER_SYSCALL_H
> +
> +#include <asm/syscall.h>
> +#include <lttng-kernel-version.h>
> +
> +#define LTTNG_SYSCALL_NR_ARGS 6
> +
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,1,0))
> +
> +#define lttng_syscall_get_arguments(task, regs, args) \
> +	syscall_get_arguments(task, regs, args)
> +
> +#else /* LINUX_VERSION_CODE >= KERNEL_VERSION(5,1,0) */
> +
> +static inline
> +void lttng_syscall_get_arguments(struct task_struct *task,
> +		struct pt_regs *regs, unsigned long *args)
> +{
> +	syscall_get_arguments(task, regs, 0, LTTNG_SYSCALL_NR_ARGS, args);
> +}
> +
> +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(5,1,0) */
> +
> +#endif /* _LTTNG_WRAPPER_SYSCALL_H */
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
