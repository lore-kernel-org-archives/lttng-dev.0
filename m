From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools 2/2] Fix: typo 'occured' ->
 'occurred'
Date: Thu, 15 Nov 2018 12:24:48 -0500
Message-ID: <20181115172448.6171-2-mjeanson__40323.8567211249$1542302628$gmane$org@efficios.com>
References: <20181115172448.6171-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42wpCL22ZczrHG
 for <lttng-dev@lists.lttng.org>; Thu, 15 Nov 2018 12:25:02 -0500 (EST)
In-Reply-To: <20181115172448.6171-1-mjeanson@efficios.com>
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

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 src/bin/lttng-relayd/main.c                         | 4 ++--
 src/bin/lttng-sessiond/cmd.c                        | 6 +++---
 src/bin/lttng-sessiond/notification-thread-events.c | 4 ++--
 src/bin/lttng-sessiond/rotation-thread.c            | 4 ++--
 src/bin/lttng-sessiond/session.h                    | 4 ++--
 src/bin/lttng-sessiond/ust-app.h                    | 2 +-
 src/bin/lttng/commands/enable_rotation.c            | 2 +-
 src/common/kernel-consumer/kernel-consumer.c        | 4 ++--
 src/common/ust-consumer/ust-consumer.c              | 4 ++--
 9 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index 1e2e9050f..09aeb33e0 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -85,7 +85,7 @@ NULL
 
 enum relay_connection_status {
 	RELAY_CONNECTION_STATUS_OK,
-	/* An error occured while processing an event on the connection. */
+	/* An error occurred while processing an event on the connection. */
 	RELAY_CONNECTION_STATUS_ERROR,
 	/* Connection closed/shutdown cleanly. */
 	RELAY_CONNECTION_STATUS_CLOSED,
@@ -1640,7 +1640,7 @@ int rotate_truncate_stream(struct relay_stream *stream)
 
 	/*
 	 * Rewind the current tracefile to the position at which the rotation
-	 * should have occured.
+	 * should have occurred.
 	 */
 	lseek_ret = lseek(stream->stream_fd->fd,
 			stream->pos_after_last_complete_data_index, SEEK_SET);
diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index 545269525..de6f67d48 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -2725,7 +2725,7 @@ int cmd_stop_trace(struct ltt_session *session)
 	struct ltt_kernel_channel *kchan;
 	struct ltt_kernel_session *ksession;
 	struct ltt_ust_session *usess;
-	bool error_occured = false;
+	bool error_occurred = false;
 
 	assert(session);
 
@@ -2762,7 +2762,7 @@ int cmd_stop_trace(struct ltt_session *session)
 			 * This error should not prevent the user from stopping
 			 * the session. However, it will be reported at the end.
 			 */
-			error_occured = true;
+			error_occurred = true;
 		}
 	}
 
@@ -2815,7 +2815,7 @@ int cmd_stop_trace(struct ltt_session *session)
 
 	/* Flag inactive after a successful stop. */
 	session->active = 0;
-	ret = !error_occured ? LTTNG_OK : LTTNG_ERR_UNK;
+	ret = !error_occurred ? LTTNG_OK : LTTNG_ERR_UNK;
 
 error:
 	return ret;
