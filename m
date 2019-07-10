From: Junchang Wang <junchangwang@gmail.com>
Subject: [RFC 2/4] userspace-rcu: Add sample code of rculflist
Date: Wed, 10 Jul 2019 11:28:08 +0800
Message-ID: <1562729290-6437-3-git-send-email-junchangwang__22486.3780009159$1562729481$gmane$org@gmail.com>
References: <1562729290-6437-1-git-send-email-junchangwang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 by lists.lttng.org (Postfix) with ESMTPS id 45k4Rf0GDXz163V
 for <lttng-dev@lists.lttng.org>; Tue,  9 Jul 2019 23:29:17 -0400 (EDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so467962pgp.12
 for <lttng-dev@lists.lttng.org>; Tue, 09 Jul 2019 20:29:17 -0700 (PDT)
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

For the three Makefiles, I just copied, pasted, and updated slightly, so
I didn't change the copyright information.

 doc/examples/Makefile.am                           |  13 ++-
 .../rculflist/Makefile.cds_lflist_delete_rcu       |  21 +++++
 .../rculflist/Makefile.cds_lflist_find_rcu         |  21 +++++
 .../rculflist/Makefile.cds_lflist_insert_rcu       |  21 +++++
 doc/examples/rculflist/cds_lflist_delete_rcu.c     | 100 +++++++++++++++++++++
 doc/examples/rculflist/cds_lflist_find_rcu.c       |  96 ++++++++++++++++++++
 doc/examples/rculflist/cds_lflist_insert_rcu.c     |  66 ++++++++++++++
 7 files changed, 337 insertions(+), 1 deletion(-)
 create mode 100644 doc/examples/rculflist/Makefile.cds_lflist_delete_rcu
 create mode 100644 doc/examples/rculflist/Makefile.cds_lflist_find_rcu
 create mode 100644 doc/examples/rculflist/Makefile.cds_lflist_insert_rcu
 create mode 100644 doc/examples/rculflist/cds_lflist_delete_rcu.c
 create mode 100644 doc/examples/rculflist/cds_lflist_find_rcu.c
 create mode 100644 doc/examples/rculflist/cds_lflist_insert_rcu.c

diff --git a/doc/examples/Makefile.am b/doc/examples/Makefile.am
index edf00eb..369d92e 100644
--- a/doc/examples/Makefile.am
+++ b/doc/examples/Makefile.am
@@ -111,13 +111,24 @@ dist_doc_examples_rculfhash_DATA = \
 	rculfhash/cds_lfht_lookup.c \
 	rculfhash/cds_lfht_for_each_entry_duplicate.c
 
+doc_examples_rculflistdir = ${doc_examplesdir}/rculflist
+
+dist_doc_examples_rculflist_DATA = \
+	rculflist/Makefile \
+	rculflist/Makefile.cds_lflist_insert_rcu \
+	rculflist/Makefile.cds_lflist_delete_rcu \
+	rculflist/Makefile.cds_lflist_find_rcu \
+	rculflist/cds_lflist_insert_rcu.c \
+	rculflist/cds_lflist_delete_rcu.c \
+	rculflist/cds_lflist_find_rcu.c
+
 if NO_SHARED
 # Don't build examples if shared libraries support was explicitly
 # disabled.
 else
 
 SUBDIRS_PROXY = hlist list urcu-flavors wfcqueue rculfqueue \
-	wfstack lfstack rculfhash
+	wfstack lfstack rculfhash rculflist
 
 # Copies are for VPATH build support.
 all-local:
diff --git a/doc/examples/rculflist/Makefile.cds_lflist_delete_rcu b/doc/examples/rculflist/Makefile.cds_lflist_delete_rcu
new file mode 100644
index 0000000..09d1a55
--- /dev/null
+++ b/doc/examples/rculflist/Makefile.cds_lflist_delete_rcu
@@ -0,0 +1,21 @@
+# Copyright (C) 2013  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+#
+# THIS MATERIAL IS PROVIDED AS IS, WITH ABSOLUTELY NO WARRANTY EXPRESSED
+# OR IMPLIED.  ANY USE IS AT YOUR OWN RISK.
+#
+# Permission is hereby granted to use or copy this program for any
+# purpose,  provided the above notices are retained on all copies.
+# Permission to modify the code and to distribute modified code is
+# granted, provided the above notices are retained, and a notice that
+# the code was modified is included with the above copyright notice.
+#
+# This makefile is purposefully kept simple to support GNU and BSD make.
+
+EXAMPLE_NAME = cds_lflist_delete_rcu
+
+SOURCES = $(EXAMPLE_NAME).c
+OBJECTS = $(EXAMPLE_NAME).o
+BINARY = $(EXAMPLE_NAME)
+LIBS = -lurcu
+
+include ../Makefile.examples.template
diff --git a/doc/examples/rculflist/Makefile.cds_lflist_find_rcu b/doc/examples/rculflist/Makefile.cds_lflist_find_rcu
new file mode 100644
index 0000000..77ad9b4
--- /dev/null
+++ b/doc/examples/rculflist/Makefile.cds_lflist_find_rcu
@@ -0,0 +1,21 @@
+# Copyright (C) 2013  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+#
+# THIS MATERIAL IS PROVIDED AS IS, WITH ABSOLUTELY NO WARRANTY EXPRESSED
+# OR IMPLIED.  ANY USE IS AT YOUR OWN RISK.
+#
+# Permission is hereby granted to use or copy this program for any
+# purpose,  provided the above notices are retained on all copies.
+# Permission to modify the code and to distribute modified code is
+# granted, provided the above notices are retained, and a notice that
+# the code was modified is included with the above copyright notice.
+#
+# This makefile is purposefully kept simple to support GNU and BSD make.
+
+EXAMPLE_NAME = cds_lflist_find_rcu
+
+SOURCES = $(EXAMPLE_NAME).c
+OBJECTS = $(EXAMPLE_NAME).o
+BINARY = $(EXAMPLE_NAME)
+LIBS = -lurcu
+
+include ../Makefile.examples.template
diff --git a/doc/examples/rculflist/Makefile.cds_lflist_insert_rcu b/doc/examples/rculflist/Makefile.cds_lflist_insert_rcu
new file mode 100644
index 0000000..cdde123
--- /dev/null
+++ b/doc/examples/rculflist/Makefile.cds_lflist_insert_rcu
@@ -0,0 +1,21 @@
+# Copyright (C) 2013  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+#
+# THIS MATERIAL IS PROVIDED AS IS, WITH ABSOLUTELY NO WARRANTY EXPRESSED
+# OR IMPLIED.  ANY USE IS AT YOUR OWN RISK.
+#
+# Permission is hereby granted to use or copy this program for any
+# purpose,  provided the above notices are retained on all copies.
+# Permission to modify the code and to distribute modified code is
+# granted, provided the above notices are retained, and a notice that
+# the code was modified is included with the above copyright notice.
+#
+# This makefile is purposefully kept simple to support GNU and BSD make.
+
+EXAMPLE_NAME = cds_lflist_insert_rcu
+
+SOURCES = $(EXAMPLE_NAME).c
+OBJECTS = $(EXAMPLE_NAME).o
+BINARY = $(EXAMPLE_NAME)
+LIBS = -lurcu
+
+include ../Makefile.examples.template
diff --git a/doc/examples/rculflist/cds_lflist_delete_rcu.c b/doc/examples/rculflist/cds_lflist_delete_rcu.c
new file mode 100644
index 0000000..bbfde61
--- /dev/null
+++ b/doc/examples/rculflist/cds_lflist_delete_rcu.c
@@ -0,0 +1,100 @@
+/*
+ * Copyright (C) 2019 Junchang Wang
+ *
+ * THIS MATERIAL IS PROVIDED AS IS, WITH ABSOLUTELY NO WARRANTY EXPRESSED
+ * OR IMPLIED.  ANY USE IS AT YOUR OWN RISK.
+ *
+ * Permission is hereby granted to use or copy this program for any
+ * purpose,  provided the above notices are retained on all copies.
+ * Permission to modify the code and to distribute modified code is
+ * granted, provided the above notices are retained, and a notice that
+ * the code was modified is included with the above copyright notice.
+ *
+ * This example shows how to delete a node from a linked-list safely against
+ * concurrent RCU traversals.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+
+#include <urcu/urcu-memb.h>	/* RCU flavor */
+#include <urcu/rculflist.h>	/* RCU lock-free linked list */
+#include <urcu/compiler.h>	/* For CAA_ARRAY_SIZE */
+
+static void free_node(struct rcu_head *head)
+{
+        struct cds_lflist_node *node =
+                caa_container_of(head, struct cds_lflist_node, rcu_head);
+
+        free(node);
+}
+
+int main(int argc, char **argv)
+{
+	int values[] = { -5, 42, 36, 24, };
+	struct cds_lflist_node * nodes[CAA_ARRAY_SIZE(values)];
+
+	struct cds_lflist_rcu mylist;	/* List */
+	unsigned int i;
+	int ret = 0;
+
+	/*
+	 * Each thread using RCU read-side needs to be explicitly
+	 * registered.
+	 */
+	urcu_memb_register_thread();
+
+	cds_lflist_init_rcu(&mylist, NULL);
+
+	/*
+	 * Insert nodes.
+	 */
+	printf("Insert content:");
+	for (i = 0; i < CAA_ARRAY_SIZE(values); i++) {
+		struct cds_lflist_node *node;
+
+		node = malloc(sizeof(*node));
+		if (!node) {
+			ret = -1;
+			goto end;
+		}
+
+		nodes[i] = node;
+		cds_lflist_node_init_rcu(node);
+		cds_lflist_node_set_key(node, values[i]);
+		/*
+		 * Both insert and delete need to be called within RCU
+		 * read-side critical section.
+		 */
+		urcu_memb_read_lock();
+		cds_lflist_insert_rcu(&mylist, node);
+		urcu_memb_read_unlock();
+		printf(" %ld", node->key);
+	}
+	printf("\n");
+
+	/*
+	 * Delete each node from the queue.
+	 */
+	printf("Delete content:");
+	for (i = 0; i < CAA_ARRAY_SIZE(values); i++) {
+		struct cds_lflist_node *node = nodes[i];
+
+		/*
+		 * Both insert and delete need to be called within RCU
+		 * read-side critical section.
+		 */
+		urcu_memb_read_lock();
+		assert(cds_lflist_delete_rcu(&mylist, node->key));
+		urcu_memb_read_unlock();
+
+		printf(" %ld", node->key);
+		urcu_memb_call_rcu(&node->rcu_head, free_node);
+	}
+	printf("\n");
+
+end:
+	urcu_memb_unregister_thread();
+	return ret;
+}
+
diff --git a/doc/examples/rculflist/cds_lflist_find_rcu.c b/doc/examples/rculflist/cds_lflist_find_rcu.c
new file mode 100644
index 0000000..b47c37f
--- /dev/null
+++ b/doc/examples/rculflist/cds_lflist_find_rcu.c
@@ -0,0 +1,96 @@
+/*
+ * Copyright (C) 2019 Junchang Wang
+ *
+ * THIS MATERIAL IS PROVIDED AS IS, WITH ABSOLUTELY NO WARRANTY EXPRESSED
+ * OR IMPLIED.  ANY USE IS AT YOUR OWN RISK.
+ *
+ * Permission is hereby granted to use or copy this program for any
+ * purpose,  provided the above notices are retained on all copies.
+ * Permission to modify the code and to distribute modified code is
+ * granted, provided the above notices are retained, and a notice that
+ * the code was modified is included with the above copyright notice.
+ *
+ * This example shows how to safely search a key in the linked list.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+
+#include <urcu/urcu-memb.h>	/* RCU flavor */
+#include <urcu/rculflist.h>	/* RCU lock-free linked list */
+#include <urcu/compiler.h>	/* For CAA_ARRAY_SIZE */
+
+int main(int argc, char **argv)
+{
+	int values[] = { -5, 42, 36, 24, };
+	struct cds_lflist_node * nodes[CAA_ARRAY_SIZE(values)];
+
+	struct cds_lflist_rcu mylist;	/* List */
+	unsigned int i;
+	int ret = 0;
+
+	/*
+	 * Each thread using RCU read-side need to be explicitly
+	 * registered.
+	 */
+	urcu_memb_register_thread();
+
+	cds_lflist_init_rcu(&mylist, NULL);
+
+	/*
+	 * Insert nodes.
+	 */
+	printf("Insert content:");
+	for (i = 0; i < CAA_ARRAY_SIZE(values); i++) {
+		struct cds_lflist_node *node;
+
+		node = malloc(sizeof(*node));
+		if (!node) {
+			ret = -1;
+			goto end;
+		}
+
+		nodes[i] = node;
+		cds_lflist_node_init_rcu(node);
+		cds_lflist_node_set_key(node, values[i]);
+		/*
+		 * Both insert and delete need to be called within RCU
+		 * read-side critical section.
+		 */
+		urcu_memb_read_lock();
+		cds_lflist_insert_rcu(&mylist, node);
+		urcu_memb_read_unlock();
+		printf(" %ld", node->key);
+	}
+	printf("\n");
+
+	/*
+	 * Search each node from the queue.
+	 */
+	struct cds_lflist_snapshot ss;
+	long invalid_key = 0;
+	for (i = 0; i < CAA_ARRAY_SIZE(values); i++) {
+		struct cds_lflist_node *node = nodes[i];
+
+		/*
+		 * Function find needs to be called within RCU
+		 * read-side critical section.
+		 */
+		urcu_memb_read_lock();
+		assert(cds_lflist_find_rcu(&mylist, node->key, &ss));
+		urcu_memb_read_unlock();
+
+		invalid_key += node->key;
+		printf("Find content: %ld\n", node->key);
+	}
+
+	urcu_memb_read_lock();
+	assert( !cds_lflist_find_rcu(&mylist, invalid_key, &ss) );
+	urcu_memb_read_unlock();
+	printf("Can't find content: %ld\n", invalid_key);
+
+end:
+	urcu_memb_unregister_thread();
+	return ret;
+}
+
diff --git a/doc/examples/rculflist/cds_lflist_insert_rcu.c b/doc/examples/rculflist/cds_lflist_insert_rcu.c
new file mode 100644
index 0000000..8d8129c
--- /dev/null
+++ b/doc/examples/rculflist/cds_lflist_insert_rcu.c
@@ -0,0 +1,66 @@
+/*
+ * Copyright (C) 2019 Junchang Wang
+ *
+ * THIS MATERIAL IS PROVIDED AS IS, WITH ABSOLUTELY NO WARRANTY EXPRESSED
+ * OR IMPLIED.  ANY USE IS AT YOUR OWN RISK.
+ *
+ * Permission is hereby granted to use or copy this program for any
+ * purpose,  provided the above notices are retained on all copies.
+ * Permission to modify the code and to distribute modified code is
+ * granted, provided the above notices are retained, and a notice that
+ * the code was modified is included with the above copyright notice.
+ *
+ * This example shows how to add into a linked-list safely against
+ * concurrent RCU traversals.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+
+#include <urcu/urcu-memb.h>	/* RCU flavor */
+#include <urcu/rculflist.h>	/* RCU lock-free linked list */
+#include <urcu/compiler.h>	/* For CAA_ARRAY_SIZE */
+
+int main(int argc, char **argv)
+{
+	int values[] = { -5, 42, 36, 24, };
+	struct cds_lflist_rcu mylist;	/* List */
+	unsigned int i;
+	int ret = 0;
+
+	/*
+	 * Each thread using RCU read-side needs to be explicitly
+	 * registered.
+	 */
+	urcu_memb_register_thread();
+
+	cds_lflist_init_rcu(&mylist, NULL);
+
+	/*
+	 * Enqueue nodes.
+	 */
+	for (i = 0; i < CAA_ARRAY_SIZE(values); i++) {
+		struct cds_lflist_node *node;
+
+		node = malloc(sizeof(*node));
+		if (!node) {
+			ret = -1;
+			goto end;
+		}
+
+		cds_lflist_node_init_rcu(node);
+		cds_lflist_node_set_key(node, values[i]);
+		/*
+		 * Both insert and delete need to be called within RCU
+		 * read-side critical section.
+		 */
+		urcu_memb_read_lock();
+		cds_lflist_insert_rcu(&mylist, node);
+		urcu_memb_read_unlock();
+	}
+
+end:
+	urcu_memb_unregister_thread();
+	return ret;
+}
+
-- 
2.7.4
