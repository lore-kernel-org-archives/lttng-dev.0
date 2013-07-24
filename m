From: Xiaona Han <xiaonahappy13@163.com>
Subject: [PATCH babeltrace] Make examples work
Date: Wed, 24 Jul 2013 17:57:48 +0800
Message-ID: <1374659868-6264-3-git-send-email-xiaonahappy13__9514.40038993514$1374631208$gmane$org@163.com>
References: <1374659868-6264-1-git-send-email-xiaonahappy13@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [124.16.141.1] (helo=host.localdomain)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <root@host.localdomain>) id 1V1oLB-00023E-AE
	for lttng-dev@lists.lttng.org; Tue, 23 Jul 2013 21:58:15 -0400
In-Reply-To: <1374659868-6264-1-git-send-email-xiaonahappy13@163.com>
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

Signed-off-by: Xiaona Han <xiaonahappy13@163.com>
---
 bindings/python/examples/example-api-test.py |   16 +++++--------
 bindings/python/examples/sched_switch.py     |   32 +++++++++++++-------------
 2 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/bindings/python/examples/example-api-test.py b/bindings/python/examples/example-api-test.py
index fc59e24..3c3527c 100644
--- a/bindings/python/examples/example-api-test.py
+++ b/bindings/python/examples/example-api-test.py
@@ -50,23 +50,19 @@ while(event is not None):
 		event.get_cycles(), event.get_name()))
 
 	if event.get_name() == "sched_switch":
-		sco = event.get_top_level_scope(ctf.scope.EVENT_FIELDS)
-		prev_field = event.get_field(sco, "_prev_comm")
-		prev_comm = prev_field.get_char_array()
-
-		if ctf.field_error():
+		prev_field = event.get_field("_prev_comm")
+		if not prev_field:
 			print("ERROR: Missing prev_comm context info")
 		else:
+			prev_comm = prev_field[0].getvalue()
 			print("sched_switch prev_comm: {}".format(prev_comm))
 
 	if event.get_name() == "exit_syscall":
-		sco = event.get_top_level_scope(ctf.scope.EVENT_FIELDS)
-		ret_field = event.get_field(sco, "_ret")
-		ret_code = ret_field.get_int64()
-
-		if ctf.field_error():
+		ret_field = event.get_field("_ret")
+		if not ret_field:
 			print("ERROR: Unable to extract ret")
 		else:
+			ret_code = ret_field[0].get_value()
 			print("exit_syscall ret: {}".format(ret_code))
 
 	ret = ctf_it.next()
diff --git a/bindings/python/examples/sched_switch.py b/bindings/python/examples/sched_switch.py
index d5ed25b..0e6947c 100644
--- a/bindings/python/examples/sched_switch.py
+++ b/bindings/python/examples/sched_switch.py
@@ -57,8 +57,8 @@ while event is not None:
 				break # Next event
 
 			# Getting PID
-			pid_field = event.get_field(sco, "_pid")
-			pid = pid_field.get_int64()
+			pid_field = event.get_field_with_scope(sco, "_pid")
+			pid = pid_field.get_value()
 
 			if ctf.field_error():
 				print("ERROR: Missing PID info for sched_switch")
@@ -70,44 +70,44 @@ while event is not None:
 			sco = event.get_top_level_scope(ctf.scope.EVENT_FIELDS)
 
 			# prev_comm
-			field = event.get_field(sco, "_prev_comm")
-			prev_comm = field.get_char_array()
+			field = event.get_field_with_scope(sco, "_prev_comm")
+			prev_comm = field.get_value()
 			if ctf.field_error():
 				print("ERROR: Missing prev_comm context info")
 
 			# prev_tid
-			field = event.get_field(sco, "_prev_tid")
-			prev_tid = field.get_int64()
+			field = event.get_field_with_scope(sco, "_prev_tid")
+			prev_tid = field.get_value()
 			if ctf.field_error():
 				print("ERROR: Missing prev_tid context info")
 
 			# prev_prio
-			field = event.get_field(sco, "_prev_prio")
-			prev_prio = field.get_int64()
+			field = event.get_field_with_scope(sco, "_prev_prio")
+			prev_prio = field.get_value()
 			if ctf.field_error():
 				print("ERROR: Missing prev_prio context info")
 
 			# prev_state
-			field = event.get_field(sco, "_prev_state")
-			prev_state = field.get_int64()
+			field = event.get_field_with_scope(sco, "_prev_state")
+			prev_state = field.get_value()
 			if ctf.field_error():
 				print("ERROR: Missing prev_state context info")
 
 			# next_comm
-			field = event.get_field(sco, "_next_comm")
-			next_comm = field.get_char_array()
+			field = event.get_field_with_scope(sco, "_next_comm")
+			next_comm = field.get_value()
 			if ctf.field_error():
 				print("ERROR: Missing next_comm context info")
 
 			# next_tid
-			field = event.get_field(sco, "_next_tid")
-			next_tid = field.get_int64()
+			field = event.get_field_with_scope(sco, "_next_tid")
+			next_tid = field.get_value()
 			if ctf.field_error():
 				print("ERROR: Missing next_tid context info")
 
 			# next_prio
-			field = event.get_field(sco, "_next_prio")
-			next_prio = field.get_int64()
+			field = event.get_field_with_scope(sco, "_next_prio")
+			next_prio = field.get_value()
 			if ctf.field_error():
 				print("ERROR: Missing next_prio context info")
 
-- 
1.7.1