diff --git a/src/bin/lttng-sessiond/notification-thread-events.c b/src/bin/lttng-sessiond/notification-thread-events.c
index f29c1ef17..040ae5f28 100644
--- a/src/bin/lttng-sessiond/notification-thread-events.c
+++ b/src/bin/lttng-sessiond/notification-thread-events.c
@@ -1533,7 +1533,7 @@ int handle_notification_thread_command_add_channel(
 	session_info = find_or_create_session_info(state, session_name,
 			session_uid, session_gid);
 	if (!session_info) {
-		/* Allocation error or an internal error occured. */
+		/* Allocation error or an internal error occurred. */
 		goto error;
 	}
 
@@ -1698,7 +1698,7 @@ int handle_notification_thread_command_session_rotation(
 	session_info = find_or_create_session_info(state, session_name,
 			session_uid, session_gid);
 	if (!session_info) {
-		/* Allocation error or an internal error occured. */
+		/* Allocation error or an internal error occurred. */
 		ret = -1;
 		cmd_result = LTTNG_ERR_NOMEM;
 		goto end;
diff --git a/src/bin/lttng-sessiond/rotation-thread.c b/src/bin/lttng-sessiond/rotation-thread.c
index df70f8fd5..cf0e7ed97 100644
--- a/src/bin/lttng-sessiond/rotation-thread.c
+++ b/src/bin/lttng-sessiond/rotation-thread.c
@@ -857,7 +857,7 @@ int handle_notification_channel(int fd,
 	status = lttng_notification_channel_has_pending_notification(
 			rotate_notification_channel, &notification_pending);
 	if (status != LTTNG_NOTIFICATION_CHANNEL_STATUS_OK) {
-		ERR("[rotation-thread ]Error occured while checking for pending notification");
+		ERR("[rotation-thread ]Error occurred while checking for pending notification");
 		ret = -1;
 		goto end;
 	}
@@ -975,7 +975,7 @@ void *thread_rotation(void *data)
 				ret = handle_notification_channel(fd, handle,
 						&thread);
 				if (ret) {
-					ERR("[rotation-thread] Error occured while handling activity on notification channel socket");
+					ERR("[rotation-thread] Error occurred while handling activity on notification channel socket");
 					goto error;
 				}
 			}
diff --git a/src/bin/lttng-sessiond/session.h b/src/bin/lttng-sessiond/session.h
index 99b8c4711..8d62c7d88 100644
--- a/src/bin/lttng-sessiond/session.h
+++ b/src/bin/lttng-sessiond/session.h
@@ -123,7 +123,7 @@ struct ltt_session {
 	struct lttng_ht_node_u64 node;
 	/*
 	 * The current archive id corresponds to the number of session rotations
-	 * that have occured for this session. The archive id
+	 * that have occurred for this session. The archive id
 	 * is used to tag the "generation" of a stream. This tag allows the
 	 * consumer and relay daemons to track when a given stream was created
 	 * during the lifetime of a session.
@@ -192,7 +192,7 @@ struct ltt_session {
 	/*
 	 * Keep a state if this session was rotated after the last stop command.
 	 * We only allow one rotation after a stop. At destroy, we also need to
-	 * know if a rotation occured since the last stop to rename the current
+	 * know if a rotation occurred since the last stop to rename the current
 	 * chunk.
 	 */
 	bool rotated_after_last_stop;
diff --git a/src/bin/lttng-sessiond/ust-app.h b/src/bin/lttng-sessiond/ust-app.h
index 5aef9e951..fc7c85d9a 100644
--- a/src/bin/lttng-sessiond/ust-app.h
+++ b/src/bin/lttng-sessiond/ust-app.h
@@ -140,7 +140,7 @@ struct ust_app_channel {
 	/*
 	 * Unique key used to identify the channel on the consumer side.
 	 * 0 is a reserved 'invalid' value used to indicate that the consumer
-	 * does not know about this channel (i.e. an error occured).
+	 * does not know about this channel (i.e. an error occurred).
 	 */
 	uint64_t key;
 	/* Id of the tracing channel set on creation. */
diff --git a/src/bin/lttng/commands/enable_rotation.c b/src/bin/lttng/commands/enable_rotation.c
index 918662661..85dae5681 100644
--- a/src/bin/lttng/commands/enable_rotation.c
+++ b/src/bin/lttng/commands/enable_rotation.c
@@ -106,7 +106,7 @@ static enum cmd_error_code add_schedule(const char *session_name,
 		ret = CMD_ERROR;
 		goto end;
 	default:
-		ERR("Unknown error occured setting %s rotation schedule",
+		ERR("Unknown error occurred setting %s rotation schedule",
 				schedule_type_name);
 		ret = CMD_ERROR;
 		goto end;
diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index c223fa395..1529a2027 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -1169,7 +1169,7 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 
 		if (pending < 0) {
 			/*
-			 * An error occured while running the command;
+			 * An error occurred while running the command;
 			 * don't send the 'pending' flag as the sessiond
 			 * will not read it.
 			 */
@@ -1213,7 +1213,7 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 
 		if (pending < 0) {
 			/*
-			 * An error occured while running the command;
+			 * An error occurred while running the command;
 			 * don't send the 'pending' flag as the sessiond
 			 * will not read it.
 			 */
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index a81a497a9..1cfb8b76e 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -2017,7 +2017,7 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 
 		if (pending < 0) {
 			/*
-			 * An error occured while running the command;
+			 * An error occurred while running the command;
 			 * don't send the 'pending' flag as the sessiond
 			 * will not read it.
 			 */
@@ -2061,7 +2061,7 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 
 		if (pending < 0) {
 			/*
-			 * An error occured while running the command;
+			 * An error occurred while running the command;
 			 * don't send the 'pending' flag as the sessiond
 			 * will not read it.
 			 */
-- 
2.17.1
