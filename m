From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2/3] Fix: relayd: put chunk
 reference when closing stream
Date: Fri,  1 Nov 2019 16:23:04 -0400
Message-ID: <20191101202305.21496-2-mathieu.desnoyers__29137.1185144939$1572639844$gmane$org@efficios.com>
References: <20191101202305.21496-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 474YXz0ZvCzrTy
 for <lttng-dev@lists.lttng.org>; Fri,  1 Nov 2019 16:23:15 -0400 (EDT)
In-Reply-To: <20191101202305.21496-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

If a stream is closed by an application exiting (per-pid buffers), it
needs to put its reference on the stream trace chunk right away, because
otherwise still holding the reference on the trace chunk could allow a
viewer stream (which holds a reference to the stream) to postpone
destroy waiting for the chunk to cease to exist endlessly until the
viewer is detached.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-relayd/stream.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/src/bin/lttng-relayd/stream.c b/src/bin/lttng-relayd/stream.c
index 4d3d37a2..9d753bd0 100644
--- a/src/bin/lttng-relayd/stream.c
+++ b/src/bin/lttng-relayd/stream.c
@@ -923,6 +923,27 @@ void try_stream_close(struct relay_stream *stream)
 	stream->closed = true;
 	/* Relay indexes are only used by the "consumer/sessiond" end. */
 	relay_index_close_all(stream);
+
+	/*
+	 * If we are closed by an application exiting (per-pid buffers),
+	 * we need to put our reference on the stream trace chunk right
+	 * away, because otherwise still holding the reference on the
+	 * trace chunk could allow a viewer stream (which holds a reference
+	 * to the stream) to postpone destroy waiting for the chunk to cease
+	 * to exist endlessly until the viewer is detached.
+	 */
+
+	/* Put stream fd before put chunk. */
+	if (stream->stream_fd) {
+		stream_fd_put(stream->stream_fd);
+		stream->stream_fd = NULL;
+	}
+	if (stream->index_file) {
+		lttng_index_file_put(stream->index_file);
+		stream->index_file = NULL;
+	}
+	lttng_trace_chunk_put(stream->trace_chunk);
+	stream->trace_chunk = NULL;
 	pthread_mutex_unlock(&stream->lock);
 	DBG("Succeeded in closing stream %" PRIu64, stream->stream_handle);
 	stream_put(stream);
-- 
2.17.1
