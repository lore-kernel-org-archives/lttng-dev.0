From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: relayd: unbalanced RCU
	read-side lock/unlock
Date: Fri, 21 Nov 2014 18:38:37 +0100
Message-ID: <1416591517-7953-1-git-send-email-mathieu.desnoyers__48953.6764719107$1416591562$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1XrsAQ-00086g-VP
 for lttng-dev@lists.lttng.org; Fri, 21 Nov 2014 12:38:47 -0500
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
index a76f530..93d458b 100644
--- a/src/bin/lttng-relayd/live.c
+++ b/src/bin/lttng-relayd/live.c
@@ -1318,7 +1318,7 @@ int viewer_get_next_index(struct relay_connection *conn)
 	ret = check_index_status(vstream, rstream, ctf_trace, &viewer_index);
 	pthread_mutex_unlock(&rstream->viewer_stream_rotation_lock);
 	if (ret < 0) {
-		goto end;
+		goto end_unlock;
 	} else if (ret == 1) {
 		/*
 		 * This means the viewer index data structure has been populated by the
-- 
2.1.1
