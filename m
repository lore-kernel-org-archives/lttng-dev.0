From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [MODULES PATCH] irqsoff and preemptoff contexts
Date: Tue, 10 Nov 2015 21:20:07 -0500
Message-ID: <1447208407-24345-1-git-send-email-jdesfossez__7167.13716178692$1447208476$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZwL1K-0000sX-Gi
 for lttng-dev@lists.lttng.org; Tue, 10 Nov 2015 21:20:24 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 Makefile                   |  1 +
 lttng-abi.c                |  4 ++
 lttng-abi.h                |  2 +
 lttng-context-irqsoff.c    | 94 ++++++++++++++++++++++++++++++++++++++++++++++
 lttng-context-preemptoff.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++
 lttng-context.c            |  8 ++++
 lttng-events.h             |  2 +
 7 files changed, 205 insertions(+)
 create mode 100644 lttng-context-irqsoff.c
 create mode 100644 lttng-context-preemptoff.c

diff --git a/Makefile b/Makefile
index f7aa23f..efc534e 100644
--- a/Makefile
+++ b/Makefile
@@ -41,6 +41,7 @@ lttng-tracer-objs :=  lttng-events.o lttng-abi.o \
 			lttng-context-vpid.o lttng-context-tid.o \
 			lttng-context-vtid.o lttng-context-ppid.o \
 			lttng-context-vppid.o lttng-context-cpu-id.o \
+			lttng-context-irqsoff.o lttng-context-preemptoff.o \
 			lttng-calibrate.o \
 			lttng-context-hostname.o wrapper/random.o \
 			probes/lttng.o wrapper/trace-clock.o \
diff --git a/lttng-abi.c b/lttng-abi.c
index f6f3043..8be9b1e 100644
--- a/lttng-abi.c
+++ b/lttng-abi.c
@@ -236,6 +236,10 @@ long lttng_abi_add_context(struct file *file,
 		return lttng_add_hostname_to_ctx(ctx);
 	case LTTNG_KERNEL_CONTEXT_CPU_ID:
 		return lttng_add_cpu_id_to_ctx(ctx);
+	case LTTNG_KERNEL_CONTEXT_IRQSOFF:
+		return lttng_add_irqsoff_to_ctx(ctx);
+	case LTTNG_KERNEL_CONTEXT_PREEMPTOFF:
+		return lttng_add_preemptoff_to_ctx(ctx);
 	default:
 		return -EINVAL;
 	}
