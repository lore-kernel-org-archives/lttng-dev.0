From: Xiaona Han <xiaonahappy13@163.com>
Subject: [PATCH babeltrace 2/3] Support for the sequence type
Date: Sat,  3 Aug 2013 05:42:33 +0800
Message-ID: <1375479754-22999-2-git-send-email-xiaonahappy13__23406.9070349962$1375451030$gmane$org@163.com>
References: <1375479754-22999-1-git-send-email-xiaonahappy13@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [124.16.141.1] (helo=host.localdomain)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <root@host.localdomain>) id 1V5FdA-0008Po-Kz
	for lttng-dev@lists.lttng.org; Fri, 02 Aug 2013 09:43:01 -0400
In-Reply-To: <1375479754-22999-1-git-send-email-xiaonahappy13@163.com>
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

Add support for getting a sequence's valule in the python binding.

Signed-off-by: Xiaona Han <xiaonahappy13@163.com>
---
 bindings/python/babeltrace.i.in      |   34 ++++++++++++++++++++++++++++++++++
 bindings/python/python-complements.c |    8 ++++++++
 bindings/python/python-complements.h |    2 ++
 3 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/bindings/python/babeltrace.i.in b/bindings/python/babeltrace.i.in
index 98eea9b..209285e 100644
--- a/bindings/python/babeltrace.i.in
+++ b/bindings/python/babeltrace.i.in
@@ -575,6 +575,8 @@ struct bt_ctf_event *bt_ctf_iter_read_event(struct bt_ctf_iter *iter);
 		const struct bt_ctf_field_decl *field);
 %rename("_bt_ctf_get_decl_from_def") bt_ctf_get_decl_from_def(
 		const struct bt_definition *field);
+%rename("_bt_sequence_len")  bt_sequence_len(struct definition_sequence *sequence);
+%rename("_bt_sequence_index") bt_sequence_index(struct definition_sequence *sequence, uint64_t i);
 
 const struct bt_definition *bt_ctf_get_top_level_scope(const struct bt_ctf_event *ctf_event,
 		enum bt_ctf_scope scope);
@@ -605,6 +607,8 @@ int bt_ctf_field_get_error(void);
 const char *bt_ctf_get_decl_event_name(const struct bt_ctf_event_decl *event);
 const char *bt_ctf_get_decl_field_name(const struct bt_ctf_field_decl *field);
 const struct bt_declaration *bt_ctf_get_decl_from_def(const struct bt_definition *field);
+uint64_t bt_sequence_len(struct definition_sequence *sequence);
+struct bt_definition *bt_sequence_index(struct definition_sequence *sequence, uint64_t i);
 
 %pythoncode%{
 
@@ -943,6 +947,27 @@ class ctf:
 			"""
 			return _bt_ctf_get_array_len(_bt_ctf_get_decl_from_def(self._d))
 
+		def get_sequence_len(self):
+			"""
+			Return the len of a sequence or a negative
+			value on error.
+			"""
+			seq = _bt_python_from_def_to_sequence(self._d)
+			return _bt_sequence_len(seq)
+
+		def get_sequence_index(self, index):
+			"""
+			Return the sequence's element at position index,
+			otherwise return None
+			"""
+			seq = _bt_python_from_def_to_sequence(self._d)
+			if seq is not None:
+				evDef = ctf.Definition.__new__(ctf.Definition)
+				evDef._d = _bt_sequence_index(seq, index)
+				if evDef._d is not None:
+					return evDef
+			return None
+
 		def get_uint64(self):
 			"""
 			Return the value associated with the field.
@@ -996,6 +1021,15 @@ class ctf:
 					return self.get_int64()
 			if id == ctf.type_id.ENUM:
 				return self.get_enum_str()
+			if id == ctf.type_id.SEQUENCE:
+				seq_len = self.get_sequence_len()
+				i = 0
+				values = []
+				while (i < seq_len):
+					evDef = self.get_sequence_index(i)
+					values.append(evDef.get_value())
+					i += 1
+				return values
 			return None
 
 		def get_scope(self):
diff --git a/bindings/python/python-complements.c b/bindings/python/python-complements.c
index aa65555..612903b 100644
--- a/bindings/python/python-complements.c
+++ b/bindings/python/python-complements.c
@@ -119,3 +119,11 @@ struct bt_ctf_field_decl *_bt_python_field_decl_one_from_list(
 {
 	return list[index];
 }
+struct definition_sequence *_bt_python_from_def_to_sequence(
+		struct bt_definition *field)
+{
+	if (field && bt_ctf_field_type(
+		bt_ctf_get_decl_from_def(field)) == CTF_TYPE_SEQUENCE)
+		return container_of(field, struct definition_sequence, p);
+	return NULL;
+}
diff --git a/bindings/python/python-complements.h b/bindings/python/python-complements.h
index 4335d8a..37b37e3 100644
--- a/bindings/python/python-complements.h
+++ b/bindings/python/python-complements.h
@@ -50,3 +50,5 @@ struct bt_ctf_field_decl **_by_python_field_decl_listcaller(
 		enum bt_ctf_scope scope);
 struct bt_ctf_field_decl *_bt_python_field_decl_one_from_list(
 		struct bt_ctf_field_decl **list, int index);
+struct definition_sequence *_bt_python_from_def_to_sequence(
+		struct bt_definition *field);
-- 
1.7.1
