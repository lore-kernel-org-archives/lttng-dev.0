From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH lttng-modules] sched instrumentation: rename
	"pid" fields in sched_process_exec
Date: Sun, 25 Nov 2012 13:39:14 -0600
Message-ID: <1353872354-19886-1-git-send-email-andrew_gabbasov__39541.3722530522$1353872395$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Andrew_Gabbasov@mentor.com>) id 1Tci31-000580-Ng
	for lttng-dev@lists.lttng.org; Sun, 25 Nov 2012 14:39:23 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1Tci2w-00008b-7Y from Andrew_Gabbasov@mentor.com
	for lttng-dev@lists.lttng.org; Sun, 25 Nov 2012 11:39:18 -0800
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

Rename "pid" to "tid" fields in new code, similarly to what was
done earlier for all sched tracepoints.

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 instrumentation/events/lttng-module/sched.h |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/instrumentation/events/lttng-module/sched.h b/instrumentation/events/lttng-module/sched.h
index ca46ed0..005f3d1 100644
--- a/instrumentation/events/lttng-module/sched.h
+++ b/instrumentation/events/lttng-module/sched.h
@@ -326,18 +326,18 @@ TRACE_EVENT(sched_process_exec,
 
 	TP_STRUCT__entry(
 		__string(	filename,	bprm->filename	)
-		__field(	pid_t,		pid		)
-		__field(	pid_t,		old_pid		)
+		__field(	pid_t,		tid		)
+		__field(	pid_t,		old_tid		)
 	),
 
 	TP_fast_assign(
 		tp_strcpy(filename, bprm->filename)
-		tp_assign(pid, p->pid)
-		tp_assign(old_pid, old_pid)
+		tp_assign(tid, p->pid)
+		tp_assign(old_tid, old_pid)
 	),
 
-	TP_printk("filename=%s pid=%d old_pid=%d", __get_str(filename),
-		  __entry->pid, __entry->old_pid)
+	TP_printk("filename=%s tid=%d old_tid=%d", __get_str(filename),
+		  __entry->tid, __entry->old_tid)
 )
 #endif
 
-- 
1.7.10.4
