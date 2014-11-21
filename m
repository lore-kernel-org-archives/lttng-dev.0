From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Cleanup: spaghetti function return
	path
Date: Fri, 21 Nov 2014 18:36:36 +0100
Message-ID: <1416591396-7750-1-git-send-email-mathieu.desnoyers__42525.9568765343$1416591460$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Xrs8U-00084J-Q6
 for lttng-dev@lists.lttng.org; Fri, 21 Nov 2014 12:36:47 -0500
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
 src/bin/lttng-relayd/live.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/src/bin/lttng-relayd/live.c b/src/bin/lttng-relayd/live.c
index 2940b2c..a76f530 100644
--- a/src/bin/lttng-relayd/live.c
+++ b/src/bin/lttng-relayd/live.c
@@ -804,14 +804,9 @@ int viewer_list_sessions(struct relay_connection *conn)
 	}
 	health_code_update();
 
-	rcu_read_unlock();
 	ret = 0;
-	goto end;
-
 end_unlock:
 	rcu_read_unlock();
-
-end:
 	return ret;
 }
 
-- 
2.1.1
