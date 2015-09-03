From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: consumer: do full flush on
	missed timer
Date: Wed,  2 Sep 2015 23:46:55 -0400
Message-ID: <1441252015-16528-1-git-send-email-mathieu.desnoyers__6772.31704253263$1441252105$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZXLUR-0000Os-07
 for lttng-dev@lists.lttng.org; Wed, 02 Sep 2015 23:47:15 -0400
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

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/consumer-timer.c                  | 118 +++++++++++++++------------
 src/common/consumer-timer.h                  |   3 +
 src/common/kernel-consumer/kernel-consumer.c |  17 +++-
 src/common/ust-consumer/ust-consumer.c       |   2 +-
 4 files changed, 85 insertions(+), 55 deletions(-)

diff --git a/src/common/consumer-timer.c b/src/common/consumer-timer.c
index e17671b..c3a07ec 100644
--- a/src/common/consumer-timer.c
+++ b/src/common/consumer-timer.c
@@ -133,11 +133,48 @@ error:
 	return ret;
 }
 
-static int check_kernel_stream(struct lttng_consumer_stream *stream)
+int consumer_flush_kernel_index(struct lttng_consumer_stream *stream)
 {
 	uint64_t ts, stream_id;
 	int ret;
 
+	ret = kernctl_get_current_timestamp(stream->wait_fd, &ts);
+	if (ret < 0) {
+		ERR("Failed to get the current timestamp");
+		goto end;
+	}
+	ret = kernctl_buffer_flush(stream->wait_fd);
+	if (ret < 0) {
+		ERR("Failed to flush kernel stream");
+		goto end;
+	}
+	ret = kernctl_snapshot(stream->wait_fd);
+	if (ret < 0) {
+		if (errno != EAGAIN && errno != ENODATA) {
+			PERROR("live timer kernel snapshot");
+			ret = -1;
+			goto end;
+		}
+		ret = kernctl_get_stream_id(stream->wait_fd, &stream_id);
+		if (ret < 0) {
+			PERROR("kernctl_get_stream_id");
+			goto end;
+		}
+		DBG("Stream %" PRIu64 " empty, sending beacon", stream->key);
+		ret = send_empty_index(stream, ts, stream_id);
+		if (ret < 0) {
+			goto end;
+		}
+	}
+	ret = 0;
+end:
+	return ret;
+}
+
+static int check_kernel_stream(struct lttng_consumer_stream *stream)
+{
+	int ret;
+
 	/*
 	 * While holding the stream mutex, try to take a snapshot, if it
 	 * succeeds, it means that data is ready to be sent, just let the data
@@ -173,45 +210,53 @@ static int check_kernel_stream(struct lttng_consumer_stream *stream)
 		}
 		break;
 	}
-	ret = kernctl_get_current_timestamp(stream->wait_fd, &ts);
-	if (ret < 0) {
-		ERR("Failed to get the current timestamp");
-		goto error_unlock;
+	ret = consumer_flush_kernel_index(stream);
+	pthread_mutex_unlock(&stream->lock);
+end:
+	return ret;
+}
+
+int consumer_flush_ust_index(struct lttng_consumer_stream *stream)
+{
+	uint64_t ts, stream_id;
+	int ret;
+
+	ret = cds_lfht_is_node_deleted(&stream->node.node);
+	if (ret) {
+		goto end;
 	}
-	ret = kernctl_buffer_flush(stream->wait_fd);
+
+	ret = lttng_ustconsumer_get_current_timestamp(stream, &ts);
 	if (ret < 0) {
-		ERR("Failed to flush kernel stream");
-		goto error_unlock;
+		ERR("Failed to get the current timestamp");
+		goto end;
 	}
-	ret = kernctl_snapshot(stream->wait_fd);
+	lttng_ustconsumer_flush_buffer(stream, 1);
+	ret = lttng_ustconsumer_take_snapshot(stream);
 	if (ret < 0) {
-		if (errno != EAGAIN && errno != ENODATA) {
-			PERROR("live timer kernel snapshot");
+		if (ret != -EAGAIN) {
+			ERR("Taking UST snapshot");
 			ret = -1;
-			goto error_unlock;
+			goto end;
 		}
-		ret = kernctl_get_stream_id(stream->wait_fd, &stream_id);
+		ret = lttng_ustconsumer_get_stream_id(stream, &stream_id);
 		if (ret < 0) {
-			PERROR("kernctl_get_stream_id");
-			goto error_unlock;
+			PERROR("ustctl_get_stream_id");
+			goto end;
 		}
 		DBG("Stream %" PRIu64 " empty, sending beacon", stream->key);
 		ret = send_empty_index(stream, ts, stream_id);
 		if (ret < 0) {
-			goto error_unlock;
+			goto end;
 		}
 	}
 	ret = 0;
-
-error_unlock:
-	pthread_mutex_unlock(&stream->lock);
 end:
 	return ret;
 }
 
 static int check_ust_stream(struct lttng_consumer_stream *stream)
 {
-	uint64_t ts, stream_id;
 	int ret;
 
 	assert(stream);
@@ -251,38 +296,7 @@ static int check_ust_stream(struct lttng_consumer_stream *stream)
 		}
 		break;
 	}
-	ret = cds_lfht_is_node_deleted(&stream->node.node);
-	if (ret) {
-		goto error_unlock;
-	}
-
-	ret = lttng_ustconsumer_get_current_timestamp(stream, &ts);
-	if (ret < 0) {
-		ERR("Failed to get the current timestamp");
-		goto error_unlock;
-	}
-	lttng_ustconsumer_flush_buffer(stream, 1);
-	ret = lttng_ustconsumer_take_snapshot(stream);
-	if (ret < 0) {
-		if (ret != -EAGAIN) {
-			ERR("Taking UST snapshot");
-			ret = -1;
-			goto error_unlock;
-		}
-		ret = lttng_ustconsumer_get_stream_id(stream, &stream_id);
-		if (ret < 0) {
-			PERROR("ustctl_get_stream_id");
-			goto error_unlock;
-		}
-		DBG("Stream %" PRIu64 " empty, sending beacon", stream->key);
-		ret = send_empty_index(stream, ts, stream_id);
-		if (ret < 0) {
-			goto error_unlock;
-		}
-	}
-	ret = 0;
-
-error_unlock:
+	ret = consumer_flush_ust_index(stream);
 	pthread_mutex_unlock(&stream->lock);
 end:
 	return ret;
diff --git a/src/common/consumer-timer.h b/src/common/consumer-timer.h
index baaa82b..22e7457 100644
--- a/src/common/consumer-timer.h
+++ b/src/common/consumer-timer.h
@@ -52,4 +52,7 @@ void consumer_timer_live_stop(struct lttng_consumer_channel *channel);
 void *consumer_timer_thread(void *data);
 int consumer_signal_init(void);
 
+int consumer_flush_kernel_index(struct lttng_consumer_stream *stream);
+int consumer_flush_ust_index(struct lttng_consumer_stream *stream);
+
 #endif /* CONSUMER_TIMER_H */
diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index 74cdd7d..aae56f9 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -1219,9 +1219,22 @@ ssize_t lttng_kconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
 		/*
 		 * In live, block until all the metadata is sent.
 		 */
-		CMM_STORE_SHARED(stream->waiting_on_metadata, 1);
+		pthread_mutex_lock(&stream->metadata_timer_lock);
+		assert(!stream->missed_metadata_flush);
+		stream->waiting_on_metadata = true;
+		pthread_mutex_unlock(&stream->metadata_timer_lock);
+
 		err = consumer_stream_sync_metadata(ctx, stream->session_id);
-		CMM_STORE_SHARED(stream->waiting_on_metadata, 0);
+
+		pthread_mutex_lock(&stream->metadata_timer_lock);
+		stream->waiting_on_metadata = false;
+		if (stream->missed_metadata_flush) {
+			stream->missed_metadata_flush = false;
+			pthread_mutex_unlock(&stream->metadata_timer_lock);
+			(void) consumer_flush_kernel_index(stream);
+		} else {
+			pthread_mutex_unlock(&stream->metadata_timer_lock);
+		}
 		if (err < 0) {
 			goto end;
 		}
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index a1f1ced..d45707b 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -2260,7 +2260,7 @@ retry:
 		if (stream->missed_metadata_flush) {
 			stream->missed_metadata_flush = false;
 			pthread_mutex_unlock(&stream->metadata_timer_lock);
-			lttng_ustconsumer_flush_buffer(stream, 1);
+			(void) consumer_flush_ust_index(stream);
 		} else {
 			pthread_mutex_unlock(&stream->metadata_timer_lock);
 		}
-- 
2.1.4
