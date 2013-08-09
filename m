From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [MODULES PATCH 2/2] LTTng ringbuffer ABI calls for
	index generation
Date: Fri,  9 Aug 2013 11:14:50 -0400
Message-ID: <1376061290-30116-2-git-send-email-jdesfossez__10984.2164828025$1376061510$gmane$org@efficios.com>
References: <1376061290-30116-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1V7oPA-0004az-RV
	for lttng-dev@lists.lttng.org; Fri, 09 Aug 2013 11:15:11 -0400
In-Reply-To: <1376061290-30116-1-git-send-email-jdesfossez@efficios.com>
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

These new calls export the data required for the consumer to generate
the index while tracing :
- timestamp begin
- timestamp end
- events discarded
- context size
- packet size
- stream id

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 lttng-abi.c                         |  174 +++++++++++++++++++++++++++++++++--
 lttng-abi.h                         |   35 +++++++
 lttng-events.c                      |    2 +-
 lttng-events.h                      |   19 ++++
 lttng-ring-buffer-client.h          |   84 +++++++++++++++++
 lttng-ring-buffer-metadata-client.h |   48 ++++++++++
 6 files changed, 355 insertions(+), 7 deletions(-)

diff --git a/lttng-abi.c b/lttng-abi.c
index 9a25490..28b9a04 100644
--- a/lttng-abi.c
+++ b/lttng-abi.c
@@ -52,6 +52,7 @@
 #include "lttng-abi-old.h"
 #include "lttng-events.h"
 #include "lttng-tracer.h"
