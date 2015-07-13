From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [UST PATCH 3/3] Export the stream instance ID.
Date: Mon, 13 Jul 2015 11:12:09 -0400
Message-ID: <1436800329-15061-3-git-send-email-jdesfossez__29436.9598654614$1436800445$gmane$org@efficios.com>
References: <1436800329-15061-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZEfP2-0008CR-9Y
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 11:12:21 -0400
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

Allow the lttng-consumer to query the stream instance ID.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 include/lttng/ust-ctl.h                 |  2 ++
 liblttng-ust-ctl/ustctl.c               | 18 ++++++++++++++++++
 liblttng-ust/lttng-rb-clients.h         |  2 ++
 liblttng-ust/lttng-ring-buffer-client.h | 13 +++++++++++++
 4 files changed, 35 insertions(+)

diff --git a/include/lttng/ust-ctl.h b/include/lttng/ust-ctl.h
index d27ca8a..b246a51 100644
--- a/include/lttng/ust-ctl.h
+++ b/include/lttng/ust-ctl.h
@@ -243,6 +243,8 @@ int ustctl_get_current_timestamp(struct ustctl_consumer_stream *stream,
 		uint64_t *ts);
 int ustctl_get_sequence_number(struct ustctl_consumer_stream *stream,
 		uint64_t *seq);
+int ustctl_get_instance_id(struct ustctl_consumer_stream *stream,
+		uint64_t *id);
 
 /* returns whether UST has perf counters support. */
 int ustctl_has_perf_counters(void);
diff --git a/liblttng-ust-ctl/ustctl.c b/liblttng-ust-ctl/ustctl.c
index 010dfd8..43fce9e 100644
--- a/liblttng-ust-ctl/ustctl.c
+++ b/liblttng-ust-ctl/ustctl.c
@@ -1663,6 +1663,24 @@ int ustctl_get_sequence_number(struct ustctl_consumer_stream *stream,
 	return client_cb->sequence_number(buf, handle, seq);
 }
 
+int ustctl_get_instance_id(struct ustctl_consumer_stream *stream,
+		uint64_t *id)
+{
+	struct lttng_ust_client_lib_ring_buffer_client_cb *client_cb;
+	struct lttng_ust_lib_ring_buffer *buf;
+	struct lttng_ust_shm_handle *handle;
+
+	if (!stream || !id)
+		return -EINVAL;
+	buf = stream->buf;
+	handle = stream->chan->chan->handle;
+	client_cb = get_client_cb(buf, handle);
+	if (!client_cb)
+		return -ENOSYS;
+	return client_cb->instance_id(buf, handle, id);
+}
+
+
 #if defined(__x86_64__) || defined(__i386__)
 
 int ustctl_has_perf_counters(void)
diff --git a/liblttng-ust/lttng-rb-clients.h b/liblttng-ust/lttng-rb-clients.h
index 788f075..e54decb 100644
--- a/liblttng-ust/lttng-rb-clients.h
+++ b/liblttng-ust/lttng-rb-clients.h
@@ -45,6 +45,8 @@ struct lttng_ust_client_lib_ring_buffer_client_cb {
 			uint64_t *ts);
 	int (*sequence_number) (struct lttng_ust_lib_ring_buffer *buf,
 		struct lttng_ust_shm_handle *handle, uint64_t *seq);
+	int (*instance_id) (struct lttng_ust_lib_ring_buffer *buf,
+			struct lttng_ust_shm_handle *handle, uint64_t *id);
 };
 
 #endif /* _LTTNG_RB_CLIENT_H */
diff --git a/liblttng-ust/lttng-ring-buffer-client.h b/liblttng-ust/lttng-ring-buffer-client.h
index 1e93cff..63df2f9 100644
--- a/liblttng-ust/lttng-ring-buffer-client.h
+++ b/liblttng-ust/lttng-ring-buffer-client.h
@@ -516,6 +516,18 @@ static int client_sequence_number(struct lttng_ust_lib_ring_buffer *buf,
 	return 0;
 }
 
+static int client_instance_id(struct lttng_ust_lib_ring_buffer *buf,
+		struct lttng_ust_shm_handle *handle,
+		uint64_t *id)
+{
+	struct packet_header *header;
+
+	header = client_packet_header(buf, handle);
+	*id = header->stream_instance_id;
+	return 0;
+}
+
+
 static const
 struct lttng_ust_client_lib_ring_buffer_client_cb client_cb = {
 	.parent = {
@@ -537,6 +549,7 @@ struct lttng_ust_client_lib_ring_buffer_client_cb client_cb = {
 	.stream_id = client_stream_id,
 	.current_timestamp = client_current_timestamp,
 	.sequence_number = client_sequence_number,
+	.instance_id = client_instance_id,
 };
 
 static const struct lttng_ust_lib_ring_buffer_config client_config = {
-- 
1.9.1
