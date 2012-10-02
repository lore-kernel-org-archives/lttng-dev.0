From: David Goulet <dgoulet@efficios.com>
Subject: [PATCH lttng-tools] Fix: Stream allocation and
	insertion consistency
Date: Tue,  2 Oct 2012 14:15:55 -0400
Message-ID: <1349201755-7875-1-git-send-email-dgoulet__7949.3033154451$1349201798$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TJ70l-00046N-Ca
	for lttng-dev@lists.lttng.org; Tue, 02 Oct 2012 14:16:03 -0400
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
stream and updating refounts. However, before inserting the stream into
the hash table and polling on the fd for data, an error could occur
which could stop the stream insertion hence creating multiple fd leaks,
mem leaks and bad refount state.

Furthermore, the consumer_del_stream now can destroy a stream even if
that stream is not added to the global hash table.

There is also a couple of fixes adding missing rcu read side lock and a
call_rcu() on stream deletion.

Signed-off-by: David Goulet <dgoulet@efficios.com>
---
 src/common/consumer.c                  |  255 +++++++++++++++++++++-----------
 src/common/ust-consumer/ust-consumer.c |   32 +++-
 src/common/ust-consumer/ust-consumer.h |    4 +-
 3 files changed, 197 insertions(+), 94 deletions(-)

diff --git a/src/common/consumer.c b/src/common/consumer.c
index 53806b0..4f60860 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -62,20 +62,23 @@ volatile int consumer_quit = 0;
  * Find a stream. The consumer_data.lock must be locked during this
  * call.
  */
