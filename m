From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 1/2] Tracepoint: fix documentation of RCU
	lockdep checks
Date: Tue,  6 Oct 2015 19:56:56 -0400
Message-ID: <1444175817-12425-1-git-send-email-mathieu.desnoyers__44692.8315017887$1444176154$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZjcAt-0003cf-RZ
 for lttng-dev@lists.lttng.org; Tue, 06 Oct 2015 20:01:43 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lttng-dev@lists.lttng.org, Dave Hansen <dave@sr71.net>, linux-kernel@vger.kernel.org
List-Id: lttng-dev@lists.lttng.org

The documentation on top of __DECLARE_TRACE() does not match its
implementation since the condition check has been added to the
RCU lockdep checks. Update the documentation to match its
implementation.

Fixes: a05d59a56733 "tracing: Add condition check to RCU lockdep checks"
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Dave Hansen <dave@sr71.net>
CC: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/tracepoint.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index a5f7f3e..c8e3030 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -167,10 +167,11 @@ extern void syscall_unregfunc(void);
  * structure. Force alignment to the same alignment as the section start.
  *
  * When lockdep is enabled, we make sure to always do the RCU portions of
- * the tracepoint code, regardless of whether tracing is on or we match the
- * condition.  This lets us find RCU issues triggered with tracepoints even
- * when this tracepoint is off.  This code has no purpose other than poking
- * RCU a bit.
+ * the tracepoint code, regardless of whether tracing is on. However,
+ * don't check if the condition is false, due to interaction with idle
+ * instrumentation. This lets us find RCU issues triggered with tracepoints
+ * even when this tracepoint is off. This code has no purpose other than
+ * poking RCU a bit.
  */
 #define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
 	extern struct tracepoint __tracepoint_##name;			\
-- 
2.1.4
