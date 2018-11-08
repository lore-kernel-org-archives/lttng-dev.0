From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 05/30] Drop support for
 kernels < 3.0 from tracepoint.h wrapper
Date: Thu,  8 Nov 2018 16:45:10 -0500
Message-ID: <20181108214535.12081-5-mjeanson__14780.9371621863$1541713503$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKX3NSLzq97
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:52 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 7324F24ACE1
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:52 -0500 (EST)
In-Reply-To: <20181108214535.12081-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 wrapper/tracepoint.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/wrapper/tracepoint.h b/wrapper/tracepoint.h
index 0c5a296..6ee4217 100644
--- a/wrapper/tracepoint.h
+++ b/wrapper/tracepoint.h
@@ -14,12 +14,6 @@
 #include <linux/tracepoint.h>
 #include <linux/module.h>
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35))
-
-#define DECLARE_EVENT_CLASS(name, proto, args, tstruct, assign, print)
-
-#endif
-
 #ifndef HAVE_KABI_2635_TRACEPOINT
 
 #define kabi_2635_tracepoint_probe_register tracepoint_probe_register
-- 
2.17.1
