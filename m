From: Rabin Vincent <rabin.vincent@axis.com>
Subject: [PATCH lttng-modules 2.6 1/2] Fix: make sched
	instrumentation build for 4.3 kernel
Date: Mon, 26 Oct 2015 12:40:31 +0100
Message-ID: <1445859632-20147-1-git-send-email-rabinv__34161.4570156254$1445859704$gmane$org@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from bastet.se.axis.com ([195.60.68.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <rabin.vincent@axis.com>) id 1Zqg8q-0007dp-FO
 for lttng-dev@lists.lttng.org; Mon, 26 Oct 2015 07:40:46 -0400
Received: from localhost (localhost [127.0.0.1])
 by bastet.se.axis.com (Postfix) with ESMTP id EC12F18103
 for <lttng-dev@lists.lttng.org>; Mon, 26 Oct 2015 12:40:38 +0100 (CET)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id NGApDV9SyyKI for <lttng-dev@lists.lttng.org>;
 Mon, 26 Oct 2015 12:40:38 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bastet.se.axis.com (Postfix) with ESMTP id 52DEF18086
 for <lttng-dev@lists.lttng.org>; Mon, 26 Oct 2015 12:40:38 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id 3C9C21343
 for <lttng-dev@lists.lttng.org>; Mon, 26 Oct 2015 12:40:38 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
 by boulder.se.axis.com (Postfix) with ESMTP id 311EA1342
 for <lttng-dev@lists.lttng.org>; Mon, 26 Oct 2015 12:40:38 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
 by thoth.se.axis.com (Postfix) with ESMTP id 2EEE3134030
 for <lttng-dev@lists.lttng.org>; Mon, 26 Oct 2015 12:40:38 +0100 (CET)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Rabin Vincent <rabinv@axis.com>
List-Id: lttng-dev@lists.lttng.org

The backported patch "Fix: update sched wakeup instrumentation for 4.3
kernel" (c93180196ea8) used a newer definition of
LTTNG_TRACEPOINT_EVENT_CLASS which is not available in v2.6.

Signed-off-by: Rabin Vincent <rabinv@axis.com>
---
 instrumentation/events/lttng-module/sched.h |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/instrumentation/events/lttng-module/sched.h b/instrumentation/events/lttng-module/sched.h
index f6b65ae..d2e03f9 100644
--- a/instrumentation/events/lttng-module/sched.h
+++ b/instrumentation/events/lttng-module/sched.h
@@ -142,12 +142,26 @@ LTTNG_TRACEPOINT_EVENT_CLASS(sched_wakeup_template,
 
 	TP_ARGS(p),
 
-	TP_FIELDS(
-		ctf_array_text(char, comm, p->comm, TASK_COMM_LEN)
-		ctf_integer(pid_t, tid, p->pid)
-		ctf_integer(int, prio, p->prio)
-		ctf_integer(int, target_cpu, task_cpu(p))
+	TP_STRUCT__entry(
+		__array_text(	char,	comm,	TASK_COMM_LEN	)
+		__field(	pid_t,	tid			)
+		__field(	int,	prio			)
+		__field(	int,	target_cpu		)
+	),
+
+	TP_fast_assign(
+		tp_memcpy(comm, p->comm, TASK_COMM_LEN)
+		tp_assign(tid, p->pid)
+		tp_assign(prio, p->prio)
+		tp_assign(target_cpu, task_cpu(p))
 	)
+	TP_perf_assign(
+		__perf_task(p)
+	),
+
+	TP_printk("comm=%s tid=%d prio=%d target_cpu=%03d",
+		  __entry->comm, __entry->tid, __entry->prio,
+		  __entry->target_cpu)
 )
 #else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)) */
 LTTNG_TRACEPOINT_EVENT_CLASS(sched_wakeup_template,
-- 
1.7.10.4
