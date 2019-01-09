From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 3/4] Fix: SUNRPC: Simplify
 defining common RPC trace events (v5.0)
Date: Wed,  9 Jan 2019 14:59:17 -0500
Message-ID: <20190109195918.31730-3-mjeanson__30946.971246931$1547063888$gmane$org@efficios.com>
References: <20190109195918.31730-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43Zg2D6wsvz16p0
 for <lttng-dev@lists.lttng.org>; Wed,  9 Jan 2019 14:59:32 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 22630A2483
 for <lttng-dev@lists.lttng.org>; Wed,  9 Jan 2019 14:59:26 -0500 (EST)
In-Reply-To: <20190109195918.31730-1-mjeanson@efficios.com>
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

See upstream commit :

  commit dc5820bd21d84ee34770b0a1e2fca9378f8f7456
  Author: Chuck Lever <chuck.lever@oracle.com>
  Date:   Wed Dec 19 11:00:16 2018 -0500

    SUNRPC: Simplify defining common RPC trace events

    Clean up, no functional change is expected.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 instrumentation/events/lttng-module/rpc.h | 99 ++++++++++++++++-------
 1 file changed, 72 insertions(+), 27 deletions(-)

diff --git a/instrumentation/events/lttng-module/rpc.h b/instrumentation/events/lttng-module/rpc.h
index 1f47d6e..3798e8e 100644
--- a/instrumentation/events/lttng-module/rpc.h
+++ b/instrumentation/events/lttng-module/rpc.h
@@ -9,7 +9,32 @@
 #include <linux/sunrpc/sched.h>
 #include <linux/sunrpc/clnt.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,0,0))
+LTTNG_TRACEPOINT_EVENT_CLASS(rpc_task_status,
+
+	TP_PROTO(const struct rpc_task *task),
+
+	TP_ARGS(task),
+
+	TP_FIELDS(
+		ctf_integer(unsigned int, task_id, task->tk_pid)
+		ctf_integer(unsigned int, client_id, task->tk_client->cl_clid)
+		ctf_integer(int, status, task->tk_status)
+	)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(rpc_task_status, rpc_call_status,
+	TP_PROTO(const struct rpc_task *task),
+
+	TP_ARGS(task)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(rpc_task_status, rpc_bind_status,
+	TP_PROTO(const struct rpc_task *task),
+
+	TP_ARGS(task)
+)
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
 LTTNG_TRACEPOINT_EVENT_CLASS(rpc_task_status,
 
 	TP_PROTO(struct rpc_task *task),
@@ -22,6 +47,18 @@ LTTNG_TRACEPOINT_EVENT_CLASS(rpc_task_status,
 		ctf_integer(int, status, task->tk_status)
 	)
 )
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(rpc_task_status, rpc_call_status,
+	TP_PROTO(struct rpc_task *task),
+
+	TP_ARGS(task)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(rpc_task_status, rpc_bind_status,
+	TP_PROTO(struct rpc_task *task),
+
+	TP_ARGS(task)
+)
 #else
 LTTNG_TRACEPOINT_EVENT_CLASS(rpc_task_status,
 
@@ -35,7 +72,6 @@ LTTNG_TRACEPOINT_EVENT_CLASS(rpc_task_status,
 		ctf_integer(int, status, task->tk_status)
 	)
 )
-#endif
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(rpc_task_status, rpc_call_status,
 	TP_PROTO(struct rpc_task *task),
@@ -48,8 +84,15 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(rpc_task_status, rpc_bind_status,
 
 	TP_ARGS(task)
 )
+#endif
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,17,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,0,0))
+LTTNG_TRACEPOINT_EVENT_INSTANCE(rpc_task_status, rpc_connect_status,
+	TP_PROTO(const struct rpc_task *task),
+
+	TP_ARGS(task)
+)
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4,17,0))
 LTTNG_TRACEPOINT_EVENT(rpc_connect_status,
 	TP_PROTO(const struct rpc_task *task),
 
@@ -61,7 +104,33 @@ LTTNG_TRACEPOINT_EVENT(rpc_connect_status,
 		ctf_integer(int, status, task->tk_status)
 	)
 )
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
+LTTNG_TRACEPOINT_EVENT(rpc_connect_status,
+	TP_PROTO(struct rpc_task *task, int status),
+
+	TP_ARGS(task, status),
+
+	TP_FIELDS(
+		ctf_integer(unsigned int, task_id, task->tk_pid)
+		ctf_integer(unsigned int, client_id, task->tk_client->cl_clid)
+		ctf_integer(int, status, status)
+	)
+)
+#else
+LTTNG_TRACEPOINT_EVENT(rpc_connect_status,
+	TP_PROTO(struct rpc_task *task, int status),
+
+	TP_ARGS(task, status),
+
+	TP_FIELDS(
+		ctf_integer_hex(const struct rpc_task *, task, task)
+		ctf_integer_hex(const struct rpc_clnt *, clnt, task->tk_client)
+		ctf_integer(int, status, status)
+	)
+)
+#endif
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,17,0))
 LTTNG_TRACEPOINT_EVENT_CLASS(rpc_task_running,
 
 	TP_PROTO(const struct rpc_task *task, const void *action),
@@ -131,18 +200,6 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(rpc_task_queued, rpc_task_wakeup,
 )
 
 #elif (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
-LTTNG_TRACEPOINT_EVENT(rpc_connect_status,
-	TP_PROTO(struct rpc_task *task, int status),
-
-	TP_ARGS(task, status),
-
-	TP_FIELDS(
-		ctf_integer(unsigned int, task_id, task->tk_pid)
-		ctf_integer(unsigned int, client_id, task->tk_client->cl_clid)
-		ctf_integer(int, status, status)
-	)
-)
-
 LTTNG_TRACEPOINT_EVENT_CLASS(rpc_task_running,
 
 	TP_PROTO(const struct rpc_clnt *clnt, const struct rpc_task *task, const void *action),
@@ -212,18 +269,6 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(rpc_task_queued, rpc_task_wakeup,
 )
 
 #else
-LTTNG_TRACEPOINT_EVENT(rpc_connect_status,
-	TP_PROTO(struct rpc_task *task, int status),
-
-	TP_ARGS(task, status),
-
-	TP_FIELDS(
-		ctf_integer_hex(const struct rpc_task *, task, task)
-		ctf_integer_hex(const struct rpc_clnt *, clnt, task->tk_client)
-		ctf_integer(int, status, status)
-	)
-)
-
 LTTNG_TRACEPOINT_EVENT_CLASS(rpc_task_running,
 
 	TP_PROTO(const struct rpc_clnt *clnt, const struct rpc_task *task, const void *action),
-- 
2.17.1
