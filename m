From: Christophe Bedard <bedard.christophe@gmail.com>
Subject: [PATCH lttng-tools] Fix: update context types for
 Python bindings
Date: Sat, 18 Jan 2020 14:29:49 -0500
Message-ID: <20200118192949.29902-1-bedard.christophe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by lists.lttng.org (Postfix) with ESMTPS id 480SgN4vXXz1nM5
 for <lttng-dev@lists.lttng.org>; Sat, 18 Jan 2020 14:29:52 -0500 (EST)
Received: by mail-qt1-x842.google.com with SMTP id j5so24537889qtq.9
 for <lttng-dev@lists.lttng.org>; Sat, 18 Jan 2020 11:29:52 -0800 (PST)
Received: from localhost.localdomain
 (modemcable243.133-200-24.mc.videotron.ca. [24.200.133.243])
 by smtp.gmail.com with ESMTPSA id g18sm13568610qki.13.2020.01.18.11.29.50
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2020 11:29:51 -0800 (PST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Fixes: #1214

Signed-off-by: Christophe Bedard <bedard.christophe@gmail.com>
---
 extras/bindings/swig/python/lttng.i.in | 45 ++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/extras/bindings/swig/python/lttng.i.in b/extras/bindings/swig/python/lttng.i.in
index f98fda6a..636f39f5 100644
--- a/extras/bindings/swig/python/lttng.i.in
+++ b/extras/bindings/swig/python/lttng.i.in
@@ -130,6 +130,15 @@ enum lttng_event_output {
 %rename("EVENT_CONTEXT_PPID") LTTNG_EVENT_CONTEXT_PPID;
 %rename("EVENT_CONTEXT_VPPID") LTTNG_EVENT_CONTEXT_VPPID;
 %rename("EVENT_CONTEXT_PTHREAD_ID") LTTNG_EVENT_CONTEXT_PTHREAD_ID;
+%rename("EVENT_CONTEXT_HOSTNAME") LTTNG_EVENT_CONTEXT_HOSTNAME;
+%rename("EVENT_CONTEXT_IP") LTTNG_EVENT_CONTEXT_IP;
+%rename("EVENT_CONTEXT_PERF_CPU_COUNTER") LTTNG_EVENT_CONTEXT_PERF_CPU_COUNTER;
+%rename("EVENT_CONTEXT_PERF_THREAD_COUNTER") LTTNG_EVENT_CONTEXT_PERF_THREAD_COUNTER;
+%rename("EVENT_CONTEXT_APP_CONTEXT") LTTNG_EVENT_CONTEXT_APP_CONTEXT;
+%rename("EVENT_CONTEXT_INTERRUPTIBLE") LTTNG_EVENT_CONTEXT_INTERRUPTIBLE;
+%rename("EVENT_CONTEXT_PREEMPTIBLE") LTTNG_EVENT_CONTEXT_PREEMPTIBLE;
+%rename("EVENT_CONTEXT_NEED_RESCHEDULE") LTTNG_EVENT_CONTEXT_NEED_RESCHEDULE;
+%rename("EVENT_CONTEXT_MIGRATABLE") LTTNG_EVENT_CONTEXT_MIGRATABLE;
 enum lttng_event_context_type {
 	LTTNG_EVENT_CONTEXT_PID               = 0,
 	LTTNG_EVENT_CONTEXT_PERF_COUNTER      = 1,
@@ -142,6 +151,15 @@ enum lttng_event_context_type {
 	LTTNG_EVENT_CONTEXT_PPID              = 8,
 	LTTNG_EVENT_CONTEXT_VPPID             = 9,
 	LTTNG_EVENT_CONTEXT_PTHREAD_ID        = 10,
+	LTTNG_EVENT_CONTEXT_HOSTNAME          = 11,
+	LTTNG_EVENT_CONTEXT_IP                = 12,
+	LTTNG_EVENT_CONTEXT_PERF_CPU_COUNTER  = 13,
+	LTTNG_EVENT_CONTEXT_PERF_THREAD_COUNTER = 14,
+	LTTNG_EVENT_CONTEXT_APP_CONTEXT       = 15,
+	LTTNG_EVENT_CONTEXT_INTERRUPTIBLE     = 16,
+	LTTNG_EVENT_CONTEXT_PREEMPTIBLE       = 17,
+	LTTNG_EVENT_CONTEXT_NEED_RESCHEDULE   = 18,
+	LTTNG_EVENT_CONTEXT_MIGRATABLE        = 19,
 };
 
 
@@ -870,6 +888,33 @@ struct lttng_event_context {
 			case 10:
 				sprintf(temp, "lttng.EventContext; ctx(EVENT_CONTEXT_PTHREAD_ID)");
 				break;
+			case 11:
+				sprintf(temp, "lttng.EventContext; ctx(EVENT_CONTEXT_HOSTNAME)");
+				break;
+			case 12:
+				sprintf(temp, "lttng.EventContext; ctx(EVENT_CONTEXT_IP)");
+				break;
+			case 13:
+				sprintf(temp, "lttng.EventContext; ctx(EVENT_CONTEXT_PERF_CPU_COUNTER)");
+				break;
+			case 14:
+				sprintf(temp, "lttng.EventContext; ctx(EVENT_CONTEXT_PERF_THREAD_COUNTER)");
+				break;
+			case 15:
+				sprintf(temp, "lttng.EventContext; ctx(EVENT_CONTEXT_APP_CONTEXT)");
+				break;
+			case 16:
+				sprintf(temp, "lttng.EventContext; ctx(EVENT_CONTEXT_INTERRUPTIBLE)");
+				break;
+			case 17:
+				sprintf(temp, "lttng.EventContext; ctx(EVENT_CONTEXT_PREEMPTIBLE)");
+				break;
+			case 18:
+				sprintf(temp, "lttng.EventContext; ctx(EVENT_CONTEXT_NEED_RESCHEDULE)");
+				break;
+			case 19:
+				sprintf(temp, "lttng.EventContext; ctx(EVENT_CONTEXT_MIGRATABLE)");
+				break;
 			default:
 				sprintf(temp, "lttng.EventContext; type(%i)", $self->ctx);
 				break;
-- 
2.17.1
