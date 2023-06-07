Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E2AC7EE23
	for <lttng-dev@archiver.kernel.org>; Wed,  7 Jun 2023 18:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1686164102;
	bh=J8vYPupDEZfEnlhbpepIr5+3pugSpCOmx5hgwGfYTEA=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=tchPC0ZtZVm5GoXLEFhZYLCW1JHBkV9AUDG0ZWzoHK85Ktrz9EhzUFy4xhGbS+dBD
	 Yy+ENEjHELu9chkbd+ConBeiA7F+2thB1c8gJXYUhX7XzcyTjCp2Fuphb8x3dE31OG
	 0NofOUV+BHh+RzG0psWyzWhVxtLHhl/jhpV2B7DV2c8DY2PkQbokSh9rSR4obrDdl2
	 h2kzQ3HH8KVW5InIeEO4CEzjoT92xmXI5Gmhr0H/p7U9XDIeYI1eAp/wURSr0JPqHQ
	 4t3lzEo3jhAykKgdca6LjlEWefFGdvZzITZGrxadOJLZdkLsf9YMKJ6I2zHd75f8BH
	 rNSir/TDvg6Mg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QbxNk2F4Fz1XRl;
	Wed,  7 Jun 2023 14:55:02 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QbxNY5l4Yz1XRk
 for <lttng-dev@lists.lttng.org>; Wed,  7 Jun 2023 14:54:53 -0400 (EDT)
Received: from laura.hitronhub.home (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QbxNY4M14z179V;
 Wed,  7 Jun 2023 14:54:53 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Wed,  7 Jun 2023 14:53:59 -0400
Message-Id: <20230607185359.8125-13-odion@efficios.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515201718.9809-1-odion@efficios.com>
References: <20230515201718.9809-1-odion@efficios.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH v2 12/12] tests: Add tests for checking race
 conditions
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Cc: Olivier Dion <odion@efficios.com>, Tony Finch <dot@dotat.at>,
 "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

These tests do nothing useful except of stress testing a
single-consumer, multiple-producers program on various data structures.

These tests are only meaningful when compiling liburcu with TSAN.

Change-Id: If22b27ed0fb95bf890947fc4e75f923edb5ada8f
Signed-off-by: Olivier Dion <odion@efficios.com>
---
 tests/unit/test_lfstack.c  |  90 ++++++++++++++++++++++++++++
 tests/unit/test_wfcqueue.c | 119 +++++++++++++++++++++++++++++++++++++
 tests/unit/test_wfqueue.c  |  91 ++++++++++++++++++++++++++++
 tests/unit/test_wfstack.c  |  90 ++++++++++++++++++++++++++++
 4 files changed, 390 insertions(+)
 create mode 100644 tests/unit/test_lfstack.c
 create mode 100644 tests/unit/test_wfcqueue.c
 create mode 100644 tests/unit/test_wfqueue.c
 create mode 100644 tests/unit/test_wfstack.c

