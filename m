From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [MODULES PATCH 3/3] Export the stream instance ID.
Date: Mon, 13 Jul 2015 11:09:25 -0400
Message-ID: <1436800165-14221-3-git-send-email-jdesfossez__36669.4615725011$1436800283$gmane$org@efficios.com>
References: <1436800165-14221-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZEfMT-00086K-T1
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 11:09:43 -0400
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

Allow the lttng-consumer to query the stream instance ID.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 lttng-abi.c                         | 18 ++++++++++++++++++
 lttng-abi.h                         |  5 +++++
 lttng-events.h                      |  3 +++
 lttng-ring-buffer-client.h          | 12 ++++++++++++
 lttng-ring-buffer-metadata-client.h |  9 +++++++++
 5 files changed, 47 insertions(+)

diff --git a/lttng-abi.c b/lttng-abi.c
index 586116d..79d6e7f 100644
--- a/lttng-abi.c
+++ b/lttng-abi.c
@@ -1517,6 +1517,15 @@ static long lttng_stream_ring_buffer_ioctl(struct file *filp,
 			goto error;
 		return put_u64(seq, arg);
 	}
+	case LTTNG_RING_BUFFER_INSTANCE_ID:
+	{
+		uint64_t id;
+
+		ret = ops->instance_id(config, buf, &id);
+		if (ret < 0)
+			goto error;
+		return put_u64(id, arg);
+	}
 	default:
 		return lib_ring_buffer_file_operations.unlocked_ioctl(filp,
 				cmd, arg);
@@ -1612,6 +1621,15 @@ static long lttng_stream_ring_buffer_compat_ioctl(struct file *filp,
 			goto error;
 		return put_u64(seq, arg);
 	}
+	case LTTNG_RING_BUFFER_COMPAT_INSTANCE_ID:
+	{
+		uint64_t id;
+
+		ret = ops->instance_id(config, buf, &id);
+		if (ret < 0)
+			goto error;
+		return put_u64(id, arg);
+	}
 	default:
 		return lib_ring_buffer_file_operations.compat_ioctl(filp,
 				cmd, arg);
diff --git a/lttng-abi.h b/lttng-abi.h
index 2d342c1..994d280 100644
--- a/lttng-abi.h
+++ b/lttng-abi.h
@@ -230,6 +230,8 @@ struct lttng_kernel_filter_bytecode {
 #define LTTNG_RING_BUFFER_GET_CURRENT_TIMESTAMP	_IOR(0xF6, 0x26, uint64_t)
 /* returns the packet sequence number */
 #define LTTNG_RING_BUFFER_GET_SEQ_NUM		_IOR(0xF6, 0x27, uint64_t)
+/* returns the stream instance id */
+#define LTTNG_RING_BUFFER_INSTANCE_ID		_IOR(0xF6, 0x28, uint64_t)
 
 #ifdef CONFIG_COMPAT
 /* returns the timestamp begin of the current sub-buffer */
@@ -256,6 +258,9 @@ struct lttng_kernel_filter_bytecode {
 /* returns the packet sequence number */
 #define LTTNG_RING_BUFFER_COMPAT_GET_SEQ_NUM	\
 	LTTNG_RING_BUFFER_GET_SEQ_NUM
+/* returns the stream instance id */
+#define LTTNG_RING_BUFFER_COMPAT_INSTANCE_ID	\
+	LTTNG_RING_BUFFER_INSTANCE_ID
 #endif /* CONFIG_COMPAT */
 
 #endif /* _LTTNG_ABI_H */
diff --git a/lttng-events.h b/lttng-events.h
index c8afd8f..f695bd5 100644
--- a/lttng-events.h
+++ b/lttng-events.h
@@ -362,6 +362,9 @@ struct lttng_channel_ops {
 			struct lib_ring_buffer *bufb,
 			uint64_t *seq);
 	uint64_t (*subbuf_size)(struct channel *chan);
+	int (*instance_id) (const struct lib_ring_buffer_config *config,
+			struct lib_ring_buffer *bufb,
+			uint64_t *id);
 };
 
 struct lttng_transport {
diff --git a/lttng-ring-buffer-client.h b/lttng-ring-buffer-client.h
index 69cc99e..6a2ee83 100644
--- a/lttng-ring-buffer-client.h
+++ b/lttng-ring-buffer-client.h
@@ -505,6 +505,17 @@ uint64_t client_get_subbuf_size(struct channel *chan)
 	return chan->backend.subbuf_size;
 }
 
+static
+int client_instance_id(const struct lib_ring_buffer_config *config,
+			struct lib_ring_buffer *buf,
+			uint64_t *id)
+{
+	struct packet_header *header = client_packet_header(config, buf);
+	*id = header->stream_instance_id;
+
+	return 0;
+}
+
 static const struct lib_ring_buffer_config client_config = {
 	.cb.ring_buffer_clock_read = client_ring_buffer_clock_read,
 	.cb.record_header_size = client_record_header_size,
@@ -737,6 +748,7 @@ static struct lttng_transport lttng_relay_transport = {
 		.current_timestamp = client_current_timestamp,
 		.sequence_number = client_sequence_number,
 		.subbuf_size = client_get_subbuf_size,
+		.instance_id = client_instance_id,
 	},
 };
 
diff --git a/lttng-ring-buffer-metadata-client.h b/lttng-ring-buffer-metadata-client.h
index da94aeb..a402301 100644
--- a/lttng-ring-buffer-metadata-client.h
+++ b/lttng-ring-buffer-metadata-client.h
@@ -212,6 +212,14 @@ uint64_t client_get_subbuf_size(struct channel *chan)
 	return -ENOSYS;
 }
 
+static
+int client_instance_id(const struct lib_ring_buffer_config *config,
+		struct lib_ring_buffer *bufb,
+		uint64_t *id)
+{
+	return -ENOSYS;
+}
+
 static const struct lib_ring_buffer_config client_config = {
 	.cb.ring_buffer_clock_read = client_ring_buffer_clock_read,
 	.cb.record_header_size = client_record_header_size,
@@ -420,6 +428,7 @@ static struct lttng_transport lttng_relay_transport = {
 		.current_timestamp = client_current_timestamp,
 		.sequence_number = client_sequence_number,
 		.subbuf_size = client_get_subbuf_size,
+		.instance_id = client_instance_id,
 	},
 };
 
-- 
1.9.1
