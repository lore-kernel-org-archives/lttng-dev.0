From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [lttng-modules PATCH] Add uprobes support
Date: Sun, 13 Jan 2013 21:40:30 -0500
Message-ID: <1358131230-3446-1-git-send-email-yannick.brosseau__48470.2895315879$1358131295$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1TuZym-0001Qw-Fj
	for lttng-dev@lists.lttng.org; Sun, 13 Jan 2013 21:40:52 -0500
Received: by mail-ia0-f172.google.com with SMTP id u8so3257578iag.31
	for <lttng-dev@lists.lttng.org>; Sun, 13 Jan 2013 18:40:47 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The added support is basic. It create an event with no data associated to the file path + offset
specified.
As per the structures currently used we cannot pass a file path bigger than 256 chars.

Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
---
 README                 |    5 +-
 lttng-abi.c            |    3 +
 lttng-abi.h            |    7 +++
 lttng-events.c         |   18 ++++++
 lttng-events.h         |   38 ++++++++++++
 probes/Makefile        |    5 ++
 probes/lttng-uprobes.c |  156 ++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 231 insertions(+), 1 deletion(-)
 create mode 100644 probes/lttng-uprobes.c

diff --git a/README b/README
index 1bcd5b2..7afdaa3 100644
--- a/README
+++ b/README
@@ -9,7 +9,7 @@ need for additional patches. Other features:
 - Produces CTF (Common Trace Format) natively,
   (http://www.efficios.com/ctf)
 - Tracepoints, Function tracer, CPU Performance Monitoring Unit (PMU)
-  counters, kprobes, and kretprobes support,
+  counters, kprobes, kretprobes and uprobes support,
 - Integrated interface for both kernel and userspace tracing,
 - Have the ability to attach "context" information to events in the
   trace (e.g. any PMU counter, pid, ppid, tid, comm name, etc).
@@ -86,6 +86,9 @@ CONFIG_KPROBES:
 CONFIG_KRETPROBES:
             Dynamic function entry/return probe.
                lttng enable-event -k --function ...
+CONFIG_UPROBES:
+            Dynamic userspace probe.
+               lttng enable-event -k --uprobe ...
 
 
 * Note about Perf PMU counters support
diff --git a/lttng-abi.c b/lttng-abi.c
index 25a350a..fe428b2 100644
--- a/lttng-abi.c
+++ b/lttng-abi.c
@@ -610,6 +610,9 @@ int lttng_abi_create_event(struct file *channel_file,
 	case LTTNG_KERNEL_FUNCTION:
 		event_param->u.ftrace.symbol_name[LTTNG_KERNEL_SYM_NAME_LEN - 1] = '\0';
 		break;
+	case LTTNG_KERNEL_UPROBE:
+		event_param->u.uprobe.path[LTTNG_KERNEL_SYM_NAME_LEN - 1] = '\0';
+		break;
 	default:
 		break;
 	}
diff --git a/lttng-abi.h b/lttng-abi.h
index 8d3ecdd..5abdb39 100644
--- a/lttng-abi.h
+++ b/lttng-abi.h
@@ -34,6 +34,7 @@ enum lttng_kernel_instrumentation {
 	LTTNG_KERNEL_KRETPROBE	= 3,
 	LTTNG_KERNEL_NOOP	= 4,	/* not hooked */
 	LTTNG_KERNEL_SYSCALL	= 5,
+	LTTNG_KERNEL_UPROBE	= 6,
 };
 
 /*
@@ -79,6 +80,11 @@ struct lttng_kernel_function_tracer {
 	char symbol_name[LTTNG_KERNEL_SYM_NAME_LEN];
 }__attribute__((packed));
 
+struct lttng_kernel_uprobe {
+	char path[LTTNG_KERNEL_SYM_NAME_LEN];
+	uint64_t offset;
+}__attribute__((packed));
+
 /*
  * For syscall tracing, name = '\0' means "enable all".
  */
@@ -94,6 +100,7 @@ struct lttng_kernel_event {
 		struct lttng_kernel_kretprobe kretprobe;
 		struct lttng_kernel_kprobe kprobe;
 		struct lttng_kernel_function_tracer ftrace;
+		struct lttng_kernel_uprobe uprobe;
 		char padding[LTTNG_KERNEL_EVENT_PADDING2];
 	} u;
 }__attribute__((packed));
