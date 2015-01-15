From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2/2] Fix: grab more than one packet
	for snapshots
Date: Thu, 15 Jan 2015 17:24:27 -0500
Message-ID: <1421360667-9017-2-git-send-email-mathieu.desnoyers__32808.9452734732$1421360740$gmane$org@efficios.com>
References: <1421360667-9017-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1YBsqL-0002ph-Hc
 for lttng-dev@lists.lttng.org; Thu, 15 Jan 2015 17:24:48 -0500
In-Reply-To: <1421360667-9017-1-git-send-email-mathieu.desnoyers@efficios.com>
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

There are a few issues with snapshot size: when taking a snapshot
without specifying any "max size" (should be unlimited), only a single
packet from each stream is saved. We expect all stream available content
to be saved. There is a similar issue when a max size is specified.

Also, trying to make all streams save as much data has unexpected
corner-cases: for instance, if we have this configuration:
- kernel channels: 2 subbuffers of 1MB x 8 CPUs
- per-PID UST channels: 16 subbuffers of 4kB x 8 CPUs x 100 apps

would require the user to have a very large max size, since it would try
to fit (8 + (100 * 8)) * 1MB = 808MB of sub-buffers, else it would fail.
This issue here is using the largest subbuffer size as the criterion
applied to all channels.

We fix those issues by simplifying the algorithm used to calculate how
much data to grab. Rather than calculating the size to grab from each
stream, we calculate a number of packets to grab. It fails if we cannot
grab at least one packet from each stream in the session. Then checks if
it can grab 2 packets from each stream, and so on, until there is no
more space available (based on max size). This is not a perfect
solution, but has the merit of being simple to understand, and has no
(or few) unexpected corner-cases.

Fixes #860

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 doc/man/lttng.1                              |   4 -
 src/bin/lttng-sessiond/buffer-registry.h     |   2 +
 src/bin/lttng-sessiond/cmd.c                 | 179 ++++++++++++++-------------
 src/bin/lttng-sessiond/consumer.c            |   4 +-
 src/bin/lttng-sessiond/consumer.h            |   2 +-
 src/bin/lttng-sessiond/kernel.c              |   7 +-
 src/bin/lttng-sessiond/kernel.h              |   3 +-
 src/bin/lttng-sessiond/snapshot.c            |   5 +-
 src/bin/lttng-sessiond/ust-app.c             |  40 ++++--
 src/bin/lttng-sessiond/ust-app.h             |   6 +-
 src/bin/lttng/commands/snapshot.c            |   4 +-
 src/common/align.h                           |   2 +-
 src/common/consumer.c                        |  30 +++--
 src/common/consumer.h                        |   5 +-
 src/common/kernel-consumer/kernel-consumer.c |  15 +--
 src/common/sessiond-comm/sessiond-comm.h     |   2 +-
 src/common/ust-consumer/ust-consumer.c       |  11 +-
 17 files changed, 170 insertions(+), 151 deletions(-)

diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
index dda9095..24dcf88 100644
--- a/doc/man/lttng.1
+++ b/doc/man/lttng.1
@@ -935,10 +935,6 @@ Name of the snapshot's output.
 Maximum size in bytes of the snapshot. The maximum size does not include the
 metadata file. Human readable format is accepted: {+k,+M,+G}. For instance,
 \-\-max-size 5M
-
-The minimum size of a snapshot is computed by multiplying the total amount of
-streams in the session by the largest subbuffer size. This is to ensure
-fairness between channels when extracting data.
 .TP
 .BR "\-C, \-\-ctrl-url URL"
 Set control path URL. (Must use -D also)
