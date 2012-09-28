From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: consumer should await for
	initial streams
Date: Fri, 28 Sep 2012 15:39:42 -0400
Message-ID: <20120928193942.GA11285__362.095997161482$1348861220$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1THgPZ-0007gT-Ei
	for lttng-dev@lists.lttng.org; Fri, 28 Sep 2012 15:39:45 -0400
Content-Disposition: inline
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

lttng-sessiond need to let the consumer know how many streams are sent
initially, so that for very short traces (short-lived apps, short kernel
trace), the consumerd don't run into the scenario where it deletes the
channel when there are still pending streams to receive for this
channel.

Fixes #355

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/src/bin/lttng-sessiond/consumer.c b/src/bin/lttng-sessiond/consumer.c
index b69df16..d33f85f 100644
--- a/src/bin/lttng-sessiond/consumer.c
+++ b/src/bin/lttng-sessiond/consumer.c
@@ -486,7 +486,8 @@ void consumer_init_channel_comm_msg(struct lttcomm_consumer_msg *msg,
 		int channel_key,
 		uint64_t max_sb_size,
 		uint64_t mmap_len,
-		const char *name)
+		const char *name,
+		unsigned int nb_init_streams)
 {
 	assert(msg);
 
@@ -500,6 +501,7 @@ void consumer_init_channel_comm_msg(struct lttcomm_consumer_msg *msg,
 	msg->u.channel.channel_key = channel_key;
 	msg->u.channel.max_sb_size = max_sb_size;
 	msg->u.channel.mmap_len = mmap_len;
+	msg->u.channel.nb_init_streams = nb_init_streams;
 }
 
 /*
diff --git a/src/bin/lttng-sessiond/consumer.h b/src/bin/lttng-sessiond/consumer.h
index 5e8ad9b..ec4ef3f 100644
--- a/src/bin/lttng-sessiond/consumer.h
+++ b/src/bin/lttng-sessiond/consumer.h
@@ -195,6 +195,7 @@ void consumer_init_channel_comm_msg(struct lttcomm_consumer_msg *msg,
 		int channel_key,
 		uint64_t max_sb_size,
 		uint64_t mmap_len,
-		const char *name);
+		const char *name,
+		unsigned int nb_init_streams);
 
 #endif /* _CONSUMER_H */
diff --git a/src/bin/lttng-sessiond/kernel-consumer.c b/src/bin/lttng-sessiond/kernel-consumer.c
index 8251213..33cbbed 100644
--- a/src/bin/lttng-sessiond/kernel-consumer.c
+++ b/src/bin/lttng-sessiond/kernel-consumer.c
@@ -48,7 +48,8 @@ int kernel_consumer_add_channel(int sock, struct ltt_kernel_channel *channel)
 			channel->fd,
 			channel->channel->attr.subbuf_size,
 			0, /* Kernel */
-			channel->channel->name);
+			channel->channel->name,
+			channel->stream_count);
 
 	ret = consumer_send_channel(sock, &lkm);
 	if (ret < 0) {
@@ -116,7 +117,8 @@ int kernel_consumer_add_metadata(int sock, struct ltt_kernel_session *session)
 			session->metadata->fd,
 			session->metadata->conf->attr.subbuf_size,
 			0, /* for kernel */
-			"metadata");
+			"metadata",
+			1);
 
 	ret = consumer_send_channel(sock, &lkm);
 	if (ret < 0) {
diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 3202cd4..fc8728d 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -2239,7 +2239,8 @@ int ust_app_start_trace(struct ltt_ust_session *usess, struct ust_app *app)
 			/* Order is important */
 			cds_list_add_tail(&ustream->list, &ua_chan->streams.head);
 			ret = snprintf(ustream->name, sizeof(ustream->name), "%s_%u",
-					ua_chan->name, ua_chan->streams.count++);
+					ua_chan->name, ua_chan->streams.count);
+			ua_chan->streams.count++;
 			if (ret < 0) {
 				PERROR("asprintf UST create stream");
 				/*
diff --git a/src/bin/lttng-sessiond/ust-consumer.c b/src/bin/lttng-sessiond/ust-consumer.c
index aabe494..44913cb 100644
--- a/src/bin/lttng-sessiond/ust-consumer.c
+++ b/src/bin/lttng-sessiond/ust-consumer.c
@@ -52,7 +52,8 @@ static int send_channel(int sock, struct ust_app_channel *uchan)
 			uchan->obj->shm_fd,
 			uchan->attr.subbuf_size,
 			uchan->obj->memory_map_size,
-			uchan->name);
+			uchan->name,
+			uchan->streams.count);
 
 	ret = consumer_send_channel(sock, &msg);
 	if (ret < 0) {
@@ -208,7 +209,8 @@ static int send_metadata(int sock, struct ust_app_session *usess,
 			usess->metadata->obj->shm_fd,
 			usess->metadata->attr.subbuf_size,
 			usess->metadata->obj->memory_map_size,
-			"metadata");
+			"metadata",
+			1);
 
 	ret = consumer_send_channel(sock, &msg);
 	if (ret < 0) {
diff --git a/src/common/consumer.c b/src/common/consumer.c
index a2980e7..be358aa 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -319,7 +319,9 @@ void consumer_del_stream(struct lttng_consumer_stream *stream)
 	}
 	rcu_read_unlock();
 
-	if (!--stream->chan->refcount) {
+	uatomic_dec(&stream->chan->refcount);
+	if (!uatomic_read(&stream->chan->refcount)
+			&& !uatomic_read(&stream->chan->nb_init_streams)) {
 		free_chan = stream->chan;
 	}
 
@@ -394,6 +396,16 @@ struct lttng_consumer_stream *consumer_allocate_stream(
 		assert(0);
 		goto end;
 	}
+	/*
+	 * When nb_init_streams reaches 0, we don't need to trigger any
+	 * action in terms of destroying the associated channel, because
+	 * the action that causes the count to become 0 also causes a
+	 * stream to be added. The channel deletion will thus be
+	 * triggered by the following removal of this stream.
+	 */
+	if (uatomic_read(&stream->chan->nb_init_streams) > 0) {
+		uatomic_dec(&stream->chan->nb_init_streams);
+	}
 	DBG("Allocated stream %s (key %d, shm_fd %d, wait_fd %d, mmap_len %llu, out_fd %d, net_seq_idx %d)",
 			stream->path_name, stream->key,
 			stream->shm_fd,
@@ -671,7 +683,8 @@ struct lttng_consumer_channel *consumer_allocate_channel(
 		int channel_key,
 		int shm_fd, int wait_fd,
 		uint64_t mmap_len,
-		uint64_t max_sb_size)
+		uint64_t max_sb_size,
+		unsigned int nb_init_streams)
 {
 	struct lttng_consumer_channel *channel;
 	int ret;
@@ -687,6 +700,7 @@ struct lttng_consumer_channel *consumer_allocate_channel(
 	channel->mmap_len = mmap_len;
 	channel->max_sb_size = max_sb_size;
 	channel->refcount = 0;
+	channel->nb_init_streams = nb_init_streams;
 	lttng_ht_node_init_ulong(&channel->node, channel->key);
 
 	switch (consumer_data.type) {
@@ -1602,7 +1616,8 @@ static void consumer_del_metadata_stream(struct lttng_consumer_stream *stream)
 
 	/* Atomically decrement channel refcount since other threads can use it. */
 	uatomic_dec(&stream->chan->refcount);
-	if (!uatomic_read(&stream->chan->refcount)) {
+	if (!uatomic_read(&stream->chan->refcount)
+			&& !uatomic_read(&stream->chan->nb_init_streams)) {
 		free_chan = stream->chan;
 	}
 
diff --git a/src/common/consumer.h b/src/common/consumer.h
index dba7765..6dbece9 100644
--- a/src/common/consumer.h
+++ b/src/common/consumer.h
@@ -77,6 +77,13 @@ struct lttng_consumer_channel {
 	int key;
 	uint64_t max_sb_size; /* the subbuffer size for this channel */
 	int refcount; /* Number of streams referencing this channel */
+	/*
+	 * nb_init_streams is the number of streams to receive
+	 * initially. Used to guarantee that we do not destroy a
+	 * channel before receiving all its associated streams.
+	 */
+	unsigned int nb_init_streams;
+
 	/* For UST */
 	int shm_fd;
 	int wait_fd;
@@ -342,7 +349,8 @@ extern struct lttng_consumer_channel *consumer_allocate_channel(
 		int channel_key,
 		int shm_fd, int wait_fd,
 		uint64_t mmap_len,
-		uint64_t max_sb_size);
+		uint64_t max_sb_size,
+		unsigned int nb_init_streams);
 int consumer_add_channel(struct lttng_consumer_channel *channel);
 
 /* lttng-relayd consumer command */
diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index f910f03..5a219fc 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -118,7 +118,8 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 		new_channel = consumer_allocate_channel(msg.u.channel.channel_key,
 				-1, -1,
 				msg.u.channel.mmap_len,
-				msg.u.channel.max_sb_size);
+				msg.u.channel.max_sb_size,
+				msg.u.channel.nb_init_streams);
 		if (new_channel == NULL) {
 			lttng_consumer_send_error(ctx, LTTCOMM_CONSUMERD_OUTFD_ERROR);
 			goto end_nosignal;
diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index 62205f4..6d796ef 100644
--- a/src/common/sessiond-comm/sessiond-comm.h
+++ b/src/common/sessiond-comm/sessiond-comm.h
@@ -255,6 +255,8 @@ struct lttcomm_consumer_msg {
 			uint64_t max_sb_size; /* the subbuffer size for this channel */
 			/* shm_fd and wait_fd are sent as ancillary data */
 			uint64_t mmap_len;
+			/* nb_init_streams is the number of streams open initially. */
+			unsigned int nb_init_streams;
 			char name[LTTNG_SYMBOL_NAME_LEN];
 		} channel;
 		struct {
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index 8ab2b81..ad4b014 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -150,7 +150,8 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 		new_channel = consumer_allocate_channel(msg.u.channel.channel_key,
 				fds[0], -1,
 				msg.u.channel.mmap_len,
-				msg.u.channel.max_sb_size);
+				msg.u.channel.max_sb_size,
+				msg.u.channel.nb_init_streams);
 		if (new_channel == NULL) {
 			lttng_consumer_send_error(ctx, LTTCOMM_CONSUMERD_OUTFD_ERROR);
 			goto end_nosignal;

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
