From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Add missing include for kernels
 between 3.8 and 3.15
Date: Mon, 28 Oct 2019 16:28:43 -0400
Message-ID: <20191028202843.17852-1-mjeanson__13555.7979041309$1572294544$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 4725sD58G9zqkb
 for <lttng-dev@lists.lttng.org>; Mon, 28 Oct 2019 16:28:48 -0400 (EDT)
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

This is required at least for:
 v3.13.x
 v3.11.x
 v3.9.x
 v3.8.x

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 lttng-context-mnt-ns.c | 1 +
 lttng-context-net-ns.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/lttng-context-mnt-ns.c b/lttng-context-mnt-ns.c
index 98d5b8e..b5bb955 100644
--- a/lttng-context-mnt-ns.c
+++ b/lttng-context-mnt-ns.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <lttng-events.h>
+#include <linux/nsproxy.h>
 #include <wrapper/ringbuffer/frontend_types.h>
 #include <wrapper/vmalloc.h>
 #include <wrapper/namespace.h>
diff --git a/lttng-context-net-ns.c b/lttng-context-net-ns.c
index 24d7ae3..6694037 100644
--- a/lttng-context-net-ns.c
+++ b/lttng-context-net-ns.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/nsproxy.h>
 #include <net/net_namespace.h>
 #include <lttng-events.h>
 #include <wrapper/ringbuffer/frontend_types.h>
-- 
2.17.1
