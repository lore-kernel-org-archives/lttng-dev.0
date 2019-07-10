From: Junchang Wang <junchangwang@gmail.com>
Subject: [RFC 1/4] userspace-rcu: Add lock-free singly linked
 list rculflist
Date: Wed, 10 Jul 2019 11:28:07 +0800
Message-ID: <1562729290-6437-2-git-send-email-junchangwang__11009.1965690785$1562729408$gmane$org@gmail.com>
References: <1562729290-6437-1-git-send-email-junchangwang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 by lists.lttng.org (Postfix) with ESMTPS id 45k4RJ41PPz1635
 for <lttng-dev@lists.lttng.org>; Tue,  9 Jul 2019 23:29:00 -0400 (EDT)
Received: by mail-pf1-x442.google.com with SMTP id i189so366210pfg.10
 for <lttng-dev@lists.lttng.org>; Tue, 09 Jul 2019 20:29:00 -0700 (PDT)
In-Reply-To: <1562729290-6437-1-git-send-email-junchangwang@gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: mathieu.desnoyers@efficios.com, lttng-dev@lists.lttng.org
Cc: paulmck@linux.ibm.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Junchang Wang <junchangwang@gmail.com>
---
 include/urcu/rculflist.h | 279 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 279 insertions(+)
 create mode 100644 include/urcu/rculflist.h

