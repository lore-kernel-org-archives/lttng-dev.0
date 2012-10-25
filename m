From: David Goulet <dgoulet@efficios.com>
Subject: [PATCH lttng-tools] Fix: consumer relayd cleanup on
	disconnect
Date: Thu, 25 Oct 2012 15:52:04 -0400
Message-ID: <1351194724-7860-1-git-send-email-dgoulet__32444.9782180183$1351194771$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TRTTU-00061G-E9
	for lttng-dev@lists.lttng.org; Thu, 25 Oct 2012 15:52:16 -0400
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

Improve the resilience of the consumer by cleaning up a relayd object
and all associated streams when a write error is detected on a relayd
socket.

Fixes #385

Signed-off-by: David Goulet <dgoulet@efficios.com>
---
 src/common/consumer.c      |  244 ++++++++++++++++++++++++++++++++++++++++----
 src/common/consumer.h      |    2 +
 src/common/relayd/relayd.c |    3 +
 3 files changed, 229 insertions(+), 20 deletions(-)

diff --git a/src/common/consumer.c b/src/common/consumer.c
index 53c6180..e61a227 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -70,6 +70,21 @@ struct lttng_ht *metadata_ht;
 struct lttng_ht *data_ht;
 
 /*
+ * Notify a thread pipe to poll back again. This usually means that some global
+ * state has changed so we just send back the thread in a poll wait call.
+ */
+static void notify_thread_pipe(int wpipe)
+{
+	int ret;
+
+	do {
+		struct lttng_consumer_stream *null_stream = NULL;
+
+		ret = write(wpipe, &null_stream, sizeof(null_stream));
+	} while (ret < 0 && errno == EINTR);
+}
+
+/*
  * Find a stream. The consumer_data.lock must be locked during this
  * call.
  */
@@ -182,6 +197,14 @@ static void consumer_rcu_free_relayd(struct rcu_head *head)
 	struct consumer_relayd_sock_pair *relayd =
 		caa_container_of(node, struct consumer_relayd_sock_pair, node);
 
+	/*
+	 * Close all sockets. This is done in the call RCU since we don't want the
+	 * socket fds to be reassigned thus potentially creating bad state of the
+	 * relayd object.
+	 */
+	(void) relayd_close(&relayd->control_sock);
+	(void) relayd_close(&relayd->data_sock);
+
 	free(relayd);
 }
 
@@ -204,21 +227,86 @@ static void destroy_relayd(struct consumer_relayd_sock_pair *relayd)
 	iter.iter.node = &relayd->node.node;
 	ret = lttng_ht_del(consumer_data.relayd_ht, &iter);
 	if (ret != 0) {
-		/* We assume the relayd was already destroyed */
+		/* We assume the relayd is being or is destroyed */
 		return;
 	}
 
