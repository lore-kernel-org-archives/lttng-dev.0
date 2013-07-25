From: Xiaona Han <xiaonahappy13@163.com>
Subject: [PATCH babeltrace] Return event fields by a field name
Date: Fri, 26 Jul 2013 07:56:04 +0800
Message-ID: <1374796564-9059-1-git-send-email-xiaonahappy13__47765.7493822791$1374767852$gmane$org@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [124.16.141.1] (helo=host.localdomain)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <root@host.localdomain>) id 1V2Nty-0004Sk-Cg
	for lttng-dev@lists.lttng.org; Thu, 25 Jul 2013 11:56:32 -0400
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

Since a field may be present both in an event and its stream's scope, this returns
a list which contains all the fileds by the name. The examples are also changed
according to this API.

Signed-off-by: Xiaona Han <xiaonahappy13@163.com>
---
 bindings/python/babeltrace.i.in              |   61 ++++++++++++++++++++++++--
 bindings/python/examples/example-api-test.py |   16 +++----
 bindings/python/examples/sched_switch.py     |   16 +++---
 3 files changed, 71 insertions(+), 22 deletions(-)

diff --git a/bindings/python/babeltrace.i.in b/bindings/python/babeltrace.i.in
index dd2dacc..c478dfc 100644
--- a/bindings/python/babeltrace.i.in
+++ b/bindings/python/babeltrace.i.in
@@ -744,19 +744,48 @@ class ctf:
 			"""
 			return _bt_ctf_get_timestamp(self._e)
 
-		def get_field(self, scope, field):
-			"""Return the definition of a specific field."""
+		def get_field_with_scope(self, scope, field):
+			"""
+			Return the definition of a specific field.
+			Return None on error.
+			"""
 			evDef = ctf.Definition.__new__(ctf.Definition)
 			try:
 				evDef._d = _bt_ctf_get_field(self._e, scope._d, field)
 			except AttributeError:
 				raise TypeError("in get_field, argument 2 must be a "
 					"Definition (scope) instance")
+			if evDef._d is None:
+				return None
+			evDef._s = scope
 			return evDef
 
-		def get_field_list(self, scope):
+		def get_field(self, field):
+			"""
+			Return the definition of fields by a name
+			Return None on error
+			"""
+			eventScope = self.get_top_level_scope(ctf.scope.EVENT_FIELDS)
+			streamScope = self.get_top_level_scope(ctf.scope.STREAM_EVENT_CONTEXT)
+			fields_by_name = []
+
+			if eventScope is not None:
+				evDef = self.get_field_with_scope(eventScope, field)
+				if evDef is not None:
+					fields_by_name.append(evDef)
+
+			if streamScope is not None:
+				evDef = self.get_field_with_scope(streamScope, field)
+				if evDef is not None:
+					fields_by_name.append(evDef);
+
+			if not fields_by_name:
+				return None
+			return fields_by_name
+
+		def get_field_list_with_scope(self, scope):
 			"""
-			Return a list of Definitions
+			Return a list of Definitions associated with the scope
 			Return None on error.
 			"""
 			try:
@@ -779,10 +808,31 @@ class ctf:
 					#_bt_python_field_listcaller
 					break
 
+				tmp._s = scope
 				def_list.append(tmp)
 				i += 1
 			return def_list
 
+		def get_field_list(self):
+			"""Return a list of Definitions or None on error."""
+			eventScope = self.get_top_level_scope(ctf.scope.EVENT_FIELDS)
+			streamScope = self.get_top_level_scope(ctf.scope.STREAM_EVENT_CONTEXT)
+
+			def_list = []
+			if eventScope is not None:
+				event_field_list = self.get_field_list_with_scope(eventScope)
+				if event_field_list is not None:
+					def_list = event_field_list
+
+			if streamScope is not None:
+				event_field_list = self.get_field_list_with_scope(streamScope)
+				if event_field_list is not None:
+					def_list.extend(event_field_list)
+
+			if not def_list:
+				return None
+			return def_list
+
 		def get_index(self, field, index):
 			"""
 			If the field is an array or a sequence, return the element
