From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 06/18] namespace declaration_ref and
	declaration_unref
Date: Thu, 24 Jan 2013 16:21:38 -0500
Message-ID: <1359062510-7557-6-git-send-email-jdesfossez__29383.8266203695$1359062610$gmane$org@efficios.com>
References: <1359062510-7557-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TyUFN-0008Eg-4W
	for lttng-dev@lists.lttng.org; Thu, 24 Jan 2013 16:22:10 -0500
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
 .../ctf/metadata/ctf-visitor-generate-io-struct.c  |   56 ++++++++++----------
 formats/ctf/types/float.c                          |    4 +-
 include/babeltrace/types.h                         |    4 +-
 types/array.c                                      |   10 ++--
 types/enum.c                                       |    8 +--
 types/float.c                                      |   10 ++--
 types/integer.c                                    |    4 +-
 types/sequence.c                                   |   10 ++--
 types/string.c                                     |    4 +-
 types/struct.c                                     |   10 ++--
 types/types.c                                      |   20 +++----
 types/variant.c                                    |   14 ++---
 12 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
index 97d15e7..9693345 100644
--- a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
+++ b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
@@ -516,7 +516,7 @@ struct declaration *ctf_type_declarator_visit(FILE *fd, int depth,
 				fprintf(fd, "[error] %s: cannot create array declaration.\n", __func__);
 				return NULL;
 			}
-			declaration_unref(nested_declaration);
+			bt_declaration_unref(nested_declaration);
 			declaration = &array_declaration->p;
 			break;
 		}
@@ -532,7 +532,7 @@ struct declaration *ctf_type_declarator_visit(FILE *fd, int depth,
 				g_free(length_name);
 				return NULL;
 			}
-			declaration_unref(nested_declaration);
+			bt_declaration_unref(nested_declaration);
 			declaration = &sequence_declaration->p;
 			g_free(length_name);
 			break;
@@ -583,7 +583,7 @@ int ctf_struct_type_declarators_visit(FILE *fd, int depth,
 		struct_declaration_add_field(struct_declaration,
 					     g_quark_to_string(field_name),
 					     field_declaration);
-		declaration_unref(field_declaration);
+		bt_declaration_unref(field_declaration);
 	}
 	return 0;
 }
@@ -620,7 +620,7 @@ int ctf_variant_type_declarators_visit(FILE *fd, int depth,
 		untagged_variant_declaration_add_field(untagged_variant_declaration,
 					      g_quark_to_string(field_name),
 					      field_declaration);
-		declaration_unref(field_declaration);
+		bt_declaration_unref(field_declaration);
 	}
 	return 0;
 }
@@ -652,7 +652,7 @@ int ctf_typedef_visit(FILE *fd, int depth, struct declaration_scope *scope,
 		 */
 		if (type_declaration->id == CTF_TYPE_UNTAGGED_VARIANT) {
 			fprintf(fd, "[error] %s: typedef of untagged variant is not permitted.\n", __func__);
-			declaration_unref(type_declaration);
+			bt_declaration_unref(type_declaration);
 			return -EPERM;
 		}
 		ret = register_declaration(identifier, type_declaration, scope);
@@ -660,7 +660,7 @@ int ctf_typedef_visit(FILE *fd, int depth, struct declaration_scope *scope,
 			type_declaration->declaration_free(type_declaration);
 			return ret;
 		}
-		declaration_unref(type_declaration);
+		bt_declaration_unref(type_declaration);
 	}
 	return 0;
 }
