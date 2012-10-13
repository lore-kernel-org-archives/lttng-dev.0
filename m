From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: [PATCH 3/4] test: test for the proper pointer
Date: Sun, 14 Oct 2012 00:08:33 +0800
Message-ID: <1350144514-4132-3-git-send-email-laijs__564.786283257668$1350144571$gmane$org@cn.fujitsu.com>
References: <1350144514-4132-1-git-send-email-laijs@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1TN4Go-0006Yf-Qm
	for lttng-dev@lists.lttng.org; Sat, 13 Oct 2012 12:08:59 -0400
In-Reply-To: <1350144514-4132-1-git-send-email-laijs@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev@lists.lttng.org, Lai Jiangshan <eag0628@gmail.com>
List-Id: lttng-dev@lists.lttng.org

We should use "if (qnode)" instead of "if (node)" in case of
the struct cds_lfq_node_rcu is not the first field of struct node.

Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
---
 tests/test_urcu_lfq.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/test_urcu_lfq.c b/tests/test_urcu_lfq.c
index 66ddd41..0fcbf55 100644
--- a/tests/test_urcu_lfq.c
+++ b/tests/test_urcu_lfq.c
@@ -243,14 +243,15 @@ void *thr_dequeuer(void *_count)
 
 	for (;;) {
 		struct cds_lfq_node_rcu *qnode;
-		struct test *node;
 
 		rcu_read_lock();
 		qnode = cds_lfq_dequeue_rcu(&q);
-		node = caa_container_of(qnode, struct test, list);
 		rcu_read_unlock();
 
-		if (node) {
+		if (qnode) {
+			struct test *node;
+
+			node = caa_container_of(qnode, struct test, list);
 			call_rcu(&node->rcu, free_node_cb);
 			URCU_TLS(nr_successful_dequeues)++;
 		}
-- 
1.7.7.6
