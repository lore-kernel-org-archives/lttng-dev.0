From: Antoine Busque <antoine.busque@efficios.com>
Subject: [PATCH lttng-modules] Fix: correct typo in kernel
	version number
Date: Wed, 11 Jun 2014 10:45:44 -0400
Message-ID: <1402497944-2186-1-git-send-email-antoine.busque__11202.3235102699$1402498024$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <antoine.busque@efficios.com>) id 1WujlM-0000b9-2H
 for lttng-dev@lists.lttng.org; Wed, 11 Jun 2014 10:44:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 16B0234012F
 for <lttng-dev@lists.lttng.org>; Wed, 11 Jun 2014 14:44:29 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 0ByQ1oKcbcP1 for <lttng-dev@lists.lttng.org>;
 Wed, 11 Jun 2014 14:44:26 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id BDCC2340124
 for <lttng-dev@lists.lttng.org>; Wed, 11 Jun 2014 14:44:26 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id wzJLLZDdmThL for <lttng-dev@lists.lttng.org>;
 Wed, 11 Jun 2014 14:44:26 +0000 (UTC)
Received: from arch.demdgi.polymtl.ca (unknown [132.207.28.209])
 by mail.efficios.com (Postfix) with ESMTPSA id 5217E34013D
 for <lttng-dev@lists.lttng.org>; Wed, 11 Jun 2014 14:44:11 +0000 (UTC)
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

A typo in an if statement verifying the range in which the current
kernel's version is situated caused build failure for modules on 3.5.0
specifically, by trying to use the new api for block_rq_complete which
has not been backported from the 3.15 branch to the 3.5 branch.

Signed-off-by: Antoine Busque <antoine.busque@efficios.com>
---
 instrumentation/events/lttng-module/block.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/instrumentation/events/lttng-module/block.h b/instrumentation/events/lttng-module/block.h
index dbe6c6c..ad0a363 100644
--- a/instrumentation/events/lttng-module/block.h
+++ b/instrumentation/events/lttng-module/block.h
@@ -224,7 +224,7 @@ DEFINE_EVENT(block_rq_with_error, block_rq_requeue,
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,5)	\
 	|| LTTNG_KERNEL_RANGE(3,12,21, 3,13,0)		\
 	|| LTTNG_KERNEL_RANGE(3,10,41, 3,11,0)		\
-	|| LTTNG_KERNEL_RANGE(3,4,91, 3,5,1)		\
+	|| LTTNG_KERNEL_RANGE(3,4,91, 3,5,0)		\
 	|| LTTNG_KERNEL_RANGE(3,2,58, 3,3,0))
 
 /**
-- 
2.0.0