@@ -702,7 +702,7 @@ int ctf_typealias_visit(FILE *fd, int depth, struct declaration_scope *scope,
 	 */
 	if (type_declaration->id == CTF_TYPE_UNTAGGED_VARIANT) {
 		fprintf(fd, "[error] %s: typedef of untagged variant is not permitted.\n", __func__);
-		declaration_unref(type_declaration);
+		bt_declaration_unref(type_declaration);
 		return -EPERM;
 	}
 	/*
@@ -725,7 +725,7 @@ int ctf_typealias_visit(FILE *fd, int depth, struct declaration_scope *scope,
 	err = register_declaration(alias_q, type_declaration, scope);
 	if (err)
 		goto error;
-	declaration_unref(type_declaration);
+	bt_declaration_unref(type_declaration);
 	return 0;
 
 error:
@@ -842,7 +842,7 @@ struct declaration *ctf_declaration_struct_visit(FILE *fd,
 		struct_declaration =
 			lookup_struct_declaration(g_quark_from_string(name),
 						  declaration_scope);
-		declaration_ref(&struct_declaration->p);
+		bt_declaration_ref(&struct_declaration->p);
 		return &struct_declaration->p;
 	} else {
 		uint64_t min_align_value = 0;
@@ -914,7 +914,7 @@ struct declaration *ctf_declaration_variant_visit(FILE *fd,
 		untagged_variant_declaration =
 			lookup_variant_declaration(g_quark_from_string(name),
 						   declaration_scope);
-		declaration_ref(&untagged_variant_declaration->p);
+		bt_declaration_ref(&untagged_variant_declaration->p);
 	} else {
 		/* For unnamed variant, create type */
 		/* For named variant (with body), create type and add to declaration scope */
@@ -954,7 +954,7 @@ struct declaration *ctf_declaration_variant_visit(FILE *fd,
 		variant_declaration = variant_declaration_new(untagged_variant_declaration, choice);
 		if (!variant_declaration)
 			goto error;
-		declaration_unref(&untagged_variant_declaration->p);
+		bt_declaration_unref(&untagged_variant_declaration->p);
 		return &variant_declaration->p;
 	}
 error:
@@ -1078,7 +1078,7 @@ struct declaration *ctf_declaration_enum_visit(FILE *fd, int depth,
 		enum_declaration =
 			lookup_enum_declaration(g_quark_from_string(name),
 						declaration_scope);
-		declaration_ref(&enum_declaration->p);
+		bt_declaration_ref(&enum_declaration->p);
 		return &enum_declaration->p;
 	} else {
 		/* For unnamed enum, create type */
@@ -1115,7 +1115,7 @@ struct declaration *ctf_declaration_enum_visit(FILE *fd, int depth,
 		}
 		integer_declaration = container_of(declaration, struct declaration_integer, p);
 		enum_declaration = enum_declaration_new(integer_declaration);
-		declaration_unref(&integer_declaration->p);	/* leave ref to enum */
+		bt_declaration_unref(&integer_declaration->p);	/* leave ref to enum */
 		if (enum_declaration->integer_declaration->signedness) {
 			last_value.u.s = 0;
 		} else {
@@ -1136,7 +1136,7 @@ struct declaration *ctf_declaration_enum_visit(FILE *fd, int depth,
 					enum_declaration,
 					declaration_scope);
 			assert(!ret);
-			declaration_unref(&enum_declaration->p);
+			bt_declaration_unref(&enum_declaration->p);
 		}
 		return &enum_declaration->p;
 	}
@@ -1164,7 +1164,7 @@ struct declaration *ctf_declaration_type_specifier_visit(FILE *fd, int depth,
 	id_q = g_quark_from_string(str_c);
 	g_free(str_c);
 	declaration = lookup_declaration(id_q, declaration_scope);
-	declaration_ref(declaration);
+	bt_declaration_ref(declaration);
 	return declaration;
 }
 
@@ -1864,9 +1864,9 @@ int ctf_event_visit(FILE *fd, int depth, struct ctf_node *node,
 
 error:
 	if (event->fields_decl)
-		declaration_unref(&event->fields_decl->p);
+		bt_declaration_unref(&event->fields_decl->p);
 	if (event->context_decl)
-		declaration_unref(&event->context_decl->p);
+		bt_declaration_unref(&event->context_decl->p);
 	free_declaration_scope(event->declaration_scope);
 	g_free(event_decl);
 	return ret;
@@ -2040,11 +2040,11 @@ int ctf_stream_visit(FILE *fd, int depth, struct ctf_node *node,
 
 error:
 	if (stream->event_header_decl)
-		declaration_unref(&stream->event_header_decl->p);
+		bt_declaration_unref(&stream->event_header_decl->p);
 	if (stream->event_context_decl)
-		declaration_unref(&stream->event_context_decl->p);
+		bt_declaration_unref(&stream->event_context_decl->p);
 	if (stream->packet_context_decl)
-		declaration_unref(&stream->packet_context_decl->p);
+		bt_declaration_unref(&stream->packet_context_decl->p);
 	g_ptr_array_free(stream->streams, TRUE);
 	g_ptr_array_free(stream->events_by_id, TRUE);
 	g_hash_table_destroy(stream->event_quark_to_id);
@@ -2236,7 +2236,7 @@ int ctf_trace_visit(FILE *fd, int depth, struct ctf_node *node, struct ctf_trace
 
 error:
 	if (trace->packet_header_decl) {
-		declaration_unref(&trace->packet_header_decl->p);
+		bt_declaration_unref(&trace->packet_header_decl->p);
 		trace->packet_header_decl = NULL;
 	}
 	g_ptr_array_free(trace->streams, TRUE);
@@ -2851,7 +2851,7 @@ int ctf_root_declaration_visit(FILE *fd, int depth, struct ctf_node *node, struc
 			node, trace->root_declaration_scope, trace);
 		if (!declaration)
 			return -ENOMEM;
-		declaration_unref(declaration);
+		bt_declaration_unref(declaration);
 		break;
 	}
 	default:
@@ -3021,11 +3021,11 @@ int ctf_destroy_metadata(struct ctf_trace *trace)
 				g_free(stream_def);
 			}
 			if (stream->event_header_decl)
-				declaration_unref(&stream->event_header_decl->p);
+				bt_declaration_unref(&stream->event_header_decl->p);
 			if (stream->event_context_decl)
-				declaration_unref(&stream->event_context_decl->p);
+				bt_declaration_unref(&stream->event_context_decl->p);
 			if (stream->packet_context_decl)
-				declaration_unref(&stream->packet_context_decl->p);
+				bt_declaration_unref(&stream->packet_context_decl->p);
 			g_ptr_array_free(stream->streams, TRUE);
 			g_ptr_array_free(stream->events_by_id, TRUE);
 			g_hash_table_destroy(stream->event_quark_to_id);
@@ -3056,9 +3056,9 @@ int ctf_destroy_metadata(struct ctf_trace *trace)
 
 			event = &event_decl->parent;
 			if (event->fields_decl)
-				declaration_unref(&event->fields_decl->p);
+				bt_declaration_unref(&event->fields_decl->p);
 			if (event->context_decl)
-				declaration_unref(&event->context_decl->p);
+				bt_declaration_unref(&event->context_decl->p);
 			free_declaration_scope(event->declaration_scope);
 
 			g_free(event);
@@ -3066,7 +3066,7 @@ int ctf_destroy_metadata(struct ctf_trace *trace)
 		g_ptr_array_free(trace->event_declarations, TRUE);
 	}
 	if (trace->packet_header_decl)
-		declaration_unref(&trace->packet_header_decl->p);
+		bt_declaration_unref(&trace->packet_header_decl->p);
 
 	free_declaration_scope(trace->root_declaration_scope);
 	free_declaration_scope(trace->declaration_scope);
diff --git a/formats/ctf/types/float.c b/formats/ctf/types/float.c
index 054e262..d77cff5 100644
--- a/formats/ctf/types/float.c
+++ b/formats/ctf/types/float.c
@@ -296,6 +296,6 @@ void __attribute__((constructor)) ctf_float_init(void)
 static
 void __attribute__((destructor)) ctf_float_fini(void)
 {
-	declaration_unref(&static_float_declaration->p);
-	declaration_unref(&static_double_declaration->p);
+	bt_declaration_unref(&static_float_declaration->p);
+	bt_declaration_unref(&static_double_declaration->p);
 }
diff --git a/include/babeltrace/types.h b/include/babeltrace/types.h
index 3b45fd5..2348823 100644
--- a/include/babeltrace/types.h
+++ b/include/babeltrace/types.h
@@ -364,8 +364,8 @@ int compare_definition_path(struct definition *definition, GQuark path)
 	return definition->path == path;
 }
 
