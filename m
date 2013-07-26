From: Xiaona Han <xiaonahappy13@163.com>
Subject: [PATCH babeltrace] Remove the unnecessary underscore
	prefix
Date: Fri, 26 Jul 2013 16:07:43 +0800
Message-ID: <1374826063-5291-1-git-send-email-xiaonahappy13__36056.984976358$1374797340$gmane$org@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [124.16.141.1] (helo=host.localdomain)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <root@host.localdomain>) id 1V2VZk-0000oa-RF
	for lttng-dev@lists.lttng.org; Thu, 25 Jul 2013 20:08:09 -0400
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

When getting the fields of an event by a name, there is no necessary
to add an underscore prefix. This removes the underscore prefix of
the field name in the examples.

Signed-off-by: Xiaona Han <xiaonahappy13@163.com>
---
 bindings/python/examples/example-api-test.py |    4 ++--
 bindings/python/examples/sched_switch.py     |   16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/bindings/python/examples/example-api-test.py b/bindings/python/examples/example-api-test.py
index 5846fac..66754ba 100644
--- a/bindings/python/examples/example-api-test.py
+++ b/bindings/python/examples/example-api-test.py
@@ -50,7 +50,7 @@ while(event is not None):
 		event.get_cycles(), event.get_name()))
 
 	if event.get_name() == "sched_switch":
-		prev_field = event.get_field("_prev_comm")
+		prev_field = event.get_field("prev_comm")
 		if prev_field is None:
 			print("ERROR: Missing prev_comm context info")
 		else:
@@ -58,7 +58,7 @@ while(event is not None):
 			print("sched_switch prev_comm: {}".format(prev_comm))
 
 	if event.get_name() == "exit_syscall":
-		ret_field = event.get_field("_ret")
+		ret_field = event.get_field("ret")
 		if ret_field is None:
 			print("ERROR: Unable to extract ret")
 		else:
diff --git a/bindings/python/examples/sched_switch.py b/bindings/python/examples/sched_switch.py
index 83c191f..6196e48 100644
--- a/bindings/python/examples/sched_switch.py
+++ b/bindings/python/examples/sched_switch.py
@@ -57,7 +57,7 @@ while event is not None:
 				break # Next event
 
 			# Getting PID
-			pid_field = event.get_field_with_scope(sco, "_pid")
+			pid_field = event.get_field_with_scope(sco, "pid")
 			pid = pid_field.get_int64()
 
 			if ctf.field_error():
@@ -70,43 +70,43 @@ while event is not None:
 			sco = event.get_top_level_scope(ctf.scope.EVENT_FIELDS)
 
 			# prev_comm
-			field = event.get_field_with_scope(sco, "_prev_comm")
+			field = event.get_field_with_scope(sco, "prev_comm")
 			prev_comm = field.get_char_array()
 			if ctf.field_error():
 				print("ERROR: Missing prev_comm context info")
 
 			# prev_tid
-			field = event.get_field_with_scope(sco, "_prev_tid")
+			field = event.get_field_with_scope(sco, "prev_tid")
 			prev_tid = field.get_int64()
 			if ctf.field_error():
 				print("ERROR: Missing prev_tid context info")
 
 			# prev_prio
-			field = event.get_field_with_scope(sco, "_prev_prio")
+			field = event.get_field_with_scope(sco, "prev_prio")
 			prev_prio = field.get_int64()
 			if ctf.field_error():
 				print("ERROR: Missing prev_prio context info")
 
 			# prev_state
-			field = event.get_field_with_scope(sco, "_prev_state")
+			field = event.get_field_with_scope(sco, "prev_state")
 			prev_state = field.get_int64()
 			if ctf.field_error():
 				print("ERROR: Missing prev_state context info")
 
 			# next_comm
-			field = event.get_field_with_scope(sco, "_next_comm")
+			field = event.get_field_with_scope(sco, "next_comm")
 			next_comm = field.get_char_array()
 			if ctf.field_error():
 				print("ERROR: Missing next_comm context info")
 
 			# next_tid
-			field = event.get_field_with_scope(sco, "_next_tid")
+			field = event.get_field_with_scope(sco, "next_tid")
 			next_tid = field.get_int64()
 			if ctf.field_error():
 				print("ERROR: Missing next_tid context info")
 
 			# next_prio
-			field = event.get_field_with_scope(sco, "_next_prio")
+			field = event.get_field_with_scope(sco, "next_prio")
 			next_prio = field.get_int64()
 			if ctf.field_error():
 				print("ERROR: Missing next_prio context info")
-- 
1.7.1
