From: David Goulet <dgoulet@efficios.com>
Subject: [PATCH 1/3 lttng-tools] Change consumer_data_pipe to be
	a lttng_pipe
Date: Tue, 14 May 2013 13:52:13 -0400
Message-ID: <1368553935-17162-1-git-send-email-dgoulet__8375.56209085069$1368553987$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UcJOo-0003vb-4Y
	for lttng-dev@lists.lttng.org; Tue, 14 May 2013 13:52:30 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Also, an important change here is that this pipe is no longer in non
block mode. Before sending stream's pointer over this pipe, only one
byte was written thus making it unlikely to fail in a read/write race
condition between threads. Now, 4 bytes are written so keeping this pipe
non block with threads is a bit of a "looking for trouble situation".

The lttng pipe wrappers make sure that the read and write side are
synchronized between threads using a mutex for each side. Furthermore,
the read and write handle partial I/O and EINTR meaning that once the
call returns we are sure that either everything was read/written or an
error occured thus making it not possible for the read side to block
indefinitely after a poll event.

Signed-off-by: David Goulet <dgoulet@efficios.com>
---
 src/common/consumer.c                        |   53 ++++++++++++--------------
 src/common/consumer.h                        |    3 +-
 src/common/kernel-consumer/kernel-consumer.c |    3 +-
 src/common/ust-consumer/ust-consumer.c       |    2 +-
 4 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/src/common/consumer.c b/src/common/consumer.c
index 01266a7..bd618dd 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -91,6 +91,20 @@ static void notify_thread_pipe(int wpipe)
 	} while (ret < 0 && errno == EINTR);
 }
 