diff --git a/include/urcu/rculflist.h b/include/urcu/rculflist.h
new file mode 100644
index 0000000..69f6303
--- /dev/null
+++ b/include/urcu/rculflist.h
@@ -0,0 +1,279 @@
+/*
+ * rculflist.c
+ *
+ * Userspace RCU library - Lock-Free ordered, singly-linked list
+ *
+ * Copyright (c) 2019 Junchang Wang
+ * Copyright (c) 2019 Paul E. McKenney
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, you can access it online at
+ * http://www.gnu.org/licenses/gpl-2.0.html.
+ *
+ *
+ * Based on the following research paper:
+ * - Maged M. Michael. High performance dynamic lock-free hash tables
+ *   and list-based sets. In Proceedings of the fourteenth annual ACM
+ *   symposium on Parallel algorithms and architectures, ACM Press,
+ *   (2002), 73-82.
+ *
+ * Some specificities of this Lock-free linked list implementation:
+ * - The original algorithm prevents the ABA problem by adding a tag field
+ *   in each hash-table node, whereas this implementation addresses this
+ *   issue by using the RCU mechanism.
+ */
+
+#ifndef _URCU_RCULFLIST_H
+#define _URCU_RCULFLIST_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include <urcu/uatomic.h>
+#include <urcu-pointer.h>
+#include <urcu-call-rcu.h>
+
+#define ACCESS_ONCE(x) (*(volatile typeof(x) *)&(x))
+#define READ_ONCE(x) \
+            ({ typeof(x) ___x = ACCESS_ONCE(x); ___x; })
+#define WRITE_ONCE(x, val) ({ ACCESS_ONCE(x) = (val); })
+
+/*
+ * lflist uses the least-significant 1 bit to indicate if a node has been
+ * logically removed.
+ */
+#define REMOVED_FLAG 	(1UL << 0)
+#define FLAGS_MASK 	((1UL << 1) - 1)
+
+/*
+ * Define the structure of list node and related functions.
+ */
+struct cds_lflist_node {
+	struct rcu_head rcu_head;
+	unsigned long key;
+	struct cds_lflist_node *next; /* (pointer | xxx_FLAG) */
+} __attribute__((aligned(8)));
+
+static inline
+unsigned long get_flag(struct cds_lflist_node *ptr)
+{
+	return (unsigned long)((uintptr_t)ptr & FLAGS_MASK);
+}
+
+static inline
+struct cds_lflist_node * get_ptr(struct cds_lflist_node *ptr)
+{
+	return (struct cds_lflist_node *)((uintptr_t)ptr & ~FLAGS_MASK);
+}
+
+static inline
+struct cds_lflist_node * set_flag(struct cds_lflist_node *ptr,
+                                      unsigned long mask)
+{
+	return (struct cds_lflist_node *)
+                    (((uintptr_t)ptr & ~FLAGS_MASK) | mask);
+}
+
+static inline
+int is_removed(struct cds_lflist_node *ptr)
+{
+	return (uintptr_t)ptr & REMOVED_FLAG;
+}
+
+void cds_lflist_node_init_rcu(struct cds_lflist_node *node)
+{
+	node->next = NULL;
+	node->key = 0UL;
+}
+
+void cds_lflist_node_set_key(struct cds_lflist_node *node, unsigned long key)
+{
+	node->key = key;
+}
+
+/*
+ * Struct cds_lflist_snapshot and its helper functions.
+ * Before invoking cds_lflist_find_rcu, the caller must first allocates
+ * an instance of struct cds_lflist_snapshot and passs the pointer
+ * to cds_lflist_find_rcu. By its completion, cds_lflist_find_rcu
+ * guarantees that (1) cur points to the node that contains the
+ * lowest key value that is greater than or equal to the input key
+ * and (2) prev is the predecessor pointer of cur.
+ */
+struct cds_lflist_snapshot {
+	struct cds_lflist_node **prev;
+	struct cds_lflist_node *cur;
+	struct cds_lflist_node *next;
+};
+
+static inline
+void set_snapshot(struct cds_lflist_snapshot *ssp,struct cds_lflist_node **prev,
+		     struct cds_lflist_node *cur, struct cds_lflist_node *next)
+{
+	ssp->prev = prev;
+	ssp->cur = get_ptr(cur);
+	ssp->next = get_ptr(next);
+}
+
+/*
+ * Define the struct of lock-free list and its helper functions.
+ */
+struct cds_lflist_rcu {
+	struct cds_lflist_node *head;
+	void (*delete_node)(struct cds_lflist_node *);
+};
+
+int cds_lflist_init_rcu(struct cds_lflist_rcu *list,
+		        void (*node_free)(struct cds_lflist_node *))
+{
+	list->head = NULL;
+	list->delete_node = node_free;
+	return 0;
+}
+
+/*
+ * Function cds_lflist_find_rcu() returns true(1) if a node with a matching key
+ * was found in the list, or returns false(0) otherwise.
+ * No matter if find_rcu() returns 1 or 0, by its completion, it guarantees
+ * that *ssp* points to the snapshot of a segment of the list. Within the
+ * snapshot, field *cur* points to the node that contains the lowest key value
+ * greater than or equal to the input key, and *prev* is the predecessor
+ * pointer of *cur*. Note that this function guarantees that the REMOVED_FLAG
+ * of the *cur* node has not been set.
+ */
+int cds_lflist_find_rcu(struct cds_lflist_rcu *list, unsigned long key,
+                            struct cds_lflist_snapshot *ssp)
+{
+	/* Local variables to record the snapshot */
+	struct cds_lflist_node **prev, *cur, *next;
+
+	struct cds_lflist_node *cur_ptr;
+	struct cds_lflist_node *next_ptr;
+	unsigned long cur_key;
+
+try_again:
+	prev = &list->head;
+	cur = READ_ONCE(*prev);
+	cur_ptr = get_ptr(cur);
+
+	for (;;) {
+		if (cur_ptr == NULL) {
+			/* Have reached the end of the list. */
+			set_snapshot(ssp, prev, NULL, NULL);
+			return 0;
+		}
+		cur_key = READ_ONCE(cur_ptr->key);
+		next = READ_ONCE(cur_ptr->next);
+		next_ptr = get_ptr(next);
+
+		/* If a new node has been added before cur, go to retry. */
+		if (READ_ONCE(*prev) != cur_ptr)
+			goto try_again;
+		if (!is_removed(next)) {
+			if (cur_key >= key) {
+				/* The key value of node cur_ptr is equal to
+				 * or larger than the input key value. */
+				set_snapshot(ssp, prev, cur, next);
+				return cur_key == key;
+			}
+			prev = &cur_ptr->next;
+		} else {
+			/* If the node cur_ptr has been logically deleted,
+			 * try to physically delete it. */
+			if (uatomic_cmpxchg(prev, cur_ptr, next_ptr) == cur_ptr){
+				/* Some applications (e.g., hashtorture) manages
+				 * (destroy) nodes by themselves. For these cases,
+				 * list->delete_node is initialized to NULL.  */
+				if(list->delete_node)
+					list->delete_node(cur_ptr);
+			} else {
+				/* One of other threads has physically delete
+				 * the node. Retry. */
+				goto try_again;
+			}
+		}
+		cur = next;
+		cur_ptr = get_ptr(cur);
+	}
+}
+
+/*
+ * Function cds_lflist_insert_rcu returns 0 if a node with a matching key
+ * is found in the list. Otherwise, this function inserts
+ * the new node before the node ss.cur and returns 1.
+ */
+int cds_lflist_insert_rcu(struct cds_lflist_rcu *list,
+                              struct cds_lflist_node *node)
+{
+	unsigned long key = node->key;
+	struct cds_lflist_snapshot ss;
+
+	for (;;) {
+		if (cds_lflist_find_rcu(list, key, &ss))
+			return 0;
+		node->next = set_flag(ss.cur, 0UL);
+		if (uatomic_cmpxchg(ss.prev, set_flag(ss.cur, 0UL),
+				set_flag(node,0UL)) == set_flag(ss.cur, 0UL)) {
+			return 1;
+		}
+	}
+}
+
+/*
+ * Function cds_lflist_delete_rcu returns 0 if the key is not found in the list.
+ * Otherwise, the key value of the node pointed to by ss.cur must be equal to
+ * the input key. The function deletes the node by (1) marking the node pointed
+ * to by ss.cur as deleted, and (2) swinging prev->next to point to next.
+ */
+int cds_lflist_delete_rcu(struct cds_lflist_rcu *list, unsigned long key)
+{
+	/* Local variables to record the snapshot */
+	struct cds_lflist_node *cur, *next;
+	struct cds_lflist_snapshot ss;
+
+	for (;;) {
+		if (!cds_lflist_find_rcu(list, key, &ss))
+			return 0;
+		cur = ss.cur;
+		next = ss.next;
+
+		/* The node to be deleted is pointed to by ss.cur.
+		 * We first logically deleted it by setting its REMOVED_FLAG.
+		 */
+		if (uatomic_cmpxchg(&cur->next, set_flag(next, 0UL),
+				set_flag(next, 1UL)) != set_flag(next, 0UL))
+			continue;
+		/* If node pointed to by ss.cur has been logically deleted,
+		 * try to physically delete it.
+		 */
+		if (uatomic_cmpxchg(ss.prev, set_flag(cur, 0UL),
+				set_flag(next, 0UL)) == set_flag(cur, 0UL)) {
+			/* Some applications (e.g., hashtorture) manages
+			 * (destroy) nodes by themselves. For these cases,
+			 * list->delete_node is initialized to NULL.  */
+			if (list->delete_node)
+				list->delete_node(cur);
+		} else {
+			/* Physical deletion failed. Retry.  */
+			cds_lflist_find_rcu(list, key, &ss);
+		}
+		return 1;
+	}
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /*_URCU_RCULFLIST_H */
-- 
2.7.4
