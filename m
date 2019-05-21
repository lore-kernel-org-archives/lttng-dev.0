From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 2/5] fix: mm/vmscan: drop
 may_writepage and classzone_idx from direct reclaim begin template (v5.2)
Date: Tue, 21 May 2019 16:33:11 -0400
Message-ID: <20190521203314.8577-2-mjeanson__15856.6443527647$1558470859$gmane$org@efficios.com>
References: <20190521203314.8577-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 457nXX4rvHz10WN
 for <lttng-dev@lists.lttng.org>; Tue, 21 May 2019 16:33:32 -0400 (EDT)
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

  commit 3481c37ffa1de58ef140d0fe9eabf56305e74666
  Author: Yafang Shao <laoar.shao@gmail.com>
  Date:   Mon May 13 17:19:14 2019 -0700

    mm/vmscan: drop may_writepage and classzone_idx from direct reclaim begin template

    There are three tracepoints using this template, which are
    mm_vmscan_direct_reclaim_begin,
    mm_vmscan_memcg_reclaim_begin,
    mm_vmscan_memcg_softlimit_reclaim_begin.

    Regarding mm_vmscan_direct_reclaim_begin,
    sc.may_writepage is !laptop_mode, that's a static setting, and
    reclaim_idx is derived from gfp_mask which is already show in this
    tracepoint.

    Regarding mm_vmscan_memcg_reclaim_begin,
    may_writepage is !laptop_mode too, and reclaim_idx is (MAX_NR_ZONES-1),
    which are both static value.

    mm_vmscan_memcg_softlimit_reclaim_begin is the same with
    mm_vmscan_memcg_reclaim_begin.

    So we can drop them all.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 .../events/lttng-module/mm_vmscan.h           | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/instrumentation/events/lttng-module/mm_vmscan.h b/instrumentation/events/lttng-module/mm_vmscan.h
index cc7a275..db4a906 100644
--- a/instrumentation/events/lttng-module/mm_vmscan.h
+++ b/instrumentation/events/lttng-module/mm_vmscan.h
@@ -114,7 +114,42 @@ LTTNG_TRACEPOINT_EVENT(mm_vmscan_wakeup_kswapd,
 )
 #endif
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,8,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,2,0))
+
+LTTNG_TRACEPOINT_EVENT_CLASS(mm_vmscan_direct_reclaim_begin_template,
+
+	TP_PROTO(int order, gfp_t gfp_flags),
+
+	TP_ARGS(order, gfp_flags),
+
+	TP_FIELDS(
+		ctf_integer(int, order, order)
+		ctf_integer(gfp_t, gfp_flags, gfp_flags)
+	)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_direct_reclaim_begin,
+
+	TP_PROTO(int order, gfp_t gfp_flags),
+
+	TP_ARGS(order, gfp_flags)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_memcg_reclaim_begin,
+
+	TP_PROTO(int order, gfp_t gfp_flags),
+
+	TP_ARGS(order, gfp_flags)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_memcg_softlimit_reclaim_begin,
+
+	TP_PROTO(int order, gfp_t gfp_flags),
+
+	TP_ARGS(order, gfp_flags)
+)
+
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4,8,0))
 
 LTTNG_TRACEPOINT_EVENT_CLASS(mm_vmscan_direct_reclaim_begin_template,
 
-- 
2.17.1
