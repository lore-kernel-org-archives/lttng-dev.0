From: David Goulet <dgoulet@efficios.com>
Subject: [PATCH v3 lttng-tools] Fix: Stream allocation and
	insertion consistency
Date: Thu,  4 Oct 2012 10:55:04 -0400
Message-ID: <1349362504-18296-1-git-send-email-dgoulet__27325.1873012216$1349390552$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TJmpW-0001Vj-1o
	for lttng-dev@lists.lttng.org; Thu, 04 Oct 2012 10:55:14 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: David Goulet <dgoulet@efficios.com>
List-Id: lttng-dev@lists.lttng.org

The stream allocation in the consumer was doing ustctl actions on the
stream and updating refcounts. However, before inserting the stream into
the hash table and polling on the fd for data, an error could occur
which could stop the stream insertion hence creating multiple fd leaks,
mem leaks and bad refcount state.

Furthermore, the consumer_del_stream now can destroy a stream even if
that stream is not added to the global hash table. The kernel and UST
consumers use it on error between allocation and hash table insertion.

Signed-off-by: David Goulet <dgoulet@efficios.com>
---
 src/common/consumer.c                        |  217 ++++++++++++++++++--------
 src/common/consumer.h                        |    3 +-
 src/common/kernel-consumer/kernel-consumer.c |   13 +-
 src/common/ust-consumer/ust-consumer.c       |   20 ++-
 src/common/ust-consumer/ust-consumer.h       |    4 +-
 5 files changed, 181 insertions(+), 76 deletions(-)

diff --git a/src/common/consumer.c b/src/common/consumer.c
index 161bf7e..a3fbef6 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -230,7 +230,8 @@ void consumer_flag_relayd_for_destroy(struct consumer_relayd_sock_pair *relayd)
  * Remove a stream from the global list protected by a mutex. This
  * function is also responsible for freeing its data structures.
  */
