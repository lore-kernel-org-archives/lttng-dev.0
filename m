From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 7/7] Namespace the struct declaration
Date: Fri, 15 Feb 2013 12:22:56 -0500
Message-ID: <1360948976-14999-7-git-send-email-jdesfossez__47843.1112286218$1360949063$gmane$org@efficios.com>
References: <1360948976-14999-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1U6P0G-0003wb-8d
	for lttng-dev@lists.lttng.org; Fri, 15 Feb 2013 12:23:16 -0500
In-Reply-To: <1360948976-14999-1-git-send-email-jdesfossez@efficios.com>
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

This struct is exposed in the public API so we need to namespace it.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 formats/ctf-text/types/array.c                     |    2 +-
 formats/ctf-text/types/sequence.c                  |    2 +-
 formats/ctf-text/types/struct.c                    |    2 +-
 formats/ctf/events.c                               |   26 +++++-----
 .../ctf/metadata/ctf-visitor-generate-io-struct.c  |   54 ++++++++++----------
 formats/ctf/types/array.c                          |    4 +-
 formats/ctf/types/sequence.c                       |    4 +-
 formats/ctf/types/struct.c                         |    2 +-
 formats/ctf/types/variant.c                        |    2 +-
 include/babeltrace/ctf/events.h                    |   20 ++++----
 include/babeltrace/types.h                         |   48 ++++++++---------
 types/array.c                                      |   12 ++---
 types/enum.c                                       |    6 +--
 types/float.c                                      |    8 +--
 types/integer.c                                    |    6 +--
 types/sequence.c                                   |   10 ++--
 types/string.c                                     |    6 +--
 types/struct.c                                     |   10 ++--
 types/types.c                                      |   12 ++---
 types/variant.c                                    |   14 ++---
 20 files changed, 125 insertions(+), 125 deletions(-)

