From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 3/6] Fix: compat poll: add missing
	empty revents checks
Date: Mon,  5 Jan 2015 16:43:05 -0500
Message-ID: <1420494188-20782-3-git-send-email-mathieu.desnoyers__27712.5477012762$1420494399$gmane$org@efficios.com>
References: <1420494188-20782-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y8FQt-0005cZ-Fa
 for lttng-dev@lists.lttng.org; Mon, 05 Jan 2015 16:43:29 -0500
In-Reply-To: <1420494188-20782-1-git-send-email-mathieu.desnoyers@efficios.com>
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

Poll returns the entire array, including entries that have no activity.
We need to check them explicitly.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-consumerd/health-consumerd.c |  5 +++
 src/bin/lttng-relayd/health-relayd.c       |  5 +++
 src/bin/lttng-relayd/live.c                | 10 +++++
 src/bin/lttng-relayd/main.c                | 71 ++++++++++++++++++------------
 src/bin/lttng-sessiond/agent-thread.c      |  5 +++
 src/bin/lttng-sessiond/ht-cleanup.c        | 10 +++++
 src/bin/lttng-sessiond/main.c              | 40 +++++++++++++++++
 src/bin/lttng-sessiond/ust-thread.c        |  5 +++
 src/common/consumer.c                      |  8 +++-
 9 files changed, 129 insertions(+), 30 deletions(-)