+#include "lib/ringbuffer/frontend_types.h"
 
 /*
  * This is LTTng's own personal way to create a system call as an external
@@ -1294,25 +1295,186 @@ static const struct file_operations lttng_event_fops = {
 #endif
 };
 
+static int put_u64(uint64_t val, unsigned long arg)
+{
+	return put_user(val, (uint64_t __user *) arg);
+}
+
 static long lttng_stream_ring_buffer_ioctl(struct file *filp,
 		unsigned int cmd, unsigned long arg)
 {
+	struct lib_ring_buffer *buf = filp->private_data;
+	struct channel *chan = buf->backend.chan;
+	const struct lib_ring_buffer_config *config = &chan->backend.config;
+	struct lttng_channel *lttng_chan = channel_get_private(chan);
+	int ret;
+
+	if (atomic_read(&chan->record_disabled))
+		return -EIO;
+
 	switch (cmd) {
-		default:
-			return lib_ring_buffer_file_operations.unlocked_ioctl(filp,
-					cmd, arg);
+	case LTTNG_RING_BUFFER_GET_TIMESTAMP_BEGIN:
+	{
+		uint64_t ts;
+
+		if (!lttng_chan->ops)
+			goto error;
+		ret = lttng_chan->ops->timestamp_begin(config, buf, &ts);
+		if (ret < 0)
+			goto error;
+		return put_u64(ts, arg);
+	}
+	case LTTNG_RING_BUFFER_GET_TIMESTAMP_END:
+	{
+		uint64_t ts;
+
+		if (!lttng_chan->ops)
+			goto error;
+		ret = lttng_chan->ops->timestamp_end(config, buf, &ts);
+		if (ret < 0)
+			goto error;
+		return put_u64(ts, arg);
+	}
+	case LTTNG_RING_BUFFER_GET_EVENTS_DISCARDED:
+	{
+		uint64_t ed;
+
+		if (!lttng_chan->ops)
+			goto error;
+		ret = lttng_chan->ops->events_discarded(config, buf, &ed);
+		if (ret < 0)
+			goto error;
+		return put_u64(ed, arg);
+	}
+	case LTTNG_RING_BUFFER_GET_CONTENT_SIZE:
+	{
+		uint64_t cs;
+
+		if (!lttng_chan->ops)
+			goto error;
+		ret = lttng_chan->ops->content_size(config, buf, &cs);
+		if (ret < 0)
+			goto error;
+		return put_u64(cs, arg);
+	}
+	case LTTNG_RING_BUFFER_GET_PACKET_SIZE:
+	{
+		uint64_t ps;
+
+		if (!lttng_chan->ops)
+			goto error;
+		ret = lttng_chan->ops->packet_size(config, buf, &ps);
+		if (ret < 0)
+			goto error;
+		return put_u64(ps, arg);
+	}
+	case LTTNG_RING_BUFFER_GET_STREAM_ID:
+	{
+		uint64_t si;
+
+		if (!lttng_chan->ops)
+			goto error;
+		ret = lttng_chan->ops->stream_id(config, buf, &si);
+		if (ret < 0)
+			goto error;
+		return put_u64(si, arg);
 	}
+	default:
+		return lib_ring_buffer_file_operations.unlocked_ioctl(filp,
+				cmd, arg);
+	}
+
+error:
+	return -ENOSYS;
 }
 
 #ifdef CONFIG_COMPAT
 static long lttng_stream_ring_buffer_compat_ioctl(struct file *filp,
 		unsigned int cmd, unsigned long arg)
 {
+	struct lib_ring_buffer *buf = filp->private_data;
+	struct channel *chan = buf->backend.chan;
+	const struct lib_ring_buffer_config *config = &chan->backend.config;
+	struct lttng_channel *lttng_chan = channel_get_private(chan);
+	int ret;
+
+	if (atomic_read(&chan->record_disabled))
+		return -EIO;
+
 	switch (cmd) {
-		default:
-			return lib_ring_buffer_file_operations.compat_ioctl(filp,
-					cmd, arg);
+	case LTTNG_RING_BUFFER_COMPAT_GET_TIMESTAMP_BEGIN:
+	{
+		uint64_t ts;
+
+		if (!lttng_chan->ops)
+			goto error;
+		ret = lttng_chan->ops->timestamp_begin(config, buf, &ts);
+		if (ret < 0)
+			goto error;
+		return put_u64(ts, arg);
+	}
+	case LTTNG_RING_BUFFER_COMPAT_GET_TIMESTAMP_END:
+	{
+		uint64_t ts;
+
+		if (!lttng_chan->ops)
+			goto error;
+		ret = lttng_chan->ops->timestamp_end(config, buf, &ts);
+		if (ret < 0)
+			goto error;
+		return put_u64(ts, arg);
+	}
+	case LTTNG_RING_BUFFER_COMPAT_GET_EVENTS_DISCARDED:
+	{
+		uint64_t ed;
+
+		if (!lttng_chan->ops)
+			goto error;
+		ret = lttng_chan->ops->events_discarded(config, buf, &ed);
+		if (ret < 0)
+			goto error;
+		return put_u64(ed, arg);
 	}
+	case LTTNG_RING_BUFFER_COMPAT_GET_CONTENT_SIZE:
+	{
+		uint64_t cs;
+
+		if (!lttng_chan->ops)
+			goto error;
+		ret = lttng_chan->ops->content_size(config, buf, &cs);
+		if (ret < 0)
+			goto error;
+		return put_u64(cs, arg);
+	}
+	case LTTNG_RING_BUFFER_COMPAT_GET_PACKET_SIZE:
+	{
+		uint64_t ps;
+
+		if (!lttng_chan->ops)
+			goto error;
+		ret = lttng_chan->ops->packet_size(config, buf, &ps);
+		if (ret < 0)
+			goto error;
+		return put_u64(ps, arg);
+	}
+	case LTTNG_RING_BUFFER_COMPAT_GET_STREAM_ID:
+	{
+		uint64_t si;
+
+		if (!lttng_chan->ops)
+			goto error;
+		ret = lttng_chan->ops->stream_id(config, buf, &si);
+		if (ret < 0)
+			goto error;
+		return put_u64(si, arg);
+	}
+	default:
+		return lib_ring_buffer_file_operations.compat_ioctl(filp,
+				cmd, arg);
+	}
+
+error:
+	return -ENOSYS;
 }
 #endif /* CONFIG_COMPAT */
 
