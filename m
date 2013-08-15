From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [UST PATCH 2/2] LTTng ringbuffer ABI calls for index
	generation
Date: Thu, 15 Aug 2013 17:46:28 -0400
Message-ID: <1376603188-19344-2-git-send-email-jdesfossez__20450.0820058913$1376603365$gmane$org@efficios.com>
References: <1376603188-19344-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1VA5NT-0003Cb-P8
	for lttng-dev@lists.lttng.org; Thu, 15 Aug 2013 17:46:50 -0400
In-Reply-To: <1376603188-19344-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

These new calls export the data required for the consumer to
generate the index while tracing :
- timestamp begin
- timestamp end
- events discarded
- context size
- packet size
- stream id

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 include/lttng/ust-ctl.h                 |   14 ++++
 liblttng-ust-ctl/ustctl.c               |   90 ++++++++++++++++++++++
 liblttng-ust/lttng-rb-clients.h         |   19 +++++
 liblttng-ust/lttng-ring-buffer-client.h |   91 ++++++++++++++++++++++
 libringbuffer/frontend.h                |   19 +++++
 libringbuffer/ring_buffer_frontend.c    |  127 +++++++++++++++++++++++++++++++
 6 files changed, 360 insertions(+)

diff --git a/include/lttng/ust-ctl.h b/include/lttng/ust-ctl.h
index 3c81e50..88112ad 100644
--- a/include/lttng/ust-ctl.h
+++ b/include/lttng/ust-ctl.h
@@ -220,6 +220,20 @@ int ustctl_put_subbuf(struct ustctl_consumer_stream *stream);
 void ustctl_flush_buffer(struct ustctl_consumer_stream *stream,
 		int producer_active);
 
+/* index */
+int ustctl_get_timestamp_begin(struct ustctl_consumer_stream *stream,
+		uint64_t *timestamp_begin);
+int ustctl_get_timestamp_end(struct ustctl_consumer_stream *stream,
+	uint64_t *timestamp_end);
+int ustctl_get_events_discarded(struct ustctl_consumer_stream *stream,
+	uint64_t *events_discarded);
+int ustctl_get_content_size(struct ustctl_consumer_stream *stream,
+	uint64_t *content_size);
+int ustctl_get_packet_size(struct ustctl_consumer_stream *stream,
+	uint64_t *packet_size);
+int ustctl_get_stream_id(struct ustctl_consumer_stream *stream,
+		uint64_t *stream_id);
+
 /* event registry management */
 
 enum ustctl_socket_type {
diff --git a/liblttng-ust-ctl/ustctl.c b/liblttng-ust-ctl/ustctl.c
index 28dee5e..a53ba3f 100644
--- a/liblttng-ust-ctl/ustctl.c
+++ b/liblttng-ust-ctl/ustctl.c
@@ -1461,6 +1461,96 @@ void ustctl_flush_buffer(struct ustctl_consumer_stream *stream,
 		consumer_chan->chan->handle);
 }
 
