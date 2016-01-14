From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 2/2] Fix: RHEL 7.2 scsi
	instrumentation
Date: Thu, 14 Jan 2016 14:35:47 -0500
Message-ID: <1452800147-4002-2-git-send-email-mjeanson__48396.8784370974$1452800251$gmane$org@efficios.com>
References: <1452800147-4002-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1aJngv-0001jZ-Aa
 for lttng-dev@lists.lttng.org; Thu, 14 Jan 2016 14:36:18 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5EBEC340454
 for <lttng-dev@lists.lttng.org>; Thu, 14 Jan 2016 19:36:14 +0000 (UTC)
In-Reply-To: <1452800147-4002-1-git-send-email-mjeanson@efficios.com>
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
 instrumentation/events/lttng-module/scsi.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/instrumentation/events/lttng-module/scsi.h b/instrumentation/events/lttng-module/scsi.h
index c23c4f2..c0088c6 100644
--- a/instrumentation/events/lttng-module/scsi.h
+++ b/instrumentation/events/lttng-module/scsi.h
@@ -15,7 +15,8 @@
 
 #define scsi_opcode_name(opcode)	{ opcode, #opcode }
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0) \
+	|| LTTNG_RHEL_KERNEL_RANGE(3,10,0,7,2, 3,11,0,0,0))
 
 #define show_opcode_name(val)					\
 	__print_symbolic(val,					\
-- 
2.7.0.rc3
