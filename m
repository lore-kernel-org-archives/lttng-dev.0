From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH urcu] lfstack: implement lock-free stack
Date: Mon, 22 Oct 2012 09:01:54 -0400
Message-ID: <20121022130154.GC30944__44484.3551530086$1350911258$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TQHdk-0002ym-D5
	for lttng-dev@lists.lttng.org; Mon, 22 Oct 2012 09:01:56 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev@lists.lttng.org, Lai Jiangshan <eag0628@gmail.com>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

This stack does not require to hold RCU read-side lock across push, and
allows multiple strategies to be used for pop.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Paul McKenney <paulmck@linux.vnet.ibm.com>
CC: Lai Jiangshan <laijs@cn.fujitsu.com>
---
diff --git a/Makefile.am b/Makefile.am
index ffdca9a..195b89a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -17,6 +17,7 @@ nobase_dist_include_HEADERS = urcu/compiler.h urcu/hlist.h urcu/list.h \
 		urcu/wfqueue.h urcu/rculfstack.h urcu/rculfqueue.h \
 		urcu/ref.h urcu/cds.h urcu/urcu_ref.h urcu/urcu-futex.h \
 		urcu/uatomic_arch.h urcu/rculfhash.h urcu/wfcqueue.h \
+		urcu/lfstack.h \
 		$(top_srcdir)/urcu/map/*.h \
 		$(top_srcdir)/urcu/static/*.h \
 		urcu/tls-compat.h
@@ -72,7 +73,8 @@ liburcu_signal_la_LIBADD = liburcu-common.la
 liburcu_bp_la_SOURCES = urcu-bp.c urcu-pointer.c $(COMPAT)
 liburcu_bp_la_LIBADD = liburcu-common.la
 
-liburcu_cds_la_SOURCES = rculfqueue.c rculfstack.c $(RCULFHASH) $(COMPAT)
+liburcu_cds_la_SOURCES = rculfqueue.c rculfstack.c lfstack.c \
+	$(RCULFHASH) $(COMPAT)
 liburcu_cds_la_LIBADD = liburcu-common.la
 
 pkgconfigdir = $(libdir)/pkgconfig
diff --git a/lfstack.c b/lfstack.c
new file mode 100644
index 0000000..74ffd4f
--- /dev/null
+++ b/lfstack.c
@@ -0,0 +1,51 @@
+/*
+ * lfstack.c
+ *
+ * Userspace RCU library - Lock-Free Stack
+ *
+ * Copyright 2010-2012 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+/* Do not #define _LGPL_SOURCE to ensure we can emit the wrapper symbols */
+#undef _LGPL_SOURCE
+#include "urcu/lfstack.h"
+#define _LGPL_SOURCE
+#include "urcu/static/lfstack.h"
+
+/*
+ * library wrappers to be used by non-LGPL compatible source code.
+ */
+
+void cds_lfs_node_init(struct cds_lfs_node *node)
+{
+	_cds_lfs_node_init(node);
+}
+
+void cds_lfs_init(struct cds_lfs_stack *s)
+{
+	_cds_lfs_init(s);
+}
+
+int cds_lfs_push(struct cds_lfs_stack *s, struct cds_lfs_node *node)
+{
+	return _cds_lfs_push(s, node);
+}
+
+struct cds_lfs_node *cds_lfs_pop(struct cds_lfs_stack *s)
+{
+	return _cds_lfs_pop(s);
+}
diff --git a/urcu/cds.h b/urcu/cds.h
index d9e7984..78534bb 100644
--- a/urcu/cds.h
+++ b/urcu/cds.h
@@ -33,5 +33,6 @@
 #include <urcu/wfqueue.h>
 #include <urcu/wfcqueue.h>
 #include <urcu/wfstack.h>
+#include <urcu/lfstack.h>
 
 #endif /* _URCU_CDS_H */