-void declaration_ref(struct declaration *declaration);
-void declaration_unref(struct declaration *declaration);
+void bt_declaration_ref(struct declaration *declaration);
+void bt_declaration_unref(struct declaration *declaration);
 
 void definition_ref(struct definition *definition);
 void definition_unref(struct definition *definition);
diff --git a/types/array.c b/types/array.c
index d2db46f..cc9a600 100644
--- a/types/array.c
+++ b/types/array.c
@@ -65,7 +65,7 @@ void _array_declaration_free(struct declaration *declaration)
 		container_of(declaration, struct declaration_array, p);
 
 	free_declaration_scope(array_declaration->scope);
-	declaration_unref(array_declaration->elem);
+	bt_declaration_unref(array_declaration->elem);
 	g_free(array_declaration);
 }
 
@@ -80,7 +80,7 @@ struct declaration_array *
 	array_declaration = g_new(struct declaration_array, 1);
 	declaration = &array_declaration->p;
 	array_declaration->len = len;
-	declaration_ref(elem_declaration);
+	bt_declaration_ref(elem_declaration);
 	array_declaration->elem = elem_declaration;
 	array_declaration->scope = new_declaration_scope(parent_scope);
 	declaration->id = CTF_TYPE_ARRAY;
@@ -105,7 +105,7 @@ struct definition *
 	int i;
 
 	array = g_new(struct definition_array, 1);
