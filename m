From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: put viewer stream on send error
Date: Fri,  4 Sep 2015 12:03:36 -0400
Message-ID: <1441382616-20398-1-git-send-email-mathieu.desnoyers__21298.2300705791$1441382709$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZXtSs-0003Za-Nt
 for lttng-dev@lists.lttng.org; Fri, 04 Sep 2015 12:03:50 -0400
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
 src/bin/lttng-relayd/live.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/bin/lttng-relayd/live.c b/src/bin/lttng-relayd/live.c
index bcc4045..a1fbbbe 100644
--- a/src/bin/lttng-relayd/live.c
+++ b/src/bin/lttng-relayd/live.c
@@ -243,10 +243,10 @@ ssize_t send_viewer_streams(struct lttcomm_sock *sock,
 		pthread_mutex_unlock(&vstream->stream->lock);
 
 		ret = send_response(sock, &send_stream, sizeof(send_stream));
+		viewer_stream_put(vstream);
 		if (ret < 0) {
 			goto end_unlock;
 		}
-		viewer_stream_put(vstream);
 	}
 
 	ret = 0;
-- 
2.1.4
