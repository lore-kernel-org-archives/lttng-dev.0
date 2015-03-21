From: Antoine Busque <abusque@efficios.com>
Subject: [PATCH lttng-modules] Fix: mm_page_alloc_extfrag
	instrumentation for kernel 3.14.36
Date: Sat, 21 Mar 2015 15:13:18 -0400
Message-ID: <1426965198-15490-1-git-send-email-abusque__48736.7538772107$1426965341$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <abusque@efficios.com>) id 1YZOpx-0003OT-3o
 for lttng-dev@lists.lttng.org; Sat, 21 Mar 2015 15:13:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id BC7C7340159
 for <lttng-dev@lists.lttng.org>; Sat, 21 Mar 2015 19:13:37 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 1ki03DzG18Rd for <lttng-dev@lists.lttng.org>;
 Sat, 21 Mar 2015 19:13:37 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2405C34016F
 for <lttng-dev@lists.lttng.org>; Sat, 21 Mar 2015 19:13:37 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id UL8FUpu97U82 for <lttng-dev@lists.lttng.org>;
 Sat, 21 Mar 2015 19:13:37 +0000 (UTC)
Received: from archbox.localdomain (cable-192.222.165.109.electronicbox.net
 [192.222.165.109])
 by mail.efficios.com (Postfix) with ESMTPSA id AC784340159
 for <lttng-dev@lists.lttng.org>; Sat, 21 Mar 2015 19:13:36 +0000 (UTC)
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
3.14.36, introducing a change to mm_page_alloc_extfrag and therefore
provoking a build failure on a 3.14.36 kernel:

commit a4f3f96f850db69890f47984c60606a2362bee89
Author: Vlastimil Babka <vbabka@suse.cz>
Date:   Wed Feb 11 15:28:15 2015 -0800

    mm: when stealing freepages, also take pages created by splitting buddy page

    commit 99592d598eca62bdbbf62b59941c189176dfc614 upstream.

This patch adds the proper version check to allow building on 3.14.y.

Signed-off-by: Antoine Busque <abusque@efficios.com>
---
 instrumentation/events/lttng-module/kmem.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/instrumentation/events/lttng-module/kmem.h b/instrumentation/events/lttng-module/kmem.h
index 3782ac6..710c9fa 100644
--- a/instrumentation/events/lttng-module/kmem.h
+++ b/instrumentation/events/lttng-module/kmem.h
@@ -286,7 +286,8 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE_PRINT(mm_page, mm_page_pcpu_drain,
 		__entry->order, __entry->migratetype)
 )
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,2))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,2)	\
+	|| LTTNG_KERNEL_RANGE(3,14,36, 3,15,0))
 
 LTTNG_TRACEPOINT_EVENT(mm_page_alloc_extfrag,
 
-- 
2.3.3