@@ -918,6 +968,9 @@ class ctf:
 			"""
 			return _bt_ctf_get_string(self._d)
 
+		def get_scope(self):
+			"""Return the scope of a field or None on error."""
+			return self._s
 
 	class EventDecl(object):
 		"""Event declaration class.  Do not instantiate."""
diff --git a/bindings/python/examples/example-api-test.py b/bindings/python/examples/example-api-test.py
index fc59e24..5846fac 100644
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
+		if prev_field is None:
 			print("ERROR: Missing prev_comm context info")
 		else:
+			prev_comm = prev_field[0].get_char_array()
 			print("sched_switch prev_comm: {}".format(prev_comm))
 
 	if event.get_name() == "exit_syscall":
-		sco = event.get_top_level_scope(ctf.scope.EVENT_FIELDS)
-		ret_field = event.get_field(sco, "_ret")
-		ret_code = ret_field.get_int64()
-
-		if ctf.field_error():
+		ret_field = event.get_field("_ret")
+		if ret_field is None:
 			print("ERROR: Unable to extract ret")
 		else:
+			ret_code = ret_field[0].get_int64()
 			print("exit_syscall ret: {}".format(ret_code))
 
 	ret = ctf_it.next()
diff --git a/bindings/python/examples/sched_switch.py b/bindings/python/examples/sched_switch.py
index d5ed25b..83c191f 100644
--- a/bindings/python/examples/sched_switch.py
+++ b/bindings/python/examples/sched_switch.py
@@ -57,7 +57,7 @@ while event is not None:
 				break # Next event
 
 			# Getting PID
-			pid_field = event.get_field(sco, "_pid")
+			pid_field = event.get_field_with_scope(sco, "_pid")
 			pid = pid_field.get_int64()
 
 			if ctf.field_error():
@@ -70,43 +70,43 @@ while event is not None:
 			sco = event.get_top_level_scope(ctf.scope.EVENT_FIELDS)
 
 			# prev_comm
-			field = event.get_field(sco, "_prev_comm")
+			field = event.get_field_with_scope(sco, "_prev_comm")
 			prev_comm = field.get_char_array()
 			if ctf.field_error():
 				print("ERROR: Missing prev_comm context info")
 
 			# prev_tid
-			field = event.get_field(sco, "_prev_tid")
+			field = event.get_field_with_scope(sco, "_prev_tid")
 			prev_tid = field.get_int64()
 			if ctf.field_error():
 				print("ERROR: Missing prev_tid context info")
 
 			# prev_prio
-			field = event.get_field(sco, "_prev_prio")
+			field = event.get_field_with_scope(sco, "_prev_prio")
 			prev_prio = field.get_int64()
 			if ctf.field_error():
 				print("ERROR: Missing prev_prio context info")
 
 			# prev_state
-			field = event.get_field(sco, "_prev_state")
+			field = event.get_field_with_scope(sco, "_prev_state")
 			prev_state = field.get_int64()
 			if ctf.field_error():
 				print("ERROR: Missing prev_state context info")
 
 			# next_comm
-			field = event.get_field(sco, "_next_comm")
+			field = event.get_field_with_scope(sco, "_next_comm")
 			next_comm = field.get_char_array()
 			if ctf.field_error():
 				print("ERROR: Missing next_comm context info")
 
 			# next_tid
-			field = event.get_field(sco, "_next_tid")
+			field = event.get_field_with_scope(sco, "_next_tid")
 			next_tid = field.get_int64()
 			if ctf.field_error():
 				print("ERROR: Missing next_tid context info")
 
 			# next_prio
-			field = event.get_field(sco, "_next_prio")
+			field = event.get_field_with_scope(sco, "_next_prio")
 			next_prio = field.get_int64()
 			if ctf.field_error():
 				print("ERROR: Missing next_prio context info")
-- 
1.7.1
