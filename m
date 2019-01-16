From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules 1/4] Fix: Remove 'type'
 argument from access_ok() function (v5.0)
Date: Wed, 16 Jan 2019 15:38:18 -0500 (EST)
Message-ID: <677583374.1823.1547671098981.JavaMail.zimbra__26631.3400854871$1547670985$gmane$org@efficios.com>
References: <20190109195918.31730-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43fzYn1bHZznmP
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jan 2019 15:38:21 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id C25D4B3A53
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jan 2019 15:38:19 -0500 (EST)
In-Reply-To: <20190109195918.31730-1-mjeanson@efficios.com>
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

All merged into master, stable-2.11, all but last patch merged into
stable-2.10 and stable-2.9,

Thanks!

Mathieu

----- On Jan 9, 2019, at 2:59 PM, Michael Jeanson mjeanson@efficios.com wrote:

> See upstream commit :
> 
>  commit 96d4f267e40f9509e8a66e2b39e8b95655617693
>  Author: Linus Torvalds <torvalds@linux-foundation.org>
>  Date:   Thu Jan 3 18:57:57 2019 -0800
> 
>    Remove 'type' argument from access_ok() function
> 
>    Nobody has actually used the type (VERIFY_READ vs VERIFY_WRITE) argument
>    of the user address range verification function since we got rid of the
>    old racy i386-only code to walk page tables by hand.
> 
>    It existed because the original 80386 would not honor the write protect
>    bit when in kernel mode, so you had to do COW by hand before doing any
>    user access.  But we haven't supported that in a long time, and these
>    days the 'type' argument is a purely historical artifact.
> 
>    A discussion about extending 'user_access_begin()' to do the range
>    checking resulted this patch, because there is no way we're going to
>    move the old VERIFY_xyz interface to that model.  And it's best done at
>    the end of the merge window when I've done most of my merges, so let's
>    just get this done once and for all.
> 
>    This patch was mostly done with a sed-script, with manual fix-ups for
>    the cases that weren't of the trivial 'access_ok(VERIFY_xyz' form.
> 
>    There were a couple of notable cases:
> 
>     - csky still had the old "verify_area()" name as an alias.
> 
>     - the iter_iov code had magical hardcoded knowledge of the actual
>       values of VERIFY_{READ,WRITE} (not that they mattered, since nothing
>       really used it)
> 
>     - microblaze used the type argument for a debug printout
> 
>    but other than those oddities this should be a total no-op patch.
> 
>    I tried to fix up all architectures, did fairly extensive grepping for
>    access_ok() uses, and the changes are trivial, but I may have missed
>    something.  Any missed conversion should be trivially fixable, though.
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> lib/ringbuffer/backend.h              |  8 ++++----
> lib/ringbuffer/ring_buffer_iterator.c |  3 ++-
> lttng-filter-interpreter.c            |  4 ++--
> probes/lttng-probe-user.c             |  3 ++-
> wrapper/uaccess.h                     | 28 +++++++++++++++++++++++++++
> 5 files changed, 38 insertions(+), 8 deletions(-)
> create mode 100644 wrapper/uaccess.h
> 
> diff --git a/lib/ringbuffer/backend.h b/lib/ringbuffer/backend.h
> index 501fad4..da937f2 100644
> --- a/lib/ringbuffer/backend.h
> +++ b/lib/ringbuffer/backend.h
> @@ -21,7 +21,7 @@
> #include <linux/list.h>
> #include <linux/fs.h>
> #include <linux/mm.h>
> -#include <linux/uaccess.h>
> +#include <wrapper/uaccess.h>
> 
> /* Internal helpers */
> #include <wrapper/ringbuffer/backend_internal.h>
> @@ -289,7 +289,7 @@ void lib_ring_buffer_copy_from_user_inatomic(const struct
> lib_ring_buffer_config
> 
> 	set_fs(KERNEL_DS);
> 	pagefault_disable();
> -	if (unlikely(!access_ok(VERIFY_READ, src, len)))
> +	if (unlikely(!lttng_access_ok(VERIFY_READ, src, len)))
> 		goto fill_buffer;
> 
> 	if (likely(pagecpy == len)) {
> @@ -359,7 +359,7 @@ void lib_ring_buffer_strcpy_from_user_inatomic(const struct
> lib_ring_buffer_conf
> 
> 	set_fs(KERNEL_DS);
> 	pagefault_disable();
> -	if (unlikely(!access_ok(VERIFY_READ, src, len)))
> +	if (unlikely(!lttng_access_ok(VERIFY_READ, src, len)))
> 		goto fill_buffer;
> 
> 	if (likely(pagecpy == len)) {
> @@ -449,7 +449,7 @@ unsigned long
> lib_ring_buffer_copy_from_user_check_nofault(void *dest,
> 	unsigned long ret;
> 	mm_segment_t old_fs;
> 
> -	if (!access_ok(VERIFY_READ, src, len))
> +	if (!lttng_access_ok(VERIFY_READ, src, len))
> 		return 1;
> 	old_fs = get_fs();
> 	set_fs(KERNEL_DS);
> diff --git a/lib/ringbuffer/ring_buffer_iterator.c
> b/lib/ringbuffer/ring_buffer_iterator.c
> index 9efe491..d25db72 100644
> --- a/lib/ringbuffer/ring_buffer_iterator.c
> +++ b/lib/ringbuffer/ring_buffer_iterator.c
> @@ -11,6 +11,7 @@
> 
> #include <wrapper/ringbuffer/iterator.h>
> #include <wrapper/file.h>
> +#include <wrapper/uaccess.h>
> #include <linux/jiffies.h>
> #include <linux/delay.h>
> #include <linux/module.h>
> @@ -605,7 +606,7 @@ ssize_t channel_ring_buffer_file_read(struct file *filp,
> 	ssize_t len;
> 
> 	might_sleep();
> -	if (!access_ok(VERIFY_WRITE, user_buf, count))
> +	if (!lttng_access_ok(VERIFY_WRITE, user_buf, count))
> 		return -EFAULT;
> 
> 	/* Finish copy of previous record */
> diff --git a/lttng-filter-interpreter.c b/lttng-filter-interpreter.c
> index bf69549..3dad6cc 100644
> --- a/lttng-filter-interpreter.c
> +++ b/lttng-filter-interpreter.c
> @@ -7,7 +7,7 @@
>  * Copyright (C) 2010-2016 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>  */
> 
> -#include <linux/uaccess.h>
> +#include <wrapper/uaccess.h>
> #include <wrapper/frame.h>
> #include <wrapper/types.h>
> #include <linux/swab.h>
> @@ -30,7 +30,7 @@ char get_char(struct estack_entry *reg, size_t offset)
> 		char c;
> 
> 		/* Handle invalid access as end of string. */
> -		if (unlikely(!access_ok(VERIFY_READ,
> +		if (unlikely(!lttng_access_ok(VERIFY_READ,
> 				reg->u.s.user_str + offset,
> 				sizeof(c))))
> 			return '\0';
> diff --git a/probes/lttng-probe-user.c b/probes/lttng-probe-user.c
> index 4162a7e..0d1f95f 100644
> --- a/probes/lttng-probe-user.c
> +++ b/probes/lttng-probe-user.c
> @@ -7,6 +7,7 @@
> 
> #include <linux/uaccess.h>
> #include <linux/module.h>
> +#include <wrapper/uaccess.h>
> #include <probes/lttng-probe-user.h>
> 
> /*
> @@ -30,7 +31,7 @@ long lttng_strlen_user_inatomic(const char *addr)
> 		char v;
> 		unsigned long ret;
> 
> -		if (unlikely(!access_ok(VERIFY_READ,
> +		if (unlikely(!lttng_access_ok(VERIFY_READ,
> 				(__force const char __user *) addr,
> 				sizeof(v))))
> 			break;
> diff --git a/wrapper/uaccess.h b/wrapper/uaccess.h
> new file mode 100644
> index 0000000..c56427c
> --- /dev/null
> +++ b/wrapper/uaccess.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: (GPL-2.0 or LGPL-2.1)
> + *
> + * wrapper/uaccess.h
> + *
> + * wrapper around linux/uaccess.h.
> + *
> + * Copyright (C) 2019 Michael Jeanson <mjeanson@efficios.com>
> + */
> +
> +#ifndef _LTTNG_WRAPPER_UACCESS_H
> +#define _LTTNG_WRAPPER_UACCESS_H
> +
> +#include <linux/uaccess.h>
> +#include <lttng-kernel-version.h>
> +
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,0,0))
> +
> +#define VERIFY_READ	0
> +#define VERIFY_WRITE	1
> +#define lttng_access_ok(type, addr, size) access_ok(addr, size)
> +
> +#else /* LINUX_VERSION_CODE >= KERNEL_VERSION(5,0,0) */
> +
> +#define lttng_access_ok(type, addr, size) access_ok(type, addr, size)
> +
> +#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(5,0,0) */
> +
> +#endif /* _LTTNG_WRAPPER_UACCESS_H */
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
