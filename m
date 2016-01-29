From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 2/2] Fix: Ubuntu kernel range for
	block_rq_complete
Date: Fri, 29 Jan 2016 17:46:03 -0500
Message-ID: <1454107563-22129-2-git-send-email-mjeanson__23849.2491691888$1454107665$gmane$org@efficios.com>
References: <1454107563-22129-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1aPHoH-0005w1-WA
 for lttng-dev@lists.lttng.org; Fri, 29 Jan 2016 17:46:34 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B2835340553
 for <lttng-dev@lists.lttng.org>; Fri, 29 Jan 2016 22:46:28 +0000 (UTC)
In-Reply-To: <1454107563-22129-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 instrumentation/events/lttng-module/block.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/instrumentation/events/lttng-module/block.h b/instrumentation/events/lttng-module/block.h
index 1a2ba6b..6b0c788 100644
--- a/instrumentation/events/lttng-module/block.h
+++ b/instrumentation/events/lttng-module/block.h
@@ -202,7 +202,7 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(block_rq_with_error, block_rq_requeue,
 	|| LTTNG_KERNEL_RANGE(3,10,41, 3,11,0)		\
 	|| LTTNG_KERNEL_RANGE(3,4,91, 3,5,0)		\
 	|| LTTNG_KERNEL_RANGE(3,2,58, 3,3,0)		\
-	|| LTTNG_UBUNTU_KERNEL_RANGE(3,13,11,31, 3,14,0,0)	\
+	|| LTTNG_UBUNTU_KERNEL_RANGE(3,13,11,28, 3,14,0,0)	\
 	|| LTTNG_RHEL_KERNEL_RANGE(3,10,0,7,1, 3,11,0,0,0))
 
 /**
-- 
2.7.0
