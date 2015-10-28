From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2/2 stable-2.6] Fix: use liburcu
	flavor header instead of local copy
Date: Wed, 28 Oct 2015 15:55:58 -0400
Message-ID: <1446062158-1807-2-git-send-email-mathieu.desnoyers__17065.521880477$1446062241$gmane$org@efficios.com>
References: <1446062158-1807-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZrWpX-0007QI-Jd
 for lttng-dev@lists.lttng.org; Wed, 28 Oct 2015 15:56:20 -0400
In-Reply-To: <1446062158-1807-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The layout of struct rcu_flavor_struct has changed in newer URCU
versions. There is no need to keep a local copy of this structure. Use
the library header instead.

This ensures that the caller of _cds_lfht_new(), which passes a flavor
pointer with the library layout defined by liburcu, has the same layout
expected internally within the local copy of rculfhash.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/hashtable/Makefile.am   |  2 +-
 src/common/hashtable/rculfhash.c   |  2 +-
 src/common/hashtable/rculfhash.h   |  3 +-
 src/common/hashtable/urcu-flavor.h | 65 --------------------------------------
 4 files changed, 3 insertions(+), 69 deletions(-)
 delete mode 100644 src/common/hashtable/urcu-flavor.h

diff --git a/src/common/hashtable/Makefile.am b/src/common/hashtable/Makefile.am
index 021f01c..8d5a59a 100644
--- a/src/common/hashtable/Makefile.am
+++ b/src/common/hashtable/Makefile.am
@@ -4,7 +4,7 @@ noinst_LTLIBRARIES = libhashtable.la
 
 libhashtable_la_SOURCES = hashtable.c hashtable.h \
                          utils.c utils.h \
-                         rculfhash-internal.h urcu-flavor.h \
+                         rculfhash-internal.h \
                          rculfhash.h rculfhash.c \
                          rculfhash-mm-chunk.c \
                          rculfhash-mm-mmap.c \
diff --git a/src/common/hashtable/rculfhash.c b/src/common/hashtable/rculfhash.c
index e11c654..aa9cae5 100644
--- a/src/common/hashtable/rculfhash.c
+++ b/src/common/hashtable/rculfhash.c
@@ -277,7 +277,7 @@
 
 #include "rculfhash.h"
 #include "rculfhash-internal.h"
-#include "urcu-flavor.h"
+#include <urcu-flavor.h>
 
 #include <common/common.h>
 
diff --git a/src/common/hashtable/rculfhash.h b/src/common/hashtable/rculfhash.h
index adb5d9d..4bfe789 100644
--- a/src/common/hashtable/rculfhash.h
+++ b/src/common/hashtable/rculfhash.h
@@ -31,8 +31,7 @@
 #include <stdint.h>
 #include <urcu/compiler.h>
 #include <urcu-call-rcu.h>
-
-#include "urcu-flavor.h"
+#include <urcu-flavor.h>
 
 #ifdef __cplusplus
 extern "C" {
diff --git a/src/common/hashtable/urcu-flavor.h b/src/common/hashtable/urcu-flavor.h
deleted file mode 100644
index 9af4d0e..0000000
--- a/src/common/hashtable/urcu-flavor.h
+++ /dev/null
@@ -1,65 +0,0 @@
-#ifndef _URCU_FLAVOR_H
-#define _URCU_FLAVOR_H
-
-/*
- * urcu-flavor.h
- *
- * Userspace RCU header - rcu flavor declarations
- *
- * Copyright (c) 2011 Lai Jiangshan <laijs@cn.fujitsu.com>
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
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-struct rcu_flavor_struct {
-	void (*read_lock)(void);
-	void (*read_unlock)(void);
-	void (*read_quiescent_state)(void);
-	void (*update_call_rcu)(struct rcu_head *head,
-				void (*func)(struct rcu_head *head));
-	void (*update_synchronize_rcu)(void);
-	void (*update_defer_rcu)(void (*fct)(void *p), void *p);
-
-	void (*thread_offline)(void);
-	void (*thread_online)(void);
-	void (*register_thread)(void);
-	void (*unregister_thread)(void);
-};
-
-#define DEFINE_RCU_FLAVOR(x)				\
-const struct rcu_flavor_struct x = {			\
-	.read_lock		= rcu_read_lock,	\
-	.read_unlock		= rcu_read_unlock,	\
-	.read_quiescent_state	= rcu_quiescent_state,	\
-	.update_call_rcu	= call_rcu,		\
-	.update_synchronize_rcu	= synchronize_rcu,	\
-	.update_defer_rcu	= defer_rcu,		\
-	.thread_offline		= rcu_thread_offline,	\
-	.thread_online		= rcu_thread_online,	\
-	.register_thread	= rcu_register_thread,	\
-	.unregister_thread	= rcu_unregister_thread,\
-}
-
-extern const struct rcu_flavor_struct rcu_flavor;
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* _URCU_FLAVOR_H */
-- 
2.1.4
