From: Xiaona Han <xiaonahappy13@163.com>
Subject: [PATCH babeltrace] Use a unique name to get a field's
	value
Date: Fri, 26 Jul 2013 18:32:36 +0800
Message-ID: <1374834756-8782-1-git-send-email-xiaonahappy13__34375.9863907055$1374806023$gmane$org@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [124.16.141.1] (helo=host.localdomain)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <root@host.localdomain>) id 1V2Xpv-00043x-Sp
	for lttng-dev@lists.lttng.org; Thu, 25 Jul 2013 22:33:00 -0400
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

Use get_value to get a field's value. Currently it does not support
compound types. Also it does not support floating point, since getting
a float's value is not implemented in babeltrace now.

Signed-off-by: Xiaona Han <xiaonahappy13@163.com>
---
 bindings/python/babeltrace.i.in              |   19 ++++++++++++++
 bindings/python/examples/example-api-test.py |   10 ++++---
 bindings/python/examples/sched_switch.py     |   34 ++++++++++++-------------
 3 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/bindings/python/babeltrace.i.in b/bindings/python/babeltrace.i.in
index d307fdb..98eea9b 100644
--- a/bindings/python/babeltrace.i.in
+++ b/bindings/python/babeltrace.i.in
@@ -979,6 +979,25 @@ class ctf:
 			"""
 			return _bt_ctf_get_string(self._d)
 
+		def get_value(self):
+			"""
+			Return the value associated with the field according to its type.
+			Return None on error.
+			"""
+			id = self.field_type()
+			if id == ctf.type_id.STRING:
+				return self.get_str()
+			if id == ctf.type_id.ARRAY:
+				return self.get_char_array()
+			if id == ctf.type_id.INTEGER:
+				if self.get_int_signedness == 0:
+					return self.get_uint64()
+				else:
+					return self.get_int64()
+			if id == ctf.type_id.ENUM:
+				return self.get_enum_str()
+			return None
+
 		def get_scope(self):
 			"""Return the scope of a field or None on error."""
 			return self._s
diff --git a/bindings/python/examples/example-api-test.py b/bindings/python/examples/example-api-test.py
index 66754ba..d6b48ff 100644
--- a/bindings/python/examples/example-api-test.py
+++ b/bindings/python/examples/example-api-test.py
@@ -54,16 +54,18 @@ while(event is not None):
 		if prev_field is None:
 			print("ERROR: Missing prev_comm context info")
 		else:
-			prev_comm = prev_field[0].get_char_array()
-			print("sched_switch prev_comm: {}".format(prev_comm))
+			prev_comm = prev_field[0].get_value()
+			if prev_comm is not None:
+				print("sched_switch prev_comm: {}".format(prev_comm))
 
 	if event.get_name() == "exit_syscall":
 		ret_field = event.get_field("ret")
 		if ret_field is None:
 			print("ERROR: Unable to extract ret")
 		else:
-			ret_code = ret_field[0].get_int64()
-			print("exit_syscall ret: {}".format(ret_code))
+			ret_code = ret_field[0].get_value()
+			if ret_code is not None:
+				print("exit_syscall ret: {}".format(ret_code))
 
 	ret = ctf_it.next()
 	if ret < 0:
diff --git a/bindings/python/examples/sched_switch.py b/bindings/python/examples/sched_switch.py
index 6196e48..9ab2b10 100644
--- a/bindings/python/examples/sched_switch.py
+++ b/bindings/python/examples/sched_switch.py
@@ -58,12 +58,10 @@ while event is not None:
 
 			# Getting PID
 			pid_field = event.get_field_with_scope(sco, "pid")
-			pid = pid_field.get_int64()
-
-			if ctf.field_error():
+			if pid_field is None:
 				print("ERROR: Missing PID info for sched_switch")
 				break # Next event
-
+			pid = pid_field.get_value()
 			if usePID and (pid != long(sys.argv[1])):
 				break # Next event
 
@@ -71,45 +69,45 @@ while event is not None:
 
 			# prev_comm
 			field = event.get_field_with_scope(sco, "prev_comm")
-			prev_comm = field.get_char_array()
-			if ctf.field_error():
+			if field is None:
 				print("ERROR: Missing prev_comm context info")
+			prev_comm = field.get_value()
 
 			# prev_tid
 			field = event.get_field_with_scope(sco, "prev_tid")
-			prev_tid = field.get_int64()
-			if ctf.field_error():
+			if field is None:
 				print("ERROR: Missing prev_tid context info")
+			prev_tid = field.get_value()
 
 			# prev_prio
 			field = event.get_field_with_scope(sco, "prev_prio")
-			prev_prio = field.get_int64()
-			if ctf.field_error():
+			if field is None:
 				print("ERROR: Missing prev_prio context info")
+			prev_prio = field.get_value()
 
 			# prev_state
 			field = event.get_field_with_scope(sco, "prev_state")
-			prev_state = field.get_int64()
-			if ctf.field_error():
+			if field is None:
 				print("ERROR: Missing prev_state context info")
+			prev_state = field.get_value()
 
 			# next_comm
 			field = event.get_field_with_scope(sco, "next_comm")
-			next_comm = field.get_char_array()
-			if ctf.field_error():
+			if field is None:
 				print("ERROR: Missing next_comm context info")
+			next_comm = field.get_value()
 
 			# next_tid
 			field = event.get_field_with_scope(sco, "next_tid")
-			next_tid = field.get_int64()
-			if ctf.field_error():
+			if field is None:
 				print("ERROR: Missing next_tid context info")
+			next_tid = field.get_value()
 
 			# next_prio
 			field = event.get_field_with_scope(sco, "next_prio")
-			next_prio = field.get_int64()
-			if ctf.field_error():
+			if field is None:
 				print("ERROR: Missing next_prio context info")
+			next_prio = field.get_value()
 
 			# Output
 			print("sched_switch, pid = {}, TS = {}, prev_comm = {},\n\t"
-- 
1.7.1
