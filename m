From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-modules 1/1] Fix: don't access packet
 header for stream_id and stream_instance_id getters
Date: Wed, 10 Apr 2019 10:48:57 -0400
Message-ID: <20190410144857.7827-1-mathieu.desnoyers__7186.36132530577$1554907765$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44fRr24Y9Sz1KgM
 for <lttng-dev@lists.lttng.org>; Wed, 10 Apr 2019 10:49:06 -0400 (EDT)
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
which can trigger WARN_ON safety nets in libringbuffer. This safety
net triggers a kernel OOPS report and disables tracing for that channel.

In the case where a ring buffer does not have any data ready, it makes
no sense to try to get a subbuffer for reading anyway, so the approach
was broken.

So return the stream id and stream instance id from the internal
data structures rather than reading it from the ring buffer.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 lttng-ring-buffer-client.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lttng-ring-buffer-client.h b/lttng-ring-buffer-client.h
index dc3356e4..d5c512c5 100644
--- a/lttng-ring-buffer-client.h
+++ b/lttng-ring-buffer-client.h
@@ -479,9 +479,10 @@ static int client_stream_id(const struct lib_ring_buffer_config *config,
 			struct lib_ring_buffer *buf,
 			uint64_t *stream_id)
 {
-	struct packet_header *header = client_packet_header(config, buf);
-	*stream_id = header->stream_id;
+	struct channel *chan = buf->backend.chan;
+	struct lttng_channel *lttng_chan = channel_get_private(chan);
 
+	*stream_id = lttng_chan->id;
 	return 0;
 }
 
@@ -510,8 +511,7 @@ int client_instance_id(const struct lib_ring_buffer_config *config,
 		struct lib_ring_buffer *buf,
 		uint64_t *id)
 {
-	struct packet_header *header = client_packet_header(config, buf);
-	*id = header->stream_instance_id;
+	*id = buf->backend.cpu;
 
 	return 0;
 }
-- 
2.11.0
