From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH 1/2] fix: missing cpuid kernel
	context in the ABI
Date: Tue, 10 Nov 2015 21:21:14 -0500
Message-ID: <1447208475-24578-1-git-send-email-jdesfossez__29098.6137385064$1447208532$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZwL2L-0000uk-VT
 for lttng-dev@lists.lttng.org; Tue, 10 Nov 2015 21:21:26 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/common/lttng-kernel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/common/lttng-kernel.h b/src/common/lttng-kernel.h
index f1144de..f58108f 100644
--- a/src/common/lttng-kernel.h
+++ b/src/common/lttng-kernel.h
@@ -53,6 +53,7 @@ enum lttng_kernel_context_type {
 	LTTNG_KERNEL_CONTEXT_PPID           = 8,
 	LTTNG_KERNEL_CONTEXT_VPPID          = 9,
 	LTTNG_KERNEL_CONTEXT_HOSTNAME       = 10,
+	LTTNG_KERNEL_CONTEXT_CPUID          = 11,
 };
 
 /* Perf counter attributes */
-- 
1.9.1