-static struct lttng_consumer_stream *consumer_find_stream(int key)
+static struct lttng_consumer_stream *consumer_find_stream(int key,
+		struct lttng_ht *ht)
 {
 	struct lttng_ht_iter iter;
 	struct lttng_ht_node_ulong *node;
 	struct lttng_consumer_stream *stream = NULL;
 
+	assert(ht);
+
 	/* Negative keys are lookup failures */
-	if (key < 0)
+	if (key < 0) {
 		return NULL;
+	}
 
 	rcu_read_lock();
 
-	lttng_ht_lookup(consumer_data.stream_ht, (void *)((unsigned long) key),
-			&iter);
+	lttng_ht_lookup(ht, (void *)((unsigned long) key), &iter);
 	node = lttng_ht_iter_get_node_ulong(&iter);
 	if (node != NULL) {
 		stream = caa_container_of(node, struct lttng_consumer_stream, node);
@@ -86,12 +89,12 @@ static struct lttng_consumer_stream *consumer_find_stream(int key)
 	return stream;
 }
 
-static void consumer_steal_stream_key(int key)
+static void consumer_steal_stream_key(int key, struct lttng_ht *ht)
 {
 	struct lttng_consumer_stream *stream;
 
 	rcu_read_lock();
-	stream = consumer_find_stream(key);
+	stream = consumer_find_stream(key, ht);
 	if (stream) {
 		stream->key = -1;
 		/*
@@ -223,8 +226,8 @@ void consumer_flag_relayd_for_destroy(struct consumer_relayd_sock_pair *relayd)
 }
 
 /*
- * Remove a stream from the global list protected by a mutex. This
- * function is also responsible for freeing its data structures.
+ * Remove a stream from the global list protected by a mutex. This function is
+ * also responsible for freeing its data structures.
  */
 void consumer_del_stream(struct lttng_consumer_stream *stream)
 {
@@ -232,10 +235,46 @@ void consumer_del_stream(struct lttng_consumer_stream *stream)
 	struct lttng_ht_iter iter;
 	struct lttng_consumer_channel *free_chan = NULL;
 	struct consumer_relayd_sock_pair *relayd;
+	struct lttng_ht_node_ulong *node;
 
 	assert(stream);
 
+	DBG3("Consumer deleting stream %d", stream->key);
+
 	pthread_mutex_lock(&consumer_data.lock);
+	rcu_read_lock();
+
+	/*
+	 * A stream with a key value of -1 means that the stream is in the hash
+	 * table but can not be looked up. This happens when consumer_add_stream is
+	 * done and we have a duplicate key before insertion.
+	 * consumer_steal_stream_key() is called to make sure we can insert a
+	 * stream even though the index is already present. Since the key is the fd
+	 * value on the session daemon side, duplicates are possible.
+	 */
+	if (stream->key != -1) {
+		lttng_ht_lookup(consumer_data.stream_ht,
+				(void *)((unsigned long) stream->key), &iter);
+		node = lttng_ht_iter_get_node_ulong(&iter);
+		if (node == NULL) {
+			rcu_read_unlock();
+
+			/*
+			 * Stream doest not exist in hash table. This can happen if we hit
+			 * an error after allocation but before adding it to the table. We
+			 * consider that if the node is not in the hash table and has a
+			 * valid key, no ustctl/ioctl nor mmap action was done hence
+			 * jumping to the RCU free.
+			 */
+			DBG2("Consumer stream key %d not found during deletion", stream->key);
+			goto free_stream;
+		} else {
+			/* Remove stream from hash table and continue */
+			ret = lttng_ht_del(consumer_data.stream_ht, &iter);
+			assert(!ret);
+		}
+	}
+	rcu_read_unlock();
 
 	switch (consumer_data.type) {
 	case LTTNG_CONSUMER_KERNEL:
@@ -256,20 +295,10 @@ void consumer_del_stream(struct lttng_consumer_stream *stream)
 		goto end;
 	}
 
-	rcu_read_lock();
-	iter.iter.node = &stream->node.node;
-	ret = lttng_ht_del(consumer_data.stream_ht, &iter);
-	assert(!ret);
-
-	rcu_read_unlock();
-
-	if (consumer_data.stream_count <= 0) {
-		goto end;
-	}
+	/* This should NEVER reach a negative value. */
+	assert(consumer_data.stream_count >= 0);
 	consumer_data.stream_count--;
-	if (!stream) {
-		goto end;
-	}
+
 	if (stream->out_fd >= 0) {
 		ret = close(stream->out_fd);
 		if (ret) {
@@ -317,7 +346,6 @@ void consumer_del_stream(struct lttng_consumer_stream *stream)
 			destroy_relayd(relayd);
 		}
 	}
-	rcu_read_unlock();
 
 	uatomic_dec(&stream->chan->refcount);
 	if (!uatomic_read(&stream->chan->refcount)
@@ -325,7 +353,6 @@ void consumer_del_stream(struct lttng_consumer_stream *stream)
 		free_chan = stream->chan;
 	}
 
-	call_rcu(&stream->node.head, consumer_free_stream);
 end:
 	consumer_data.need_update = 1;
 	pthread_mutex_unlock(&consumer_data.lock);
@@ -333,6 +360,10 @@ end:
 	if (free_chan) {
 		consumer_del_channel(free_chan);
 	}
+
+free_stream:
+	call_rcu(&stream->node.head, consumer_free_stream);
+	rcu_read_unlock();
 }
 
 struct lttng_consumer_stream *consumer_allocate_stream(
@@ -349,20 +380,25 @@ struct lttng_consumer_stream *consumer_allocate_stream(
 		int *alloc_ret)
 {
 	struct lttng_consumer_stream *stream;
-	int ret;
 
 	stream = zmalloc(sizeof(*stream));
 	if (stream == NULL) {
-		perror("malloc struct lttng_consumer_stream");
+		PERROR("malloc struct lttng_consumer_stream");
 		*alloc_ret = -ENOMEM;
-		return NULL;
+		goto end;
 	}
+
+	/*
+	 * Get stream's channel reference. Needed when adding the stream to the
+	 * global hash table.
+	 */
 	stream->chan = consumer_find_channel(channel_key);
 	if (!stream->chan) {
 		*alloc_ret = -ENOENT;
+		ERR("Unable to find channel for stream %d", stream_key);
 		goto error;
 	}
-	stream->chan->refcount++;
+
 	stream->key = stream_key;
 	stream->shm_fd = shm_fd;
 	stream->wait_fd = wait_fd;
@@ -381,35 +417,6 @@ struct lttng_consumer_stream *consumer_allocate_stream(
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
@@ -419,6 +426,7 @@ struct lttng_consumer_stream *consumer_allocate_stream(
 
 error:
 	free(stream);
+end:
 	return NULL;
 }
 
@@ -428,38 +436,66 @@ error:
 int consumer_add_stream(struct lttng_consumer_stream *stream)
 {
 	int ret = 0;
-	struct lttng_ht_node_ulong *node;
-	struct lttng_ht_iter iter;
 	struct consumer_relayd_sock_pair *relayd;
 
-	pthread_mutex_lock(&consumer_data.lock);
-	/* Steal stream identifier, for UST */
-	consumer_steal_stream_key(stream->key);
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
-	}
 
-	lttng_ht_add_unique_ulong(consumer_data.stream_ht, &stream->node);
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
+	}
 
 	/* Check and cleanup relayd */
 	relayd = consumer_find_relayd(stream->net_seq_idx);
 	if (relayd != NULL) {
 		uatomic_inc(&relayd->refcount);
 	}
-	rcu_read_unlock();
 
-	/* Update consumer data */
+	/* Final operation is to add the stream to the global hash table. */
+	lttng_ht_add_unique_ulong(consumer_data.stream_ht, &stream->node);
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
+	/* Update consumer data once the node is inserted. */
 	consumer_data.stream_count++;
 	consumer_data.need_update = 1;
 
-end:
+error:
+	rcu_read_unlock();
 	pthread_mutex_unlock(&consumer_data.lock);
 
 	return ret;
@@ -611,7 +647,7 @@ void consumer_change_stream_state(int stream_key,
 	struct lttng_consumer_stream *stream;
 
 	pthread_mutex_lock(&consumer_data.lock);
-	stream = consumer_find_stream(stream_key);
+	stream = consumer_find_stream(stream_key, consumer_data.stream_ht);
 	if (stream) {
 		stream->state = state;
 	}
@@ -679,7 +715,9 @@ void consumer_del_channel(struct lttng_consumer_channel *channel)
 		}
 	}
 
+	rcu_read_lock();
 	call_rcu(&channel->node.head, consumer_free_channel);
+	rcu_read_unlock();
 end:
 	pthread_mutex_unlock(&consumer_data.lock);
 }
@@ -1526,7 +1564,7 @@ static void destroy_stream_ht(struct lttng_ht *ht)
 		ret = lttng_ht_del(ht, &iter);
 		assert(!ret);
 
-		free(stream);
+		call_rcu(&stream->node.head, consumer_free_stream);
 	}
 	rcu_read_unlock();
 
@@ -1626,17 +1664,46 @@ static void consumer_del_metadata_stream(struct lttng_consumer_stream *stream)
 		consumer_del_channel(stream->chan);
 	}
 
-	free(stream);
+	rcu_read_lock();
+	call_rcu(&stream->node.head, consumer_free_stream);
+	rcu_read_unlock();
 }
 
 /*
  * Action done with the metadata stream when adding it to the consumer internal
  * data structures to handle it.
  */