-	/* Close all sockets */
-	pthread_mutex_lock(&relayd->ctrl_sock_mutex);
-	(void) relayd_close(&relayd->control_sock);
-	pthread_mutex_unlock(&relayd->ctrl_sock_mutex);
-	(void) relayd_close(&relayd->data_sock);
-
 	/* RCU free() call */
 	call_rcu(&relayd->node.head, consumer_rcu_free_relayd);
 }
 
 /*
+ * Set the delete flag to all streams having the given network sequence index
+ * (relayd index).
+ */
+static void set_delete_flag_stream_by_netidx(int net_seq_idx)
+{
+	struct lttng_ht_iter iter;
+	struct lttng_consumer_stream *stream;
+
+	DBG("Consumer set delete flag on stream by idx %d", net_seq_idx);
+
+	rcu_read_lock();
+
+	/* Let's begin with metadata */
+	cds_lfht_for_each_entry(metadata_ht->ht, &iter.iter, stream, node.node) {
+		if (stream->net_seq_idx == net_seq_idx) {
+			uatomic_set(&stream->delete_flag, 1);
+			DBG("Delete flag set to metadata stream %d", stream->wait_fd);
+		}
+	}
+
+	/* Follow up by the data streams */
+	cds_lfht_for_each_entry(data_ht->ht, &iter.iter, stream, node.node) {
+		if (stream->net_seq_idx == net_seq_idx) {
+			uatomic_set(&stream->delete_flag, 1);
+			DBG("Delete flag set to data stream %d", stream->wait_fd);
+		}
+	}
+	rcu_read_unlock();
+}
+
+/*
+ * Cleanup a relayd object by flagging every associated streams for deletion,
+ * destroying the object meaning removing it from the relayd hash table,
+ * closing the sockets and freeing the memory in a RCU call.
+ *
+ * If a local data context is available, notify the threads that the streams'
+ * state have changed.
+ */
+static void cleanup_relayd(struct consumer_relayd_sock_pair *relayd,
+		struct lttng_consumer_local_data *ctx)
+{
+	int netidx;
+
+	if (!relayd) {
+		/* Well... no fun */
+		return;
+	}
+
+	/* Save the net sequence index before destroying the object */
+	netidx = relayd->net_seq_idx;
+
+	/*
+	 * Delete the relayd from the relayd hash table, close the sockets and free
+	 * the object in a RCU call.
+	 */
+	destroy_relayd(relayd);
+
+	/* For all streams associated with the relayd, flag them for deletion. */
+	set_delete_flag_stream_by_netidx(netidx);
+
+	/*
+	 * With a local data context, notify the threads that the streams' state
+	 * have changed.
+	 */
+	if (ctx) {
+		notify_thread_pipe(ctx->consumer_data_pipe[1]);
+		notify_thread_pipe(ctx->consumer_metadata_pipe[1]);
+	}
+}
+
+/*
  * Flag a relayd socket pair for destruction. Destroy it if the refcount
  * reaches zero.
  *
@@ -251,11 +339,15 @@ void consumer_del_stream(struct lttng_consumer_stream *stream,
 
 	assert(stream);
 
+	DBG("Consumer del stream %d", stream->wait_fd);
+
 	if (ht == NULL) {
 		/* Means the stream was allocated but not successfully added */
 		goto free_stream;
 	}
 
