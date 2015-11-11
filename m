From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH 2/2] irqsoff and preemptoff kernel
	contexts support
Date: Tue, 10 Nov 2015 21:21:15 -0500
Message-ID: <1447208475-24578-2-git-send-email-jdesfossez__44744.5906037048$1447208552$gmane$org@efficios.com>
References: <1447208475-24578-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1ZwL2O-0000ul-JN
 for lttng-dev@lists.lttng.org; Tue, 10 Nov 2015 21:21:29 -0500
In-Reply-To: <1447208475-24578-1-git-send-email-jdesfossez@efficios.com>
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

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 include/lttng/event.h                  | 2 ++
 src/bin/lttng-sessiond/context.c       | 6 ++++++
 src/bin/lttng-sessiond/save.c          | 6 ++++++
 src/bin/lttng/commands/add_context.c   | 4 ++++
 src/common/config/config-session-abi.h | 2 ++
 src/common/config/session-config.c     | 8 ++++++++
 src/common/lttng-kernel.h              | 2 ++
 7 files changed, 30 insertions(+)

diff --git a/include/lttng/event.h b/include/lttng/event.h
index 3e8fbe3..e8b8d64 100644
--- a/include/lttng/event.h
+++ b/include/lttng/event.h
@@ -136,6 +136,8 @@ enum lttng_event_context_type {
 	LTTNG_EVENT_CONTEXT_IP                = 12,
 	LTTNG_EVENT_CONTEXT_PERF_CPU_COUNTER  = 13,
 	LTTNG_EVENT_CONTEXT_PERF_THREAD_COUNTER = 14,
+	LTTNG_EVENT_CONTEXT_IRQSOFF           = 15,
+	LTTNG_EVENT_CONTEXT_PREEMPTOFF        = 16,
 };
 
 enum lttng_event_field_type {
diff --git a/src/bin/lttng-sessiond/context.c b/src/bin/lttng-sessiond/context.c
index 0de1d06..799009a 100644
--- a/src/bin/lttng-sessiond/context.c
+++ b/src/bin/lttng-sessiond/context.c
@@ -193,6 +193,12 @@ int context_kernel_add(struct ltt_kernel_session *ksession,
 	case LTTNG_EVENT_CONTEXT_HOSTNAME:
 		kctx->ctx.ctx = LTTNG_KERNEL_CONTEXT_HOSTNAME;
 		break;
+	case LTTNG_EVENT_CONTEXT_IRQSOFF:
+		kctx->ctx.ctx = LTTNG_KERNEL_CONTEXT_IRQSOFF;
+		break;
+	case LTTNG_EVENT_CONTEXT_PREEMPTOFF:
+		kctx->ctx.ctx = LTTNG_KERNEL_CONTEXT_PREEMPTOFF;
+		break;
 	case LTTNG_EVENT_CONTEXT_PERF_CPU_COUNTER:
 	case LTTNG_EVENT_CONTEXT_PERF_COUNTER:
 		kctx->ctx.ctx = LTTNG_KERNEL_CONTEXT_PERF_CPU_COUNTER;
diff --git a/src/bin/lttng-sessiond/save.c b/src/bin/lttng-sessiond/save.c
index a6fea46..74c055f 100644
--- a/src/bin/lttng-sessiond/save.c
+++ b/src/bin/lttng-sessiond/save.c
@@ -232,6 +232,12 @@ const char *get_kernel_context_type_string(
 	case LTTNG_KERNEL_CONTEXT_HOSTNAME:
 		context_type_string = config_event_context_hostname;
 		break;
+	case LTTNG_KERNEL_CONTEXT_IRQSOFF:
+		context_type_string = config_event_context_irqsoff;
+		break;
+	case LTTNG_KERNEL_CONTEXT_PREEMPTOFF:
+		context_type_string = config_event_context_preemptoff;
+		break;
 	default:
 		context_type_string = NULL;
 	}
diff --git a/src/bin/lttng/commands/add_context.c b/src/bin/lttng/commands/add_context.c
index fb37c0a..81a73e4 100644
--- a/src/bin/lttng/commands/add_context.c
+++ b/src/bin/lttng/commands/add_context.c
@@ -69,6 +69,8 @@ enum context_type {
 	CONTEXT_IP           = 12,
 	CONTEXT_PERF_CPU_COUNTER = 13,
 	CONTEXT_PERF_THREAD_COUNTER = 14,
+	CONTEXT_IRQSOFF      = 15,
+	CONTEXT_PREEMPTOFF   = 16,
 };
 
 /*
@@ -213,6 +215,8 @@ const struct ctx_opts {
 	{ "vppid", CONTEXT_VPPID },
 	{ "hostname", CONTEXT_HOSTNAME },
 	{ "ip", CONTEXT_IP },
+	{ "irqsoff", CONTEXT_IRQSOFF },
+	{ "preemptoff", CONTEXT_PREEMPTOFF },
 
 	/* Perf options */
 
diff --git a/src/common/config/config-session-abi.h b/src/common/config/config-session-abi.h
index 9251b22..156346d 100644
--- a/src/common/config/config-session-abi.h
+++ b/src/common/config/config-session-abi.h
@@ -116,5 +116,7 @@ extern const char * const config_event_context_pthread_id;
 extern const char * const config_event_context_hostname;
 extern const char * const config_event_context_ip;
 extern const char * const config_event_context_perf_thread_counter;
+extern const char * const config_event_context_irqsoff;
+extern const char * const config_event_context_preemptoff;
 
 #endif /* CONFIG_SESSION_INTERNAL_H */
diff --git a/src/common/config/session-config.c b/src/common/config/session-config.c
index 87e9c03..3945139 100644
--- a/src/common/config/session-config.c
+++ b/src/common/config/session-config.c
@@ -165,6 +165,8 @@ const char * const config_event_context_pthread_id = "PTHREAD_ID";
 const char * const config_event_context_hostname = "HOSTNAME";
 const char * const config_event_context_ip = "IP";
 const char * const config_event_context_perf_thread_counter = "PERF_THREAD_COUNTER";
+const char * const config_event_context_irqsoff = "IRQSOFF";
+const char * const config_event_context_preemptoff = "PREEMPTOFF";
 
 struct consumer_output {
 	int enabled;
@@ -946,6 +948,12 @@ int get_context_type(xmlChar *context_type)
 	} else if (!strcmp((char *) context_type,
 		config_event_context_ip)) {
 		ret = LTTNG_EVENT_CONTEXT_IP;
+	} else if (!strcmp((char *) context_type,
+		config_event_context_irqsoff)) {
+		ret = LTTNG_EVENT_CONTEXT_IRQSOFF;
+	} else if (!strcmp((char *) context_type,
+		config_event_context_preemptoff)) {
+		ret = LTTNG_EVENT_CONTEXT_PREEMPTOFF;
 	} else {
 		goto error;
 	}
diff --git a/src/common/lttng-kernel.h b/src/common/lttng-kernel.h
index f58108f..55cb6f2 100644
--- a/src/common/lttng-kernel.h
+++ b/src/common/lttng-kernel.h
@@ -54,6 +54,8 @@ enum lttng_kernel_context_type {
 	LTTNG_KERNEL_CONTEXT_VPPID          = 9,
 	LTTNG_KERNEL_CONTEXT_HOSTNAME       = 10,
 	LTTNG_KERNEL_CONTEXT_CPUID          = 11,
+	LTTNG_KERNEL_CONTEXT_IRQSOFF        = 12,
+	LTTNG_KERNEL_CONTEXT_PREEMPTOFF     = 13,
 };
 
 /* Perf counter attributes */
-- 
1.9.1
