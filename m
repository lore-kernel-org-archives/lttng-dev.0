From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 05/18] namespace the array functions
Date: Thu, 24 Jan 2013 16:21:37 -0500
Message-ID: <1359062510-7557-5-git-send-email-jdesfossez__22133.8815907531$1359062595$gmane$org@efficios.com>
References: <1359062510-7557-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TyUFL-0008EN-2D
	for lttng-dev@lists.lttng.org; Thu, 24 Jan 2013 16:22:07 -0500
In-Reply-To: <1359062510-7557-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 formats/ctf-text/types/array.c                        |    4 ++--
 formats/ctf/ctf.c                                     |    4 ++--
 formats/ctf/events.c                                  |    4 ++--
 formats/ctf/metadata/ctf-visitor-generate-io-struct.c |    2 +-
 formats/ctf/types/array.c                             |    4 ++--
 include/babeltrace/types.h                            |   12 ++++++------
 types/array.c                                         |   12 ++++++------
 7 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/formats/ctf-text/types/array.c b/formats/ctf-text/types/array.c
index 97b557f..e2ed7b3 100644
--- a/formats/ctf-text/types/array.c
+++ b/formats/ctf-text/types/array.c
@@ -63,7 +63,7 @@ int ctf_text_array_write(struct stream_pos *ppos, struct definition *definition)
 			    && integer_declaration->p.alignment == CHAR_BIT)) {
 				pos->string = array_definition->string;
 				g_string_assign(array_definition->string, "");
-				ret = array_rw(ppos, definition);
+				ret = bt_array_rw(ppos, definition);
 				pos->string = NULL;
 			}
 			fprintf(pos->fp, "\"%s\"", array_definition->string->str);
@@ -77,7 +77,7 @@ int ctf_text_array_write(struct stream_pos *ppos, struct definition *definition)
 	}
 	field_nr_saved = pos->field_nr;
 	pos->field_nr = 0;