diff --git a/lttng-abi.h b/lttng-abi.h
index a40b58f..e8b0647 100644
--- a/lttng-abi.h
+++ b/lttng-abi.h
@@ -142,6 +142,8 @@ enum lttng_kernel_context_type {
 	LTTNG_KERNEL_CONTEXT_VPPID		= 9,
 	LTTNG_KERNEL_CONTEXT_HOSTNAME		= 10,
 	LTTNG_KERNEL_CONTEXT_CPU_ID		= 11,
+	LTTNG_KERNEL_CONTEXT_IRQSOFF		= 12,
+	LTTNG_KERNEL_CONTEXT_PREEMPTOFF		= 13,
 };
 
 struct lttng_kernel_perf_counter_ctx {
diff --git a/lttng-context-irqsoff.c b/lttng-context-irqsoff.c
new file mode 100644
index 0000000..2980265
--- /dev/null
+++ b/lttng-context-irqsoff.c
@@ -0,0 +1,94 @@
+/*
+ * lttng-context-irqsoff.c
+ *
+ * LTTng irqsoff context.
+ *
+ * Copyright (C) 2009-2012 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; only
+ * version 2.1 of the License.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/irqflags.h>
+#include "lttng-events.h"
+#include "wrapper/ringbuffer/frontend_types.h"
+#include "wrapper/vmalloc.h"
+#include "lttng-tracer.h"
+
+static
+size_t irqsoff_get_size(size_t offset)
+{
+	size_t size = 0;
+
+	size += lib_ring_buffer_align(offset, lttng_alignof(uint8_t));
+	size += sizeof(uint8_t);
+	return size;
+}
+
+static
+void irqsoff_record(struct lttng_ctx_field *field,
+		struct lib_ring_buffer_ctx *ctx,
+		struct lttng_channel *chan)
+{
+	uint8_t irqsoff = irqs_disabled();
+
+	lib_ring_buffer_align_ctx(ctx, lttng_alignof(irqsoff));
+	chan->ops->event_write(ctx, &irqsoff, sizeof(irqsoff));
+}
+
+static
+void irqsoff_get_value(struct lttng_ctx_field *field,
+		union lttng_ctx_value *value)
+{
+	value->s64 = irqs_disabled();
+}
+
+int lttng_add_irqsoff_to_ctx(struct lttng_ctx **ctx)
+{
+	struct lttng_ctx_field *field;
+
+	field = lttng_append_context(ctx);
+	if (!field)
+		return -ENOMEM;
+	if (lttng_find_context(*ctx, "irqsoff")) {
+		lttng_remove_context_field(ctx, field);
+		return -EEXIST;
+	}
+	field->event_field.name = "irqsoff";
+	field->event_field.type.atype = atype_integer;
+	field->event_field.type.u.basic.integer.size = sizeof(uint8_t) * CHAR_BIT;
+	field->event_field.type.u.basic.integer.alignment = lttng_alignof(uint8_t) * CHAR_BIT;
+	field->event_field.type.u.basic.integer.signedness = lttng_is_signed_type(uint8_t);
+	field->event_field.type.u.basic.integer.reverse_byte_order = 0;
+	field->event_field.type.u.basic.integer.base = 10;
+	field->event_field.type.u.basic.integer.encoding = lttng_encode_none;
+	field->get_size = irqsoff_get_size;
+	field->record = irqsoff_record;
+	field->get_value = irqsoff_get_value;
+	lttng_context_update(*ctx);
+	wrapper_vmalloc_sync_all();
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lttng_add_irqsoff_to_ctx);
+
+MODULE_LICENSE("GPL and additional rights");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit irqsoff Context");
+MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
+	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
+	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
+	LTTNG_MODULES_EXTRAVERSION);
diff --git a/lttng-context-preemptoff.c b/lttng-context-preemptoff.c
new file mode 100644
index 0000000..72d60f8
--- /dev/null
+++ b/lttng-context-preemptoff.c
@@ -0,0 +1,94 @@
+/*
+ * lttng-context-preemptoff.c
+ *
+ * LTTng preemptoff context.
+ *
+ * Copyright (C) 2009-2012 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; only
+ * version 2.1 of the License.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/irqflags.h>
+#include "lttng-events.h"
+#include "wrapper/ringbuffer/frontend_types.h"
+#include "wrapper/vmalloc.h"
+#include "lttng-tracer.h"
+
+static
+size_t preemptoff_get_size(size_t offset)
+{
+	size_t size = 0;
+
+	size += lib_ring_buffer_align(offset, lttng_alignof(uint8_t));
+	size += sizeof(uint8_t);
+	return size;
+}
+
+static
+void preemptoff_record(struct lttng_ctx_field *field,
+		struct lib_ring_buffer_ctx *ctx,
+		struct lttng_channel *chan)
+{
+	uint8_t preemptoff = !!preempt_count();
+
+	lib_ring_buffer_align_ctx(ctx, lttng_alignof(preemptoff));
+	chan->ops->event_write(ctx, &preemptoff, sizeof(preemptoff));
+}
+
+static
+void preemptoff_get_value(struct lttng_ctx_field *field,
+		union lttng_ctx_value *value)
+{
+	value->s64 = !!preempt_count();
+}
+
+int lttng_add_preemptoff_to_ctx(struct lttng_ctx **ctx)
+{
+	struct lttng_ctx_field *field;
+
+	field = lttng_append_context(ctx);
+	if (!field)
+		return -ENOMEM;
+	if (lttng_find_context(*ctx, "preemptoff")) {
+		lttng_remove_context_field(ctx, field);
+		return -EEXIST;
+	}
+	field->event_field.name = "preemptoff";
+	field->event_field.type.atype = atype_integer;
+	field->event_field.type.u.basic.integer.size = sizeof(uint8_t) * CHAR_BIT;
+	field->event_field.type.u.basic.integer.alignment = lttng_alignof(uint8_t) * CHAR_BIT;
+	field->event_field.type.u.basic.integer.signedness = lttng_is_signed_type(uint8_t);
+	field->event_field.type.u.basic.integer.reverse_byte_order = 0;
+	field->event_field.type.u.basic.integer.base = 10;
+	field->event_field.type.u.basic.integer.encoding = lttng_encode_none;
+	field->get_size = preemptoff_get_size;
+	field->record = preemptoff_record;
+	field->get_value = preemptoff_get_value;
+	lttng_context_update(*ctx);
+	wrapper_vmalloc_sync_all();
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lttng_add_preemptoff_to_ctx);
+
+MODULE_LICENSE("GPL and additional rights");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit preemptoff Context");
+MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
+	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
+	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
+	LTTNG_MODULES_EXTRAVERSION);
diff --git a/lttng-context.c b/lttng-context.c
index eca58ce..66e828b 100644
--- a/lttng-context.c
+++ b/lttng-context.c
@@ -268,6 +268,14 @@ int lttng_context_init(void)
 	if (ret) {
 		printk(KERN_WARNING "Cannot add context lttng_add_cpu_id_to_ctx");
 	}
+	ret = lttng_add_irqsoff_to_ctx(&lttng_static_ctx);
+	if (ret) {
+		printk(KERN_WARNING "Cannot add context lttng_add_irqsoff_to_ctx");
+	}
+	ret = lttng_add_preemptoff_to_ctx(&lttng_static_ctx);
+	if (ret) {
+		printk(KERN_WARNING "Cannot add context lttng_add_preemptoff_to_ctx");
+	}
 	/* TODO: perf counters for filtering */
 	return 0;
 }
diff --git a/lttng-events.h b/lttng-events.h
index 234d4bc..dda22e7 100644
--- a/lttng-events.h
+++ b/lttng-events.h
@@ -630,6 +630,8 @@ int lttng_add_vtid_to_ctx(struct lttng_ctx **ctx);
 int lttng_add_ppid_to_ctx(struct lttng_ctx **ctx);
 int lttng_add_vppid_to_ctx(struct lttng_ctx **ctx);
 int lttng_add_hostname_to_ctx(struct lttng_ctx **ctx);
+int lttng_add_irqsoff_to_ctx(struct lttng_ctx **ctx);
+int lttng_add_preemptoff_to_ctx(struct lttng_ctx **ctx);
 #if defined(CONFIG_PERF_EVENTS) && (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
 int lttng_add_perf_counter_to_ctx(uint32_t type,
 				  uint64_t config,
-- 
1.9.1
