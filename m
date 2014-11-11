From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: filter bytecode and string
	memory leak on error
Date: Tue, 11 Nov 2014 16:34:30 -0500
Message-ID: <1415741670-20395-1-git-send-email-mathieu.desnoyers__31148.0470154949$1415741739$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1XoJ5G-0001D4-Tg
 for lttng-dev@lists.lttng.org; Tue, 11 Nov 2014 16:34:47 -0500
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
 src/bin/lttng-sessiond/main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 9542e65..50da40c 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -3217,12 +3217,14 @@ skip_domain:
 
 			if (bytecode_len > LTTNG_FILTER_MAX_LEN) {
 				ret = LTTNG_ERR_FILTER_INVAL;
+				free(filter_expression);
 				free(exclusion);
 				goto error;
 			}
 
 			bytecode = zmalloc(bytecode_len);
 			if (!bytecode) {
+				free(filter_expression);
 				free(exclusion);
 				ret = LTTNG_ERR_FILTER_NOMEM;
 				goto error;
@@ -3234,6 +3236,7 @@ skip_domain:
 			if (ret <= 0) {
 				DBG("Nothing recv() from client car len data... continuing");
 				*sock_error = 1;
+				free(filter_expression);
 				free(bytecode);
 				free(exclusion);
 				ret = LTTNG_ERR_FILTER_INVAL;
@@ -3241,6 +3244,7 @@ skip_domain:
 			}
 
 			if ((bytecode->len + sizeof(*bytecode)) != bytecode_len) {
+				free(filter_expression);
 				free(bytecode);
 				free(exclusion);
 				ret = LTTNG_ERR_FILTER_INVAL;
@@ -3253,6 +3257,12 @@ skip_domain:
 				&cmd_ctx->lsm->u.enable.event,
 				filter_expression, bytecode, exclusion,
 				kernel_poll_pipe[1]);
+		if (ret != LTTNG_OK) {
+			/* On error, we still have ownership. */
+			free(filter_expression);
+			free(bytecode);
+			free(exclusion);
+		}
 		break;
 	}
 	case LTTNG_LIST_TRACEPOINTS:
-- 
2.1.1
