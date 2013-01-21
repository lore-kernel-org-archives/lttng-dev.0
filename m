From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH urcu] expand and cleanup list.h and rculist.h
Date: Mon, 21 Jan 2013 09:23:02 -0500
Message-ID: <20130121142302.GA32570__21049.1296639249$1358778232$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TxIHB-0002TI-7a
	for lttng-dev@lists.lttng.org; Mon, 21 Jan 2013 09:23:05 -0500
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Liu Yuan <namei.unix@gmail.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

Cleanup urcu/list.h and urcu/rculist.h: adopt Userspace RCU project
coding style, comment each function thoroughly.

Add the following API members:

- cds_list_for_each_safe()
- cds_list_for_each_entry_reverse_safe()
- cds_list_add_tail_rcu()

Document that cds_list_empty() can be used on RCU lists without
protection.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/urcu/list.h b/urcu/list.h
index 5d04394..f1fece4 100644
--- a/urcu/list.h
+++ b/urcu/list.h
@@ -5,7 +5,7 @@
  *
  * Copyright (C) 2009 Pierre-Marc Fournier
  * Conversion to RCU list.
- * Copyright (C) 2010 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * Copyright (C) 2010-2013 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
@@ -25,86 +25,124 @@
 #ifndef _CDS_LIST_H
 #define _CDS_LIST_H	1
 
-/* The definitions of this file are adopted from those which can be
-   found in the Linux kernel headers to enable people familiar with
-   the latter find their way in these sources as well.  */
-
+/*
+ * The definitions of this file are adopted from those which can be
+ * found in the Linux kernel headers to enable people familiar with the
+ * latter find their way in these sources as well.
+ */
 
