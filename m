From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 23/30] Drop support for
 kernels < 3.0 from net instrumentation
Date: Thu,  8 Nov 2018 16:45:28 -0500
Message-ID: <20181108214535.12081-23-mjeanson__44440.0811488324$1541713754$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKm2BrCzqGh
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:04 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 4858124AEDC
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:46:04 -0500 (EST)
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
 instrumentation/events/lttng-module/net.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/instrumentation/events/lttng-module/net.h b/instrumentation/events/lttng-module/net.h
index 8789263..bfa14fc 100644
--- a/instrumentation/events/lttng-module/net.h
+++ b/instrumentation/events/lttng-module/net.h
@@ -439,30 +439,18 @@ LTTNG_TRACEPOINT_ENUM(net_network_header,
 
 LTTNG_TRACEPOINT_EVENT(net_dev_xmit,
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,40))
 	TP_PROTO(struct sk_buff *skb,
 		 int rc,
 		 struct net_device *dev,
 		 unsigned int skb_len),
 
 	TP_ARGS(skb, rc, dev, skb_len),
-#else
-	TP_PROTO(struct sk_buff *skb,
-		 int rc),
-
-	TP_ARGS(skb, rc),
-#endif
 
 	TP_FIELDS(
 		ctf_integer_hex(void *, skbaddr, skb)
 		ctf_integer(int, rc, rc)
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,40))
 		ctf_integer(unsigned int, len, skb_len)
 		ctf_string(name, dev->name)
-#else
-		ctf_integer(unsigned int, len, skb->len)
-		ctf_string(name, skb->dev->name)
-#endif
 	)
 )
 
-- 
2.17.1
