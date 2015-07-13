From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [MODULES PATCH 2/3] Add a packet sequence number
Date: Mon, 13 Jul 2015 11:09:24 -0400
Message-ID: <1436800165-14221-2-git-send-email-jdesfossez__48761.1180557453$1436800308$gmane$org@efficios.com>
References: <1436800165-14221-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZEfMT-00086J-3Q
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 11:09:44 -0400
In-Reply-To: <1436800165-14221-1-git-send-email-jdesfossez@efficios.com>
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

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 lttng-abi.c                         | 18 +++++++++++++++
 lttng-abi.h                         |  5 ++++
 lttng-events.c                      | 46 +++++++++++++++++++++++++------------
 lttng-events.h                      |  4 ++++
 lttng-ring-buffer-client.h          | 35 ++++++++++++++++++++++++++++
 lttng-ring-buffer-metadata-client.h | 15 ++++++++++++
 6 files changed, 108 insertions(+), 15 deletions(-)

diff --git a/lttng-abi.c b/lttng-abi.c
index 8f63ad9..586116d 100644
--- a/lttng-abi.c
+++ b/lttng-abi.c
@@ -1508,6 +1508,15 @@ static long lttng_stream_ring_buffer_ioctl(struct file *filp,
 			goto error;
 		return put_u64(ts, arg);
 	}
+	case LTTNG_RING_BUFFER_GET_SEQ_NUM:
+	{
+		uint64_t seq;
+
+		ret = ops->sequence_number(config, buf, &seq);
+		if (ret < 0)
+			goto error;
+		return put_u64(seq, arg);
+	}
 	default:
 		return lib_ring_buffer_file_operations.unlocked_ioctl(filp,
 				cmd, arg);
@@ -1594,6 +1603,15 @@ static long lttng_stream_ring_buffer_compat_ioctl(struct file *filp,
 			goto error;
 		return put_u64(ts, arg);
 	}
+	case LTTNG_RING_BUFFER_COMPAT_GET_SEQ_NUM:
+	{
+		uint64_t seq;
+
+		ret = ops->sequence_number(config, buf, &seq);
+		if (ret < 0)
+			goto error;
+		return put_u64(seq, arg);
+	}
 	default:
 		return lib_ring_buffer_file_operations.compat_ioctl(filp,
 				cmd, arg);
