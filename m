From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/2] Add rcu_read_ongoing()
	assertions around process_client_msg
Date: Mon,  7 Sep 2015 10:36:08 -0400
Message-ID: <1441636569-3488-1-git-send-email-mathieu.desnoyers__10872.7581719451$1441636629$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZYxWu-0008Tl-VS
 for lttng-dev@lists.lttng.org; Mon, 07 Sep 2015 10:36:22 -0400
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

process_client_msg ensures that RCU read-side lock should not be held
when calling it. Validate this using rcu_read_ongoing() at the entry and
exit points of this function. This allows us to catch unbalanced RCU
read-side lock within commands quickly.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 7c48e4d..0e7de6e 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -2972,6 +2972,8 @@ static int process_client_msg(struct command_ctx *cmd_ctx, int sock,
 
 	DBG("Processing client command %d", cmd_ctx->lsm->cmd_type);
 
+	assert(!rcu_read_ongoing());
+
 	*sock_error = 0;
 
 	switch (cmd_ctx->lsm->cmd_type) {
@@ -4059,6 +4061,7 @@ setup_error:
 		session_unlock_list();
 	}
 init_setup_error:
+	assert(!rcu_read_ongoing());
 	return ret;
 }
 
-- 
2.1.4
