From: Francis Deslauriers <fdeslaur@gmail.com>
Subject: [RFC-PATCH] Adding trap tracepoints definitions
Date: Thu, 14 Mar 2013 20:26:32 -0400
Message-ID: <1363307192-14522-1-git-send-email-fdeslaur__46865.145097445$1363317130$gmane$org@gmail.com>
References: <CADcCL0j+_N-6b4QvbLRnpC_DvpH3K8U9G2yQsb1ACzqqz3vQSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <fdeslaur@gmail.com>) id 1UGITx-000315-V7
	for lttng-dev@lists.lttng.org; Thu, 14 Mar 2013 20:26:50 -0400
Received: by mail-ie0-f171.google.com with SMTP id 10so3788950ied.2
	for <lttng-dev@lists.lttng.org>; Thu, 14 Mar 2013 17:26:44 -0700 (PDT)
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
Cc: Francis Deslauriers <fdeslaur@gmail.com>
List-Id: lttng-dev@lists.lttng.org

This patch adds new trap tracepoint definitions. Both trap entry and trap exit
tracepoints can be added.

Signed-off-by: Francis Deslauriers <fdeslaur@gmail.com>
---
 include/trace/events/trap.h |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 include/trace/events/trap.h

diff --git a/include/trace/events/trap.h b/include/trace/events/trap.h
new file mode 100644
index 0000000..869c512
--- /dev/null
+++ b/include/trace/events/trap.h
@@ -0,0 +1,39 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM trap
+
+#if !defined(_TRACE_TRAP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_TRAP_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(trap,
+	TP_PROTO(int trap_nb),
+
+	TP_ARGS(trap_nb),
+
+	TP_STRUCT__entry(
+		__field(    int,    trap_nb )
+	),
+	TP_fast_assign(
+		__entry->trap_nb = trap_nb;
+),
+
+	TP_printk("number=%d", __entry->trap_nb)
+);
+
+DEFINE_EVENT(trap, trap_entry,
+
+	TP_PROTO(int trap_nb),
+
+	TP_ARGS(trap_nb)
+);
+DEFINE_EVENT(trap, trap_exit,
+
+	TP_PROTO(int trap_nb),
+
+	TP_ARGS(trap_nb)
+);
+
+#endif /* _TRACE_TRAP_H */
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
1.7.10.4
