From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [MODULES PATCH 2/4] Fix block_rq_complete TP on Ubuntu
	kernel
Date: Wed,  1 Oct 2014 11:05:09 -0400
Message-ID: <1412175911-27001-2-git-send-email-jdesfossez__26240.1729160503$1412176029$gmane$org@efficios.com>
References: <1412175911-27001-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1XZLT2-0004eC-W8
 for lttng-dev@lists.lttng.org; Wed, 01 Oct 2014 11:05:27 -0400
In-Reply-To: <1412175911-27001-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Fixes: #814

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 instrumentation/events/lttng-module/block.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/instrumentation/events/lttng-module/block.h b/instrumentation/events/lttng-module/block.h
index fb592ad..0aff546 100644
--- a/instrumentation/events/lttng-module/block.h
+++ b/instrumentation/events/lttng-module/block.h
@@ -225,7 +225,8 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(block_rq_with_error, block_rq_requeue,
 	|| LTTNG_KERNEL_RANGE(3,12,21, 3,13,0)		\
 	|| LTTNG_KERNEL_RANGE(3,10,41, 3,11,0)		\
 	|| LTTNG_KERNEL_RANGE(3,4,91, 3,5,0)		\
-	|| LTTNG_KERNEL_RANGE(3,2,58, 3,3,0))
+	|| LTTNG_KERNEL_RANGE(3,2,58, 3,3,0)		\
+	|| LTTNG_UBUNTU_KERNEL_RANGE(3,13,11,31, 3,14,0,0))
 
 /**
  * block_rq_complete - block IO operation completed by device driver
-- 
1.9.1