diff --git a/lttng-abi.h b/lttng-abi.h
index ab54cf8..2d342c1 100644
--- a/lttng-abi.h
+++ b/lttng-abi.h
@@ -228,6 +228,8 @@ struct lttng_kernel_filter_bytecode {
 #define LTTNG_RING_BUFFER_GET_STREAM_ID		_IOR(0xF6, 0x25, uint64_t)
 /* returns the current timestamp */
 #define LTTNG_RING_BUFFER_GET_CURRENT_TIMESTAMP	_IOR(0xF6, 0x26, uint64_t)
+/* returns the packet sequence number */
+#define LTTNG_RING_BUFFER_GET_SEQ_NUM		_IOR(0xF6, 0x27, uint64_t)
 
 #ifdef CONFIG_COMPAT
 /* returns the timestamp begin of the current sub-buffer */
@@ -251,6 +253,9 @@ struct lttng_kernel_filter_bytecode {
 /* returns the current timestamp */
 #define LTTNG_RING_BUFFER_COMPAT_GET_CURRENT_TIMESTAMP \
 	LTTNG_RING_BUFFER_GET_CURRENT_TIMESTAMP
+/* returns the packet sequence number */
+#define LTTNG_RING_BUFFER_COMPAT_GET_SEQ_NUM	\
+	LTTNG_RING_BUFFER_GET_SEQ_NUM
 #endif /* CONFIG_COMPAT */
 
 #endif /* _LTTNG_ABI_H */
diff --git a/lttng-events.c b/lttng-events.c
index 3cbfcbf..319ba5a 100644
--- a/lttng-events.c
+++ b/lttng-events.c
@@ -76,6 +76,9 @@ static
 int _lttng_session_metadata_statedump(struct lttng_session *session);
 static
 void _lttng_metadata_channel_hangup(struct lttng_metadata_stream *stream);
+static
+int _lttng_stream_packet_context_declare(struct lttng_session *session,
+					struct lttng_channel *chan);
 
 void synchronize_trace(void)
 {
@@ -1808,14 +1811,22 @@ int _lttng_channel_metadata_statedump(struct lttng_session *session,
 	ret = lttng_metadata_printf(session,
 		"stream {\n"
 		"	id = %u;\n"
-		"	event.header := %s;\n"
-		"	packet.context := struct packet_context;\n",
+		"	event.header := %s;\n",
 		chan->id,
 		chan->header_type == 1 ? "struct event_header_compact" :
 			"struct event_header_large");
 	if (ret)
 		goto end;
 
+	ret = lttng_metadata_printf(session,
+			"	packet.context := ");
+	if (ret)
+		goto end;
+
+	ret = _lttng_stream_packet_context_declare(session, chan);
+	if (ret)
+		goto end;
+
 	if (chan->ctx) {
 		ret = lttng_metadata_printf(session,
 			"	event.context := struct {\n");
@@ -1844,18 +1855,27 @@ end:
  * Must be called with sessions_mutex held.
  */
 static
-int _lttng_stream_packet_context_declare(struct lttng_session *session)
+int _lttng_stream_packet_context_declare(struct lttng_session *session,
+		struct lttng_channel *chan)
 {
+	unsigned int field_size = 64;
+	/* subbuf_size cannot be 0, so we can use fls_long(x - 1) directly. */
+	unsigned int padding = fls_long(chan->ops->subbuf_size(chan->chan) - 1);
+
 	return lttng_metadata_printf(session,
 		"struct packet_context {\n"
-		"	uint64_clock_monotonic_t timestamp_begin;\n"
-		"	uint64_clock_monotonic_t timestamp_end;\n"
-		"	uint64_t content_size;\n"
-		"	uint64_t packet_size;\n"
-		"	unsigned long events_discarded;\n"
-		"	uint32_t cpu_id;\n"
-		"};\n\n"
-		);
+		"		uint64_clock_monotonic_t timestamp_begin;\n"
+		"		uint64_clock_monotonic_t timestamp_end;\n"
+		"		uint64_t content_size;\n"
+		"		uint64_t packet_size;\n"
+		"		integer { size = %u; signed = false;"
+		" align = 1; } packet_seq_num_padding;\n"
+		"		integer { size = %u; signed = false;"
+		" align = 1; } packet_seq_num;\n"
+		"		unsigned long events_discarded;\n"
+		"		uint32_t cpu_id;\n"
+		"	};\n\n",
+		padding, field_size - padding);
 }
 
 /*
@@ -2067,10 +2087,6 @@ int _lttng_session_metadata_statedump(struct lttng_session *session)
 	if (ret)
 		goto end;
 
-	ret = _lttng_stream_packet_context_declare(session);
-	if (ret)
-		goto end;
-
 	ret = _lttng_event_header_declare(session);
 	if (ret)
 		goto end;
diff --git a/lttng-events.h b/lttng-events.h
index 484534c..c8afd8f 100644
--- a/lttng-events.h
+++ b/lttng-events.h
@@ -358,6 +358,10 @@ struct lttng_channel_ops {
 	int (*current_timestamp) (const struct lib_ring_buffer_config *config,
 			struct lib_ring_buffer *bufb,
 			uint64_t *ts);
+	int (*sequence_number) (const struct lib_ring_buffer_config *config,
+			struct lib_ring_buffer *bufb,
+			uint64_t *seq);
+	uint64_t (*subbuf_size)(struct channel *chan);
 };
 
 struct lttng_transport {
diff --git a/lttng-ring-buffer-client.h b/lttng-ring-buffer-client.h
index 72fbf18..69cc99e 100644
--- a/lttng-ring-buffer-client.h
+++ b/lttng-ring-buffer-client.h
@@ -65,6 +65,7 @@ struct packet_header {
 		uint64_t timestamp_end;		/* Cycle count at subbuffer end */
 		uint64_t content_size;		/* Size of data in subbuffer */
 		uint64_t packet_size;		/* Subbuffer size (include padding) */
+		uint64_t packet_seq_num;	/* Packet sequence number */
 		unsigned long events_discarded;	/*
 						 * Events lost in this subbuffer since
 						 * the beginning of the trace.
@@ -348,6 +349,10 @@ static void client_buffer_begin(struct lib_ring_buffer *buf, u64 tsc,
 				subbuf_idx * chan->backend.subbuf_size);
 	struct lttng_channel *lttng_chan = channel_get_private(chan);
 	struct lttng_session *session = lttng_chan->session;
+	/* subbuf_size cannot be 0 so we can use fls_long(x - 1) directly. */
+	unsigned long seq_num_offset =
+		fls_long(chan->backend.subbuf_size - 1);
+	unsigned int field_size = sizeof(header->ctx.packet_seq_num) * CHAR_BIT;
 
 	header->magic = CTF_MAGIC_NUMBER;
 	memcpy(header->uuid, session->uuid.b, sizeof(session->uuid));
@@ -357,6 +362,14 @@ static void client_buffer_begin(struct lib_ring_buffer *buf, u64 tsc,
 	header->ctx.timestamp_end = 0;
 	header->ctx.content_size = ~0ULL; /* for debugging */
 	header->ctx.packet_size = ~0ULL;
+	header->ctx.packet_seq_num = 0;
+	/*
+	 * vread returns an unsigned long, the bt_bitfield_write adds the
+	 * complement of padding.
+	*/
+	bt_bitfield_write(&header->ctx.packet_seq_num, unsigned long,
+			seq_num_offset, field_size - seq_num_offset,
+			v_read(&client_config, &buf->offset) >> seq_num_offset);
 	header->ctx.events_discarded = 0;
 	header->ctx.cpu_id = buf->backend.cpu;
 }
@@ -472,6 +485,26 @@ static int client_current_timestamp(const struct lib_ring_buffer_config *config,
 	return 0;
 }
 
+static int client_sequence_number(const struct lib_ring_buffer_config *config,
+			struct lib_ring_buffer *buf,
+			uint64_t *seq)
+{
+	struct packet_header *header = client_packet_header(config, buf);
+	struct channel *chan = buf->backend.chan;
+
+	/* subbuf_size cannot be 0, so we can use fls_long(x - 1) directly. */
+	*seq = header->ctx.packet_seq_num >>
+		(fls_long(chan->backend.subbuf_size - 1));
+
+	return 0;
+}
+
+static
+uint64_t client_get_subbuf_size(struct channel *chan)
+{
+	return chan->backend.subbuf_size;
+}
+
 static const struct lib_ring_buffer_config client_config = {
 	.cb.ring_buffer_clock_read = client_ring_buffer_clock_read,
 	.cb.record_header_size = client_record_header_size,
@@ -702,6 +735,8 @@ static struct lttng_transport lttng_relay_transport = {
 		.packet_size = client_packet_size,
 		.stream_id = client_stream_id,
 		.current_timestamp = client_current_timestamp,
+		.sequence_number = client_sequence_number,
+		.subbuf_size = client_get_subbuf_size,
 	},
 };
 
diff --git a/lttng-ring-buffer-metadata-client.h b/lttng-ring-buffer-metadata-client.h
index 9e03530..da94aeb 100644
--- a/lttng-ring-buffer-metadata-client.h
+++ b/lttng-ring-buffer-metadata-client.h
@@ -199,6 +199,19 @@ static int client_stream_id(const struct lib_ring_buffer_config *config,
 	return -ENOSYS;
 }
 
+static int client_sequence_number(const struct lib_ring_buffer_config *config,
+			struct lib_ring_buffer *bufb,
+			uint64_t *seq)
+{
+	return -ENOSYS;
+}
+
+static
+uint64_t client_get_subbuf_size(struct channel *chan)
+{
+	return -ENOSYS;
+}
+
 static const struct lib_ring_buffer_config client_config = {
 	.cb.ring_buffer_clock_read = client_ring_buffer_clock_read,
 	.cb.record_header_size = client_record_header_size,
@@ -405,6 +418,8 @@ static struct lttng_transport lttng_relay_transport = {
 		.packet_size = client_packet_size,
 		.stream_id = client_stream_id,
 		.current_timestamp = client_current_timestamp,
+		.sequence_number = client_sequence_number,
+		.subbuf_size = client_get_subbuf_size,
 	},
 };
 
-- 
1.9.1
