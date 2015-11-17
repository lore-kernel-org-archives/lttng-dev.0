From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [MODULES PATCH v3] Contexts for RT debugging
Date: Tue, 17 Nov 2015 19:18:51 +0000 (UTC)
Message-ID: <1129399370.111272.1447787931344.JavaMail.zimbra__48616.7390169159$1447788012$gmane$org@efficios.com>
References: <1447361364-8548-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZylmT-0007EU-Cr
 for lttng-dev@lists.lttng.org; Tue, 17 Nov 2015 14:19:08 -0500
In-Reply-To: <1447361364-8548-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

----- On Nov 12, 2015, at 3:49 PM, Julien Desfossez jdesfossez@efficios.com wrote:

> Add the interruptible, preemptible, need_resched and migratable
> contexts.
> 
> TODO: find a way to check if IRQs are disabled prior to the
> instrumentation (ex: kprobe).

I implemented the TODO, and merged into master, thanks!

Mathieu

> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
> Makefile                        | 12 ++++-
> lttng-abi.c                     | 12 +++++
> lttng-abi.h                     |  4 ++
> lttng-context-interruptible.c   | 94 ++++++++++++++++++++++++++++++++++++++
> lttng-context-migratable.c      | 94 ++++++++++++++++++++++++++++++++++++++
> lttng-context-need-reschedule.c | 94 ++++++++++++++++++++++++++++++++++++++
> lttng-context-preemptible.c     | 99 +++++++++++++++++++++++++++++++++++++++++
> lttng-context.c                 | 20 +++++++++
> lttng-events.h                  |  8 ++++
> 9 files changed, 436 insertions(+), 1 deletion(-)
> create mode 100644 lttng-context-interruptible.c
> create mode 100644 lttng-context-migratable.c
> create mode 100644 lttng-context-need-reschedule.c
> create mode 100644 lttng-context-preemptible.c
> 
> diff --git a/Makefile b/Makefile
> index f7aa23f..2db30ef 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -41,7 +41,8 @@ lttng-tracer-objs :=  lttng-events.o lttng-abi.o \
> 			lttng-context-vpid.o lttng-context-tid.o \
> 			lttng-context-vtid.o lttng-context-ppid.o \
> 			lttng-context-vppid.o lttng-context-cpu-id.o \
> -			lttng-calibrate.o \
> +			lttng-context-interruptible.o \
> +			lttng-context-need-reschedule.o lttng-calibrate.o \
> 			lttng-context-hostname.o wrapper/random.o \
> 			probes/lttng.o wrapper/trace-clock.o \
> 			wrapper/page_alloc.o \
> @@ -66,6 +67,15 @@ lttng-tracer-objs += $(shell \
> 		echo "lttng-context-perf-counters.o" ; fi;)
> endif # CONFIG_PERF_EVENTS
> 
> +ifneq ($(CONFIG_PREEMPT_RT_FULL),)
> +lttng-tracer-objs += lttng-context-migratable.o
> +lttng-tracer-objs += lttng-context-preemptible.o
> +endif # CONFIG_PREEMPT_RT_FULLJ
> +
> +ifneq ($(CONFIG_PREEMPT),)
> +lttng-tracer-objs += lttng-context-preemptible.o
> +endif
> +
> lttng-tracer-objs += $(shell \
> 	if [ $(VERSION) -ge 4 \
> 		-o \( $(VERSION) -eq 3 -a $(PATCHLEVEL) -ge 15 -a $(SUBLEVEL) -ge 0 \) ] ; then
> 		\
> diff --git a/lttng-abi.c b/lttng-abi.c
> index f6f3043..3e44b54 100644
> --- a/lttng-abi.c
> +++ b/lttng-abi.c
> @@ -236,6 +236,18 @@ long lttng_abi_add_context(struct file *file,
> 		return lttng_add_hostname_to_ctx(ctx);
> 	case LTTNG_KERNEL_CONTEXT_CPU_ID:
> 		return lttng_add_cpu_id_to_ctx(ctx);
> +	case LTTNG_KERNEL_CONTEXT_INTERRUPTIBLE:
> +		return lttng_add_interruptible_to_ctx(ctx);
> +	case LTTNG_KERNEL_CONTEXT_NEED_RESCHEDULE:
> +		return lttng_add_need_reschedule_to_ctx(ctx);
> +#if defined(CONFIG_PREEMPT_RT_FULL) || defined(CONFIG_PREEMPT)
> +	case LTTNG_KERNEL_CONTEXT_PREEMPTIBLE:
> +		return lttng_add_preemptible_to_ctx(ctx);
> +#endif
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +	case LTTNG_KERNEL_CONTEXT_MIGRATABLE:
> +		return lttng_add_migratable_to_ctx(ctx);
> +#endif
> 	default:
> 		return -EINVAL;
> 	}
> diff --git a/lttng-abi.h b/lttng-abi.h
> index a40b58f..e53ff27 100644
> --- a/lttng-abi.h
> +++ b/lttng-abi.h
> @@ -142,6 +142,10 @@ enum lttng_kernel_context_type {
> 	LTTNG_KERNEL_CONTEXT_VPPID		= 9,
> 	LTTNG_KERNEL_CONTEXT_HOSTNAME		= 10,
> 	LTTNG_KERNEL_CONTEXT_CPU_ID		= 11,
> +	LTTNG_KERNEL_CONTEXT_INTERRUPTIBLE	= 12,
> +	LTTNG_KERNEL_CONTEXT_PREEMPTIBLE	= 13,
> +	LTTNG_KERNEL_CONTEXT_NEED_RESCHEDULE	= 14,
> +	LTTNG_KERNEL_CONTEXT_MIGRATABLE		= 15,
> };
> 
> struct lttng_kernel_perf_counter_ctx {
> diff --git a/lttng-context-interruptible.c b/lttng-context-interruptible.c
> new file mode 100644
> index 0000000..25186b7
> --- /dev/null
> +++ b/lttng-context-interruptible.c
> @@ -0,0 +1,94 @@
> +/*
> + * lttng-context-interruptible.c
> + *
> + * LTTng interruptible context.
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
> +#include <linux/slab.h>
> +#include <linux/sched.h>
> +#include <linux/irqflags.h>
> +#include "lttng-events.h"
> +#include "wrapper/ringbuffer/frontend_types.h"
> +#include "wrapper/vmalloc.h"
> +#include "lttng-tracer.h"
> +
> +static
> +size_t interruptible_get_size(size_t offset)
> +{
> +	size_t size = 0;
> +
> +	size += lib_ring_buffer_align(offset, lttng_alignof(uint8_t));
> +	size += sizeof(uint8_t);
> +	return size;
> +}
> +
> +static
> +void interruptible_record(struct lttng_ctx_field *field,
> +		struct lib_ring_buffer_ctx *ctx,
> +		struct lttng_channel *chan)
> +{
> +	uint8_t interruptible = !irqs_disabled();
> +
> +	lib_ring_buffer_align_ctx(ctx, lttng_alignof(interruptible));
> +	chan->ops->event_write(ctx, &interruptible, sizeof(interruptible));
> +}
> +
> +static
> +void interruptible_get_value(struct lttng_ctx_field *field,
> +		union lttng_ctx_value *value)
> +{
> +	value->s64 = !irqs_disabled();
> +}
> +
> +int lttng_add_interruptible_to_ctx(struct lttng_ctx **ctx)
> +{
> +	struct lttng_ctx_field *field;
> +
> +	field = lttng_append_context(ctx);
> +	if (!field)
> +		return -ENOMEM;
> +	if (lttng_find_context(*ctx, "interruptible")) {
> +		lttng_remove_context_field(ctx, field);
> +		return -EEXIST;
> +	}
> +	field->event_field.name = "interruptible";
> +	field->event_field.type.atype = atype_integer;
> +	field->event_field.type.u.basic.integer.size = sizeof(uint8_t) * CHAR_BIT;
> +	field->event_field.type.u.basic.integer.alignment = lttng_alignof(uint8_t) *
> CHAR_BIT;
> +	field->event_field.type.u.basic.integer.signedness =
> lttng_is_signed_type(uint8_t);
> +	field->event_field.type.u.basic.integer.reverse_byte_order = 0;
> +	field->event_field.type.u.basic.integer.base = 10;
> +	field->event_field.type.u.basic.integer.encoding = lttng_encode_none;
> +	field->get_size = interruptible_get_size;
> +	field->record = interruptible_record;
> +	field->get_value = interruptible_get_value;
> +	lttng_context_update(*ctx);
> +	wrapper_vmalloc_sync_all();
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(lttng_add_interruptible_to_ctx);
> +
> +MODULE_LICENSE("GPL and additional rights");
> +MODULE_AUTHOR("Mathieu Desnoyers");
> +MODULE_DESCRIPTION("Linux Trace Toolkit interruptible Context");
> +MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
> +	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
> +	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
> +	LTTNG_MODULES_EXTRAVERSION);
> diff --git a/lttng-context-migratable.c b/lttng-context-migratable.c
> new file mode 100644
> index 0000000..8a5cfbf
> --- /dev/null
> +++ b/lttng-context-migratable.c
> @@ -0,0 +1,94 @@
> +/*
> + * lttng-context-migratable.c
> + *
> + * LTTng migratable context.
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
> +#include <linux/slab.h>
> +#include <linux/sched.h>
> +#include <linux/irqflags.h>
> +#include "lttng-events.h"
> +#include "wrapper/ringbuffer/frontend_types.h"
> +#include "wrapper/vmalloc.h"
> +#include "lttng-tracer.h"
> +
> +static
> +size_t migratable_get_size(size_t offset)
> +{
> +	size_t size = 0;
> +
> +	size += lib_ring_buffer_align(offset, lttng_alignof(uint8_t));
> +	size += sizeof(uint8_t);
> +	return size;
> +}
> +
> +static
> +void migratable_record(struct lttng_ctx_field *field,
> +		struct lib_ring_buffer_ctx *ctx,
> +		struct lttng_channel *chan)
> +{
> +	uint8_t migratable = !__migrate_disabled(current);
> +
> +	lib_ring_buffer_align_ctx(ctx, lttng_alignof(migratable));
> +	chan->ops->event_write(ctx, &migratable, sizeof(migratable));
> +}
> +
> +static
> +void migratable_get_value(struct lttng_ctx_field *field,
> +		union lttng_ctx_value *value)
> +{
> +	value->s64 = !__migrate_disabled(current);
> +}
> +
> +int lttng_add_migratable_to_ctx(struct lttng_ctx **ctx)
> +{
> +	struct lttng_ctx_field *field;
> +
> +	field = lttng_append_context(ctx);
> +	if (!field)
> +		return -ENOMEM;
> +	if (lttng_find_context(*ctx, "migratable")) {
> +		lttng_remove_context_field(ctx, field);
> +		return -EEXIST;
> +	}
> +	field->event_field.name = "migratable";
> +	field->event_field.type.atype = atype_integer;
> +	field->event_field.type.u.basic.integer.size = sizeof(uint8_t) * CHAR_BIT;
> +	field->event_field.type.u.basic.integer.alignment = lttng_alignof(uint8_t) *
> CHAR_BIT;
> +	field->event_field.type.u.basic.integer.signedness =
> lttng_is_signed_type(uint8_t);
> +	field->event_field.type.u.basic.integer.reverse_byte_order = 0;
> +	field->event_field.type.u.basic.integer.base = 10;
> +	field->event_field.type.u.basic.integer.encoding = lttng_encode_none;
> +	field->get_size = migratable_get_size;
> +	field->record = migratable_record;
> +	field->get_value = migratable_get_value;
> +	lttng_context_update(*ctx);
> +	wrapper_vmalloc_sync_all();
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(lttng_add_migratable_to_ctx);
> +
> +MODULE_LICENSE("GPL and additional rights");
> +MODULE_AUTHOR("Mathieu Desnoyers");
> +MODULE_DESCRIPTION("Linux Trace Toolkit migratable Context");
> +MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
> +	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
> +	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
> +	LTTNG_MODULES_EXTRAVERSION);
> diff --git a/lttng-context-need-reschedule.c b/lttng-context-need-reschedule.c
> new file mode 100644
> index 0000000..8864e40
> --- /dev/null
> +++ b/lttng-context-need-reschedule.c
> @@ -0,0 +1,94 @@
> +/*
> + * lttng-context-need_reschedule.c
> + *
> + * LTTng need_reschedule context.
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
> +#include <linux/slab.h>
> +#include <linux/sched.h>
> +#include <linux/irqflags.h>
> +#include "lttng-events.h"
> +#include "wrapper/ringbuffer/frontend_types.h"
> +#include "wrapper/vmalloc.h"
> +#include "lttng-tracer.h"
> +
> +static
> +size_t need_reschedule_get_size(size_t offset)
> +{
> +	size_t size = 0;
> +
> +	size += lib_ring_buffer_align(offset, lttng_alignof(uint8_t));
> +	size += sizeof(uint8_t);
> +	return size;
> +}
> +
> +static
> +void need_reschedule_record(struct lttng_ctx_field *field,
> +		struct lib_ring_buffer_ctx *ctx,
> +		struct lttng_channel *chan)
> +{
> +	uint8_t need_reschedule = test_tsk_need_resched(current);
> +
> +	lib_ring_buffer_align_ctx(ctx, lttng_alignof(need_reschedule));
> +	chan->ops->event_write(ctx, &need_reschedule, sizeof(need_reschedule));
> +}
> +
> +static
> +void need_reschedule_get_value(struct lttng_ctx_field *field,
> +		union lttng_ctx_value *value)
> +{
> +	value->s64 = test_tsk_need_resched(current);;
> +}
> +
> +int lttng_add_need_reschedule_to_ctx(struct lttng_ctx **ctx)
> +{
> +	struct lttng_ctx_field *field;
> +
> +	field = lttng_append_context(ctx);
> +	if (!field)
> +		return -ENOMEM;
> +	if (lttng_find_context(*ctx, "need_reschedule")) {
> +		lttng_remove_context_field(ctx, field);
> +		return -EEXIST;
> +	}
> +	field->event_field.name = "need_reschedule";
> +	field->event_field.type.atype = atype_integer;
> +	field->event_field.type.u.basic.integer.size = sizeof(uint8_t) * CHAR_BIT;
> +	field->event_field.type.u.basic.integer.alignment = lttng_alignof(uint8_t) *
> CHAR_BIT;
> +	field->event_field.type.u.basic.integer.signedness =
> lttng_is_signed_type(uint8_t);
> +	field->event_field.type.u.basic.integer.reverse_byte_order = 0;
> +	field->event_field.type.u.basic.integer.base = 10;
> +	field->event_field.type.u.basic.integer.encoding = lttng_encode_none;
> +	field->get_size = need_reschedule_get_size;
> +	field->record = need_reschedule_record;
> +	field->get_value = need_reschedule_get_value;
> +	lttng_context_update(*ctx);
> +	wrapper_vmalloc_sync_all();
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(lttng_add_need_reschedule_to_ctx);
> +
> +MODULE_LICENSE("GPL and additional rights");
> +MODULE_AUTHOR("Mathieu Desnoyers");
> +MODULE_DESCRIPTION("Linux Trace Toolkit need_reschedule Context");
> +MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
> +	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
> +	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
> +	LTTNG_MODULES_EXTRAVERSION);
> diff --git a/lttng-context-preemptible.c b/lttng-context-preemptible.c
> new file mode 100644
> index 0000000..7ef41a8
> --- /dev/null
> +++ b/lttng-context-preemptible.c
> @@ -0,0 +1,99 @@
> +/*
> + * lttng-context-preemptible.c
> + *
> + * LTTng preemptible context.
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
> +#include <linux/slab.h>
> +#include <linux/sched.h>
> +#include <linux/irqflags.h>
> +#include "lttng-events.h"
> +#include "wrapper/ringbuffer/frontend_types.h"
> +#include "wrapper/vmalloc.h"
> +#include "lttng-tracer.h"
> +
> +static
> +size_t preemptible_get_size(size_t offset)
> +{
> +	size_t size = 0;
> +
> +	size += lib_ring_buffer_align(offset, lttng_alignof(uint8_t));
> +	size += sizeof(uint8_t);
> +	return size;
> +}
> +
> +static
> +void preemptible_record(struct lttng_ctx_field *field,
> +		struct lib_ring_buffer_ctx *ctx,
> +		struct lttng_channel *chan)
> +{
> +	uint8_t preemptible;
> +
> +	/*
> +	 * The tracing adds 2 levels of preempt_disable.
> +	 */
> +	WARN_ON_ONCE(preempt_count() < 2);
> +	preemptible = ((preempt_count() - 2) == 0);
> +	lib_ring_buffer_align_ctx(ctx, lttng_alignof(preemptible));
> +	chan->ops->event_write(ctx, &preemptible, sizeof(preemptible));
> +}
> +
> +static
> +void preemptible_get_value(struct lttng_ctx_field *field,
> +		union lttng_ctx_value *value)
> +{
> +	value->s64 = ((preempt_count() - 2) == 0);
> +}
> +
> +int lttng_add_preemptible_to_ctx(struct lttng_ctx **ctx)
> +{
> +	struct lttng_ctx_field *field;
> +
> +	field = lttng_append_context(ctx);
> +	if (!field)
> +		return -ENOMEM;
> +	if (lttng_find_context(*ctx, "preemptible")) {
> +		lttng_remove_context_field(ctx, field);
> +		return -EEXIST;
> +	}
> +	field->event_field.name = "preemptible";
> +	field->event_field.type.atype = atype_integer;
> +	field->event_field.type.u.basic.integer.size = sizeof(uint8_t) * CHAR_BIT;
> +	field->event_field.type.u.basic.integer.alignment = lttng_alignof(uint8_t) *
> CHAR_BIT;
> +	field->event_field.type.u.basic.integer.signedness =
> lttng_is_signed_type(uint8_t);
> +	field->event_field.type.u.basic.integer.reverse_byte_order = 0;
> +	field->event_field.type.u.basic.integer.base = 10;
> +	field->event_field.type.u.basic.integer.encoding = lttng_encode_none;
> +	field->get_size = preemptible_get_size;
> +	field->record = preemptible_record;
> +	field->get_value = preemptible_get_value;
> +	lttng_context_update(*ctx);
> +	wrapper_vmalloc_sync_all();
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(lttng_add_preemptible_to_ctx);
> +
> +MODULE_LICENSE("GPL and additional rights");
> +MODULE_AUTHOR("Mathieu Desnoyers");
> +MODULE_DESCRIPTION("Linux Trace Toolkit preemptible Context");
> +MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
> +	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
> +	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
> +	LTTNG_MODULES_EXTRAVERSION);
> diff --git a/lttng-context.c b/lttng-context.c
> index eca58ce..ee17282 100644
> --- a/lttng-context.c
> +++ b/lttng-context.c
> @@ -268,6 +268,26 @@ int lttng_context_init(void)
> 	if (ret) {
> 		printk(KERN_WARNING "Cannot add context lttng_add_cpu_id_to_ctx");
> 	}
> +	ret = lttng_add_interruptible_to_ctx(&lttng_static_ctx);
> +	if (ret) {
> +		printk(KERN_WARNING "Cannot add context lttng_add_interruptible_to_ctx");
> +	}
> +	ret = lttng_add_need_reschedule_to_ctx(&lttng_static_ctx);
> +	if (ret) {
> +		printk(KERN_WARNING "Cannot add context lttng_add_need_reschedule_to_ctx");
> +	}
> +#if defined(CONFIG_PREEMPT_RT_FULL) || defined(CONFIG_PREEMPT)
> +	ret = lttng_add_preemptible_to_ctx(&lttng_static_ctx);
> +	if (ret) {
> +		printk(KERN_WARNING "Cannot add context lttng_add_preemptible_to_ctx");
> +	}
> +#endif
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +	ret = lttng_add_migratable_to_ctx(&lttng_static_ctx);
> +	if (ret) {
> +		printk(KERN_WARNING "Cannot add context lttng_add_migratable_to_ctx");
> +	}
> +#endif
> 	/* TODO: perf counters for filtering */
> 	return 0;
> }
> diff --git a/lttng-events.h b/lttng-events.h
> index 234d4bc..44e6f92 100644
> --- a/lttng-events.h
> +++ b/lttng-events.h
> @@ -630,6 +630,14 @@ int lttng_add_vtid_to_ctx(struct lttng_ctx **ctx);
> int lttng_add_ppid_to_ctx(struct lttng_ctx **ctx);
> int lttng_add_vppid_to_ctx(struct lttng_ctx **ctx);
> int lttng_add_hostname_to_ctx(struct lttng_ctx **ctx);
> +int lttng_add_interruptible_to_ctx(struct lttng_ctx **ctx);
> +int lttng_add_need_reschedule_to_ctx(struct lttng_ctx **ctx);
> +#if defined(CONFIG_PREEMPT_RT_FULL) || defined(CONFIG_PREEMPT)
> +int lttng_add_preemptible_to_ctx(struct lttng_ctx **ctx);
> +#endif
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +int lttng_add_migratable_to_ctx(struct lttng_ctx **ctx);
> +#endif
> #if defined(CONFIG_PERF_EVENTS) && (LINUX_VERSION_CODE >=
> KERNEL_VERSION(2,6,33))
> int lttng_add_perf_counter_to_ctx(uint32_t type,
> 				  uint64_t config,
> --
> 1.9.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