diff --git a/src/bin/lttng-sessiond/buffer-registry.h b/src/bin/lttng-sessiond/buffer-registry.h
index c2099b6..656fc91 100644
--- a/src/bin/lttng-sessiond/buffer-registry.h
+++ b/src/bin/lttng-sessiond/buffer-registry.h
@@ -51,6 +51,8 @@ struct buffer_reg_channel {
 	struct lttng_ht_node_u64 node;
 	/* Size of subbuffers in this channel. */
 	size_t subbuf_size;
+	/* Number of subbuffers per stream. */
+	size_t num_subbuf;
 	union {
 		/* Original object data that MUST be copied over. */
 		struct lttng_ust_object_data *ust;
diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index 58506b2..06b015f 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -2942,7 +2942,7 @@ error:
  */
 static int record_kernel_snapshot(struct ltt_kernel_session *ksess,
 		struct snapshot_output *output, struct ltt_session *session,
-		int wait, uint64_t max_stream_size)
+		int wait, uint64_t nb_packets_per_stream)
 {
 	int ret;
 
@@ -2973,7 +2973,7 @@ static int record_kernel_snapshot(struct ltt_kernel_session *ksess,
 		goto error_snapshot;
 	}
 
-	ret = kernel_snapshot_record(ksess, output, wait, max_stream_size);
+	ret = kernel_snapshot_record(ksess, output, wait, nb_packets_per_stream);
 	if (ret != LTTNG_OK) {
 		goto error_snapshot;
 	}
@@ -2996,7 +2996,7 @@ end:
  */
 static int record_ust_snapshot(struct ltt_ust_session *usess,
 		struct snapshot_output *output, struct ltt_session *session,
-		int wait, uint64_t max_stream_size)
+		int wait, uint64_t nb_packets_per_stream)
 {
 	int ret;
 
@@ -3027,7 +3027,7 @@ static int record_ust_snapshot(struct ltt_ust_session *usess,
 		goto error_snapshot;
 	}
 
-	ret = ust_app_snapshot_record(usess, output, wait, max_stream_size);
+	ret = ust_app_snapshot_record(usess, output, wait, nb_packets_per_stream);
 	if (ret < 0) {
 		switch (-ret) {
 		case EINVAL:
@@ -3052,69 +3052,90 @@ error:
 	return ret;
 }
 
-/*
- * Return the biggest subbuffer size of all channels in the given session.
- */
-static uint64_t get_session_max_subbuf_size(struct ltt_session *session)
+static
+uint64_t get_session_size_one_more_packet_per_stream(struct ltt_session *session,
+	uint64_t cur_nr_packets)
 {
-	uint64_t max_size = 0;
-
-	assert(session);
+	uint64_t tot_size = 0;
 
 	if (session->kernel_session) {
 		struct ltt_kernel_channel *chan;
 		struct ltt_kernel_session *ksess = session->kernel_session;
 
-		/*
-		 * For each channel, add to the max size the size of each subbuffer
-		 * multiplied by their sized.
-		 */
 		cds_list_for_each_entry(chan, &ksess->channel_list.head, list) {
-			if (chan->channel->attr.subbuf_size > max_size) {
-				max_size = chan->channel->attr.subbuf_size;
+			if (cur_nr_packets >= chan->channel->attr.num_subbuf) {
+				/*
+				 * Don't take channel into account if we
+				 * already grab all its packets.
+				 */
+				continue;
 			}
+			tot_size += chan->channel->attr.subbuf_size
+				* chan->stream_count;
 		}
 	}
 
 	if (session->ust_session) {
-		struct lttng_ht_iter iter;
-		struct ltt_ust_channel *uchan;
 		struct ltt_ust_session *usess = session->ust_session;
 
-		rcu_read_lock();
-		cds_lfht_for_each_entry(usess->domain_global.channels->ht, &iter.iter,
-				uchan, node.node) {
-			if (uchan->attr.subbuf_size > max_size) {
-				max_size = uchan->attr.subbuf_size;
-			}
-		}
-		rcu_read_unlock();
+		tot_size += ust_app_get_size_one_more_packet_per_stream(usess,
+				cur_nr_packets);
 	}
 
-	return max_size;
+	return tot_size;
 }
 
 /*
- * Returns the total number of streams for a session or a negative value
- * on error.
+ * Calculate the number of packets we can grab from each stream that
+ * fits within the overall snapshot max size.
+ *
+ * Returns -1 on error, 0 means infinite number of packets, else > 0 is
+ * the number of packets per stream.
+ *
+ * TODO: this approach is not perfect: we consider the worse case
+ * (packet filling the sub-buffers) as an upper bound, but we could do
+ * better if we do this calculation while we actually grab the packet
+ * content: we would know how much padding we don't actually store into
+ * the file.
+ *
+ * This algorithm is currently bounded by the number of packets per
+ * stream.
+ *
+ * Since we call this algorithm before actually grabbing the data, it's
+ * an approximation: for instance, applications could appear/disappear
+ * in between this call and actually grabbing data.
  */
-static unsigned int get_session_nb_streams(struct ltt_session *session)
+static
+int64_t get_session_nb_packets_per_stream(struct ltt_session *session, uint64_t max_size)
 {
-	unsigned int total_streams = 0;
-
-	if (session->kernel_session) {
-		struct ltt_kernel_session *ksess = session->kernel_session;
+	int64_t size_left;
+	uint64_t cur_nb_packets = 0;
 
-		total_streams += ksess->stream_count_global;
+	if (!max_size) {
+		return 0;	/* Infinite */
 	}
 
-	if (session->ust_session) {
-		struct ltt_ust_session *usess = session->ust_session;
+	size_left = max_size;
+	for (;;) {
+		uint64_t one_more_packet_tot_size;
 
-		total_streams += ust_app_get_nb_stream(usess);
+		one_more_packet_tot_size = get_session_size_one_more_packet_per_stream(session,
+					cur_nb_packets);
+		if (!one_more_packet_tot_size) {
+			/* We are already grabbing all packets. */
+			break;
+		}
+		size_left -= one_more_packet_tot_size;
+		if (size_left < 0) {
+			break;
+		}
+		cur_nb_packets++;
 	}
-
-	return total_streams;
+	if (!cur_nb_packets) {
+		/* Not enough room to grab one packet of each stream, error. */
+		return -1;
+	}
+	return cur_nb_packets;
 }
 
 /*
@@ -3132,7 +3153,6 @@ int cmd_snapshot_record(struct ltt_session *session,
 	unsigned int use_tmp_output = 0;
 	struct snapshot_output tmp_output;
 	unsigned int nb_streams, snapshot_success = 0;
-	uint64_t session_max_size = 0, max_stream_size = 0;
 
 	assert(session);
 	assert(output);
@@ -3172,44 +3192,20 @@ int cmd_snapshot_record(struct ltt_session *session,
 		use_tmp_output = 1;
 	}
 
-	/*
-	 * Get the session maximum size for a snapshot meaning it will compute the
-	 * size of all streams from all domain.
-	 */
-	max_stream_size = get_session_max_subbuf_size(session);
-
-	nb_streams = get_session_nb_streams(session);
-	if (nb_streams) {
-		/*
-		 * The maximum size of the snapshot is the number of streams multiplied
-		 * by the biggest subbuf size of all channels in a session which is the
-		 * maximum stream size available for each stream. The session max size
-		 * is now checked against the snapshot max size value given by the user
-		 * and if lower, an error is returned.
-		 */
-		session_max_size = max_stream_size * nb_streams;
-	}
-
-	DBG3("Snapshot max size is %" PRIu64 " for max stream size of %" PRIu64,
-			session_max_size, max_stream_size);
-
-	/*
-	 * If we use a temporary output, check right away if the max size fits else
-	 * for each output the max size will be checked.
-	 */
-	if (use_tmp_output &&
-			(tmp_output.max_size != 0 &&
-			tmp_output.max_size < session_max_size)) {
-		ret = LTTNG_ERR_MAX_SIZE_INVALID;
-		goto error;
-	}
-
 	if (session->kernel_session) {
 		struct ltt_kernel_session *ksess = session->kernel_session;
 
 		if (use_tmp_output) {
+			int64_t nb_packets_per_stream;
+
+			nb_packets_per_stream = get_session_nb_packets_per_stream(session,
+					tmp_output.max_size);
+			if (nb_packets_per_stream < 0) {
+				ret = LTTNG_ERR_MAX_SIZE_INVALID;
+				goto error;
+			}
 			ret = record_kernel_snapshot(ksess, &tmp_output, session,
-					wait, max_stream_size);
+					wait, nb_packets_per_stream);
 			if (ret != LTTNG_OK) {
 				goto error;
 			}
@@ -3221,6 +3217,8 @@ int cmd_snapshot_record(struct ltt_session *session,
 			rcu_read_lock();
 			cds_lfht_for_each_entry(session->snapshot.output_ht->ht,
 					&iter.iter, sout, node.node) {
+				int64_t nb_packets_per_stream;
+
 				/*
 				 * Make a local copy of the output and assign the possible
 				 * temporary value given by the caller.
@@ -3228,14 +3226,13 @@ int cmd_snapshot_record(struct ltt_session *session,
 				memset(&tmp_output, 0, sizeof(tmp_output));
 				memcpy(&tmp_output, sout, sizeof(tmp_output));
 
-				/* Use temporary max size. */
 				if (output->max_size != (uint64_t) -1ULL) {
 					tmp_output.max_size = output->max_size;
 				}
 
-				if (tmp_output.max_size != 0 &&
-						tmp_output.max_size < session_max_size) {
-					rcu_read_unlock();
+				nb_packets_per_stream = get_session_nb_packets_per_stream(session,
+						tmp_output.max_size);
+				if (nb_packets_per_stream < 0) {
 					ret = LTTNG_ERR_MAX_SIZE_INVALID;
 					goto error;
 				}
@@ -3249,7 +3246,7 @@ int cmd_snapshot_record(struct ltt_session *session,
 				tmp_output.nb_snapshot = session->snapshot.nb_snapshot;
 
 				ret = record_kernel_snapshot(ksess, &tmp_output,
-						session, wait, max_stream_size);
+						session, wait, nb_packets_per_stream);
 				if (ret != LTTNG_OK) {
 					rcu_read_unlock();
 					goto error;
@@ -3264,8 +3261,16 @@ int cmd_snapshot_record(struct ltt_session *session,
 		struct ltt_ust_session *usess = session->ust_session;
 
 		if (use_tmp_output) {
+			int64_t nb_packets_per_stream;
+
+			nb_packets_per_stream = get_session_nb_packets_per_stream(session,
+					tmp_output.max_size);
+			if (nb_packets_per_stream < 0) {
+				ret = LTTNG_ERR_MAX_SIZE_INVALID;
+				goto error;
+			}
 			ret = record_ust_snapshot(usess, &tmp_output, session,
-					wait, max_stream_size);
+					wait, nb_packets_per_stream);
 			if (ret != LTTNG_OK) {
 				goto error;
 			}
@@ -3277,6 +3282,8 @@ int cmd_snapshot_record(struct ltt_session *session,
 			rcu_read_lock();
 			cds_lfht_for_each_entry(session->snapshot.output_ht->ht,
 					&iter.iter, sout, node.node) {
+				int64_t nb_packets_per_stream;
+
 				/*
 				 * Make a local copy of the output and assign the possible
 				 * temporary value given by the caller.
@@ -3284,15 +3291,15 @@ int cmd_snapshot_record(struct ltt_session *session,
 				memset(&tmp_output, 0, sizeof(tmp_output));
 				memcpy(&tmp_output, sout, sizeof(tmp_output));
 
-				/* Use temporary max size. */
 				if (output->max_size != (uint64_t) -1ULL) {
 					tmp_output.max_size = output->max_size;
 				}
 
-				if (tmp_output.max_size != 0 &&
-						tmp_output.max_size < session_max_size) {
-					rcu_read_unlock();
+				nb_packets_per_stream = get_session_nb_packets_per_stream(session,
+						tmp_output.max_size);
+				if (nb_packets_per_stream < 0) {
 					ret = LTTNG_ERR_MAX_SIZE_INVALID;
+					rcu_read_unlock();
 					goto error;
 				}
 
@@ -3305,7 +3312,7 @@ int cmd_snapshot_record(struct ltt_session *session,
 				tmp_output.nb_snapshot = session->snapshot.nb_snapshot;
 
 				ret = record_ust_snapshot(usess, &tmp_output, session,
-						wait, max_stream_size);
+						wait, nb_packets_per_stream);
 				if (ret != LTTNG_OK) {
 					rcu_read_unlock();
 					goto error;
diff --git a/src/bin/lttng-sessiond/consumer.c b/src/bin/lttng-sessiond/consumer.c
index 42738bc..9b8a0a7 100644
--- a/src/bin/lttng-sessiond/consumer.c
+++ b/src/bin/lttng-sessiond/consumer.c
@@ -1277,7 +1277,7 @@ end:
  */
 int consumer_snapshot_channel(struct consumer_socket *socket, uint64_t key,
 		struct snapshot_output *output, int metadata, uid_t uid, gid_t gid,
-		const char *session_path, int wait, int max_stream_size)
+		const char *session_path, int wait, uint64_t nb_packets_per_stream)
 {
 	int ret;
 	struct lttcomm_consumer_msg msg;
@@ -1291,7 +1291,7 @@ int consumer_snapshot_channel(struct consumer_socket *socket, uint64_t key,
 	memset(&msg, 0, sizeof(msg));
 	msg.cmd_type = LTTNG_CONSUMER_SNAPSHOT_CHANNEL;
 	msg.u.snapshot_channel.key = key;
-	msg.u.snapshot_channel.max_stream_size = max_stream_size;
+	msg.u.snapshot_channel.nb_packets_per_stream = nb_packets_per_stream;
 	msg.u.snapshot_channel.metadata = metadata;
 
 	if (output->consumer->type == CONSUMER_DST_NET) {
diff --git a/src/bin/lttng-sessiond/consumer.h b/src/bin/lttng-sessiond/consumer.h
index 3601ed9..a9266d5 100644
--- a/src/bin/lttng-sessiond/consumer.h
+++ b/src/bin/lttng-sessiond/consumer.h
@@ -279,6 +279,6 @@ int consumer_flush_channel(struct consumer_socket *socket, uint64_t key);
 /* Snapshot command. */
 int consumer_snapshot_channel(struct consumer_socket *socket, uint64_t key,
 		struct snapshot_output *output, int metadata, uid_t uid, gid_t gid,
-		const char *session_path, int wait, int max_size_per_stream);
+		const char *session_path, int wait, uint64_t nb_packets_per_stream);
 
 #endif /* _CONSUMER_H */
diff --git a/src/bin/lttng-sessiond/kernel.c b/src/bin/lttng-sessiond/kernel.c
index 6b404c0..9464a84 100644
--- a/src/bin/lttng-sessiond/kernel.c
+++ b/src/bin/lttng-sessiond/kernel.c
@@ -853,7 +853,8 @@ void kernel_destroy_channel(struct ltt_kernel_channel *kchan)
  * Return 0 on success or else return a LTTNG_ERR code.
  */
 int kernel_snapshot_record(struct ltt_kernel_session *ksess,
-		struct snapshot_output *output, int wait, uint64_t max_size_per_stream)
+		struct snapshot_output *output, int wait,
+		uint64_t nb_packets_per_stream)
 {
 	int err, ret, saved_metadata_fd;
 	struct consumer_socket *socket;
@@ -914,7 +915,7 @@ int kernel_snapshot_record(struct ltt_kernel_session *ksess,
 			ret = consumer_snapshot_channel(socket, chan->fd, output, 0,
 					ksess->uid, ksess->gid,
 					DEFAULT_KERNEL_TRACE_DIR, wait,
-					max_size_per_stream);
+					nb_packets_per_stream);
 			pthread_mutex_unlock(socket->lock);
 			if (ret < 0) {
 				ret = LTTNG_ERR_KERN_CONSUMER_FAIL;
@@ -928,7 +929,7 @@ int kernel_snapshot_record(struct ltt_kernel_session *ksess,
 		pthread_mutex_lock(socket->lock);
 		ret = consumer_snapshot_channel(socket, ksess->metadata->fd, output,
 				1, ksess->uid, ksess->gid,
-				DEFAULT_KERNEL_TRACE_DIR, wait, max_size_per_stream);
+				DEFAULT_KERNEL_TRACE_DIR, wait, 0);
 		pthread_mutex_unlock(socket->lock);
 		if (ret < 0) {
 			ret = LTTNG_ERR_KERN_CONSUMER_FAIL;
diff --git a/src/bin/lttng-sessiond/kernel.h b/src/bin/lttng-sessiond/kernel.h
index d6332e2..09c3ed9 100644
--- a/src/bin/lttng-sessiond/kernel.h
+++ b/src/bin/lttng-sessiond/kernel.h
@@ -59,7 +59,8 @@ int kernel_validate_version(int tracer_fd);
 void kernel_destroy_session(struct ltt_kernel_session *ksess);
 void kernel_destroy_channel(struct ltt_kernel_channel *kchan);
 int kernel_snapshot_record(struct ltt_kernel_session *ksess,
-		struct snapshot_output *output, int wait, uint64_t max_stream_size);
+		struct snapshot_output *output, int wait,
+		uint64_t nb_packets_per_stream);
 int kernel_syscall_mask(int chan_fd, char **syscall_mask, uint32_t *nr_bits);
 
 int init_kernel_workarounds(void);
diff --git a/src/bin/lttng-sessiond/snapshot.c b/src/bin/lttng-sessiond/snapshot.c
index 1060269..f9366b3 100644
--- a/src/bin/lttng-sessiond/snapshot.c
+++ b/src/bin/lttng-sessiond/snapshot.c
@@ -47,10 +47,11 @@ static int output_init(uint64_t max_size, const char *name,
 {
 	int ret = 0, i;
 
-	assert(output);
-
 	memset(output, 0, sizeof(struct snapshot_output));
 
+	/*
+	 * max_size of -1ULL means unset. Set to default (unlimited).
+	 */
 	if (max_size == (uint64_t) -1ULL) {
 		max_size = 0;
 	}
diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 0c4045c..41a6d39 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -2395,6 +2395,7 @@ static int create_buffer_reg_channel(struct buffer_reg_session *reg_sess,
 	assert(reg_chan);
 	reg_chan->consumer_key = ua_chan->key;
 	reg_chan->subbuf_size = ua_chan->attr.subbuf_size;
+	reg_chan->num_subbuf = ua_chan->attr.num_subbuf;
 
 	/* Create and add a channel registry to session. */
 	ret = ust_registry_channel_add(reg_sess->reg.ust,
@@ -5083,7 +5084,8 @@ void ust_app_destroy(struct ust_app *app)
  * Return 0 on success or else a negative value.
  */
 int ust_app_snapshot_record(struct ltt_ust_session *usess,
-		struct snapshot_output *output, int wait, uint64_t max_stream_size)
+		struct snapshot_output *output, int wait,
+		uint64_t nb_packets_per_stream)
 {
 	int ret = 0;
 	unsigned int snapshot_done = 0;
@@ -5127,14 +5129,14 @@ int ust_app_snapshot_record(struct ltt_ust_session *usess,
 					reg_chan, node.node) {
 				ret = consumer_snapshot_channel(socket, reg_chan->consumer_key,
 						output, 0, usess->uid, usess->gid, pathname, wait,
-						max_stream_size);
+						nb_packets_per_stream);
 				if (ret < 0) {
 					goto error;
 				}
 			}
 			ret = consumer_snapshot_channel(socket,
 					reg->registry->reg.ust->metadata_key, output, 1,
-					usess->uid, usess->gid, pathname, wait, max_stream_size);
+					usess->uid, usess->gid, pathname, wait, 0);
 			if (ret < 0) {
 				goto error;
 			}
@@ -5178,7 +5180,7 @@ int ust_app_snapshot_record(struct ltt_ust_session *usess,
 					ua_chan, node.node) {
 				ret = consumer_snapshot_channel(socket, ua_chan->key, output,
 						0, ua_sess->euid, ua_sess->egid, pathname, wait,
-						max_stream_size);
+						nb_packets_per_stream);
 				if (ret < 0) {
 					goto error;
 				}
@@ -5187,8 +5189,7 @@ int ust_app_snapshot_record(struct ltt_ust_session *usess,
 			registry = get_session_registry(ua_sess);
 			assert(registry);
 			ret = consumer_snapshot_channel(socket, registry->metadata_key, output,
-					1, ua_sess->euid, ua_sess->egid, pathname, wait,
-					max_stream_size);
+					1, ua_sess->euid, ua_sess->egid, pathname, wait, 0);
 			if (ret < 0) {
 				goto error;
 			}
@@ -5216,11 +5217,12 @@ error:
 }
 
 /*
- * Return the number of streams for a UST session.
+ * Return the size taken by one more packet per stream.
  */
-unsigned int ust_app_get_nb_stream(struct ltt_ust_session *usess)
+uint64_t ust_app_get_size_one_more_packet_per_stream(struct ltt_ust_session *usess,
+		uint64_t cur_nr_packets)
 {
-	unsigned int ret = 0;
+	uint64_t tot_size = 0;
 	struct ust_app *app;
 	struct lttng_ht_iter iter;
 
@@ -5237,7 +5239,14 @@ unsigned int ust_app_get_nb_stream(struct ltt_ust_session *usess)
 			rcu_read_lock();
 			cds_lfht_for_each_entry(reg->registry->channels->ht, &iter.iter,
 					reg_chan, node.node) {
-				ret += reg_chan->stream_count;
+				if (cur_nr_packets >= reg_chan->num_subbuf) {
+					/*
+					 * Don't take channel into account if we
+					 * already grab all its packets.
+					 */
+					continue;
+				}
+				tot_size += reg_chan->subbuf_size * reg_chan->stream_count;
 			}
 			rcu_read_unlock();
 		}
@@ -5259,7 +5268,14 @@ unsigned int ust_app_get_nb_stream(struct ltt_ust_session *usess)
 
 			cds_lfht_for_each_entry(ua_sess->channels->ht, &chan_iter.iter,
 					ua_chan, node.node) {
-				ret += ua_chan->streams.count;
+				if (cur_nr_packets >= ua_chan->attr.num_subbuf) {
+					/*
+					 * Don't take channel into account if we
+					 * already grab all its packets.
+					 */
+					continue;
+				}
+				tot_size += ua_chan->attr.subbuf_size * ua_chan->streams.count;
 			}
 		}
 		rcu_read_unlock();
@@ -5270,5 +5286,5 @@ unsigned int ust_app_get_nb_stream(struct ltt_ust_session *usess)
 		break;
 	}
 
-	return ret;
+	return tot_size;
 }
diff --git a/src/bin/lttng-sessiond/ust-app.h b/src/bin/lttng-sessiond/ust-app.h
index dc63677..7a35ef2 100644
--- a/src/bin/lttng-sessiond/ust-app.h
+++ b/src/bin/lttng-sessiond/ust-app.h
@@ -326,8 +326,10 @@ ssize_t ust_app_push_metadata(struct ust_registry_session *registry,
 		struct consumer_socket *socket, int send_zero_data);
 void ust_app_destroy(struct ust_app *app);
 int ust_app_snapshot_record(struct ltt_ust_session *usess,
-		struct snapshot_output *output, int wait, uint64_t max_stream_size);
-unsigned int ust_app_get_nb_stream(struct ltt_ust_session *usess);
+		struct snapshot_output *output, int wait,
+		uint64_t nb_packets_per_stream);
+uint64_t ust_app_get_size_one_more_packet_per_stream(struct ltt_ust_session *usess,
+		uint64_t cur_nr_packets);
 struct ust_app *ust_app_find_by_sock(int sock);
 
 static inline
diff --git a/src/bin/lttng/commands/snapshot.c b/src/bin/lttng/commands/snapshot.c
index 4b38edf..846e9ba 100644
--- a/src/bin/lttng/commands/snapshot.c
+++ b/src/bin/lttng/commands/snapshot.c
@@ -568,9 +568,7 @@ static int record(const char *url)
 	ret = lttng_snapshot_record(current_session_name, output, 0);
 	if (ret < 0) {
 		if (ret == -LTTNG_ERR_MAX_SIZE_INVALID) {
-			ERR("The minimum size of a snapshot is computed by multiplying "
-					"the total amount of streams with the largest subbuffer "
-					"in the session.");
+			ERR("Invalid snapshot size. Cannot fit at least one packet per stream.");
 		}
 		goto error;
 	}
diff --git a/src/common/align.h b/src/common/align.h
index fe32673..928c5b6 100644
--- a/src/common/align.h
+++ b/src/common/align.h
@@ -58,7 +58,7 @@
 	({								       \
 		LTTNG_BUILD_RUNTIME_BUG_ON((alignment) == 0		       \
 				   || ((alignment) & ((alignment) - 1)));      \
-		(((align_drift) - (alignment)) & ((alignment) - 1);	       \
+		(((align_drift) - (alignment)) & ((alignment) - 1));	       \
 	})
 
 #endif /* _LTTNG_ALIGN_H */
diff --git a/src/common/consumer.c b/src/common/consumer.c
index b0b926b..0af994f 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -48,6 +48,7 @@
 #include "consumer.h"
 #include "consumer-stream.h"
 #include "consumer-testpoint.h"
+#include "align.h"
 
 struct lttng_consumer_global_data consumer_data = {
 	.stream_count = 0,
@@ -3651,22 +3652,19 @@ int consumer_send_status_channel(int sock,
 	return lttcomm_send_unix_sock(sock, &msg, sizeof(msg));
 }
 
-/*
- * Using a maximum stream size with the produced and consumed position of a
- * stream, computes the new consumed position to be as close as possible to the
- * maximum possible stream size.
- *
- * If maximum stream size is lower than the possible buffer size (produced -
- * consumed), the consumed_pos given is returned untouched else the new value
- * is returned.
- */
-unsigned long consumer_get_consumed_maxsize(unsigned long consumed_pos,
-		unsigned long produced_pos, uint64_t max_stream_size)
+unsigned long consumer_get_consume_start_pos(unsigned long consumed_pos,
+		unsigned long produced_pos, uint64_t nb_packets_per_stream,
+		uint64_t max_sb_size)
 {
-	if (max_stream_size && max_stream_size < (produced_pos - consumed_pos)) {
-		/* Offset from the produced position to get the latest buffers. */
-		return produced_pos - max_stream_size;
-	}
+	unsigned long start_pos;
 
-	return consumed_pos;
+	if (!nb_packets_per_stream) {
+		return consumed_pos;	/* Grab everything */
+	}
+	start_pos = produced_pos - offset_align_floor(produced_pos, max_sb_size);
+	start_pos -= max_sb_size * nb_packets_per_stream;
+	if ((long) (start_pos - consumed_pos) < 0) {
+		return consumed_pos;	/* Grab everything */
+	}
+	return start_pos;
 }
diff --git a/src/common/consumer.h b/src/common/consumer.h
index 1e378f0..790cb6b 100644
--- a/src/common/consumer.h
+++ b/src/common/consumer.h
@@ -666,8 +666,9 @@ int consumer_send_status_channel(int sock,
 void notify_thread_del_channel(struct lttng_consumer_local_data *ctx,
 		uint64_t key);
 void consumer_destroy_relayd(struct consumer_relayd_sock_pair *relayd);
-unsigned long consumer_get_consumed_maxsize(unsigned long consumed_pos,
-		unsigned long produced_pos, uint64_t max_stream_size);
+unsigned long consumer_get_consume_start_pos(unsigned long consumed_pos,
+		unsigned long produced_pos, uint64_t nb_packets_per_stream,
+		uint64_t max_sb_size);
 int consumer_add_data_stream(struct lttng_consumer_stream *stream);
 void consumer_del_stream_for_data(struct lttng_consumer_stream *stream);
 int consumer_add_metadata_stream(struct lttng_consumer_stream *stream);
diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index 161293d..7622a22 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -115,7 +115,7 @@ int lttng_kconsumer_get_consumed_snapshot(struct lttng_consumer_stream *stream,
  * Returns 0 on success, < 0 on error
  */
 int lttng_kconsumer_snapshot_channel(uint64_t key, char *path,
-		uint64_t relayd_id, uint64_t max_stream_size,
+		uint64_t relayd_id, uint64_t nb_packets_per_stream,
 		struct lttng_consumer_local_data *ctx)
 {
 	int ret;
@@ -221,14 +221,9 @@ int lttng_kconsumer_snapshot_channel(uint64_t key, char *path,
 			}
 		}
 
-		/*
-		 * The original value is sent back if max stream size is larger than
-		 * the possible size of the snapshot. Also, we asume that the session
-		 * daemon should never send a maximum stream size that is lower than
-		 * subbuffer size.
-		 */
-		consumed_pos = consumer_get_consumed_maxsize(consumed_pos,
-				produced_pos, max_stream_size);
+		consumed_pos = consumer_get_consume_start_pos(consumed_pos,
+				produced_pos, nb_packets_per_stream,
+				stream->max_sb_size);
 
 		while (consumed_pos < produced_pos) {
 			ssize_t read_len;
@@ -886,7 +881,7 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 			ret = lttng_kconsumer_snapshot_channel(msg.u.snapshot_channel.key,
 					msg.u.snapshot_channel.pathname,
 					msg.u.snapshot_channel.relayd_id,
-					msg.u.snapshot_channel.max_stream_size,
+					msg.u.snapshot_channel.nb_packets_per_stream,
 					ctx);
 			if (ret < 0) {
 				ERR("Snapshot channel failed");
diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index 9842214..1426fcf 100644
--- a/src/common/sessiond-comm/sessiond-comm.h
+++ b/src/common/sessiond-comm/sessiond-comm.h
@@ -452,7 +452,7 @@ struct lttcomm_consumer_msg {
 			uint32_t metadata;		/* This a metadata snapshot. */
 			uint64_t relayd_id;		/* Relayd id if apply. */
 			uint64_t key;
-			uint64_t max_stream_size;
+			uint64_t nb_packets_per_stream;
 		} LTTNG_PACKED snapshot_channel;
 		struct {
 			uint64_t channel_key;
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index 38cdf70..bf0208f 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -860,7 +860,7 @@ error:
  * Returns 0 on success, < 0 on error
  */
 static int snapshot_channel(uint64_t key, char *path, uint64_t relayd_id,
-		uint64_t max_stream_size, struct lttng_consumer_local_data *ctx)
+		uint64_t nb_packets_per_stream, struct lttng_consumer_local_data *ctx)
 {
 	int ret;
 	unsigned use_relayd = 0;
@@ -942,12 +942,13 @@ static int snapshot_channel(uint64_t key, char *path, uint64_t relayd_id,
 
 		/*
 		 * The original value is sent back if max stream size is larger than
-		 * the possible size of the snapshot. Also, we asume that the session
+		 * the possible size of the snapshot. Also, we assume that the session
 		 * daemon should never send a maximum stream size that is lower than
 		 * subbuffer size.
 		 */
-		consumed_pos = consumer_get_consumed_maxsize(consumed_pos,
-				produced_pos, max_stream_size);
+		consumed_pos = consumer_get_consume_start_pos(consumed_pos,
+				produced_pos, nb_packets_per_stream,
+				stream->max_sb_size);
 
 		while (consumed_pos < produced_pos) {
 			ssize_t read_len;
@@ -1490,7 +1491,7 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 			ret = snapshot_channel(msg.u.snapshot_channel.key,
 					msg.u.snapshot_channel.pathname,
 					msg.u.snapshot_channel.relayd_id,
-					msg.u.snapshot_channel.max_stream_size,
+					msg.u.snapshot_channel.nb_packets_per_stream,
 					ctx);
 			if (ret < 0) {
 				ERR("Snapshot channel failed");
-- 
2.1.1
