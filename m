From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: consumerd errors on exit
Date: Fri, 21 Feb 2014 10:14:46 -0500
Message-ID: <1392995686-26640-1-git-send-email-mathieu.desnoyers__35731.182099744$1392995774$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mathieu.desnoyers@efficios.com>) id 1WGroY-0006hE-KK
	for lttng-dev@lists.lttng.org; Fri, 21 Feb 2014 10:15:04 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id DC7DB3401A8
	for <lttng-dev@lists.lttng.org>; Fri, 21 Feb 2014 15:14:58 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

- The LTTNG_CONSUMER_STOP command is not used by sessiond anymore, so
  deprecate it,
- Ensure that the normal teardown (with signal handler) does not trigger
  a health error in consumer daemon by distinguishing between errors and
  "should exit" with different lttng_consumer_poll_socket() return values.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/consumer.c                        |   42 +++++++++++++++-----------
 src/common/consumer.h                        |    2 +-
 src/common/kernel-consumer/kernel-consumer.c |   18 +++--------
 src/common/ust-consumer/ust-consumer.c       |   15 ++-------
 4 files changed, 33 insertions(+), 44 deletions(-)

diff --git a/src/common/consumer.c b/src/common/consumer.c
index 821a04e..8462c0e 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -1095,8 +1095,8 @@ static int update_poll_array(struct lttng_consumer_local_data *ctx,
 }
 
 /*
- * Poll on the should_quit pipe and the command socket return -1 on error and
- * should exit, 0 if data is available on the command socket
+ * Poll on the should_quit pipe and the command socket return -1 on
+ * error, 1 if should exit, 0 if data is available on the command socket
  */
 int lttng_consumer_poll_socket(struct pollfd *consumer_sockpoll)
 {
@@ -1112,16 +1112,13 @@ restart:
 			goto restart;
 		}
 		PERROR("Poll error");
-		goto exit;
+		return -1;
 	}
 	if (consumer_sockpoll[0].revents & (POLLIN | POLLPRI)) {
 		DBG("consumer_should_quit wake up");
-		goto exit;
+		return 1;
 	}
 	return 0;
-
-exit:
-	return -1;
 }
 
 /*
@@ -2944,8 +2941,8 @@ static int set_metadata_socket(struct lttng_consumer_local_data *ctx,
 	assert(ctx);
 	assert(sockpoll);
 
-	if (lttng_consumer_poll_socket(sockpoll) < 0) {
-		ret = -1;
+	ret = lttng_consumer_poll_socket(sockpoll);
+	if (ret) {
 		goto error;
 	}
 	DBG("Metadata connection on client_socket");
@@ -3014,7 +3011,12 @@ void *consumer_thread_sessiond_poll(void *data)
 	consumer_sockpoll[1].fd = client_socket;
 	consumer_sockpoll[1].events = POLLIN | POLLPRI;
 
-	if (lttng_consumer_poll_socket(consumer_sockpoll) < 0) {
+	ret = lttng_consumer_poll_socket(consumer_sockpoll);
+	if (ret) {
+		if (ret > 0) {
+			/* should exit */
+			err = 0;
+		}
 		goto end;
 	}
 	DBG("Connection on client_socket");
@@ -3031,7 +3033,11 @@ void *consumer_thread_sessiond_poll(void *data)
 	 * command unix socket.
 	 */
 	ret = set_metadata_socket(ctx, consumer_sockpoll, client_socket);
-	if (ret < 0) {
+	if (ret) {
+		if (ret > 0) {
+			/* should exit */
+			err = 0;
+		}
 		goto end;
 	}
 
@@ -3052,15 +3058,15 @@ void *consumer_thread_sessiond_poll(void *data)
 		health_poll_entry();
 		ret = lttng_consumer_poll_socket(consumer_sockpoll);
 		health_poll_exit();
-		if (ret < 0) {
+		if (ret) {
+			if (ret > 0) {
+				/* should exit */
+				err = 0;
+			}
 			goto end;
 		}
 		DBG("Incoming command on sock");
 		ret = lttng_consumer_recv_cmd(ctx, sock, consumer_sockpoll);
-		if (ret == -ENOENT) {
-			DBG("Received STOP command");
-			goto end;
-		}
 		if (ret <= 0) {
 			/*
 			 * This could simply be a session daemon quitting. Don't output
@@ -3278,7 +3284,9 @@ int consumer_add_relayd_socket(uint64_t net_seq_idx, int sock_type,
 	}
 
 	/* Poll on consumer socket. */
-	if (lttng_consumer_poll_socket(consumer_sockpoll) < 0) {
+	ret = lttng_consumer_poll_socket(consumer_sockpoll);
+	if (ret) {
+		/* Needing to exit in the middle of a command: error. */
 		lttng_consumer_send_error(ctx, LTTCOMM_CONSUMERD_POLL_ERROR);
 		ret = -EINTR;
 		goto error_nosignal;
diff --git a/src/common/consumer.h b/src/common/consumer.h
index 84ef271..7485e65 100644
--- a/src/common/consumer.h
+++ b/src/common/consumer.h
@@ -41,7 +41,7 @@ enum lttng_consumer_command {
 	/* pause, delete, active depending on fd state */
 	LTTNG_CONSUMER_UPDATE_STREAM,
 	/* inform the consumer to quit when all fd has hang up */
-	LTTNG_CONSUMER_STOP,
+	LTTNG_CONSUMER_STOP,	/* deprecated */
 	LTTNG_CONSUMER_ADD_RELAYD_SOCKET,
 	/* Inform the consumer to kill a specific relayd connection */
 	LTTNG_CONSUMER_DESTROY_RELAYD,
diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index 061123d..ab4f604 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -441,17 +441,8 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 
 	health_code_update();
 
-	if (msg.cmd_type == LTTNG_CONSUMER_STOP) {
-		/*
-		 * Notify the session daemon that the command is completed.
-		 *
-		 * On transport layer error, the function call will print an error
-		 * message so handling the returned code is a bit useless since we
-		 * return an error code anyway.
-		 */
-		(void) consumer_send_status_msg(sock, ret_code);
-		return -ENOENT;
-	}
+	/* Deprecated command */
+	assert(msg.cmd_type != LTTNG_CONSUMER_STOP);
 
 	health_code_update();
 
@@ -593,9 +584,8 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 		health_poll_entry();
 		ret = lttng_consumer_poll_socket(consumer_sockpoll);
 		health_poll_exit();
-		if (ret < 0) {
-			rcu_read_unlock();
-			return -EINTR;
+		if (ret) {
+			goto error_fatal;
 		}
 
 		health_code_update();
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index b48a3c8..be203cf 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -1116,17 +1116,8 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 
 	health_code_update();
 
-	if (msg.cmd_type == LTTNG_CONSUMER_STOP) {
-		/*
-		 * Notify the session daemon that the command is completed.
-		 *
-		 * On transport layer error, the function call will print an error
-		 * message so handling the returned code is a bit useless since we
-		 * return an error code anyway.
-		 */
-		(void) consumer_send_status_msg(sock, ret_code);
-		return -ENOENT;
-	}
+	/* deprecated */
+	assert(msg.cmd_type != LTTNG_CONSUMER_STOP);
 
 	health_code_update();
 
@@ -1456,7 +1447,7 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 		health_poll_entry();
 		ret = lttng_consumer_poll_socket(consumer_sockpoll);
 		health_poll_exit();
-		if (ret < 0) {
+		if (ret) {
 			goto error_fatal;
 		}
 
-- 
1.7.10.4
