From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: sched_process_exec
Date: Fri, 12 Oct 2012 14:12:42 +0200
Message-ID: <5078093A.6080500__2929.07385523922$1350043987$gmane$org@mentor.com>
References: <50769060.7070309@mentor.com> <20121011145855.GA11726@Krystal>
	<5076E59D.3010003@mentor.com> <20121011160729.GA29181@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1TMe6O-0002IA-43
	for lttng-dev@lists.lttng.org; Fri, 12 Oct 2012 08:12:28 -0400
In-Reply-To: <20121011160729.GA29181@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 10/11/2012 06:07 PM, Mathieu Desnoyers wrote:
> * Woegerer, Paul (Paul_Woegerer@mentor.com) wrote:
>> On 10/11/2012 04:58 PM, Mathieu Desnoyers wrote:
>>> A couple a details to fix before I can merge this patch though:
>>>
>>> Please also update instrumentation/events/mainline/sched.h to add the
>>> original mainline TRACE_EVENT, so we can keep the files in sync.
>>
>> Ok, reconfigured Thunderbird, removed semicolon, updated mainline:
> 
> Still an issue:
> 
> compudj@thinkos:~/work/lttng-modules$ patch -p1 < ~/.swp
> patching file instrumentation/events/lttng-module/sched.h
> patch: **** malformed patch at line 45: SCHED_OTHER/BATCH/IDLE

Now it should (hopefully) work:

From b792323bca694f1e88144319befcdbfb30efa878 Mon Sep 17 00:00:00 2001
From: Paul Woegerer <paul_woegerer@mentor.com>
Date: Fri, 12 Oct 2012 12:52:19 +0200
Subject: [PATCH] Add TRACE_EVENT(sched_process_exec) to sched.h.

---
 instrumentation/events/lttng-module/sched.h |   26 ++++++++++++++++++++++++++
 instrumentation/events/mainline/sched.h     |   26 ++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/instrumentation/events/lttng-module/sched.h b/instrumentation/events/lttng-module/sched.h
index b68616e..23e4955 100644
--- a/instrumentation/events/lttng-module/sched.h
+++ b/instrumentation/events/lttng-module/sched.h
@@ -314,6 +314,32 @@ TRACE_EVENT(sched_process_fork,
 )
 
 /*
+ * Tracepoint for exec:
+ */
+TRACE_EVENT(sched_process_exec,
+
+	TP_PROTO(struct task_struct *p, pid_t old_pid,
+		 struct linux_binprm *bprm),
+
+	TP_ARGS(p, old_pid, bprm),
+
+	TP_STRUCT__entry(
+		__string(	filename,	bprm->filename	)
+		__field(	pid_t,		pid		)
+		__field(	pid_t,		old_pid		)
+	),
+
+	TP_fast_assign(
+		tp_strcpy(filename, bprm->filename)
+		tp_assign(pid, p->pid)
+		tp_assign(old_pid, old_pid)
+	),
+
+	TP_printk("filename=%s pid=%d old_pid=%d", __get_str(filename),
+		  __entry->pid, __entry->old_pid)
+)
+
+/*
  * XXX the below sched_stat tracepoints only apply to SCHED_OTHER/BATCH/IDLE
  *     adding sched_stat support to SCHED_FIFO/RR would be welcome.
  */
diff --git a/instrumentation/events/mainline/sched.h b/instrumentation/events/mainline/sched.h
index f633478..6700ecc 100644
--- a/instrumentation/events/mainline/sched.h
+++ b/instrumentation/events/mainline/sched.h
@@ -275,6 +275,32 @@ TRACE_EVENT(sched_process_fork,
 );
 
 /*
+ * Tracepoint for exec:
+ */
+TRACE_EVENT(sched_process_exec,
+
+	TP_PROTO(struct task_struct *p, pid_t old_pid,
+		 struct linux_binprm *bprm),
+
+	TP_ARGS(p, old_pid, bprm),
+
+	TP_STRUCT__entry(
+		__string(	filename,	bprm->filename	)
+		__field(	pid_t,		pid		)
+		__field(	pid_t,		old_pid		)
+	),
+
+	TP_fast_assign(
+		__assign_str(filename, bprm->filename);
+		__entry->pid		= p->pid;
+		__entry->old_pid	= old_pid;
+	),
+
+	TP_printk("filename=%s pid=%d old_pid=%d", __get_str(filename),
+		  __entry->pid, __entry->old_pid)
+);
+
+/*
  * XXX the below sched_stat tracepoints only apply to SCHED_OTHER/BATCH/IDLE
  *     adding sched_stat support to SCHED_FIFO/RR would be welcome.
  */
-- 
1.7.10.4
