From: Antoine Busque <abusque@efficios.com>
Subject: [PATCH lttng-modules] Add prio field to process
	statedump
Date: Sat, 28 Nov 2015 23:12:46 -0500
Message-ID: <1448770366-2388-1-git-send-email-abusque__14641.5664152757$1448770450$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <abusque@efficios.com>) id 1a2tMY-0004XV-Od
 for lttng-dev@lists.lttng.org; Sat, 28 Nov 2015 23:13:23 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Antoine Busque <antoine.busque@efficios.com>
List-Id: lttng-dev@lists.lttng.org

From: Antoine Busque <antoine.busque@efficios.com>

This introduces a payload field named 'prio' for the process' priority
value to the lttng_statedump_process_state event. The prio field's
value corresponds to the value which would be provided by the prio
context for a given process. It is however computed directly, rather
than by calling the equivalent task_prio() function from the kernel.

Signed-off-by: Antoine Busque <abusque@efficios.com>
---
 instrumentation/events/lttng-module/lttng-statedump.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/instrumentation/events/lttng-module/lttng-statedump.h b/instrumentation/events/lttng-module/lttng-statedump.h
index 916a6c5..fa1807f 100644
--- a/instrumentation/events/lttng-module/lttng-statedump.h
+++ b/instrumentation/events/lttng-module/lttng-statedump.h
@@ -7,6 +7,7 @@
 #include "../../../probes/lttng-tracepoint-event.h"
 #include <linux/nsproxy.h>
 #include <linux/pid_namespace.h>
+#include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/version.h>
 
@@ -63,6 +64,7 @@ LTTNG_TRACEPOINT_EVENT(lttng_statedump_process_state,
 				ret;
 			}))
 		ctf_array_text(char, name, p->comm, TASK_COMM_LEN)
+		ctf_integer(int, prio, p->prio - MAX_RT_PRIO)
 		ctf_integer(int, type, type)
 		ctf_integer(int, mode, mode)
 		ctf_integer(int, submode, submode)
-- 
2.6.2