-/* Basic type for the double-link list.  */
-struct cds_list_head
-{
-  struct cds_list_head *next;
-  struct cds_list_head *prev;
+/* Basic type for the double-link list. */
+struct cds_list_head {
+	struct cds_list_head *next;
+	struct cds_list_head *prev;
 };
 
+/* Define a variable with the head and tail of the list. */
+#define CDS_LIST_HEAD(name)	\
+	struct cds_list_head name = CDS_LIST_HEAD_INIT(name)
 
-/* Define a variable with the head and tail of the list.  */
-#define CDS_LIST_HEAD(name) \
-  struct cds_list_head name = { &(name), &(name) }
-
-/* Initialize a new list head.  */
-#define CDS_INIT_LIST_HEAD(ptr) \
-  (ptr)->next = (ptr)->prev = (ptr)
-
-#define CDS_LIST_HEAD_INIT(name) { .prev = &(name), .next = &(name) }
+#define CDS_LIST_HEAD_INIT(name)	{ .prev = &(name), .next = &(name) }
 
-/* Add new element at the head of the list.  */
-static inline void
-cds_list_add (struct cds_list_head *newp, struct cds_list_head *head)
+/*
+ * @CSD_INIT_LIST_HEAD: Initialize a new list head.
+ * @head: head of list to initialize.
+ */
+static inline
+void CDS_INIT_LIST_HEAD(struct cds_list_head *head)
 {
-  head->next->prev = newp;
-  newp->next = head->next;
-  newp->prev = head;
-  head->next = newp;
+	head->next = head;
+	head->prev = head;
 }
 
-
-/* Add new element at the tail of the list.  */
-static inline void
-cds_list_add_tail (struct cds_list_head *newp, struct cds_list_head *head)
+/*
+ * cds_list_add: Add new element at the head of the list.
+ * @newp: new element.
+ * @head: list head.
+ *
+ * Mutual exclusion against other updates and reads to list is required.
+ */
+static inline
+void cds_list_add(struct cds_list_head *newp, struct cds_list_head *head)
 {
-  head->prev->next = newp;
-  newp->next = head;
-  newp->prev = head->prev;
-  head->prev = newp;
+	head->next->prev = newp;
+	newp->next = head->next;
+	newp->prev = head;
+	head->next = newp;
 }
 
+/*
+ * cds_list_add_tail: Add new element at the tail of the list.
+ * @newp: new element.
+ * @head: list head.
+ *
+ * Mutual exclusion against other updates and reads to list is required.
+ */
+static inline
+void cds_list_add_tail(struct cds_list_head *newp, struct cds_list_head *head)
+{
+	head->prev->next = newp;
+	newp->next = head;
+	newp->prev = head->prev;
+	head->prev = newp;
+}
 
-/* Remove element from list.  */
-static inline void
-__cds_list_del (struct cds_list_head *prev, struct cds_list_head *next)
+static inline
+void __cds_list_del(struct cds_list_head *prev, struct cds_list_head *next)
 {
-  next->prev = prev;
-  prev->next = next;
+	next->prev = prev;
+	prev->next = next;
 }
 
-/* Remove element from list.  */
-static inline void
-cds_list_del (struct cds_list_head *elem)
+/*
+ * cds_list_del: Remove element from list.
+ * @elem: element to remove.
+ *
+ * Mutual exclusion against other updates and reads to list is required.
+ */
+static inline
+void cds_list_del(struct cds_list_head *elem)
 {
-  __cds_list_del (elem->prev, elem->next);
+	__cds_list_del(elem->prev, elem->next);
 }
 
-/* Remove element from list, initializing the element's list pointers. */
-static inline void
-cds_list_del_init (struct cds_list_head *elem)
+/*
+ * cds_list_del_init: Remove element from list, init element.
+ * @elem: element to remove.
+ *
+ * Remove element from list, initializing the element's list pointers.
+ * Mutual exclusion against other updates and reads to list is required.
+ */
+static inline
+void cds_list_del_init(struct cds_list_head *elem)
 {
 	cds_list_del(elem);
 	CDS_INIT_LIST_HEAD(elem);
 }
 
-/* delete from list, add to another list as head */
-static inline void
-cds_list_move (struct cds_list_head *elem, struct cds_list_head *head)
+/*
+ * cds_list_move: Delete from list, add to another list as head.
+ * @elem: element to move.
+ * @head: head of list to move into.
+ *
+ * Mutual exclusion against other updates and reads to both lists is
+ * required.
+ */
+static inline
+void cds_list_move(struct cds_list_head *elem, struct cds_list_head *head)
 {
-  __cds_list_del (elem->prev, elem->next);
-  cds_list_add (elem, head);
+	__cds_list_del(elem->prev, elem->next);
+	cds_list_add(elem, head);
 }
 
-/* replace an old entry.
+/*
+ * cds_list_replace: replace an old entry.
+ * @old: old entry.
+ * @_new: new entry.
+ *
+ * Mutual exclusion against other updates and reads to list is required.
  */
-static inline void
-cds_list_replace(struct cds_list_head *old, struct cds_list_head *_new)
+static inline
+void cds_list_replace(struct cds_list_head *old, struct cds_list_head *_new)
 {
 	_new->next = old->next;
 	_new->prev = old->prev;
@@ -112,75 +150,192 @@ cds_list_replace(struct cds_list_head *old, struct cds_list_head *_new)
 	_new->next->prev = _new;
 }
 
-/* Join two lists.  */
-static inline void
-cds_list_splice (struct cds_list_head *add, struct cds_list_head *head)
+/*
+ * cds_list_empty: returns whether list is empty
+ *
+ * Return nonzero if list is empty, zero otherwise.
+ * cds_list_empty() can be used on RCU lists. RCU read-side lock is not
+ * required.
+ */
+static inline
+int cds_list_empty(struct cds_list_head *head)
 {
-  /* Do nothing if the list which gets added is empty.  */
-  if (add != add->next)
-    {
-      add->next->prev = head;
-      add->prev->next = head->next;
-      head->next->prev = add->prev;
-      head->next = add->next;
-    }
+	return head == head->next;
 }
 
-/* Get typed element from list at a given position.  */
-#define cds_list_entry(ptr, type, member) \
-  ((type *) ((char *) (ptr) - (unsigned long) (&((type *) 0)->member)))
-
+/*
+ * cds_list_splice: Join two lists.
+ * @add: head of list to merge into @head.
+ * @head: head of list to be merged into.
+ *
+ * Merge @add into @head.
+ * Mutual exclusion against other updates and reads to both lists is
+ * required.
+ */
+static inline
+void cds_list_splice(struct cds_list_head *add, struct cds_list_head *head)
+{
+	/* Do nothing if the list which gets added is empty. */
+	if (cds_list_empty(add))
+		return;
+	add->next->prev = head;
+	add->prev->next = head->next;
+	head->next->prev = add->prev;
+	head->next = add->next;
+}
 
-/* Get first entry from a list. */
-#define cds_list_first_entry(ptr, type, member) \
-	cds_list_entry((ptr)->next, type, member)
+/*
+ * cds_list_replace_init: replace old entry by new one, init new entry.
+ * @old: old entry to replace.
+ * @_new: new entry to replace with.
+ *
+ * Mutual exclusion against other updates and reads to list is required.
+ */
+static inline
+void cds_list_replace_init(struct cds_list_head *old,
+		struct cds_list_head *_new)
+{
+	struct cds_list_head *head = old->next;
+	cds_list_del(old);
+	cds_list_add_tail(_new, head);
+	CDS_INIT_LIST_HEAD(old);
+}
 
+/*
+ * cds_list_entry: Get typed element from list at a given position.
+ * @ptr: node pointer (struct cds_list_head *).
+ * @type: type containing the list node field.
+ * @member: field name of list node within containing type.
+ */
+#define cds_list_entry(ptr, type, member)		\
+	((type *) ((char *) (ptr) - (unsigned long) (&((type *) 0)->member)))
 
-/* Iterate forward over the elements of the list.  */
-#define cds_list_for_each(pos, head) \
-  for (pos = (head)->next; pos != (head); pos = pos->next)
+/*
+ * cds_list_first_entry: Get first entry from a list.
+ * @head: list head (struct cds_list_head *).
+ * @type: type containing the list node field.
+ * @member: field name of list node within containing type.
+ *
+ * This should *not* be used on an empty list. Test for list emptiness
+ * before using @cds_list_first_entry.
+ */
+#define cds_list_first_entry(head, type, member)	\
+	cds_list_entry((head)->next, type, member)
 
+/*
+ * cds_list_for_each: Iterate forward over the elements of the list.
+ * @pos: pointer to use as iterator (struct cds_list_head *).
+ * @head: list head (struct cds_list_head *).
+ *
+ * Mutual exclusion against updates to list is required.
+ * It is not safe to remove elements within loop iteration.
+ */
+#define cds_list_for_each(pos, head)			\
+	for (pos = (head)->next; pos != (head); pos = pos->next)
 
-/* Iterate backward over the elements of the list.  */
-#define cds_list_for_each_prev(pos, head) \
-  for (pos = (head)->prev; pos != (head); pos = pos->prev)
+/*
+ * cds_list_for_each_safe: Iterate forward, safe against removal.
+ * @pos: pointer to use as iterator (struct cds_list_head *).
+ * @p: temporary pointer to store @pos copy (struct cds_list_head *).
+ * @head: list head (struct cds_list_head *).
+ *
+ * Mutual exclusion against updates to list is required.
+ * The list elements can be removed from the list within loop iteration.
+ */
+#define cds_list_for_each_safe(pos, p, head)		\
+	for (pos = (head)->next, p = pos->next;		\
+		pos != (head);				\
+		pos = p; p = pos->next)
 
+/*
+ * cds_list_for_each_prev: Iterate backward over the elements of the list.
+ * @pos: pointer to use as iterator (struct cds_list_head *).
+ * @head: list head (struct cds_list_head *).
+ *
+ * Mutual exclusion against updates to list is required.
+ * It is not safe to remove elements within loop iteration.
+ */
+#define cds_list_for_each_prev(pos, head)		\
+	for (pos = (head)->prev; pos != (head); pos = pos->prev)
 
-/* Iterate backwards over the elements list.  The list elements can be
-   removed from the list while doing this.  */
-#define cds_list_for_each_prev_safe(pos, p, head) \
-  for (pos = (head)->prev, p = pos->prev; \
-       pos != (head); \
-       pos = p, p = pos->prev)
+/*
+ * cds_list_for_each_prev_safe: Iterate backwards, safe against removal.
+ * @pos: pointer to use as iterator (struct cds_list_head *).
+ * @p: temporary pointer to store @pos copy (struct cds_list_head *).
+ * @head: list head (struct cds_list_head *).
+ *
+ * Mutual exclusion against updates to list is required.
+ * The list elements can be removed from the list within loop iteration.
+ */
+#define cds_list_for_each_prev_safe(pos, p, head)	\
+	for (pos = (head)->prev, p = pos->prev;		\
+		pos != (head);				\
+		pos = p, p = pos->prev)
 
-#define cds_list_for_each_entry(pos, head, member)				\
+/*
+ * cds_list_for_each_entry: Iterate forward over entries of the list.
+ * @pos: pointer to use as iterator (type of list node container).
+ * @head: list head (struct cds_list_head *).
+ * @member: field name of list node field within container type.
+ *
+ * Mutual exclusion against updates to list is required.
+ * It is not safe to remove elements within loop iteration.
+ */
+#define cds_list_for_each_entry(pos, head, member)			   \
 	for (pos = cds_list_entry((head)->next, __typeof__(*pos), member); \
-	     &pos->member != (head);					\
-	     pos = cds_list_entry(pos->member.next, __typeof__(*pos), member))
+		&pos->member != (head);					   \
+		pos = cds_list_entry(pos->member.next,			   \
+				__typeof__(*pos), member))
 