diff --git a/tests/unit/test_lfstack.c b/tests/unit/test_lfstack.c
new file mode 100644
index 0000000..a1f99f0
--- /dev/null
+++ b/tests/unit/test_lfstack.c
@@ -0,0 +1,90 @@
+/*
+ * test_lfstack.c
+ *
+ * Userspace RCU library - test wftack race conditions
+ *
+ * Copyright 2023 - Olivier Dion <odion@efficios.com>
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
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#define _LGPL_SOURCE
+
+#include <stdlib.h>
+
+#include <pthread.h>
+
+#include <urcu/lfstack.h>
+
+#include "tap.h"
+
+#define NR_TESTS 1
+#define NR_PRODUCERS 4
+#define LOOP 100
+
+static void async_run(struct cds_lfs_stack *queue)
+{
+	struct cds_lfs_node *node = malloc(sizeof(*node));
+
+	cds_lfs_node_init(node);
+
+	cds_lfs_push(queue, node);
+}
+
+static void *async_loop(void *queue)
+{
+	size_t k = 0;
+
+	while (k < LOOP * NR_PRODUCERS) {
+		free(cds_lfs_pop_blocking(queue));
+		++k;
+	}
+
+	return NULL;
+}
+
+static void *spawn_jobs(void *queue)
+{
+	for (size_t k = 0; k < LOOP; ++k) {
+		async_run(queue);
+	}
+
+	return 0;
+}
+
+int main(void)
+{
+	pthread_t consumer;
+	pthread_t producers[NR_PRODUCERS];
+	struct cds_lfs_stack queue;
+
+	plan_tests(NR_TESTS);
+
+	cds_lfs_init(&queue);
+	pthread_create(&consumer, NULL, async_loop, &queue);
+
+	for (size_t k = 0; k < NR_PRODUCERS; ++k) {
+		pthread_create(&producers[k], NULL, spawn_jobs, &queue);
+	}
+
+	pthread_join(consumer, NULL);
+	for (size_t k = 0; k < NR_PRODUCERS; ++k) {
+		pthread_join(producers[k], NULL);
+	}
+
+	ok1("No race conditions");
+
+	return exit_status();
+}
diff --git a/tests/unit/test_wfcqueue.c b/tests/unit/test_wfcqueue.c
new file mode 100644
index 0000000..338aa07
--- /dev/null
+++ b/tests/unit/test_wfcqueue.c
@@ -0,0 +1,119 @@
+/*
+ * test_wfcqueue.c
+ *
+ * Userspace RCU library - test wfcqueue race conditions
+ *
+ * Copyright 2023 - Olivier Dion <odion@efficios.com>
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
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#define _LGPL_SOURCE
+
+#include <stdlib.h>
+
+#include <pthread.h>
+
+#include <urcu/wfcqueue.h>
+
+#include "tap.h"
+
+#define NR_TESTS 1
+#define NR_PRODUCERS 4
+#define LOOP 100
+
+struct queue {
+	struct cds_wfcq_head head;
+	struct cds_wfcq_tail tail;
+};
+
+static void async_run(struct queue *queue)
+{
+	struct cds_wfcq_node *node = malloc(sizeof(*node));
+
+	cds_wfcq_node_init(node);
+
+	cds_wfcq_enqueue(&queue->head, &queue->tail, node);
+}
+static void do_async_loop(size_t *k, struct queue *queue)
+{
+	struct queue my_queue;
+	enum cds_wfcq_ret state;
+	struct cds_wfcq_node *node, *next;
+
+	cds_wfcq_init(&my_queue.head, &my_queue.tail);
+
+	state = cds_wfcq_splice_blocking(&my_queue.head,
+					&my_queue.tail,
+					&queue->head,
+					&queue->tail);
+
+	if (state == CDS_WFCQ_RET_SRC_EMPTY) {
+		return;
+	}
+
+	__cds_wfcq_for_each_blocking_safe(&my_queue.head,
+					&my_queue.tail,
+					node, next) {
+		free(node);
+		(*k)++;
+	}
+}
+
+static void *async_loop(void *queue)
+{
+	size_t k = 0;
+
+	while (k < LOOP * NR_PRODUCERS) {
+		(void) poll(NULL, 0, 10);
+		do_async_loop(&k, queue);
+	}
+
+	return NULL;
+}
+
+static void *spawn_jobs(void *queue)
+{
+	for (size_t k = 0; k < LOOP; ++k) {
+		async_run(queue);
+	}
+
+	return 0;
+}
+
+int main(void)
+{
+	pthread_t consumer;
+	pthread_t producers[NR_PRODUCERS];
+	struct queue queue;
+
+	plan_tests(NR_TESTS);
+
+	cds_wfcq_init(&queue.head, &queue.tail);
+	pthread_create(&consumer, NULL, async_loop, &queue);
+
+	for (size_t k = 0; k < NR_PRODUCERS; ++k) {
+		pthread_create(&producers[k], NULL, spawn_jobs, &queue);
+	}
+
+	pthread_join(consumer, NULL);
+	for (size_t k = 0; k < NR_PRODUCERS; ++k) {
+		pthread_join(producers[k], NULL);
+	}
+
+	ok1("No race conditions");
+
+	return exit_status();
+}
diff --git a/tests/unit/test_wfqueue.c b/tests/unit/test_wfqueue.c
new file mode 100644
index 0000000..57afaba
--- /dev/null
+++ b/tests/unit/test_wfqueue.c
@@ -0,0 +1,91 @@
+/*
+ * test_wfqueue.c
+ *
+ * Userspace RCU library - test wfqueue race conditions
+ *
+ * Copyright 2023 - Olivier Dion <odion@efficios.com>
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
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#define _LGPL_SOURCE
+
+#include <stdlib.h>
+
+#include <pthread.h>
+
+#define CDS_WFQ_DEPRECATED
+#include <urcu/wfqueue.h>
+
+#include "tap.h"
+
+#define NR_TESTS 1
+#define NR_PRODUCERS 4
+#define LOOP 100
+
+static void async_run(struct cds_wfq_queue *queue)
+{
+	struct cds_wfq_node *node = malloc(sizeof(*node));
+
+	cds_wfq_node_init(node);
+
+	cds_wfq_enqueue(queue, node);
+}
+
+static void *async_loop(void *queue)
+{
+	size_t k = 0;
+
+	while (k < LOOP * NR_PRODUCERS) {
+		free(cds_wfq_dequeue_blocking(queue));
+		++k;
+	}
+
+	return NULL;
+}
+
+static void *spawn_jobs(void *queue)
+{
+	for (size_t k = 0; k < LOOP; ++k) {
+		async_run(queue);
+	}
+
+	return 0;
+}
+
+int main(void)
+{
+	pthread_t consumer;
+	pthread_t producers[NR_PRODUCERS];
+	struct cds_wfq_queue queue;
+
+	plan_tests(NR_TESTS);
+
+	cds_wfq_init(&queue);
+	pthread_create(&consumer, NULL, async_loop, &queue);
+
+	for (size_t k = 0; k < NR_PRODUCERS; ++k) {
+		pthread_create(&producers[k], NULL, spawn_jobs, &queue);
+	}
+
+	pthread_join(consumer, NULL);
+	for (size_t k = 0; k < NR_PRODUCERS; ++k) {
+		pthread_join(producers[k], NULL);
+	}
+
+	ok1("No race conditions");
+
+	return exit_status();
+}
diff --git a/tests/unit/test_wfstack.c b/tests/unit/test_wfstack.c
new file mode 100644
index 0000000..578ae92
--- /dev/null
+++ b/tests/unit/test_wfstack.c
@@ -0,0 +1,90 @@
+/*
+ * test_wfstack.c
+ *
+ * Userspace RCU library - test wftack race conditions
+ *
+ * Copyright 2023 - Olivier Dion <odion@efficios.com>
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
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#define _LGPL_SOURCE
+
+#include <stdlib.h>
+
+#include <pthread.h>
+
+#include <urcu/wfstack.h>
+
+#include "tap.h"
+
+#define NR_TESTS 1
+#define NR_PRODUCERS 4
+#define LOOP 100
+
+static void async_run(struct cds_wfs_stack *queue)
+{
+	struct cds_wfs_node *node = malloc(sizeof(*node));
+
+	cds_wfs_node_init(node);
+
+	cds_wfs_push(queue, node);
+}
+
+static void *async_loop(void *queue)
+{
+	size_t k = 0;
+
+	while (k < LOOP * NR_PRODUCERS) {
+		free(cds_wfs_pop_blocking(queue));
+		++k;
+	}
+
+	return NULL;
+}
+
+static void *spawn_jobs(void *queue)
+{
+	for (size_t k = 0; k < LOOP; ++k) {
+		async_run(queue);
+	}
+
+	return 0;
+}
+
+int main(void)
+{
+	pthread_t consumer;
+	pthread_t producers[NR_PRODUCERS];
+	struct cds_wfs_stack queue;
+
+	plan_tests(NR_TESTS);
+
+	cds_wfs_init(&queue);
+	pthread_create(&consumer, NULL, async_loop, &queue);
+
+	for (size_t k = 0; k < NR_PRODUCERS; ++k) {
+		pthread_create(&producers[k], NULL, spawn_jobs, &queue);
+	}
+
+	pthread_join(consumer, NULL);
+	for (size_t k = 0; k < NR_PRODUCERS; ++k) {
+		pthread_join(producers[k], NULL);
+	}
+
+	ok1("No race conditions");
+
+	return exit_status();
+}
-- 
2.40.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
