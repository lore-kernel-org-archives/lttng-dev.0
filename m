From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 2/4] Fix: Replace pointer values
 with task->tk_pid and rpc_clnt->cl_clid
Date: Wed,  9 Jan 2019 14:59:16 -0500
Message-ID: <20190109195918.31730-2-mjeanson__5303.67481192133$1547063869$gmane$org@efficios.com>
References: <20190109195918.31730-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43Zg2C6wCRz16nl
 for <lttng-dev@lists.lttng.org>; Wed,  9 Jan 2019 14:59:31 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 5BBD2A246C
 for <lttng-dev@lists.lttng.org>; Wed,  9 Jan 2019 14:59:25 -0500 (EST)
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

Introduced in v3.12.

See upstream commit :

  commit 92cb6c5be8134db6f7c38f25f6afd13e444cebaf
  Author: Trond Myklebust <Trond.Myklebust@netapp.com>
  Date:   Wed Sep 4 22:09:50 2013 -0400

    SUNRPC: Replace pointer values with task->tk_pid and rpc_clnt->cl_clid

    Instead of the pointer values, use the task and client identifier values
    for tracing purposes.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 instrumentation/events/lttng-module/rpc.h | 108 ++++++++++++++++++++--
 1 file changed, 102 insertions(+), 6 deletions(-)

diff --git a/instrumentation/events/lttng-module/rpc.h b/instrumentation/events/lttng-module/rpc.h
index c825f8b..1f47d6e 100644
--- a/instrumentation/events/lttng-module/rpc.h
+++ b/instrumentation/events/lttng-module/rpc.h
@@ -9,6 +9,20 @@
 #include <linux/sunrpc/sched.h>
 #include <linux/sunrpc/clnt.h>
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0))
+LTTNG_TRACEPOINT_EVENT_CLASS(rpc_task_status,
+
+	TP_PROTO(struct rpc_task *task),
+
+	TP_ARGS(task),
+
+	TP_FIELDS(
+		ctf_integer(unsigned int, task_id, task->tk_pid)
+		ctf_integer(unsigned int, client_id, task->tk_client->cl_clid)
+		ctf_integer(int, status, task->tk_status)
+	)
+)
+#else
 LTTNG_TRACEPOINT_EVENT_CLASS(rpc_task_status,
 
 	TP_PROTO(struct rpc_task *task),
@@ -21,6 +35,7 @@ LTTNG_TRACEPOINT_EVENT_CLASS(rpc_task_status,
 		ctf_integer(int, status, task->tk_status)
 	)
 )
+#endif
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(rpc_task_status, rpc_call_status,
 	TP_PROTO(struct rpc_task *task),
@@ -41,8 +56,8 @@ LTTNG_TRACEPOINT_EVENT(rpc_connect_status,
 	TP_ARGS(task),
 
 	TP_FIELDS(
-		ctf_integer_hex(const struct rpc_task *, task, task)
-		ctf_integer_hex(const struct rpc_clnt *, clnt, task->tk_client)
+		ctf_integer(unsigned int, task_id, task->tk_pid)
+		ctf_integer(unsigned int, client_id, task->tk_client->cl_clid)
 		ctf_integer(int, status, task->tk_status)
 	)
 )
@@ -54,8 +69,8 @@ LTTNG_TRACEPOINT_EVENT_CLASS(rpc_task_running,
 	TP_ARGS(task, action),
 
 	TP_FIELDS(
-		ctf_integer_hex(const struct rpc_clnt *, clnt, task->tk_client)
-		ctf_integer_hex(const struct rpc_task *, task, task)
+		ctf_integer(unsigned int, task_id, task->tk_pid)
+		ctf_integer(unsigned int, client_id, task->tk_client->cl_clid)
 		ctf_integer_hex(const void *, action, action)
 		ctf_integer(unsigned long, runstate, task->tk_runstate)
 		ctf_integer(int, status, task->tk_status)
@@ -91,8 +106,8 @@ LTTNG_TRACEPOINT_EVENT_CLASS(rpc_task_queued,
 	TP_ARGS(task, q),
 
 	TP_FIELDS(
-		ctf_integer_hex(const struct rpc_clnt *, clnt, task->tk_client)
-		ctf_integer_hex(const struct rpc_task *, task, task)
+		ctf_integer(unsigned int, task_id, task->tk_pid)
+		ctf_integer(unsigned int, client_id, task->tk_client->cl_clid)
 		ctf_integer(unsigned long, timeout, task->tk_timeout)
 		ctf_integer(unsigned long, runstate, task->tk_runstate)
 		ctf_integer(int, status, task->tk_status)
@@ -115,6 +130,87 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(rpc_task_queued, rpc_task_wakeup,
 	TP_ARGS(task, q)
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
+
+LTTNG_TRACEPOINT_EVENT_CLASS(rpc_task_running,
+
+	TP_PROTO(const struct rpc_clnt *clnt, const struct rpc_task *task, const void *action),
+
+	TP_ARGS(clnt, task, action),
+
+	TP_FIELDS(
+		ctf_integer(unsigned int, task_id, task->tk_pid)
+		ctf_integer(unsigned int, client_id, task->tk_client->cl_clid)
+		ctf_integer_hex(const void *, action, action)
+		ctf_integer(unsigned long, runstate, task->tk_runstate)
+		ctf_integer(int, status, task->tk_status)
+		ctf_integer(unsigned short, flags, task->tk_flags)
+	)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(rpc_task_running, rpc_task_begin,
+
+	TP_PROTO(const struct rpc_clnt *clnt, const struct rpc_task *task, const void *action),
+
+	TP_ARGS(clnt, task, action)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(rpc_task_running, rpc_task_run_action,
+
+	TP_PROTO(const struct rpc_clnt *clnt, const struct rpc_task *task, const void *action),
+
+	TP_ARGS(clnt, task, action)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(rpc_task_running, rpc_task_complete,
+
+	TP_PROTO(const struct rpc_clnt *clnt, const struct rpc_task *task, const void *action),
+
+	TP_ARGS(clnt, task, action)
+)
+
+LTTNG_TRACEPOINT_EVENT_CLASS(rpc_task_queued,
+
+	TP_PROTO(const struct rpc_clnt *clnt, const struct rpc_task *task, const struct rpc_wait_queue *q),
+
+	TP_ARGS(clnt, task, q),
+
+	TP_FIELDS(
+		ctf_integer(unsigned int, task_id, task->tk_pid)
+		ctf_integer(unsigned int, client_id, task->tk_client->cl_clid)
+		ctf_integer(unsigned long, timeout, task->tk_timeout)
+		ctf_integer(unsigned long, runstate, task->tk_runstate)
+		ctf_integer(int, status, task->tk_status)
+		ctf_integer(unsigned short, flags, task->tk_flags)
+		ctf_string(q_name, rpc_qname(q))
+	)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(rpc_task_queued, rpc_task_sleep,
+
+	TP_PROTO(const struct rpc_clnt *clnt, const struct rpc_task *task, const struct rpc_wait_queue *q),
+
+	TP_ARGS(clnt, task, q)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(rpc_task_queued, rpc_task_wakeup,
+
+	TP_PROTO(const struct rpc_clnt *clnt, const struct rpc_task *task, const struct rpc_wait_queue *q),
+
+	TP_ARGS(clnt, task, q)
+)
+
 #else
 LTTNG_TRACEPOINT_EVENT(rpc_connect_status,
 	TP_PROTO(struct rpc_task *task, int status),
-- 
2.17.1