+/*
+ * Notify a thread lttng pipe to poll back again. This usually means that some
+ * global state has changed so we just send back the thread in a poll wait
+ * call.
+ */
+static void notify_thread_lttng_pipe(struct lttng_pipe *pipe)
+{
+	struct lttng_consumer_stream *null_stream = NULL;
+
+	assert(pipe);
+
+	(void) lttng_pipe_write(pipe, &null_stream, sizeof(null_stream));
+}
+
 static void notify_channel_pipe(struct lttng_consumer_local_data *ctx,
 		struct lttng_consumer_channel *chan,
 		uint64_t key,
@@ -406,7 +420,7 @@ static void cleanup_relayd(struct consumer_relayd_sock_pair *relayd,
 	 * read of this status which happens AFTER receiving this notify.
 	 */
 	if (ctx) {
-		notify_thread_pipe(ctx->consumer_data_pipe[1]);
+		notify_thread_lttng_pipe(ctx->consumer_data_pipe);
 		notify_thread_pipe(ctx->consumer_metadata_pipe[1]);
 	}
 }
@@ -971,7 +985,7 @@ static int update_poll_array(struct lttng_consumer_local_data *ctx,
 	 * Insert the consumer_data_pipe at the end of the array and don't
 	 * increment i so nb_fd is the number of real FD.
 	 */
-	(*pollfd)[i].fd = ctx->consumer_data_pipe[0];
+	(*pollfd)[i].fd = lttng_pipe_get_readfd(ctx->consumer_data_pipe);
 	(*pollfd)[i].events = POLLIN | POLLPRI;
 	return i;
 }
@@ -1167,26 +1181,11 @@ struct lttng_consumer_local_data *lttng_consumer_create(
 	ctx->on_recv_stream = recv_stream;
 	ctx->on_update_stream = update_stream;
 
-	ret = pipe(ctx->consumer_data_pipe);
-	if (ret < 0) {
-		PERROR("Error creating poll pipe");
+	ctx->consumer_data_pipe = lttng_pipe_open(0);
+	if (!ctx->consumer_data_pipe) {
 		goto error_poll_pipe;
 	}
 
-	/* set read end of the pipe to non-blocking */
-	ret = fcntl(ctx->consumer_data_pipe[0], F_SETFL, O_NONBLOCK);
-	if (ret < 0) {
-		PERROR("fcntl O_NONBLOCK");
-		goto error_poll_fcntl;
-	}
-
-	/* set write end of the pipe to non-blocking */
-	ret = fcntl(ctx->consumer_data_pipe[1], F_SETFL, O_NONBLOCK);
-	if (ret < 0) {
-		PERROR("fcntl O_NONBLOCK");
-		goto error_poll_fcntl;
-	}
-
 	ret = pipe(ctx->consumer_should_quit);
 	if (ret < 0) {
 		PERROR("Error creating recv pipe");
@@ -1225,9 +1224,8 @@ error_channel_pipe:
 	utils_close_pipe(ctx->consumer_thread_pipe);
 error_thread_pipe:
 	utils_close_pipe(ctx->consumer_should_quit);
-error_poll_fcntl:
 error_quit_pipe:
-	utils_close_pipe(ctx->consumer_data_pipe);
+	lttng_pipe_destroy(ctx->consumer_data_pipe);
 error_poll_pipe:
 	free(ctx);
 error:
@@ -1253,7 +1251,7 @@ void lttng_consumer_destroy(struct lttng_consumer_local_data *ctx)
 	}
 	utils_close_pipe(ctx->consumer_thread_pipe);
 	utils_close_pipe(ctx->consumer_channel_pipe);
-	utils_close_pipe(ctx->consumer_data_pipe);
+	lttng_pipe_destroy(ctx->consumer_data_pipe);
 	utils_close_pipe(ctx->consumer_should_quit);
 	utils_close_pipe(ctx->consumer_splice_metadata_pipe);
 
@@ -2402,13 +2400,10 @@ void *consumer_thread_data_poll(void *data)
 			ssize_t pipe_readlen;
 
 			DBG("consumer_data_pipe wake up");
-			/* Consume 1 byte of pipe data */
-			do {
-				pipe_readlen = read(ctx->consumer_data_pipe[0], &new_stream,
-						sizeof(new_stream));
-			} while (pipe_readlen == -1 && errno == EINTR);
+			pipe_readlen = lttng_pipe_read(ctx->consumer_data_pipe,
+					&new_stream, sizeof(new_stream));
 			if (pipe_readlen < 0) {
-				PERROR("read consumer data pipe");
+				ERR("Consumer data pipe ret %ld", pipe_readlen);
 				/* Continue so we can at least handle the current stream(s). */
 				continue;
 			}
@@ -2968,7 +2963,7 @@ end:
 	 * Notify the data poll thread to poll back again and test the
 	 * consumer_quit state that we just set so to quit gracefully.
 	 */
-	notify_thread_pipe(ctx->consumer_data_pipe[1]);
+	notify_thread_lttng_pipe(ctx->consumer_data_pipe);
 
 	notify_channel_pipe(ctx, NULL, -1, CONSUMER_CHANNEL_QUIT);
 
diff --git a/src/common/consumer.h b/src/common/consumer.h
index 43989e4..91039e8 100644
--- a/src/common/consumer.h
+++ b/src/common/consumer.h
@@ -31,6 +31,7 @@
 #include <common/compat/fcntl.h>
 #include <common/compat/uuid.h>
 #include <common/sessiond-comm/sessiond-comm.h>
+#include <common/pipe.h>
 
 /* Commands for consumer */
 enum lttng_consumer_command {
@@ -346,7 +347,7 @@ struct lttng_consumer_local_data {
 	int consumer_channel_pipe[2];
 	int consumer_splice_metadata_pipe[2];
 	/* Data stream poll thread pipe. To transfer data stream to the thread */
-	int consumer_data_pipe[2];
+	struct lttng_pipe *consumer_data_pipe;
 	/* to let the signal handler wake up the fd receiver thread */
 	int consumer_should_quit[2];
 	/* Metadata poll thread pipe. Transfer metadata stream to it */
diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index 2cf9ac1..d8aec49 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -34,6 +34,7 @@
 #include <common/sessiond-comm/sessiond-comm.h>
 #include <common/sessiond-comm/relayd.h>
 #include <common/compat/fcntl.h>
+#include <common/pipe.h>
 #include <common/relayd/relayd.h>
 #include <common/utils.h>
 
@@ -289,7 +290,7 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 		if (new_stream->metadata_flag) {
 			stream_pipe = ctx->consumer_metadata_pipe[1];
 		} else {
-			stream_pipe = ctx->consumer_data_pipe[1];
+			stream_pipe = lttng_pipe_get_writefd(ctx->consumer_data_pipe);
 		}
 
 		do {
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index 031a7cb..ddf80da 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -191,7 +191,7 @@ static int send_stream_to_thread(struct lttng_consumer_stream *stream,
 	if (stream->metadata_flag) {
 		stream_pipe = ctx->consumer_metadata_pipe[1];
 	} else {
-		stream_pipe = ctx->consumer_data_pipe[1];
+		stream_pipe = lttng_pipe_get_writefd(ctx->consumer_data_pipe);
 	}
 
 	do {
-- 
1.7.10.4
