From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [PATCH lttng-tools v4 7/8] Clean code base from
 redundant verification
Date: Mon,  1 Apr 2019 13:59:24 -0400
Message-ID: <20190401175925.8512-8-ylamarre__38205.4022558563$1554141729$gmane$org@efficios.com>
References: <20190401175925.8512-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44Y0V45zkfz17ww
 for <lttng-dev@lists.lttng.org>; Mon,  1 Apr 2019 13:59:40 -0400 (EDT)
In-Reply-To: <20190401175925.8512-1-ylamarre@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Remove redundant verification for file descriptors with 0 revents in
code base.

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
 src/bin/lttng-consumerd/health-consumerd.c   |  5 -----
 src/bin/lttng-relayd/health-relayd.c         |  5 -----
 src/bin/lttng-relayd/live.c                  | 10 ----------
 src/bin/lttng-relayd/main.c                  | 16 ----------------
 src/bin/lttng-sessiond/agent-thread.c        |  5 -----
 src/bin/lttng-sessiond/client.c              |  5 -----
 src/bin/lttng-sessiond/dispatch.c            |  5 -----
 src/bin/lttng-sessiond/health.c              |  5 -----
 src/bin/lttng-sessiond/ht-cleanup.c          |  5 -----
 src/bin/lttng-sessiond/manage-apps.c         |  5 -----
 src/bin/lttng-sessiond/manage-consumer.c     | 10 ----------
 src/bin/lttng-sessiond/manage-kernel.c       |  5 -----
 src/bin/lttng-sessiond/notification-thread.c |  3 ---
 src/bin/lttng-sessiond/notify-apps.c         |  5 -----
 src/bin/lttng-sessiond/register.c            |  5 -----
 src/bin/lttng-sessiond/rotation-thread.c     |  4 ----
 src/common/consumer/consumer.c               | 10 ----------
 17 files changed, 108 deletions(-)

