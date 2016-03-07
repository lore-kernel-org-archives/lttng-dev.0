From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [PATCH lttng-tools v3] Contexts for RT debugging
Date: Mon,  7 Mar 2016 15:20:25 -0500
Message-ID: <1457382025-10149-1-git-send-email-jdesfossez__29707.0037144751$1457382129$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ad1dt-00017v-W2
 for lttng-dev@lists.lttng.org; Mon, 07 Mar 2016 15:20:45 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Enables the interruptible, preemptible, need_reschedule and migratable
kernel contexts.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 include/lttng/event.h                  |  4 ++++
 include/lttng/lttng-error.h            |  1 +
 src/bin/lttng-sessiond/context.c       | 18 ++++++++++++++----
 src/bin/lttng-sessiond/kernel.c        | 17 ++++++++++++-----
 src/bin/lttng-sessiond/save.c          | 12 ++++++++++++
 src/bin/lttng/commands/add_context.c   |  8 ++++++++
 src/common/config/config-session-abi.h |  4 ++++
 src/common/config/session-config.c     | 17 ++++++++++++++++-
 src/common/error.c                     |  1 +
 src/common/lttng-kernel.h              |  4 ++++
 10 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/include/lttng/event.h b/include/lttng/event.h
index bf37a11..492786c 100644
--- a/include/lttng/event.h
+++ b/include/lttng/event.h
@@ -138,6 +138,10 @@ enum lttng_event_context_type {
 	LTTNG_EVENT_CONTEXT_PERF_CPU_COUNTER	= 13,
 	LTTNG_EVENT_CONTEXT_PERF_THREAD_COUNTER = 14,
 	LTTNG_EVENT_CONTEXT_APP_CONTEXT		= 15,
+	LTTNG_EVENT_CONTEXT_INTERRUPTIBLE	= 16,
+	LTTNG_EVENT_CONTEXT_PREEMPTIBLE		= 17,
+	LTTNG_EVENT_CONTEXT_NEED_RESCHEDULE	= 18,
+	LTTNG_EVENT_CONTEXT_MIGRATABLE		= 19,
 };
 
 enum lttng_event_field_type {
diff --git a/include/lttng/lttng-error.h b/include/lttng/lttng-error.h
index 1030bdf..35b5ca2 100644
--- a/include/lttng/lttng-error.h
+++ b/include/lttng/lttng-error.h
@@ -138,6 +138,7 @@ enum lttng_error_code {
 	LTTNG_ERR_PID_NOT_TRACKED        = 115, /* PID not tracked */
 	LTTNG_ERR_INVALID_CHANNEL_DOMAIN = 116, /* Invalid channel domain */
 	LTTNG_ERR_OVERFLOW		 = 117, /* Overflow occured. */
+	LTTNG_ERR_KERN_CONTEXT_UNAVAIL   = 118,  /* Context unavailable on this kernel */
 
 	/* MUST be last element */
 	LTTNG_ERR_NR,                           /* Last element */
diff --git a/src/bin/lttng-sessiond/context.c b/src/bin/lttng-sessiond/context.c
index 9a57387..9c3a394 100644
--- a/src/bin/lttng-sessiond/context.c
+++ b/src/bin/lttng-sessiond/context.c
@@ -49,8 +49,7 @@ static int add_kctx_all_channels(struct ltt_kernel_session *ksession,
 	/* Go over all channels */
 	cds_list_for_each_entry(kchan, &ksession->channel_list.head, list) {
 		ret = kernel_add_channel_context(kchan, kctx);
-		if (ret < 0) {
-			ret = LTTNG_ERR_KERN_CONTEXT_FAIL;
+		if (ret != 0) {
 			goto error;
 		}
 	}
@@ -75,8 +74,7 @@ static int add_kctx_to_channel(struct ltt_kernel_context *kctx,
 	DBG("Add kernel context to channel '%s'", kchan->channel->name);
 
 	ret = kernel_add_channel_context(kchan, kctx);
-	if (ret < 0) {
-		ret = LTTNG_ERR_KERN_CONTEXT_FAIL;
+	if (ret != 0) {
 		goto error;
 	}
 
@@ -231,6 +229,18 @@ int context_kernel_add(struct ltt_kernel_session *ksession,
 	case LTTNG_EVENT_CONTEXT_PERF_COUNTER:
 		kctx->ctx.ctx = LTTNG_KERNEL_CONTEXT_PERF_CPU_COUNTER;
 		break;
+	case LTTNG_EVENT_CONTEXT_INTERRUPTIBLE:
+		kctx->ctx.ctx = LTTNG_KERNEL_CONTEXT_INTERRUPTIBLE;
+		break;
+	case LTTNG_EVENT_CONTEXT_PREEMPTIBLE:
+		kctx->ctx.ctx = LTTNG_KERNEL_CONTEXT_PREEMPTIBLE;
+		break;
+	case LTTNG_EVENT_CONTEXT_NEED_RESCHEDULE:
+		kctx->ctx.ctx = LTTNG_KERNEL_CONTEXT_NEED_RESCHEDULE;
+		break;
+	case LTTNG_EVENT_CONTEXT_MIGRATABLE:
+		kctx->ctx.ctx = LTTNG_KERNEL_CONTEXT_MIGRATABLE;
+		break;
 	default:
 		ret = LTTNG_ERR_KERN_CONTEXT_FAIL;
 		goto error;
diff --git a/src/bin/lttng-sessiond/kernel.c b/src/bin/lttng-sessiond/kernel.c
index 2cad0b2..5bcf487 100644
--- a/src/bin/lttng-sessiond/kernel.c
+++ b/src/bin/lttng-sessiond/kernel.c
@@ -49,17 +49,24 @@ int kernel_add_channel_context(struct ltt_kernel_channel *chan,
 	DBG("Adding context to channel %s", chan->channel->name);
 	ret = kernctl_add_context(chan->fd, &ctx->ctx);
 	if (ret < 0) {
-		if (errno != EEXIST) {
-			PERROR("add context ioctl");
-		} else {
+		switch (errno) {
+		case ENOSYS:
+			/* Exists but not available for this kernel */
+			ret = LTTNG_ERR_KERN_CONTEXT_UNAVAIL;
+			goto error;
+		case EEXIST:
 			/* If EEXIST, we just ignore the error */
 			ret = 0;
+			goto end;
+		default:
+			PERROR("add context ioctl");
+			ret = LTTNG_ERR_KERN_CONTEXT_FAIL;
+			goto error;
 		}
-		goto error;
 	}
 
+end:
 	cds_list_add_tail(&ctx->list, &chan->ctx_list);
-
 	return 0;
 
 error:
diff --git a/src/bin/lttng-sessiond/save.c b/src/bin/lttng-sessiond/save.c
index b332878..4db2cfb 100644
--- a/src/bin/lttng-sessiond/save.c
+++ b/src/bin/lttng-sessiond/save.c
@@ -232,6 +232,18 @@ const char *get_kernel_context_type_string(
 	case LTTNG_KERNEL_CONTEXT_HOSTNAME:
 		context_type_string = config_event_context_hostname;
 		break;
+	case LTTNG_KERNEL_CONTEXT_INTERRUPTIBLE:
+		context_type_string = config_event_context_interruptible;
+		break;
+	case LTTNG_KERNEL_CONTEXT_PREEMPTIBLE:
+		context_type_string = config_event_context_preemptible;
+		break;
+	case LTTNG_KERNEL_CONTEXT_NEED_RESCHEDULE:
+		context_type_string = config_event_context_need_reschedule;
+		break;
+	case LTTNG_KERNEL_CONTEXT_MIGRATABLE:
+		context_type_string = config_event_context_migratable;
+		break;
 	default:
 		context_type_string = NULL;
 	}
diff --git a/src/bin/lttng/commands/add_context.c b/src/bin/lttng/commands/add_context.c
index a802df0..a6d73a0 100644
--- a/src/bin/lttng/commands/add_context.c
+++ b/src/bin/lttng/commands/add_context.c
@@ -75,6 +75,10 @@ enum context_type {
 	CONTEXT_PERF_CPU_COUNTER = 13,
 	CONTEXT_PERF_THREAD_COUNTER = 14,
 	CONTEXT_APP_CONTEXT  = 15,
+	CONTEXT_INTERRUPTIBLE = 16,
+	CONTEXT_PREEMPTIBLE  = 17,
+	CONTEXT_NEED_RESCHEDULE = 18,
+	CONTEXT_MIGRATABLE   = 19,
 };
 
 /*
@@ -225,6 +229,10 @@ const struct ctx_opts {
 	{ "vppid", CONTEXT_VPPID },
 	{ "hostname", CONTEXT_HOSTNAME },
 	{ "ip", CONTEXT_IP },
+	{ "interruptible", CONTEXT_INTERRUPTIBLE },
+	{ "preemptible", CONTEXT_PREEMPTIBLE },
+	{ "need_reschedule", CONTEXT_NEED_RESCHEDULE },
+	{ "migratable", CONTEXT_MIGRATABLE },
 
 	/* Perf options */
 
diff --git a/src/common/config/config-session-abi.h b/src/common/config/config-session-abi.h
index f7cee34..17acea1 100644
--- a/src/common/config/config-session-abi.h
+++ b/src/common/config/config-session-abi.h
@@ -121,5 +121,9 @@ extern const char * const config_event_context_hostname;
 extern const char * const config_event_context_ip;
 extern const char * const config_event_context_perf_thread_counter;
 extern const char * const config_event_context_app;
+extern const char * const config_event_context_interruptible;
+extern const char * const config_event_context_preemptible;
+extern const char * const config_event_context_need_reschedule;
+extern const char * const config_event_context_migratable;
 
 #endif /* CONFIG_SESSION_INTERNAL_H */
diff --git a/src/common/config/session-config.c b/src/common/config/session-config.c
index dec8913..647d16a 100644
--- a/src/common/config/session-config.c
+++ b/src/common/config/session-config.c
@@ -170,7 +170,10 @@ const char * const config_event_context_hostname = "HOSTNAME";
 const char * const config_event_context_ip = "IP";
 const char * const config_event_context_perf_thread_counter = "PERF_THREAD_COUNTER";
 const char * const config_event_context_app = "APP";
-
+const char * const config_event_context_interruptible = "INTERRUPTIBLE";
+const char * const config_event_context_preemptible = "PREEMPTIBLE";
+const char * const config_event_context_need_reschedule = "NEED_RESCHEDULE";
+const char * const config_event_context_migratable = "MIGRATABLE";
 
 struct consumer_output {
 	int enabled;
@@ -985,6 +988,18 @@ int get_context_type(xmlChar *context_type)
 	} else if (!strcmp((char *) context_type,
 		config_event_context_ip)) {
 		ret = LTTNG_EVENT_CONTEXT_IP;
+	} else if (!strcmp((char *) context_type,
+		config_event_context_interruptible)) {
+		ret = LTTNG_EVENT_CONTEXT_INTERRUPTIBLE;
+	} else if (!strcmp((char *) context_type,
+		config_event_context_preemptible)) {
+		ret = LTTNG_EVENT_CONTEXT_PREEMPTIBLE;
+	} else if (!strcmp((char *) context_type,
+		config_event_context_need_reschedule)) {
+		ret = LTTNG_EVENT_CONTEXT_NEED_RESCHEDULE;
+	} else if (!strcmp((char *) context_type,
+		config_event_context_migratable)) {
+		ret = LTTNG_EVENT_CONTEXT_MIGRATABLE;
 	} else {
 		goto error;
 	}
diff --git a/src/common/error.c b/src/common/error.c
index c3fde51..d1c329c 100644
--- a/src/common/error.c
+++ b/src/common/error.c
@@ -170,6 +170,7 @@ static const char *error_string_array[] = {
 	[ ERROR_INDEX(LTTNG_ERR_PID_NOT_TRACKED) ] = "PID not tracked",
 	[ ERROR_INDEX(LTTNG_ERR_INVALID_CHANNEL_DOMAIN) ] = "Invalid channel domain",
 	[ ERROR_INDEX(LTTNG_ERR_OVERFLOW) ] = "Overflow occured",
+	[ ERROR_INDEX(LTTNG_ERR_KERN_CONTEXT_UNAVAIL) ] = "Context unavailable on this kernel",
 
 	/* Last element */
 	[ ERROR_INDEX(LTTNG_ERR_NR) ] = "Unknown error code"
diff --git a/src/common/lttng-kernel.h b/src/common/lttng-kernel.h
index 9dd8df7..78d5fc4 100644
--- a/src/common/lttng-kernel.h
+++ b/src/common/lttng-kernel.h
@@ -54,6 +54,10 @@ enum lttng_kernel_context_type {
 	LTTNG_KERNEL_CONTEXT_VPPID          = 9,
 	LTTNG_KERNEL_CONTEXT_HOSTNAME       = 10,
 	LTTNG_KERNEL_CONTEXT_CPU_ID         = 11,
+	LTTNG_KERNEL_CONTEXT_INTERRUPTIBLE  = 12,
+	LTTNG_KERNEL_CONTEXT_PREEMPTIBLE    = 13,
+	LTTNG_KERNEL_CONTEXT_NEED_RESCHEDULE = 14,
+	LTTNG_KERNEL_CONTEXT_MIGRATABLE     = 15,
 };
 
 /* Perf counter attributes */
-- 
1.9.1
