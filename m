From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 21/30] Drop support for
 kernels < 3.0 from mm_vmscan instrumentation
Date: Thu,  8 Nov 2018 16:45:26 -0500
Message-ID: <20181108214535.12081-21-mjeanson__13820.2143171386$1541713726$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKl260gzqGb
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:03 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id EC42B24AEB9
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:02 -0500 (EST)
In-Reply-To: <20181108214535.12081-1-mjeanson@efficios.com>
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

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 instrumentation/events/lttng-module/mm_vmscan.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/instrumentation/events/lttng-module/mm_vmscan.h b/instrumentation/events/lttng-module/mm_vmscan.h
index b9cd8b0..cc7a275 100644
--- a/instrumentation/events/lttng-module/mm_vmscan.h
+++ b/instrumentation/events/lttng-module/mm_vmscan.h
@@ -640,7 +640,7 @@ LTTNG_TRACEPOINT_EVENT(mm_vmscan_lru_shrink_inactive,
 		ctf_integer(int, reclaim_flags, trace_shrink_flags(file))
 	)
 )
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
+#else
 LTTNG_TRACEPOINT_EVENT(mm_vmscan_lru_shrink_inactive,
 
 	TP_PROTO(int nid, int zid,
-- 
2.17.1
