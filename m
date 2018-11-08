From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 27/30] Drop support for
 kernels < 3.0 from skb instrumentation
Date: Thu,  8 Nov 2018 16:45:32 -0500
Message-ID: <20181108214535.12081-27-mjeanson__19772.5993385122$1541713801$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKp4bLPzqJF
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:06 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 9C5A224AF29
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:06 -0500 (EST)
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
 instrumentation/events/lttng-module/skb.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/instrumentation/events/lttng-module/skb.h b/instrumentation/events/lttng-module/skb.h
index 6d3fd45..1726b44 100644
--- a/instrumentation/events/lttng-module/skb.h
+++ b/instrumentation/events/lttng-module/skb.h
@@ -28,7 +28,6 @@ LTTNG_TRACEPOINT_EVENT_MAP(kfree_skb,
 	)
 )
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
 LTTNG_TRACEPOINT_EVENT_MAP(consume_skb,
 
 	skb_consume,
@@ -41,9 +40,7 @@ LTTNG_TRACEPOINT_EVENT_MAP(consume_skb,
 		ctf_integer_hex(void *, skbaddr, skb)
 	)
 )
-#endif
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
 LTTNG_TRACEPOINT_EVENT(skb_copy_datagram_iovec,
 
 	TP_PROTO(const struct sk_buff *skb, int len),
@@ -55,7 +52,6 @@ LTTNG_TRACEPOINT_EVENT(skb_copy_datagram_iovec,
 		ctf_integer(int, len, len)
 	)
 )
-#endif
 
 #endif /* LTTNG_TRACE_SKB_H */
 
-- 
2.17.1