-	declaration_ref(&array_declaration->p);
+	bt_declaration_ref(&array_declaration->p);
 	array->p.declaration = declaration;
 	array->declaration = array_declaration;
 	array->p.ref = 1;
@@ -170,7 +170,7 @@ error:
 	}
 	(void) g_ptr_array_free(array->elems, TRUE);
 	free_definition_scope(array->p.scope);
-	declaration_unref(array->p.declaration);
+	bt_declaration_unref(array->p.declaration);
 	g_free(array);
 	return NULL;
 }
@@ -194,7 +194,7 @@ void _array_definition_free(struct definition *definition)
 		(void) g_ptr_array_free(array->elems, TRUE);
 	}
 	free_definition_scope(array->p.scope);
-	declaration_unref(array->p.declaration);
+	bt_declaration_unref(array->p.declaration);
 	g_free(array);
 }
 
diff --git a/types/enum.c b/types/enum.c
index ca0143d..2ea40ba 100644
--- a/types/enum.c
+++ b/types/enum.c
@@ -386,7 +386,7 @@ void _enum_declaration_free(struct declaration *declaration)
 		g_free(iter);
 	}
 	g_hash_table_destroy(enum_declaration->table.quark_to_range_set);
-	declaration_unref(&enum_declaration->integer_declaration->p);
+	bt_declaration_unref(&enum_declaration->integer_declaration->p);
 	g_free(enum_declaration);
 }
 
@@ -405,7 +405,7 @@ struct declaration_enum *
 	enum_declaration->table.quark_to_range_set = g_hash_table_new_full(g_direct_hash,
 							g_direct_equal,
 							NULL, enum_range_set_free);
-	declaration_ref(&integer_declaration->p);
+	bt_declaration_ref(&integer_declaration->p);
 	enum_declaration->integer_declaration = integer_declaration;
 	enum_declaration->p.id = CTF_TYPE_ENUM;
 	enum_declaration->p.alignment = 1;
@@ -430,7 +430,7 @@ struct definition *
 	int ret;
 
 	_enum = g_new(struct definition_enum, 1);
-	declaration_ref(&enum_declaration->p);
+	bt_declaration_ref(&enum_declaration->p);
 	_enum->p.declaration = declaration;
 	_enum->declaration = enum_declaration;
 	_enum->p.ref = 1;
@@ -463,7 +463,7 @@ void _enum_definition_free(struct definition *definition)
 
 	definition_unref(&_enum->integer->p);
 	free_definition_scope(_enum->p.scope);
-	declaration_unref(_enum->p.declaration);
+	bt_declaration_unref(_enum->p.declaration);
 	if (_enum->value)
 		g_array_unref(_enum->value);
 	g_free(_enum);
diff --git a/types/float.c b/types/float.c
index 028749b..5c80312 100644
--- a/types/float.c
+++ b/types/float.c
@@ -45,9 +45,9 @@ void _float_declaration_free(struct declaration *declaration)
 	struct declaration_float *float_declaration =
 		container_of(declaration, struct declaration_float, p);
 
-	declaration_unref(&float_declaration->exp->p);
-	declaration_unref(&float_declaration->mantissa->p);
-	declaration_unref(&float_declaration->sign->p);
+	bt_declaration_unref(&float_declaration->exp->p);
+	bt_declaration_unref(&float_declaration->mantissa->p);
+	bt_declaration_unref(&float_declaration->sign->p);
 	g_free(float_declaration);
 }
 
@@ -93,7 +93,7 @@ struct definition *
 	struct definition *tmp;
 
 	_float = g_new(struct definition_float, 1);
-	declaration_ref(&float_declaration->p);
+	bt_declaration_ref(&float_declaration->p);
 	_float->p.declaration = declaration;
 	_float->declaration = float_declaration;
 	_float->p.scope = new_definition_scope(parent_scope, field_name, root_name);
