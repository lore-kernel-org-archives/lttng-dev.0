From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Fix: Use generic
	irqs_disabled_flags
Date: Wed,  9 Dec 2015 17:25:19 -0500
Message-ID: <1449699919-26929-1-git-send-email-mjeanson__23011.2898898826$1449699992$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1a6nAy-00063H-LV
 for lttng-dev@lists.lttng.org; Wed, 09 Dec 2015 17:25:33 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8913934050C
 for <lttng-dev@lists.lttng.org>; Wed,  9 Dec 2015 22:25:28 +0000 (UTC)
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
index 77f8382..74c340b 100644
--- a/wrapper/irqflags.h
+++ b/wrapper/irqflags.h
@@ -33,7 +33,7 @@ int lttng_regs_irqs_disabled(struct pt_regs *regs)
 {
 	unsigned long flags = regs->flags;
 
-	return arch_irqs_disabled_flags(flags);
+	return irqs_disabled_flags(flags);
 }
 
 #else
-- 
1.9.1
