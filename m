From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: improve error message when UST
	support is	disabled
Date: Thu, 22 Aug 2013 17:48:59 -0400
Message-ID: <20130822214859.GA6700__47472.6625638597$1377208184$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VCckW-0000VS-Pf
	for lttng-dev@lists.lttng.org; Thu, 22 Aug 2013 17:49:05 -0400
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

Fixes #583

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/include/lttng/lttng-error.h b/include/lttng/lttng-error.h
index 51ef9ca..5e0dd07 100644
--- a/include/lttng/lttng-error.h
+++ b/include/lttng/lttng-error.h
@@ -114,7 +114,7 @@ enum lttng_error_code {
 	LTTNG_ERR_TRACE_ALREADY_STOPPED  = 81,  /* Tracing already stopped */
 	LTTNG_ERR_KERN_EVENT_ENOSYS      = 82,  /* Kernel event type not supported */
 	LTTNG_ERR_NEED_CHANNEL_NAME      = 83,	/* Non-default channel exists within session: channel name needs to be specified with '-c name' */
-	/* 84 */
+	LTTNG_ERR_NO_UST                 = 84,  /* LTTng-UST tracer is not supported. Please rebuild lttng-tools with lttng-ust support enabled. */
 	/* 85 */
 	/* 86 */
 	/* 87 */
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 69bc3a1..4ebd1e7 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -2710,6 +2710,10 @@ static int process_client_msg(struct command_ctx *cmd_ctx, int sock,
 		break;
 	case LTTNG_DOMAIN_UST:
 	{
+		if (!ust_app_supported()) {
+			ret = LTTNG_ERR_NO_UST;
+			goto error;
+		}
 		/* Consumer is in an ERROR state. Report back to client */
 		if (uatomic_read(&ust_consumerd_state) == CONSUMER_ERROR) {
 			ret = LTTNG_ERR_NO_USTCONSUMERD;
diff --git a/src/bin/lttng-sessiond/ust-app.h b/src/bin/lttng-sessiond/ust-app.h
index a08cfd2..fd5e93f 100644
--- a/src/bin/lttng-sessiond/ust-app.h
+++ b/src/bin/lttng-sessiond/ust-app.h
@@ -320,6 +320,12 @@ int ust_app_snapshot_record(struct ltt_ust_session *usess,
 		struct snapshot_output *output, int wait, unsigned int nb_streams);
 unsigned int ust_app_get_nb_stream(struct ltt_ust_session *usess);
 
+static inline
+int ust_app_supported(void)
+{
+	return 1;
+}
+
 #else /* HAVE_LIBLTTNG_UST_CTL */
 
 static inline
@@ -528,6 +534,12 @@ unsigned int ust_app_get_nb_stream(struct ltt_ust_session *usess)
 	return 0;
 }
 
+static inline
+int ust_app_supported(void)
+{
+	return 0;
+}
+
 #endif /* HAVE_LIBLTTNG_UST_CTL */
 
 #endif /* _LTT_UST_APP_H */
diff --git a/src/common/error.c b/src/common/error.c
index 7faba5a..911baea 100644
--- a/src/common/error.c
+++ b/src/common/error.c
@@ -83,6 +83,7 @@ static const char *error_string_array[] = {
 	[ ERROR_INDEX(LTTNG_ERR_UST_CONTEXT_EXIST)] = "UST context already exist",
 	[ ERROR_INDEX(LTTNG_ERR_UST_CONTEXT_INVAL)] = "UST invalid context",
 	[ ERROR_INDEX(LTTNG_ERR_NEED_ROOT_SESSIOND) ] = "Tracing the kernel requires a root lttng-sessiond daemon, as well as \"tracing\" group membership or root user ID for the lttng client.",
+	[ ERROR_INDEX(LTTNG_ERR_NO_UST) ] = "LTTng-UST tracer is not supported. Please rebuild lttng-tools with lttng-ust support enabled.",
 	[ ERROR_INDEX(LTTNG_ERR_TRACE_ALREADY_STARTED) ] = "Tracing already started",
 	[ ERROR_INDEX(LTTNG_ERR_TRACE_ALREADY_STOPPED) ] = "Tracing already stopped",
 	[ ERROR_INDEX(LTTNG_ERR_KERN_EVENT_ENOSYS) ] = "Kernel event type not supported",

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