-	ret = array_rw(ppos, definition);
+	ret = bt_array_rw(ppos, definition);
 	if (!pos->dummy) {
 		pos->depth--;
 		fprintf(pos->fp, " ]");
diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index a55f5e4..e18fffb 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -1338,12 +1338,12 @@ int create_stream_packet_index(struct ctf_trace *td,
 				field = struct_definition_get_field_from_index(file_stream->parent.trace_packet_header, len_index);
 				assert(field->declaration->id == CTF_TYPE_ARRAY);
 				defarray = container_of(field, struct definition_array, p);
-				assert(array_len(defarray) == BABELTRACE_UUID_LEN);
+				assert(bt_array_len(defarray) == BABELTRACE_UUID_LEN);
 
 				for (i = 0; i < BABELTRACE_UUID_LEN; i++) {
 					struct definition *elem;
 
-					elem = array_index(defarray, i);
+					elem = bt_array_index(defarray, i);
 					uuidval[i] = get_unsigned_int(elem);
 				}
 				ret = babeltrace_uuid_compare(td->uuid, uuidval);
diff --git a/formats/ctf/events.c b/formats/ctf/events.c
index ac7dce4..b530cd5 100644
--- a/formats/ctf/events.c
+++ b/formats/ctf/events.c
@@ -140,7 +140,7 @@ const struct definition *bt_ctf_get_index(const struct bt_ctf_event *ctf_event,
 		struct definition_array *array_definition;
 		array_definition = container_of(field,
 				struct definition_array, p);
-		ret = array_index(array_definition, index);
+		ret = bt_array_index(array_definition, index);
 	} else if (bt_ctf_field_type(bt_ctf_get_decl_from_def(field)) == CTF_TYPE_SEQUENCE) {
 		struct definition_sequence *sequence_definition;
 		sequence_definition = container_of(field,
@@ -584,7 +584,7 @@ char *bt_ctf_get_char_array(const struct definition *field)
 	GString *char_array;
 
 	if (field && bt_ctf_field_type(bt_ctf_get_decl_from_def(field)) == CTF_TYPE_ARRAY) {
-		char_array = get_char_array(field);
+		char_array = bt_get_char_array(field);
 		if (char_array) {
 			ret = char_array->str;
 			goto end;
diff --git a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
index c32aa99..97d15e7 100644
--- a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
+++ b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
@@ -509,7 +509,7 @@ struct declaration *ctf_type_declarator_visit(FILE *fd, int depth,
 			size_t len;
 
 			len = first->u.unary_expression.u.unsigned_constant;
-			array_declaration = array_declaration_new(len, nested_declaration,
+			array_declaration = bt_array_declaration_new(len, nested_declaration,
 						declaration_scope);
 
 			if (!array_declaration) {
diff --git a/formats/ctf/types/array.c b/formats/ctf/types/array.c
index d5b6ed4..006f0ce 100644
--- a/formats/ctf/types/array.c
+++ b/formats/ctf/types/array.c
@@ -61,7 +61,7 @@ int ctf_array_read(struct stream_pos *ppos, struct definition *definition)
 			}
 		}
 	}
-	return array_rw(ppos, definition);
+	return bt_array_rw(ppos, definition);
 }
 
 int ctf_array_write(struct stream_pos *ppos, struct definition *definition)
@@ -96,5 +96,5 @@ int ctf_array_write(struct stream_pos *ppos, struct definition *definition)
 			}
 		}
 	}
-	return array_rw(ppos, definition);
+	return bt_array_rw(ppos, definition);
 }
diff --git a/include/babeltrace/types.h b/include/babeltrace/types.h
index 772abb2..3b45fd5 100644
--- a/include/babeltrace/types.h
+++ b/include/babeltrace/types.h
@@ -488,13 +488,13 @@ int variant_rw(struct stream_pos *pos, struct definition *definition);
  * array.
  */
 struct declaration_array *
-	array_declaration_new(size_t len, struct declaration *elem_declaration,
+	bt_array_declaration_new(size_t len, struct declaration *elem_declaration,
 		struct declaration_scope *parent_scope);
-uint64_t array_len(struct definition_array *array);
-struct definition *array_index(struct definition_array *array, uint64_t i);
-int array_rw(struct stream_pos *pos, struct definition *definition);
-GString *get_char_array(const struct definition *field);
-int get_array_len(const struct definition *field);
+uint64_t bt_array_len(struct definition_array *array);
+struct definition *bt_array_index(struct definition_array *array, uint64_t i);
+int bt_array_rw(struct stream_pos *pos, struct definition *definition);
+GString *bt_get_char_array(const struct definition *field);
+int bt_get_array_len(const struct definition *field);
 
 /*
  * int_declaration and elem_declaration passed as parameter now belong
diff --git a/types/array.c b/types/array.c
index 4942108..d2db46f 100644
--- a/types/array.c
+++ b/types/array.c
@@ -38,7 +38,7 @@ struct definition *_array_definition_new(struct declaration *declaration,
 static
 void _array_definition_free(struct definition *definition);
 
-int array_rw(struct stream_pos *pos, struct definition *definition)
+int bt_array_rw(struct stream_pos *pos, struct definition *definition)
 {
 	struct definition_array *array_definition =
 		container_of(definition, struct definition_array, p);
@@ -70,7 +70,7 @@ void _array_declaration_free(struct declaration *declaration)
 }
 
 struct declaration_array *
-	array_declaration_new(size_t len,
+	bt_array_declaration_new(size_t len,
 			      struct declaration *elem_declaration,
 			      struct declaration_scope *parent_scope)
 {
@@ -198,14 +198,14 @@ void _array_definition_free(struct definition *definition)
 	g_free(array);
 }
 
-uint64_t array_len(struct definition_array *array)
+uint64_t bt_array_len(struct definition_array *array)
 {
 	if (!array->elems)
 		return array->string->len;
 	return array->elems->len;
 }
 
-struct definition *array_index(struct definition_array *array, uint64_t i)
+struct definition *bt_array_index(struct definition_array *array, uint64_t i)
 {
 	if (!array->elems)
 		return NULL;
@@ -214,7 +214,7 @@ struct definition *array_index(struct definition_array *array, uint64_t i)
 	return g_ptr_array_index(array->elems, i);
 }
 
-int get_array_len(const struct definition *field)
+int bt_get_array_len(const struct definition *field)
 {
 	struct definition_array *array_definition;
 	struct declaration_array *array_declaration;
@@ -225,7 +225,7 @@ int get_array_len(const struct definition *field)
 	return array_declaration->len;
 }
 
-GString *get_char_array(const struct definition *field)
+GString *bt_get_char_array(const struct definition *field)
 {
 	struct definition_array *array_definition;
 	struct declaration_array *array_declaration;
-- 
1.7.10.4
