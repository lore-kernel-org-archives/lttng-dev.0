From: Antoine Busque <antoine.busque@efficios.com>
Subject: [PATCH lttng-modules] Fix: blktrace instrumentation for
	backported branches
Date: Sat,  7 Jun 2014 12:27:21 -0400
Message-ID: <1402158441-1129-1-git-send-email-antoine.busque__12226.5291087844$1402158510$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <antoine.busque@efficios.com>) id 1WtJT8-00025y-Jc
 for lttng-dev@lists.lttng.org; Sat, 07 Jun 2014 12:27:49 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Antoine Busque <antoine.busque@efficios.com>
List-Id: lttng-dev@lists.lttng.org

The following commit from kernel 3.15 changing the API of a block layer
tracepoint has been backported to multiple branches:

commit af5040da01ef980670b3741b3e10733ee3e33566
Author: Roman Pen <r.peniaev@gmail.com>
Date:   Tue Mar 4 23:13:10 2014 +0900

    blktrace: fix accounting of partially completed requests

This patch fixes the resulting build failure by adding the proper
version checks. The versions and corresponding commit SHA-1 hashes are
as follow:

   3.2.58
       commit 5b85afa68e4f56c27f1d5c6f49e5257bce6448e6

   3.4.91
       commit 14eee5bd065d6aac0acbdc6092a25ba68c55b9c8

   3.10.41
       commit e9d933941569c107e0083c3c115467c699a57db2

   3.12.21
       commit 5104b40a981d26212ced149fbd43ad0b6b72910b

   3.14.15
       commit 0a8eda9c00ef37e8b40de77f2b0714317191bcf2

Signed-off-by: Antoine Busque <antoine.busque@efficios.com>
---
 instrumentation/events/lttng-module/block.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/instrumentation/events/lttng-module/block.h b/instrumentation/events/lttng-module/block.h
index 4f3460e..5684153 100644
--- a/instrumentation/events/lttng-module/block.h
+++ b/instrumentation/events/lttng-module/block.h
@@ -221,8 +221,11 @@ DEFINE_EVENT(block_rq_with_error, block_rq_requeue,
 	TP_ARGS(q, rq)
 )
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)	\
-	|| LTTNG_KERNEL_RANGE(3,2,58, 3,3,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,5)	\
+	|| LTTNG_KERNEL_RANGE(3,2,58, 3,3,0)		\
+	|| LTTNG_KERNEL_RANGE(3,4,91, 3,5,1)		\
+	|| LTTNG_KERNEL_RANGE(3,10,41, 3,11,0)		\
+	|| LTTNG_KERNEL_RANGE(3,12,21, 3,13,0))
 
 /**
  * block_rq_complete - block IO operation completed by device driver
-- 
2.0.0