diff --git a/src/bin/lttng-consumerd/health-consumerd.c b/src/bin/lttng-consumerd/health-consumerd.c
index 1e2f31e4..7d60e54e 100644
--- a/src/bin/lttng-consumerd/health-consumerd.c
+++ b/src/bin/lttng-consumerd/health-consumerd.c
@@ -259,11 +259,6 @@ restart:
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
-			if (!revents) {
-				/* No activity for this FD (poll implementation). */
-				continue;
-			}
-
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = check_health_quit_pipe(pollfd, revents);
 			if (ret) {
diff --git a/src/bin/lttng-relayd/health-relayd.c b/src/bin/lttng-relayd/health-relayd.c
index ba996621..b782c3e7 100644
--- a/src/bin/lttng-relayd/health-relayd.c
+++ b/src/bin/lttng-relayd/health-relayd.c
@@ -329,11 +329,6 @@ restart:
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
-			if (!revents) {
-				/* No activity for this FD (poll implementation). */
-				continue;
-			}
-
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = check_health_quit_pipe(pollfd, revents);
 			if (ret) {
diff --git a/src/bin/lttng-relayd/live.c b/src/bin/lttng-relayd/live.c
index 9efab8a7..9503ba47 100644
--- a/src/bin/lttng-relayd/live.c
+++ b/src/bin/lttng-relayd/live.c
@@ -543,11 +543,6 @@ restart:
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
-			if (!revents) {
-				/* No activity for this FD (poll implementation). */
-				continue;
-			}
-
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = check_thread_quit_pipe(pollfd, revents);
 			if (ret) {
@@ -2000,11 +1995,6 @@ restart:
 
 			health_code_update();
 
-			if (!revents) {
-				/* No activity for this FD (poll implementation). */
-				continue;
-			}
-
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = check_thread_quit_pipe(pollfd, revents);
 			if (ret) {
diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index e81bdeff..0ee27efc 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -858,14 +858,6 @@ restart:
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
-			if (!revents) {
-				/*
-				 * No activity for this FD (poll
-				 * implementation).
-				 */
-				continue;
-			}
-
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = check_thread_quit_pipe(pollfd, revents);
 			if (ret) {
@@ -3813,14 +3805,6 @@ restart:
 
 			health_code_update();
 
-			if (!revents) {
-				/*
-				 * No activity for this FD (poll
-				 * implementation).
-				 */
-				continue;
-			}
-
 			/* Thread quit pipe has been closed. Killing thread. */
 			ret = check_thread_quit_pipe(pollfd, revents);
 			if (ret) {
diff --git a/src/bin/lttng-sessiond/agent-thread.c b/src/bin/lttng-sessiond/agent-thread.c
index f7be1ef7..575f6aee 100644
--- a/src/bin/lttng-sessiond/agent-thread.c
+++ b/src/bin/lttng-sessiond/agent-thread.c
@@ -404,11 +404,6 @@ restart:
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
-			if (!revents) {
-				/* No activity for this FD (poll implementation). */
-				continue;
-			}
-
 			/* Thread quit pipe has been closed. Killing thread. */
 			if (pollfd == quit_pipe_read_fd) {
 				goto exit;
diff --git a/src/bin/lttng-sessiond/client.c b/src/bin/lttng-sessiond/client.c
index a889529a..0be065ec 100644
--- a/src/bin/lttng-sessiond/client.c
+++ b/src/bin/lttng-sessiond/client.c
@@ -2174,11 +2174,6 @@ static void *thread_manage_clients(void *data)
 
 			health_code_update();
 
-			if (!revents) {
-				/* No activity for this FD (poll implementation). */
-				continue;
-			}
-
 			if (pollfd == thread_quit_pipe_fd) {
 				err = 0;
 				goto exit;
diff --git a/src/bin/lttng-sessiond/dispatch.c b/src/bin/lttng-sessiond/dispatch.c
index 04b3954c..a637f23d 100644
--- a/src/bin/lttng-sessiond/dispatch.c
+++ b/src/bin/lttng-sessiond/dispatch.c
@@ -144,11 +144,6 @@ static void sanitize_wait_queue(struct ust_reg_wait_queue *wait_queue)
 		uint32_t revents = LTTNG_POLL_GETEV(&events, i);
 		int pollfd = LTTNG_POLL_GETFD(&events, i);
 
-		if (!revents) {
-			/* No activity for this FD (poll implementation). */
-			continue;
-		}
-
 		cds_list_for_each_entry_safe(wait_node, tmp_wait_node,
 				&wait_queue->head, head) {
 			if (pollfd == wait_node->app->sock &&
diff --git a/src/bin/lttng-sessiond/health.c b/src/bin/lttng-sessiond/health.c
index 921b4526..5b4f5f8f 100644
--- a/src/bin/lttng-sessiond/health.c
+++ b/src/bin/lttng-sessiond/health.c
@@ -158,11 +158,6 @@ restart:
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
-			if (!revents) {
-				/* No activity for this FD (poll implementation). */
-				continue;
-			}
-
 			/* Event on the registration socket */
 			if (pollfd == sock) {
 				if (revents & LPOLLIN) {
diff --git a/src/bin/lttng-sessiond/ht-cleanup.c b/src/bin/lttng-sessiond/ht-cleanup.c
index 91c0544c..02244f0c 100644
--- a/src/bin/lttng-sessiond/ht-cleanup.c
+++ b/src/bin/lttng-sessiond/ht-cleanup.c
@@ -155,11 +155,6 @@ static void *thread_ht_cleanup(void *data)
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
-			if (!revents) {
-				/* No activity for this FD (poll implementation). */
-				continue;
-			}
-
 			if (pollfd != ht_cleanup_pipe[0]) {
 				continue;
 			}
diff --git a/src/bin/lttng-sessiond/manage-apps.c b/src/bin/lttng-sessiond/manage-apps.c
index f9ec356d..356c147a 100644
--- a/src/bin/lttng-sessiond/manage-apps.c
+++ b/src/bin/lttng-sessiond/manage-apps.c
@@ -123,11 +123,6 @@ static void *thread_application_management(void *data)
 
 			health_code_update();
 
-			if (!revents) {
-				/* No activity for this FD (poll implementation). */
-				continue;
-			}
-
 			if (pollfd == quit_pipe_read_fd) {
 				err = 0;
 				goto exit;
diff --git a/src/bin/lttng-sessiond/manage-consumer.c b/src/bin/lttng-sessiond/manage-consumer.c
index b710c61f..fa802adc 100644
--- a/src/bin/lttng-sessiond/manage-consumer.c
+++ b/src/bin/lttng-sessiond/manage-consumer.c
@@ -134,11 +134,6 @@ void *thread_consumer_management(void *data)
 
 		health_code_update();
 
-		if (!revents) {
-			/* No activity for this FD (poll implementation). */
-			continue;
-		}
-
 		/* Thread quit pipe has been closed. Killing thread. */
 		if (pollfd == quit_pipe_read_fd) {
 			err = 0;
@@ -298,11 +293,6 @@ void *thread_consumer_management(void *data)
 
 			health_code_update();
 
-			if (!revents) {
-				/* No activity for this FD (poll implementation). */
-				continue;
-			}
-
 			/*
 			 * Thread quit pipe has been triggered, flag that we should stop
 			 * but continue the current loop to handle potential data from
diff --git a/src/bin/lttng-sessiond/manage-kernel.c b/src/bin/lttng-sessiond/manage-kernel.c
index 34887d7b..f656c9f5 100644
--- a/src/bin/lttng-sessiond/manage-kernel.c
+++ b/src/bin/lttng-sessiond/manage-kernel.c
@@ -267,11 +267,6 @@ static void *thread_kernel_management(void *data)
 
 			health_code_update();
 
-			if (!revents) {
-				/* No activity for this FD (poll implementation). */
-				continue;
-			}
-
 			if (pollfd == quit_pipe_read_fd) {
 				err = 0;
 				goto exit;
diff --git a/src/bin/lttng-sessiond/notification-thread.c b/src/bin/lttng-sessiond/notification-thread.c
index b42b282e..0a1fd557 100644
--- a/src/bin/lttng-sessiond/notification-thread.c
+++ b/src/bin/lttng-sessiond/notification-thread.c
@@ -562,9 +562,6 @@ void *thread_notification(void *data)
 			int fd = LTTNG_POLL_GETFD(&state.events, i);
 			uint32_t revents = LTTNG_POLL_GETEV(&state.events, i);
 
-			if (!revents) {
-				continue;
-			}
 			DBG("[notification-thread] Handling fd (%i) activity (%u)", fd, revents);
 
 			if (fd == state.notification_channel_socket) {
diff --git a/src/bin/lttng-sessiond/notify-apps.c b/src/bin/lttng-sessiond/notify-apps.c
index bc7405c7..17f3cd0c 100644
--- a/src/bin/lttng-sessiond/notify-apps.c
+++ b/src/bin/lttng-sessiond/notify-apps.c
@@ -109,11 +109,6 @@ restart:
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
-			if (!revents) {
-				/* No activity for this FD (poll implementation). */
-				continue;
-			}
-
 			/* Thread quit pipe has been closed. Killing thread. */
 			if (pollfd == quit_pipe_read_fd) {
 				err = 0;
diff --git a/src/bin/lttng-sessiond/register.c b/src/bin/lttng-sessiond/register.c
index 6ce25ad0..e809834f 100644
--- a/src/bin/lttng-sessiond/register.c
+++ b/src/bin/lttng-sessiond/register.c
@@ -239,11 +239,6 @@ static void *thread_application_registration(void *data)
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
-			if (!revents) {
-				/* No activity for this FD (poll implementation). */
-				continue;
-			}
-
 			/* Thread quit pipe has been closed. Killing thread. */
 			if (pollfd == quit_pipe_read_fd) {
 				err = 0;
diff --git a/src/bin/lttng-sessiond/rotation-thread.c b/src/bin/lttng-sessiond/rotation-thread.c
index b86b1668..6669372d 100644
--- a/src/bin/lttng-sessiond/rotation-thread.c
+++ b/src/bin/lttng-sessiond/rotation-thread.c
@@ -974,10 +974,6 @@ void *thread_rotation(void *data)
 			int fd = LTTNG_POLL_GETFD(&thread.events, i);
 			uint32_t revents = LTTNG_POLL_GETEV(&thread.events, i);
 
-			if (!revents) {
-				/* No activity for this FD (poll implementation). */
-				continue;
-			}
 			DBG("[rotation-thread] Handling fd (%i) activity (%u)",
 					fd, revents);
 
diff --git a/src/common/consumer/consumer.c b/src/common/consumer/consumer.c
index 10273e66..c70d95a5 100644
--- a/src/common/consumer/consumer.c
+++ b/src/common/consumer/consumer.c
@@ -2396,11 +2396,6 @@ restart:
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
-			if (!revents) {
-				/* No activity for this FD (poll implementation). */
-				continue;
-			}
-
 			if (pollfd == lttng_pipe_get_readfd(ctx->consumer_metadata_pipe)) {
 				if (revents & LPOLLIN) {
 					ssize_t pipe_len;
@@ -2990,11 +2985,6 @@ restart:
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
-			if (!revents) {
-				/* No activity for this FD (poll implementation). */
-				continue;
-			}
-
 			if (pollfd == ctx->consumer_channel_pipe[0]) {
 				if (revents & LPOLLIN) {
 					enum consumer_channel_action action;
-- 
2.11.0
