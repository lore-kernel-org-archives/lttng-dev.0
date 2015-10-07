From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 1/3] Tracepoint: fix documentation of RCU lockdep checks
Date: Wed,  7 Oct 2015 06:39:18 -0400
Message-ID: <1444214360-16708-1-git-send-email-mathieu.desnoyers@efficios.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dave Hansen <dave@sr71.net>
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
