From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 3/5] fix: mm/vmscan: simplify
 trace_reclaim_flags and trace_shrink_flags (v5.2)
Date: Tue, 21 May 2019 16:33:12 -0400
Message-ID: <20190521203314.8577-3-mjeanson__22061.9615561858$1558470896$gmane$org@efficios.com>
References: <20190521203314.8577-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 457nXY6dpsz10Wd
 for <lttng-dev@lists.lttng.org>; Tue, 21 May 2019 16:33:33 -0400 (EDT)
In-Reply-To: <20190521203314.8577-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

See upstream commit:

  commit 60b62ff7cc4217ac3de76535fa4c1510a798dbcb
  Author: Yafang Shao <laoar.shao@gmail.com>
  Date:   Mon May 13 17:23:08 2019 -0700

    mm/vmscan: simplify trace_reclaim_flags and trace_shrink_flags

    trace_reclaim_flags and trace_shrink_flags are almost the same.
    We can simplify them to avoid redundant code.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 .../events/lttng-module/mm_vmscan.h           | 52 +++++++++++++++++--
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/instrumentation/events/lttng-module/mm_vmscan.h b/instrumentation/events/lttng-module/mm_vmscan.h
index db4a906..417472c 100644
--- a/instrumentation/events/lttng-module/mm_vmscan.h
+++ b/instrumentation/events/lttng-module/mm_vmscan.h
@@ -26,7 +26,16 @@ typedef int isolate_mode_t;
 
 #endif
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,5,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0))
+
+#include <linux/mm_inline.h>
+
+#define trace_reclaim_flags(file) ( \
+	(file ? RECLAIM_WB_FILE : RECLAIM_WB_ANON) | \
+	(RECLAIM_WB_ASYNC) \
+	)
+
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4,5,0))
 
 #include <linux/mm_inline.h>
 
@@ -559,7 +568,20 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(mm_vmscan_lru_isolate_template, mm_vmscan_memcg_
 )
 #endif
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,5,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0))
+LTTNG_TRACEPOINT_EVENT(mm_vmscan_writepage,
+
+	TP_PROTO(struct page *page),
+
+	TP_ARGS(page),
+
+	TP_FIELDS(
+		ctf_integer_hex(struct page *, page, page)
+		ctf_integer(int, reclaim_flags, trace_reclaim_flags(
+				page_is_file_cache(page)))
+	)
+)
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4,5,0))
 LTTNG_TRACEPOINT_EVENT(mm_vmscan_writepage,
 
 	TP_PROTO(struct page *page),
@@ -586,7 +608,31 @@ LTTNG_TRACEPOINT_EVENT(mm_vmscan_writepage,
 )
 #endif
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,17,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0))
+LTTNG_TRACEPOINT_EVENT(mm_vmscan_lru_shrink_inactive,
+
+	TP_PROTO(int nid,
+		unsigned long nr_scanned, unsigned long nr_reclaimed,
+		struct reclaim_stat *stat, int priority, int file),
+
+	TP_ARGS(nid, nr_scanned, nr_reclaimed, stat, priority, file),
+
+	TP_FIELDS(
+		ctf_integer(int, nid, nid)
+		ctf_integer(unsigned long, nr_scanned, nr_scanned)
+		ctf_integer(unsigned long, nr_reclaimed, nr_reclaimed)
+		ctf_integer(unsigned long, nr_dirty, stat->nr_dirty)
+		ctf_integer(unsigned long, nr_writeback, stat->nr_writeback)
+		ctf_integer(unsigned long, nr_congested, stat->nr_congested)
+		ctf_integer(unsigned long, nr_immediate, stat->nr_immediate)
+		ctf_integer(unsigned long, nr_activate, stat->nr_activate)
+		ctf_integer(unsigned long, nr_ref_keep, stat->nr_ref_keep)
+		ctf_integer(unsigned long, nr_unmap_fail, stat->nr_unmap_fail)
+		ctf_integer(int, priority, priority)
+		ctf_integer(int, reclaim_flags, trace_reclaim_flags(file))
+	)
+)
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4,17,0))
 LTTNG_TRACEPOINT_EVENT(mm_vmscan_lru_shrink_inactive,
 
 	TP_PROTO(int nid,
-- 
2.17.1
