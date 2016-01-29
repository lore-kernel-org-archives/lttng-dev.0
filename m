From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 1/2] Fix: Ubuntu kernel range for
	mm_page_alloc_extfrag
Date: Fri, 29 Jan 2016 17:46:02 -0500
Message-ID: <1454107563-22129-1-git-send-email-mjeanson__22877.7637159967$1454107654$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1aPHoD-0005w0-Mn
 for lttng-dev@lists.lttng.org; Fri, 29 Jan 2016 17:46:32 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 24DBC3404A1
 for <lttng-dev@lists.lttng.org>; Fri, 29 Jan 2016 22:46:24 +0000 (UTC)
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
 instrumentation/events/lttng-module/kmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/instrumentation/events/lttng-module/kmem.h b/instrumentation/events/lttng-module/kmem.h
index 25e58cb..cce8da4 100644
--- a/instrumentation/events/lttng-module/kmem.h
+++ b/instrumentation/events/lttng-module/kmem.h
@@ -211,7 +211,7 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(kmem_mm_page, mm_page_pcpu_drain,
 	|| LTTNG_KERNEL_RANGE(3,18,10, 3,19,0)		\
 	|| LTTNG_DEBIAN_KERNEL_RANGE(3,16,7,9,0,0, 3,17,0,0,0,0)	\
 	|| LTTNG_UBUNTU_KERNEL_RANGE(3,13,11,50, 3,14,0,0)	\
-	|| LTTNG_UBUNTU_KERNEL_RANGE(3,16,7,38, 3,17,0,0))
+	|| LTTNG_UBUNTU_KERNEL_RANGE(3,16,7,34, 3,17,0,0))
 
 LTTNG_TRACEPOINT_EVENT_MAP(mm_page_alloc_extfrag,
 
-- 
2.7.0
