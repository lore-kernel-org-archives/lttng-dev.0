From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 1/2] Fix: RHEL 7.2 kvm
	instrumentation
Date: Thu, 14 Jan 2016 14:35:46 -0500
Message-ID: <1452800147-4002-1-git-send-email-mjeanson__21375.1628449701$1452800232$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1aJngt-0001jY-7T
 for lttng-dev@lists.lttng.org; Thu, 14 Jan 2016 14:36:15 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 45C2F340452
 for <lttng-dev@lists.lttng.org>; Thu, 14 Jan 2016 19:36:12 +0000 (UTC)
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
 instrumentation/events/lttng-module/kvm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/instrumentation/events/lttng-module/kvm.h b/instrumentation/events/lttng-module/kvm.h
index 87d605c..cb73011 100644
--- a/instrumentation/events/lttng-module/kvm.h
+++ b/instrumentation/events/lttng-module/kvm.h
@@ -111,7 +111,8 @@ LTTNG_TRACEPOINT_EVENT(kvm_fpu,
 	)
 )
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0) \
+	|| LTTNG_RHEL_KERNEL_RANGE(3,10,0,7,2, 3,11,0,0,0))
 
 LTTNG_TRACEPOINT_EVENT(kvm_age_page,
 	TP_PROTO(ulong gfn, int level, struct kvm_memory_slot *slot, int ref),
-- 
2.7.0.rc3
