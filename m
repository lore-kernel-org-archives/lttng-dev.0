From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH lttng-tools] Change wfq usages for wfcq
Date: Sat, 26 Jul 2014 01:26:56 -0400
Message-ID: <1406352416-11364-1-git-send-email-simon.marchi__31085.9136320234$1406352481$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.electronicbox.net ([96.127.255.82])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <simon.marchi@polymtl.ca>) id 1XAuVq-0002DN-2b
 for lttng-dev@lists.lttng.org; Sat, 26 Jul 2014 01:27:24 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This removes the deprecated warnings when building lttng-tools. We can
now build with -Werror, woohoo!

Verified by running make check.
---
 configure.ac                            |  8 ++++----
 src/bin/lttng-relayd/connection.h       |  4 ++--
 src/bin/lttng-relayd/live.c             | 12 +++++++-----
 src/bin/lttng-relayd/lttng-relayd.h     |  5 +++--
 src/bin/lttng-relayd/main.c             | 12 +++++++-----
 src/bin/lttng-sessiond/lttng-sessiond.h |  7 ++++---
 src/bin/lttng-sessiond/main.c           | 10 +++++-----
 7 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/configure.ac b/configure.ac
index a6f5b0b..3d59a20 100644
--- a/configure.ac
+++ b/configure.ac
@@ -177,11 +177,11 @@ liburcu_version=">= 0.7.2"
 AC_CHECK_DECL([cds_list_add], [],
 	[AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu/list.h>]]
 )
-AC_CHECK_DECL([cds_wfq_init], [],
-	[AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu/wfqueue.h>]]
+AC_CHECK_DECL([cds_wfcq_init], [],
+	[AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu/wfcqueue.h>]]
 )
-AC_CHECK_DECL([cds_wfq_dequeue_blocking], [],
-    [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu/wfqueue.h>]]
+AC_CHECK_DECL([cds_wfcq_dequeue_blocking], [],
+    [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu/wfcqueue.h>]]
 )
 AC_CHECK_DECL([futex_async], [],
 	[AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu/futex.h>]]
diff --git a/src/bin/lttng-relayd/connection.h b/src/bin/lttng-relayd/connection.h
index fc4a590..70fe4ba 100644
--- a/src/bin/lttng-relayd/connection.h
+++ b/src/bin/lttng-relayd/connection.h
@@ -23,7 +23,7 @@
 #include <inttypes.h>
 #include <pthread.h>
 #include <urcu.h>
-#include <urcu/wfqueue.h>
+#include <urcu/wfcqueue.h>
 #include <urcu/list.h>
 
 #include <common/hashtable/hashtable.h>
@@ -46,7 +46,7 @@ struct relay_connection {
 	struct lttcomm_sock *sock;
 	struct relay_session *session;
 	struct relay_viewer_session *viewer_session;
-	struct cds_wfq_node qnode;
+	struct cds_wfcq_node qnode;
 	struct lttng_ht_node_ulong sock_n;
 	struct rcu_head rcu_node;
 	enum connection_type type;
diff --git a/src/bin/lttng-relayd/live.c b/src/bin/lttng-relayd/live.c
index 8c716db..5684608 100644
--- a/src/bin/lttng-relayd/live.c
+++ b/src/bin/lttng-relayd/live.c
@@ -558,11 +558,12 @@ restart:
 				new_conn->sock = newsock;
 
 				/* Enqueue request for the dispatcher thread. */
-				cds_wfq_enqueue(&viewer_conn_queue.queue, &new_conn->qnode);
+				cds_wfcq_enqueue(&viewer_conn_queue.head, &viewer_conn_queue.tail,
+						 &new_conn->qnode);
 
 				/*
 				 * Wake the dispatch queue futex. Implicit memory barrier with
-				 * the exchange in cds_wfq_enqueue.
+				 * the exchange in cds_wfcq_enqueue.
 				 */
 				futex_nto1_wake(&viewer_conn_queue.futex);
 			}
