From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH] Contexts for RT debugging
Date: Wed, 11 Nov 2015 20:22:24 -0500
Message-ID: <1447291344-10709-1-git-send-email-jdesfossez__46707.0471765057$1447291443$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1Zwgav-00083V-Ih
 for lttng-dev@lists.lttng.org; Wed, 11 Nov 2015 20:22:34 -0500
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

Enables the interruptible, preemptible, need_resched and migratable
kernel contexts.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 include/lttng/event.h                  |  4 ++++
 src/bin/lttng-sessiond/context.c       | 12 ++++++++++++
 src/bin/lttng-sessiond/save.c          | 12 ++++++++++++
 src/bin/lttng/commands/add_context.c   |  8 ++++++++
 src/common/config/config-session-abi.h |  4 ++++
 src/common/config/session-config.c     | 16 ++++++++++++++++
 src/common/lttng-kernel.h              |  4 ++++
 7 files changed, 60 insertions(+)

diff --git a/include/lttng/event.h b/include/lttng/event.h
index 3e8fbe3..d79eb4b 100644
--- a/include/lttng/event.h
+++ b/include/lttng/event.h
@@ -136,6 +136,10 @@ enum lttng_event_context_type {
 	LTTNG_EVENT_CONTEXT_IP                = 12,
 	LTTNG_EVENT_CONTEXT_PERF_CPU_COUNTER  = 13,
 	LTTNG_EVENT_CONTEXT_PERF_THREAD_COUNTER = 14,
+	LTTNG_EVENT_CONTEXT_INTERRUPTIBLE     = 15,
+	LTTNG_EVENT_CONTEXT_PREEMPTIBLE       = 16,
+	LTTNG_EVENT_CONTEXT_NEED_RESCHED      = 17,
+	LTTNG_EVENT_CONTEXT_MIGRATABLE        = 18,
 };
 
 enum lttng_event_field_type {
diff --git a/src/bin/lttng-sessiond/context.c b/src/bin/lttng-sessiond/context.c
index 0de1d06..b01278c 100644
--- a/src/bin/lttng-sessiond/context.c
+++ b/src/bin/lttng-sessiond/context.c
@@ -193,6 +193,18 @@ int context_kernel_add(struct ltt_kernel_session *ksession,
 	case LTTNG_EVENT_CONTEXT_HOSTNAME:
 		kctx->ctx.ctx = LTTNG_KERNEL_CONTEXT_HOSTNAME;
 		break;
+	case LTTNG_EVENT_CONTEXT_INTERRUPTIBLE:
+		kctx->ctx.ctx = LTTNG_KERNEL_CONTEXT_INTERRUPTIBLE;
+		break;
+	case LTTNG_EVENT_CONTEXT_PREEMPTIBLE:
+		kctx->ctx.ctx = LTTNG_KERNEL_CONTEXT_PREEMPTIBLE;
+		break;
+	case LTTNG_EVENT_CONTEXT_NEED_RESCHED:
+		kctx->ctx.ctx = LTTNG_KERNEL_CONTEXT_NEED_RESCHED;
+		break;
+	case LTTNG_EVENT_CONTEXT_MIGRATABLE:
+		kctx->ctx.ctx = LTTNG_KERNEL_CONTEXT_MIGRATABLE;
+		break;
 	case LTTNG_EVENT_CONTEXT_PERF_CPU_COUNTER:
 	case LTTNG_EVENT_CONTEXT_PERF_COUNTER:
 		kctx->ctx.ctx = LTTNG_KERNEL_CONTEXT_PERF_CPU_COUNTER;
diff --git a/src/bin/lttng-sessiond/save.c b/src/bin/lttng-sessiond/save.c
index a6fea46..16b928e 100644
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
+	case LTTNG_KERNEL_CONTEXT_NEED_RESCHED:
+		context_type_string = config_event_context_need_resched;
+		break;
+	case LTTNG_KERNEL_CONTEXT_MIGRATABLE:
+		context_type_string = config_event_context_migratable;
+		break;
 	default:
 		context_type_string = NULL;
 	}
diff --git a/src/bin/lttng/commands/add_context.c b/src/bin/lttng/commands/add_context.c
index fb37c0a..8cbb5a4 100644
--- a/src/bin/lttng/commands/add_context.c
+++ b/src/bin/lttng/commands/add_context.c
@@ -69,6 +69,10 @@ enum context_type {
 	CONTEXT_IP           = 12,
 	CONTEXT_PERF_CPU_COUNTER = 13,
 	CONTEXT_PERF_THREAD_COUNTER = 14,
+	CONTEXT_INTERRUPTIBLE = 15,
+	CONTEXT_PREEMPTIBLE  = 16,
+	CONTEXT_NEED_RESCHED = 17,
+	CONTEXT_MIGRATABLE   = 18,
 };
 
 /*
@@ -213,6 +217,10 @@ const struct ctx_opts {
 	{ "vppid", CONTEXT_VPPID },
 	{ "hostname", CONTEXT_HOSTNAME },
 	{ "ip", CONTEXT_IP },
+	{ "interruptible", CONTEXT_INTERRUPTIBLE },
+	{ "preemptible", CONTEXT_PREEMPTIBLE },
+	{ "need_resched", CONTEXT_NEED_RESCHED },
+	{ "migratable", CONTEXT_MIGRATABLE },
 
 	/* Perf options */
 
diff --git a/src/common/config/config-session-abi.h b/src/common/config/config-session-abi.h
index 9251b22..f951e3c 100644
--- a/src/common/config/config-session-abi.h
+++ b/src/common/config/config-session-abi.h
@@ -116,5 +116,9 @@ extern const char * const config_event_context_pthread_id;
 extern const char * const config_event_context_hostname;
 extern const char * const config_event_context_ip;
 extern const char * const config_event_context_perf_thread_counter;
+extern const char * const config_event_context_interruptible;
+extern const char * const config_event_context_preemptible;
+extern const char * const config_event_context_need_resched;
+extern const char * const config_event_context_migratable;
 
 #endif /* CONFIG_SESSION_INTERNAL_H */
diff --git a/src/common/config/session-config.c b/src/common/config/session-config.c
index 87e9c03..c87cdc2 100644
--- a/src/common/config/session-config.c
+++ b/src/common/config/session-config.c
@@ -165,6 +165,10 @@ const char * const config_event_context_pthread_id = "PTHREAD_ID";
 const char * const config_event_context_hostname = "HOSTNAME";
 const char * const config_event_context_ip = "IP";
 const char * const config_event_context_perf_thread_counter = "PERF_THREAD_COUNTER";
+const char * const config_event_context_interruptible = "INTERRUPTIBLE";
+const char * const config_event_context_preemptible = "PREEMPTIBLE";
+const char * const config_event_context_need_resched = "NEED_RESCHED";
+const char * const config_event_context_migratable = "MIGRATABLE";
 
 struct consumer_output {
 	int enabled;
@@ -946,6 +950,18 @@ int get_context_type(xmlChar *context_type)
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
+		config_event_context_need_resched)) {
+		ret = LTTNG_EVENT_CONTEXT_NEED_RESCHED;
+	} else if (!strcmp((char *) context_type,
+		config_event_context_migratable)) {
+		ret = LTTNG_EVENT_CONTEXT_MIGRATABLE;
 	} else {
 		goto error;
 	}
diff --git a/src/common/lttng-kernel.h b/src/common/lttng-kernel.h
index 9dd8df7..cce094c 100644
--- a/src/common/lttng-kernel.h
+++ b/src/common/lttng-kernel.h
@@ -54,6 +54,10 @@ enum lttng_kernel_context_type {
 	LTTNG_KERNEL_CONTEXT_VPPID          = 9,
 	LTTNG_KERNEL_CONTEXT_HOSTNAME       = 10,
 	LTTNG_KERNEL_CONTEXT_CPU_ID         = 11,
+	LTTNG_KERNEL_CONTEXT_INTERRUPTIBLE  = 12,
+	LTTNG_KERNEL_CONTEXT_PREEMPTIBLE    = 13,
+	LTTNG_KERNEL_CONTEXT_NEED_RESCHED   = 14,
+	LTTNG_KERNEL_CONTEXT_MIGRATABLE     = 15,
 };
 
 /* Perf counter attributes */
-- 
1.9.1