+int ustctl_get_timestamp_begin(struct ustctl_consumer_stream *stream,
+		uint64_t *timestamp_begin)
+{
+	struct lttng_ust_lib_ring_buffer *buf;
+	struct ustctl_consumer_channel *consumer_chan;
+
+	if (!stream)
+		return -EINVAL;
+	buf = stream->buf;
+	consumer_chan = stream->chan;
+
+	return lib_ring_buffer_get_timestamp_begin(buf, consumer_chan->chan->handle,
+			timestamp_begin);
+}
+
+int ustctl_get_timestamp_end(struct ustctl_consumer_stream *stream,
+	uint64_t *timestamp_end)
+{
+	struct lttng_ust_lib_ring_buffer *buf;
+	struct ustctl_consumer_channel *consumer_chan;
+
+	if (!stream)
+		return -EINVAL;
+	buf = stream->buf;
+	consumer_chan = stream->chan;
+
+	return lib_ring_buffer_get_timestamp_end(buf, consumer_chan->chan->handle,
+			timestamp_end);
+}
+
+int ustctl_get_events_discarded(struct ustctl_consumer_stream *stream,
+	uint64_t *events_discarded)
+{
+	struct lttng_ust_lib_ring_buffer *buf;
+	struct ustctl_consumer_channel *consumer_chan;
+
+	if (!stream)
+		return -EINVAL;
+	buf = stream->buf;
+	consumer_chan = stream->chan;
+
+	return lib_ring_buffer_get_events_discarded(buf, consumer_chan->chan->handle,
+			events_discarded);
+}
+
+int ustctl_get_content_size(struct ustctl_consumer_stream *stream,
+	uint64_t *content_size)
+{
+	struct lttng_ust_lib_ring_buffer *buf;
+	struct ustctl_consumer_channel *consumer_chan;
+
+	if (!stream)
+		return -EINVAL;
+	buf = stream->buf;
+	consumer_chan = stream->chan;
+
+	return lib_ring_buffer_get_content_size(buf, consumer_chan->chan->handle,
+			content_size);
+}
+
+int ustctl_get_packet_size(struct ustctl_consumer_stream *stream,
+	uint64_t *packet_size)
+{
+	struct lttng_ust_lib_ring_buffer *buf;
+	struct ustctl_consumer_channel *consumer_chan;
+
+	if (!stream)
+		return -EINVAL;
+	buf = stream->buf;
+	consumer_chan = stream->chan;
+
+	return lib_ring_buffer_get_packet_size(buf, consumer_chan->chan->handle,
+			packet_size);
+}
+
+int ustctl_get_stream_id(struct ustctl_consumer_stream *stream,
+		uint64_t *stream_id)
+{
+	struct lttng_ust_lib_ring_buffer *buf;
+	struct ustctl_consumer_channel *consumer_chan;
+
+	if (!stream)
+		return -EINVAL;
+	buf = stream->buf;
+	consumer_chan = stream->chan;
+
+	return lib_ring_buffer_get_stream_id(buf, consumer_chan->chan->handle,
+			stream_id);
+}
+
 /*
  * Returns 0 on success, negative error value on error.
  */
diff --git a/liblttng-ust/lttng-rb-clients.h b/liblttng-ust/lttng-rb-clients.h
index 37fd842..3a22e03 100644
--- a/liblttng-ust/lttng-rb-clients.h
+++ b/liblttng-ust/lttng-rb-clients.h
@@ -3,6 +3,25 @@
 
 struct specialized_lttng_ust_lib_ring_buffer_client_cb {
 	struct lttng_ust_lib_ring_buffer_client_cb parent;
+
+	int (*timestamp_begin) (struct lttng_ust_lib_ring_buffer *buf,
+			struct lttng_ust_shm_handle *handle,
+			uint64_t *timestamp_begin);
+	int (*timestamp_end) (struct lttng_ust_lib_ring_buffer *buf,
+			struct lttng_ust_shm_handle *handle,
+			uint64_t *timestamp_end);
+	int (*events_discarded) (struct lttng_ust_lib_ring_buffer *buf,
+			struct lttng_ust_shm_handle *handle,
+			uint64_t *events_discarded);
+	int (*content_size) (struct lttng_ust_lib_ring_buffer *buf,
+			struct lttng_ust_shm_handle *handle,
+			uint64_t *content_size);
+	int (*packet_size) (struct lttng_ust_lib_ring_buffer *buf,
+			struct lttng_ust_shm_handle *handle,
+			uint64_t *packet_size);
+	int (*stream_id) (struct lttng_ust_lib_ring_buffer *buf,
+			struct lttng_ust_shm_handle *handle,
+			uint64_t *stream_id);
 };
 
 #endif /* _LTTNG_RB_CLIENT_H */
