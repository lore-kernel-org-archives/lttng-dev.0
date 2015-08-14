From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Fix: mm_page_alloc_extfrag
	instrumentation for kernel 3.18.10
Date: Fri, 14 Aug 2015 11:37:31 -0400
Message-ID: <1439566651-24873-1-git-send-email-mjeanson__41591.082691639$1439566762$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZQH3H-00049E-Pr
 for lttng-dev@lists.lttng.org; Fri, 14 Aug 2015 11:38:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 566BB3403BC
 for <lttng-dev@lists.lttng.org>; Fri, 14 Aug 2015 15:37:46 +0000 (UTC)
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

The following commit has been backported from kernel 3.19.2 into
3.18.10, introducing a change to mm_page_alloc_extfrag and therefore
provoking a build failure on a 3.18.10 kernel:

commit a4f3f96f850db69890f47984c60606a2362bee89
Author: Vlastimil Babka <vbabka@suse.cz>
Date:   Wed Feb 11 15:28:15 2015 -0800

    mm: when stealing freepages, also take pages created by splitting buddy page

    commit 99592d598eca62bdbbf62b59941c189176dfc614 upstream.

This patch adds the proper version check to allow building on 3.18.y.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 instrumentation/events/lttng-module/kmem.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/instrumentation/events/lttng-module/kmem.h b/instrumentation/events/lttng-module/kmem.h
index 85c116b..85d13b9 100644
--- a/instrumentation/events/lttng-module/kmem.h
+++ b/instrumentation/events/lttng-module/kmem.h
@@ -202,6 +202,7 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(kmem_mm_page, mm_page_pcpu_drain,
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,2)	\
 	|| LTTNG_KERNEL_RANGE(3,14,36, 3,15,0)		\
+	|| LTTNG_KERNEL_RANGE(3,18,10, 3,19,0)		\
 	|| LTTNG_DEBIAN_KERNEL_RANGE(3,16,7,9,0,0, 3,17,0,0,0,0)	\
 	|| LTTNG_UBUNTU_KERNEL_RANGE(3,13,11,50, 3,14,0,0)	\
 	|| LTTNG_UBUNTU_KERNEL_RANGE(3,16,7,38, 3,17,0,0))
-- 
1.9.1
