From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] Add missing SPDX license
 identifiers to uprobes
Date: Thu,  8 Nov 2018 17:18:28 -0500
Message-ID: <20181108221828.18428-1-mjeanson__19611.9041684598$1541715401$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42rd3L4Tp8zqgN
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 17:18:38 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 0510424BE3C
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 17:18:38 -0500 (EST)
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
 probes/lttng-uprobes.c | 3 ++-
 wrapper/uprobes.h      | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/probes/lttng-uprobes.c b/probes/lttng-uprobes.c
index bcdbbd8..76023fb 100644
--- a/probes/lttng-uprobes.c
+++ b/probes/lttng-uprobes.c
@@ -1,4 +1,5 @@
-/*
+/* SPDX-License-Identifier: (GPL-2.0 OR LGPL-2.1)
+ *
  * probes/lttng-uprobes.c
  *
  * LTTng uprobes integration module.
diff --git a/wrapper/uprobes.h b/wrapper/uprobes.h
index e38a541..28da640 100644
--- a/wrapper/uprobes.h
+++ b/wrapper/uprobes.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR LGPL-2.1) */
 #ifndef _LTTNG_WRAPPER_UPROBES_H
 #define _LTTNG_WRAPPER_UPROBES_H
 
-- 
2.17.1