+	pthread_mutex_lock(&stream->lock);
+
 	pthread_mutex_lock(&consumer_data.lock);
 
 	switch (consumer_data.type) {
@@ -349,6 +441,7 @@ void consumer_del_stream(struct lttng_consumer_stream *stream,
 end:
 	consumer_data.need_update = 1;
 	pthread_mutex_unlock(&consumer_data.lock);
+	pthread_mutex_unlock(&stream->lock);
 
 	if (free_chan) {
 		consumer_del_channel(free_chan);
@@ -804,7 +897,8 @@ static int consumer_update_poll_array(
 	DBG("Updating poll fd array");
 	rcu_read_lock();
 	cds_lfht_for_each_entry(ht->ht, &iter.iter, stream, node.node) {
-		if (stream->state != LTTNG_CONSUMER_ACTIVE_STREAM) {
+		if (stream->state != LTTNG_CONSUMER_ACTIVE_STREAM ||
+				stream->delete_flag) {
 			continue;
 		}
 		DBG("Active FD %d", stream->wait_fd);
@@ -1169,6 +1263,7 @@ ssize_t lttng_consumer_on_read_subbuffer_mmap(
 	/* Default is on the disk */
 	int outfd = stream->out_fd;
 	struct consumer_relayd_sock_pair *relayd = NULL;
+	unsigned int relayd_hang_up = 0;
 
 	/* RCU lock for the relayd pointer */
 	rcu_read_lock();
@@ -1228,11 +1323,22 @@ ssize_t lttng_consumer_on_read_subbuffer_mmap(
 				ret = write_relayd_metadata_id(outfd, stream, relayd, padding);
 				if (ret < 0) {
 					written = ret;
+					/* Socket operation failed. We consider the relayd dead */
+					if (ret == -EPIPE || ret == -EINVAL) {
+						relayd_hang_up = 1;
+						goto write_error;
+					}
 					goto end;
 				}
 			}
+		} else {
+			/* Socket operation failed. We consider the relayd dead */
+			if (ret == -EPIPE || ret == -EINVAL) {
+				relayd_hang_up = 1;
+				goto write_error;
+			}
+			/* Else, use the default set before which is the filesystem. */
 		}
-		/* Else, use the default set before which is the filesystem. */
 	} else {
 		/* No streaming, we have to set the len with the full padding */
 		len += padding;
@@ -1248,6 +1354,11 @@ ssize_t lttng_consumer_on_read_subbuffer_mmap(
 			if (written == 0) {
 				written = ret;
 			}
+			/* Socket operation failed. We consider the relayd dead */
+			if (errno == EPIPE || errno == EINVAL) {
+				relayd_hang_up = 1;
+				goto write_error;
+			}
 			goto end;
 		} else if (ret > len) {
 			PERROR("Error in file write (ret %zd > len %lu)", ret, len);
@@ -1269,6 +1380,15 @@ ssize_t lttng_consumer_on_read_subbuffer_mmap(
 	}
 	lttng_consumer_sync_trace_file(stream, orig_offset);
 
+write_error:
+	/*
+	 * This is a special case that the relayd has closed its socket. Let's
+	 * cleanup the relayd object and all associated streams.
+	 */
+	if (relayd && relayd_hang_up) {
+		cleanup_relayd(relayd, ctx);
+	}
+
 end:
 	/* Unlock only if ctrl socket used */
 	if (relayd && stream->metadata_flag) {
@@ -1298,6 +1418,7 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
 	int outfd = stream->out_fd;
 	struct consumer_relayd_sock_pair *relayd = NULL;
 	int *splice_pipe;
+	unsigned int relayd_hang_up = 0;
 
 	switch (consumer_data.type) {
 	case LTTNG_CONSUMER_KERNEL:
@@ -1350,6 +1471,12 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
 					padding);
 			if (ret < 0) {
 				written = ret;
+				/* Socket operation failed. We consider the relayd dead */
+				if (ret == -EBADF) {
+					WARN("Remote relayd disconnected. Stopping");
+					relayd_hang_up = 1;
+					goto write_error;
+				}
 				goto end;
 			}
 
@@ -1361,7 +1488,12 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
 			/* Use the returned socket. */
 			outfd = ret;
 		} else {
-			ERR("Remote relayd disconnected. Stopping");
+			/* Socket operation failed. We consider the relayd dead */
+			if (ret == -EBADF) {
+				WARN("Remote relayd disconnected. Stopping");
+				relayd_hang_up = 1;
+				goto write_error;
+			}
 			goto end;
 		}
 	} else {
@@ -1410,6 +1542,12 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
 			if (written == 0) {
 				written = ret_splice;
 			}
+			/* Socket operation failed. We consider the relayd dead */
+			if (errno == EBADF) {
+				WARN("Remote relayd disconnected. Stopping");
+				relayd_hang_up = 1;
+				goto write_error;
+			}
 			ret = errno;
 			goto splice_error;
 		} else if (ret_splice > len) {
@@ -1437,12 +1575,20 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
 
 	goto end;
 
+write_error:
+	/*
+	 * This is a special case that the relayd has closed its socket. Let's
+	 * cleanup the relayd object and all associated streams.
+	 */
+	if (relayd && relayd_hang_up) {
+		cleanup_relayd(relayd, ctx);
+		/* Let's not make fail the consumer for a disconnected relayd. */
+		goto end;
+	}
+
 splice_error:
 	/* send the appropriate error description to sessiond */
 	switch (ret) {
-	case EBADF:
-		lttng_consumer_send_error(ctx, LTTCOMM_CONSUMERD_SPLICE_EBADF);
-		break;
 	case EINVAL:
 		lttng_consumer_send_error(ctx, LTTCOMM_CONSUMERD_SPLICE_EINVAL);
 		break;
@@ -1604,6 +1750,8 @@ void consumer_del_metadata_stream(struct lttng_consumer_stream *stream,
 		goto free_stream;
 	}
 
+	pthread_mutex_lock(&stream->lock);
+
 	pthread_mutex_lock(&consumer_data.lock);
 	switch (consumer_data.type) {
 	case LTTNG_CONSUMER_KERNEL:
@@ -1695,6 +1843,7 @@ void consumer_del_metadata_stream(struct lttng_consumer_stream *stream,
 
 end:
 	pthread_mutex_unlock(&consumer_data.lock);
+	pthread_mutex_unlock(&stream->lock);
 
 	if (free_chan) {
 		consumer_del_channel(free_chan);
@@ -1766,6 +1915,58 @@ static int consumer_add_metadata_stream(struct lttng_consumer_stream *stream,
 }
 
 /*
+ * Delete data stream that are flagged for deletion (delete_flag).
+ */
+static void delete_flagged_data_stream(void)
+{
+	struct lttng_ht_iter iter;
+	struct lttng_consumer_stream *stream;
+
+	DBG("Consumer delete flagged data stream");
+
+	rcu_read_lock();
+	cds_lfht_for_each_entry(data_ht->ht, &iter.iter, stream, node.node) {
+		/* Validate delete flag of the stream */
+		if (!stream->delete_flag) {
+			continue;
+		}
+		/* Delete it right now */
+		consumer_del_stream(stream, data_ht);
+	}
+	rcu_read_unlock();
+}
+
+/*
+ * Delete metadata stream that are flagged for deletion (delete_flag).
+ */
+static void delete_flagged_metadata_stream(struct lttng_poll_event *pollset)
+{
+	struct lttng_ht_iter iter;
+	struct lttng_consumer_stream *stream;
+
+	DBG("Consumer delete flagged metadata stream");
+
+	assert(pollset);
+
+	rcu_read_lock();
+	cds_lfht_for_each_entry(metadata_ht->ht, &iter.iter, stream, node.node) {
+		/* Validate delete flag of the stream */
+		if (!stream->delete_flag) {
+			continue;
+		}
+		/*
+		 * Remove from pollset so the metadata thread can continue without
+		 * blocking on a deleted stream.
+		 */
+		lttng_poll_del(pollset, stream->wait_fd);
+
+		/* Delete it right now */
+		consumer_del_metadata_stream(stream, metadata_ht);
+	}
+	rcu_read_unlock();
+}
+
+/*
  * Thread polls on metadata file descriptor and write them on disk or on the
  * network.
  */
@@ -1856,6 +2057,13 @@ restart:
 						continue;
 					}
 
+					/* A NULL stream means that the state has changed. */
+					if (stream == NULL) {
+						/* Check for deleted streams. */
+						delete_flagged_metadata_stream(&events);
+						continue;
+					}
+
 					DBG("Adding metadata stream %d to poll set",
 							stream->wait_fd);
 
@@ -2063,6 +2271,7 @@ void *consumer_thread_data_poll(void *data)
 			 * waking us up to test it.
 			 */
 			if (new_stream == NULL) {
+				delete_flagged_data_stream();
 				continue;
 			}
 
@@ -2301,14 +2510,9 @@ end:
 
 	/*
 	 * Notify the data poll thread to poll back again and test the
-	 * consumer_quit state to quit gracefully.
+	 * consumer_quit state that we just set so to quit gracefully.
 	 */
-	do {
-		struct lttng_consumer_stream *null_stream = NULL;
-
-		ret = write(ctx->consumer_data_pipe[1], &null_stream,
-				sizeof(null_stream));
-	} while (ret < 0 && errno == EINTR);
+	notify_thread_pipe(ctx->consumer_data_pipe[1]);
 
 	rcu_unregister_thread();
 	return NULL;
diff --git a/src/common/consumer.h b/src/common/consumer.h
index 53b6151..99ce325 100644
--- a/src/common/consumer.h
+++ b/src/common/consumer.h
@@ -150,6 +150,8 @@ struct lttng_consumer_stream {
 	pthread_mutex_t lock;
 	/* Tracing session id */
 	uint64_t session_id;
+	/* Delete flag. This indicates that the stream must be deleted */
+	unsigned int delete_flag;
 };
 
 /*
diff --git a/src/common/relayd/relayd.c b/src/common/relayd/relayd.c
index 785d3dc..db47608 100644
--- a/src/common/relayd/relayd.c
+++ b/src/common/relayd/relayd.c
@@ -67,6 +67,7 @@ static int send_command(struct lttcomm_sock *sock,
 
 	ret = sock->ops->sendmsg(sock, buf, buf_size, flags);
 	if (ret < 0) {
+		ret = -errno;
 		goto error;
 	}
 
@@ -90,6 +91,7 @@ static int recv_reply(struct lttcomm_sock *sock, void *data, size_t size)
 
 	ret = sock->ops->recvmsg(sock, data, size, 0);
 	if (ret < 0) {
+		ret = -errno;
 		goto error;
 	}
 
@@ -283,6 +285,7 @@ int relayd_send_data_hdr(struct lttcomm_sock *sock,
 	/* Only send data header. */
 	ret = sock->ops->sendmsg(sock, hdr, size, 0);
 	if (ret < 0) {
+		ret = -errno;
 		goto error;
 	}
 
-- 
1.7.10.4
