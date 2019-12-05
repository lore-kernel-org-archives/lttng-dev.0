From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH babeltrace-1.5 1/6] Fix: lttng-live:
 use-after-free in get_next_index()
Date: Thu,  5 Dec 2019 01:58:04 -0500
Message-ID: <20191205065809.16728-2-mathieu.desnoyers__45016.8532946677$1575529177$gmane$org@efficios.com>
References: <20191205065809.16728-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 47T64Q5sn5z10G1
 for <lttng-dev@lists.lttng.org>; Thu,  5 Dec 2019 01:58:14 -0500 (EST)
In-Reply-To: <20191205065809.16728-1-mathieu.desnoyers@efficios.com>
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

Running babeltrace under valgrind with a test-cases doing per-pid
lttng tracing in live mode triggers this use-after-free in
get_next_index() when stream is hung up.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 formats/lttng-live/lttng-live-comm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/formats/lttng-live/lttng-live-comm.c b/formats/lttng-live/lttng-live-comm.c
index 33a78029..96817f5e 100644
--- a/formats/lttng-live/lttng-live-comm.c
+++ b/formats/lttng-live/lttng-live-comm.c
@@ -1108,8 +1108,8 @@ retry:
 		viewer_stream->in_trace = 0;
 		bt_list_del(&viewer_stream->trace_stream_node);
 		bt_list_del(&viewer_stream->session_stream_node);
-		g_free(viewer_stream);
 		*stream_id = be64toh(rp->stream_id);
+		g_free(viewer_stream);
 		break;
 	case LTTNG_VIEWER_INDEX_ERR:
 		fprintf(stderr, "[error] get_next_index: error\n");
-- 
2.17.1
