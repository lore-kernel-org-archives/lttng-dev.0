From: Paul Woegerer <paul_woegerer@mentor.com>
Subject: [PATCH] Fix: baddr_statedump tracepoint registration
Date: Fri, 13 Dec 2013 14:12:02 +0100
Message-ID: <1386940322-9894-1-git-send-email-paul_woegerer__22691.6382242509$1386940412$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1VrSXr-0005rD-G1
	for lttng-dev@lists.lttng.org; Fri, 13 Dec 2013 08:12:46 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Also make sure that the ust_baddr_statedump probe get registered prior
to using the tracepoint in lttng_ust_baddr_statedump(). This fix solves
the issue that in rare cases the very first ust_baddr_statedump events
were missing.

Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
---
 include/lttng/ust-tracepoint-event.h | 10 ++++++++++
 liblttng-ust/Makefile.am             |  1 -
 liblttng-ust/lttng-ust-baddr.c       | 15 +++++++++++++++
 liblttng-ust/ust_baddr_statedump.c   | 22 ----------------------
 4 files changed, 25 insertions(+), 23 deletions(-)
 delete mode 100644 liblttng-ust/ust_baddr_statedump.c

diff --git a/include/lttng/ust-tracepoint-event.h b/include/lttng/ust-tracepoint-event.h
index be58030..b48cd74 100644
--- a/include/lttng/ust-tracepoint-event.h
+++ b/include/lttng/ust-tracepoint-event.h
@@ -694,6 +694,10 @@ static struct lttng_probe_desc _TP_COMBINE_TOKENS(__probe_desc___, TRACEPOINT_PR
  * linking the probe statically.
  */
 
+#ifndef BADDR_EXPLICIT_PROBE_REGISTER
+#define BADDR_EXPLICIT_PROBE_REGISTER do {} while (0)
+#endif
+
 /* Reset all macros within TRACEPOINT_EVENT */
 #include <lttng/ust-tracepoint-event-reset.h>
 static void lttng_ust_notrace __attribute__((constructor))
@@ -703,6 +707,8 @@ _TP_COMBINE_TOKENS(__lttng_events_init__, TRACEPOINT_PROVIDER)(void)
 {
 	int ret;
 
+	BADDR_EXPLICIT_PROBE_REGISTER;
+
 	/*
 	 * __tracepoint_provider_check_ ## TRACEPOINT_PROVIDER() is a
 	 * static inline function that ensures every probe PROVIDER
@@ -724,7 +730,11 @@ _TP_COMBINE_TOKENS(__lttng_events_exit__, TRACEPOINT_PROVIDER)(void);
 static void
 _TP_COMBINE_TOKENS(__lttng_events_exit__, TRACEPOINT_PROVIDER)(void)
 {
+	BADDR_EXPLICIT_PROBE_REGISTER;
+
 	lttng_probe_unregister(&_TP_COMBINE_TOKENS(__probe_desc___, TRACEPOINT_PROVIDER));
 }
 
+#undef BADDR_EXPLICIT_PROBE_REGISTER
+
 int _TP_COMBINE_TOKENS(__tracepoint_provider_, TRACEPOINT_PROVIDER);
diff --git a/liblttng-ust/Makefile.am b/liblttng-ust/Makefile.am
index b165c32..e9022d8 100644
--- a/liblttng-ust/Makefile.am
+++ b/liblttng-ust/Makefile.am
@@ -37,7 +37,6 @@ liblttng_ust_runtime_la_SOURCES = \
 	lttng-hash-helper.h \
 	lttng-ust-baddr.c \
 	lttng-ust-baddr.h \
-	ust_baddr_statedump.c \
 	ust_baddr_statedump.h \
 	tracepoint-internal.h \
 	clock.h \
diff --git a/liblttng-ust/lttng-ust-baddr.c b/liblttng-ust/lttng-ust-baddr.c
index b7843e2..d39e9e8 100644
--- a/liblttng-ust/lttng-ust-baddr.c
+++ b/liblttng-ust/lttng-ust-baddr.c
@@ -35,6 +35,15 @@
 #include "lttng-tracer-core.h"
 #include "lttng-ust-baddr.h"
 
+#define TRACEPOINT_CREATE_PROBES
+#define TP_SESSION_CHECK
+static int explicit_probe_register;
+#define BADDR_EXPLICIT_PROBE_REGISTER \
+do { \
+	if (!explicit_probe_register) \
+		return; \
+} while (0)
+
 #define TRACEPOINT_DEFINE
 #include "ust_baddr_statedump.h"
 
@@ -199,10 +208,16 @@ void lttng_ust_baddr_statedump_init(void)
 {
 	__tracepoints__init();
 	__tracepoints__ptrs_init();
+	explicit_probe_register = 1;
+	__lttng_events_init__ust_baddr_statedump();
+	explicit_probe_register = 0;
 }
 
 void lttng_ust_baddr_statedump_destroy(void)
 {
+	explicit_probe_register = 1;
+	__lttng_events_exit__ust_baddr_statedump();
+	explicit_probe_register = 0;
 	__tracepoints__ptrs_destroy();
 	__tracepoints__destroy();
 }
diff --git a/liblttng-ust/ust_baddr_statedump.c b/liblttng-ust/ust_baddr_statedump.c
deleted file mode 100644
index 9097008..0000000
--- a/liblttng-ust/ust_baddr_statedump.c
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * Copyright (C) 2013  Paul Woegerer <paul_woegerer@mentor.com>
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
- */
-
-#define _LGPL_SOURCE
-#define TRACEPOINT_CREATE_PROBES
-#define TP_SESSION_CHECK
-#include "ust_baddr_statedump.h"
-- 
1.8.5
