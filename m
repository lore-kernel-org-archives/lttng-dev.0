From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 13/30] Drop support for
 kernels < 3.0 from lttng-statedump-impl.c
Date: Thu,  8 Nov 2018 16:45:18 -0500
Message-ID: <20181108214535.12081-13-mjeanson__31548.2777813033$1541713620$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKf0ZhJzqDj
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:58 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 12E6424ADE8
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:58 -0500 (EST)
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
 lttng-statedump-impl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lttng-statedump-impl.c b/lttng-statedump-impl.c
index 8ce50c0..dc03750 100644
--- a/lttng-statedump-impl.c
+++ b/lttng-statedump-impl.c
@@ -353,10 +353,6 @@ int lttng_enumerate_vm_maps(struct lttng_session *session)
 
 #ifdef CONFIG_LTTNG_HAS_LIST_IRQ
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39))
-#define irq_desc_get_chip(desc) get_irq_desc_chip(desc)
-#endif
-
 static
 int lttng_list_interrupts(struct lttng_session *session)
 {
-- 
2.17.1