diff --git a/src/bin/lttng-consumerd/health-consumerd.c b/src/bin/lttng-consumerd/health-consumerd.c
index bd47f0c..fc9a266 100644
--- a/src/bin/lttng-consumerd/health-consumerd.c
+++ b/src/bin/lttng-consumerd/health-consumerd.c
@@ -261,6 +261,11 @@ restart:
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
+			if (!revents) {
+				/* No activity for this FD (poll implementation). */
+				continue;
+			}
+
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = check_health_quit_pipe(pollfd, revents);
 			if (ret) {
diff --git a/src/bin/lttng-relayd/health-relayd.c b/src/bin/lttng-relayd/health-relayd.c
index af375e2..75149ba 100644
--- a/src/bin/lttng-relayd/health-relayd.c
+++ b/src/bin/lttng-relayd/health-relayd.c
@@ -330,6 +330,11 @@ restart:
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
+			if (!revents) {
+				/* No activity for this FD (poll implementation). */
+				continue;
+			}
+
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = check_health_quit_pipe(pollfd, revents);
 			if (ret) {
diff --git a/src/bin/lttng-relayd/live.c b/src/bin/lttng-relayd/live.c
index fd570e0..756efbe 100644
--- a/src/bin/lttng-relayd/live.c
+++ b/src/bin/lttng-relayd/live.c
@@ -488,6 +488,11 @@ restart:
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
+			if (!revents) {
+				/* No activity for this FD (poll implementation). */
+				continue;
+			}
+
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = check_thread_quit_pipe(pollfd, revents);
 			if (ret) {
@@ -1922,6 +1927,11 @@ restart:
 
 			health_code_update();
 
+			if (!revents) {
+				/* No activity for this FD (poll implementation). */
+				continue;
+			}
+
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = check_thread_quit_pipe(pollfd, revents);
 			if (ret) {
diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index 1ec1eea..94bb4cb 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -868,6 +868,11 @@ restart:
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
+			if (!revents) {
+				/* No activity for this FD (poll implementation). */
+				continue;
+			}
+
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = check_thread_quit_pipe(pollfd, revents);
 			if (ret) {
@@ -2536,6 +2541,11 @@ restart:
 
 			health_code_update();
 
+			if (!revents) {
+				/* No activity for this FD (poll implementation). */
+				continue;
+			}
+
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = check_thread_quit_pipe(pollfd, revents);
 			if (ret) {
@@ -2638,46 +2648,49 @@ restart:
 
 			health_code_update();
 
+			if (!revents) {
+				/* No activity for this FD (poll implementation). */
+				continue;
+			}
+
 			/* Skip the command pipe. It's handled in the first loop. */
 			if (pollfd == relay_conn_pipe[0]) {
 				continue;
 			}
 
-			if (revents) {
-				rcu_read_lock();
-				conn = connection_find_by_sock(relay_connections_ht, pollfd);
-				if (!conn) {
-					/* Skip it. Might be removed before. */
+			rcu_read_lock();
+			conn = connection_find_by_sock(relay_connections_ht, pollfd);
+			if (!conn) {
+				/* Skip it. Might be removed before. */
+				rcu_read_unlock();
+				continue;
+			}
+
+			if (revents & LPOLLIN) {
+				if (conn->type != RELAY_DATA) {
 					rcu_read_unlock();
 					continue;
 				}
 
-				if (revents & LPOLLIN) {
-					if (conn->type != RELAY_DATA) {
-						rcu_read_unlock();
-						continue;
-					}
-
-					ret = relay_process_data(conn);
-					/* Connection closed */
-					if (ret < 0) {
-						cleanup_connection_pollfd(&events, pollfd);
-						destroy_connection(relay_connections_ht, conn);
-						DBG("Data connection closed with %d", pollfd);
-						/*
-						 * Every goto restart call sets the last seen fd where
-						 * here we don't really care since we gracefully
-						 * continue the loop after the connection is deleted.
-						 */
-					} else {
-						/* Keep last seen port. */
-						last_seen_data_fd = pollfd;
-						rcu_read_unlock();
-						goto restart;
-					}
+				ret = relay_process_data(conn);
+				/* Connection closed */
+				if (ret < 0) {
+					cleanup_connection_pollfd(&events, pollfd);
+					destroy_connection(relay_connections_ht, conn);
+					DBG("Data connection closed with %d", pollfd);
+					/*
+					 * Every goto restart call sets the last seen fd where
+					 * here we don't really care since we gracefully
+					 * continue the loop after the connection is deleted.
+					 */
+				} else {
+					/* Keep last seen port. */
+					last_seen_data_fd = pollfd;
+					rcu_read_unlock();
+					goto restart;
 				}
-				rcu_read_unlock();
 			}
+			rcu_read_unlock();
 		}
 		last_seen_data_fd = -1;
 	}
diff --git a/src/bin/lttng-sessiond/agent-thread.c b/src/bin/lttng-sessiond/agent-thread.c
index d7d9c6c..a9cc6e7 100644
--- a/src/bin/lttng-sessiond/agent-thread.c
+++ b/src/bin/lttng-sessiond/agent-thread.c
@@ -330,6 +330,11 @@ restart:
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
+			if (!revents) {
+				/* No activity for this FD (poll implementation). */
+				continue;
+			}
+
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = sessiond_check_thread_quit_pipe(pollfd, revents);
 			if (ret) {
diff --git a/src/bin/lttng-sessiond/ht-cleanup.c b/src/bin/lttng-sessiond/ht-cleanup.c
index ace41e5..373c913 100644
--- a/src/bin/lttng-sessiond/ht-cleanup.c
+++ b/src/bin/lttng-sessiond/ht-cleanup.c
@@ -96,6 +96,11 @@ restart:
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
+			if (!revents) {
+				/* No activity for this FD (poll implementation). */
+				continue;
+			}
+
 			if (pollfd != ht_cleanup_pipe[0]) {
 				continue;
 			}
@@ -140,6 +145,11 @@ restart:
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
+			if (!revents) {
+				/* No activity for this FD (poll implementation). */
+				continue;
+			}
+
 			if (pollfd == ht_cleanup_pipe[0]) {
 				continue;
 			}
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index f418d74..2649b55 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -1090,6 +1090,11 @@ static void *thread_manage_kernel(void *data)
 
 			health_code_update();
 
+			if (!revents) {
+				/* No activity for this FD (poll implementation). */
+				continue;
+			}
+
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = sessiond_check_thread_quit_pipe(pollfd, revents);
 			if (ret) {
@@ -1235,6 +1240,11 @@ restart:
 
 		health_code_update();
 
+		if (!revents) {
+			/* No activity for this FD (poll implementation). */
+			continue;
+		}
+
 		/* Thread quit pipe has been closed. Killing thread. */
 		ret = sessiond_check_thread_quit_pipe(pollfd, revents);
 		if (ret) {
@@ -1362,6 +1372,11 @@ restart_poll:
 
 			health_code_update();
 
+			if (!revents) {
+				/* No activity for this FD (poll implementation). */
+				continue;
+			}
+
 			/*
 			 * Thread quit pipe has been triggered, flag that we should stop
 			 * but continue the current loop to handle potential data from
@@ -1538,6 +1553,11 @@ static void *thread_manage_apps(void *data)
 
 			health_code_update();
 
+			if (!revents) {
+				/* No activity for this FD (poll implementation). */
+				continue;
+			}
+
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = sessiond_check_thread_quit_pipe(pollfd, revents);
 			if (ret) {
@@ -1716,6 +1736,11 @@ static void sanitize_wait_queue(struct ust_reg_wait_queue *wait_queue)
 		uint32_t revents = LTTNG_POLL_GETEV(&events, i);
 		int pollfd = LTTNG_POLL_GETFD(&events, i);
 
+		if (!revents) {
+			/* No activity for this FD (poll implementation). */
+			continue;
+		}
+
 		cds_list_for_each_entry_safe(wait_node, tmp_wait_node,
 				&wait_queue->head, head) {
 			if (pollfd == wait_node->app->sock &&
@@ -2055,6 +2080,11 @@ static void *thread_registration_apps(void *data)
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
+			if (!revents) {
+				/* No activity for this FD (poll implementation). */
+				continue;
+			}
+
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = sessiond_check_thread_quit_pipe(pollfd, revents);
 			if (ret) {
@@ -3918,6 +3948,11 @@ restart:
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
+			if (!revents) {
+				/* No activity for this FD (poll implementation). */
+				continue;
+			}
+
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = sessiond_check_thread_quit_pipe(pollfd, revents);
 			if (ret) {
@@ -4090,6 +4125,11 @@ static void *thread_manage_clients(void *data)
 
 			health_code_update();
 
+			if (!revents) {
+				/* No activity for this FD (poll implementation). */
+				continue;
+			}
+
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = sessiond_check_thread_quit_pipe(pollfd, revents);
 			if (ret) {
diff --git a/src/bin/lttng-sessiond/ust-thread.c b/src/bin/lttng-sessiond/ust-thread.c
index d92c1f9..6f4295d 100644
--- a/src/bin/lttng-sessiond/ust-thread.c
+++ b/src/bin/lttng-sessiond/ust-thread.c
@@ -92,6 +92,11 @@ restart:
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
+			if (!revents) {
+				/* No activity for this FD (poll implementation). */
+				continue;
+			}
+
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = sessiond_check_thread_quit_pipe(pollfd, revents);
 			if (ret) {
diff --git a/src/common/consumer.c b/src/common/consumer.c
index 3f72af3..1ece1d5 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -2212,6 +2212,11 @@ restart:
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
+			if (!revents) {
+				/* No activity for this FD (poll implementation). */
+				continue;
+			}
+
 			if (pollfd == lttng_pipe_get_readfd(ctx->consumer_metadata_pipe)) {
 				if (revents & (LPOLLERR | LPOLLHUP )) {
 					DBG("Metadata thread pipe hung up");
@@ -2782,10 +2787,11 @@ restart:
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
-			/* Just don't waste time if no returned events for the fd */
 			if (!revents) {
+				/* No activity for this FD (poll implementation). */
 				continue;
 			}
+
 			if (pollfd == ctx->consumer_channel_pipe[0]) {
 				if (revents & (LPOLLERR | LPOLLHUP)) {
 					DBG("Channel thread pipe hung up");
-- 
2.1.1
