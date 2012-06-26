From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Expose kernel tracer to user-space
Date: Tue, 26 Jun 2012 02:40:16 -0400
Message-ID: <20120626064016.GD11952__14524.7961082079$1340692843$gmane$org@Krystal>
References: <1338938654-16515-1-git-send-email-francis.giraldeau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SjPRi-0006MC-HZ
	for lttng-dev@lists.lttng.org; Tue, 26 Jun 2012 02:40:18 -0400
Content-Disposition: inline
In-Reply-To: <1338938654-16515-1-git-send-email-francis.giraldeau@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Francis Giraldeau <francis.giraldeau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Francis Giraldeau (francis.giraldeau@gmail.com) wrote:
> By writing to the file /proc/lttng, a user-space application creates a
> kernel event. The event's payload is by default UTF-8 text, but any data
> can be written, up to 1024 bytes. Null-character is optional and is not
> enforced. The event uses sequence for space efficiency and to store any
> data as payload.
> 
> Update: split the probe code into it's own module and make it an optional
> feature of lttng-abi. The feature is enabled when the module is loaded. The
> lttng-abi module exports a register function and includes a wrapper for
> lttng_fops write. This is required since struct file_operations must be const.
> Since the module dependency is reversed, unloading the lttng-uevent module is
> done only when it's not used anymore. This is done with rwlock synchronisation.
> The synchronisation doesn't prevent starvation, but this situation is unlikely
> and can be prevented by stop active tracing sessions.
> 
> Signed-off-by: Francis Giraldeau <francis.giraldeau@gmail.com>
> ---
>  instrumentation/events/lttng-module/uevent.h |   33 +++++++++++++++
>  lttng-abi.c                                  |   42 +++++++++++++++++++
>  lttng-abi.h                                  |    3 ++
>  probes/Makefile                              |    2 +
>  probes/lttng-probe-uevent.c                  |   36 ++++++++++++++++
>  probes/lttng-uevent.c                        |   58 ++++++++++++++++++++++++++
>  6 files changed, 174 insertions(+)
>  create mode 100644 instrumentation/events/lttng-module/uevent.h
>  create mode 100644 probes/lttng-probe-uevent.c
>  create mode 100644 probes/lttng-uevent.c
> 
> diff --git a/instrumentation/events/lttng-module/uevent.h b/instrumentation/events/lttng-module/uevent.h
> new file mode 100644
> index 0000000..f67d901
> --- /dev/null
> +++ b/instrumentation/events/lttng-module/uevent.h
> @@ -0,0 +1,33 @@
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM uevent
> +
> +#if !defined(UEVENT_H_) || defined(TRACE_HEADER_MULTI_READ)
> +#define UEVENT_H_
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(lttng_uevent,
> +
> +	TP_PROTO(const char *str, size_t len),
> +
> +	TP_ARGS(str, len),
> +
> +	/*
> +	 * Uses sequence to hold variable size data, by default considered
> +	 * as text. Null-terminal character is optional and is not enforced.
> +	 */
> +	TP_STRUCT__entry(
> +		__dynamic_array_text(char, text, len)
> +	),
> +
> +	TP_fast_assign(
> +		tp_memcpy_dyn_from_user(text, str)
> +	),
> +
> +	TP_printk("")
> +)
> +
> +#endif /* UEVENT_H_ */
> +
> +/* This part must be outside protection */
> +#include "../../../probes/define_trace.h"
> diff --git a/lttng-abi.c b/lttng-abi.c
> index 26a02ed..b8e6b57 100644
> --- a/lttng-abi.c
> +++ b/lttng-abi.c
> @@ -51,6 +51,12 @@
>  #include "lttng-tracer.h"
>  
>  /*
> + * Required data structures to support lttng-probe-uevent
> + */
> +DEFINE_RWLOCK(uevent_rwlock);

Not required.

> +write_ops_t lttng_uevent_handler;

this should be static.

