From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH] Fix: create/destroy a splice_pipe
	per stream
Date: Wed, 12 Nov 2014 18:36:17 -0500
Message-ID: <1415835377-24954-1-git-send-email-jdesfossez__30266.8141470805$1415835435$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1XohSi-0000vk-Hm
 for lttng-dev@lists.lttng.org; Wed, 12 Nov 2014 18:36:35 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com, dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

We had a per-thread splice_pipe (one for data and one for metadata), but
in case of error, we would end up filling the write side of the pipe and
never emptying it. This could lead to leaking data from one session to
the other, but also to stall the consumer trying to splice into a full
pipe.

Now we create a splice_pipe per-stream, so it is destroyed when the
session is destroyed.

Fixes: #726

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/common/consumer-stream.c                 |  4 ++++
 src/common/consumer.c                        | 32 +++-------------------------
 src/common/consumer.h                        |  7 ++++--
 src/common/kernel-consumer/kernel-consumer.c |  4 ++++
 4 files changed, 16 insertions(+), 31 deletions(-)

diff --git a/src/common/consumer-stream.c b/src/common/consumer-stream.c
index 8fe02e7..92576aa 100644
--- a/src/common/consumer-stream.c
+++ b/src/common/consumer-stream.c
@@ -28,6 +28,7 @@
 #include <common/kernel-consumer/kernel-consumer.h>
 #include <common/relayd/relayd.h>
 #include <common/ust-consumer/ust-consumer.h>
+#include <common/utils.h>
 
 #include "consumer-stream.h"
 
@@ -119,6 +120,9 @@ void consumer_stream_close(struct lttng_consumer_stream *stream)
 			}
 			stream->wait_fd = -1;
 		}
+		if (stream->chan->output == CONSUMER_CHANNEL_SPLICE) {
+			utils_close_pipe(stream->splice_pipe);
+		}
 		break;
 	case LTTNG_CONSUMER32_UST:
 	case LTTNG_CONSUMER64_UST:
diff --git a/src/common/consumer.c b/src/common/consumer.c
index 999e400..755aa5e 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -1302,12 +1302,6 @@ struct lttng_consumer_local_data *lttng_consumer_create(
 		goto error_quit_pipe;
 	}
 
-	ret = pipe(ctx->consumer_thread_pipe);
-	if (ret < 0) {
-		PERROR("Error creating thread pipe");
-		goto error_thread_pipe;
-	}
-
 	ret = pipe(ctx->consumer_channel_pipe);
 	if (ret < 0) {
 		PERROR("Error creating channel pipe");
@@ -1319,20 +1313,11 @@ struct lttng_consumer_local_data *lttng_consumer_create(
 		goto error_metadata_pipe;
 	}
 
-	ret = utils_create_pipe(ctx->consumer_splice_metadata_pipe);
-	if (ret < 0) {
-		goto error_splice_pipe;
-	}
-
 	return ctx;
 
-error_splice_pipe:
-	lttng_pipe_destroy(ctx->consumer_metadata_pipe);
 error_metadata_pipe:
 	utils_close_pipe(ctx->consumer_channel_pipe);
 error_channel_pipe:
-	utils_close_pipe(ctx->consumer_thread_pipe);
-error_thread_pipe:
 	utils_close_pipe(ctx->consumer_should_quit);
 error_quit_pipe:
 	lttng_pipe_destroy(ctx->consumer_wakeup_pipe);
@@ -1419,13 +1404,11 @@ void lttng_consumer_destroy(struct lttng_consumer_local_data *ctx)
 	if (ret) {
 		PERROR("close");
 	}
-	utils_close_pipe(ctx->consumer_thread_pipe);
 	utils_close_pipe(ctx->consumer_channel_pipe);
 	lttng_pipe_destroy(ctx->consumer_data_pipe);
 	lttng_pipe_destroy(ctx->consumer_metadata_pipe);
 	lttng_pipe_destroy(ctx->consumer_wakeup_pipe);
 	utils_close_pipe(ctx->consumer_should_quit);
-	utils_close_pipe(ctx->consumer_splice_metadata_pipe);
 
 	unlink(ctx->consumer_command_sock_path);
 	free(ctx);
@@ -1718,17 +1701,7 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
 			goto end;
 		}
 	}
-
-	/*
-	 * Choose right pipe for splice. Metadata and trace data are handled by
-	 * different threads hence the use of two pipes in order not to race or
-	 * corrupt the written data.
-	 */
-	if (stream->metadata_flag) {
-		splice_pipe = ctx->consumer_splice_metadata_pipe;
-	} else {
-		splice_pipe = ctx->consumer_thread_pipe;
-	}
+	splice_pipe = stream->splice_pipe;
 
 	/* Write metadata stream id before payload */
 	if (relayd) {
@@ -1834,7 +1807,8 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
 		/* Splice data out */
 		ret_splice = splice(splice_pipe[0], NULL, outfd, NULL,
 				ret_splice, SPLICE_F_MOVE | SPLICE_F_MORE);
-		DBG("Consumer splice pipe to file, ret %zd", ret_splice);
+		DBG("Consumer splice pipe to file (out_fd: %d), ret %zd",
+				outfd, ret_splice);
 		if (ret_splice < 0) {
 			ret = errno;
 			written = -ret;
diff --git a/src/common/consumer.h b/src/common/consumer.h
index 4ac823c..1e378f0 100644
--- a/src/common/consumer.h
+++ b/src/common/consumer.h
@@ -337,6 +337,11 @@ struct lttng_consumer_stream {
 	int index_fd;
 
 	/*
+	 * Local pipe to extract data when using splice.
+	 */
+	int splice_pipe[2];
+
+	/*
 	 * Rendez-vous point between data and metadata stream in live mode.
 	 */
 	pthread_cond_t metadata_rdv;
@@ -451,9 +456,7 @@ struct lttng_consumer_local_data {
 	/* socket to exchange commands with sessiond */
 	char *consumer_command_sock_path;
 	/* communication with splice */
-	int consumer_thread_pipe[2];
 	int consumer_channel_pipe[2];
-	int consumer_splice_metadata_pipe[2];
 	/* Data stream poll thread pipe. To transfer data stream to the thread */
 	struct lttng_pipe *consumer_data_pipe;
 
diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index cbd1b5a..6ec6acc 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -642,6 +642,10 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 		switch (channel->output) {
 		case CONSUMER_CHANNEL_SPLICE:
 			new_stream->output = LTTNG_EVENT_SPLICE;
+			ret = utils_create_pipe(new_stream->splice_pipe);
+			if (ret < 0) {
+				goto end_nosignal;
+			}
 			break;
 		case CONSUMER_CHANNEL_MMAP:
 			new_stream->output = LTTNG_EVENT_MMAP;
-- 
1.9.1