diff --git a/liblttng-ust/lttng-ring-buffer-client.h b/liblttng-ust/lttng-ring-buffer-client.h
index 94db97e..942a624 100644
--- a/liblttng-ust/lttng-ring-buffer-client.h
+++ b/liblttng-ust/lttng-ring-buffer-client.h
@@ -386,6 +386,91 @@ static void client_buffer_finalize(struct lttng_ust_lib_ring_buffer *buf, void *
 {
 }
 
+static struct packet_header *client_packet_header(struct lttng_ust_lib_ring_buffer *buf,
+		struct lttng_ust_shm_handle *handle)
+{
+	struct channel *chan = shmp(handle, buf->backend.chan);
+	struct lttng_channel *lttng_chan = channel_get_private(chan);
+	unsigned long sb_index;
+	struct lttng_ust_lib_ring_buffer_backend *bufb;
+	struct packet_header *header;
+
+	bufb = &buf->backend;
+	sb_index = subbuffer_id_get_index(&lttng_chan->chan->backend.config,
+			bufb->buf_rsb.id);
+
+	header = lib_ring_buffer_offset_address(bufb,
+			sb_index * lttng_chan->chan->backend.subbuf_size,
+			handle);
+
+	return header;
+}
+
+static int client_timestamp_begin(struct lttng_ust_lib_ring_buffer *buf,
+		struct lttng_ust_shm_handle *handle,
+		uint64_t *timestamp_begin)
+{
+	struct packet_header *header = client_packet_header(buf, handle);
+
+	*timestamp_begin = header->ctx.timestamp_begin;
+
+	return 0;
+}
+
+static int client_timestamp_end(struct lttng_ust_lib_ring_buffer *buf,
+		struct lttng_ust_shm_handle *handle,
+		uint64_t *timestamp_end)
+{
+	struct packet_header *header = client_packet_header(buf, handle);
+
+	*timestamp_end = header->ctx.timestamp_end;
+
+	return 0;
+}
+
+static int client_events_discarded(struct lttng_ust_lib_ring_buffer *buf,
+		struct lttng_ust_shm_handle *handle,
+		uint64_t *events_discarded)
+{
+	struct packet_header *header = client_packet_header(buf, handle);
+
+	*events_discarded = header->ctx.events_discarded;
+
+	return 0;
+}
+
+static int client_content_size(struct lttng_ust_lib_ring_buffer *buf,
+		struct lttng_ust_shm_handle *handle,
+		uint64_t *content_size)
+{
+	struct packet_header *header = client_packet_header(buf, handle);
+
+	*content_size = header->ctx.content_size;
+
+	return 0;
+}
+
+static int client_packet_size(struct lttng_ust_lib_ring_buffer *buf,
+		struct lttng_ust_shm_handle *handle,
+		uint64_t *packet_size)
+{
+	struct packet_header *header = client_packet_header(buf, handle);
+
+	*packet_size = header->ctx.packet_size;
+
+	return 0;
+}
+
+static int client_stream_id(struct lttng_ust_lib_ring_buffer *buf,
+		struct lttng_ust_shm_handle *handle,
+		uint64_t *stream_id)
+{
+	struct packet_header *header = client_packet_header(buf, handle);
+
+	*stream_id = header->stream_id;
+
+	return 0;
+}
 static const
 struct specialized_lttng_ust_lib_ring_buffer_client_cb client_cb = {
 	.parent = {
@@ -397,6 +482,12 @@ struct specialized_lttng_ust_lib_ring_buffer_client_cb client_cb = {
 		.buffer_create = client_buffer_create,
 		.buffer_finalize = client_buffer_finalize,
 	},
+	.timestamp_begin = client_timestamp_begin,
+	.timestamp_end = client_timestamp_end,
+	.events_discarded = client_events_discarded,
+	.content_size = client_content_size,
+	.packet_size = client_packet_size,
+	.stream_id = client_stream_id,
 };
 
 static const struct lttng_ust_lib_ring_buffer_config client_config = {
diff --git a/libringbuffer/frontend.h b/libringbuffer/frontend.h
index 89613d4..92399d2 100644
--- a/libringbuffer/frontend.h
+++ b/libringbuffer/frontend.h
@@ -269,4 +269,23 @@ unsigned long lib_ring_buffer_get_records_read(
 	return v_read(config, &buf->backend.records_read);
 }
 
+extern int lib_ring_buffer_get_timestamp_begin(struct lttng_ust_lib_ring_buffer *buf,
+		struct lttng_ust_shm_handle *handle,
+		uint64_t *timestamp_begin);
+extern int lib_ring_buffer_get_timestamp_end(struct lttng_ust_lib_ring_buffer *buf,
+		struct lttng_ust_shm_handle *handle,
+		uint64_t *timestamp_end);
+extern int lib_ring_buffer_get_events_discarded(struct lttng_ust_lib_ring_buffer *buf,
+		struct lttng_ust_shm_handle *handle,
+		uint64_t *events_discarded);
+extern int lib_ring_buffer_get_content_size(struct lttng_ust_lib_ring_buffer *buf,
+		struct lttng_ust_shm_handle *handle,
+		uint64_t *content_size);
+extern int lib_ring_buffer_get_packet_size(struct lttng_ust_lib_ring_buffer *buf,
+		struct lttng_ust_shm_handle *handle,
+		uint64_t *packet_size);
+extern int lib_ring_buffer_get_stream_id(struct lttng_ust_lib_ring_buffer *buf,
+		struct lttng_ust_shm_handle *handle,
+		uint64_t *stream_id);
+
 #endif /* _LTTNG_RING_BUFFER_FRONTEND_H */
diff --git a/libringbuffer/ring_buffer_frontend.c b/libringbuffer/ring_buffer_frontend.c
index e99ba8a..6664935 100644
--- a/libringbuffer/ring_buffer_frontend.c
+++ b/libringbuffer/ring_buffer_frontend.c
@@ -72,6 +72,7 @@
 #include "shm.h"
 #include "tlsfixup.h"
 #include "../liblttng-ust/compat.h"	/* For ENODATA */
+#include "../liblttng-ust/lttng-rb-clients.h"
 
 #ifndef max
 #define max(a, b)	((a) > (b) ? (a) : (b))
@@ -1869,6 +1870,132 @@ int lib_ring_buffer_reserve_slow(struct lttng_ust_lib_ring_buffer_ctx *ctx)
 	return 0;
 }
 
+/**
+ * lib_ring_buffer_get_timestamp_begin - get the timestamp begin of the subbuffer
+ * @buf: ring buffer
+ * @timestamp_begin: timestamp begin of the subbuffer
+ *
+ * Returns 0 on success, a negative value on error.
+ */
+int lib_ring_buffer_get_timestamp_begin(struct lttng_ust_lib_ring_buffer *buf,
+		struct lttng_ust_shm_handle *handle,
+		uint64_t *timestamp_begin)
+{
+	struct channel *chan = shmp(handle, buf->backend.chan);
+	const struct lttng_ust_lib_ring_buffer_config *config = &chan->backend.config;
+	struct specialized_lttng_ust_lib_ring_buffer_client_cb *client_cb;
+
+	client_cb = caa_container_of(config->cb_ptr,
+			struct specialized_lttng_ust_lib_ring_buffer_client_cb,
+			parent);
+	return client_cb->timestamp_begin(buf, handle, timestamp_begin);
+}
+
+/**
+ * lib_ring_buffer_get_timestamp_end - get the timestamp end of the subbuffer
+ * @buf: ring buffer
+ * @timestamp_end: timestamp end of the subbuffer
+ *
+ * Returns 0 on success, a negative value on error.
+ */
+int lib_ring_buffer_get_timestamp_end(struct lttng_ust_lib_ring_buffer *buf,
+	struct lttng_ust_shm_handle *handle,
+	uint64_t *timestamp_end)
+{
+	struct channel *chan = shmp(handle, buf->backend.chan);
+	const struct lttng_ust_lib_ring_buffer_config *config = &chan->backend.config;
+	struct specialized_lttng_ust_lib_ring_buffer_client_cb *client_cb;
+
+	client_cb = caa_container_of(config->cb_ptr,
+			struct specialized_lttng_ust_lib_ring_buffer_client_cb,
+			parent);
+	return client_cb->timestamp_end(buf, handle, timestamp_end);
+}
+
+/**
+ * lib_ring_buffer_get_events_discarded - get the number of discarded events
+ * @buf: ring buffer
+ * @events_discarded: discarded events
+ *
+ * Returns 0 on success, a negative value on error.
+ */
+int lib_ring_buffer_get_events_discarded(struct lttng_ust_lib_ring_buffer *buf,
+	struct lttng_ust_shm_handle *handle,
+	uint64_t *events_discarded)
+{
+	struct channel *chan = shmp(handle, buf->backend.chan);
+	const struct lttng_ust_lib_ring_buffer_config *config = &chan->backend.config;
+	struct specialized_lttng_ust_lib_ring_buffer_client_cb *client_cb;
+
+	client_cb = caa_container_of(config->cb_ptr,
+			struct specialized_lttng_ust_lib_ring_buffer_client_cb,
+			parent);
+	return client_cb->events_discarded(buf, handle, events_discarded);
+}
+
+/**
+ * lib_ring_buffer_get_content_size - get the content size of the subbuffer
+ * @buf: ring buffer
+ * @content_size: content size of the subbuffer
+ *
+ * Returns 0 on success, a negative value on error.
+ */
+int lib_ring_buffer_get_content_size(struct lttng_ust_lib_ring_buffer *buf,
+	struct lttng_ust_shm_handle *handle,
+	uint64_t *content_size)
+{
+	struct channel *chan = shmp(handle, buf->backend.chan);
+	const struct lttng_ust_lib_ring_buffer_config *config = &chan->backend.config;
+	struct specialized_lttng_ust_lib_ring_buffer_client_cb *client_cb;
+
+	client_cb = caa_container_of(config->cb_ptr,
+			struct specialized_lttng_ust_lib_ring_buffer_client_cb,
+			parent);
+	return client_cb->content_size(buf, handle, content_size);
+}
+
+/**
+ * lib_ring_buffer_get_packet_size - get the packet size of the subbuffer
+ * @buf: ring buffer
+ * @packet_size: packet size of the subbuffer
+ *
+ * Returns 0 on success, a negative value on error.
+ */
+int lib_ring_buffer_get_packet_size(struct lttng_ust_lib_ring_buffer *buf,
+	struct lttng_ust_shm_handle *handle,
+	uint64_t *packet_size)
+{
+	struct channel *chan = shmp(handle, buf->backend.chan);
+	const struct lttng_ust_lib_ring_buffer_config *config = &chan->backend.config;
+	struct specialized_lttng_ust_lib_ring_buffer_client_cb *client_cb;
+
+	client_cb = caa_container_of(config->cb_ptr,
+			struct specialized_lttng_ust_lib_ring_buffer_client_cb,
+			parent);
+	return client_cb->packet_size(buf, handle, packet_size);
+}
+
+/**
+ * lib_ring_buffer_get_stream_id - get the strean ID of the subbuffer
+ * @buf: ring buffer
+ * @stream_id: stream ID of the subbuffer
+ *
+ * Returns 0 on success, a negative value on error.
+ */
+int lib_ring_buffer_get_stream_id(struct lttng_ust_lib_ring_buffer *buf,
+		struct lttng_ust_shm_handle *handle,
+		uint64_t *stream_id)
+{
+	struct channel *chan = shmp(handle, buf->backend.chan);
+	const struct lttng_ust_lib_ring_buffer_config *config = &chan->backend.config;
+	struct specialized_lttng_ust_lib_ring_buffer_client_cb *client_cb;
+
+	client_cb = caa_container_of(config->cb_ptr,
+			struct specialized_lttng_ust_lib_ring_buffer_client_cb,
+			parent);
+	return client_cb->stream_id(buf, handle, stream_id);
+}
+
 /*
  * Force a read (imply TLS fixup for dlopen) of TLS variables.
  */
-- 
1.7.10.4
