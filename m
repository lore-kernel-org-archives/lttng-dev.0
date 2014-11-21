From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: relayd viewer stream:
	unhandled out of memory error
Date: Fri, 21 Nov 2014 18:49:08 +0100
Message-ID: <1416592148-12723-1-git-send-email-mathieu.desnoyers__1819.0790121027$1416592193$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1XrsKb-0008Ft-Ut
 for lttng-dev@lists.lttng.org; Fri, 21 Nov 2014 12:49:18 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-relayd/viewer-stream.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/bin/lttng-relayd/viewer-stream.c b/src/bin/lttng-relayd/viewer-stream.c
index 2f5d6f7..3748629 100644
--- a/src/bin/lttng-relayd/viewer-stream.c
+++ b/src/bin/lttng-relayd/viewer-stream.c
@@ -58,8 +58,16 @@ struct relay_viewer_stream *viewer_stream_create(struct relay_stream *stream,
 	vstream->session_id = stream->session_id;
 	vstream->stream_handle = stream->stream_handle;
 	vstream->path_name = strndup(stream->path_name, LTTNG_VIEWER_PATH_MAX);
+	if (vstream->path_name == NULL) {
+		PERROR("relay viewer path_name alloc");
+		goto error;
+	}
 	vstream->channel_name = strndup(stream->channel_name,
 			LTTNG_VIEWER_NAME_MAX);
+	if (vstream->channel_name == NULL) {
+		PERROR("relay viewer channel_name alloc");
+		goto error;
+	}
 	vstream->tracefile_count = stream->tracefile_count;
 	vstream->metadata_flag = stream->metadata_flag;
 	vstream->tracefile_count_last = -1ULL;
-- 
2.1.1
