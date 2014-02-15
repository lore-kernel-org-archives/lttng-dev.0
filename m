From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH lttng-modules] LTTng logger ABI
Date: Sat, 15 Feb 2014 17:08:16 -0500
Message-ID: <1392502096-1900-1-git-send-email-mathieu.desnoyers__7515.60663707114$1392502472$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mathieu.desnoyers@efficios.com>) id 1WEnPV-0000rC-DF
	for lttng-dev@lists.lttng.org; Sat, 15 Feb 2014 17:08:38 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Karim Yaghmour <karim.yaghmour@opersys.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Add a user-space ABI (new file /proc/lttng-logger) to lttng-modules
which can be written into by any user on the system. The content is
saved into the kernel trace stream into the "lttng_logger" kernel event.

The content of a single write is written into an lttng_logger event,
provided the packet size is large enough to store the content. If it is
not large enough, it won't be logged. However we cannot return any error
to the caller, since there may be more than one trace session listening
to this event.

Example use:

Enable the "lttng_logger" event.

echo -n "this is a test" > /proc/lttng-logger

Result in babeltrace output:

[17:00:04.251970425] (+179.750663203) thinkos lttng_logger: { cpu_id = 3 }, { _msg_length = 14, msg = "this is a test" }

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Karim Yaghmour <karim.yaghmour@opersys.com>
---
 Makefile                                    |    3 +-
 instrumentation/events/lttng-module/lttng.h |   24 +++++++
 lttng-events.c                              |    7 ++
 lttng-events.h                              |    3 +
 probes/lttng.c                              |   98 +++++++++++++++++++++++++++
 5 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 instrumentation/events/lttng-module/lttng.h
 create mode 100644 probes/lttng.c

diff --git a/Makefile b/Makefile
index a9d1cb1..a4c602f 100644
--- a/Makefile
+++ b/Makefile
@@ -20,7 +20,8 @@ lttng-tracer-objs :=  lttng-events.o lttng-abi.o \
 			lttng-context-vpid.o lttng-context-tid.o \
 			lttng-context-vtid.o lttng-context-ppid.o \
 			lttng-context-vppid.o lttng-calibrate.o \
-			lttng-context-hostname.o wrapper/random.o
+			lttng-context-hostname.o wrapper/random.o \
+			probes/lttng.o
 
 obj-m += lttng-statedump.o
 lttng-statedump-objs := lttng-statedump-impl.o wrapper/irqdesc.o \
diff --git a/instrumentation/events/lttng-module/lttng.h b/instrumentation/events/lttng-module/lttng.h
new file mode 100644
index 0000000..c2ddf8d
--- /dev/null
+++ b/instrumentation/events/lttng-module/lttng.h
@@ -0,0 +1,24 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM lttng
+
+#if !defined(_TRACE_LTTNG_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_LTTNG_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(lttng_logger,
+	TP_PROTO(const char __user *text, size_t len),
+	TP_ARGS(text, len),
+	TP_STRUCT__entry(
+		__dynamic_array_text(char, msg, len)
+	),
+	TP_fast_assign(
+		tp_memcpy_dyn_from_user(msg, text)
+	),
+	TP_printk("")
+)
+
+#endif /* _TRACE_LTTNG_H */
+
+/* This part must be outside protection */
+#include "../../../probes/define_trace.h"
diff --git a/lttng-events.c b/lttng-events.c
index 0512a3f..ff28c9a 100644
--- a/lttng-events.c
+++ b/lttng-events.c
@@ -1261,7 +1261,13 @@ static int __init lttng_events_init(void)
 	ret = lttng_abi_init();
 	if (ret)
 		goto error_abi;
+	ret = lttng_logger_init();
+	if (ret)
+		goto error_logger;
 	return 0;
+
+error_logger:
+	lttng_abi_exit();
 error_abi:
 	kmem_cache_destroy(event_cache);
 	return ret;
@@ -1273,6 +1279,7 @@ static void __exit lttng_events_exit(void)
 {
 	struct lttng_session *session, *tmpsession;
 
+	lttng_logger_exit();
 	lttng_abi_exit();
 	list_for_each_entry_safe(session, tmpsession, &sessions, list)
 		lttng_session_destroy(session);
diff --git a/lttng-events.h b/lttng-events.h
index 6b39304..aeb2a6b 100644
--- a/lttng-events.h
+++ b/lttng-events.h
@@ -429,6 +429,9 @@ int lttng_add_perf_counter_to_ctx(uint32_t type,
 }
 #endif
 
+int lttng_logger_init(void);
+void lttng_logger_exit(void);
+
 extern int lttng_statedump_start(struct lttng_session *session);
 
 #ifdef CONFIG_KPROBES
diff --git a/probes/lttng.c b/probes/lttng.c
new file mode 100644
index 0000000..2761f19
--- /dev/null
+++ b/probes/lttng.c
@@ -0,0 +1,98 @@
+/*
+ * lttng.c
+ *
+ * LTTng logger ABI
+ *
+ * Copyright (C) 2008-2014 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
+#include <linux/tracepoint.h>
+#include <linux/uaccess.h>
+#include <linux/gfp.h>
+#include <linux/fs.h>
+#include <linux/proc_fs.h>
+#include <linux/slab.h>
+#include "../wrapper/vmalloc.h"
+#include "../lttng-events.h"
+
+#define TP_MODULE_NOAUTOLOAD
+#define LTTNG_PACKAGE_BUILD
+#define CREATE_TRACE_POINTS
+#define TRACE_INCLUDE_PATH ../instrumentation/events/lttng-module
+#define TRACE_INCLUDE_FILE lttng
+
+#include "../instrumentation/events/lttng-module/lttng.h"
+
+#define LTTNG_LOGGER_FILE	"lttng-logger"
+
+static struct proc_dir_entry *lttng_logger_dentry;
+
+/**
+ * lttng_logger_write - write a userspace string into the trace system
+ * @file: file pointer
+ * @user_buf: user string
+ * @count: length to copy
+ * @ppos: unused
+ *
+ * Copy a userspace string into a trace event named "lttng:logger".
+ * Copies @count bytes into the event "msg" dynamic array.
+ * Returns the number of bytes copied from the source. It cannot return
+ * more than @count.
+ */
+static
+ssize_t lttng_logger_write(struct file *file, const char __user *user_buf,
+		    size_t count, loff_t *ppos)
+{
+	trace_lttng_logger(user_buf, count);
+	return count;
+}
+
+static const struct file_operations lttng_logger_operations = {
+	.write = lttng_logger_write,
+};
+
+int __init lttng_logger_init(void)
+{
+	int ret = 0;
+
+	wrapper_vmalloc_sync_all();
+	lttng_logger_dentry = proc_create_data(LTTNG_LOGGER_FILE,
+				S_IRUGO | S_IWUGO, NULL,
+				&lttng_logger_operations, NULL);
+	if (!lttng_logger_dentry) {
+		printk(KERN_ERR "Error creating LTTng logger file\n");
+		ret = -ENOMEM;
+		goto error;
+	}
+	ret = __lttng_events_init__lttng();
+	if (ret)
+		goto error_events;
+	return ret;
+
+error_events:
+	remove_proc_entry("lttng-logger", NULL);
+error:
+	return ret;
+}
+
+void __exit lttng_logger_exit(void)
+{
+	__lttng_events_exit__lttng();
+	if (lttng_logger_dentry)
+		remove_proc_entry("lttng-logger", NULL);
+}
-- 
1.7.10.4
