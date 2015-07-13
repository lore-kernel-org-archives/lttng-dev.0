From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [UST PATCH 2/3] Generate and export the sequence number
Date: Mon, 13 Jul 2015 11:12:08 -0400
Message-ID: <1436800329-15061-2-git-send-email-jdesfossez__5873.10080086372$1436800423$gmane$org@efficios.com>
References: <1436800329-15061-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZEfP0-0008CQ-Vw
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 11:12:20 -0400
In-Reply-To: <1436800329-15061-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

This allows the viewer to identify the gaps between trace packets.

This is a locked-step with the corresponding commit in lttng-tools.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 include/lttng/ust-ctl.h                 |  2 ++
 liblttng-ust-ctl/ustctl.c               | 17 +++++++++++++
 liblttng-ust/lttng-rb-clients.h         |  2 ++
 liblttng-ust/lttng-ring-buffer-client.h | 29 ++++++++++++++++++++++
 libringbuffer/backend_internal.h        | 43 +++++++++++++++++++++++++++++++++
 5 files changed, 93 insertions(+)

diff --git a/include/lttng/ust-ctl.h b/include/lttng/ust-ctl.h
index 78e0cf7..d27ca8a 100644
--- a/include/lttng/ust-ctl.h
+++ b/include/lttng/ust-ctl.h
@@ -241,6 +241,8 @@ int ustctl_get_stream_id(struct ustctl_consumer_stream *stream,
 		uint64_t *stream_id);
 int ustctl_get_current_timestamp(struct ustctl_consumer_stream *stream,
 		uint64_t *ts);
+int ustctl_get_sequence_number(struct ustctl_consumer_stream *stream,
+		uint64_t *seq);
 
 /* returns whether UST has perf counters support. */
 int ustctl_has_perf_counters(void);
diff --git a/liblttng-ust-ctl/ustctl.c b/liblttng-ust-ctl/ustctl.c
index 5801bc6..010dfd8 100644
--- a/liblttng-ust-ctl/ustctl.c
+++ b/liblttng-ust-ctl/ustctl.c
@@ -1646,6 +1646,23 @@ int ustctl_get_current_timestamp(struct ustctl_consumer_stream *stream,
 	return client_cb->current_timestamp(buf, handle, ts);
 }
 
+int ustctl_get_sequence_number(struct ustctl_consumer_stream *stream,
+		uint64_t *seq)
+{
+	struct lttng_ust_client_lib_ring_buffer_client_cb *client_cb;
+	struct lttng_ust_lib_ring_buffer *buf;
+	struct lttng_ust_shm_handle *handle;
+
+	if (!stream || !seq)
+		return -EINVAL;
+	buf = stream->buf;
+	handle = stream->chan->chan->handle;
+	client_cb = get_client_cb(buf, handle);
+	if (!client_cb || !client_cb->sequence_number)
+		return -ENOSYS;
+	return client_cb->sequence_number(buf, handle, seq);
+}
+
 #if defined(__x86_64__) || defined(__i386__)
 
 int ustctl_has_perf_counters(void)
diff --git a/liblttng-ust/lttng-rb-clients.h b/liblttng-ust/lttng-rb-clients.h
index 85d4e1b..788f075 100644
--- a/liblttng-ust/lttng-rb-clients.h
+++ b/liblttng-ust/lttng-rb-clients.h
@@ -43,6 +43,8 @@ struct lttng_ust_client_lib_ring_buffer_client_cb {
 	int (*current_timestamp) (struct lttng_ust_lib_ring_buffer *buf,
 			struct lttng_ust_shm_handle *handle,
 			uint64_t *ts);
+	int (*sequence_number) (struct lttng_ust_lib_ring_buffer *buf,
+		struct lttng_ust_shm_handle *handle, uint64_t *seq);
 };
 
 #endif /* _LTTNG_RB_CLIENT_H */
