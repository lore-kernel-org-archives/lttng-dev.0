From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Expose kernel tracer to user-space	(version
	6)
Date: Mon, 2 Jul 2012 18:23:40 -0400
Message-ID: <20120702222340.GA1702__36637.3638310053$1341267871$gmane$org@Krystal>
References: <1341266778-13735-1-git-send-email-francis.giraldeau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Slp1y-00024n-GD
	for lttng-dev@lists.lttng.org; Mon, 02 Jul 2012 18:23:42 -0400
Content-Disposition: inline
In-Reply-To: <1341266778-13735-1-git-send-email-francis.giraldeau@gmail.com>
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
> By writing to the file /proc/lttng_uevent, a user-space application creates a
> kernel event. The event's payload is by default UTF-8 text, but any data can be
> written, up to 1024 bytes. Null-character is optional and is not enforced.

The 1024 byte limit is removed now, right ?

> The
> event uses sequence for space efficiency and to store any data as payload.
> 
> The feature is enabled when the module lttng-uevent is loaded. The module can
> be removed if no tracing sessions with lttng_uevent enabled is active.
> 
> Signed-off-by: Francis Giraldeau <francis.giraldeau@gmail.com>
> ---
>  instrumentation/events/lttng-module/uevent.h |   33 +++++++++
>  probes/Makefile                              |    1 +
>  probes/lttng-uevent.c                        |   97 ++++++++++++++++++++++++++
>  3 files changed, 131 insertions(+)
>  create mode 100644 instrumentation/events/lttng-module/uevent.h
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
> diff --git a/probes/Makefile b/probes/Makefile
> index 698a9c9..3003535 100644
> --- a/probes/Makefile
> +++ b/probes/Makefile
> @@ -14,6 +14,7 @@ obj-m += lttng-probe-sched.o
>  obj-m += lttng-probe-irq.o
>  obj-m += lttng-probe-signal.o
>  obj-m += lttng-probe-timer.o
> +obj-m += lttng-uevent.o
>  
>  obj-m += lttng-probe-statedump.o
>  
> diff --git a/probes/lttng-uevent.c b/probes/lttng-uevent.c
> new file mode 100644
> index 0000000..96fb233
> --- /dev/null
> +++ b/probes/lttng-uevent.c
> @@ -0,0 +1,97 @@
> +/*
> + * probes/lttng-uevent.c
> + *
> + * Expose kernel tracer to user-space through /proc/lttng
> + *
> + * Copyright (C) 2009-2012 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

you might want to add your own copyright in here too.

the rest looks good. I look forward to see the updated version.

Thanks,

Mathieu

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
> +#include <linux/proc_fs.h>
> +
> +/*
> + * Create lttng_uevent tracepoint probes.
> + */
> +
> +#define TP_MODULE_NOAUTOLOAD
> +#define LTTNG_PACKAGE_BUILD
> +#define CREATE_TRACE_POINTS
> +#define TRACE_INCLUDE_PATH ../instrumentation/events/lttng-module
> +#include "../instrumentation/events/lttng-module/uevent.h"
> +
> +#define LTTNG_UEVENT_FILE "lttng_uevent"
> +
> +/**
> + * lttng_uevent_write - write user-space data into kernel trace
> + * @file: file pointer
> + * @user_buf: user string
> + * @count: length to copy
> + * @ppos: unused
> + *
> + * Copy count bytes into a trace event "lttng_uevent".
> + *
> + * Returns the number of bytes copied from the source.
> + * Notice that there is no guarantee that the event is
> + * actually written in a trace. This can occur in 3
> + * situations:
> + *
> + *   * Buffer overrun
> + *   * No trace session are active
> + *   * The data size is greater than a sub-buffer
> + */
> +
> +ssize_t lttng_uevent_write(struct file *file, const char __user *ubuf,
> +		size_t count, loff_t *fpos)
> +{
> +	trace_lttng_uevent(ubuf, count);
> +	return count;
> +}
> +
> +static const struct file_operations uev_ops = {
> +	.owner = THIS_MODULE,
> +	.write = lttng_uevent_write
> +};
> +
> +static int __init lttng_uevent_init(void)
> +{
> +	struct proc_dir_entry *uev_file;
> +
> +	uev_file = create_proc_entry(LTTNG_UEVENT_FILE, 0444, NULL);
> +	if (!uev_file)
> +		return -ENOENT;
> +	uev_file->proc_fops = &uev_ops;
> +	uev_file->mode = S_IFREG | S_IWUGO;
> +	uev_file->uid = 0;
> +	uev_file->gid = 0;
> +	/* register manually the probe */
> +	__lttng_events_init__uevent();
> +	return 0;
> +}
> +
> +static void __exit lttng_uevent_exit(void)
> +{
> +	/* unregister manually the probe */
> +	__lttng_events_exit__uevent();
> +	remove_proc_entry(LTTNG_UEVENT_FILE, NULL);
> +}
> +
> +module_init(lttng_uevent_init);
> +module_exit(lttng_uevent_exit);
> +
> +MODULE_LICENSE("GPL and additional rights");
> +MODULE_AUTHOR("Francis Giraldeau <francis.giraldeau@gmail.com>");
> +MODULE_DESCRIPTION("Append custom events to kernel trace from user-space");
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