@@ -147,6 +147,6 @@ void _float_definition_free(struct definition *definition)
 	definition_unref(&_float->exp->p);
 	definition_unref(&_float->mantissa->p);
 	free_definition_scope(_float->p.scope);
-	declaration_unref(_float->p.declaration);
+	bt_declaration_unref(_float->p.declaration);
 	g_free(_float);
 }
diff --git a/types/integer.c b/types/integer.c
index 337641d..20e7688 100644
--- a/types/integer.c
+++ b/types/integer.c
@@ -85,7 +85,7 @@ struct definition *
 	int ret;
 
 	integer = g_new(struct definition_integer, 1);
-	declaration_ref(&integer_declaration->p);
+	bt_declaration_ref(&integer_declaration->p);
 	integer->p.declaration = declaration;
 	integer->declaration = integer_declaration;
 	integer->p.ref = 1;
@@ -111,7 +111,7 @@ void _integer_definition_free(struct definition *definition)
 	struct definition_integer *integer =
 		container_of(definition, struct definition_integer, p);
 
-	declaration_unref(integer->p.declaration);
+	bt_declaration_unref(integer->p.declaration);
 	g_free(integer);
 }
 
diff --git a/types/sequence.c b/types/sequence.c
index 3967f97..18d7e35 100644
--- a/types/sequence.c
+++ b/types/sequence.c
@@ -95,7 +95,7 @@ void _sequence_declaration_free(struct declaration *declaration)
 
 	free_declaration_scope(sequence_declaration->scope);
 	g_array_free(sequence_declaration->length_name, TRUE);
-	declaration_unref(sequence_declaration->elem);
+	bt_declaration_unref(sequence_declaration->elem);
 	g_free(sequence_declaration);
 }
 
@@ -113,7 +113,7 @@ struct declaration_sequence *
 	sequence_declaration->length_name = g_array_new(FALSE, TRUE, sizeof(GQuark));
 	bt_append_scope_path(length, sequence_declaration->length_name);
 
-	declaration_ref(elem_declaration);
+	bt_declaration_ref(elem_declaration);
 	sequence_declaration->elem = elem_declaration;
 	sequence_declaration->scope = new_declaration_scope(parent_scope);
 	declaration->id = CTF_TYPE_SEQUENCE;
@@ -138,7 +138,7 @@ struct definition *_sequence_definition_new(struct declaration *declaration,
 	int ret;
 
 	sequence = g_new(struct definition_sequence, 1);
-	declaration_ref(&sequence_declaration->p);
+	bt_declaration_ref(&sequence_declaration->p);
 	sequence->p.declaration = declaration;
 	sequence->declaration = sequence_declaration;
 	sequence->p.ref = 1;
@@ -192,7 +192,7 @@ struct definition *_sequence_definition_new(struct declaration *declaration,
 
 error:
 	free_definition_scope(sequence->p.scope);
-	declaration_unref(&sequence_declaration->p);
+	bt_declaration_unref(&sequence_declaration->p);
 	g_free(sequence);
 	return NULL;
 }
@@ -218,7 +218,7 @@ void _sequence_definition_free(struct definition *definition)
 	}
 	definition_unref(len_definition);
 	free_definition_scope(sequence->p.scope);
-	declaration_unref(sequence->p.declaration);
+	bt_declaration_unref(sequence->p.declaration);
 	g_free(sequence);
 }
 
diff --git a/types/string.c b/types/string.c
index 4860740..cebce12 100644
--- a/types/string.c
+++ b/types/string.c
@@ -76,7 +76,7 @@ struct definition *
 	int ret;
 
 	string = g_new(struct definition_string, 1);
-	declaration_ref(&string_declaration->p);
+	bt_declaration_ref(&string_declaration->p);
 	string->p.declaration = declaration;
 	string->declaration = string_declaration;
 	string->p.ref = 1;
@@ -104,7 +104,7 @@ void _string_definition_free(struct definition *definition)
 	struct definition_string *string =
 		container_of(definition, struct definition_string, p);
 
-	declaration_unref(string->p.declaration);
+	bt_declaration_unref(string->p.declaration);
 	g_free(string->value);
 	g_free(string);
 }
