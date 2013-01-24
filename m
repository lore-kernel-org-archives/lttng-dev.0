From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 12/18] namespace the struct functions
Date: Thu, 24 Jan 2013 16:21:44 -0500
Message-ID: <1359062510-7557-12-git-send-email-jdesfossez__3811.07296930185$1359064970$gmane$org@efficios.com>
References: <1359062510-7557-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TyUFT-0008Ey-4j
	for lttng-dev@lists.lttng.org; Thu, 24 Jan 2013 16:22:16 -0500
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
 formats/ctf-text/types/struct.c                    |    4 +--
 formats/ctf/ctf.c                                  |   32 ++++++++++----------
 .../ctf/metadata/ctf-visitor-generate-io-struct.c  |   16 +++++-----
 formats/ctf/types/struct.c                         |    2 +-
 include/babeltrace/types.h                         |   18 +++++------
 types/struct.c                                     |   16 +++++-----
 types/types.c                                      |   10 +++---
 7 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/formats/ctf-text/types/struct.c b/formats/ctf-text/types/struct.c
index 8a9344e..e9365af 100644
--- a/formats/ctf-text/types/struct.c
+++ b/formats/ctf-text/types/struct.c
@@ -35,7 +35,7 @@ int ctf_text_struct_write(struct stream_pos *ppos, struct definition *definition
 	struct declaration_struct *struct_declaration =
 		container_of(declaration, struct declaration_struct, p);
 	struct ctf_text_stream_pos *pos = ctf_text_pos(ppos);
-	uint64_t len = struct_declaration_len(struct_declaration);
+	uint64_t len = bt_struct_declaration_len(struct_declaration);
 	int field_nr_saved;
 	int ret;
 
@@ -58,7 +58,7 @@ int ctf_text_struct_write(struct stream_pos *ppos, struct definition *definition
 	}
 	field_nr_saved = pos->field_nr;
 	pos->field_nr = 0;
-	ret = struct_rw(ppos, definition);
+	ret = bt_struct_rw(ppos, definition);
 	if (!pos->dummy) {
 		pos->depth--;
 		if (pos->depth >= 0 && (pos->print_names || len > 1)) {
diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 45ab65e..e2a109b 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -1311,12 +1311,12 @@ int create_stream_packet_index(struct ctf_trace *td,
 			ret = generic_rw(&pos->parent, &file_stream->parent.trace_packet_header->p);
 			if (ret)
 				return ret;
-			len_index = struct_declaration_lookup_field_index(file_stream->parent.trace_packet_header->declaration, g_quark_from_static_string("magic"));
+			len_index = bt_struct_declaration_lookup_field_index(file_stream->parent.trace_packet_header->declaration, g_quark_from_static_string("magic"));
 			if (len_index >= 0) {
 				struct definition *field;
 				uint64_t magic;
 
-				field = struct_definition_get_field_from_index(file_stream->parent.trace_packet_header, len_index);
+				field = bt_struct_definition_get_field_from_index(file_stream->parent.trace_packet_header, len_index);
 				magic = bt_get_unsigned_int(field);
 				if (magic != CTF_MAGIC) {
 					fprintf(stderr, "[error] Invalid magic number 0x%" PRIX64 " at packet %u (file offset %zd).\n",
@@ -1328,14 +1328,14 @@ int create_stream_packet_index(struct ctf_trace *td,
 			}
 
 			/* check uuid */
-			len_index = struct_declaration_lookup_field_index(file_stream->parent.trace_packet_header->declaration, g_quark_from_static_string("uuid"));
+			len_index = bt_struct_declaration_lookup_field_index(file_stream->parent.trace_packet_header->declaration, g_quark_from_static_string("uuid"));
 			if (len_index >= 0) {
 				struct definition_array *defarray;
 				struct definition *field;
 				uint64_t i;
 				uint8_t uuidval[BABELTRACE_UUID_LEN];
 
-				field = struct_definition_get_field_from_index(file_stream->parent.trace_packet_header, len_index);
+				field = bt_struct_definition_get_field_from_index(file_stream->parent.trace_packet_header, len_index);
 				assert(field->declaration->id == CTF_TYPE_ARRAY);
 				defarray = container_of(field, struct definition_array, p);
 				assert(bt_array_len(defarray) == BABELTRACE_UUID_LEN);
@@ -1354,11 +1354,11 @@ int create_stream_packet_index(struct ctf_trace *td,
 			}
 
 
-			len_index = struct_declaration_lookup_field_index(file_stream->parent.trace_packet_header->declaration, g_quark_from_static_string("stream_id"));
+			len_index = bt_struct_declaration_lookup_field_index(file_stream->parent.trace_packet_header->declaration, g_quark_from_static_string("stream_id"));
 			if (len_index >= 0) {
 				struct definition *field;
 
-				field = struct_definition_get_field_from_index(file_stream->parent.trace_packet_header, len_index);
+				field = bt_struct_definition_get_field_from_index(file_stream->parent.trace_packet_header, len_index);
 				stream_id = bt_get_unsigned_int(field);
 			}
 		}
@@ -1391,11 +1391,11 @@ int create_stream_packet_index(struct ctf_trace *td,
 			if (ret)
 				return ret;
 			/* read content size from header */
-			len_index = struct_declaration_lookup_field_index(file_stream->parent.stream_packet_context->declaration, g_quark_from_static_string("content_size"));
+			len_index = bt_struct_declaration_lookup_field_index(file_stream->parent.stream_packet_context->declaration, g_quark_from_static_string("content_size"));
 			if (len_index >= 0) {
 				struct definition *field;
 
-				field = struct_definition_get_field_from_index(file_stream->parent.stream_packet_context, len_index);
+				field = bt_struct_definition_get_field_from_index(file_stream->parent.stream_packet_context, len_index);
 				packet_index.content_size = bt_get_unsigned_int(field);
 			} else {
 				/* Use file size for packet size */
@@ -1403,11 +1403,11 @@ int create_stream_packet_index(struct ctf_trace *td,
 			}
 
 			/* read packet size from header */
-			len_index = struct_declaration_lookup_field_index(file_stream->parent.stream_packet_context->declaration, g_quark_from_static_string("packet_size"));
+			len_index = bt_struct_declaration_lookup_field_index(file_stream->parent.stream_packet_context->declaration, g_quark_from_static_string("packet_size"));
 			if (len_index >= 0) {
 				struct definition *field;
 
-				field = struct_definition_get_field_from_index(file_stream->parent.stream_packet_context, len_index);
+				field = bt_struct_definition_get_field_from_index(file_stream->parent.stream_packet_context, len_index);
 				packet_index.packet_size = bt_get_unsigned_int(field);
 			} else {
 				/* Use content size if non-zero, else file size */
@@ -1415,11 +1415,11 @@ int create_stream_packet_index(struct ctf_trace *td,
 			}
 
 			/* read timestamp begin from header */
-			len_index = struct_declaration_lookup_field_index(file_stream->parent.stream_packet_context->declaration, g_quark_from_static_string("timestamp_begin"));
+			len_index = bt_struct_declaration_lookup_field_index(file_stream->parent.stream_packet_context->declaration, g_quark_from_static_string("timestamp_begin"));
 			if (len_index >= 0) {
 				struct definition *field;
 
-				field = struct_definition_get_field_from_index(file_stream->parent.stream_packet_context, len_index);
+				field = bt_struct_definition_get_field_from_index(file_stream->parent.stream_packet_context, len_index);
 				packet_index.timestamp_begin = bt_get_unsigned_int(field);
 				if (file_stream->parent.stream_class->trace->collection) {
 					packet_index.timestamp_begin =
@@ -1430,11 +1430,11 @@ int create_stream_packet_index(struct ctf_trace *td,
 			}
 
 			/* read timestamp end from header */
-			len_index = struct_declaration_lookup_field_index(file_stream->parent.stream_packet_context->declaration, g_quark_from_static_string("timestamp_end"));
+			len_index = bt_struct_declaration_lookup_field_index(file_stream->parent.stream_packet_context->declaration, g_quark_from_static_string("timestamp_end"));
 			if (len_index >= 0) {
 				struct definition *field;
 
-				field = struct_definition_get_field_from_index(file_stream->parent.stream_packet_context, len_index);
+				field = bt_struct_definition_get_field_from_index(file_stream->parent.stream_packet_context, len_index);
 				packet_index.timestamp_end = bt_get_unsigned_int(field);
 				if (file_stream->parent.stream_class->trace->collection) {
 					packet_index.timestamp_end =
@@ -1445,11 +1445,11 @@ int create_stream_packet_index(struct ctf_trace *td,
 			}
 
 			/* read events discarded from header */
-			len_index = struct_declaration_lookup_field_index(file_stream->parent.stream_packet_context->declaration, g_quark_from_static_string("events_discarded"));
+			len_index = bt_struct_declaration_lookup_field_index(file_stream->parent.stream_packet_context->declaration, g_quark_from_static_string("events_discarded"));
 			if (len_index >= 0) {
 				struct definition *field;
 
-				field = struct_definition_get_field_from_index(file_stream->parent.stream_packet_context, len_index);
+				field = bt_struct_definition_get_field_from_index(file_stream->parent.stream_packet_context, len_index);
 				packet_index.events_discarded = bt_get_unsigned_int(field);
 				packet_index.events_discarded_len = bt_get_int_len(field);
 			}
diff --git a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
index bdb9f5f..9c5aeb1 100644
--- a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
+++ b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
@@ -575,12 +575,12 @@ int ctf_struct_type_declarators_visit(FILE *fd, int depth,
 		}
 
 		/* Check if field with same name already exists */
-		if (struct_declaration_lookup_field_index(struct_declaration, field_name) >= 0) {
+		if (bt_struct_declaration_lookup_field_index(struct_declaration, field_name) >= 0) {
 			fprintf(fd, "[error] %s: duplicate field %s in struct\n", __func__, g_quark_to_string(field_name));
 			return -EINVAL;
 		}
 
-		struct_declaration_add_field(struct_declaration,
+		bt_struct_declaration_add_field(struct_declaration,
 					     g_quark_to_string(field_name),
 					     field_declaration);
 		bt_declaration_unref(field_declaration);
@@ -840,7 +840,7 @@ struct declaration *ctf_declaration_struct_visit(FILE *fd,
 	if (!has_body) {
 		assert(name);
 		struct_declaration =
-			lookup_struct_declaration(g_quark_from_string(name),
+			bt_lookup_struct_declaration(g_quark_from_string(name),
 						  declaration_scope);
 		bt_declaration_ref(&struct_declaration->p);
 		return &struct_declaration->p;
@@ -850,7 +850,7 @@ struct declaration *ctf_declaration_struct_visit(FILE *fd,
 		/* For unnamed struct, create type */
 		/* For named struct (with body), create type and add to declaration scope */
 		if (name) {
-			if (lookup_struct_declaration(g_quark_from_string(name),
+			if (bt_lookup_struct_declaration(g_quark_from_string(name),
 						      declaration_scope)) {
 				
 				fprintf(fd, "[error] %s: struct %s already declared in scope\n", __func__, name);
@@ -867,7 +867,7 @@ struct declaration *ctf_declaration_struct_visit(FILE *fd,
 				goto error;
 			}
 		}
-		struct_declaration = struct_declaration_new(declaration_scope,
+		struct_declaration = bt_struct_declaration_new(declaration_scope,
 							    min_align_value);
 		bt_list_for_each_entry(iter, declaration_list, siblings) {
 			int ret;
@@ -880,7 +880,7 @@ struct declaration *ctf_declaration_struct_visit(FILE *fd,
 		if (name) {
 			int ret;
 
-			ret = register_struct_declaration(g_quark_from_string(name),
+			ret = bt_register_struct_declaration(g_quark_from_string(name),
 					struct_declaration,
 					declaration_scope);
 			assert(!ret);
@@ -2017,7 +2017,7 @@ int ctf_stream_visit(FILE *fd, int depth, struct ctf_node *node,
 	if (CTF_STREAM_FIELD_IS_SET(stream, stream_id)) {
 		/* check that packet header has stream_id field. */
 		if (!trace->packet_header_decl
-		    || struct_declaration_lookup_field_index(trace->packet_header_decl, g_quark_from_static_string("stream_id")) < 0) {
+		    || bt_struct_declaration_lookup_field_index(trace->packet_header_decl, g_quark_from_static_string("stream_id")) < 0) {
 			ret = -EPERM;
 			fprintf(fd, "[error] %s: missing stream_id field in packet header declaration, but stream_id attribute is declared for stream.\n", __func__);
 			goto error;
@@ -2226,7 +2226,7 @@ int ctf_trace_visit(FILE *fd, int depth, struct ctf_node *node, struct ctf_trace
 	if (!CTF_TRACE_FIELD_IS_SET(trace, byte_order)) {
 		/* check that the packet header contains a "magic" field */
 		if (!trace->packet_header_decl
-		    || struct_declaration_lookup_field_index(trace->packet_header_decl, g_quark_from_static_string("magic")) < 0) {
+		    || bt_struct_declaration_lookup_field_index(trace->packet_header_decl, g_quark_from_static_string("magic")) < 0) {
 			ret = -EPERM;
 			fprintf(fd, "[error] %s: missing both byte_order and packet header magic number in trace declaration\n", __func__);
 			goto error;
diff --git a/formats/ctf/types/struct.c b/formats/ctf/types/struct.c
index 21ce96f..b0d9e4a 100644
--- a/formats/ctf/types/struct.c
+++ b/formats/ctf/types/struct.c
@@ -34,5 +34,5 @@ int ctf_struct_rw(struct stream_pos *ppos, struct definition *definition)
 	struct ctf_stream_pos *pos = ctf_pos(ppos);
 
 	ctf_align_pos(pos, declaration->alignment);
-	return struct_rw(ppos, definition);
+	return bt_struct_rw(ppos, definition);
 }
diff --git a/include/babeltrace/types.h b/include/babeltrace/types.h
index da69b91..a3d9788 100644
--- a/include/babeltrace/types.h
+++ b/include/babeltrace/types.h
@@ -317,11 +317,11 @@ struct declaration *lookup_declaration(GQuark declaration_name,
  * that a named variant can be declared without specifying its target
  * "choice" tag field immediately.
  */
-int register_struct_declaration(GQuark struct_name,
+int bt_register_struct_declaration(GQuark struct_name,
 				struct declaration_struct *struct_declaration,
 				struct declaration_scope *scope);
 struct declaration_struct *
-	lookup_struct_declaration(GQuark struct_name,
+	bt_lookup_struct_declaration(GQuark struct_name,
 				  struct declaration_scope *scope);
 int register_variant_declaration(GQuark variant_name,
 			  struct declaration_untagged_variant *untagged_variant_declaration,
@@ -431,27 +431,27 @@ char *bt_get_string(const struct definition *field);
 enum ctf_string_encoding bt_get_string_encoding(const struct definition *field);
 
 struct declaration_struct *
-	struct_declaration_new(struct declaration_scope *parent_scope,
+	bt_struct_declaration_new(struct declaration_scope *parent_scope,
 			       uint64_t min_align);
-void struct_declaration_add_field(struct declaration_struct *struct_declaration,
+void bt_struct_declaration_add_field(struct declaration_struct *struct_declaration,
 				  const char *field_name,
 				  struct declaration *field_declaration);
 /*
  * Returns the index of a field within a structure.
  */
-int struct_declaration_lookup_field_index(struct declaration_struct *struct_declaration,
+int bt_struct_declaration_lookup_field_index(struct declaration_struct *struct_declaration,
 						    GQuark field_name);
 /*
  * field returned only valid as long as the field structure is not appended to.
  */
 struct declaration_field *
-struct_declaration_get_field_from_index(struct declaration_struct *struct_declaration,
+bt_struct_declaration_get_field_from_index(struct declaration_struct *struct_declaration,
 					int index);
 struct definition *
-struct_definition_get_field_from_index(struct definition_struct *struct_definition,
+bt_struct_definition_get_field_from_index(struct definition_struct *struct_definition,
 				       int index);
-int struct_rw(struct stream_pos *pos, struct definition *definition);
-uint64_t struct_declaration_len(struct declaration_struct *struct_declaration);
+int bt_struct_rw(struct stream_pos *pos, struct definition *definition);
+uint64_t bt_struct_declaration_len(struct declaration_struct *struct_declaration);
 
 /*
  * The tag enumeration is validated to ensure that it contains only mappings
diff --git a/types/struct.c b/types/struct.c
index cf8fef6..f065dbc 100644
--- a/types/struct.c
+++ b/types/struct.c
@@ -43,7 +43,7 @@ struct definition *_struct_definition_new(struct declaration *declaration,
 static
 void _struct_definition_free(struct definition *definition);
 
-int struct_rw(struct stream_pos *ppos, struct definition *definition)
+int bt_struct_rw(struct stream_pos *ppos, struct definition *definition)
 {
 	struct definition_struct *struct_definition =
 		container_of(definition, struct definition_struct, p);
@@ -81,7 +81,7 @@ void _struct_declaration_free(struct declaration *declaration)
 }
 
 struct declaration_struct *
-	struct_declaration_new(struct declaration_scope *parent_scope,
+	bt_struct_declaration_new(struct declaration_scope *parent_scope,
 			       uint64_t min_align)
 {
 	struct declaration_struct *struct_declaration;
@@ -181,7 +181,7 @@ void _struct_definition_free(struct definition *definition)
 	g_free(_struct);
 }
 
-void struct_declaration_add_field(struct declaration_struct *struct_declaration,
+void bt_struct_declaration_add_field(struct declaration_struct *struct_declaration,
 			   const char *field_name,
 			   struct declaration *field_declaration)
 {
@@ -207,12 +207,12 @@ void struct_declaration_add_field(struct declaration_struct *struct_declaration,
 }
 
 /*
- * struct_declaration_lookup_field_index - returns field index
+ * bt_struct_declaration_lookup_field_index - returns field index
  *
  * Returns the index of a field in a structure, or -1 if it does not
  * exist.
  */
-int struct_declaration_lookup_field_index(struct declaration_struct *struct_declaration,
+int bt_struct_declaration_lookup_field_index(struct declaration_struct *struct_declaration,
 				       GQuark field_name)
 {
 	gpointer index;
@@ -230,7 +230,7 @@ int struct_declaration_lookup_field_index(struct declaration_struct *struct_decl
  * field returned only valid as long as the field structure is not appended to.
  */
 struct declaration_field *
-	struct_declaration_get_field_from_index(struct declaration_struct *struct_declaration,
+	bt_struct_declaration_get_field_from_index(struct declaration_struct *struct_declaration,
 					 int index)
 {
 	if (index < 0)
@@ -242,7 +242,7 @@ struct declaration_field *
  * field returned only valid as long as the field structure is not appended to.
  */
 struct definition *
-struct_definition_get_field_from_index(struct definition_struct *_struct,
+bt_struct_definition_get_field_from_index(struct definition_struct *_struct,
 					int index)
 {
 	if (index < 0)
@@ -250,7 +250,7 @@ struct_definition_get_field_from_index(struct definition_struct *_struct,
 	return g_ptr_array_index(_struct->fields, index);
 }
 
-uint64_t struct_declaration_len(struct declaration_struct *struct_declaration)
+uint64_t bt_struct_declaration_len(struct declaration_struct *struct_declaration)
 {
 	return struct_declaration->fields->len;
 }
diff --git a/types/types.c b/types/types.c
index a6c8abe..615ab70 100644
--- a/types/types.c
+++ b/types/types.c
@@ -336,20 +336,20 @@ void free_declaration_scope(struct declaration_scope *scope)
 }
 
 static
-struct declaration_struct *lookup_struct_declaration_scope(GQuark struct_name,
+struct declaration_struct *bt_lookup_struct_declaration_scope(GQuark struct_name,
 					     struct declaration_scope *scope)
 {
 	return g_hash_table_lookup(scope->struct_declarations,
 				   (gconstpointer) (unsigned long) struct_name);
 }
 
-struct declaration_struct *lookup_struct_declaration(GQuark struct_name,
+struct declaration_struct *bt_lookup_struct_declaration(GQuark struct_name,
 				       struct declaration_scope *scope)
 {
 	struct declaration_struct *declaration;
 
 	while (scope) {
-		declaration = lookup_struct_declaration_scope(struct_name, scope);
+		declaration = bt_lookup_struct_declaration_scope(struct_name, scope);
 		if (declaration)
 			return declaration;
 		scope = scope->parent_scope;
@@ -357,7 +357,7 @@ struct declaration_struct *lookup_struct_declaration(GQuark struct_name,
 	return NULL;
 }
 
-int register_struct_declaration(GQuark struct_name,
+int bt_register_struct_declaration(GQuark struct_name,
 	struct declaration_struct *struct_declaration,
 	struct declaration_scope *scope)
 {
@@ -368,7 +368,7 @@ int register_struct_declaration(GQuark struct_name,
 		return -EPERM;
 
 	/* Only lookup in local scope */
-	if (lookup_struct_declaration_scope(struct_name, scope))
+	if (bt_lookup_struct_declaration_scope(struct_name, scope))
 		return -EEXIST;
 
 	g_hash_table_insert(scope->struct_declarations,
-- 
1.7.10.4
