From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-ust 1/1] Fix: don't access packet header
 for stream_id and stream_instance_id getters
Date: Wed, 10 Apr 2019 10:49:53 -0400
Message-ID: <20190410144953.9792-1-mathieu.desnoyers__17471.0987763078$1554907822$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44fRrz6Jyrz1Kgq
 for <lttng-dev@lists.lttng.org>; Wed, 10 Apr 2019 10:49:55 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: joraj@efficios.com, jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The stream ID and stream instance ID are invariant for a stream, so
there is no point reading them from the packet header currently owned by
the consumer (between get/put subbuf).

Actually, the consumer try to access the stream_id from the live timer
when sending a live beacon without getting the reader subbuffer first,
which was handled by issuing a CHAN_WARN_ON, which disables tracing for
the channel, and prints warning to the consumerd console when running
consumerd with LTTNG_UST_DEBUG=1).

In the case where a ring buffer does not have any data ready, it makes
no sense to try to get a subbuffer for reading anyway, so the approach
was broken.

So return the stream id and stream instance id from the internal
data structures rather than reading it from the ring buffer.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 liblttng-ust/lttng-ring-buffer-client.h | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/liblttng-ust/lttng-ring-buffer-client.h b/liblttng-ust/lttng-ring-buffer-client.h
index 0fae8878..ab472352 100644
--- a/liblttng-ust/lttng-ring-buffer-client.h
+++ b/liblttng-ust/lttng-ring-buffer-client.h
@@ -580,12 +580,11 @@ static int client_stream_id(struct lttng_ust_lib_ring_buffer *buf,
 		struct lttng_ust_shm_handle *handle,
 		uint64_t *stream_id)
 {
-	struct packet_header *header;
+	struct channel *chan = shmp(handle, buf->backend.chan);
+	struct lttng_channel *lttng_chan = channel_get_private(chan);
+
+	*stream_id = lttng_chan->id;
 
-	header = client_packet_header(buf, handle);
-	if (!header)
-		return -1;
-	*stream_id = header->stream_id;
 	return 0;
 }
 
@@ -616,10 +615,8 @@ static int client_instance_id(struct lttng_ust_lib_ring_buffer *buf,
 		struct lttng_ust_shm_handle *handle,
 		uint64_t *id)
 {
-	struct packet_header *header;
+	*id = buf->backend.cpu;
 
-	header = client_packet_header(buf, handle);
-	*id = header->stream_instance_id;
 	return 0;
 }
 
-- 
2.11.0
