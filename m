From: Antoine Busque <abusque@efficios.com>
Subject: [PATCH lttng-modules] Use MAX_RT_PRIO offset in
	sched_wakeup_template
Date: Fri,  4 Dec 2015 15:16:59 -0500
Message-ID: <1449260219-1944-1-git-send-email-abusque__26279.7305048027$1449260309$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <abusque@efficios.com>) id 1a4wn1-0003ct-8b
 for lttng-dev@lists.lttng.org; Fri, 04 Dec 2015 15:17:21 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 54FB5340443
 for <lttng-dev@lists.lttng.org>; Fri,  4 Dec 2015 20:17:07 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

All other sched_* events with prio fields offset the task_struct's
prio value by subtracting MAX_RT_PRIO. This way the value corresponds
to that given by the kernel's task_prio function, and thus with the
prio context field.

This adds the same offset to sched_wakeup, sched_wakeup_new, and
sched_waking, via the sched_wakeup_template event class. This way
their value is comparable to other sched_* events, and the prio
context.

Signed-off-by: Antoine Busque <abusque@efficios.com>
---
 instrumentation/events/lttng-module/sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/instrumentation/events/lttng-module/sched.h b/instrumentation/events/lttng-module/sched.h
index 4e829a3..4f3676b 100644
--- a/instrumentation/events/lttng-module/sched.h
+++ b/instrumentation/events/lttng-module/sched.h
@@ -155,7 +155,7 @@ LTTNG_TRACEPOINT_EVENT_CLASS(sched_wakeup_template,
 	TP_FIELDS(
 		ctf_array_text(char, comm, p->comm, TASK_COMM_LEN)
 		ctf_integer(pid_t, tid, p->pid)
-		ctf_integer(int, prio, p->prio)
+		ctf_integer(int, prio, p->prio - MAX_RT_PRIO)
 		ctf_integer(int, target_cpu, task_cpu(p))
 	)
 )
@@ -175,7 +175,7 @@ LTTNG_TRACEPOINT_EVENT_CLASS(sched_wakeup_template,
 	TP_FIELDS(
 		ctf_array_text(char, comm, p->comm, TASK_COMM_LEN)
 		ctf_integer(pid_t, tid, p->pid)
-		ctf_integer(int, prio, p->prio)
+		ctf_integer(int, prio, p->prio - MAX_RT_PRIO)
 		ctf_integer(int, success, success)
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
 		ctf_integer(int, target_cpu, task_cpu(p))
-- 
2.6.3