diff --git a/lttng-events.c b/lttng-events.c
index 4f30904..38c901f 100644
--- a/lttng-events.c
+++ b/lttng-events.c
@@ -392,6 +392,16 @@ struct lttng_event *lttng_event_create(struct lttng_channel *chan,
 		if (!event->desc)
 			goto register_error;
 		break;
+	case LTTNG_KERNEL_UPROBE:
+		ret = lttng_uprobes_register(event_param->name,
+				event_param->u.uprobe.path,
+				event_param->u.uprobe.offset,
+				event);
+		if (ret)
+			goto register_error;
+		ret = try_module_get(event->desc->owner);
+		WARN_ON_ONCE(!ret);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
@@ -443,6 +453,10 @@ int _lttng_event_unregister(struct lttng_event *event)
 	case LTTNG_KERNEL_NOOP:
 		ret = 0;
 		break;
+	case LTTNG_KERNEL_UPROBE:
+		lttng_uprobes_unregister(event);
+		ret = 0;
+		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
@@ -473,6 +487,10 @@ void _lttng_event_destroy(struct lttng_event *event)
 		break;
 	case LTTNG_KERNEL_NOOP:
 		break;
+	case LTTNG_KERNEL_UPROBE:
+		module_put(event->desc->owner);
+		lttng_uprobes_destroy_private(event);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
diff --git a/lttng-events.h b/lttng-events.h
index 09d5618..e630db0 100644
--- a/lttng-events.h
+++ b/lttng-events.h
@@ -26,6 +26,9 @@
 #include <linux/version.h>
 #include <linux/list.h>
 #include <linux/kprobes.h>
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
+#include <linux/uprobes.h>
+#endif
 #include "wrapper/uuid.h"
 #include "lttng-abi.h"
 #include "lttng-abi-old.h"
@@ -203,6 +206,13 @@ struct lttng_event {
 		struct {
 			char *symbol_name;
 		} ftrace;
+		struct {
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
+			struct uprobe_consumer up_consumer;
+#endif
+			struct inode *inode;
+			loff_t offset;
+		} uprobe;
 	} u;
 	struct list_head list;		/* Event list */
 	unsigned int metadata_dumped:1;
@@ -406,6 +416,34 @@ void lttng_kprobes_destroy_private(struct lttng_event *event)
 }
 #endif
 