diff --git a/liblttng-ust/lttng-ring-buffer-client.h b/liblttng-ust/lttng-ring-buffer-client.h
index 41baab0..1e93cff 100644
--- a/liblttng-ust/lttng-ring-buffer-client.h
+++ b/liblttng-ust/lttng-ring-buffer-client.h
@@ -53,6 +53,7 @@ struct packet_header {
 		uint64_t timestamp_end;		/* Cycle count at subbuffer end */
 		uint64_t content_size;		/* Size of data in subbuffer */
 		uint64_t packet_size;		/* Subbuffer size (include padding) */
+		uint64_t packet_seq_num;	/* Packet sequence number */
 		unsigned long events_discarded;	/*
 						 * Events lost in this subbuffer since
 						 * the beginning of the trace.
@@ -339,6 +340,9 @@ static void client_buffer_begin(struct lttng_ust_lib_ring_buffer *buf, uint64_t
 				subbuf_idx * chan->backend.subbuf_size,
 				handle);
 	struct lttng_channel *lttng_chan = channel_get_private(chan);
+	unsigned long seq_num_offset =
+		get_count_order64(chan->backend.subbuf_size);
+	unsigned int field_size = sizeof(header->ctx.packet_seq_num) * CHAR_BIT;
 
 	header->magic = CTF_MAGIC_NUMBER;
 	memcpy(header->uuid, lttng_chan->uuid, sizeof(lttng_chan->uuid));
@@ -348,6 +352,14 @@ static void client_buffer_begin(struct lttng_ust_lib_ring_buffer *buf, uint64_t
 	header->ctx.timestamp_end = 0;
 	header->ctx.content_size = ~0ULL; /* for debugging */
 	header->ctx.packet_size = ~0ULL;
+	header->ctx.packet_seq_num = 0;
+	/*
+	 * vread returns an unsigned long, the bt_bitfield_write adds the
+	 * complement of padding.
+	 */
+	bt_bitfield_write(&header->ctx.packet_seq_num, unsigned long,
+			seq_num_offset, field_size - seq_num_offset,
+			v_read(&client_config, &buf->offset) >> seq_num_offset);
 	header->ctx.events_discarded = 0;
 	header->ctx.cpu_id = buf->backend.cpu;
 }
@@ -488,6 +500,22 @@ static int client_current_timestamp(struct lttng_ust_lib_ring_buffer *buf,
 	return 0;
 }
 
+static int client_sequence_number(struct lttng_ust_lib_ring_buffer *buf,
+		struct lttng_ust_shm_handle *handle,
+		uint64_t *seq)
+{
+	struct packet_header *header;
+	struct channel *chan;
+
+	header = client_packet_header(buf, handle);
+	chan = shmp(handle, handle->chan);
+
+	*seq = header->ctx.packet_seq_num >>
+		(get_count_order64(chan->backend.subbuf_size));
+
+	return 0;
+}
+
 static const
 struct lttng_ust_client_lib_ring_buffer_client_cb client_cb = {
 	.parent = {
@@ -508,6 +536,7 @@ struct lttng_ust_client_lib_ring_buffer_client_cb client_cb = {
 	.packet_size = client_packet_size,
 	.stream_id = client_stream_id,
 	.current_timestamp = client_current_timestamp,
+	.sequence_number = client_sequence_number,
 };
 
 static const struct lttng_ust_lib_ring_buffer_config client_config = {
diff --git a/libringbuffer/backend_internal.h b/libringbuffer/backend_internal.h
index 344784f..ef2c553 100644
--- a/libringbuffer/backend_internal.h
+++ b/libringbuffer/backend_internal.h
@@ -491,6 +491,40 @@ static inline int lttng_ust_fls(unsigned int x)
 	return r;
 }
 
+static inline int lttng_ust_fls64(uint64_t x)
+{
+	unsigned int r = 64;
+
+	if (!x)
+		return 0;
+
+	if (!(x & 0xFFFFFFFF00000000ULL)) {
+		x <<= 32;
+		r -= 32;
+	}
+	if (!(x & 0xFFFF000000000000ULL)) {
+		x <<= 16;
+		r -= 16;
+	}
+	if (!(x & 0xFF00000000000000ULL)) {
+		x <<= 8;
+		r -= 8;
+	}
+	if (!(x & 0xF000000000000000ULL)) {
+		x <<= 4;
+		r -= 4;
+	}
+	if (!(x & 0xC000000000000000ULL)) {
+		x <<= 2;
+		r -= 2;
+	}
+	if (!(x & 0x8000000000000000ULL)) {
+		x <<= 1;
+		r -= 1;
+	}
+	return r;
+}
+
 static inline int get_count_order(unsigned int count)
 {
 	int order;
@@ -501,4 +535,13 @@ static inline int get_count_order(unsigned int count)
 	return order;
 }
 
+static inline int get_count_order64(uint64_t count)
+{
+	int order;
+
+	order = lttng_ust_fls64(count) - 1;
+	if (count & (count - 1))
+		order++;
+	return order;
+}
 #endif /* _LTTNG_RING_BUFFER_BACKEND_INTERNAL_H */
-- 
1.9.1