diff --git a/types/struct.c b/types/struct.c
index 138da16..5cc0849 100644
--- a/types/struct.c
+++ b/types/struct.c
@@ -74,7 +74,7 @@ void _struct_declaration_free(struct declaration *declaration)
 		struct declaration_field *declaration_field =
 			&g_array_index(struct_declaration->fields,
 				       struct declaration_field, i);
-		declaration_unref(declaration_field->declaration);
+		bt_declaration_unref(declaration_field->declaration);
 	}
 	g_array_free(struct_declaration->fields, true);
 	g_free(struct_declaration);
@@ -118,7 +118,7 @@ struct definition *
 	int ret;
 
 	_struct = g_new(struct definition_struct, 1);
-	declaration_ref(&struct_declaration->p);
+	bt_declaration_ref(&struct_declaration->p);
 	_struct->p.declaration = declaration;
 	_struct->declaration = struct_declaration;
 	_struct->p.ref = 1;
@@ -158,7 +158,7 @@ error:
 		definition_unref(field);
 	}
 	free_definition_scope(_struct->p.scope);
-	declaration_unref(&struct_declaration->p);
+	bt_declaration_unref(&struct_declaration->p);
 	g_free(_struct);
 	return NULL;
 }
@@ -176,7 +176,7 @@ void _struct_definition_free(struct definition *definition)
 		definition_unref(field);
 	}
 	free_definition_scope(_struct->p.scope);
-	declaration_unref(_struct->p.declaration);
+	bt_declaration_unref(_struct->p.declaration);
 	g_ptr_array_free(_struct->fields, TRUE);
 	g_free(_struct);
 }
@@ -192,7 +192,7 @@ void struct_declaration_add_field(struct declaration_struct *struct_declaration,
 	index = struct_declaration->fields->len - 1;	/* last field (new) */
 	field = &g_array_index(struct_declaration->fields, struct declaration_field, index);
 	field->name = g_quark_from_string(field_name);
-	declaration_ref(field_declaration);
+	bt_declaration_ref(field_declaration);
 	field->declaration = field_declaration;
 	/* Keep index in hash rather than pointer, because array can relocate */
 	g_hash_table_insert(struct_declaration->fields_by_name,
diff --git a/types/types.c b/types/types.c
index 9c5cfca..5bb051f 100644
--- a/types/types.c
+++ b/types/types.c
@@ -87,7 +87,7 @@ int register_declaration(GQuark name, struct declaration *declaration,
 	g_hash_table_insert(scope->typedef_declarations,
 			    (gpointer) (unsigned long) name,
 			    declaration);
-	declaration_ref(declaration);
+	bt_declaration_ref(declaration);
 	return 0;
 }
 
@@ -279,12 +279,12 @@ int register_field_definition(GQuark field_name, struct definition *definition,
 	return 0;
 }
 
-void declaration_ref(struct declaration *declaration)
+void bt_declaration_ref(struct declaration *declaration)
 {
 	declaration->ref++;
 }
 
-void declaration_unref(struct declaration *declaration)
+void bt_declaration_unref(struct declaration *declaration)
 {
 	if (!declaration)
 		return;
@@ -312,16 +312,16 @@ struct declaration_scope *
 
 	scope->typedef_declarations = g_hash_table_new_full(g_direct_hash,
 					g_direct_equal, NULL,
-					(GDestroyNotify) declaration_unref);
+					(GDestroyNotify) bt_declaration_unref);
 	scope->struct_declarations = g_hash_table_new_full(g_direct_hash,
 					g_direct_equal, NULL,
-					(GDestroyNotify) declaration_unref);
+					(GDestroyNotify) bt_declaration_unref);
 	scope->variant_declarations = g_hash_table_new_full(g_direct_hash,
 					g_direct_equal, NULL,
-					(GDestroyNotify) declaration_unref);
+					(GDestroyNotify) bt_declaration_unref);
 	scope->enum_declarations = g_hash_table_new_full(g_direct_hash,
 					g_direct_equal, NULL,
-					(GDestroyNotify) declaration_unref);
+					(GDestroyNotify) bt_declaration_unref);
 	scope->parent_scope = parent_scope;
 	return scope;
 }
