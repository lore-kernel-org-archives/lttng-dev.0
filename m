From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: unbalanced
	ustconsumer32_data.pid_mutex lock
Date: Sun, 27 Jul 2014 20:38:50 -0400
Message-ID: <1406507930-620-1-git-send-email-mathieu.desnoyers__35719.046512577$1406508013$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1XBYy5-0007Hx-OJ
 for lttng-dev@lists.lttng.org; Sun, 27 Jul 2014 20:39:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 809C8340195
 for <lttng-dev@lists.lttng.org>; Mon, 28 Jul 2014 00:39:13 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

It is never locked in this function, but should be. This is triggering
spurious runtime failures on my system, where it seems that sessiond was
sometimes breaking the communication pipe with liblttng-ctl when the
unbalanced unlock is reached.

This should be backported to stable-2.4 and stable-2.5.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index a8751c6..1ee6f4a 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -3016,6 +3016,7 @@ static int process_client_msg(struct command_ctx *cmd_ctx, int sock,
 			}
 
 			/* 32-bit */
+			pthread_mutex_lock(&ustconsumer32_data.pid_mutex);
 			if (consumerd32_bin[0] != '\0' &&
 					ustconsumer32_data.pid == 0 &&
 					cmd_ctx->lsm->cmd_type != LTTNG_REGISTER_CONSUMER) {
-- 
2.0.1
