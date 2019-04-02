From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/2] Fix relayd: initialize beacon
 to -1ULL
Date: Tue,  2 Apr 2019 13:41:16 -0400
Message-ID: <20190402174117.8663-1-mathieu.desnoyers__1820.80660467676$1554227042$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44Yc2g4p46z1Kvc
 for <lttng-dev@lists.lttng.org>; Tue,  2 Apr 2019 13:41:31 -0400 (EDT)
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

The relayd stream beacon_ts_end field is expected to have the value
-1ULL when unset (no beacon has been received since last index).

However, the initial state is wrong. It is left at the value 0, which
indicates that a live beacon has indeed been received (which is untrue),
which in turn causes a live beacon with ctf_stream_id of -1ULL to be
sent to babeltrace, which does not expect it, and fails.

This issue can be triggered with the following scenario:

1) create live session
2) setup UST per-uid buffers tracing
3) start tracing, without any active traced application
4) hook with babeltrace live client to view the trace
5) run a traced application

Step 5) will cause the babeltrace live client to receive a stream_id of
-1ULL, and error out.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-relayd/stream.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/bin/lttng-relayd/stream.c b/src/bin/lttng-relayd/stream.c
index 80c8aa0c..1218c2f4 100644
--- a/src/bin/lttng-relayd/stream.c
+++ b/src/bin/lttng-relayd/stream.c
@@ -98,6 +98,7 @@ struct relay_stream *stream_create(struct ctf_trace *trace,
 	stream->tracefile_count = tracefile_count;
 	stream->path_name = path_name;
 	stream->channel_name = channel_name;
+	stream->beacon_ts_end = -1ULL;
 	lttng_ht_node_init_u64(&stream->node, stream->stream_handle);
 	pthread_mutex_init(&stream->lock, NULL);
 	pthread_mutex_init(&stream->reflock, NULL);
-- 
2.17.1
