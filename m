From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: filter bytecode and string
	memory leak on error
Date: Thu, 13 Nov 2014 17:18:16 -0500
Message-ID: <1415917096-26182-1-git-send-email-mathieu.desnoyers__31782.0180360743$1415917144$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Xp2ih-00088o-40
 for lttng-dev@lists.lttng.org; Thu, 13 Nov 2014 17:18:28 -0500
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
 src/bin/lttng-sessiond/cmd.c       | 11 +++++++++++
 src/bin/lttng-sessiond/event.c     | 12 ++++++++++++
 src/bin/lttng-sessiond/kernel.c    |  1 +
 src/bin/lttng-sessiond/main.c      |  4 ++++
 src/bin/lttng-sessiond/trace-ust.c |  4 ++++
 5 files changed, 32 insertions(+)

diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
index c2b0248..2598029 100644
--- a/src/bin/lttng-sessiond/cmd.c
+++ b/src/bin/lttng-sessiond/cmd.c
@@ -1385,6 +1385,7 @@ end:
 
 /*
  * Command LTTNG_ENABLE_EVENT processed by the client thread.
+ * We own filter, exclusion, and filter_expression.
  */
 int cmd_enable_event(struct ltt_session *session, struct lttng_domain *domain,
 		char *channel_name, struct lttng_event *event,
@@ -1536,6 +1537,10 @@ int cmd_enable_event(struct ltt_session *session, struct lttng_domain *domain,
 		/* At this point, the session and channel exist on the tracer */
 		ret = event_ust_enable_tracepoint(usess, uchan, event,
 				filter_expression, filter, exclusion);
+		/* We have passed ownership */
+		filter_expression = NULL;
+		filter = NULL;
+		exclusion = NULL;
 		if (ret != LTTNG_OK) {
 			goto error;
 		}
@@ -1600,6 +1605,9 @@ int cmd_enable_event(struct ltt_session *session, struct lttng_domain *domain,
 
 		ret = cmd_enable_event(session, &tmp_dom, (char *) default_chan_name,
 			&uevent, filter_expression, filter, NULL, wpipe);
+		/* We have passed ownership */
+		filter_expression = NULL;
+		filter = NULL;
 		if (ret != LTTNG_OK && ret != LTTNG_ERR_UST_EVENT_ENABLED) {
 			goto error;
 		}
@@ -1629,6 +1637,9 @@ int cmd_enable_event(struct ltt_session *session, struct lttng_domain *domain,
 	ret = LTTNG_OK;
 
 error:
+	free(filter_expression);
+	free(filter);
+	free(exclusion);
 	rcu_read_unlock();
 	return ret;
 }
diff --git a/src/bin/lttng-sessiond/event.c b/src/bin/lttng-sessiond/event.c
index 181926b..5e9ca19 100644
--- a/src/bin/lttng-sessiond/event.c
+++ b/src/bin/lttng-sessiond/event.c
@@ -180,6 +180,7 @@ int event_kernel_disable_all(struct ltt_kernel_channel *kchan)
 
 /*
  * Enable kernel tracepoint event for a channel from the kernel session.
+ * We own filter_expression and filter.
  */
 int event_kernel_enable_tracepoint(struct ltt_kernel_channel *kchan,
 		struct lttng_event *event)
@@ -407,6 +408,7 @@ error:
 
 /*
  * Enable UST tracepoint event for a channel from a UST session.
+ * We own filter_expression, filter, and exclusion.
  */
 int event_ust_enable_tracepoint(struct ltt_ust_session *usess,
 		struct ltt_ust_channel *uchan, struct lttng_event *event,
@@ -428,6 +430,10 @@ int event_ust_enable_tracepoint(struct ltt_ust_session *usess,
 	if (uevent == NULL) {
 		uevent = trace_ust_create_event(event, filter_expression,
 			filter, exclusion);
+		/* We have passed ownership */
+		filter_expression = NULL;
+		filter = NULL;
+		exclusion = NULL;
 		if (uevent == NULL) {
 			ret = LTTNG_ERR_UST_ENABLE_FAIL;
 			goto error;
@@ -475,6 +481,9 @@ int event_ust_enable_tracepoint(struct ltt_ust_session *usess,
 
 end:
 	rcu_read_unlock();
+	free(filter_expression);
+	free(filter);
+	free(exclusion);
 	return ret;
 
 error:
@@ -490,6 +499,9 @@ error:
 		trace_ust_destroy_event(uevent);
 	}
 	rcu_read_unlock();
+	free(filter_expression);
+	free(filter);
+	free(exclusion);
 	return ret;
 }
 
diff --git a/src/bin/lttng-sessiond/kernel.c b/src/bin/lttng-sessiond/kernel.c
index 00bfbbc..a9151f4 100644
--- a/src/bin/lttng-sessiond/kernel.c
+++ b/src/bin/lttng-sessiond/kernel.c
@@ -173,6 +173,7 @@ error:
 /*
  * Create a kernel event, enable it to the kernel tracer and add it to the
  * channel event list of the kernel session.
+ * We own filter_expression and filter.
  */
 int kernel_create_event(struct lttng_event *ev,
 		struct ltt_kernel_channel *channel)
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 9542e65..cfe8c35 100644
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
diff --git a/src/bin/lttng-sessiond/trace-ust.c b/src/bin/lttng-sessiond/trace-ust.c
index 19a1c95..33ee071 100644
--- a/src/bin/lttng-sessiond/trace-ust.c
+++ b/src/bin/lttng-sessiond/trace-ust.c
@@ -365,6 +365,7 @@ error:
 
 /*
  * Allocate and initialize a ust event. Set name and event type.
+ * We own filter_expression, filter, and exclusion.
  *
  * Return pointer to structure or NULL.
  */
@@ -440,6 +441,9 @@ struct ltt_ust_event *trace_ust_create_event(struct lttng_event *ev,
 error_free_event:
 	free(lue);
 error:
+	free(filter_expression);
+	free(filter);
+	free(exclusion);
 	return NULL;
 }
 
-- 
2.1.1