@@ -601,7 +602,7 @@ void *thread_dispatcher(void *data)
 {
 	int err = -1;
 	ssize_t ret;
-	struct cds_wfq_node *node;
+	struct cds_wfcq_node *node;
 	struct relay_connection *conn = NULL;
 
 	DBG("[thread] Live viewer relay dispatcher started");
@@ -624,7 +625,8 @@ void *thread_dispatcher(void *data)
 			health_code_update();
 
 			/* Dequeue commands */
-			node = cds_wfq_dequeue_blocking(&viewer_conn_queue.queue);
+			node = cds_wfcq_dequeue_blocking(&viewer_conn_queue.head,
+							 &viewer_conn_queue.tail);
 			if (node == NULL) {
 				DBG("Woken up but nothing in the live-viewer "
 						"relay command queue");
@@ -2113,7 +2115,7 @@ int live_start_threads(struct lttng_uri *uri,
 	}
 
 	/* Init relay command queue. */
-	cds_wfq_init(&viewer_conn_queue.queue);
+	cds_wfcq_init(&viewer_conn_queue.head, &viewer_conn_queue.tail);
 
 	/* Set up max poll set size */
 	lttng_poll_set_max_size();
diff --git a/src/bin/lttng-relayd/lttng-relayd.h b/src/bin/lttng-relayd/lttng-relayd.h
index 55ce25e..896925f 100644
--- a/src/bin/lttng-relayd/lttng-relayd.h
+++ b/src/bin/lttng-relayd/lttng-relayd.h
@@ -22,7 +22,7 @@
 #define _LGPL_SOURCE
 #include <limits.h>
 #include <urcu.h>
-#include <urcu/wfqueue.h>
+#include <urcu/wfcqueue.h>
 
 #include <common/hashtable/hashtable.h>
 
@@ -30,7 +30,8 @@
  * Queue used to enqueue relay requests
  */
 struct relay_conn_queue {
-	struct cds_wfq_queue queue;
+	struct cds_wfcq_head head;
+	struct cds_wfcq_tail tail;
 	int32_t futex;
 };
 
diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index 3a6beba..a3b8016 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -882,11 +882,12 @@ restart:
 				new_conn->sock = newsock;
 
 				/* Enqueue request for the dispatcher thread. */
-				cds_wfq_enqueue(&relay_conn_queue.queue, &new_conn->qnode);
+				cds_wfcq_enqueue(&relay_conn_queue.head, &relay_conn_queue.tail,
+						 &new_conn->qnode);
 
 				/*
 				 * Wake the dispatch queue futex. Implicit memory barrier with
-				 * the exchange in cds_wfq_enqueue.
+				 * the exchange in cds_wfcq_enqueue.
 				 */
 				futex_nto1_wake(&relay_conn_queue.futex);
 			}
@@ -933,7 +934,7 @@ void *relay_thread_dispatcher(void *data)
 {
 	int err = -1;
 	ssize_t ret;
-	struct cds_wfq_node *node;
+	struct cds_wfcq_node *node;
 	struct relay_connection *new_conn = NULL;
 
 	DBG("[thread] Relay dispatcher started");
@@ -956,7 +957,8 @@ void *relay_thread_dispatcher(void *data)
 			health_code_update();
 
 			/* Dequeue commands */
-			node = cds_wfq_dequeue_blocking(&relay_conn_queue.queue);
+			node = cds_wfcq_dequeue_blocking(&relay_conn_queue.head,
+							 &relay_conn_queue.tail);
 			if (node == NULL) {
 				DBG("Woken up but nothing in the relay command queue");
 				/* Continue thread execution */
@@ -2762,7 +2764,7 @@ int main(int argc, char **argv)
 	}
 
 	/* Init relay command queue. */
-	cds_wfq_init(&relay_conn_queue.queue);
+	cds_wfcq_init(&relay_conn_queue.head, &relay_conn_queue.tail);
 
 	/* Set up max poll set size */
 	lttng_poll_set_max_size();
diff --git a/src/bin/lttng-sessiond/lttng-sessiond.h b/src/bin/lttng-sessiond/lttng-sessiond.h
index 0f4c668..f3fb750 100644
--- a/src/bin/lttng-sessiond/lttng-sessiond.h
+++ b/src/bin/lttng-sessiond/lttng-sessiond.h
@@ -21,7 +21,7 @@
 
 #define _LGPL_SOURCE
 #include <urcu.h>
-#include <urcu/wfqueue.h>
+#include <urcu/wfcqueue.h>
 
 #include <common/sessiond-comm/sessiond-comm.h>
 #include <common/compat/poll.h>
@@ -55,7 +55,7 @@ struct command_ctx {
 struct ust_command {
 	int sock;
 	struct ust_register_msg reg_msg;
-	struct cds_wfq_node node;
+	struct cds_wfcq_node node;
 };
 
 /*
@@ -64,7 +64,8 @@ struct ust_command {
  */
 struct ust_cmd_queue {
 	int32_t futex;
-	struct cds_wfq_queue queue;
+	struct cds_wfcq_head head;
+	struct cds_wfcq_tail tail;
 };
 
 /*
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index a8751c6..2e53b0a 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -1685,7 +1685,7 @@ error_create:
 static void *thread_dispatch_ust_registration(void *data)
 {
 	int ret, err = -1;
-	struct cds_wfq_node *node;
+	struct cds_wfcq_node *node;
 	struct ust_command *ust_cmd = NULL;
 	struct ust_reg_wait_node *wait_node = NULL, *tmp_wait_node;
 	struct ust_reg_wait_queue wait_queue = {
@@ -1723,7 +1723,7 @@ static void *thread_dispatch_ust_registration(void *data)
 
 			health_code_update();
 			/* Dequeue command for registration */
-			node = cds_wfq_dequeue_blocking(&ust_cmd_queue.queue);
+			node = cds_wfcq_dequeue_blocking(&ust_cmd_queue.head, &ust_cmd_queue.tail);
 			if (node == NULL) {
 				DBG("Woken up but nothing in the UST command queue");
 				/* Continue thread execution */
@@ -2077,11 +2077,11 @@ static void *thread_registration_apps(void *data)
 					 * Lock free enqueue the registration request. The red pill
 					 * has been taken! This apps will be part of the *system*.
 					 */
-					cds_wfq_enqueue(&ust_cmd_queue.queue, &ust_cmd->node);
+					cds_wfcq_enqueue(&ust_cmd_queue.head, &ust_cmd_queue.tail, &ust_cmd->node);
 
 					/*
 					 * Wake the registration queue futex. Implicit memory
-					 * barrier with the exchange in cds_wfq_enqueue.
+					 * barrier with the exchange in cds_wfcq_enqueue.
 					 */
 					futex_nto1_wake(&ust_cmd_queue.futex);
 				}
@@ -5256,7 +5256,7 @@ int main(int argc, char **argv)
 	buffer_reg_init_pid_registry();
 
 	/* Init UST command queue. */
-	cds_wfq_init(&ust_cmd_queue.queue);
+	cds_wfcq_init(&ust_cmd_queue.head, &ust_cmd_queue.tail);
 
 	/*
 	 * Get session list pointer. This pointer MUST NOT be free(). This list is
-- 
2.0.0