diff --git a/formats/ctf-text/types/array.c b/formats/ctf-text/types/array.c
index d9f57a2..47eb128 100644
--- a/formats/ctf-text/types/array.c
+++ b/formats/ctf-text/types/array.c
@@ -36,7 +36,7 @@ int ctf_text_array_write(struct bt_stream_pos *ppos, struct bt_definition *defin
 		container_of(definition, struct definition_array, p);
 	struct declaration_array *array_declaration =
 		array_definition->declaration;
-	struct declaration *elem = array_declaration->elem;
+	struct bt_declaration *elem = array_declaration->elem;
 	int field_nr_saved;
 	int ret = 0;
 
diff --git a/formats/ctf-text/types/sequence.c b/formats/ctf-text/types/sequence.c
index 706fe5e..a9499b4 100644
--- a/formats/ctf-text/types/sequence.c
+++ b/formats/ctf-text/types/sequence.c
@@ -36,7 +36,7 @@ int ctf_text_sequence_write(struct bt_stream_pos *ppos, struct bt_definition *de
 		container_of(definition, struct definition_sequence, p);
 	struct declaration_sequence *sequence_declaration =
 		sequence_definition->declaration;
-	struct declaration *elem = sequence_declaration->elem;
+	struct bt_declaration *elem = sequence_declaration->elem;
 	int field_nr_saved;
 	int ret = 0;
 
diff --git a/formats/ctf-text/types/struct.c b/formats/ctf-text/types/struct.c
index 1b9e27e..cbfcc7c 100644
--- a/formats/ctf-text/types/struct.c
+++ b/formats/ctf-text/types/struct.c
@@ -31,7 +31,7 @@
 
 int ctf_text_struct_write(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
-	struct declaration *declaration = definition->declaration;
+	struct bt_declaration *declaration = definition->declaration;
 	struct declaration_struct *struct_declaration =
 		container_of(declaration, struct declaration_struct, p);
 	struct ctf_text_stream_pos *pos = ctf_text_pos(ppos);
diff --git a/formats/ctf/events.c b/formats/ctf/events.c
index af7f5e1..3cf3b88 100644
--- a/formats/ctf/events.c
+++ b/formats/ctf/events.c
@@ -174,7 +174,7 @@ const char *bt_ctf_field_name(const struct bt_definition *def)
 	return rem_(g_quark_to_string(def->name));
 }
 
-enum ctf_type_id bt_ctf_field_type(const struct declaration *decl)
+enum ctf_type_id bt_ctf_field_type(const struct bt_declaration *decl)
 {
 	if (!decl)
 		return CTF_TYPE_UNKNOWN;
@@ -358,7 +358,7 @@ int bt_ctf_field_get_error(void)
 }
 
 static const struct declaration_integer *
-get_declaration_integer(const struct declaration *decl)
+get_declaration_integer(const struct bt_declaration *decl)
 {
 	if (!decl || bt_ctf_field_type(decl) != CTF_TYPE_INTEGER)
 		return NULL;
@@ -366,7 +366,7 @@ get_declaration_integer(const struct declaration *decl)
 }
 
 static const struct declaration_string *
-get_declaration_string(const struct declaration *decl)
+get_declaration_string(const struct bt_declaration *decl)
 {
 	if (!decl || bt_ctf_field_type(decl) != CTF_TYPE_STRING)
 		return NULL;
@@ -374,7 +374,7 @@ get_declaration_string(const struct declaration *decl)
 }
 
 static const struct declaration_array *
-get_declaration_array(const struct declaration *decl)
+get_declaration_array(const struct bt_declaration *decl)
 {
 	if (!decl || bt_ctf_field_type(decl) != CTF_TYPE_ARRAY)
 		return NULL;
@@ -382,14 +382,14 @@ get_declaration_array(const struct declaration *decl)
 }
 
 static const struct declaration_sequence *
-get_declaration_sequence(const struct declaration *decl)
+get_declaration_sequence(const struct bt_declaration *decl)
 {
 	if (!decl || bt_ctf_field_type(decl) != CTF_TYPE_SEQUENCE)
 		return NULL;
 	return container_of(decl, const struct declaration_sequence, p);
 }
 
-int bt_ctf_get_int_signedness(const struct declaration *decl)
+int bt_ctf_get_int_signedness(const struct bt_declaration *decl)
 {
 	const struct declaration_integer *integer;
 
@@ -401,7 +401,7 @@ int bt_ctf_get_int_signedness(const struct declaration *decl)
 	return integer->signedness;
 }
 
-int bt_ctf_get_int_base(const struct declaration *decl)
+int bt_ctf_get_int_base(const struct bt_declaration *decl)
 {
 	const struct declaration_integer *integer;
 
@@ -413,7 +413,7 @@ int bt_ctf_get_int_base(const struct declaration *decl)
 	return integer->base;
 }
 
-int bt_ctf_get_int_byte_order(const struct declaration *decl)
+int bt_ctf_get_int_byte_order(const struct bt_declaration *decl)
 {
 	const struct declaration_integer *integer;
 
@@ -425,7 +425,7 @@ int bt_ctf_get_int_byte_order(const struct declaration *decl)
 	return integer->byte_order;
 }
 
-ssize_t bt_ctf_get_int_len(const struct declaration *decl)
+ssize_t bt_ctf_get_int_len(const struct bt_declaration *decl)
 {
 	const struct declaration_integer *integer;
 
@@ -485,7 +485,7 @@ const char *bt_ctf_get_enum_str(const struct bt_definition *field)
 	return ret;
 }
 
-enum ctf_string_encoding bt_ctf_get_encoding(const struct declaration *decl)
+enum ctf_string_encoding bt_ctf_get_encoding(const struct bt_declaration *decl)
 {
 	enum ctf_string_encoding ret = 0;
 	enum ctf_type_id type;
@@ -540,7 +540,7 @@ error:
 	return -1;
 }
 
-int bt_ctf_get_array_len(const struct declaration *decl)
+int bt_ctf_get_array_len(const struct bt_declaration *decl)
 {
 	const struct declaration_array *array;
 
@@ -767,7 +767,7 @@ const char *bt_ctf_get_decl_field_name(const struct bt_ctf_field_decl *field)
 	return rem_(g_quark_to_string(((struct declaration_field *) field)->name));
 }
 
-const struct declaration *bt_ctf_get_decl_from_def(const struct bt_definition *def)
+const struct bt_declaration *bt_ctf_get_decl_from_def(const struct bt_definition *def)
 {
 	if (def)
 		return def->declaration;
@@ -775,7 +775,7 @@ const struct declaration *bt_ctf_get_decl_from_def(const struct bt_definition *d
 	return NULL;
 }
 
-const struct declaration *bt_ctf_get_decl_from_field_decl(
+const struct bt_declaration *bt_ctf_get_decl_from_field_decl(
 		const struct bt_ctf_field_decl *field)
 {
 	if (field)
diff --git a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
index ebf8b1b..4671d1b 100644
--- a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
+++ b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
@@ -58,7 +58,7 @@ struct last_enum_value {
 int opt_clock_force_correlate;
 
 static
-struct declaration *ctf_type_specifier_list_visit(FILE *fd,
+struct bt_declaration *ctf_type_specifier_list_visit(FILE *fd,
 		int depth, struct ctf_node *type_specifier_list,
 		struct declaration_scope *declaration_scope,
 		struct ctf_trace *trace);
@@ -411,12 +411,12 @@ GQuark create_typealias_identifier(FILE *fd, int depth,
 }
 
 static
-struct declaration *ctf_type_declarator_visit(FILE *fd, int depth,
+struct bt_declaration *ctf_type_declarator_visit(FILE *fd, int depth,
 	struct ctf_node *type_specifier_list,
 	GQuark *field_name,
 	struct ctf_node *node_type_declarator,
 	struct declaration_scope *declaration_scope,
-	struct declaration *nested_declaration,
+	struct bt_declaration *nested_declaration,
 	struct ctf_trace *trace)
 {
 	/*
@@ -483,7 +483,7 @@ struct declaration *ctf_type_declarator_visit(FILE *fd, int depth,
 			*field_name = 0;
 		return nested_declaration;
 	} else {
-		struct declaration *declaration;
+		struct bt_declaration *declaration;
 		struct ctf_node *first;
 
 		/* TYPEDEC_NESTED */
@@ -562,7 +562,7 @@ int ctf_struct_type_declarators_visit(FILE *fd, int depth,
 	GQuark field_name;
 
 	bt_list_for_each_entry(iter, type_declarators, siblings) {
-		struct declaration *field_declaration;
+		struct bt_declaration *field_declaration;
 
 		field_declaration = ctf_type_declarator_visit(fd, depth,
 						type_specifier_list,
@@ -600,7 +600,7 @@ int ctf_variant_type_declarators_visit(FILE *fd, int depth,
 	GQuark field_name;
 
 	bt_list_for_each_entry(iter, type_declarators, siblings) {
-		struct declaration *field_declaration;
+		struct bt_declaration *field_declaration;
 
 		field_declaration = ctf_type_declarator_visit(fd, depth,
 						type_specifier_list,
@@ -635,7 +635,7 @@ int ctf_typedef_visit(FILE *fd, int depth, struct declaration_scope *scope,
 	GQuark identifier;
 
 	bt_list_for_each_entry(iter, type_declarators, siblings) {
-		struct declaration *type_declaration;
+		struct bt_declaration *type_declaration;
 		int ret;
 	
 		type_declaration = ctf_type_declarator_visit(fd, depth,
@@ -670,7 +670,7 @@ int ctf_typealias_visit(FILE *fd, int depth, struct declaration_scope *scope,
 		struct ctf_node *target, struct ctf_node *alias,
 		struct ctf_trace *trace)
 {
-	struct declaration *type_declaration;
+	struct bt_declaration *type_declaration;
 	struct ctf_node *node;
 	GQuark dummy_id;
 	GQuark alias_q;
@@ -744,7 +744,7 @@ int ctf_struct_declaration_list_visit(FILE *fd, int depth,
 
 	switch (iter->type) {
 	case NODE_TYPEDEF:
-		/* For each declarator, declare type and add type to struct declaration scope */
+		/* For each declarator, declare type and add type to struct bt_declaration scope */
 		ret = ctf_typedef_visit(fd, depth,
 			struct_declaration->scope,
 			iter->u._typedef.type_specifier_list,
@@ -753,7 +753,7 @@ int ctf_struct_declaration_list_visit(FILE *fd, int depth,
 			return ret;
 		break;
 	case NODE_TYPEALIAS:
-		/* Declare type with declarator and add type to struct declaration scope */
+		/* Declare type with declarator and add type to struct bt_declaration scope */
 		ret = ctf_typealias_visit(fd, depth,
 			struct_declaration->scope,
 			iter->u.typealias.target,
@@ -823,7 +823,7 @@ int ctf_variant_declaration_list_visit(FILE *fd, int depth,
 }
 
 static
-struct declaration *ctf_declaration_struct_visit(FILE *fd,
+struct bt_declaration *ctf_declaration_struct_visit(FILE *fd,
 	int depth, const char *name, struct bt_list_head *declaration_list,
 	int has_body, struct bt_list_head *min_align,
 	struct declaration_scope *declaration_scope,
@@ -894,7 +894,7 @@ error:
 }
 
 static
-struct declaration *ctf_declaration_variant_visit(FILE *fd,
+struct bt_declaration *ctf_declaration_variant_visit(FILE *fd,
 	int depth, const char *name, const char *choice,
 	struct bt_list_head *declaration_list,
 	int has_body, struct declaration_scope *declaration_scope,
@@ -1053,7 +1053,7 @@ int ctf_enumerator_list_visit(FILE *fd, int depth,
 }
 
 static
-struct declaration *ctf_declaration_enum_visit(FILE *fd, int depth,
+struct bt_declaration *ctf_declaration_enum_visit(FILE *fd, int depth,
 			const char *name,
 			struct ctf_node *container_type,
 			struct bt_list_head *enumerator_list,
@@ -1061,7 +1061,7 @@ struct declaration *ctf_declaration_enum_visit(FILE *fd, int depth,
 			struct declaration_scope *declaration_scope,
 			struct ctf_trace *trace)
 {
-	struct declaration *declaration;
+	struct bt_declaration *declaration;
 	struct declaration_enum *enum_declaration;
 	struct declaration_integer *integer_declaration;
 	struct last_enum_value last_value;
@@ -1146,12 +1146,12 @@ error:
 }
 
 static
-struct declaration *ctf_declaration_type_specifier_visit(FILE *fd, int depth,
+struct bt_declaration *ctf_declaration_type_specifier_visit(FILE *fd, int depth,
 		struct ctf_node *type_specifier_list,
 		struct declaration_scope *declaration_scope)
 {
 	GString *str;
-	struct declaration *declaration;
+	struct bt_declaration *declaration;
 	char *str_c;
 	int ret;
 	GQuark id_q;
@@ -1263,7 +1263,7 @@ int get_byte_order(FILE *fd, int depth, struct ctf_node *unary_expression,
 }
 
 static
-struct declaration *ctf_declaration_integer_visit(FILE *fd, int depth,
+struct bt_declaration *ctf_declaration_integer_visit(FILE *fd, int depth,
 		struct bt_list_head *expressions,
 		struct ctf_trace *trace)
 {
@@ -1449,7 +1449,7 @@ struct declaration *ctf_declaration_integer_visit(FILE *fd, int depth,
 }
 
 static
-struct declaration *ctf_declaration_floating_point_visit(FILE *fd, int depth,
+struct bt_declaration *ctf_declaration_floating_point_visit(FILE *fd, int depth,
 		struct bt_list_head *expressions,
 		struct ctf_trace *trace)
 {
@@ -1528,7 +1528,7 @@ struct declaration *ctf_declaration_floating_point_visit(FILE *fd, int depth,
 }
 
 static
-struct declaration *ctf_declaration_string_visit(FILE *fd, int depth,
+struct bt_declaration *ctf_declaration_string_visit(FILE *fd, int depth,
 		struct bt_list_head *expressions,
 		struct ctf_trace *trace)
 {
@@ -1564,7 +1564,7 @@ struct declaration *ctf_declaration_string_visit(FILE *fd, int depth,
 
 
 static
-struct declaration *ctf_type_specifier_list_visit(FILE *fd,
+struct bt_declaration *ctf_type_specifier_list_visit(FILE *fd,
 		int depth, struct ctf_node *type_specifier_list,
 		struct declaration_scope *declaration_scope,
 		struct ctf_trace *trace)
@@ -1715,7 +1715,7 @@ int ctf_event_declaration_visit(FILE *fd, int depth, struct ctf_node *node, stru
 			}
 			CTF_EVENT_SET_FIELD(event, stream_id);
 		} else if (!strcmp(left, "context")) {
-			struct declaration *declaration;
+			struct bt_declaration *declaration;
 
 			if (event->context_decl) {
 				fprintf(fd, "[error] %s: context already declared in event declaration\n", __func__);
@@ -1736,7 +1736,7 @@ int ctf_event_declaration_visit(FILE *fd, int depth, struct ctf_node *node, stru
 			}
 			event->context_decl = container_of(declaration, struct declaration_struct, p);
 		} else if (!strcmp(left, "fields")) {
-			struct declaration *declaration;
+			struct bt_declaration *declaration;
 
 			if (event->fields_decl) {
 				fprintf(fd, "[error] %s: fields already declared in event declaration\n", __func__);
@@ -1915,7 +1915,7 @@ int ctf_stream_declaration_visit(FILE *fd, int depth, struct ctf_node *node, str
 			}
 			CTF_STREAM_SET_FIELD(stream, stream_id);
 		} else if (!strcmp(left, "event.header")) {
-			struct declaration *declaration;
+			struct bt_declaration *declaration;
 
 			if (stream->event_header_decl) {
 				fprintf(fd, "[error] %s: event.header already declared in stream declaration\n", __func__);
@@ -1936,7 +1936,7 @@ int ctf_stream_declaration_visit(FILE *fd, int depth, struct ctf_node *node, str
 			}
 			stream->event_header_decl = container_of(declaration, struct declaration_struct, p);
 		} else if (!strcmp(left, "event.context")) {
-			struct declaration *declaration;
+			struct bt_declaration *declaration;
 
 			if (stream->event_context_decl) {
 				fprintf(fd, "[error] %s: event.context already declared in stream declaration\n", __func__);
@@ -1957,7 +1957,7 @@ int ctf_stream_declaration_visit(FILE *fd, int depth, struct ctf_node *node, str
 			}
 			stream->event_context_decl = container_of(declaration, struct declaration_struct, p);
 		} else if (!strcmp(left, "packet.context")) {
-			struct declaration *declaration;
+			struct bt_declaration *declaration;
 
 			if (stream->packet_context_decl) {
 				fprintf(fd, "[error] %s: packet.context already declared in stream declaration\n", __func__);
@@ -2155,7 +2155,7 @@ int ctf_trace_declaration_visit(FILE *fd, int depth, struct ctf_node *node, stru
 			}
 			CTF_TRACE_SET_FIELD(trace, byte_order);
 		} else if (!strcmp(left, "packet.header")) {
-			struct declaration *declaration;
+			struct bt_declaration *declaration;
 
 			if (trace->packet_header_decl) {
 				fprintf(fd, "[error] %s: packet.header already declared in trace declaration\n", __func__);
@@ -2841,7 +2841,7 @@ int ctf_root_declaration_visit(FILE *fd, int depth, struct ctf_node *node, struc
 		break;
 	case NODE_TYPE_SPECIFIER_LIST:
 	{
-		struct declaration *declaration;
+		struct bt_declaration *declaration;
 
 		/*
 		 * Just add the type specifier to the root scope
diff --git a/formats/ctf/types/array.c b/formats/ctf/types/array.c
index 683c171..ea3ecfd 100644
--- a/formats/ctf/types/array.c
+++ b/formats/ctf/types/array.c
@@ -34,7 +34,7 @@ int ctf_array_read(struct bt_stream_pos *ppos, struct bt_definition *definition)
 		container_of(definition, struct definition_array, p);
 	struct declaration_array *array_declaration =
 		array_definition->declaration;
-	struct declaration *elem = array_declaration->elem;
+	struct bt_declaration *elem = array_declaration->elem;
 	struct ctf_stream_pos *pos =
 		container_of(ppos, struct ctf_stream_pos, parent);
 
@@ -70,7 +70,7 @@ int ctf_array_write(struct bt_stream_pos *ppos, struct bt_definition *definition
 		container_of(definition, struct definition_array, p);
 	struct declaration_array *array_declaration =
 		array_definition->declaration;
-	struct declaration *elem = array_declaration->elem;
+	struct bt_declaration *elem = array_declaration->elem;
 	struct ctf_stream_pos *pos =
 		container_of(ppos, struct ctf_stream_pos, parent);
 
diff --git a/formats/ctf/types/sequence.c b/formats/ctf/types/sequence.c
index 53ebf75..898c367 100644
--- a/formats/ctf/types/sequence.c
+++ b/formats/ctf/types/sequence.c
@@ -34,7 +34,7 @@ int ctf_sequence_read(struct bt_stream_pos *ppos, struct bt_definition *definiti
 		container_of(definition, struct definition_sequence, p);
 	struct declaration_sequence *sequence_declaration =
 		sequence_definition->declaration;
-	struct declaration *elem = sequence_declaration->elem;
+	struct bt_declaration *elem = sequence_declaration->elem;
 	struct ctf_stream_pos *pos = ctf_pos(ppos);
 
 	if (elem->id == CTF_TYPE_INTEGER) {
@@ -69,7 +69,7 @@ int ctf_sequence_write(struct bt_stream_pos *ppos, struct bt_definition *definit
 		container_of(definition, struct definition_sequence, p);
 	struct declaration_sequence *sequence_declaration =
 		sequence_definition->declaration;
-	struct declaration *elem = sequence_declaration->elem;
+	struct bt_declaration *elem = sequence_declaration->elem;
 	struct ctf_stream_pos *pos = ctf_pos(ppos);
 
 	if (elem->id == CTF_TYPE_INTEGER) {
diff --git a/formats/ctf/types/struct.c b/formats/ctf/types/struct.c
index b004767..106f682 100644
--- a/formats/ctf/types/struct.c
+++ b/formats/ctf/types/struct.c
@@ -30,7 +30,7 @@
 
 int ctf_struct_rw(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
-	struct declaration *declaration = definition->declaration;
+	struct bt_declaration *declaration = definition->declaration;
 	struct ctf_stream_pos *pos = ctf_pos(ppos);
 
 	ctf_align_pos(pos, declaration->alignment);
diff --git a/formats/ctf/types/variant.c b/formats/ctf/types/variant.c
index ece8b33..b3d6396 100644
--- a/formats/ctf/types/variant.c
+++ b/formats/ctf/types/variant.c
@@ -30,7 +30,7 @@
 
 int ctf_variant_rw(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
-	struct declaration *declaration = definition->declaration;
+	struct bt_declaration *declaration = definition->declaration;
 	struct ctf_stream_pos *pos = ctf_pos(ppos);
 
 	ctf_align_pos(pos, declaration->alignment);
diff --git a/include/babeltrace/ctf/events.h b/include/babeltrace/ctf/events.h
index ecc5c28..c92470c 100644
--- a/include/babeltrace/ctf/events.h
+++ b/include/babeltrace/ctf/events.h
@@ -40,7 +40,7 @@ extern "C" {
 #endif
 
 struct bt_definition;
-struct declaration;
+struct bt_declaration;
 struct bt_ctf_event;
 struct bt_ctf_event_decl;
 struct bt_ctf_field_decl;
@@ -158,19 +158,19 @@ const char *bt_ctf_field_name(const struct bt_definition *def);
  * bt_ctf_get_decl_from_def: return the declaration of a field from
  * its definition or NULL on error
  */
-const struct declaration *bt_ctf_get_decl_from_def(const struct bt_definition *def);
+const struct bt_declaration *bt_ctf_get_decl_from_def(const struct bt_definition *def);
 
 /*
  * bt_ctf_get_decl_from_field_decl: return the declaration of a field from
  * a field_decl or NULL on error
  */
-const struct declaration *bt_ctf_get_decl_from_field_decl(
+const struct bt_declaration *bt_ctf_get_decl_from_field_decl(
 		const struct bt_ctf_field_decl *field);
 
 /*
  * bt_ctf_field_type: returns the type of a field or -1 if unknown
  */
-enum ctf_type_id bt_ctf_field_type(const struct declaration *decl);
+enum ctf_type_id bt_ctf_field_type(const struct bt_declaration *decl);
 
 /*
  * bt_ctf_get_int_signedness: return the signedness of an integer
@@ -179,37 +179,37 @@ enum ctf_type_id bt_ctf_field_type(const struct declaration *decl);
  * return 1 if signed
  * return -1 on error
  */
-int bt_ctf_get_int_signedness(const struct declaration *decl);
+int bt_ctf_get_int_signedness(const struct bt_declaration *decl);
 
 /*
  * bt_ctf_get_int_base: return the base of an int or a negative value on error
  */
-int bt_ctf_get_int_base(const struct declaration *decl);
+int bt_ctf_get_int_base(const struct bt_declaration *decl);
 
 /*
  * bt_ctf_get_int_byte_order: return the byte order of an int or a negative
  * value on error
  */
-int bt_ctf_get_int_byte_order(const struct declaration *decl);
+int bt_ctf_get_int_byte_order(const struct bt_declaration *decl);
 
 /*
  * bt_ctf_get_int_len: return the size, in bits, of an int or a negative
  * value on error
  */
-ssize_t bt_ctf_get_int_len(const struct declaration *decl);
+ssize_t bt_ctf_get_int_len(const struct bt_declaration *decl);
 
 /*
  * bt_ctf_get_encoding: return the encoding of an int, a string, or of
  * the integer contained in a char array or a sequence.
  * return a negative value on error
  */
-enum ctf_string_encoding bt_ctf_get_encoding(const struct declaration *decl);
+enum ctf_string_encoding bt_ctf_get_encoding(const struct bt_declaration *decl);
 
 /*
  * bt_ctf_get_array_len: return the len of an array or a negative
  * value on error
  */
-int bt_ctf_get_array_len(const struct declaration *decl);
+int bt_ctf_get_array_len(const struct bt_declaration *decl);
 
 /*
  * Field access functions
diff --git a/include/babeltrace/types.h b/include/babeltrace/types.h
index 0b8d1c1..22c6876 100644
--- a/include/babeltrace/types.h
+++ b/include/babeltrace/types.h
@@ -78,16 +78,16 @@ struct definition_scope {
 	GArray *scope_path;	/* array of GQuark */
 };
 
-struct declaration {
+struct bt_declaration {
 	enum ctf_type_id id;
 	size_t alignment;	/* type alignment, in bits */
 	int ref;		/* number of references to the type */
 	/*
 	 * declaration_free called with declaration ref is decremented to 0.
 	 */
-	void (*declaration_free)(struct declaration *declaration);
+	void (*declaration_free)(struct bt_declaration *declaration);
 	struct bt_definition *
-		(*definition_new)(struct declaration *declaration,
+		(*definition_new)(struct bt_declaration *declaration,
 				  struct definition_scope *parent_scope,
 				  GQuark field_name, int index,
 				  const char *root_name);
@@ -98,7 +98,7 @@ struct declaration {
 };
 
 struct bt_definition {
-	struct declaration *declaration;
+	struct bt_declaration *declaration;
 	int index;		/* Position of the definition in its container */
 	GQuark name;		/* Field name in its container (or 0 if unset) */
 	int ref;		/* number of references to the definition */
@@ -134,7 +134,7 @@ int generic_rw(struct bt_stream_pos *pos, struct bt_definition *definition)
  * read/write non aligned on CHAR_BIT.
  */
 struct declaration_integer {
-	struct declaration p;
+	struct bt_declaration p;
 	size_t len;		/* length, in bits. */
 	int byte_order;		/* byte order */
 	int signedness;
@@ -154,7 +154,7 @@ struct definition_integer {
 };
 
 struct declaration_float {
-	struct declaration p;
+	struct bt_declaration p;
 	struct declaration_integer *sign;
 	struct declaration_integer *mantissa;
 	struct declaration_integer *exp;
@@ -211,7 +211,7 @@ struct enum_table {
 };
 
 struct declaration_enum {
-	struct declaration p;
+	struct bt_declaration p;
 	struct declaration_integer *integer_declaration;
 	struct enum_table table;
 };
@@ -225,7 +225,7 @@ struct definition_enum {
 };
 
 struct declaration_string {
-	struct declaration p;
+	struct bt_declaration p;
 	enum ctf_string_encoding encoding;
 };
 
@@ -238,11 +238,11 @@ struct definition_string {
 
 struct declaration_field {
 	GQuark name;
-	struct declaration *declaration;
+	struct bt_declaration *declaration;
 };
 
 struct declaration_struct {
-	struct declaration p;
+	struct bt_declaration p;
 	GHashTable *fields_by_name;	/* Tuples (field name, field index) */
 	struct declaration_scope *scope;
 	GArray *fields;			/* Array of declaration_field */
@@ -255,14 +255,14 @@ struct definition_struct {
 };
 
 struct declaration_untagged_variant {
-	struct declaration p;
+	struct bt_declaration p;
 	GHashTable *fields_by_tag;	/* Tuples (field tag, field index) */
 	struct declaration_scope *scope;
 	GArray *fields;			/* Array of declaration_field */
 };
 
 struct declaration_variant {
-	struct declaration p;
+	struct bt_declaration p;
 	struct declaration_untagged_variant *untagged_variant;
 	GArray *tag_name;		/* Array of GQuark */
 };
@@ -277,9 +277,9 @@ struct definition_variant {
 };
 
 struct declaration_array {
-	struct declaration p;
+	struct bt_declaration p;
 	size_t len;
-	struct declaration *elem;
+	struct bt_declaration *elem;
 	struct declaration_scope *scope;
 };
 
@@ -291,9 +291,9 @@ struct definition_array {
 };
 
 struct declaration_sequence {
-	struct declaration p;
+	struct bt_declaration p;
 	GArray *length_name;		/* Array of GQuark */
-	struct declaration *elem;
+	struct bt_declaration *elem;
 	struct declaration_scope *scope;
 };
 
@@ -306,9 +306,9 @@ struct definition_sequence {
 };
 
 int bt_register_declaration(GQuark declaration_name,
-			 struct declaration *declaration,
+			 struct bt_declaration *declaration,
 			 struct declaration_scope *scope);
-struct declaration *bt_lookup_declaration(GQuark declaration_name,
+struct bt_declaration *bt_lookup_declaration(GQuark declaration_name,
 				struct declaration_scope *scope);
 
 /*
@@ -364,8 +364,8 @@ int compare_definition_path(struct bt_definition *definition, GQuark path)
 	return definition->path == path;
 }
 
-void bt_declaration_ref(struct declaration *declaration);
-void bt_declaration_unref(struct declaration *declaration);
+void bt_declaration_ref(struct bt_declaration *declaration);
+void bt_declaration_unref(struct bt_declaration *declaration);
 
 void bt_definition_ref(struct bt_definition *definition);
 void bt_definition_unref(struct bt_definition *definition);
@@ -435,7 +435,7 @@ struct declaration_struct *
 			       uint64_t min_align);
 void bt_struct_declaration_add_field(struct declaration_struct *struct_declaration,
 				  const char *field_name,
-				  struct declaration *field_declaration);
+				  struct bt_declaration *field_declaration);
 /*
  * Returns the index of a field within a structure.
  */
@@ -465,7 +465,7 @@ struct declaration_variant *bt_variant_declaration_new(struct declaration_untagg
 
 void bt_untagged_variant_declaration_add_field(struct declaration_untagged_variant *untagged_variant_declaration,
 		const char *field_name,
-		struct declaration *field_declaration);
+		struct bt_declaration *field_declaration);
 struct declaration_field *
 	bt_untagged_variant_declaration_get_field_from_tag(struct declaration_untagged_variant *untagged_variant_declaration,
 		GQuark tag);
@@ -488,7 +488,7 @@ int bt_variant_rw(struct bt_stream_pos *pos, struct bt_definition *definition);
  * array.
  */
 struct declaration_array *
-	bt_array_declaration_new(size_t len, struct declaration *elem_declaration,
+	bt_array_declaration_new(size_t len, struct bt_declaration *elem_declaration,
 		struct declaration_scope *parent_scope);
 uint64_t bt_array_len(struct definition_array *array);
 struct bt_definition *bt_array_index(struct definition_array *array, uint64_t i);
@@ -502,7 +502,7 @@ int bt_get_array_len(const struct bt_definition *field);
  */
 struct declaration_sequence *
 	bt_sequence_declaration_new(const char *length_name,
-		struct declaration *elem_declaration,
+		struct bt_declaration *elem_declaration,
 		struct declaration_scope *parent_scope);
 uint64_t bt_sequence_len(struct definition_sequence *sequence);
 struct bt_definition *bt_sequence_index(struct definition_sequence *sequence, uint64_t i);
diff --git a/types/array.c b/types/array.c
index debc15a..c9b973b 100644
--- a/types/array.c
+++ b/types/array.c
@@ -32,7 +32,7 @@
 #include <inttypes.h>
 
 static
-struct bt_definition *_array_definition_new(struct declaration *declaration,
+struct bt_definition *_array_definition_new(struct bt_declaration *declaration,
 			struct definition_scope *parent_scope,
 			GQuark field_name, int index, const char *root_name);
 static
@@ -59,7 +59,7 @@ int bt_array_rw(struct bt_stream_pos *pos, struct bt_definition *definition)
 }
 
 static
-void _array_declaration_free(struct declaration *declaration)
+void _array_declaration_free(struct bt_declaration *declaration)
 {
 	struct declaration_array *array_declaration =
 		container_of(declaration, struct declaration_array, p);
@@ -71,11 +71,11 @@ void _array_declaration_free(struct declaration *declaration)
 
 struct declaration_array *
 	bt_array_declaration_new(size_t len,
-			      struct declaration *elem_declaration,
+			      struct bt_declaration *elem_declaration,
 			      struct declaration_scope *parent_scope)
 {
 	struct declaration_array *array_declaration;
-	struct declaration *declaration;
+	struct bt_declaration *declaration;
 
 	array_declaration = g_new(struct declaration_array, 1);
 	declaration = &array_declaration->p;
@@ -94,7 +94,7 @@ struct declaration_array *
 
 static
 struct bt_definition *
-	_array_definition_new(struct declaration *declaration,
+	_array_definition_new(struct bt_declaration *declaration,
 			      struct definition_scope *parent_scope,
 			      GQuark field_name, int index, const char *root_name)
 {
@@ -229,7 +229,7 @@ GString *bt_get_char_array(const struct bt_definition *field)
 {
 	struct definition_array *array_definition;
 	struct declaration_array *array_declaration;
-	struct declaration *elem;
+	struct bt_declaration *elem;
 
 	array_definition = container_of(field, struct definition_array, p);
 	array_declaration = array_definition->declaration;
diff --git a/types/enum.c b/types/enum.c
index e967e14..8394e1b 100644
--- a/types/enum.c
+++ b/types/enum.c
@@ -41,7 +41,7 @@
 #endif
 
 static
-struct bt_definition *_enum_definition_new(struct declaration *declaration,
+struct bt_definition *_enum_definition_new(struct bt_declaration *declaration,
 					struct definition_scope *parent_scope,
 					GQuark field_name, int index,
 					const char *root_name);
@@ -374,7 +374,7 @@ size_t bt_enum_get_nr_enumerators(struct declaration_enum *enum_declaration)
 }
 
 static
-void _enum_declaration_free(struct declaration *declaration)
+void _enum_declaration_free(struct bt_declaration *declaration)
 {
 	struct declaration_enum *enum_declaration =
 		container_of(declaration, struct declaration_enum, p);
@@ -418,7 +418,7 @@ struct declaration_enum *
 
 static
 struct bt_definition *
-	_enum_definition_new(struct declaration *declaration,
+	_enum_definition_new(struct bt_declaration *declaration,
 			     struct definition_scope *parent_scope,
 			     GQuark field_name, int index,
 			     const char *root_name)
diff --git a/types/float.c b/types/float.c
index 7aeb9c3..3b61f8f 100644
--- a/types/float.c
+++ b/types/float.c
@@ -32,7 +32,7 @@
 #include <babeltrace/endian.h>
 
 static
-struct bt_definition *_float_definition_new(struct declaration *declaration,
+struct bt_definition *_float_definition_new(struct bt_declaration *declaration,
 				   struct definition_scope *parent_scope,
 				   GQuark field_name, int index,
 				   const char *root_name);
@@ -40,7 +40,7 @@ static
 void _float_definition_free(struct bt_definition *definition);
 
 static
-void _float_declaration_free(struct declaration *declaration)
+void _float_declaration_free(struct bt_declaration *declaration)
 {
 	struct declaration_float *float_declaration =
 		container_of(declaration, struct declaration_float, p);
@@ -56,7 +56,7 @@ struct declaration_float *
 		       size_t exp_len, int byte_order, size_t alignment)
 {
 	struct declaration_float *float_declaration;
-	struct declaration *declaration;
+	struct bt_declaration *declaration;
 
 	float_declaration = g_new(struct declaration_float, 1);
 	declaration = &float_declaration->p;
@@ -82,7 +82,7 @@ struct declaration_float *
 
 static
 struct bt_definition *
-	_float_definition_new(struct declaration *declaration,
+	_float_definition_new(struct bt_declaration *declaration,
 			      struct definition_scope *parent_scope,
 			      GQuark field_name, int index,
 			      const char *root_name)
diff --git a/types/integer.c b/types/integer.c
index 92c7eb1..73d4f2a 100644
--- a/types/integer.c
+++ b/types/integer.c
@@ -33,7 +33,7 @@
 #include <stdint.h>
 
 static
-struct bt_definition *_integer_definition_new(struct declaration *declaration,
+struct bt_definition *_integer_definition_new(struct bt_declaration *declaration,
 			       struct definition_scope *parent_scope,
 			       GQuark field_name, int index,
 			       const char *root_name);
@@ -41,7 +41,7 @@ static
 void _integer_definition_free(struct bt_definition *definition);
 
 static
-void _integer_declaration_free(struct declaration *declaration)
+void _integer_declaration_free(struct bt_declaration *declaration)
 {
 	struct declaration_integer *integer_declaration =
 		container_of(declaration, struct declaration_integer, p);
@@ -74,7 +74,7 @@ struct declaration_integer *
 
 static
 struct bt_definition *
-	_integer_definition_new(struct declaration *declaration,
+	_integer_definition_new(struct bt_declaration *declaration,
 				struct definition_scope *parent_scope,
 				GQuark field_name, int index,
 				const char *root_name)
diff --git a/types/sequence.c b/types/sequence.c
index 8792325..6c61ef7 100644
--- a/types/sequence.c
+++ b/types/sequence.c
@@ -32,7 +32,7 @@
 #include <inttypes.h>
 
 static
-struct bt_definition *_sequence_definition_new(struct declaration *declaration,
+struct bt_definition *_sequence_definition_new(struct bt_declaration *declaration,
 					struct definition_scope *parent_scope,
 					GQuark field_name, int index,
 					const char *root_name);
@@ -88,7 +88,7 @@ int bt_sequence_rw(struct bt_stream_pos *pos, struct bt_definition *definition)
 }
 
 static
-void _sequence_declaration_free(struct declaration *declaration)
+void _sequence_declaration_free(struct bt_declaration *declaration)
 {
 	struct declaration_sequence *sequence_declaration =
 		container_of(declaration, struct declaration_sequence, p);
@@ -101,11 +101,11 @@ void _sequence_declaration_free(struct declaration *declaration)
 
 struct declaration_sequence *
 	bt_sequence_declaration_new(const char *length,
-			  struct declaration *elem_declaration,
+			  struct bt_declaration *elem_declaration,
 			  struct declaration_scope *parent_scope)
 {
 	struct declaration_sequence *sequence_declaration;
-	struct declaration *declaration;
+	struct bt_declaration *declaration;
 
 	sequence_declaration = g_new(struct declaration_sequence, 1);
 	declaration = &sequence_declaration->p;
@@ -126,7 +126,7 @@ struct declaration_sequence *
 }
 
 static
-struct bt_definition *_sequence_definition_new(struct declaration *declaration,
+struct bt_definition *_sequence_definition_new(struct bt_declaration *declaration,
 				struct definition_scope *parent_scope,
 				GQuark field_name, int index,
 				const char *root_name)
diff --git a/types/string.c b/types/string.c
index 5db1716..5bbba98 100644
--- a/types/string.c
+++ b/types/string.c
@@ -32,7 +32,7 @@
 #include <babeltrace/types.h>
 
 static
-struct bt_definition *_string_definition_new(struct declaration *declaration,
+struct bt_definition *_string_definition_new(struct bt_declaration *declaration,
 				struct definition_scope *parent_scope,
 				GQuark field_name, int index,
 				const char *root_name);
@@ -40,7 +40,7 @@ static
 void _string_definition_free(struct bt_definition *definition);
 
 static
-void _string_declaration_free(struct declaration *declaration)
+void _string_declaration_free(struct bt_declaration *declaration)
 {
 	struct declaration_string *string_declaration =
 		container_of(declaration, struct declaration_string, p);
@@ -65,7 +65,7 @@ struct declaration_string *
 
 static
 struct bt_definition *
-	_string_definition_new(struct declaration *declaration,
+	_string_definition_new(struct bt_declaration *declaration,
 			       struct definition_scope *parent_scope,
 			       GQuark field_name, int index,
 			       const char *root_name)
diff --git a/types/struct.c b/types/struct.c
index fadc187..b9fb679 100644
--- a/types/struct.c
+++ b/types/struct.c
@@ -36,7 +36,7 @@
 #endif
 
 static
-struct bt_definition *_struct_definition_new(struct declaration *declaration,
+struct bt_definition *_struct_definition_new(struct bt_declaration *declaration,
 				struct definition_scope *parent_scope,
 				GQuark field_name, int index,
 				const char *root_name);
@@ -61,7 +61,7 @@ int bt_struct_rw(struct bt_stream_pos *ppos, struct bt_definition *definition)
 }
 
 static
-void _struct_declaration_free(struct declaration *declaration)
+void _struct_declaration_free(struct bt_declaration *declaration)
 {
 	struct declaration_struct *struct_declaration =
 		container_of(declaration, struct declaration_struct, p);
@@ -85,7 +85,7 @@ struct declaration_struct *
 			       uint64_t min_align)
 {
 	struct declaration_struct *struct_declaration;
-	struct declaration *declaration;
+	struct bt_declaration *declaration;
 
 	struct_declaration = g_new(struct declaration_struct, 1);
 	declaration = &struct_declaration->p;
@@ -106,7 +106,7 @@ struct declaration_struct *
 
 static
 struct bt_definition *
-	_struct_definition_new(struct declaration *declaration,
+	_struct_definition_new(struct bt_declaration *declaration,
 			       struct definition_scope *parent_scope,
 			       GQuark field_name, int index,
 			       const char *root_name)
@@ -183,7 +183,7 @@ void _struct_definition_free(struct bt_definition *definition)
 
 void bt_struct_declaration_add_field(struct declaration_struct *struct_declaration,
 			   const char *field_name,
-			   struct declaration *field_declaration)
+			   struct bt_declaration *field_declaration)
 {
 	struct declaration_field *field;
 	unsigned long index;
diff --git a/types/types.c b/types/types.c
index b235c13..0d1a89d 100644
--- a/types/types.c
+++ b/types/types.c
@@ -51,7 +51,7 @@ GQuark prefix_quark(const char *prefix, GQuark quark)
 }
 
 static
-struct declaration *
+struct bt_declaration *
 	bt_lookup_declaration_scope(GQuark declaration_name,
 		struct declaration_scope *scope)
 {
@@ -59,10 +59,10 @@ struct declaration *
 				   (gconstpointer) (unsigned long) declaration_name);
 }
 
-struct declaration *bt_lookup_declaration(GQuark declaration_name,
+struct bt_declaration *bt_lookup_declaration(GQuark declaration_name,
 		struct declaration_scope *scope)
 {
-	struct declaration *declaration;
+	struct bt_declaration *declaration;
 
 	while (scope) {
 		declaration = bt_lookup_declaration_scope(declaration_name,
@@ -74,7 +74,7 @@ struct declaration *bt_lookup_declaration(GQuark declaration_name,
 	return NULL;
 }
 
-int bt_register_declaration(GQuark name, struct declaration *declaration,
+int bt_register_declaration(GQuark name, struct bt_declaration *declaration,
 		struct declaration_scope *scope)
 {
 	if (!name)
@@ -279,12 +279,12 @@ int bt_register_field_definition(GQuark field_name, struct bt_definition *defini
 	return 0;
 }
 
-void bt_declaration_ref(struct declaration *declaration)
+void bt_declaration_ref(struct bt_declaration *declaration)
 {
 	declaration->ref++;
 }
 
-void bt_declaration_unref(struct declaration *declaration)
+void bt_declaration_unref(struct bt_declaration *declaration)
 {
 	if (!declaration)
 		return;
diff --git a/types/variant.c b/types/variant.c
index ed29550..1f0dc6a 100644
--- a/types/variant.c
+++ b/types/variant.c
@@ -32,7 +32,7 @@
 #include <errno.h>
 
 static
-struct bt_definition *_variant_definition_new(struct declaration *declaration,
+struct bt_definition *_variant_definition_new(struct bt_declaration *declaration,
 				struct definition_scope *parent_scope,
 				GQuark field_name, int index,
 				const char *root_name);
@@ -50,7 +50,7 @@ int bt_variant_rw(struct bt_stream_pos *ppos, struct bt_definition *definition)
 }
 
 static
-void _untagged_variant_declaration_free(struct declaration *declaration)
+void _untagged_variant_declaration_free(struct bt_declaration *declaration)
 {
 	struct declaration_untagged_variant *untagged_variant_declaration =
 		container_of(declaration, struct declaration_untagged_variant, p);
@@ -73,7 +73,7 @@ struct declaration_untagged_variant *bt_untagged_bt_variant_declaration_new(
 				      struct declaration_scope *parent_scope)
 {
 	struct declaration_untagged_variant *untagged_variant_declaration;
-	struct declaration *declaration;
+	struct bt_declaration *declaration;
 
 	untagged_variant_declaration = g_new(struct declaration_untagged_variant, 1);
 	declaration = &untagged_variant_declaration->p;
@@ -93,7 +93,7 @@ struct declaration_untagged_variant *bt_untagged_bt_variant_declaration_new(
 }
 
 static
-void _variant_declaration_free(struct declaration *declaration)
+void _variant_declaration_free(struct bt_declaration *declaration)
 {
 	struct declaration_variant *variant_declaration =
 		container_of(declaration, struct declaration_variant, p);
@@ -107,7 +107,7 @@ struct declaration_variant *
 	bt_variant_declaration_new(struct declaration_untagged_variant *untagged_variant, const char *tag)
 {
 	struct declaration_variant *variant_declaration;
-	struct declaration *declaration;
+	struct bt_declaration *declaration;
 
 	variant_declaration = g_new(struct declaration_variant, 1);
 	declaration = &variant_declaration->p;
@@ -173,7 +173,7 @@ int check_enum_tag(struct definition_variant *variant,
 
 static
 struct bt_definition *
-	_variant_definition_new(struct declaration *declaration,
+	_variant_definition_new(struct bt_declaration *declaration,
 				struct definition_scope *parent_scope,
 				GQuark field_name, int index,
 				const char *root_name)
@@ -259,7 +259,7 @@ void _variant_definition_free(struct bt_definition *definition)
 
 void bt_untagged_variant_declaration_add_field(struct declaration_untagged_variant *untagged_variant_declaration,
 			    const char *field_name,
-			    struct declaration *field_declaration)
+			    struct bt_declaration *field_declaration)
 {
 	struct declaration_field *field;
 	unsigned long index;
-- 
1.7.10.4