+#ifdef CONFIG_UPROBES
+int lttng_uprobes_register(const char *name,
+		const char *path,
+		uint64_t offset,
+		struct lttng_event *event);
+void lttng_uprobes_unregister(struct lttng_event *event);
+void lttng_uprobes_destroy_private(struct lttng_event *event);
+#else
+static inline
+int lttng_uprobes_register(const char *name,
+		const char *path,
+		uint64_t offset,
+		struct lttng_event *event)
+{
+	return -ENOSYS;
+}
+
+static inline
+void lttng_uprobes_unregister(struct lttng_event *event)
+{
+}
+
+static inline
+void lttng_uprobes_destroy_private(struct lttng_event *event)
+{
+}
+#endif
+
 #ifdef CONFIG_KRETPROBES
 int lttng_kretprobes_register(const char *name,
 		const char *symbol_name,
diff --git a/probes/Makefile b/probes/Makefile
index 088cd5f..de0f1a7 100644
--- a/probes/Makefile
+++ b/probes/Makefile
@@ -208,6 +208,11 @@ ifneq ($(CONFIG_DYNAMIC_FTRACE),)
 obj-m += lttng-ftrace.o
 endif
 
+ifneq ($(CONFIG_UPROBES),)
+obj-m += lttng-uprobes.o
+endif
+
+
 endif
 
 else
diff --git a/probes/lttng-uprobes.c b/probes/lttng-uprobes.c
new file mode 100644
index 0000000..1d68273
--- /dev/null
+++ b/probes/lttng-uprobes.c
@@ -0,0 +1,156 @@
+/*
+ * probes/lttng-uprobes.c
+ *
+ * LTTng uprobes integration module.
+ *
+ * Copyright (C) 2013 Yannick Brosseau <yannick.brosseau@gmail.com>
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
+#include <linux/uprobes.h>
+#include <linux/slab.h>
+#include <linux/namei.h>
+#include <linux/fs.h>
+#include "../lttng-events.h"
+#include "../wrapper/ringbuffer/frontend_types.h"
+#include "../wrapper/vmalloc.h"
+#include "../lttng-tracer.h"
+
+static
+int lttng_uprobes_handler_pre(struct uprobe_consumer *uc, struct pt_regs *regs)
+{
+	struct lttng_event *event =
+		container_of(uc, struct lttng_event, u.uprobe.up_consumer);
+	struct lttng_channel *chan = event->chan;
+	struct lib_ring_buffer_ctx ctx;
+	int ret;
+
+	if (unlikely(!ACCESS_ONCE(chan->session->active)))
+		return 0;
+	if (unlikely(!ACCESS_ONCE(chan->enabled)))
+		return 0;
+	if (unlikely(!ACCESS_ONCE(event->enabled)))
+		return 0;
+
+	lib_ring_buffer_ctx_init(&ctx, chan->chan, event, 0,
+				 0, -1);
+	ret = chan->ops->event_reserve(&ctx, event->id);
+	if (ret < 0)
+		return 0;
+	lib_ring_buffer_align_ctx(&ctx, 0);
+	chan->ops->event_write(&ctx, 0, 0);
+	chan->ops->event_commit(&ctx);
+	return 0;
+}
+
+/*
+ * Create event description
+ */
+static
+int lttng_create_uprobe_event(const char *name, struct lttng_event *event)
+{
+	struct lttng_event_desc *desc;
+	int ret;
+
+	desc = kzalloc(sizeof(*event->desc), GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
+	desc->name = kstrdup(name, GFP_KERNEL);
+	if (!desc->name) {
+		ret = -ENOMEM;
+		goto error_str;
+	}
+	desc->owner = THIS_MODULE;
+	event->desc = desc;
+
+	return 0;
+
+error_str:
+	kfree(desc);
+	return ret;
+}
+
+int lttng_uprobes_register(const char *name,
+			   const char *path_name,
+			   uint64_t offset,
+			   struct lttng_event *event)
+{
+	int ret;
+
+	if (path_name[0] == '\0')
+		path_name = NULL;
+
+	ret = lttng_create_uprobe_event(name, event);
+	if (ret)
+		goto error;
+	memset(&event->u.uprobe.up_consumer, 0,
+		sizeof(event->u.uprobe.up_consumer));
+	event->u.uprobe.up_consumer.handler = lttng_uprobes_handler_pre;
+	if (path_name) {
+		struct path path;
+		ret = kern_path(path_name, LOOKUP_FOLLOW, &path);
+		if (ret)
+			goto path_error;
+
+		event->u.uprobe.inode = igrab(path.dentry->d_inode);
+	}
+	event->u.uprobe.offset = offset;
+
+	/* TODO Is this also true for uprobes?
+	 * Ensure the memory we just allocated don't trigger page faults.
+	 * Well.. kprobes itself puts the page fault handler on the blacklist,
+	 * but we can never be too careful.
+	 */
+	wrapper_vmalloc_sync_all();
+
+	ret = uprobe_register(event->u.uprobe.inode,
+			event->u.uprobe.offset,
+			&event->u.uprobe.up_consumer);
+	if (ret)
+		goto register_error;
+	return 0;
+
+register_error:
+	iput(event->u.uprobe.inode);
+path_error:
+	kfree(event->desc->name);
+	kfree(event->desc);
+error:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(lttng_uprobes_register);
+
+void lttng_uprobes_unregister(struct lttng_event *event)
+{
+	uprobe_unregister(event->u.uprobe.inode,
+			event->u.uprobe.offset,
+			&event->u.uprobe.up_consumer);
+}
+EXPORT_SYMBOL_GPL(lttng_uprobes_unregister);
+
+void lttng_uprobes_destroy_private(struct lttng_event *event)
+{
+	iput(event->u.uprobe.inode);
+	kfree(event->desc->name);
+	kfree(event->desc);
+}
+EXPORT_SYMBOL_GPL(lttng_uprobes_destroy_private);
+
+MODULE_LICENSE("GPL and additional rights");
+MODULE_AUTHOR("Yannick Brosseau");
+MODULE_DESCRIPTION("Linux Trace Toolkit Uprobes Support");
-- 
1.7.10.4
