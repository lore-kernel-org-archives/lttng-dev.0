From: David Goulet <dgoulet@efficios.com>
Subject: [PATCH 2/3 lttng-tools v2] Change
	consumer_metadata_pipe to be a lttng_pipe
Date: Thu, 16 May 2013 10:42:26 -0400
Message-ID: <1368715346-28720-1-git-send-email-dgoulet__133.66073039851$1368715393$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UczOA-0000jO-3x
	for lttng-dev@lists.lttng.org; Thu, 16 May 2013 10:42:38 -0400
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

The read() call in the metadata thread is also changed to use the lttng
pipe read wrapper.

Signed-off-by: David Goulet <dgoulet@efficios.com>
---
 src/common/consumer.c                        |   58 +++++++++-----------------
 src/common/consumer.h                        |    2 +-
 src/common/kernel-consumer/kernel-consumer.c |    2 +-
 src/common/ust-consumer/ust-consumer.c       |    2 +-
 4 files changed, 22 insertions(+), 42 deletions(-)

diff --git a/src/common/consumer.c b/src/common/consumer.c
index ca51ce0..c63e6e6 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -77,21 +77,6 @@ static struct lttng_ht *metadata_ht;
 static struct lttng_ht *data_ht;
 
 /*
- * Notify a thread pipe to poll back again. This usually means that some global
- * state has changed so we just send back the thread in a poll wait call.
- */
-static void notify_thread_pipe(int wpipe)
-{
-	int ret;
-
-	do {
-		struct lttng_consumer_stream *null_stream = NULL;
-
-		ret = write(wpipe, &null_stream, sizeof(null_stream));
-	} while (ret < 0 && errno == EINTR);
-}
-
-/*
  * Notify a thread lttng pipe to poll back again. This usually means that some
  * global state has changed so we just send back the thread in a poll wait
  * call.
@@ -423,7 +408,7 @@ static void cleanup_relayd(struct consumer_relayd_sock_pair *relayd,
 	 */
 	if (ctx) {
 		notify_thread_lttng_pipe(ctx->consumer_data_pipe);
-		notify_thread_pipe(ctx->consumer_metadata_pipe[1]);
+		notify_thread_lttng_pipe(ctx->consumer_metadata_pipe);
 	}
 }
 
@@ -1206,8 +1191,8 @@ struct lttng_consumer_local_data *lttng_consumer_create(
 		goto error_channel_pipe;
 	}
 
-	ret = utils_create_pipe(ctx->consumer_metadata_pipe);
-	if (ret < 0) {
+	ctx->consumer_metadata_pipe = lttng_pipe_open(0);
+	if (!ctx->consumer_metadata_pipe) {
 		goto error_metadata_pipe;
 	}
 
@@ -1219,7 +1204,7 @@ struct lttng_consumer_local_data *lttng_consumer_create(
 	return ctx;
 
 error_splice_pipe:
-	utils_close_pipe(ctx->consumer_metadata_pipe);
+	lttng_pipe_destroy(ctx->consumer_metadata_pipe);
 error_metadata_pipe:
 	utils_close_pipe(ctx->consumer_channel_pipe);
 error_channel_pipe:
@@ -1254,6 +1239,7 @@ void lttng_consumer_destroy(struct lttng_consumer_local_data *ctx)
 	utils_close_pipe(ctx->consumer_thread_pipe);
 	utils_close_pipe(ctx->consumer_channel_pipe);
 	lttng_pipe_destroy(ctx->consumer_data_pipe);
+	lttng_pipe_destroy(ctx->consumer_metadata_pipe);
 	utils_close_pipe(ctx->consumer_should_quit);
 	utils_close_pipe(ctx->consumer_splice_metadata_pipe);
 
@@ -2134,7 +2120,8 @@ void *consumer_thread_metadata_poll(void *data)
 		goto end_poll;
 	}
 
-	ret = lttng_poll_add(&events, ctx->consumer_metadata_pipe[0], LPOLLIN);
+	ret = lttng_poll_add(&events,
+			lttng_pipe_get_readfd(ctx->consumer_metadata_pipe), LPOLLIN);
 	if (ret < 0) {
 		goto end;
 	}
@@ -2172,30 +2159,26 @@ restart:
 				continue;
 			}
 
