From: Junchang Wang <junchangwang@gmail.com>
Subject: [PATCH v2 2/4] userspace-rcu: Add sample code of
 rculflist
Date: Mon, 29 Jul 2019 21:35:29 +0800
Message-ID: <1564407331-25820-3-git-send-email-junchangwang__2630.67601933784$1564407470$gmane$org@gmail.com>
References: <1564407331-25820-1-git-send-email-junchangwang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 by lists.lttng.org (Postfix) with ESMTPS id 45y11q5bx8z17yj
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 09:36:47 -0400 (EDT)
Received: by mail-pg1-x541.google.com with SMTP id l21so28285592pgm.3
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 06:36:47 -0700 (PDT)
In-Reply-To: <1564407331-25820-1-git-send-email-junchangwang@gmail.com>
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
 doc/examples/rculflist/Makefile                    |  24 +++++
 .../rculflist/Makefile.cds_lflist_delete_rcu       |  21 +++++
 .../rculflist/Makefile.cds_lflist_find_rcu         |  21 +++++
 .../rculflist/Makefile.cds_lflist_insert_rcu       |  21 +++++
 doc/examples/rculflist/cds_lflist_delete_rcu.c     | 101 +++++++++++++++++++++
 doc/examples/rculflist/cds_lflist_find_rcu.c       |  96 ++++++++++++++++++++
 doc/examples/rculflist/cds_lflist_insert_rcu.c     |  69 ++++++++++++++
 7 files changed, 353 insertions(+)
 create mode 100644 doc/examples/rculflist/Makefile
 create mode 100644 doc/examples/rculflist/Makefile.cds_lflist_delete_rcu
 create mode 100644 doc/examples/rculflist/Makefile.cds_lflist_find_rcu
 create mode 100644 doc/examples/rculflist/Makefile.cds_lflist_insert_rcu
 create mode 100644 doc/examples/rculflist/cds_lflist_delete_rcu.c
 create mode 100644 doc/examples/rculflist/cds_lflist_find_rcu.c
 create mode 100644 doc/examples/rculflist/cds_lflist_insert_rcu.c

diff --git a/doc/examples/rculflist/Makefile b/doc/examples/rculflist/Makefile
new file mode 100644
index 0000000..b804b13
--- /dev/null
+++ b/doc/examples/rculflist/Makefile
@@ -0,0 +1,24 @@
+# Copyright (C) 2013  Junchang Wang <junchangwang@gmail.com>
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
+all:
+	$(AM_V_at)$(MAKE) -f Makefile.cds_lflist_insert_rcu
+	$(AM_V_at)$(MAKE) -f Makefile.cds_lflist_delete_rcu
+	$(AM_V_at)$(MAKE) -f Makefile.cds_lflist_find_rcu
+
+.PHONY: clean
+clean:
+	$(AM_V_at)$(MAKE) -f Makefile.cds_lflist_insert_rcu clean
+	$(AM_V_at)$(MAKE) -f Makefile.cds_lflist_delete_rcu clean
+	$(AM_V_at)$(MAKE) -f Makefile.cds_lflist_find_rcu clean
+
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
index 0000000..d5b1327
--- /dev/null
+++ b/doc/examples/rculflist/cds_lflist_delete_rcu.c
@@ -0,0 +1,101 @@
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
+		assert(!cds_lflist_insert_rcu(&mylist, node));
+		urcu_memb_read_unlock();
+		printf(" %ld", node->key);
+	}
+	printf("\n");
+
+	/*
+	 * Delete each node from the queue.
+	 */
+	printf("Delete content:");
+	struct cds_lflist_snapshot ss;
+	for (i = 0; i < CAA_ARRAY_SIZE(values); i++) {
+		struct cds_lflist_node *node = nodes[i];
+
+		/*
+		 * Both insert and delete need to be called within RCU
+		 * read-side critical section.
+		 */
+		urcu_memb_read_lock();
+		assert(!cds_lflist_delete_rcu(&mylist, node->key, &ss));
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
index 0000000..bb465c1
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
+		assert(!cds_lflist_insert_rcu(&mylist, node));
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
+		assert(!cds_lflist_find_rcu(&mylist, node->key, &ss));
+		urcu_memb_read_unlock();
+
+		invalid_key += node->key;
+		printf("Find content: %ld\n", node->key);
+	}
+
+	urcu_memb_read_lock();
+	assert(cds_lflist_find_rcu(&mylist, invalid_key, &ss) == -ENOENT);
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
index 0000000..252a25c
--- /dev/null
+++ b/doc/examples/rculflist/cds_lflist_insert_rcu.c
@@ -0,0 +1,69 @@
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
+		cds_lflist_node_init_rcu(node);
+		cds_lflist_node_set_key(node, values[i]);
+		/*
+		 * Both insert and delete need to be called within RCU
+		 * read-side critical section.
+		 */
+		urcu_memb_read_lock();
+		assert(!cds_lflist_insert_rcu(&mylist, node));
+		urcu_memb_read_unlock();
+		printf(" %ld", node->key);
+	}
+	printf("\n");
+
+end:
+	urcu_memb_unregister_thread();
+	return ret;
+}
+
-- 
1.8.3.1
