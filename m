From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Clarify empty string/NULL filter
	errors
Date: Mon, 26 Nov 2012 15:58:08 -0500
Message-ID: <20121126205808.GA32010__11015.5409820893$1353963640$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Td5kn-0008I2-Jd
	for lttng-dev@lists.lttng.org; Mon, 26 Nov 2012 15:58:09 -0500
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Reported-by: Jesus Garcia <jesus.garcia@ericsson.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/include/lttng/lttng.h b/include/lttng/lttng.h
index c6fc605..515e07c 100644
--- a/include/lttng/lttng.h
+++ b/include/lttng/lttng.h
@@ -516,6 +516,8 @@ extern int lttng_enable_event(struct lttng_handle *handle,
  * If event_name is NULL, all events are enabled with that filter.
  * If channel_name is NULL, the default channel is used (channel0) and created
  * if not found.
+ * If filter_expression is NULL, an event without associated filter is
+ * created.
  */
 extern int lttng_enable_event_with_filter(struct lttng_handle *handle,
 		struct lttng_event *event, const char *channel_name,
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index df47606..d5cfc0e 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -2853,6 +2853,10 @@ skip_domain:
 			ret = LTTNG_ERR_FILTER_INVAL;
 			goto error;
 		}
+		if (cmd_ctx->lsm->u.enable.bytecode_len == 0) {
+			ret = LTTNG_ERR_FILTER_INVAL;
+			goto error;
+		}
 		bytecode = zmalloc(cmd_ctx->lsm->u.enable.bytecode_len);
 		if (!bytecode) {
 			ret = LTTNG_ERR_FILTER_NOMEM;
diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
index 6238d9a..96351bd 100644
--- a/src/lib/lttng-ctl/lttng-ctl.c
+++ b/src/lib/lttng-ctl/lttng-ctl.c
@@ -841,8 +841,20 @@ int lttng_enable_event_with_filter(struct lttng_handle *handle,
 	FILE *fmem;
 	int ret = 0;
 
-	/* Safety check. */
-	if (handle == NULL || !filter_expression) {
+	if (!filter_expression) {
+		/*
+		 * Fall back to normal event enabling if no filter
+		 * specified.
+		 */
+		return lttng_enable_event(handle, event, channel_name);
+	}
+
+	/*
+	 * Empty filter string will always be rejected by the parser
+	 * anyway, so treat this corner-case early to eliminate
+	 * lttng_fmemopen error for 0-byte allocation.
+	 */
+	if (handle == NULL || filter_expression[0] == '\0') {
 		return -LTTNG_ERR_INVALID;
 	}
 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