-#define cds_list_for_each_entry_reverse(pos, head, member)			\
+/*
+ * cds_list_for_each_entry_reverse: Iterate backwards over entries of the list.
+ * @pos: pointer to use as iterator (type of list node container).
+ * @head: list head (struct cds_list_head *).
+ * @member: field name of list node field within container type.
+ *
+ * Mutual exclusion against updates to list is required.
+ * It is not safe to remove elements within loop iteration.
+ */
+#define cds_list_for_each_entry_reverse(pos, head, member)		   \
 	for (pos = cds_list_entry((head)->prev, __typeof__(*pos), member); \
-	     &pos->member != (head);					\
-	     pos = cds_list_entry(pos->member.prev, __typeof__(*pos), member))
+		&pos->member != (head);					   \
+		pos = cds_list_entry(pos->member.prev,			   \
+				__typeof__(*pos), member))
 
-#define cds_list_for_each_entry_safe(pos, p, head, member)			\
+/*
+ * cds_list_for_each_entry_safe: Iterate forward, safe against removal.
+ * @pos: pointer to use as iterator (pointer to list node container).
+ * @p: temporary pointer to store @pos copy (pointer to list node container).
+ * @head: list head (struct cds_list_head *).
+ * @member: field name of list node field within container type.
+ *
+ * Mutual exclusion against updates to list is required.
+ * The list elements can be removed from the list within loop iteration.
+ */
+#define cds_list_for_each_entry_safe(pos, p, head, member)		   \
 	for (pos = cds_list_entry((head)->next, __typeof__(*pos), member), \
-		     p = cds_list_entry(pos->member.next, __typeof__(*pos), member); \
-	     &pos->member != (head);					\
-	     pos = p, p = cds_list_entry(pos->member.next, __typeof__(*pos), member))
+		p = cds_list_entry(pos->member.next,			   \
+				__typeof__(*pos), member);		   \
+		&pos->member != (head);					   \
+		pos = p, p = cds_list_entry(pos->member.next,		   \
+				__typeof__(*pos), member))
 