-void consumer_del_stream(struct lttng_consumer_stream *stream)
+void consumer_del_stream(struct lttng_consumer_stream *stream,
+		struct lttng_ht *ht)
 {
 	int ret;
 	struct lttng_ht_iter iter;
@@ -239,6 +240,11 @@ void consumer_del_stream(struct lttng_consumer_stream *stream)
 
 	assert(stream);
 
+	if (ht == NULL) {
+		/* Means that the stream was never added to a hash table */
+		goto free_stream;
+	}
+
 	pthread_mutex_lock(&consumer_data.lock);
 
 	switch (consumer_data.type) {
@@ -329,7 +335,6 @@ void consumer_del_stream(struct lttng_consumer_stream *stream)
 		free_chan = stream->chan;
 	}
 
-	call_rcu(&stream->node.head, consumer_free_stream);
 end:
 	consumer_data.need_update = 1;
 	pthread_mutex_unlock(&consumer_data.lock);
@@ -337,6 +342,9 @@ end:
 	if (free_chan) {
 		consumer_del_channel(free_chan);
 	}
+
+free_stream:
+	call_rcu(&stream->node.head, consumer_free_stream);
 }
 
 struct lttng_consumer_stream *consumer_allocate_stream(
@@ -353,7 +361,6 @@ struct lttng_consumer_stream *consumer_allocate_stream(
 		int *alloc_ret)
 {
 	struct lttng_consumer_stream *stream;
-	int ret;
 
 	stream = zmalloc(sizeof(*stream));
 	if (stream == NULL) {
@@ -372,7 +379,7 @@ struct lttng_consumer_stream *consumer_allocate_stream(
 		ERR("Unable to find channel for stream %d", stream_key);
 		goto error;
 	}
-	stream->chan->refcount++;
+
 	stream->key = stream_key;
 	stream->shm_fd = shm_fd;
 	stream->wait_fd = wait_fd;
@@ -391,35 +398,6 @@ struct lttng_consumer_stream *consumer_allocate_stream(
 	lttng_ht_node_init_ulong(&stream->node, stream->key);
 	lttng_ht_node_init_ulong(&stream->waitfd_node, stream->wait_fd);
 
-	switch (consumer_data.type) {
-	case LTTNG_CONSUMER_KERNEL:
-		break;
-	case LTTNG_CONSUMER32_UST:
-	case LTTNG_CONSUMER64_UST:
-		stream->cpu = stream->chan->cpucount++;
-		ret = lttng_ustconsumer_allocate_stream(stream);
-		if (ret) {
-			*alloc_ret = -EINVAL;
-			goto error;
-		}
-		break;
-	default:
-		ERR("Unknown consumer_data type");
-		*alloc_ret = -EINVAL;
-		goto error;
-	}
-
-	/*
-	 * When nb_init_streams reaches 0, we don't need to trigger any action in
-	 * terms of destroying the associated channel, because the action that
-	 * causes the count to become 0 also causes a stream to be added. The
-	 * channel deletion will thus be triggered by the following removal of this
-	 * stream.
-	 */
-	if (uatomic_read(&stream->chan->nb_init_streams) > 0) {
-		uatomic_dec(&stream->chan->nb_init_streams);
-	}
-
 	DBG3("Allocated stream %s (key %d, shm_fd %d, wait_fd %d, mmap_len %llu,"
 			" out_fd %d, net_seq_idx %d)", stream->path_name, stream->key,
 			stream->shm_fd, stream->wait_fd,
@@ -439,22 +417,35 @@ end:
 int consumer_add_stream(struct lttng_consumer_stream *stream)
 {
 	int ret = 0;
-	struct lttng_ht_node_ulong *node;
-	struct lttng_ht_iter iter;
 	struct consumer_relayd_sock_pair *relayd;
 
-	pthread_mutex_lock(&consumer_data.lock);
-	/* Steal stream identifier, for UST */
-	consumer_steal_stream_key(stream->key, consumer_data.stream_ht);
+	assert(stream);
+
+	DBG3("Adding consumer stream %d", stream->key);
 
+	pthread_mutex_lock(&consumer_data.lock);
 	rcu_read_lock();
-	lttng_ht_lookup(consumer_data.stream_ht,
-			(void *)((unsigned long) stream->key), &iter);
-	node = lttng_ht_iter_get_node_ulong(&iter);
-	if (node != NULL) {
-		rcu_read_unlock();
-		/* Stream already exist. Ignore the insertion */
-		goto end;
+
+	switch (consumer_data.type) {
+	case LTTNG_CONSUMER_KERNEL:
+		break;
+	case LTTNG_CONSUMER32_UST:
+	case LTTNG_CONSUMER64_UST:
+		stream->cpu = stream->chan->cpucount++;
+		ret = lttng_ustconsumer_add_stream(stream);
+		if (ret) {
+			ret = -EINVAL;
+			goto error;
+		}
+
+		/* Steal stream identifier only for UST */
+		consumer_steal_stream_key(stream->key, consumer_data.stream_ht);
+		break;
+	default:
+		ERR("Unknown consumer_data type");
+		assert(0);
+		ret = -ENOSYS;
+		goto error;
 	}
 
 	lttng_ht_add_unique_ulong(consumer_data.stream_ht, &stream->node);
@@ -464,13 +455,27 @@ int consumer_add_stream(struct lttng_consumer_stream *stream)
 	if (relayd != NULL) {
 		uatomic_inc(&relayd->refcount);
 	}
-	rcu_read_unlock();
 
-	/* Update consumer data */
+	/* Update channel refcount once added without error(s). */
+	uatomic_inc(&stream->chan->refcount);
+
+	/*
+	 * When nb_init_streams reaches 0, we don't need to trigger any action in
+	 * terms of destroying the associated channel, because the action that
+	 * causes the count to become 0 also causes a stream to be added. The
+	 * channel deletion will thus be triggered by the following removal of this
+	 * stream.
+	 */
+	if (uatomic_read(&stream->chan->nb_init_streams) > 0) {
+		uatomic_dec(&stream->chan->nb_init_streams);
+	}
+
+	/* Update consumer data once the node is inserted. */
 	consumer_data.stream_count++;
 	consumer_data.need_update = 1;
 
-end:
+error:
+	rcu_read_unlock();
 	pthread_mutex_unlock(&consumer_data.lock);
 
 	return ret;
@@ -896,7 +901,7 @@ void lttng_consumer_cleanup(void)
 			node) {
 		struct lttng_consumer_stream *stream =
 			caa_container_of(node, struct lttng_consumer_stream, node);
-		consumer_del_stream(stream);
+		consumer_del_stream(stream, consumer_data.stream_ht);
 	}
 
 	cds_lfht_for_each_entry(consumer_data.channel_ht->ht, &iter.iter, node,
@@ -1545,9 +1550,12 @@ static void destroy_stream_ht(struct lttng_ht *ht)
 /*
  * Clean up a metadata stream and free its memory.
  */
-static void consumer_del_metadata_stream(struct lttng_consumer_stream *stream)
+static void consumer_del_metadata_stream(struct lttng_consumer_stream *stream,
+		struct lttng_ht *ht)
 {
 	int ret;
+	struct lttng_ht_iter iter;
+	struct lttng_consumer_channel *free_chan = NULL;
 	struct consumer_relayd_sock_pair *relayd;
 
 	assert(stream);
@@ -1557,6 +1565,16 @@ static void consumer_del_metadata_stream(struct lttng_consumer_stream *stream)
 	 */
 	assert(stream->metadata_flag);
 
+	if (ht == NULL) {
+		goto free_stream;
+	}
+
+	rcu_read_lock();
+	iter.iter.node = &stream->node.node;
+	ret = lttng_ht_del(ht, &iter);
+	assert(!ret);
+	rcu_read_unlock();
+
 	pthread_mutex_lock(&consumer_data.lock);
 	switch (consumer_data.type) {
 	case LTTNG_CONSUMER_KERNEL:
@@ -1574,8 +1592,8 @@ static void consumer_del_metadata_stream(struct lttng_consumer_stream *stream)
 	default:
 		ERR("Unknown consumer_data type");
 		assert(0);
+		goto end;
 	}
-	pthread_mutex_unlock(&consumer_data.lock);
 
 	if (stream->out_fd >= 0) {
 		ret = close(stream->out_fd);
@@ -1632,9 +1650,17 @@ static void consumer_del_metadata_stream(struct lttng_consumer_stream *stream)
 	if (!uatomic_read(&stream->chan->refcount)
 			&& !uatomic_read(&stream->chan->nb_init_streams)) {
 		/* Go for channel deletion! */
-		consumer_del_channel(stream->chan);
+		free_chan = stream->chan;
 	}
 
+end:
+	pthread_mutex_unlock(&consumer_data.lock);
+
+	if (free_chan) {
+		consumer_del_channel(free_chan);
+	}
+
+free_stream:
 	call_rcu(&stream->node.head, consumer_free_stream);
 }
 
@@ -1642,17 +1668,72 @@ static void consumer_del_metadata_stream(struct lttng_consumer_stream *stream)
  * Action done with the metadata stream when adding it to the consumer internal
  * data structures to handle it.
  */
-static void consumer_add_metadata_stream(struct lttng_consumer_stream *stream)
+static int consumer_add_metadata_stream(struct lttng_consumer_stream *stream,
+		struct lttng_ht *ht)
 {
+	int ret = 0;
 	struct consumer_relayd_sock_pair *relayd;
 
-	/* Find relayd and, if one is found, increment refcount. */
+	assert(stream);
+	assert(ht);
+
+	DBG3("Adding metadata stream %d to hash table", stream->wait_fd);
+
+	pthread_mutex_lock(&consumer_data.lock);
+
+	switch (consumer_data.type) {
+	case LTTNG_CONSUMER_KERNEL:
+		break;
+	case LTTNG_CONSUMER32_UST:
+	case LTTNG_CONSUMER64_UST:
+		ret = lttng_ustconsumer_add_stream(stream);
+		if (ret) {
+			ret = -EINVAL;
+			goto error;
+		}
+
+		/* Steal stream identifier only for UST */
+		consumer_steal_stream_key(stream->wait_fd, ht);
+		break;
+	default:
+		ERR("Unknown consumer_data type");
+		assert(0);
+		ret = -ENOSYS;
+		goto error;
+	}
+
+	/*
+	 * From here, refcounts are updated so be _careful_ when returning an error
+	 * after this point.
+	 */
+
 	rcu_read_lock();
+	/* Find relayd and, if one is found, increment refcount. */
 	relayd = consumer_find_relayd(stream->net_seq_idx);
 	if (relayd != NULL) {
 		uatomic_inc(&relayd->refcount);
 	}
+
+	/* Update channel refcount once added without error(s). */
+	uatomic_inc(&stream->chan->refcount);
+
+	/*
+	 * When nb_init_streams reaches 0, we don't need to trigger any action in
+	 * terms of destroying the associated channel, because the action that
+	 * causes the count to become 0 also causes a stream to be added. The
+	 * channel deletion will thus be triggered by the following removal of this
+	 * stream.
+	 */
+	if (uatomic_read(&stream->chan->nb_init_streams) > 0) {
+		uatomic_dec(&stream->chan->nb_init_streams);
+	}
+
+	lttng_ht_add_unique_ulong(ht, &stream->waitfd_node);
 	rcu_read_unlock();
+
+error:
+	pthread_mutex_unlock(&consumer_data.lock);
+	return ret;
 }
 
 /*
@@ -1749,17 +1830,17 @@ restart:
 					DBG("Adding metadata stream %d to poll set",
 							stream->wait_fd);
 
-					rcu_read_lock();
-					/* The node should be init at this point */
-					lttng_ht_add_unique_ulong(metadata_ht,
-							&stream->waitfd_node);
-					rcu_read_unlock();
+					ret = consumer_add_metadata_stream(stream, metadata_ht);
+					if (ret) {
+						ERR("Unable to add metadata stream");
+						/* Stream was not setup properly. Continuing. */
+						consumer_del_metadata_stream(stream, NULL);
+						continue;
+					}
 
 					/* Add metadata stream to the global poll events list */
 					lttng_poll_add(&events, stream->wait_fd,
 							LPOLLIN | LPOLLPRI);
-
-					consumer_add_metadata_stream(stream);
 				}
 
 				/* Metadata pipe handled. Continue handling the others */
@@ -1817,11 +1898,8 @@ restart:
 					}
 				}
 
-				/* Removing it from hash table, poll set and free memory */
-				lttng_ht_del(metadata_ht, &iter);
-
 				lttng_poll_del(&events, stream->wait_fd);
-				consumer_del_metadata_stream(stream);
+				consumer_del_metadata_stream(stream, metadata_ht);
 			}
 			rcu_read_unlock();
 		}
@@ -2015,19 +2093,22 @@ void *lttng_consumer_thread_poll_fds(void *data)
 			if ((pollfd[i].revents & POLLHUP)) {
 				DBG("Polling fd %d tells it has hung up.", pollfd[i].fd);
 				if (!local_stream[i]->data_read) {
-					consumer_del_stream(local_stream[i]);
+					consumer_del_stream(local_stream[i],
+							consumer_data.stream_ht);
 					num_hup++;
 				}
 			} else if (pollfd[i].revents & POLLERR) {
 				ERR("Error returned in polling fd %d.", pollfd[i].fd);
 				if (!local_stream[i]->data_read) {
-					consumer_del_stream(local_stream[i]);
+					consumer_del_stream(local_stream[i],
+							consumer_data.stream_ht);
 					num_hup++;
 				}
 			} else if (pollfd[i].revents & POLLNVAL) {
 				ERR("Polling fd %d tells fd is not open.", pollfd[i].fd);
 				if (!local_stream[i]->data_read) {
-					consumer_del_stream(local_stream[i]);
+					consumer_del_stream(local_stream[i],
+							consumer_data.stream_ht);
 					num_hup++;
 				}
 			}
diff --git a/src/common/consumer.h b/src/common/consumer.h
index 9a93c42..5af38e1 100644
--- a/src/common/consumer.h
+++ b/src/common/consumer.h
@@ -341,7 +341,8 @@ extern struct lttng_consumer_stream *consumer_allocate_stream(
 		int metadata_flag,
 		int *alloc_ret);
 extern int consumer_add_stream(struct lttng_consumer_stream *stream);
-extern void consumer_del_stream(struct lttng_consumer_stream *stream);
+extern void consumer_del_stream(struct lttng_consumer_stream *stream,
+		struct lttng_ht *ht);
 extern void consumer_change_stream_state(int stream_key,
 		enum lttng_consumer_stream_state state);
 extern void consumer_del_channel(struct lttng_consumer_channel *channel);
diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index 4d61cc5..13cbe21 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -206,18 +206,20 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 					&new_stream->relayd_stream_id);
 			pthread_mutex_unlock(&relayd->ctrl_sock_mutex);
 			if (ret < 0) {
+				consumer_del_stream(new_stream, NULL);
 				goto end_nosignal;
 			}
 		} else if (msg.u.stream.net_index != -1) {
 			ERR("Network sequence index %d unknown. Not adding stream.",
 					msg.u.stream.net_index);
-			free(new_stream);
+			consumer_del_stream(new_stream, NULL);
 			goto end_nosignal;
 		}
 
 		if (ctx->on_recv_stream) {
 			ret = ctx->on_recv_stream(new_stream);
 			if (ret < 0) {
+				consumer_del_stream(new_stream, NULL);
 				goto end_nosignal;
 			}
 		}
@@ -230,9 +232,16 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 			} while (ret < 0 && errno == EINTR);
 			if (ret < 0) {
 				PERROR("write metadata pipe");
+				consumer_del_stream(new_stream, NULL);
 			}
 		} else {
-			consumer_add_stream(new_stream);
+			ret = consumer_add_stream(new_stream);
+			if (ret) {
+				ERR("Consumer add stream %d failed. Continuing",
+						new_stream->key);
+				consumer_del_stream(new_stream, NULL);
+				goto end_nosignal;
+			}
 		}
 
 		DBG("Kernel consumer_add_stream (%d)", fd);
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index 76238a0..69da765 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -234,12 +234,13 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 					&new_stream->relayd_stream_id);
 			pthread_mutex_unlock(&relayd->ctrl_sock_mutex);
 			if (ret < 0) {
+				consumer_del_stream(new_stream, NULL);
 				goto end_nosignal;
 			}
 		} else if (msg.u.stream.net_index != -1) {
 			ERR("Network sequence index %d unknown. Not adding stream.",
 					msg.u.stream.net_index);
-			free(new_stream);
+			consumer_del_stream(new_stream, NULL);
 			goto end_nosignal;
 		}
 