-static void consumer_add_metadata_stream(struct lttng_consumer_stream *stream)
+static int consumer_add_metadata_stream(struct lttng_consumer_stream *stream,
+		struct lttng_ht *ht)
 {
+	int ret = 0;
 	struct consumer_relayd_sock_pair *relayd;
 
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
+		consumer_steal_stream_key(stream->key, ht);
+		break;
+	default:
+		ERR("Unknown consumer_data type");
+		assert(0);
+		return -ENOSYS;
+	}
+
+	/*
+	 * From here, refcounts are updated so be _careful_ when returning an error
+	 * after this point.
+	 */
+
 	/* Find relayd and, if one is found, increment refcount. */
 	rcu_read_lock();
 	relayd = consumer_find_relayd(stream->net_seq_idx);
@@ -1644,6 +1711,27 @@ static void consumer_add_metadata_stream(struct lttng_consumer_stream *stream)
 		uatomic_inc(&relayd->refcount);
 	}
 	rcu_read_unlock();
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
+	rcu_read_lock();
+	lttng_ht_add_unique_ulong(ht, &stream->waitfd_node);
+	rcu_read_unlock();
+
+error:
+	return ret;
 }
 
 /*
@@ -1740,17 +1828,16 @@ restart:
 					DBG("Adding metadata stream %d to poll set",
 							stream->wait_fd);
 
-					rcu_read_lock();
-					/* The node should be init at this point */
-					lttng_ht_add_unique_ulong(metadata_ht,
-							&stream->waitfd_node);
-					rcu_read_unlock();
+					ret = consumer_add_metadata_stream(stream, metadata_ht);
+					if (ret) {
+						/* Stream was not setup properly. Continuing. */
+						free(stream);
+						continue;
+					}
 
 					/* Add metadata stream to the global poll events list */
 					lttng_poll_add(&events, stream->wait_fd,
 							LPOLLIN | LPOLLPRI);