-static inline int cds_list_empty(struct cds_list_head *head)
-{
-	return head == head->next;
-}
-
-static inline void cds_list_replace_init(struct cds_list_head *old,
-				     struct cds_list_head *_new)
-{
-	struct cds_list_head *head = old->next;
-	cds_list_del(old);
-	cds_list_add_tail(_new, head);
-	CDS_INIT_LIST_HEAD(old);
-}
+/*
+ * cds_list_for_each_entry_reverse_safe: Iterate backwards, safe for removal.
+ * @pos: pointer to use as iterator (pointer to list node container).
+ * @p: temporary pointer to store @pos copy (pointer to list node container).
+ * @head: list head (struct cds_list_head *).
+ * @member: field name of list node field within container type.
+ *
+ * Mutual exclusion against updates to list is required.
+ * The list elements can be removed from the list within loop iteration.
+ */
+#define cds_list_for_each_entry_reverse_safe(pos, p, head, member)	   \
+	for (pos = cds_list_entry((head)->prev, __typeof__(*pos), member), \
+		p = cds_list_entry(pos->member.prev,			   \
+				__typeof__(*pos), member);		   \
+		&pos->member != (head);					   \
+		pos = p, p = cds_list_entry(pos->member.prev,		   \
+				__typeof__(*pos), member))
 
 #endif	/* _CDS_LIST_H */
diff --git a/urcu/rculist.h b/urcu/rculist.h
index 3604a96..e6615ba 100644
--- a/urcu/rculist.h
+++ b/urcu/rculist.h
@@ -5,7 +5,7 @@
  *
  * Copyright (C) 2009 Pierre-Marc Fournier
  * Conversion to RCU list.
- * Copyright (C) 2010 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * Copyright (C) 2010-2013 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
@@ -29,9 +29,16 @@
 #include <urcu/arch.h>
 #include <urcu-pointer.h>
 
-/* Add new element at the head of the list.
+/*
+ * cds_list_add_rcu: Add new element at the head of the list.
+ * @newp: new element.
+ * @head: list head.
+ *
+ * Mutual exclusion against other updates to the list is required.
+ * RCU-safe for concurrent traversals.
  */
