From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2/3] Fix: relay:
	viewer_get_next_index handle null vstream
Date: Thu,  3 Sep 2015 17:17:29 -0400
Message-ID: <1441315050-17271-2-git-send-email-mathieu.desnoyers__19934.7454858527$1441315143$gmane$org@efficios.com>
References: <1441315050-17271-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZXbt9-00065D-Ay
 for lttng-dev@lists.lttng.org; Thu, 03 Sep 2015 17:17:51 -0400
In-Reply-To: <1441315050-17271-1-git-send-email-mathieu.desnoyers@efficios.com>
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
 src/bin/lttng-relayd/live.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/bin/lttng-relayd/live.c b/src/bin/lttng-relayd/live.c
index 2d0b687..eb57421 100644
--- a/src/bin/lttng-relayd/live.c
+++ b/src/bin/lttng-relayd/live.c
@@ -1454,9 +1454,11 @@ send_reply:
 	}
 	health_code_update();
 
-	DBG("Index %" PRIu64 " for stream %" PRIu64 " sent",
-			vstream->last_sent_index,
-			vstream->stream->stream_handle);
+	if (vstream) {
+		DBG("Index %" PRIu64 " for stream %" PRIu64 " sent",
+				vstream->last_sent_index,
+				vstream->stream->stream_handle);
+	}
 end:
 	if (metadata_viewer_stream) {
 		viewer_stream_put(metadata_viewer_stream);
-- 
2.1.4
