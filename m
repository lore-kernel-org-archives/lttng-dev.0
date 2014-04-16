From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: [PATCH lttng-modules] Statedump event for block
	devices
Date: Wed, 16 Apr 2014 16:59:18 -0400
Message-ID: <534EEF26.5060307__2859.2704715722$1397682054$gmane$org@efficios.com>
References: <1397681801-5991-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([85.12.144.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1WaWvW-0003lB-At
 for lttng-dev@lists.lttng.org; Wed, 16 Apr 2014 16:59:32 -0400
In-Reply-To: <1397681801-5991-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, Houssem Daoud <houssemmh@gmail.com>
List-Id: lttng-dev@lists.lttng.org

Tested-by: Julien Desfossez <jdesfossez@efficios.com>

On 14-04-16 04:56 PM, Mathieu Desnoyers wrote:
> From: Houssem Daoud <houssemmh@gmail.com>
> 
> [ Edited by Mathieu Desnoyers. ]
> Signed-off-by: Houssem Daoud <houssemmh@gmail.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  README                                             |    2 +
>  .../events/lttng-module/lttng-statedump.h          |   16 +++
>  lttng-statedump-impl.c                             |   46 ++++++++
>  wrapper/genhd.h                                    |  113 ++++++++++++++++++++
>  4 files changed, 177 insertions(+)
>  create mode 100644 wrapper/genhd.h
> 
> diff --git a/README b/README
> index 9aa5b93..119bfa8 100644
> --- a/README
> +++ b/README
> @@ -83,6 +83,8 @@ CONFIG_KPROBES:
>  CONFIG_KRETPROBES:
>              Dynamic function entry/return probe.
>                 lttng enable-event -k --function ...
> +CONFIG_KALLSYMS_ALL:
> +            State dump of mapping between block device number and name.
>  
>  
>  * Note about Perf PMU counters support
> diff --git a/instrumentation/events/lttng-module/lttng-statedump.h b/instrumentation/events/lttng-module/lttng-statedump.h
> index e4c86d6..efd22d7 100644
> --- a/instrumentation/events/lttng-module/lttng-statedump.h
> +++ b/instrumentation/events/lttng-module/lttng-statedump.h
> @@ -7,6 +7,7 @@
>  #include <linux/tracepoint.h>
>  #include <linux/nsproxy.h>
>  #include <linux/pid_namespace.h>
> +#include <linux/types.h>
>  
>  TRACE_EVENT(lttng_statedump_start,
>  	TP_PROTO(struct lttng_session *session),
> @@ -141,6 +142,21 @@ TRACE_EVENT(lttng_statedump_network_interface,
>  	TP_printk("")
>  )
>  
> +TRACE_EVENT(lttng_statedump_block_device,
> +	TP_PROTO(struct lttng_session *session,
> +		dev_t dev, const char *diskname),
> +	TP_ARGS(session, dev, diskname),
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__string(diskname, diskname)
> +	),
> +	TP_fast_assign(
> +		tp_assign(dev, dev)
> +		tp_strcpy(diskname, diskname)
> +	),
> +	TP_printk("")
> +)
> +
>  /* Called with desc->lock held */
>  TRACE_EVENT(lttng_statedump_interrupt,
>  	TP_PROTO(struct lttng_session *session,
> diff --git a/lttng-statedump-impl.c b/lttng-statedump-impl.c
> index 3e46ca1..e9fe829 100644
> --- a/lttng-statedump-impl.c
> +++ b/lttng-statedump-impl.c
> @@ -45,6 +45,7 @@
>  #include <linux/swap.h>
>  #include <linux/wait.h>
>  #include <linux/mutex.h>
> +#include <linux/device.h>
>  
>  #include "lttng-events.h"
>  #include "lttng-tracer.h"
> @@ -54,6 +55,7 @@
>  #include "wrapper/nsproxy.h"
>  #include "wrapper/irq.h"
>  #include "wrapper/tracepoint.h"
> +#include "wrapper/genhd.h"
>  
>  #ifdef CONFIG_LTTNG_HAS_LIST_IRQ
>  #include <linux/irq.h>
> @@ -65,6 +67,7 @@
>  #define TRACE_INCLUDE_FILE lttng-statedump
>  #include "instrumentation/events/lttng-module/lttng-statedump.h"
>  
> +DEFINE_TRACE(lttng_statedump_block_device);
>  DEFINE_TRACE(lttng_statedump_end);
>  DEFINE_TRACE(lttng_statedump_interrupt);
>  DEFINE_TRACE(lttng_statedump_file_descriptor);
> @@ -115,7 +118,49 @@ enum lttng_process_status {
>  	LTTNG_DEAD = 7,
>  };
>  
> +static
> +int lttng_enumerate_block_devices(struct lttng_session *session)
> +{
> +	struct class *ptr_block_class;
> +	struct device_type *ptr_disk_type;
> +	struct class_dev_iter iter;
> +	struct device *dev;
> +
> +	ptr_block_class = wrapper_get_block_class();
> +	if (!ptr_block_class)
> +		return -ENOSYS;
> +	ptr_disk_type = wrapper_get_disk_type();
> +	if (!ptr_disk_type) {
> +		return -ENOSYS;
> +	}
> +	class_dev_iter_init(&iter, ptr_block_class, NULL, ptr_disk_type);
> +	while ((dev = class_dev_iter_next(&iter))) {
> +		struct disk_part_iter piter;
> +		struct gendisk *disk = dev_to_disk(dev);
> +		struct hd_struct *part;
> +
> +		disk_part_iter_init(&piter, disk, DISK_PITER_INCL_PART0);
> +		while ((part = disk_part_iter_next(&piter))) {
> +			char name_buf[BDEVNAME_SIZE];
> +			char *p;
> +
> +			p = wrapper_disk_name(disk, part->partno, name_buf);
> +			if (!p) {
> +				disk_part_iter_exit(&piter);
> +				class_dev_iter_exit(&iter);
> +				return -ENOSYS;
> +			}
> +			trace_lttng_statedump_block_device(session,
> +					part_devt(part), name_buf);
> +		}
> +		disk_part_iter_exit(&piter);
> +	}
> +	class_dev_iter_exit(&iter);
> +	return 0;
> +}
> +
>  #ifdef CONFIG_INET
> +
>  static
>  void lttng_enumerate_device(struct lttng_session *session,
>  		struct net_device *dev)
> @@ -397,6 +442,7 @@ int do_lttng_statedump(struct lttng_session *session)
>  	/* FIXME lttng_enumerate_vm_maps(session); */
>  	lttng_list_interrupts(session);
>  	lttng_enumerate_network_ip_interface(session);
> +	lttng_enumerate_block_devices(session);
>  
>  	/* TODO lttng_dump_idt_table(session); */
>  	/* TODO lttng_dump_softirq_vec(session); */
> diff --git a/wrapper/genhd.h b/wrapper/genhd.h
> new file mode 100644
> index 0000000..5bb390b
> --- /dev/null
> +++ b/wrapper/genhd.h
> @@ -0,0 +1,113 @@
> +#ifndef _LTTNG_WRAPPER_GENHD_H
> +#define _LTTNG_WRAPPER_GENHD_H
> +
> +/*
> + * wrapper/genhd.h
> + *
> + * wrapper around block layer functions and data structures. Using
> + * KALLSYMS to get its address when available, else we need to have a
> + * kernel that exports this function to GPL modules.
> + *
> + * Copyright (C) 2011-2014 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
> +#include <linux/genhd.h>
> +
> +#ifdef CONFIG_KALLSYMS
> +
> +#include <linux/kallsyms.h>
> +#include "kallsyms.h"
> +
> +static inline
> +char *wrapper_disk_name(struct gendisk *hd, int partno, char *buf)
> +{
> +	char *(*disk_name_sym)(struct gendisk *hd, int partno, char *buf);
> +
> +	disk_name_sym = (void *) kallsyms_lookup_funcptr("disk_name");
> +	if (disk_name_sym) {
> +		return disk_name_sym(hd, partno, buf);
> +	} else {
> +		printk(KERN_WARNING "LTTng: disk_name symbol lookup failed.\n");
> +		return NULL;
> +	}
> +}
> +
> +#else
> +
> +static inline
> +char *wrapper_disk_name(struct gendisk *hd, int partno, char *buf)
> +{
> +	return disk_name(hd, partno, buf);
> +}
> +
> +#endif
> +
> +#ifdef CONFIG_KALLSYMS_ALL
> +
> +static inline
> +struct class *wrapper_get_block_class(void)
> +{
> +	struct class *ptr_block_class;
> +
> +	ptr_block_class = (struct class *) kallsyms_lookup_dataptr("block_class");
> +	if (!ptr_block_class) {
> +		printk(KERN_WARNING "LTTng: block_class symbol lookup failed.\n");
> +		return NULL;
> +	}
> +	return ptr_block_class;
> +}
> +
> +static inline
> +struct device_type *wrapper_get_disk_type(void)
> +{
> +	struct device_type *ptr_disk_type;
> +
> +	ptr_disk_type = (struct device_type *) kallsyms_lookup_dataptr("disk_type");
> +	if (!ptr_disk_type) {
> +		printk(KERN_WARNING "LTTng: disk_type symbol lookup failed.\n");
> +		return NULL;
> +	}
> +	return ptr_disk_type;
> +}
> +
> +#else
> +
> +static inline
> +struct class *wrapper_get_block_class(void)
> +{
> +	/*
> +	 * Symbol block_class is not exported.
> +	 * TODO: return &block_class;
> +	 */
> +	/* Feature currently unavailable without KALLSYMS_ALL */
> +	return NULL;
> +}
> +
> +static inline
> +struct device_type *wrapper_get_disk_type(void)
> +{
> +	/*
> +	 * Symbol disk_type is not exported.
> +	 * TODO: return &disk_type;
> +	 */
> +	/* Feature currently unavailable without KALLSYMS_ALL */
> +	return NULL;
> +}
> +
> +#endif
> +
> +#endif /* _LTTNG_WRAPPER_GENHD_H */
> 
