From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [UST PATCH 3/3] Per-stream ioctl to get the current
	timestamp
Date: Thu, 19 Sep 2013 13:51:55 -0400
Message-ID: <1379613115-28789-3-git-send-email-jdesfossez__41423.1447539807$1379613456$gmane$org@efficios.com>
References: <1379613115-28789-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1VMiOn-0002wR-9k
	for lttng-dev@lists.lttng.org; Thu, 19 Sep 2013 13:52:27 -0400
In-Reply-To: <1379613115-28789-1-git-send-email-jdesfossez@efficios.com>
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

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 include/lttng/ust-ctl.h                 |  2 ++
 liblttng-ust-ctl/ustctl.c               | 15 +++++++++++++++
 liblttng-ust/lttng-rb-clients.h         |  3 +++
 liblttng-ust/lttng-ring-buffer-client.h | 13 +++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/include/lttng/ust-ctl.h b/include/lttng/ust-ctl.h
index 88112ad..c8ac3f9 100644
--- a/include/lttng/ust-ctl.h
+++ b/include/lttng/ust-ctl.h
@@ -233,6 +233,8 @@ int ustctl_get_packet_size(struct ustctl_consumer_stream *stream,
 	uint64_t *packet_size);
 int ustctl_get_stream_id(struct ustctl_consumer_stream *stream,
 		uint64_t *stream_id);
+int ustctl_get_current_timestamp(struct ustctl_consumer_stream *stream,
+		uint64_t *ts);
 
 /* event registry management */
 
diff --git a/liblttng-ust-ctl/ustctl.c b/liblttng-ust-ctl/ustctl.c
index 7830132..11fc704 100644
--- a/liblttng-ust-ctl/ustctl.c
+++ b/liblttng-ust-ctl/ustctl.c
@@ -1571,6 +1571,21 @@ int ustctl_get_stream_id(struct ustctl_consumer_stream *stream,
 	return client_cb->stream_id(buf, handle, stream_id);
 }
 
+int ustctl_get_current_timestamp(struct ustctl_consumer_stream *stream,
+		uint64_t *ts)
+{
+	struct lttng_ust_client_lib_ring_buffer_client_cb *client_cb;
+	struct lttng_ust_lib_ring_buffer *buf = stream->buf;
+	struct lttng_ust_shm_handle *handle = stream->chan->chan->handle;
+
+	if (!stream || !ts)
+		return -EINVAL;
+	client_cb = get_client_cb(buf, handle);
+	if (!client_cb || !client_cb->current_timestamp)
+		return -ENOSYS;
+	return client_cb->current_timestamp(buf, handle, ts);
+}
+
 /*
  * Returns 0 on success, negative error value on error.
  */
diff --git a/liblttng-ust/lttng-rb-clients.h b/liblttng-ust/lttng-rb-clients.h
index c43aa75..85d4e1b 100644
--- a/liblttng-ust/lttng-rb-clients.h
+++ b/liblttng-ust/lttng-rb-clients.h
@@ -40,6 +40,9 @@ struct lttng_ust_client_lib_ring_buffer_client_cb {
 	int (*stream_id) (struct lttng_ust_lib_ring_buffer *buf,
 			struct lttng_ust_shm_handle *handle,
 			uint64_t *stream_id);
+	int (*current_timestamp) (struct lttng_ust_lib_ring_buffer *buf,
+			struct lttng_ust_shm_handle *handle,
+			uint64_t *ts);
 };
 
 #endif /* _LTTNG_RB_CLIENT_H */
diff --git a/liblttng-ust/lttng-ring-buffer-client.h b/liblttng-ust/lttng-ring-buffer-client.h
index 4671713..2cdecbe 100644
--- a/liblttng-ust/lttng-ring-buffer-client.h
+++ b/liblttng-ust/lttng-ring-buffer-client.h
@@ -470,6 +470,18 @@ static int client_stream_id(struct lttng_ust_lib_ring_buffer *buf,
 	return 0;
 }
 
+static int client_current_timestamp(struct lttng_ust_lib_ring_buffer *buf,
+		struct lttng_ust_shm_handle *handle,
+		uint64_t *ts)
+{
+	struct channel *chan;
+
+	chan = shmp(handle, handle->chan);
+	*ts = client_ring_buffer_clock_read(chan);
+
+	return 0;
+}
+
 static const
 struct lttng_ust_client_lib_ring_buffer_client_cb client_cb = {
 	.parent = {
@@ -487,6 +499,7 @@ struct lttng_ust_client_lib_ring_buffer_client_cb client_cb = {
 	.content_size = client_content_size,
 	.packet_size = client_packet_size,
 	.stream_id = client_stream_id,
+	.current_timestamp = client_current_timestamp,
 };
 
 static const struct lttng_ust_lib_ring_buffer_config client_config = {
-- 
1.8.3.2
