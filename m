From: Xiaona Han <xiaonahappy13@163.com>
Subject: [PATCH babeltrace] Return event fields by a field name.
	Since a field may be present both in an event and its
	stream's scope,
	this returns a list which contains all the fileds by the name
Date: Wed, 24 Jul 2013 17:57:46 +0800
Message-ID: <1374659868-6264-1-git-send-email-xiaonahappy13__1115.31935767761$1374631278$gmane$org@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [124.16.141.1] (helo=host.localdomain)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <root@host.localdomain>) id 1V1oLB-00023C-AF
	for lttng-dev@lists.lttng.org; Tue, 23 Jul 2013 21:58:19 -0400
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
 bindings/python/babeltrace.i.in |   78 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 75 insertions(+), 3 deletions(-)
 mode change 100644 => 100755 bindings/python/babeltrace.i.in

diff --git a/bindings/python/babeltrace.i.in b/bindings/python/babeltrace.i.in
old mode 100644
new mode 100755
index dd2dacc..880b23e
--- a/bindings/python/babeltrace.i.in
+++ b/bindings/python/babeltrace.i.in
@@ -744,7 +744,7 @@ class ctf:
 			"""
 			return _bt_ctf_get_timestamp(self._e)
 
-		def get_field(self, scope, field):
+		def get_field_with_scope(self, scope, field):
 			"""Return the definition of a specific field."""
 			evDef = ctf.Definition.__new__(ctf.Definition)
 			try:
@@ -754,9 +754,32 @@ class ctf:
 					"Definition (scope) instance")
 			return evDef
 
-		def get_field_list(self, scope):
+		def get_field(self, field):
+			"""Return the definition of fields by a name"""
+			eventScope = self.get_top_level_scope(ctf.scope.EVENT_FIELDS)
+			streamScope = self.get_top_level_scope(ctf.scope.STREAM_EVENT_CONTEXT)
+			fields_by_name = []
+
+			if eventScope is not None:
+				evDef = ctf.Definition.__new__(ctf.Definition)
+				evDef._d = _bt_ctf_get_field(self._e, eventScope._d, field)
+
+				if evDef._d is not None:
+					evDef._s = eventScope
+					fields_by_name.append(evDef);
+
+			if streamScope is not None:
+				stDef = ctf.Definition.__new__(ctf.Definition)
+				stDef._d = _bt_ctf_get_field(self._e, streamScope._d, field)
+
+				if stDef._d is not None:
+					stDef._s = streamScope
+					fields_by_name.append(stDef);
+			return fields_by_name
+
+		def get_field_list_with_scope(self, scope):
 			"""
-			Return a list of Definitions
+			Return a list of Definitions by a scope
 			Return None on error.
 			"""
 			try:
@@ -783,6 +806,51 @@ class ctf:
 				i += 1
 			return def_list
 
+		def get_field_list(self):
+			"""
+			Return a list of Definitions
+			Return None on error.
+			"""
+			event_field_lc = None
+			stream_field_lc = None
+			eventScope = self.get_top_level_scope(ctf.scope.EVENT_FIELDS)
+			streamScope = self.get_top_level_scope(ctf.scope.STREAM_EVENT_CONTEXT)
+
+			if eventScope is not None:
+				event_field_lc = _bt_python_field_listcaller(self._e, eventScope._d)
+			if streamScope is not None:
+				stream_field_lc = _bt_python_field_listcaller(self._e, streamScope._d)
+
+			if event_field_lc is None and stream_field_lc is None:
+				return None
+
+			def_list = []
+			if event_field_lc is not None:
+				i = 0
+				while True:
+					tmp = ctf.Definition.__new__(ctf.Definition)
+					tmp._d = _bt_python_field_one_from_list(event_field_lc, i)
+					if tmp._d is None:
+ 					#Last item of list is None, assured in
+ 					#_bt_python_field_listcaller
+						break
+					tmp._s = eventScope
+					def_list.append(tmp)
+					i += 1
+			if stream_field_lc is not None:
+				i = 0
+				while True:
+					tmp = ctf.Definition.__new__(ctf.Definition)
+					tmp._d = _bt_python_field_one_from_list(stream_field_lc, i)
+					if tmp._d is None:
+					#Last item of list is None, assured in
+					#_bt_python_field_listcaller
+						break
+					tmp._s = streamScope
+					def_list.append(tmp)
+					i += 1
+			return def_list
+
 		def get_index(self, field, index):
 			"""
 			If the field is an array or a sequence, return the element
@@ -918,6 +986,10 @@ class ctf:
 			"""
 			return _bt_ctf_get_string(self._d)
 
+		def get_scope(self):
+			"""Return the scope of a field or None on error."""
+			return self._s
+
 
 	class EventDecl(object):
 		"""Event declaration class.  Do not instantiate."""
-- 
1.7.1
