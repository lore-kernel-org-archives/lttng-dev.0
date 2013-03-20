From: Francis Deslauriers <fdeslaur@gmail.com>
Subject: [RFC-PATCH] Adding trap tracepoints definitions
Date: Wed, 20 Mar 2013 16:37:21 -0400
Message-ID: <1363811841-23843-1-git-send-email-fdeslaur__22327.0990107723$1363811903$gmane$org@gmail.com>
References: <CADcCL0j+_N-6b4QvbLRnpC_DvpH3K8U9G2yQsb1ACzqqz3vQSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <fdeslaur@gmail.com>) id 1UIPlO-0003rN-Ny
	for lttng-dev@lists.lttng.org; Wed, 20 Mar 2013 16:37:34 -0400
Received: by mail-ia0-f172.google.com with SMTP id l29so1813133iag.3
	for <lttng-dev@lists.lttng.org>; Wed, 20 Mar 2013 13:37:29 -0700 (PDT)
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

This patch adds new trap tracepoint definitions. Both trap entry and trap exit
tracepoints can be added.

Signed-off-by: Francis Deslauriers <fdeslaur@gmail.com>
---
 include/trace/events/trap.h |   45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 include/trace/events/trap.h

diff --git a/include/trace/events/trap.h b/include/trace/events/trap.h
new file mode 100644
index 0000000..e1847a3
--- /dev/null
+++ b/include/trace/events/trap.h
@@ -0,0 +1,45 @@
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
+		__field(	long,	trap)
+		__field(	unsigned long,	ip)
+	),
+	TP_fast_assign(
+		__entry->trap = trap;
+		__entry->ip = regs ? instruction_pointer(regs) : 0UL;
+	),
+
+	TP_printk("number=%ld, ip = %lu", __entry->trap, __entry->ip)
+);
+
+TRACE_EVENT(trap_exit,
+
+	TP_PROTO(long trap),
+
+	TP_ARGS(trap),
+
+	TP_STRUCT__entry(
+		__field(	long,	trap)
+	),
+	TP_fast_assign(
+		__entry->trap = trap;
+	),
+
+	TP_printk("number=%ld", __entry->trap)
+);
+
+#endif /* _TRACE_TRAP_H */
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
1.7.10.4
