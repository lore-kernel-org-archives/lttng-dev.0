From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 15/18] namespace the declaration
	functions
Date: Thu, 24 Jan 2013 16:21:47 -0500
Message-ID: <1359062510-7557-15-git-send-email-jdesfossez__3915.80037908188$1359064836$gmane$org@efficios.com>
References: <1359062510-7557-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TyUFX-0008G6-Ns
	for lttng-dev@lists.lttng.org; Thu, 24 Jan 2013 16:22:20 -0500
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
 .../ctf/metadata/ctf-visitor-generate-io-struct.c  |   62 ++++++++++----------
 formats/ctf/types/float.c                          |    4 +-
 include/babeltrace/types.h                         |   28 ++++-----
 types/array.c                                      |    4 +-
 types/float.c                                      |    8 +--
 types/integer.c                                    |    2 +-
 types/sequence.c                                   |    4 +-
 types/struct.c                                     |    4 +-
 types/types.c                                      |   40 ++++++-------
 types/variant.c                                    |   12 ++--
 10 files changed, 84 insertions(+), 84 deletions(-)

diff --git a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
index 9c5aeb1..d1b453e 100644
--- a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
+++ b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
@@ -445,7 +445,7 @@ struct declaration *ctf_type_declarator_visit(FILE *fd, int depth,
 			 */
 			alias_q = create_typealias_identifier(fd, depth,
 				type_specifier_list, node_type_declarator);
-			nested_declaration = lookup_declaration(alias_q, declaration_scope);
+			nested_declaration = bt_lookup_declaration(alias_q, declaration_scope);
 			if (!nested_declaration) {
 				fprintf(fd, "[error] %s: cannot find typealias \"%s\".\n", __func__, g_quark_to_string(alias_q));
 				return NULL;
@@ -460,7 +460,7 @@ struct declaration *ctf_type_declarator_visit(FILE *fd, int depth,
 					 * integer declaration to modify it. There could be other references to
 					 * it.
 					 */
-					integer_declaration = integer_declaration_new(integer_declaration->len,
+					integer_declaration = bt_integer_declaration_new(integer_declaration->len,
 						integer_declaration->byte_order, integer_declaration->signedness,
 						integer_declaration->p.alignment, 16, integer_declaration->encoding,
 						integer_declaration->clock);
@@ -612,12 +612,12 @@ int ctf_variant_type_declarators_visit(FILE *fd, int depth,
 			return -EINVAL;
 		}
 
-		if (untagged_variant_declaration_get_field_from_tag(untagged_variant_declaration, field_name) != NULL) {
+		if (bt_untagged_variant_declaration_get_field_from_tag(untagged_variant_declaration, field_name) != NULL) {
 			fprintf(fd, "[error] %s: duplicate field %s in variant\n", __func__, g_quark_to_string(field_name));
 			return -EINVAL;
 		}
 
-		untagged_variant_declaration_add_field(untagged_variant_declaration,
+		bt_untagged_variant_declaration_add_field(untagged_variant_declaration,
 					      g_quark_to_string(field_name),
 					      field_declaration);
 		bt_declaration_unref(field_declaration);
@@ -655,7 +655,7 @@ int ctf_typedef_visit(FILE *fd, int depth, struct declaration_scope *scope,
 			bt_declaration_unref(type_declaration);
 			return -EPERM;
 		}
-		ret = register_declaration(identifier, type_declaration, scope);
+		ret = bt_register_declaration(identifier, type_declaration, scope);
 		if (ret) {
 			type_declaration->declaration_free(type_declaration);
 			return ret;
@@ -722,7 +722,7 @@ int ctf_typealias_visit(FILE *fd, int depth, struct declaration_scope *scope,
 				struct ctf_node, siblings);
 	alias_q = create_typealias_identifier(fd, depth,
 			alias->u.typealias_alias.type_specifier_list, node);
-	err = register_declaration(alias_q, type_declaration, scope);
+	err = bt_register_declaration(alias_q, type_declaration, scope);
 	if (err)
 		goto error;
 	bt_declaration_unref(type_declaration);
@@ -912,21 +912,21 @@ struct declaration *ctf_declaration_variant_visit(FILE *fd,
 	if (!has_body) {
 		assert(name);
 		untagged_variant_declaration =
-			lookup_variant_declaration(g_quark_from_string(name),
+			bt_lookup_variant_declaration(g_quark_from_string(name),
 						   declaration_scope);
 		bt_declaration_ref(&untagged_variant_declaration->p);
 	} else {
 		/* For unnamed variant, create type */
 		/* For named variant (with body), create type and add to declaration scope */
 		if (name) {
-			if (lookup_variant_declaration(g_quark_from_string(name),
+			if (bt_lookup_variant_declaration(g_quark_from_string(name),
 						       declaration_scope)) {
 				
 				fprintf(fd, "[error] %s: variant %s already declared in scope\n", __func__, name);
 				return NULL;
 			}
 		}
-		untagged_variant_declaration = untagged_variant_declaration_new(declaration_scope);
+		untagged_variant_declaration = bt_untagged_bt_variant_declaration_new(declaration_scope);
 		bt_list_for_each_entry(iter, declaration_list, siblings) {
 			int ret;
 
@@ -938,7 +938,7 @@ struct declaration *ctf_declaration_variant_visit(FILE *fd,
 		if (name) {
 			int ret;
 
-			ret = register_variant_declaration(g_quark_from_string(name),
+			ret = bt_register_variant_declaration(g_quark_from_string(name),
 					untagged_variant_declaration,
 					declaration_scope);
 			assert(!ret);
@@ -951,7 +951,7 @@ struct declaration *ctf_declaration_variant_visit(FILE *fd,
 	if (!choice) {
 		return &untagged_variant_declaration->p;
 	} else {
-		variant_declaration = variant_declaration_new(untagged_variant_declaration, choice);
+		variant_declaration = bt_variant_declaration_new(untagged_variant_declaration, choice);
 		if (!variant_declaration)
 			goto error;
 		bt_declaration_unref(&untagged_variant_declaration->p);
@@ -1076,7 +1076,7 @@ struct declaration *ctf_declaration_enum_visit(FILE *fd, int depth,
 	if (!has_body) {
 		assert(name);
 		enum_declaration =
-			lookup_enum_declaration(g_quark_from_string(name),
+			bt_lookup_enum_declaration(g_quark_from_string(name),
 						declaration_scope);
 		bt_declaration_ref(&enum_declaration->p);
 		return &enum_declaration->p;
@@ -1084,7 +1084,7 @@ struct declaration *ctf_declaration_enum_visit(FILE *fd, int depth,
 		/* For unnamed enum, create type */
 		/* For named enum (with body), create type and add to declaration scope */
 		if (name) {
-			if (lookup_enum_declaration(g_quark_from_string(name),
+			if (bt_lookup_enum_declaration(g_quark_from_string(name),
 						    declaration_scope)) {
 				
 				fprintf(fd, "[error] %s: enum %s already declared in scope\n", __func__, name);
@@ -1092,7 +1092,7 @@ struct declaration *ctf_declaration_enum_visit(FILE *fd, int depth,
 			}
 		}
 		if (!container_type) {
-			declaration = lookup_declaration(g_quark_from_static_string("int"),
+			declaration = bt_lookup_declaration(g_quark_from_static_string("int"),
 							 declaration_scope);
 			if (!declaration) {
 				fprintf(fd, "[error] %s: \"int\" type declaration missing for enumeration\n", __func__);
@@ -1132,7 +1132,7 @@ struct declaration *ctf_declaration_enum_visit(FILE *fd, int depth,
 		if (name) {
 			int ret;
 
-			ret = register_enum_declaration(g_quark_from_string(name),
+			ret = bt_register_enum_declaration(g_quark_from_string(name),
 					enum_declaration,
 					declaration_scope);
 			assert(!ret);
@@ -1163,7 +1163,7 @@ struct declaration *ctf_declaration_type_specifier_visit(FILE *fd, int depth,
 	str_c = g_string_free(str, FALSE);
 	id_q = g_quark_from_string(str_c);
 	g_free(str_c);
-	declaration = lookup_declaration(id_q, declaration_scope);
+	declaration = bt_lookup_declaration(id_q, declaration_scope);
 	bt_declaration_ref(declaration);
 	return declaration;
 }
@@ -1442,7 +1442,7 @@ struct declaration *ctf_declaration_integer_visit(FILE *fd, int depth,
 			alignment = CHAR_BIT;
 		}
 	}
-	integer_declaration = integer_declaration_new(size,
+	integer_declaration = bt_integer_declaration_new(size,
 				byte_order, signedness, alignment,
 				base, encoding, clock);
 	return &integer_declaration->p;
@@ -1522,7 +1522,7 @@ struct declaration *ctf_declaration_floating_point_visit(FILE *fd, int depth,
 			alignment = CHAR_BIT;
 		}
 	}
-	float_declaration = float_declaration_new(mant_dig, exp_dig,
+	float_declaration = bt_float_declaration_new(mant_dig, exp_dig,
 				byte_order, alignment);
 	return &float_declaration->p;
 }
@@ -1816,7 +1816,7 @@ int ctf_event_visit(FILE *fd, int depth, struct ctf_node *node,
 
 	event_decl = g_new0(struct bt_ctf_event_decl, 1);
 	event = &event_decl->parent;
-	event->declaration_scope = new_declaration_scope(parent_declaration_scope);
+	event->declaration_scope = bt_new_declaration_scope(parent_declaration_scope);
 	event->loglevel = -1;
 	bt_list_for_each_entry(iter, &node->u.event.declaration_list, siblings) {
 		ret = ctf_event_declaration_visit(fd, depth + 1, iter, event, trace);
@@ -1867,7 +1867,7 @@ error:
 		bt_declaration_unref(&event->fields_decl->p);
 	if (event->context_decl)
 		bt_declaration_unref(&event->context_decl->p);
-	free_declaration_scope(event->declaration_scope);
+	bt_free_declaration_scope(event->declaration_scope);
 	g_free(event_decl);
 	return ret;
 }
@@ -2003,7 +2003,7 @@ int ctf_stream_visit(FILE *fd, int depth, struct ctf_node *node,
 	struct ctf_stream_declaration *stream;
 
 	stream = g_new0(struct ctf_stream_declaration, 1);
-	stream->declaration_scope = new_declaration_scope(parent_declaration_scope);
+	stream->declaration_scope = bt_new_declaration_scope(parent_declaration_scope);
 	stream->events_by_id = g_ptr_array_new();
 	stream->event_quark_to_id = g_hash_table_new(g_direct_hash, g_direct_equal);
 	stream->streams = g_ptr_array_new();
@@ -2048,7 +2048,7 @@ error:
 	g_ptr_array_free(stream->streams, TRUE);
 	g_ptr_array_free(stream->events_by_id, TRUE);
 	g_hash_table_destroy(stream->event_quark_to_id);
-	free_declaration_scope(stream->declaration_scope);
+	bt_free_declaration_scope(stream->declaration_scope);
 	g_free(stream);
 	return ret;
 }
@@ -2199,7 +2199,7 @@ int ctf_trace_visit(FILE *fd, int depth, struct ctf_node *node, struct ctf_trace
 
 	if (trace->declaration_scope)
 		return -EEXIST;
-	trace->declaration_scope = new_declaration_scope(trace->root_declaration_scope);
+	trace->declaration_scope = bt_new_declaration_scope(trace->root_declaration_scope);
 	trace->streams = g_ptr_array_new();
 	trace->event_declarations = g_ptr_array_new();
 	bt_list_for_each_entry(iter, &node->u.trace.declaration_list, siblings) {
@@ -2241,7 +2241,7 @@ error:
 	}
 	g_ptr_array_free(trace->streams, TRUE);
 	g_ptr_array_free(trace->event_declarations, TRUE);
-	free_declaration_scope(trace->declaration_scope);
+	bt_free_declaration_scope(trace->declaration_scope);
 	trace->declaration_scope = NULL;
 	return ret;
 }
@@ -2876,7 +2876,7 @@ int ctf_visitor_construct_metadata(FILE *fd, int depth, struct ctf_node *node,
 				NULL, callsite_free);
 
 retry:
-	trace->root_declaration_scope = new_declaration_scope(NULL);
+	trace->root_declaration_scope = bt_new_declaration_scope(NULL);
 
 	switch (node->type) {
 	case NODE_ROOT:
@@ -2910,7 +2910,7 @@ retry:
 		bt_list_for_each_entry(iter, &node->u.root.trace, siblings) {
 			ret = ctf_trace_visit(fd, depth + 1, iter, trace);
 			if (ret == -EINTR) {
-				free_declaration_scope(trace->root_declaration_scope);
+				bt_free_declaration_scope(trace->root_declaration_scope);
 				/*
 				 * Need to restart creation of type
 				 * definitions, aliases and
@@ -2971,7 +2971,7 @@ retry:
 	return ret;
 
 error:
-	free_declaration_scope(trace->root_declaration_scope);
+	bt_free_declaration_scope(trace->root_declaration_scope);
 	g_hash_table_destroy(trace->callsites);
 	g_hash_table_destroy(trace->clocks);
 	return ret;
@@ -3029,7 +3029,7 @@ int ctf_destroy_metadata(struct ctf_trace *trace)
 			g_ptr_array_free(stream->streams, TRUE);
 			g_ptr_array_free(stream->events_by_id, TRUE);
 			g_hash_table_destroy(stream->event_quark_to_id);
-			free_declaration_scope(stream->declaration_scope);
+			bt_free_declaration_scope(stream->declaration_scope);
 			g_free(stream);
 		}
 		g_ptr_array_free(trace->streams, TRUE);
@@ -3059,7 +3059,7 @@ int ctf_destroy_metadata(struct ctf_trace *trace)
 				bt_declaration_unref(&event->fields_decl->p);
 			if (event->context_decl)
 				bt_declaration_unref(&event->context_decl->p);
-			free_declaration_scope(event->declaration_scope);
+			bt_free_declaration_scope(event->declaration_scope);
 
 			g_free(event);
 		}
@@ -3068,8 +3068,8 @@ int ctf_destroy_metadata(struct ctf_trace *trace)
 	if (trace->packet_header_decl)
 		bt_declaration_unref(&trace->packet_header_decl->p);
 
-	free_declaration_scope(trace->root_declaration_scope);
-	free_declaration_scope(trace->declaration_scope);
+	bt_free_declaration_scope(trace->root_declaration_scope);
+	bt_free_declaration_scope(trace->declaration_scope);
 
 	g_hash_table_destroy(trace->callsites);
 	g_hash_table_destroy(trace->clocks);
diff --git a/formats/ctf/types/float.c b/formats/ctf/types/float.c
index fc7c39c..2dfef86 100644
--- a/formats/ctf/types/float.c
+++ b/formats/ctf/types/float.c
@@ -282,12 +282,12 @@ static
 void __attribute__((constructor)) ctf_float_init(void)
 {
 	static_float_declaration =
-		float_declaration_new(FLT_MANT_DIG,
+		bt_float_declaration_new(FLT_MANT_DIG,
 				sizeof(float) * CHAR_BIT - FLT_MANT_DIG,
 				BYTE_ORDER,
 				__alignof__(float));
 	static_double_declaration =
-		float_declaration_new(DBL_MANT_DIG,
+		bt_float_declaration_new(DBL_MANT_DIG,
 				sizeof(double) * CHAR_BIT - DBL_MANT_DIG,
 				BYTE_ORDER,
 				__alignof__(double));
diff --git a/include/babeltrace/types.h b/include/babeltrace/types.h
index a3d9788..84d0c95 100644
--- a/include/babeltrace/types.h
+++ b/include/babeltrace/types.h
@@ -305,10 +305,10 @@ struct definition_sequence {
 	GString *string;		/* String for encoded integer children */
 };
 
-int register_declaration(GQuark declaration_name,
+int bt_register_declaration(GQuark declaration_name,
 			 struct declaration *declaration,
 			 struct declaration_scope *scope);
-struct declaration *lookup_declaration(GQuark declaration_name,
+struct declaration *bt_lookup_declaration(GQuark declaration_name,
 				struct declaration_scope *scope);
 
 /*
@@ -323,21 +323,21 @@ int bt_register_struct_declaration(GQuark struct_name,
 struct declaration_struct *
 	bt_lookup_struct_declaration(GQuark struct_name,
 				  struct declaration_scope *scope);
-int register_variant_declaration(GQuark variant_name,
+int bt_register_variant_declaration(GQuark variant_name,
 			  struct declaration_untagged_variant *untagged_variant_declaration,
 		          struct declaration_scope *scope);
-struct declaration_untagged_variant *lookup_variant_declaration(GQuark variant_name,
+struct declaration_untagged_variant *bt_lookup_variant_declaration(GQuark variant_name,
 					 struct declaration_scope *scope);
-int register_enum_declaration(GQuark enum_name,
+int bt_register_enum_declaration(GQuark enum_name,
 			      struct declaration_enum *enum_declaration,
 			      struct declaration_scope *scope);
 struct declaration_enum *
-	lookup_enum_declaration(GQuark enum_name,
+	bt_lookup_enum_declaration(GQuark enum_name,
 			        struct declaration_scope *scope);
 
 struct declaration_scope *
-	new_declaration_scope(struct declaration_scope *parent_scope);
-void free_declaration_scope(struct declaration_scope *scope);
+	bt_new_declaration_scope(struct declaration_scope *parent_scope);
+void bt_free_declaration_scope(struct declaration_scope *scope);
 
 /*
  * field_definition is for field definitions. They are registered into
@@ -370,7 +370,7 @@ void bt_declaration_unref(struct declaration *declaration);
 void bt_definition_ref(struct definition *definition);
 void bt_definition_unref(struct definition *definition);
 
-struct declaration_integer *integer_declaration_new(size_t len, int byte_order,
+struct declaration_integer *bt_integer_declaration_new(size_t len, int byte_order,
 				  int signedness, size_t alignment,
 				  int base, enum ctf_string_encoding encoding,
 				  struct ctf_clock *clock);
@@ -386,7 +386,7 @@ enum ctf_string_encoding bt_get_int_encoding(const struct definition *field);
  * mantissa_len is the length of the number of bytes represented by the mantissa
  * (e.g. result of DBL_MANT_DIG). It includes the leading 1.
  */
-struct declaration_float *float_declaration_new(size_t mantissa_len,
+struct declaration_float *bt_float_declaration_new(size_t mantissa_len,
 				  size_t exp_len, int byte_order,
 				  size_t alignment);
 
@@ -458,16 +458,16 @@ uint64_t bt_struct_declaration_len(struct declaration_struct *struct_declaration
  * from numeric values to a single tag. Overlapping tag value ranges are
  * therefore forbidden.
  */
-struct declaration_untagged_variant *untagged_variant_declaration_new(
+struct declaration_untagged_variant *bt_untagged_bt_variant_declaration_new(
 		struct declaration_scope *parent_scope);
-struct declaration_variant *variant_declaration_new(struct declaration_untagged_variant *untagged_variant,
+struct declaration_variant *bt_variant_declaration_new(struct declaration_untagged_variant *untagged_variant,
 		const char *tag);
 
-void untagged_variant_declaration_add_field(struct declaration_untagged_variant *untagged_variant_declaration,
+void bt_untagged_variant_declaration_add_field(struct declaration_untagged_variant *untagged_variant_declaration,
 		const char *field_name,
 		struct declaration *field_declaration);
 struct declaration_field *
-	untagged_variant_declaration_get_field_from_tag(struct declaration_untagged_variant *untagged_variant_declaration,
+	bt_untagged_variant_declaration_get_field_from_tag(struct declaration_untagged_variant *untagged_variant_declaration,
 		GQuark tag);
 /*
  * Returns 0 on success, -EPERM on error.
diff --git a/types/array.c b/types/array.c
index cc9a600..7f82167 100644
--- a/types/array.c
+++ b/types/array.c
@@ -64,7 +64,7 @@ void _array_declaration_free(struct declaration *declaration)
 	struct declaration_array *array_declaration =
 		container_of(declaration, struct declaration_array, p);
 
-	free_declaration_scope(array_declaration->scope);
+	bt_free_declaration_scope(array_declaration->scope);
 	bt_declaration_unref(array_declaration->elem);
 	g_free(array_declaration);
 }
@@ -82,7 +82,7 @@ struct declaration_array *
 	array_declaration->len = len;
 	bt_declaration_ref(elem_declaration);
 	array_declaration->elem = elem_declaration;
-	array_declaration->scope = new_declaration_scope(parent_scope);
+	array_declaration->scope = bt_new_declaration_scope(parent_scope);
 	declaration->id = CTF_TYPE_ARRAY;
 	declaration->alignment = elem_declaration->alignment;
 	declaration->declaration_free = _array_declaration_free;
diff --git a/types/float.c b/types/float.c
index 0fc137f..7b89a89 100644
--- a/types/float.c
+++ b/types/float.c
@@ -52,7 +52,7 @@ void _float_declaration_free(struct declaration *declaration)
 }
 
 struct declaration_float *
-	float_declaration_new(size_t mantissa_len,
+	bt_float_declaration_new(size_t mantissa_len,
 		       size_t exp_len, int byte_order, size_t alignment)
 {
 	struct declaration_float *float_declaration;
@@ -68,13 +68,13 @@ struct declaration_float *
 	declaration->ref = 1;
 	float_declaration->byte_order = byte_order;
 
-	float_declaration->sign = integer_declaration_new(1,
+	float_declaration->sign = bt_integer_declaration_new(1,
 						byte_order, false, 1, 2,
 						CTF_STRING_NONE, NULL);
-	float_declaration->mantissa = integer_declaration_new(mantissa_len - 1,
+	float_declaration->mantissa = bt_integer_declaration_new(mantissa_len - 1,
 						byte_order, false, 1, 10,
 						CTF_STRING_NONE, NULL);
-	float_declaration->exp = integer_declaration_new(exp_len,
+	float_declaration->exp = bt_integer_declaration_new(exp_len,
 						byte_order, true, 1, 10,
 						CTF_STRING_NONE, NULL);
 	return float_declaration;
diff --git a/types/integer.c b/types/integer.c
index 58b6104..936453a 100644
--- a/types/integer.c
+++ b/types/integer.c
@@ -49,7 +49,7 @@ void _integer_declaration_free(struct declaration *declaration)
 }
 
 struct declaration_integer *
-	integer_declaration_new(size_t len, int byte_order,
+	bt_integer_declaration_new(size_t len, int byte_order,
 			 int signedness, size_t alignment, int base,
 			 enum ctf_string_encoding encoding,
 			 struct ctf_clock *clock)
diff --git a/types/sequence.c b/types/sequence.c
index 6ed168c..1795ae4 100644
--- a/types/sequence.c
+++ b/types/sequence.c
@@ -93,7 +93,7 @@ void _sequence_declaration_free(struct declaration *declaration)
 	struct declaration_sequence *sequence_declaration =
 		container_of(declaration, struct declaration_sequence, p);
 
-	free_declaration_scope(sequence_declaration->scope);
+	bt_free_declaration_scope(sequence_declaration->scope);
 	g_array_free(sequence_declaration->length_name, TRUE);
 	bt_declaration_unref(sequence_declaration->elem);
 	g_free(sequence_declaration);
@@ -115,7 +115,7 @@ struct declaration_sequence *
 
 	bt_declaration_ref(elem_declaration);
 	sequence_declaration->elem = elem_declaration;
-	sequence_declaration->scope = new_declaration_scope(parent_scope);
+	sequence_declaration->scope = bt_new_declaration_scope(parent_scope);
 	declaration->id = CTF_TYPE_SEQUENCE;
 	declaration->alignment = elem_declaration->alignment;
 	declaration->declaration_free = _sequence_declaration_free;
diff --git a/types/struct.c b/types/struct.c
index f065dbc..76b82d2 100644
--- a/types/struct.c
+++ b/types/struct.c
@@ -67,7 +67,7 @@ void _struct_declaration_free(struct declaration *declaration)
 		container_of(declaration, struct declaration_struct, p);
 	unsigned long i;
 
-	free_declaration_scope(struct_declaration->scope);
+	bt_free_declaration_scope(struct_declaration->scope);
 	g_hash_table_destroy(struct_declaration->fields_by_name);
 
 	for (i = 0; i < struct_declaration->fields->len; i++) {
@@ -94,7 +94,7 @@ struct declaration_struct *
 	struct_declaration->fields = g_array_sized_new(FALSE, TRUE,
 						sizeof(struct declaration_field),
 						DEFAULT_NR_STRUCT_FIELDS);
-	struct_declaration->scope = new_declaration_scope(parent_scope);
+	struct_declaration->scope = bt_new_declaration_scope(parent_scope);
 	declaration->id = CTF_TYPE_STRUCT;
 	declaration->alignment = max(1, min_align);
 	declaration->declaration_free = _struct_declaration_free;
diff --git a/types/types.c b/types/types.c
index 615ab70..912c8d5 100644
--- a/types/types.c
+++ b/types/types.c
@@ -52,20 +52,20 @@ GQuark prefix_quark(const char *prefix, GQuark quark)
 
 static
 struct declaration *
-	lookup_declaration_scope(GQuark declaration_name,
+	bt_lookup_declaration_scope(GQuark declaration_name,
 		struct declaration_scope *scope)
 {
 	return g_hash_table_lookup(scope->typedef_declarations,
 				   (gconstpointer) (unsigned long) declaration_name);
 }
 
-struct declaration *lookup_declaration(GQuark declaration_name,
+struct declaration *bt_lookup_declaration(GQuark declaration_name,
 		struct declaration_scope *scope)
 {
 	struct declaration *declaration;
 
 	while (scope) {
-		declaration = lookup_declaration_scope(declaration_name,
+		declaration = bt_lookup_declaration_scope(declaration_name,
 						       scope);
 		if (declaration)
 			return declaration;
@@ -74,14 +74,14 @@ struct declaration *lookup_declaration(GQuark declaration_name,
 	return NULL;
 }
 
-int register_declaration(GQuark name, struct declaration *declaration,
+int bt_register_declaration(GQuark name, struct declaration *declaration,
 		struct declaration_scope *scope)
 {
 	if (!name)
 		return -EPERM;
 
 	/* Only lookup in local scope */
-	if (lookup_declaration_scope(name, scope))
+	if (bt_lookup_declaration_scope(name, scope))
 		return -EEXIST;
 
 	g_hash_table_insert(scope->typedef_declarations,
@@ -306,7 +306,7 @@ void bt_definition_unref(struct definition *definition)
 }
 
 struct declaration_scope *
-	new_declaration_scope(struct declaration_scope *parent_scope)
+	bt_new_declaration_scope(struct declaration_scope *parent_scope)
 {
 	struct declaration_scope *scope = g_new(struct declaration_scope, 1);
 
@@ -326,7 +326,7 @@ struct declaration_scope *
 	return scope;
 }
 
-void free_declaration_scope(struct declaration_scope *scope)
+void bt_free_declaration_scope(struct declaration_scope *scope)
 {
 	g_hash_table_destroy(scope->enum_declarations);
 	g_hash_table_destroy(scope->variant_declarations);
@@ -378,14 +378,14 @@ int bt_register_struct_declaration(GQuark struct_name,
 
 	/* Also add in typedef/typealias scopes */
 	prefix_name = prefix_quark("struct ", struct_name);
-	ret = register_declaration(prefix_name, &struct_declaration->p, scope);
+	ret = bt_register_declaration(prefix_name, &struct_declaration->p, scope);
 	assert(!ret);
 	return 0;
 }
 
 static
 struct declaration_untagged_variant *
-	lookup_variant_declaration_scope(GQuark variant_name,
+	bt_lookup_variant_declaration_scope(GQuark variant_name,
 		struct declaration_scope *scope)
 {
 	return g_hash_table_lookup(scope->variant_declarations,
@@ -393,13 +393,13 @@ struct declaration_untagged_variant *
 }
 
 struct declaration_untagged_variant *
-	lookup_variant_declaration(GQuark variant_name,
+	bt_lookup_variant_declaration(GQuark variant_name,
 		struct declaration_scope *scope)
 {
 	struct declaration_untagged_variant *declaration;
 
 	while (scope) {
-		declaration = lookup_variant_declaration_scope(variant_name, scope);
+		declaration = bt_lookup_variant_declaration_scope(variant_name, scope);
 		if (declaration)
 			return declaration;
 		scope = scope->parent_scope;
@@ -407,7 +407,7 @@ struct declaration_untagged_variant *
 	return NULL;
 }
 
-int register_variant_declaration(GQuark variant_name,
+int bt_register_variant_declaration(GQuark variant_name,
 		struct declaration_untagged_variant *untagged_variant_declaration,
 		struct declaration_scope *scope)
 {
@@ -418,7 +418,7 @@ int register_variant_declaration(GQuark variant_name,
 		return -EPERM;
 
 	/* Only lookup in local scope */
-	if (lookup_variant_declaration_scope(variant_name, scope))
+	if (bt_lookup_variant_declaration_scope(variant_name, scope))
 		return -EEXIST;
 
 	g_hash_table_insert(scope->variant_declarations,
@@ -428,7 +428,7 @@ int register_variant_declaration(GQuark variant_name,
 
 	/* Also add in typedef/typealias scopes */
 	prefix_name = prefix_quark("variant ", variant_name);
-	ret = register_declaration(prefix_name,
+	ret = bt_register_declaration(prefix_name,
 			&untagged_variant_declaration->p, scope);
 	assert(!ret);
 	return 0;
@@ -436,7 +436,7 @@ int register_variant_declaration(GQuark variant_name,
 
 static
 struct declaration_enum *
-	lookup_enum_declaration_scope(GQuark enum_name,
+	bt_lookup_enum_declaration_scope(GQuark enum_name,
 		struct declaration_scope *scope)
 {
 	return g_hash_table_lookup(scope->enum_declarations,
@@ -444,13 +444,13 @@ struct declaration_enum *
 }
 
 struct declaration_enum *
-	lookup_enum_declaration(GQuark enum_name,
+	bt_lookup_enum_declaration(GQuark enum_name,
 		struct declaration_scope *scope)
 {
 	struct declaration_enum *declaration;
 
 	while (scope) {
-		declaration = lookup_enum_declaration_scope(enum_name, scope);
+		declaration = bt_lookup_enum_declaration_scope(enum_name, scope);
 		if (declaration)
 			return declaration;
 		scope = scope->parent_scope;
@@ -458,7 +458,7 @@ struct declaration_enum *
 	return NULL;
 }
 
-int register_enum_declaration(GQuark enum_name,
+int bt_register_enum_declaration(GQuark enum_name,
 		struct declaration_enum *enum_declaration,
 		struct declaration_scope *scope)
 {
@@ -469,7 +469,7 @@ int register_enum_declaration(GQuark enum_name,
 		return -EPERM;
 
 	/* Only lookup in local scope */
-	if (lookup_enum_declaration_scope(enum_name, scope))
+	if (bt_lookup_enum_declaration_scope(enum_name, scope))
 		return -EEXIST;
 
 	g_hash_table_insert(scope->enum_declarations,
@@ -479,7 +479,7 @@ int register_enum_declaration(GQuark enum_name,
 
 	/* Also add in typedef/typealias scopes */
 	prefix_name = prefix_quark("enum ", enum_name);
-	ret = register_declaration(prefix_name, &enum_declaration->p, scope);
+	ret = bt_register_declaration(prefix_name, &enum_declaration->p, scope);
 	assert(!ret);
 	return 0;
 }
diff --git a/types/variant.c b/types/variant.c
index 47c821e..ba4179d 100644
--- a/types/variant.c
+++ b/types/variant.c
@@ -56,7 +56,7 @@ void _untagged_variant_declaration_free(struct declaration *declaration)
 		container_of(declaration, struct declaration_untagged_variant, p);
 	unsigned long i;
 
-	free_declaration_scope(untagged_variant_declaration->scope);
+	bt_free_declaration_scope(untagged_variant_declaration->scope);
 	g_hash_table_destroy(untagged_variant_declaration->fields_by_tag);
 
 	for (i = 0; i < untagged_variant_declaration->fields->len; i++) {
@@ -69,7 +69,7 @@ void _untagged_variant_declaration_free(struct declaration *declaration)
 	g_free(untagged_variant_declaration);
 }
 
-struct declaration_untagged_variant *untagged_variant_declaration_new(
+struct declaration_untagged_variant *bt_untagged_bt_variant_declaration_new(
 				      struct declaration_scope *parent_scope)
 {
 	struct declaration_untagged_variant *untagged_variant_declaration;
@@ -82,7 +82,7 @@ struct declaration_untagged_variant *untagged_variant_declaration_new(
 	untagged_variant_declaration->fields = g_array_sized_new(FALSE, TRUE,
 						 sizeof(struct declaration_field),
 						 DEFAULT_NR_STRUCT_FIELDS);
-	untagged_variant_declaration->scope = new_declaration_scope(parent_scope);
+	untagged_variant_declaration->scope = bt_new_declaration_scope(parent_scope);
 	declaration->id = CTF_TYPE_UNTAGGED_VARIANT;
 	declaration->alignment = 1;
 	declaration->declaration_free = _untagged_variant_declaration_free;
@@ -104,7 +104,7 @@ void _variant_declaration_free(struct declaration *declaration)
 }
 
 struct declaration_variant *
-	variant_declaration_new(struct declaration_untagged_variant *untagged_variant, const char *tag)
+	bt_variant_declaration_new(struct declaration_untagged_variant *untagged_variant, const char *tag)
 {
 	struct declaration_variant *variant_declaration;
 	struct declaration *declaration;
@@ -257,7 +257,7 @@ void _variant_definition_free(struct definition *definition)
 	g_free(variant);
 }
 
-void untagged_variant_declaration_add_field(struct declaration_untagged_variant *untagged_variant_declaration,
+void bt_untagged_variant_declaration_add_field(struct declaration_untagged_variant *untagged_variant_declaration,
 			    const char *field_name,
 			    struct declaration *field_declaration)
 {
@@ -282,7 +282,7 @@ void untagged_variant_declaration_add_field(struct declaration_untagged_variant
 }
 
 struct declaration_field *
-untagged_variant_declaration_get_field_from_tag(struct declaration_untagged_variant *untagged_variant_declaration, GQuark tag)
+bt_untagged_variant_declaration_get_field_from_tag(struct declaration_untagged_variant *untagged_variant_declaration, GQuark tag)
 {
 	gpointer index;
 	gboolean found;
-- 
1.7.10.4
