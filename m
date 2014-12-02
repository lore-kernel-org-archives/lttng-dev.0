From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2/4] Fix: print format type mismatch
Date: Tue,  2 Dec 2014 17:21:10 -0500
Message-ID: <1417558872-25339-2-git-send-email-mathieu.desnoyers__14540.2613714852$1417558939$gmane$org@efficios.com>
References: <1417558872-25339-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Xvvp1-0005ML-T8
 for lttng-dev@lists.lttng.org; Tue, 02 Dec 2014 17:21:28 -0500
In-Reply-To: <1417558872-25339-1-git-send-email-mathieu.desnoyers@efficios.com>
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
 src/bin/lttng-relayd/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index 27a428a..4be065f 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -2321,7 +2321,7 @@ int relay_process_data(struct relay_connection *conn)
 				pthread_mutex_lock(&vstream->overwrite_lock);
 				vstream->abort_flag = 1;
 				pthread_mutex_unlock(&vstream->overwrite_lock);
-				DBG("Streaming side setting abort_flag on stream %s_%lu\n",
+				DBG("Streaming side setting abort_flag on stream %s_%" PRIu64 "\n",
 						stream->channel_name, new_id);
 			} else if (vstream->tracefile_count_current ==
 					stream->tracefile_count_current) {
-- 
2.1.1
