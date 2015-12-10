From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules v2] Fix: Use generic
	raw_irqs_disabled_flags
Date: Thu, 10 Dec 2015 11:26:29 -0500
Message-ID: <1449764789-8219-1-git-send-email-mjeanson__19891.0120678649$1449764896$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1a743b-00034h-Eh
 for lttng-dev@lists.lttng.org; Thu, 10 Dec 2015 11:27:09 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A0A5B340474
 for <lttng-dev@lists.lttng.org>; Thu, 10 Dec 2015 16:26:59 +0000 (UTC)
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

instead of arch_irqs_disabled_flags, this fixes the build for kernel < 2.6.37

See linux commit df9ee29270c11dba7d0fe0b83ce47a4d8e8d2101 for more details.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 wrapper/irqflags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wrapper/irqflags.h b/wrapper/irqflags.h
index 77f8382..d7a7a38 100644
--- a/wrapper/irqflags.h
+++ b/wrapper/irqflags.h
@@ -33,7 +33,7 @@ int lttng_regs_irqs_disabled(struct pt_regs *regs)
 {
 	unsigned long flags = regs->flags;
 
-	return arch_irqs_disabled_flags(flags);
+	return raw_irqs_disabled_flags(flags);
 }
 
 #else
-- 
1.9.1