@@ -247,6 +248,7 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 		if (ctx->on_recv_stream) {
 			ret = ctx->on_recv_stream(new_stream);
 			if (ret < 0) {
+				consumer_del_stream(new_stream, NULL);
 				goto end_nosignal;
 			}
 		}
@@ -259,9 +261,21 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 			} while (ret < 0 && errno == EINTR);
 			if (ret < 0) {
 				PERROR("write metadata pipe");
+				consumer_del_stream(new_stream, NULL);
+				goto end_nosignal;
 			}
 		} else {
-			consumer_add_stream(new_stream);
+			ret = consumer_add_stream(new_stream);
+			if (ret) {
+				ERR("Consumer add stream %d failed. Continuing",
+						new_stream->key);
+				/*
+				 * At this point, if the add_stream fails, it is not in the
+				 * hash table thus passing the NULL value here.
+				 */
+				consumer_del_stream(new_stream, NULL);
+				goto end_nosignal;
+			}
 		}
 
 		DBG("UST consumer_add_stream %s (%d,%d) with relayd id %" PRIu64,
@@ -373,7 +387,7 @@ void lttng_ustconsumer_del_channel(struct lttng_consumer_channel *chan)
 	ustctl_unmap_channel(chan->handle);
 }
 
-int lttng_ustconsumer_allocate_stream(struct lttng_consumer_stream *stream)
+int lttng_ustconsumer_add_stream(struct lttng_consumer_stream *stream)
 {
 	struct lttng_ust_object_data obj;
 	int ret;
diff --git a/src/common/ust-consumer/ust-consumer.h b/src/common/ust-consumer/ust-consumer.h
index 3f76f23..6b507ed 100644
--- a/src/common/ust-consumer/ust-consumer.h
+++ b/src/common/ust-consumer/ust-consumer.h
@@ -49,7 +49,7 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 
 extern int lttng_ustconsumer_allocate_channel(struct lttng_consumer_channel *chan);
 extern void lttng_ustconsumer_del_channel(struct lttng_consumer_channel *chan);
-extern int lttng_ustconsumer_allocate_stream(struct lttng_consumer_stream *stream);
+extern int lttng_ustconsumer_add_stream(struct lttng_consumer_stream *stream);
 extern void lttng_ustconsumer_del_stream(struct lttng_consumer_stream *stream);
 
 int lttng_ustconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
@@ -117,7 +117,7 @@ void lttng_ustconsumer_del_channel(struct lttng_consumer_channel *chan)
 }
 
 static inline
-int lttng_ustconsumer_allocate_stream(struct lttng_consumer_stream *stream)
+int lttng_ustconsumer_add_stream(struct lttng_consumer_stream *stream)
 {
 	return -ENOSYS;
 }
-- 
1.7.10.4