-			if (pollfd == ctx->consumer_metadata_pipe[0]) {
+			if (pollfd == lttng_pipe_get_readfd(ctx->consumer_metadata_pipe)) {
 				if (revents & (LPOLLERR | LPOLLHUP )) {
 					DBG("Metadata thread pipe hung up");
 					/*
 					 * Remove the pipe from the poll set and continue the loop
 					 * since their might be data to consume.
 					 */
-					lttng_poll_del(&events, ctx->consumer_metadata_pipe[0]);
-					ret = close(ctx->consumer_metadata_pipe[0]);
-					if (ret < 0) {
-						PERROR("close metadata pipe");
-					}
+					lttng_poll_del(&events,
+							lttng_pipe_get_readfd(ctx->consumer_metadata_pipe));
+					lttng_pipe_read_close(ctx->consumer_metadata_pipe);
 					continue;
 				} else if (revents & LPOLLIN) {
-					do {
-						/* Get the stream pointer received */
-						ret = read(pollfd, &stream, sizeof(stream));
-					} while (ret < 0 && errno == EINTR);
-					if (ret < 0 ||
-							ret < sizeof(struct lttng_consumer_stream *)) {
-						PERROR("read metadata stream");
+					ssize_t pipe_len;
+
+					pipe_len = lttng_pipe_read(ctx->consumer_metadata_pipe,
+							&stream, sizeof(stream));
+					if (pipe_len < 0) {
+						ERR("read metadata stream, ret: %ld", pipe_len);
 						/*
-						 * Let's continue here and hope we can still work
-						 * without stopping the consumer. XXX: Should we?
+						 * Continue here to handle the rest of the streams.
 						 */
 						continue;
 					}
@@ -2543,10 +2526,7 @@ end:
 	 * only tracked fd in the poll set. The thread will take care of closing
 	 * the read side.
 	 */
-	ret = close(ctx->consumer_metadata_pipe[1]);
-	if (ret < 0) {
-		PERROR("close data pipe");
-	}
+	(void) lttng_pipe_write_close(ctx->consumer_metadata_pipe);
 
 	destroy_data_stream_ht(data_ht);
 
diff --git a/src/common/consumer.h b/src/common/consumer.h
index 91039e8..3726fd1 100644
--- a/src/common/consumer.h
+++ b/src/common/consumer.h
@@ -351,7 +351,7 @@ struct lttng_consumer_local_data {
 	/* to let the signal handler wake up the fd receiver thread */
 	int consumer_should_quit[2];
 	/* Metadata poll thread pipe. Transfer metadata stream to it */
-	int consumer_metadata_pipe[2];
+	struct lttng_pipe *consumer_metadata_pipe;
 };
 
 /*
diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index d8aec49..f23fc9c 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -288,7 +288,7 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 
 		/* Get the right pipe where the stream will be sent. */
 		if (new_stream->metadata_flag) {
-			stream_pipe = ctx->consumer_metadata_pipe[1];
+			stream_pipe = lttng_pipe_get_writefd(ctx->consumer_metadata_pipe);
 		} else {
 			stream_pipe = lttng_pipe_get_writefd(ctx->consumer_data_pipe);
 		}
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index ddf80da..a81e9d4 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -189,7 +189,7 @@ static int send_stream_to_thread(struct lttng_consumer_stream *stream,
 
 	/* Get the right pipe where the stream will be sent. */
 	if (stream->metadata_flag) {
-		stream_pipe = ctx->consumer_metadata_pipe[1];
+		stream_pipe = lttng_pipe_get_writefd(ctx->consumer_metadata_pipe);
 	} else {
 		stream_pipe = lttng_pipe_get_writefd(ctx->consumer_data_pipe);
 	}
-- 
1.7.10.4