@@ -374,7 +374,7 @@ int register_struct_declaration(GQuark struct_name,
 	g_hash_table_insert(scope->struct_declarations,
 			    (gpointer) (unsigned long) struct_name,
 			    struct_declaration);
-	declaration_ref(&struct_declaration->p);
+	bt_declaration_ref(&struct_declaration->p);
 
 	/* Also add in typedef/typealias scopes */
 	prefix_name = prefix_quark("struct ", struct_name);
@@ -424,7 +424,7 @@ int register_variant_declaration(GQuark variant_name,
 	g_hash_table_insert(scope->variant_declarations,
 			    (gpointer) (unsigned long) variant_name,
 			    untagged_variant_declaration);
-	declaration_ref(&untagged_variant_declaration->p);
+	bt_declaration_ref(&untagged_variant_declaration->p);
 
 	/* Also add in typedef/typealias scopes */
 	prefix_name = prefix_quark("variant ", variant_name);
@@ -475,7 +475,7 @@ int register_enum_declaration(GQuark enum_name,
 	g_hash_table_insert(scope->enum_declarations,
 			    (gpointer) (unsigned long) enum_name,
 			    enum_declaration);
-	declaration_ref(&enum_declaration->p);
+	bt_declaration_ref(&enum_declaration->p);
 
 	/* Also add in typedef/typealias scopes */
 	prefix_name = prefix_quark("enum ", enum_name);
diff --git a/types/variant.c b/types/variant.c
index 4f1e524..4d00a3b 100644
--- a/types/variant.c
+++ b/types/variant.c
@@ -63,7 +63,7 @@ void _untagged_variant_declaration_free(struct declaration *declaration)
 		struct declaration_field *declaration_field =
 			&g_array_index(untagged_variant_declaration->fields,
 				       struct declaration_field, i);
-		declaration_unref(declaration_field->declaration);
+		bt_declaration_unref(declaration_field->declaration);
 	}
 	g_array_free(untagged_variant_declaration->fields, true);
 	g_free(untagged_variant_declaration);
@@ -98,7 +98,7 @@ void _variant_declaration_free(struct declaration *declaration)
 	struct declaration_variant *variant_declaration =
 		container_of(declaration, struct declaration_variant, p);
 
-	declaration_unref(&variant_declaration->untagged_variant->p);
+	bt_declaration_unref(&variant_declaration->untagged_variant->p);
 	g_array_free(variant_declaration->tag_name, TRUE);
 	g_free(variant_declaration);
 }
@@ -112,7 +112,7 @@ struct declaration_variant *
 	variant_declaration = g_new(struct declaration_variant, 1);
 	declaration = &variant_declaration->p;
 	variant_declaration->untagged_variant = untagged_variant;
-	declaration_ref(&untagged_variant->p);
+	bt_declaration_ref(&untagged_variant->p);
 	variant_declaration->tag_name = g_array_new(FALSE, TRUE, sizeof(GQuark));
 	bt_append_scope_path(tag, variant_declaration->tag_name);
 	declaration->id = CTF_TYPE_VARIANT;
@@ -185,7 +185,7 @@ struct definition *
 	int ret;
 
 	variant = g_new(struct definition_variant, 1);
-	declaration_ref(&variant_declaration->p);
+	bt_declaration_ref(&variant_declaration->p);
 	variant->p.declaration = declaration;
 	variant->declaration = variant_declaration;
 	variant->p.ref = 1;
@@ -233,7 +233,7 @@ struct definition *
 	return &variant->p;
 error:
 	free_definition_scope(variant->p.scope);
-	declaration_unref(&variant_declaration->p);
+	bt_declaration_unref(&variant_declaration->p);
 	g_free(variant);
 	return NULL;
 }
@@ -252,7 +252,7 @@ void _variant_definition_free(struct definition *definition)
 	}
 	definition_unref(variant->enum_tag);
 	free_definition_scope(variant->p.scope);
-	declaration_unref(variant->p.declaration);
+	bt_declaration_unref(variant->p.declaration);
 	g_ptr_array_free(variant->fields, TRUE);
 	g_free(variant);
 }
@@ -268,7 +268,7 @@ void untagged_variant_declaration_add_field(struct declaration_untagged_variant
 	index = untagged_variant_declaration->fields->len - 1;	/* last field (new) */
 	field = &g_array_index(untagged_variant_declaration->fields, struct declaration_field, index);
 	field->name = g_quark_from_string(field_name);
-	declaration_ref(field_declaration);
+	bt_declaration_ref(field_declaration);
 	field->declaration = field_declaration;
 	/* Keep index in hash rather than pointer, because array can relocate */
 	g_hash_table_insert(untagged_variant_declaration->fields_by_tag,
-- 
1.7.10.4