diff --git a/urcu/lfstack.h b/urcu/lfstack.h
new file mode 100644
index 0000000..d068739
--- /dev/null
+++ b/urcu/lfstack.h
@@ -0,0 +1,87 @@
+#ifndef _URCU_LFSTACK_H
+#define _URCU_LFSTACK_H
+
+/*
+ * lfstack.h
+ *
+ * Userspace RCU library - Lock-Free Stack
+ *
+ * Copyright 2010-2012 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct cds_lfs_node {
+	struct cds_lfs_node *next;
+};
+
+struct cds_lfs_stack {
+	struct cds_lfs_node *head;
+};
+
+#ifdef _LGPL_SOURCE
+
+#include <urcu/static/lfstack.h>
+
+#define cds_lfs_node_init		_cds_lfs_node_init
+#define cds_lfs_init			_cds_lfs_init
+#define cds_lfs_push			_cds_lfs_push
+#define cds_lfs_pop			_cds_lfs_pop
+
+#else /* !_LGPL_SOURCE */
+
+extern void cds_lfs_node_init(struct cds_lfs_node *node);
+extern void cds_lfs_init(struct cds_lfs_stack *s);
+
+/*
+ * cds_lfs_push: push a node into the stack.
+ *
+ * Does not require any synchronization with other push nor pop.
+ *
+ * Returns 0 if the stack was empty prior to adding the node.
+ * Returns non-zero otherwise.
+ */
+extern int cds_lfs_push(struct cds_lfs_stack *s,
+			struct cds_lfs_node *node);
+
+/*
+ * cds_lfs_pop: pop a node from the stack.
+ *
+ * Returns NULL if stack is empty.
+ *
+ * cds_lfs_pop needs to be synchronized using one of the following
+ * techniques:
+ *
+ * 1) Calling cds_lfs_pop under rcu read lock critical section. The
+ *    caller must wait for a grace period to pass before freeing the
+ *    returned node or modifying the cds_lfs_node structure.
+ * 2) Using mutual exclusion (e.g. mutexes) to protect cds_lfs_pop
+ *    callers.
+ * 3) Ensuring that only ONE thread can call cds_lfs_pop().
+ *    (multi-provider/single-consumer scheme).
+ */
+extern struct cds_lfs_node *cds_lfs_pop(struct cds_lfs_stack *s);
+
+#endif /* !_LGPL_SOURCE */
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _URCU_LFSTACK_H */
diff --git a/urcu/static/lfstack.h b/urcu/static/lfstack.h
new file mode 100644
index 0000000..7acbf54
--- /dev/null
+++ b/urcu/static/lfstack.h
@@ -0,0 +1,151 @@
+#ifndef _URCU_STATIC_LFSTACK_H
+#define _URCU_STATIC_LFSTACK_H
+
+/*
+ * urcu/static/lfstack.h
+ *
+ * Userspace RCU library - Lock-Free Stack
+ *
+ * Copyright 2010-2012 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * TO BE INCLUDED ONLY IN LGPL-COMPATIBLE CODE. See rculfstack.h for linking
+ * dynamically with the userspace rcu library.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <urcu/uatomic.h>
+#include <urcu-pointer.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+static inline
+void _cds_lfs_node_init(struct cds_lfs_node *node)
+{
+}
+
+static inline
+void _cds_lfs_init(struct cds_lfs_stack *s)
+{
+	s->head = NULL;
+}
+
+/*
+ * cds_lfs_push: push a node into the stack.
+ *
+ * Does not require any synchronization with other push nor pop.
+ *
+ * Lock-free stack push is not subject to ABA problem, so no need to
+ * take the RCU read-side lock. Even if "head" changes between two
+ * uatomic_cmpxchg() invocations here (being popped, and then pushed
+ * again by one or more concurrent threads), the second
+ * uatomic_cmpxchg() invocation only cares about pushing a new entry at
+ * the head of the stack, ensuring consistency by making sure the new
+ * node->next is the same pointer value as the value replaced as head.
+ * It does not care about the content of the actual next node, so it can
+ * very well be reallocated between the two uatomic_cmpxchg().
+ *
+ * We take the approach of expecting the stack to be usually empty, so
+ * we first try an initial uatomic_cmpxchg() on a NULL old_head, and
+ * retry if the old head was non-NULL (the value read by the first
+ * uatomic_cmpxchg() is used as old head for the following loop). The
+ * upside of this scheme is to minimize the amount of cacheline traffic,
+ * always performing an exclusive cacheline access, rather than doing
+ * non-exclusive followed by exclusive cacheline access (which would be
+ * required if we first read the old head value). This design decision
+ * might be revisited after more throrough benchmarking on various
+ * platforms.
+ *
+ * Returns 0 if the stack was empty prior to adding the node.
+ * Returns non-zero otherwise.
+ */
+static inline
+int _cds_lfs_push(struct cds_lfs_stack *s,
+		  struct cds_lfs_node *node)
+{
+	struct cds_lfs_node *head = NULL;
+
+	for (;;) {
+		struct cds_lfs_node *old_head = head;
+
+		/*
+		 * node->next is still private at this point, no need to
+		 * perform a _CMM_STORE_SHARED().
+		 */
+		node->next = head;
+		/*
+		 * uatomic_cmpxchg() implicit memory barrier orders earlier
+		 * stores to node before publication.
+		 */
+		head = uatomic_cmpxchg(&s->head, old_head, node);
+		if (old_head == head)
+			break;
+	}
+	return (int) !!((unsigned long) head);
+}
+
+/*
+ * cds_lfs_pop: pop a node from the stack.
+ *
+ * Returns NULL if stack is empty.
+ *
+ * cds_lfs_pop needs to be synchronized using one of the following
+ * techniques:
+ *
+ * 1) Calling cds_lfs_pop under rcu read lock critical section. The
+ *    caller must wait for a grace period to pass before freeing the
+ *    returned node or modifying the cds_lfs_node structure.
+ * 2) Using mutual exclusion (e.g. mutexes) to protect cds_lfs_pop
+ *    callers.
+ * 3) Ensuring that only ONE thread can call cds_lfs_pop().
+ *    (multi-provider/single-consumer scheme).
+ */
+static inline
+struct cds_lfs_node *_cds_lfs_pop(struct cds_lfs_stack *s)
+{
+	for (;;) {
+		struct cds_lfs_node *head;
+
+		head = _CMM_LOAD_SHARED(s->head);
+		if (head) {
+			struct cds_lfs_node *next;
+
+			/*
+			 * Read head before head->next. Matches the
+			 * implicit memory barrier before
+			 * uatomic_cmpxchg() in cds_lfs_push.
+			 */
+			cmm_smp_read_barrier_depends();
+			next = _CMM_LOAD_SHARED(head->next);
+			if (uatomic_cmpxchg(&s->head, head, next) == head) {
+				return head;
+			} else {
+				/* Concurrent modification. Retry. */
+				continue;
+			}
+		} else {
+			/* Empty stack */
+			return NULL;
+		}
+	}
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _URCU_STATIC_LFSTACK_H */

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