-static inline void cds_list_add_rcu(struct cds_list_head *newp, struct cds_list_head *head)
+static inline
+void cds_list_add_rcu(struct cds_list_head *newp, struct cds_list_head *head)
 {
 	newp->next = head->next;
 	newp->prev = head;
@@ -40,9 +47,36 @@ static inline void cds_list_add_rcu(struct cds_list_head *newp, struct cds_list_
 	head->next = newp;
 }
 
-/* replace an old entry atomically.
+/*
+ * cds_list_add_tail_rcu: Add new element at the tail of the list.
+ * @newp: new element.
+ * @head: list head.
+ *
+ * Mutual exclusion against other updates to the list is required.
+ * RCU-safe for concurrent traversals.
+ */
+static inline
+void cds_list_add_tail_rcu(struct cds_list_head *newp,
+		struct cds_list_head *head)
+{
+	newp->next = head;
+	newp->prev = head->prev;
+	cmm_smp_wmb();
+	head->prev = newp;
+	head->prev->next = newp;
+}
+
+/*
+ * cds_list_replace_rcu: replace an old entry atomically.
+ * @old: old entry.
+ * @_new: new entry.
+ *
+ * Replace old entry atomically with respect to concurrent readers.
+ * Mutual exclusion against other updates to the list is required.
+ * RCU-safe for concurrent traversals.
  */
-static inline void cds_list_replace_rcu(struct cds_list_head *old, struct cds_list_head *_new)
+static inline
+void cds_list_replace_rcu(struct cds_list_head *old, struct cds_list_head *_new)
 {
 	_new->next = old->next;
 	_new->prev = old->prev;
@@ -50,29 +84,53 @@ static inline void cds_list_replace_rcu(struct cds_list_head *old, struct cds_li
 	_new->next->prev = _new;
 }
 
-/* Remove element from list. */
-static inline void cds_list_del_rcu(struct cds_list_head *elem)
+/*
+ * cds_list_del_rcu: Remove element from list.
+ * @elem: new element.
+ *
+ * Mutual exclusion against other updates to the list is required.
+ * RCU-safe for concurrent traversals.
+ */
+static inline
+void cds_list_del_rcu(struct cds_list_head *elem)
 {
 	elem->next->prev = elem->prev;
 	elem->prev->next = elem->next;
 }
 
 /*
- * Iteration through all elements of the list must be done while rcu_read_lock()
- * is held.
+ * cds_list_empty() can be used on RCU lists. RCU read-side lock is not
+ * required.
  */
 
-/* Iterate forward over the elements of the list.  */
-#define cds_list_for_each_rcu(pos, head) \
-  for (pos = rcu_dereference((head)->next); pos != (head); \
-       pos = rcu_dereference(pos->next))
-
+/*
+ * cds_list_for_each_rcu: RCU-safe iteration over the elements of the list.
+ * @pos: iteration position (struct cds_list_head *).
+ * @head: list head (struct cds_list_head *).
+ *
+ * Iteration direction: forward.
+ * Iteration through all elements of the list must be done while
+ * rcu_read_lock() is held.
+ */
+#define cds_list_for_each_rcu(pos, head)				\
+	for (pos = rcu_dereference((head)->next); pos != (head);	\
+		pos = rcu_dereference(pos->next))
 
-/* Iterate through elements of the list.
+/*
+ * cds_list_for_each_entry_rcu: RCU-safe iteration over entries of the list.
+ * @pos: iteration position (pointer to entry type).
+ * @head: list head (struct cds_list_head *).
+ * @member: field name of the list node within entry type.
+ *
+ * Iteration direction: forward.
+ * Iteration through all elements of the list must be done while
+ * rcu_read_lock() is held.
  */
-#define cds_list_for_each_entry_rcu(pos, head, member)				\
-	for (pos = cds_list_entry(rcu_dereference((head)->next), __typeof__(*pos), member);	\
+#define cds_list_for_each_entry_rcu(pos, head, member)			\
+	for (pos = cds_list_entry(rcu_dereference((head)->next),	\
+		__typeof__(*pos), member);				\
 	     &pos->member != (head);					\
-	     pos = cds_list_entry(rcu_dereference(pos->member.next), __typeof__(*pos), member))
+	     pos = cds_list_entry(rcu_dereference(pos->member.next),	\
+		__typeof__(*pos), member))
 
 #endif	/* _URCU_RCULIST_H */
-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