-
-					consumer_add_metadata_stream(stream);
 				}
 
 				/* Metadata pipe handled. Continue handling the others */
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index f57e2e6..e10d540 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -190,9 +190,8 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 			return ret;
 		}
 
-		DBG("consumer_add_stream chan %d stream %d",
-				msg.u.stream.channel_key,
-				msg.u.stream.stream_key);
+		DBG("Consumer command ADD_STREAM chan %d stream %d",
+				msg.u.stream.channel_key, msg.u.stream.stream_key);
 
 		assert(msg.u.stream.output == LTTNG_EVENT_MMAP);
 		new_stream = consumer_allocate_stream(msg.u.stream.channel_key,
@@ -235,12 +234,13 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 					&new_stream->relayd_stream_id);
 			pthread_mutex_unlock(&relayd->ctrl_sock_mutex);
 			if (ret < 0) {
+				consumer_del_stream(new_stream);
 				goto end_nosignal;
 			}
 		} else if (msg.u.stream.net_index != -1) {
 			ERR("Network sequence index %d unknown. Not adding stream.",
 					msg.u.stream.net_index);
-			free(new_stream);
+			consumer_del_stream(new_stream);
 			goto end_nosignal;
 		}
 
@@ -248,6 +248,7 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 		if (ctx->on_recv_stream) {
 			ret = ctx->on_recv_stream(new_stream);
 			if (ret < 0) {
+				consumer_del_stream(new_stream);
 				goto end_nosignal;
 			}
 		}
@@ -260,9 +261,17 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 			} while (ret < 0 && errno == EINTR);
 			if (ret < 0) {
 				PERROR("write metadata pipe");
+				consumer_del_stream(new_stream);
+				goto end_nosignal;
 			}
 		} else {
-			consumer_add_stream(new_stream);
+			ret = consumer_add_stream(new_stream);
+			if (ret) {
+				ERR("Consumer add stream %d failed. Continuing",
+						new_stream->key);
+				consumer_del_stream(new_stream);
+				goto end_nosignal;
+			}
 		}
 
 		DBG("UST consumer_add_stream %s (%d,%d) with relayd id %" PRIu64,
@@ -374,7 +383,7 @@ void lttng_ustconsumer_del_channel(struct lttng_consumer_channel *chan)
 	ustctl_unmap_channel(chan->handle);
 }
 
-int lttng_ustconsumer_allocate_stream(struct lttng_consumer_stream *stream)
+int lttng_ustconsumer_add_stream(struct lttng_consumer_stream *stream)
 {
 	struct lttng_ust_object_data obj;
 	int ret;
@@ -384,17 +393,24 @@ int lttng_ustconsumer_allocate_stream(struct lttng_consumer_stream *stream)
 	obj.wait_fd = stream->wait_fd;
 	obj.memory_map_size = stream->mmap_len;
 	ret = ustctl_add_stream(stream->chan->handle, &obj);
-	if (ret)
+	if (ret) {
+		ERR("UST ctl add_stream failed with ret %d", ret);
 		return ret;
+	}
+
 	stream->buf = ustctl_open_stream_read(stream->chan->handle, stream->cpu);
-	if (!stream->buf)
+	if (!stream->buf) {
+		ERR("UST ctl open_stream_read failed");
 		return -EBUSY;
+	}
+
 	/* ustctl_open_stream_read has closed the shm fd. */
 	stream->wait_fd_is_copy = 1;
 	stream->shm_fd = -1;
 
 	stream->mmap_base = ustctl_get_mmap_base(stream->chan->handle, stream->buf);
 	if (!stream->mmap_base) {
+		ERR("UST ctl get_mmap_base failed");
 		return -EINVAL;
 	}
 
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