diff --git a/lttng-abi.h b/lttng-abi.h
index 8d3ecdd..b028f1e 100644
--- a/lttng-abi.h
+++ b/lttng-abi.h
@@ -174,4 +174,39 @@ struct lttng_kernel_context {
 #define LTTNG_KERNEL_ENABLE			_IO(0xF6, 0x82)
 #define LTTNG_KERNEL_DISABLE			_IO(0xF6, 0x83)
 
+/* LTTng-specific ioctls for the lib ringbuffer */
+/* returns the timestamp begin of the current sub-buffer */
+#define LTTNG_RING_BUFFER_GET_TIMESTAMP_BEGIN	_IOR(0xF6, 0x20, uint64_t)
+/* returns the timestamp end of the current sub-buffer */
+#define LTTNG_RING_BUFFER_GET_TIMESTAMP_END	_IOR(0xF6, 0x21, uint64_t)
+/* returns the number of events discarded */
+#define LTTNG_RING_BUFFER_GET_EVENTS_DISCARDED	_IOR(0xF6, 0x22, uint64_t)
+/* returns the packet payload size */
+#define LTTNG_RING_BUFFER_GET_CONTENT_SIZE	_IOR(0xF6, 0x23, uint64_t)
+/* returns the actual packet size */
+#define LTTNG_RING_BUFFER_GET_PACKET_SIZE	_IOR(0xF6, 0x24, uint64_t)
+/* returns the stream id */
+#define LTTNG_RING_BUFFER_GET_STREAM_ID		_IOR(0xF6, 0x25, uint64_t)
+
+#ifdef CONFIG_COMPAT
+/* returns the timestamp begin of the current sub-buffer */
+#define LTTNG_RING_BUFFER_COMPAT_GET_TIMESTAMP_BEGIN \
+	LTTNG_RING_BUFFER_GET_TIMESTAMP_BEGIN
+/* returns the timestamp end of the current sub-buffer */
+#define LTTNG_RING_BUFFER_COMPAT_GET_TIMESTAMP_END \
+	LTTNG_RING_BUFFER_GET_TIMESTAMP_END
+/* returns the number of events discarded */
+#define LTTNG_RING_BUFFER_COMPAT_GET_EVENTS_DISCARDED \
+	LTTNG_RING_BUFFER_GET_EVENTS_DISCARDED
+/* returns the packet payload size */
+#define LTTNG_RING_BUFFER_COMPAT_GET_CONTENT_SIZE \
+	LTTNG_RING_BUFFER_GET_CONTENT_SIZE
+/* returns the actual packet size */
+#define LTTNG_RING_BUFFER_COMPAT_GET_PACKET_SIZE \
+	LTTNG_RING_BUFFER_GET_PACKET_SIZE
+/* returns the stream id */
+#define LTTNG_RING_BUFFER_COMPAT_GET_STREAM_ID \
+	LTTNG_RING_BUFFER_GET_STREAM_ID
+#endif /* CONFIG_COMPAT */
+
 #endif /* _LTTNG_ABI_H */
diff --git a/lttng-events.c b/lttng-events.c
index 567df65..7cb1b93 100644
--- a/lttng-events.c
+++ b/lttng-events.c
@@ -285,6 +285,7 @@ struct lttng_channel *lttng_channel_create(struct lttng_session *session,
 		goto nomem;
 	chan->session = session;
 	chan->id = session->free_chan_id++;
+	chan->ops = &transport->ops;
 	/*
 	 * Note: the channel creation op already writes into the packet
 	 * headers. Therefore the "chan" information used as input
@@ -296,7 +297,6 @@ struct lttng_channel *lttng_channel_create(struct lttng_session *session,
 	if (!chan->chan)
 		goto create_error;
 	chan->enabled = 1;
-	chan->ops = &transport->ops;
 	chan->transport = transport;
 	chan->channel_type = channel_type;
 	list_add(&chan->list, &session->chan);
diff --git a/lttng-events.h b/lttng-events.h
index 4c1f322..08d0a5a 100644
--- a/lttng-events.h
+++ b/lttng-events.h
@@ -39,6 +39,7 @@ struct lttng_metadata_cache;
 struct lib_ring_buffer_ctx;
 struct perf_event;
 struct perf_event_attr;
+struct lib_ring_buffer_config;
 
 /* Type description */
 
@@ -244,6 +245,24 @@ struct lttng_channel_ops {
 	wait_queue_head_t *(*get_hp_wait_queue)(struct channel *chan);
 	int (*is_finalized)(struct channel *chan);
 	int (*is_disabled)(struct channel *chan);
+	int (*timestamp_begin) (const struct lib_ring_buffer_config *config,
+			struct lib_ring_buffer *bufb,
+			uint64_t *timestamp_begin);
+	int (*timestamp_end) (const struct lib_ring_buffer_config *config,
+			struct lib_ring_buffer *bufb,
+			uint64_t *timestamp_end);
+	int (*events_discarded) (const struct lib_ring_buffer_config *config,
+			struct lib_ring_buffer *bufb,
+			uint64_t *events_discarded);
+	int (*content_size) (const struct lib_ring_buffer_config *config,
+			struct lib_ring_buffer *bufb,
+			uint64_t *content_size);
+	int (*packet_size) (const struct lib_ring_buffer_config *config,
+			struct lib_ring_buffer *bufb,
+			uint64_t *packet_size);
+	int (*stream_id) (const struct lib_ring_buffer_config *config,
+			struct lib_ring_buffer *bufb,
+			uint64_t *stream_id);
 };
 
 struct lttng_transport {
diff --git a/lttng-ring-buffer-client.h b/lttng-ring-buffer-client.h
index 0b05561..167000a 100644
--- a/lttng-ring-buffer-client.h
+++ b/lttng-ring-buffer-client.h
@@ -390,6 +390,83 @@ static void client_buffer_finalize(struct lib_ring_buffer *buf, void *priv, int
 {
 }
 
+static struct packet_header *client_packet_header(
+		const struct lib_ring_buffer_config *config,
+		struct lib_ring_buffer *buf)
+{
+	struct lib_ring_buffer_backend *bufb;
+	unsigned long sb_bindex;
+	struct packet_header *header;
+
+	bufb = &buf->backend;
+	sb_bindex = subbuffer_id_get_index(config, bufb->buf_rsb.id);
+	header = (struct packet_header *)
+		lib_ring_buffer_offset_address(bufb,
+				sb_bindex * bufb->chan->backend.subbuf_size);
+
+	return header;
+}
+
+static int client_timestamp_begin(const struct lib_ring_buffer_config *config,
+		struct lib_ring_buffer *buf,
+		uint64_t *timestamp_begin)
+{
+	struct packet_header *header = client_packet_header(config, buf);
+	*timestamp_begin = header->ctx.timestamp_begin;
+
+	return 0;
+}
+
+static int client_timestamp_end(const struct lib_ring_buffer_config *config,
+			struct lib_ring_buffer *buf,
+			uint64_t *timestamp_end)
+{
+	struct packet_header *header = client_packet_header(config, buf);
+	*timestamp_end = header->ctx.timestamp_end;
+
+	return 0;
+}
+
+static int client_events_discarded(const struct lib_ring_buffer_config *config,
+			struct lib_ring_buffer *buf,
+			uint64_t *events_discarded)
+{
+	struct packet_header *header = client_packet_header(config, buf);
+	*events_discarded = header->ctx.events_discarded;
+
+	return 0;
+}
+
+static int client_content_size(const struct lib_ring_buffer_config *config,
+			struct lib_ring_buffer *buf,
+			uint64_t *content_size)
+{
+	struct packet_header *header = client_packet_header(config, buf);
+	*content_size = header->ctx.content_size;
+
+	return 0;
+}
+
+static int client_packet_size(const struct lib_ring_buffer_config *config,
+			struct lib_ring_buffer *buf,
+			uint64_t *packet_size)
+{
+	struct packet_header *header = client_packet_header(config, buf);
+	*packet_size = header->ctx.packet_size;
+
+	return 0;
+}
+
+static int client_stream_id(const struct lib_ring_buffer_config *config,
+			struct lib_ring_buffer *buf,
+			uint64_t *stream_id)
+{
+	struct packet_header *header = client_packet_header(config, buf);
+	*stream_id = header->stream_id;
+
+	return 0;
+}
+
 static const struct lib_ring_buffer_config client_config = {
 	.cb.ring_buffer_clock_read = client_ring_buffer_clock_read,
 	.cb.record_header_size = client_record_header_size,
@@ -417,6 +494,13 @@ struct channel *_channel_create(const char *name,
 				unsigned int switch_timer_interval,
 				unsigned int read_timer_interval)
 {
+	lttng_chan->ops->timestamp_begin = client_timestamp_begin;
+	lttng_chan->ops->timestamp_end = client_timestamp_end;
+	lttng_chan->ops->events_discarded = client_events_discarded;
+	lttng_chan->ops->content_size = client_content_size;
+	lttng_chan->ops->packet_size = client_packet_size;
+	lttng_chan->ops->stream_id = client_stream_id;
+
 	return channel_create(&client_config, name, lttng_chan, buf_addr,
 			      subbuf_size, num_subbuf, switch_timer_interval,
 			      read_timer_interval);
diff --git a/lttng-ring-buffer-metadata-client.h b/lttng-ring-buffer-metadata-client.h
index 1c77f99..6130715 100644
--- a/lttng-ring-buffer-metadata-client.h
+++ b/lttng-ring-buffer-metadata-client.h
@@ -148,6 +148,47 @@ static void client_buffer_finalize(struct lib_ring_buffer *buf, void *priv, int
 {
 }
 
+static int client_timestamp_begin(const struct lib_ring_buffer_config *config,
+		struct lib_ring_buffer *buf, uint64_t *timestamp_begin)
+{
+	return -ENOSYS;
+}
+
+static int client_timestamp_end(const struct lib_ring_buffer_config *config,
+			struct lib_ring_buffer *bufb,
+			uint64_t *timestamp_end)
+{
+	return -ENOSYS;
+}
+
+static int client_events_discarded(const struct lib_ring_buffer_config *config,
+			struct lib_ring_buffer *bufb,
+			uint64_t *events_discarded)
+{
+	return -ENOSYS;
+}
+
+static int client_content_size(const struct lib_ring_buffer_config *config,
+			struct lib_ring_buffer *bufb,
+			uint64_t *content_size)
+{
+	return -ENOSYS;
+}
+
+static int client_packet_size(const struct lib_ring_buffer_config *config,
+			struct lib_ring_buffer *bufb,
+			uint64_t *packet_size)
+{
+	return -ENOSYS;
+}
+
+static int client_stream_id(const struct lib_ring_buffer_config *config,
+			struct lib_ring_buffer *bufb,
+			uint64_t *stream_id)
+{
+	return -ENOSYS;
+}
+
 static const struct lib_ring_buffer_config client_config = {
 	.cb.ring_buffer_clock_read = client_ring_buffer_clock_read,
 	.cb.record_header_size = client_record_header_size,
@@ -175,6 +216,13 @@ struct channel *_channel_create(const char *name,
 				unsigned int switch_timer_interval,
 				unsigned int read_timer_interval)
 {
+	lttng_chan->ops->timestamp_begin = client_timestamp_begin;
+	lttng_chan->ops->timestamp_end = client_timestamp_end;
+	lttng_chan->ops->events_discarded = client_events_discarded;
+	lttng_chan->ops->content_size = client_content_size;
+	lttng_chan->ops->packet_size = client_packet_size;
+	lttng_chan->ops->stream_id = client_stream_id;
+
 	return channel_create(&client_config, name, lttng_chan, buf_addr,
 			      subbuf_size, num_subbuf, switch_timer_interval,
 			      read_timer_interval);
-- 
1.7.10.4