> +
> +/*
>   * This is LTTng's own personal way to create a system call as an external
>   * module. We use ioctl() on /proc/lttng.
>   */
> @@ -252,9 +258,45 @@ long lttng_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	}
>  }
>  
> +/*
> + * lttng_uevent_set_handler - set handler functions for uevent
> + *
> + * Access to handler code is protected with rwlock in order to
> + * prevent the optional module to be removed while in use.
> + */
> +
> +void lttng_uevent_set_handler(write_ops_t handler)
> +{
> +	write_lock(&uevent_rwlock);

write lock not necessary.

if (!lttng_uevent_set_handler)
  release refcount in prior handler's module.

then:
take a refcount on the module that contains the handler address.
(explicit)

> +	lttng_uevent_handler = handler;

Just declare the lttng_uevent_handler as "volatile".

> +	write_unlock(&uevent_rwlock);
> +}
> +EXPORT_SYMBOL_GPL(lttng_uevent_set_handler);
> +
> +/*
> + * lttng_write_uevent - expose kernel tracer to user-space
> + */
> +
> +static
> +ssize_t lttng_write_uevent(struct file *file, const char __user *ubuf,
> +		size_t count, loff_t *fpos)
> +{
> +	int ret;
> +
> +	read_lock(&uevent_rwlock);
> +	if (unlikely(lttng_uevent_handler == NULL)) {
> +		read_unlock(&uevent_rwlock);
> +		return -ENOSYS;

instead of read_lock, please do:

write_ops_t uev_handler;

uev_handler = ACCESS_ONCE(lttng_uevent_handler);
if (!uev_handler)
  return -ENOSYS;
return uev_handler(file, ubuf, count, fpos);

Thanks,

Mathieu


> +	}
> +	ret = (*lttng_uevent_handler)(file, ubuf, count, fpos);
> +	read_unlock(&uevent_rwlock);
> +	return ret;
> +}
> +
>  static const struct file_operations lttng_fops = {
>  	.owner = THIS_MODULE,

The THIS_MODULE owner protects the module that contains lttng-abi.c from
unloading when the handling is running. (keeps a refcount) However, it
does not protect the handler probe module from unloading. This is why we
need a refcount.

>  	.unlocked_ioctl = lttng_ioctl,
> +	.write = lttng_write_uevent,
>  #ifdef CONFIG_COMPAT
>  	.compat_ioctl = lttng_ioctl,
>  #endif
> diff --git a/lttng-abi.h b/lttng-abi.h
> index dc230d8..f4a8c0c 100644
> --- a/lttng-abi.h
> +++ b/lttng-abi.h
> @@ -27,6 +27,9 @@
>  
>  #define LTTNG_KERNEL_SYM_NAME_LEN	256
>  
> +typedef	ssize_t (*write_ops_t) (struct file *, const char __user *, size_t, loff_t *);
> +void lttng_uevent_set_handler(write_ops_t handler);
> +
>  enum lttng_kernel_instrumentation {
>  	LTTNG_KERNEL_TRACEPOINT	= 0,
>  	LTTNG_KERNEL_KPROBE	= 1,
> diff --git a/probes/Makefile b/probes/Makefile
> index 698a9c9..a895e60 100644
> --- a/probes/Makefile
> +++ b/probes/Makefile
> @@ -14,6 +14,8 @@ obj-m += lttng-probe-sched.o
>  obj-m += lttng-probe-irq.o
>  obj-m += lttng-probe-signal.o
>  obj-m += lttng-probe-timer.o
> +obj-m += lttng-probe-uevent.o
> +obj-m += lttng-uevent.o
>  
>  obj-m += lttng-probe-statedump.o
>  
> diff --git a/probes/lttng-probe-uevent.c b/probes/lttng-probe-uevent.c
> new file mode 100644
> index 0000000..90abb5e
> --- /dev/null
> +++ b/probes/lttng-probe-uevent.c
> @@ -0,0 +1,36 @@
> +/*
> + * probes/lttng-probe-uevent.c
> + *
> + * Expose kernel tracer to user-space through /proc/lttng
> + *
> + * Copyright (C) 2009-2012 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; only
> + * version 2.1 of the License.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +
> +#include <linux/module.h>
> +
> +/*
> + * Create lttng_uevent tracepoint probes.
> + */
> +#define LTTNG_PACKAGE_BUILD
> +#define CREATE_TRACE_POINTS
> +#define TRACE_INCLUDE_PATH ../instrumentation/events/lttng-module
> +
> +#include "../instrumentation/events/lttng-module/uevent.h"
> +
> +MODULE_LICENSE("GPL and additional rights");
> +MODULE_AUTHOR("Mathieu Desnoyers <mathieu.desnoyers@efficios.com>");
> +MODULE_DESCRIPTION("LTTng uevent probes");
> diff --git a/probes/lttng-uevent.c b/probes/lttng-uevent.c
> new file mode 100644
> index 0000000..7b4bffc
> --- /dev/null
> +++ b/probes/lttng-uevent.c
> @@ -0,0 +1,58 @@
> +/*
> + * probes/lttng-uevent.c
> + *
> + * Expose kernel tracer to user-space through /proc/lttng
> + *
> + * Copyright (C) 2012 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; only
> + * version 2.1 of the License.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +
> +#include <linux/module.h>
> +#include "../lttng-abi.h"
> +
> +/* include our own uevent tracepoint */
> +#include "../instrumentation/events/lttng-module/uevent.h"
> +DEFINE_TRACE(lttng_uevent);
> +
> +#define LTTNG_UEVENT_SIZE 1024
> +
> +ssize_t uevent_write_handler(struct file *file, const char __user *ubuf,
> +		size_t count, loff_t *fpos)
> +{
> +	if (count > LTTNG_UEVENT_SIZE)
> +		count = LTTNG_UEVENT_SIZE;
> +
> +	trace_lttng_uevent(ubuf, count);
> +	return count;
> +}
> +
> +static int __init lttng_probe_uevent_init(void)
> +{
> +	lttng_uevent_set_handler(uevent_write_handler);
> +	return 0;
> +}
> +
> +static void __exit lttng_probe_uevent_exit(void)
> +{
> +	lttng_uevent_set_handler(NULL);
> +}
> +
> +module_init(lttng_probe_uevent_init);
> +module_exit(lttng_probe_uevent_exit);
> +
> +MODULE_LICENSE("GPL and additional rights");
> +MODULE_AUTHOR("Mathieu Desnoyers <mathieu.desnoyers@efficios.com>");
> +MODULE_DESCRIPTION("LTTng kernel event from user-space");
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
