From: Francis Deslauriers <fdeslaur@gmail.com>
Subject: [trap-probe] Add lttng-probe-trap
Date: Thu, 21 Mar 2013 22:06:16 -0400
Message-ID: <1363917976-29492-1-git-send-email-fdeslaur__24883.9769316421$1363918041$gmane$org@gmail.com>
References: <CADcCL0j+_N-6b4QvbLRnpC_DvpH3K8U9G2yQsb1ACzqqz3vQSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <fdeslaur@gmail.com>) id 1UIrNM-0001FM-5y
	for lttng-dev@lists.lttng.org; Thu, 21 Mar 2013 22:06:36 -0400
Received: by mail-ve0-f170.google.com with SMTP id 14so3055855vea.1
	for <lttng-dev@lists.lttng.org>; Thu, 21 Mar 2013 19:06:30 -0700 (PDT)
In-Reply-To: <CADcCL0j+_N-6b4QvbLRnpC_DvpH3K8U9G2yQsb1ACzqqz3vQSA@mail.gmail.com>
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

This probe monitors trap entry and trap exit trace event.

Signed-off-by: Francis Deslauriers <fdeslaur@gmail.com>
---
 instrumentation/events/lttng-module/trap.h |   46 +++++++++++++++++++++++++++
 instrumentation/events/mainline/trap.h     |   47 ++++++++++++++++++++++++++++
 probes/Makefile                            |    1 +
 probes/lttng-probe-trap.c                  |   43 +++++++++++++++++++++++++
 4 files changed, 137 insertions(+)
 create mode 100644 instrumentation/events/lttng-module/trap.h
 create mode 100644 instrumentation/events/mainline/trap.h
 create mode 100644 probes/lttng-probe-trap.c

diff --git a/instrumentation/events/lttng-module/trap.h b/instrumentation/events/lttng-module/trap.h
new file mode 100644
index 0000000..124bbba
--- /dev/null
+++ b/instrumentation/events/lttng-module/trap.h
@@ -0,0 +1,46 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM trap
+
+#if !defined(_TRACE_TRAP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_TRAP_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(trap_entry,
+
+	TP_PROTO(struct pt_regs *regs, long trap),
+
+	TP_ARGS(regs, trap),
+
+	TP_STRUCT__entry(
+		__field(	long,		trap	)
+		__field(	unsigned long,	ip	)
+
+	),
+	TP_fast_assign(
+		tp_assign(trap, trap)
+		tp_assign(ip, regs ? instruction_pointer(regs) : 0UL)
+	),
+
+	TP_printk("number=%ld ip=%lu", __entry->trap, __entry->ip)
+)
+
+TRACE_EVENT(trap_exit,
+
+	TP_PROTO(long trap),
+
+	TP_ARGS(trap),
+
+	TP_STRUCT__entry(
+		__field(	long,	trap	)
+	),
+	TP_fast_assign(
+		tp_assign(trap, trap)
+	),
+
+	TP_printk("number=%ld", __entry->trap)
+)
+
+#endif /* _TRACE_TRAP_H */
+/* This part must be outside protection */
+#include "../../../probes/define_trace.h"
diff --git a/instrumentation/events/mainline/trap.h b/instrumentation/events/mainline/trap.h
new file mode 100644
index 0000000..171b9cf
--- /dev/null
+++ b/instrumentation/events/mainline/trap.h
@@ -0,0 +1,47 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM trap
+
+#if !defined(_TRACE_TRAP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_TRAP_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(trap_entry,
+
+	TP_PROTO(struct pt_regs *regs, long trap),
+
+	TP_ARGS(regs, trap),
+
+	TP_STRUCT__entry(
+		__field(	long,		trap	)
+		__field(	unsigned long,	ip	)
+	),
+
+	TP_fast_assign(
+		__entry->trap	= trap;
+		__entry->ip	= regs ? instruction_pointer(regs) : 0UL;
+	),
+
+	TP_printk("number=%ld ip=%lu", __entry->trap, __entry->ip)
+);
+
+TRACE_EVENT(trap_exit,
+
+	TP_PROTO(long trap),
+
+	TP_ARGS(trap),
+
+	TP_STRUCT__entry(
+		__field(	long,	trap	)
+	),
+
+	TP_fast_assign(
+		__entry->trap	= trap;
+	),
+
+	TP_printk("number=%ld", __entry->trap)
+);
+
+#endif /* _TRACE_TRAP_H */
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/probes/Makefile b/probes/Makefile
index 088cd5f..c8d0085 100644
--- a/probes/Makefile
+++ b/probes/Makefile
@@ -15,6 +15,7 @@ obj-m += lttng-probe-timer.o
 obj-m += lttng-probe-kmem.o
 obj-m += lttng-probe-module.o
 obj-m += lttng-probe-power.o
+obj-m += lttng-probe-trap.o
 
 obj-m += lttng-probe-statedump.o
 
diff --git a/probes/lttng-probe-trap.c b/probes/lttng-probe-trap.c
new file mode 100644
index 0000000..17c1526
--- /dev/null
+++ b/probes/lttng-probe-trap.c
@@ -0,0 +1,43 @@
+/*
+ * probes/lttng-probe-trap.c
+ *
+ * LTTng trap probes.
+ *
+ * Copyright (C) 2010-2012 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * Copyright (C) 2013 Francis Deslauriers <fdeslaur@gmail.com>.
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
+
+/*
+ * Create the tracepoint static inlines from the kernel to validate that our
+ * trace event macros match the kernel we run on.
+ */
+#include <trace/events/trap.h>
+#include "../wrapper/tracepoint.h"
+/*
+ * Create LTTng tracepoint probes.
+ */
+#define LTTNG_PACKAGE_BUILD
+#define CREATE_TRACE_POINTS
+#define TRACE_INCLUDE_PATH ../instrumentation/events/lttng-module
+
+#include "../instrumentation/events/lttng-module/trap.h"
+
+MODULE_LICENSE("GPL and additional rights");
+MODULE_AUTHOR("Francis Deslauriers <fdeslaur@gmail.com>");
+MODULE_DESCRIPTION("LTTng trap probes");
-- 
1.7.10.4
