From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: sched_process_exec
Date: Thu, 11 Oct 2012 11:24:48 +0200
Message-ID: <50769060.7070309__33885.0161679604$1349947477$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1TMEzt-0005GC-6P
	for lttng-dev@lists.lttng.org; Thu, 11 Oct 2012 05:24:05 -0400
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1TMEzm-0007NV-Jc from Paul_Woegerer@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 11 Oct 2012 02:23:58 -0700
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

Is there a reason why instrumentation/events/lttng-module/sched.h does =

not include TRACE_EVENT(sched_process_exec) ?

The patch below adds the missing tracepoint definition (tested with =

kernel 3.4.6-2.10).

diff --git a/instrumentation/events/lttng-module/sched.h =

b/instrumentation/events/lttng-module/sched.h
index b68616e..ef791ac 100644
--- a/instrumentation/events/lttng-module/sched.h
+++ b/instrumentation/events/lttng-module/sched.h
@@ -314,6 +314,32 @@ TRACE_EVENT(sched_process_fork,
  )

  /*
+ * Tracepoint for exec:
+ */
+TRACE_EVENT(sched_process_exec,
+
+       TP_PROTO(struct task_struct *p, pid_t old_pid,
+                struct linux_binprm *bprm),
+
+       TP_ARGS(p, old_pid, bprm),
+
+       TP_STRUCT__entry(
+               __string(       filename,       bprm->filename  )
+               __field(        pid_t,          pid             )
+               __field(        pid_t,          old_pid         )
+       ),
+
+       TP_fast_assign(
+               tp_strcpy(filename, bprm->filename);
+               tp_assign(pid, p->pid)
+               tp_assign(old_pid, old_pid)
+       ),
+
+       TP_printk("filename=3D%s pid=3D%d old_pid=3D%d", __get_str(filename=
),
+                 __entry->pid, __entry->old_pid)
+)
+
+/*
   * XXX the below sched_stat tracepoints only apply to =

SCHED_OTHER/BATCH/IDLE
   *     adding sched_stat support to SCHED_FIFO/RR would be welcome.
   */

-- =

Paul Woegerer | SW Development Engineer
http://go.mentor.com/sourceryanalyzer

Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to G=
oogle Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other c=
ountries.
