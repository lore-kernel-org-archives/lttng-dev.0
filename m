From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 6/7] Namespace the struct definition
Date: Fri, 15 Feb 2013 12:22:55 -0500
Message-ID: <1360948976-14999-6-git-send-email-jdesfossez__44876.2957159944$1360949075$gmane$org@efficios.com>
References: <1360948976-14999-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1U6P0G-0003wg-Rl
	for lttng-dev@lists.lttng.org; Fri, 15 Feb 2013 12:23:17 -0500
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

This struct is exposed in the public API, so we need to namespace it.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 formats/ctf-text/ctf-text.c         |    2 +-
 formats/ctf-text/types/array.c      |    2 +-
 formats/ctf-text/types/enum.c       |    2 +-
 formats/ctf-text/types/float.c      |    2 +-
 formats/ctf-text/types/integer.c    |    2 +-
 formats/ctf-text/types/sequence.c   |    2 +-
 formats/ctf-text/types/string.c     |    2 +-
 formats/ctf-text/types/struct.c     |    2 +-
 formats/ctf-text/types/variant.c    |    2 +-
 formats/ctf/ctf.c                   |   32 ++++++------
 formats/ctf/events.c                |   44 ++++++++--------
 formats/ctf/types/array.c           |    4 +-
 formats/ctf/types/enum.c            |    4 +-
 formats/ctf/types/float.c           |    8 +--
 formats/ctf/types/integer.c         |    8 +--
 formats/ctf/types/sequence.c        |    4 +-
 formats/ctf/types/string.c          |    4 +-
 formats/ctf/types/struct.c          |    2 +-
 formats/ctf/types/variant.c         |    2 +-
 include/babeltrace/ctf-text/types.h |   18 +++----
 include/babeltrace/ctf/events.h     |   32 ++++++------
 include/babeltrace/ctf/types.h      |   28 +++++-----
 include/babeltrace/types.h          |   98 +++++++++++++++++------------------
 types/array.c                       |   26 +++++-----
 types/enum.c                        |   10 ++--
 types/float.c                       |   10 ++--
 types/integer.c                     |   22 ++++----
 types/sequence.c                    |   26 +++++-----
 types/string.c                      |   12 ++---
 types/struct.c                      |   22 ++++----
 types/types.c                       |   28 +++++-----
 types/variant.c                     |   22 ++++----
 32 files changed, 242 insertions(+), 242 deletions(-)

diff --git a/formats/ctf-text/ctf-text.c b/formats/ctf-text/ctf-text.c
index cd69125..e9fd741 100644
--- a/formats/ctf-text/ctf-text.c
+++ b/formats/ctf-text/ctf-text.c
@@ -135,7 +135,7 @@ struct ctf_callsite_dups *ctf_trace_callsite_lookup(struct ctf_trace *trace,
 			(gpointer) (unsigned long) callsite_name);
 }
 
-int print_field(struct definition *definition)
+int print_field(struct bt_definition *definition)
 {
 	/* Print all fields in verbose mode */
 	if (babeltrace_verbose)
diff --git a/formats/ctf-text/types/array.c b/formats/ctf-text/types/array.c
index 9e7d49f..d9f57a2 100644
--- a/formats/ctf-text/types/array.c
+++ b/formats/ctf-text/types/array.c
@@ -29,7 +29,7 @@
 #include <babeltrace/ctf-text/types.h>
 #include <stdio.h>
 
-int ctf_text_array_write(struct bt_stream_pos *ppos, struct definition *definition)
+int ctf_text_array_write(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
 	struct ctf_text_stream_pos *pos = ctf_text_pos(ppos);
 	struct definition_array *array_definition =
diff --git a/formats/ctf-text/types/enum.c b/formats/ctf-text/types/enum.c
index 8a2463b..6470500 100644
--- a/formats/ctf-text/types/enum.c
+++ b/formats/ctf-text/types/enum.c
@@ -30,7 +30,7 @@
 #include <stdio.h>
 #include <stdint.h>
 
-int ctf_text_enum_write(struct bt_stream_pos *ppos, struct definition *definition)
+int ctf_text_enum_write(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
 	struct definition_enum *enum_definition =
 		container_of(definition, struct definition_enum, p);
diff --git a/formats/ctf-text/types/float.c b/formats/ctf-text/types/float.c
index a925480..a4946f9 100644
--- a/formats/ctf-text/types/float.c
+++ b/formats/ctf-text/types/float.c
@@ -31,7 +31,7 @@
 #include <babeltrace/ctf-text/types.h>
 #include <stdio.h>
 
-int ctf_text_float_write(struct bt_stream_pos *ppos, struct definition *definition)
+int ctf_text_float_write(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
 	struct definition_float *float_definition =
 		container_of(definition, struct definition_float, p);
diff --git a/formats/ctf-text/types/integer.c b/formats/ctf-text/types/integer.c
index 3a469f6..7363b52 100644
--- a/formats/ctf-text/types/integer.c
+++ b/formats/ctf-text/types/integer.c
@@ -32,7 +32,7 @@
 #include <stdint.h>
 #include <babeltrace/bitfield.h>
 
-int ctf_text_integer_write(struct bt_stream_pos *ppos, struct definition *definition)
+int ctf_text_integer_write(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
 	struct definition_integer *integer_definition =
 		container_of(definition, struct definition_integer, p);
diff --git a/formats/ctf-text/types/sequence.c b/formats/ctf-text/types/sequence.c
index 61be860..706fe5e 100644
--- a/formats/ctf-text/types/sequence.c
+++ b/formats/ctf-text/types/sequence.c
@@ -29,7 +29,7 @@
 #include <babeltrace/ctf-text/types.h>
 #include <stdio.h>
 
-int ctf_text_sequence_write(struct bt_stream_pos *ppos, struct definition *definition)
+int ctf_text_sequence_write(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
 	struct ctf_text_stream_pos *pos = ctf_text_pos(ppos);
 	struct definition_sequence *sequence_definition =
diff --git a/formats/ctf-text/types/string.c b/formats/ctf-text/types/string.c
index f49d1b7..c397f0e 100644
--- a/formats/ctf-text/types/string.c
+++ b/formats/ctf-text/types/string.c
@@ -32,7 +32,7 @@
 #include <string.h>
 
 int ctf_text_string_write(struct bt_stream_pos *ppos,
-			  struct definition *definition)
+			  struct bt_definition *definition)
 {
 	struct definition_string *string_definition =
 		container_of(definition, struct definition_string, p);
diff --git a/formats/ctf-text/types/struct.c b/formats/ctf-text/types/struct.c
index a727a89..1b9e27e 100644
--- a/formats/ctf-text/types/struct.c
+++ b/formats/ctf-text/types/struct.c
@@ -29,7 +29,7 @@
 #include <babeltrace/ctf-text/types.h>
 #include <stdio.h>
 
-int ctf_text_struct_write(struct bt_stream_pos *ppos, struct definition *definition)
+int ctf_text_struct_write(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
 	struct declaration *declaration = definition->declaration;
 	struct declaration_struct *struct_declaration =
diff --git a/formats/ctf-text/types/variant.c b/formats/ctf-text/types/variant.c
index ca7c1ae..3aeb6ec 100644
--- a/formats/ctf-text/types/variant.c
+++ b/formats/ctf-text/types/variant.c
@@ -29,7 +29,7 @@
 #include <babeltrace/ctf-text/types.h>
 #include <stdio.h>
 
-int ctf_text_variant_write(struct bt_stream_pos *ppos, struct definition *definition)
+int ctf_text_variant_write(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
 	struct ctf_text_stream_pos *pos = ctf_text_pos(ppos);
 	int field_nr_saved;
diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index aea12a1..5a51495 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -421,7 +421,7 @@ int ctf_read_event(struct bt_stream_pos *ppos, struct ctf_stream_definition *str
 	/* Read event header */
 	if (likely(stream->stream_event_header)) {
 		struct definition_integer *integer_definition;
-		struct definition *variant;
+		struct bt_definition *variant;
 
 		ret = generic_rw(ppos, &stream->stream_event_header->p);
 		if (unlikely(ret))
@@ -1150,7 +1150,7 @@ struct ctf_event_definition *create_event_definitions(struct ctf_trace *td,
 	struct ctf_event_definition *stream_event = g_new0(struct ctf_event_definition, 1);
 
 	if (event->context_decl) {
-		struct definition *definition =
+		struct bt_definition *definition =
 			event->context_decl->p.definition_new(&event->context_decl->p,
 				stream->parent_def_scope, 0, 0, "event.context");
 		if (!definition) {
@@ -1161,7 +1161,7 @@ struct ctf_event_definition *create_event_definitions(struct ctf_trace *td,
 		stream->parent_def_scope = stream_event->event_context->p.scope;
 	}
 	if (event->fields_decl) {
-		struct definition *definition =
+		struct bt_definition *definition =
 			event->fields_decl->p.definition_new(&event->fields_decl->p,
 				stream->parent_def_scope, 0, 0, "event.fields");
 		if (!definition) {
@@ -1195,7 +1195,7 @@ int create_stream_definitions(struct ctf_trace *td, struct ctf_stream_definition
 	stream_class = stream->stream_class;
 
 	if (stream_class->packet_context_decl) {
-		struct definition *definition =
+		struct bt_definition *definition =
 			stream_class->packet_context_decl->p.definition_new(&stream_class->packet_context_decl->p,
 				stream->parent_def_scope, 0, 0, "stream.packet.context");
 		if (!definition) {
@@ -1207,7 +1207,7 @@ int create_stream_definitions(struct ctf_trace *td, struct ctf_stream_definition
 		stream->parent_def_scope = stream->stream_packet_context->p.scope;
 	}
 	if (stream_class->event_header_decl) {
-		struct definition *definition =
+		struct bt_definition *definition =
 			stream_class->event_header_decl->p.definition_new(&stream_class->event_header_decl->p,
 				stream->parent_def_scope, 0, 0, "stream.event.header");
 		if (!definition) {
@@ -1219,7 +1219,7 @@ int create_stream_definitions(struct ctf_trace *td, struct ctf_stream_definition
 		stream->parent_def_scope = stream->stream_event_header->p.scope;
 	}
 	if (stream_class->event_context_decl) {
-		struct definition *definition =
+		struct bt_definition *definition =
 			stream_class->event_context_decl->p.definition_new(&stream_class->event_context_decl->p,
 				stream->parent_def_scope, 0, 0, "stream.event.context");
 		if (!definition) {
@@ -1321,7 +1321,7 @@ int create_stream_packet_index(struct ctf_trace *td,
 				return ret;
 			len_index = bt_struct_declaration_lookup_field_index(file_stream->parent.trace_packet_header->declaration, g_quark_from_static_string("magic"));
 			if (len_index >= 0) {
-				struct definition *field;
+				struct bt_definition *field;
 				uint64_t magic;
 
 				field = bt_struct_definition_get_field_from_index(file_stream->parent.trace_packet_header, len_index);
@@ -1339,7 +1339,7 @@ int create_stream_packet_index(struct ctf_trace *td,
 			len_index = bt_struct_declaration_lookup_field_index(file_stream->parent.trace_packet_header->declaration, g_quark_from_static_string("uuid"));
 			if (len_index >= 0) {
 				struct definition_array *defarray;
-				struct definition *field;
+				struct bt_definition *field;
 				uint64_t i;
 				uint8_t uuidval[BABELTRACE_UUID_LEN];
 
@@ -1349,7 +1349,7 @@ int create_stream_packet_index(struct ctf_trace *td,
 				assert(bt_array_len(defarray) == BABELTRACE_UUID_LEN);
 
 				for (i = 0; i < BABELTRACE_UUID_LEN; i++) {
-					struct definition *elem;
+					struct bt_definition *elem;
 
 					elem = bt_array_index(defarray, i);
 					uuidval[i] = bt_get_unsigned_int(elem);
@@ -1364,7 +1364,7 @@ int create_stream_packet_index(struct ctf_trace *td,
 
 			len_index = bt_struct_declaration_lookup_field_index(file_stream->parent.trace_packet_header->declaration, g_quark_from_static_string("stream_id"));
 			if (len_index >= 0) {
-				struct definition *field;
+				struct bt_definition *field;
 
 				field = bt_struct_definition_get_field_from_index(file_stream->parent.trace_packet_header, len_index);
 				stream_id = bt_get_unsigned_int(field);
@@ -1401,7 +1401,7 @@ int create_stream_packet_index(struct ctf_trace *td,
 			/* read content size from header */
 			len_index = bt_struct_declaration_lookup_field_index(file_stream->parent.stream_packet_context->declaration, g_quark_from_static_string("content_size"));
 			if (len_index >= 0) {
-				struct definition *field;
+				struct bt_definition *field;
 
 				field = bt_struct_definition_get_field_from_index(file_stream->parent.stream_packet_context, len_index);
 				packet_index.content_size = bt_get_unsigned_int(field);
@@ -1413,7 +1413,7 @@ int create_stream_packet_index(struct ctf_trace *td,
 			/* read packet size from header */
 			len_index = bt_struct_declaration_lookup_field_index(file_stream->parent.stream_packet_context->declaration, g_quark_from_static_string("packet_size"));
 			if (len_index >= 0) {
-				struct definition *field;
+				struct bt_definition *field;
 
 				field = bt_struct_definition_get_field_from_index(file_stream->parent.stream_packet_context, len_index);
 				packet_index.packet_size = bt_get_unsigned_int(field);
@@ -1425,7 +1425,7 @@ int create_stream_packet_index(struct ctf_trace *td,
 			/* read timestamp begin from header */
 			len_index = bt_struct_declaration_lookup_field_index(file_stream->parent.stream_packet_context->declaration, g_quark_from_static_string("timestamp_begin"));
 			if (len_index >= 0) {
-				struct definition *field;
+				struct bt_definition *field;
 
 				field = bt_struct_definition_get_field_from_index(file_stream->parent.stream_packet_context, len_index);
 				packet_index.timestamp_begin = bt_get_unsigned_int(field);
@@ -1440,7 +1440,7 @@ int create_stream_packet_index(struct ctf_trace *td,
 			/* read timestamp end from header */
 			len_index = bt_struct_declaration_lookup_field_index(file_stream->parent.stream_packet_context->declaration, g_quark_from_static_string("timestamp_end"));
 			if (len_index >= 0) {
-				struct definition *field;
+				struct bt_definition *field;
 
 				field = bt_struct_definition_get_field_from_index(file_stream->parent.stream_packet_context, len_index);
 				packet_index.timestamp_end = bt_get_unsigned_int(field);
@@ -1455,7 +1455,7 @@ int create_stream_packet_index(struct ctf_trace *td,
 			/* read events discarded from header */
 			len_index = bt_struct_declaration_lookup_field_index(file_stream->parent.stream_packet_context->declaration, g_quark_from_static_string("events_discarded"));
 			if (len_index >= 0) {
-				struct definition *field;
+				struct bt_definition *field;
 
 				field = bt_struct_definition_get_field_from_index(file_stream->parent.stream_packet_context, len_index);
 				packet_index.events_discarded = bt_get_unsigned_int(field);
@@ -1499,7 +1499,7 @@ int create_trace_definitions(struct ctf_trace *td, struct ctf_stream_definition
 	int ret;
 
 	if (td->packet_header_decl) {
-		struct definition *definition =
+		struct bt_definition *definition =
 			td->packet_header_decl->p.definition_new(&td->packet_header_decl->p,
 				stream->parent_def_scope, 0, 0, "trace.packet.header");
 		if (!definition) {
diff --git a/formats/ctf/events.c b/formats/ctf/events.c
index d9460b1..af7f5e1 100644
--- a/formats/ctf/events.c
+++ b/formats/ctf/events.c
@@ -46,10 +46,10 @@
  */
 __thread int bt_ctf_last_field_error = 0;
 
-const struct definition *bt_ctf_get_top_level_scope(const struct bt_ctf_event *ctf_event,
+const struct bt_definition *bt_ctf_get_top_level_scope(const struct bt_ctf_event *ctf_event,
 		enum bt_ctf_scope scope)
 {
-	const struct definition *tmp = NULL;
+	const struct bt_definition *tmp = NULL;
 	const struct ctf_event_definition *event;
 
 	if (!ctf_event)
@@ -96,11 +96,11 @@ error:
 	return NULL;
 }
 
-const struct definition *bt_ctf_get_field(const struct bt_ctf_event *ctf_event,
-		const struct definition *scope,
+const struct bt_definition *bt_ctf_get_field(const struct bt_ctf_event *ctf_event,
+		const struct bt_definition *scope,
 		const char *field)
 {
-	const struct definition *def;
+	const struct bt_definition *def;
 	char *field_underscore;
 
 	if (!ctf_event || !scope || !field)
@@ -127,11 +127,11 @@ const struct definition *bt_ctf_get_field(const struct bt_ctf_event *ctf_event,
 	return def;
 }
 
-const struct definition *bt_ctf_get_index(const struct bt_ctf_event *ctf_event,
-		const struct definition *field,
+const struct bt_definition *bt_ctf_get_index(const struct bt_ctf_event *ctf_event,
+		const struct bt_definition *field,
 		unsigned int index)
 {
-	struct definition *ret = NULL;
+	struct bt_definition *ret = NULL;
 
 	if (!ctf_event || !field)
 		return NULL;
@@ -166,7 +166,7 @@ const char *bt_ctf_event_name(const struct bt_ctf_event *ctf_event)
 	return g_quark_to_string(event_class->name);
 }
 
-const char *bt_ctf_field_name(const struct definition *def)
+const char *bt_ctf_field_name(const struct bt_definition *def)
 {
 	if (!def || !def->name)
 		return NULL;
@@ -183,8 +183,8 @@ enum ctf_type_id bt_ctf_field_type(const struct declaration *decl)
 }
 
 int bt_ctf_get_field_list(const struct bt_ctf_event *ctf_event,
-		const struct definition *scope,
-		struct definition const * const **list,
+		const struct bt_definition *scope,
+		struct bt_definition const * const **list,
 		unsigned int *count)
 {
 	if (!ctf_event || !scope || !list || !count)
@@ -204,7 +204,7 @@ int bt_ctf_get_field_list(const struct bt_ctf_event *ctf_event,
 		if (!def_struct)
 			goto error;
 		if (def_struct->fields->pdata) {
-			*list = (struct definition const* const*) def_struct->fields->pdata;
+			*list = (struct bt_definition const* const*) def_struct->fields->pdata;
 			*count = def_struct->fields->len;
 			goto end;
 		} else {
@@ -222,7 +222,7 @@ int bt_ctf_get_field_list(const struct bt_ctf_event *ctf_event,
 		if (!def_variant)
 			goto error;
 		if (def_variant->fields->pdata) {
-			*list = (struct definition const* const*) def_variant->fields->pdata;
+			*list = (struct bt_definition const* const*) def_variant->fields->pdata;
 			*count = def_variant->fields->len;
 			goto end;
 		} else {
@@ -238,7 +238,7 @@ int bt_ctf_get_field_list(const struct bt_ctf_event *ctf_event,
 		if (!def_array)
 			goto error;
 		if (def_array->elems->pdata) {
-			*list = (struct definition const* const*) def_array->elems->pdata;
+			*list = (struct bt_definition const* const*) def_array->elems->pdata;
 			*count = def_array->elems->len;
 			goto end;
 		} else {
@@ -254,7 +254,7 @@ int bt_ctf_get_field_list(const struct bt_ctf_event *ctf_event,
 		if (!def_sequence)
 			goto error;
 		if (def_sequence->elems->pdata) {
-			*list = (struct definition const* const*) def_sequence->elems->pdata;
+			*list = (struct bt_definition const* const*) def_sequence->elems->pdata;
 			*count = def_sequence->elems->len;
 			goto end;
 		} else {
@@ -437,7 +437,7 @@ ssize_t bt_ctf_get_int_len(const struct declaration *decl)
 	return (ssize_t) integer->len;
 }
 
-const struct definition *bt_ctf_get_enum_int(const struct definition *field)
+const struct bt_definition *bt_ctf_get_enum_int(const struct bt_definition *field)
 {
 	const struct definition_enum *def_enum;
 
@@ -449,7 +449,7 @@ const struct definition *bt_ctf_get_enum_int(const struct definition *field)
 	return &def_enum->integer->p;
 }
 
-const char *bt_ctf_get_enum_str(const struct definition *field)
+const char *bt_ctf_get_enum_str(const struct bt_definition *field)
 {
 	const struct definition_enum *def_enum;
 	const struct declaration_enum *decl_enum;
@@ -554,7 +554,7 @@ error:
 	return -1;
 }
 
-uint64_t bt_ctf_get_uint64(const struct definition *field)
+uint64_t bt_ctf_get_uint64(const struct bt_definition *field)
 {
 	uint64_t ret = 0;
 
@@ -566,7 +566,7 @@ uint64_t bt_ctf_get_uint64(const struct definition *field)
 	return ret;
 }
 
-int64_t bt_ctf_get_int64(const struct definition *field)
+int64_t bt_ctf_get_int64(const struct bt_definition *field)
 {
 	int64_t ret = 0;
 
@@ -578,7 +578,7 @@ int64_t bt_ctf_get_int64(const struct definition *field)
 	return ret;
 }
 
-char *bt_ctf_get_char_array(const struct definition *field)
+char *bt_ctf_get_char_array(const struct bt_definition *field)
 {
 	char *ret = NULL;
 	GString *char_array;
@@ -596,7 +596,7 @@ end:
 	return ret;
 }
 
-char *bt_ctf_get_string(const struct definition *field)
+char *bt_ctf_get_string(const struct bt_definition *field)
 {
 	char *ret = NULL;
 
@@ -767,7 +767,7 @@ const char *bt_ctf_get_decl_field_name(const struct bt_ctf_field_decl *field)
 	return rem_(g_quark_to_string(((struct declaration_field *) field)->name));
 }
 
-const struct declaration *bt_ctf_get_decl_from_def(const struct definition *def)
+const struct declaration *bt_ctf_get_decl_from_def(const struct bt_definition *def)
 {
 	if (def)
 		return def->declaration;
diff --git a/formats/ctf/types/array.c b/formats/ctf/types/array.c
index b1cbe2f..683c171 100644
--- a/formats/ctf/types/array.c
+++ b/formats/ctf/types/array.c
@@ -28,7 +28,7 @@
 
 #include <babeltrace/ctf/types.h>
 
-int ctf_array_read(struct bt_stream_pos *ppos, struct definition *definition)
+int ctf_array_read(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
 	struct definition_array *array_definition =
 		container_of(definition, struct definition_array, p);
@@ -64,7 +64,7 @@ int ctf_array_read(struct bt_stream_pos *ppos, struct definition *definition)
 	return bt_array_rw(ppos, definition);
 }
 
-int ctf_array_write(struct bt_stream_pos *ppos, struct definition *definition)
+int ctf_array_write(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
 	struct definition_array *array_definition =
 		container_of(definition, struct definition_array, p);
diff --git a/formats/ctf/types/enum.c b/formats/ctf/types/enum.c
index 9371b27..9461af6 100644
--- a/formats/ctf/types/enum.c
+++ b/formats/ctf/types/enum.c
@@ -31,7 +31,7 @@
 #include <stdint.h>
 #include <glib.h>
 
-int ctf_enum_read(struct bt_stream_pos *ppos, struct definition *definition)
+int ctf_enum_read(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
 	struct definition_enum *enum_definition =
 		container_of(definition, struct definition_enum, p);
@@ -69,7 +69,7 @@ int ctf_enum_read(struct bt_stream_pos *ppos, struct definition *definition)
 	return 0;
 }
 
-int ctf_enum_write(struct bt_stream_pos *pos, struct definition *definition)
+int ctf_enum_write(struct bt_stream_pos *pos, struct bt_definition *definition)
 {
 	struct definition_enum *enum_definition =
 		container_of(definition, struct definition_enum, p);
diff --git a/formats/ctf/types/float.c b/formats/ctf/types/float.c
index f46e26a..2e0bd5c 100644
--- a/formats/ctf/types/float.c
+++ b/formats/ctf/types/float.c
@@ -165,7 +165,7 @@ static int _ctf_float_copy(struct bt_stream_pos *destp,
 	return 0;
 }
 
-int ctf_float_read(struct bt_stream_pos *ppos, struct definition *definition)
+int ctf_float_read(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
 	struct definition_float *float_definition =
 		container_of(definition, struct definition_float, p);
@@ -173,7 +173,7 @@ int ctf_float_read(struct bt_stream_pos *ppos, struct definition *definition)
 		float_definition->declaration;
 	struct ctf_stream_pos *pos = ctf_pos(ppos);
 	union doubleIEEE754 u;
-	struct definition *tmpdef;
+	struct bt_definition *tmpdef;
 	struct definition_float *tmpfloat;
 	struct ctf_stream_pos destp;
 	struct mmap_align mma;
@@ -222,7 +222,7 @@ end:
 	return ret;
 }
 
-int ctf_float_write(struct bt_stream_pos *ppos, struct definition *definition)
+int ctf_float_write(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
 	struct definition_float *float_definition =
 		container_of(definition, struct definition_float, p);
@@ -230,7 +230,7 @@ int ctf_float_write(struct bt_stream_pos *ppos, struct definition *definition)
 		float_definition->declaration;
 	struct ctf_stream_pos *pos = ctf_pos(ppos);
 	union doubleIEEE754 u;
-	struct definition *tmpdef;
+	struct bt_definition *tmpdef;
 	struct definition_float *tmpfloat;
 	struct ctf_stream_pos srcp;
 	struct mmap_align mma;
diff --git a/formats/ctf/types/integer.c b/formats/ctf/types/integer.c
index 1267925..257341a 100644
--- a/formats/ctf/types/integer.c
+++ b/formats/ctf/types/integer.c
@@ -40,7 +40,7 @@
 
 static
 int _aligned_integer_read(struct bt_stream_pos *ppos,
-			  struct definition *definition)
+			  struct bt_definition *definition)
 {
 	struct definition_integer *integer_definition =
 		container_of(definition, struct definition_integer, p);
@@ -142,7 +142,7 @@ int _aligned_integer_read(struct bt_stream_pos *ppos,
 
 static
 int _aligned_integer_write(struct bt_stream_pos *ppos,
-			    struct definition *definition)
+			    struct bt_definition *definition)
 {
 	struct definition_integer *integer_definition =
 		container_of(definition, struct definition_integer, p);
@@ -211,7 +211,7 @@ end:
 	return 0;
 }
 
-int ctf_integer_read(struct bt_stream_pos *ppos, struct definition *definition)
+int ctf_integer_read(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
 	struct definition_integer *integer_definition =
 		container_of(definition, struct definition_integer, p);
@@ -256,7 +256,7 @@ int ctf_integer_read(struct bt_stream_pos *ppos, struct definition *definition)
 	return 0;
 }
 
-int ctf_integer_write(struct bt_stream_pos *ppos, struct definition *definition)
+int ctf_integer_write(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
 	struct definition_integer *integer_definition =
 		container_of(definition, struct definition_integer, p);
diff --git a/formats/ctf/types/sequence.c b/formats/ctf/types/sequence.c
index b2221ea..53ebf75 100644
--- a/formats/ctf/types/sequence.c
+++ b/formats/ctf/types/sequence.c
@@ -28,7 +28,7 @@
 
 #include <babeltrace/ctf/types.h>
 
-int ctf_sequence_read(struct bt_stream_pos *ppos, struct definition *definition)
+int ctf_sequence_read(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
 	struct definition_sequence *sequence_definition =
 		container_of(definition, struct definition_sequence, p);
@@ -63,7 +63,7 @@ int ctf_sequence_read(struct bt_stream_pos *ppos, struct definition *definition)
 	return bt_sequence_rw(ppos, definition);
 }
 
-int ctf_sequence_write(struct bt_stream_pos *ppos, struct definition *definition)
+int ctf_sequence_write(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
 	struct definition_sequence *sequence_definition =
 		container_of(definition, struct definition_sequence, p);
diff --git a/formats/ctf/types/string.c b/formats/ctf/types/string.c
index 5771733..a2433bf 100644
--- a/formats/ctf/types/string.c
+++ b/formats/ctf/types/string.c
@@ -31,7 +31,7 @@
 #include <limits.h>		/* C99 limits */
 #include <string.h>
 
-int ctf_string_read(struct bt_stream_pos *ppos, struct definition *definition)
+int ctf_string_read(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
 	struct definition_string *string_definition =
 		container_of(definition, struct definition_string, p);
@@ -69,7 +69,7 @@ int ctf_string_read(struct bt_stream_pos *ppos, struct definition *definition)
 }
 
 int ctf_string_write(struct bt_stream_pos *ppos,
-		      struct definition *definition)
+		      struct bt_definition *definition)
 {
 	struct definition_string *string_definition =
 		container_of(definition, struct definition_string, p);
diff --git a/formats/ctf/types/struct.c b/formats/ctf/types/struct.c
index 7c1562b..b004767 100644
--- a/formats/ctf/types/struct.c
+++ b/formats/ctf/types/struct.c
@@ -28,7 +28,7 @@
 
 #include <babeltrace/ctf/types.h>
 
-int ctf_struct_rw(struct bt_stream_pos *ppos, struct definition *definition)
+int ctf_struct_rw(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
 	struct declaration *declaration = definition->declaration;
 	struct ctf_stream_pos *pos = ctf_pos(ppos);
diff --git a/formats/ctf/types/variant.c b/formats/ctf/types/variant.c
index 3c0c371..ece8b33 100644
--- a/formats/ctf/types/variant.c
+++ b/formats/ctf/types/variant.c
@@ -28,7 +28,7 @@
 
 #include <babeltrace/ctf/types.h>
 
-int ctf_variant_rw(struct bt_stream_pos *ppos, struct definition *definition)
+int ctf_variant_rw(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
 	struct declaration *declaration = definition->declaration;
 	struct ctf_stream_pos *pos = ctf_pos(ppos);
diff --git a/include/babeltrace/ctf-text/types.h b/include/babeltrace/ctf-text/types.h
index 15c8333..74a68a1 100644
--- a/include/babeltrace/ctf-text/types.h
+++ b/include/babeltrace/ctf-text/types.h
@@ -62,21 +62,21 @@ struct ctf_text_stream_pos *ctf_text_pos(struct bt_stream_pos *pos)
  * Write only is supported for now.
  */
 BT_HIDDEN
-int ctf_text_integer_write(struct bt_stream_pos *pos, struct definition *definition);
+int ctf_text_integer_write(struct bt_stream_pos *pos, struct bt_definition *definition);
 BT_HIDDEN
-int ctf_text_float_write(struct bt_stream_pos *pos, struct definition *definition);
+int ctf_text_float_write(struct bt_stream_pos *pos, struct bt_definition *definition);
 BT_HIDDEN
-int ctf_text_string_write(struct bt_stream_pos *pos, struct definition *definition);
+int ctf_text_string_write(struct bt_stream_pos *pos, struct bt_definition *definition);
 BT_HIDDEN
-int ctf_text_enum_write(struct bt_stream_pos *pos, struct definition *definition);
+int ctf_text_enum_write(struct bt_stream_pos *pos, struct bt_definition *definition);
 BT_HIDDEN
-int ctf_text_struct_write(struct bt_stream_pos *pos, struct definition *definition);
+int ctf_text_struct_write(struct bt_stream_pos *pos, struct bt_definition *definition);
 BT_HIDDEN
-int ctf_text_variant_write(struct bt_stream_pos *pos, struct definition *definition);
+int ctf_text_variant_write(struct bt_stream_pos *pos, struct bt_definition *definition);
 BT_HIDDEN
-int ctf_text_array_write(struct bt_stream_pos *pos, struct definition *definition);
+int ctf_text_array_write(struct bt_stream_pos *pos, struct bt_definition *definition);
 BT_HIDDEN
-int ctf_text_sequence_write(struct bt_stream_pos *pos, struct definition *definition);
+int ctf_text_sequence_write(struct bt_stream_pos *pos, struct bt_definition *definition);
 
 static inline
 void print_pos_tabs(struct ctf_text_stream_pos *pos)
@@ -91,6 +91,6 @@ void print_pos_tabs(struct ctf_text_stream_pos *pos)
  * Check if the field must be printed.
  */
 BT_HIDDEN
-int print_field(struct definition *definition);
+int print_field(struct bt_definition *definition);
 
 #endif /* _BABELTRACE_CTF_TEXT_TYPES_H */
diff --git a/include/babeltrace/ctf/events.h b/include/babeltrace/ctf/events.h
index 19d7361..ecc5c28 100644
--- a/include/babeltrace/ctf/events.h
+++ b/include/babeltrace/ctf/events.h
@@ -39,7 +39,7 @@
 extern "C" {
 #endif
 
-struct definition;
+struct bt_definition;
 struct declaration;
 struct bt_ctf_event;
 struct bt_ctf_event_decl;
@@ -94,7 +94,7 @@ enum ctf_string_encoding {
  * between the enum and the actual definition of top-level scopes.
  * On error return NULL.
  */
-const struct definition *bt_ctf_get_top_level_scope(const struct bt_ctf_event *event,
+const struct bt_definition *bt_ctf_get_top_level_scope(const struct bt_ctf_event *event,
 		enum bt_ctf_scope scope);
 
 /*
@@ -130,35 +130,35 @@ uint64_t bt_ctf_get_timestamp(const struct bt_ctf_event *event);
  * from which the event is extracted is unchanged).
  */
 int bt_ctf_get_field_list(const struct bt_ctf_event *event,
-		const struct definition *scope,
-		struct definition const * const **list,
+		const struct bt_definition *scope,
+		struct bt_definition const * const **list,
 		unsigned int *count);
 
 /*
  * bt_ctf_get_field: returns the definition of a specific field
  */
-const struct definition *bt_ctf_get_field(const struct bt_ctf_event *event,
-		const struct definition *scope,
+const struct bt_definition *bt_ctf_get_field(const struct bt_ctf_event *event,
+		const struct bt_definition *scope,
 		const char *field);
 
 /*
  * bt_ctf_get_index: if the field is an array or a sequence, return the element
  * at position index, otherwise return NULL;
  */
-const struct definition *bt_ctf_get_index(const struct bt_ctf_event *event,
-		const struct definition *field,
+const struct bt_definition *bt_ctf_get_index(const struct bt_ctf_event *event,
+		const struct bt_definition *field,
 		unsigned int index);
 
 /*
  * bt_ctf_field_name: returns the name of a field or NULL on error
  */
-const char *bt_ctf_field_name(const struct definition *def);
+const char *bt_ctf_field_name(const struct bt_definition *def);
 
 /*
  * bt_ctf_get_decl_from_def: return the declaration of a field from
  * its definition or NULL on error
  */
-const struct declaration *bt_ctf_get_decl_from_def(const struct definition *def);
+const struct declaration *bt_ctf_get_decl_from_def(const struct bt_definition *def);
 
 /*
  * bt_ctf_get_decl_from_field_decl: return the declaration of a field from
@@ -225,12 +225,12 @@ int bt_ctf_get_array_len(const struct declaration *decl);
  * bt_ctf_get_enum_str gets the string matching the current enumeration
  * value, or NULL if the current value does not match any string.
  */
-uint64_t bt_ctf_get_uint64(const struct definition *field);
-int64_t bt_ctf_get_int64(const struct definition *field);
-const struct definition *bt_ctf_get_enum_int(const struct definition *field);
-const char *bt_ctf_get_enum_str(const struct definition *field);
-char *bt_ctf_get_char_array(const struct definition *field);
-char *bt_ctf_get_string(const struct definition *field);
+uint64_t bt_ctf_get_uint64(const struct bt_definition *field);
+int64_t bt_ctf_get_int64(const struct bt_definition *field);
+const struct bt_definition *bt_ctf_get_enum_int(const struct bt_definition *field);
+const char *bt_ctf_get_enum_str(const struct bt_definition *field);
+char *bt_ctf_get_char_array(const struct bt_definition *field);
+char *bt_ctf_get_string(const struct bt_definition *field);
 
 /*
  * bt_ctf_field_get_error: returns the last error code encountered while
diff --git a/include/babeltrace/ctf/types.h b/include/babeltrace/ctf/types.h
index f7b93d3..781b942 100644
--- a/include/babeltrace/ctf/types.h
+++ b/include/babeltrace/ctf/types.h
@@ -91,33 +91,33 @@ struct ctf_stream_pos *ctf_pos(struct bt_stream_pos *pos)
 }
 
 BT_HIDDEN
-int ctf_integer_read(struct bt_stream_pos *pos, struct definition *definition);
+int ctf_integer_read(struct bt_stream_pos *pos, struct bt_definition *definition);
 BT_HIDDEN
-int ctf_integer_write(struct bt_stream_pos *pos, struct definition *definition);
+int ctf_integer_write(struct bt_stream_pos *pos, struct bt_definition *definition);
 BT_HIDDEN
-int ctf_float_read(struct bt_stream_pos *pos, struct definition *definition);
+int ctf_float_read(struct bt_stream_pos *pos, struct bt_definition *definition);
 BT_HIDDEN
-int ctf_float_write(struct bt_stream_pos *pos, struct definition *definition);
+int ctf_float_write(struct bt_stream_pos *pos, struct bt_definition *definition);
 BT_HIDDEN
-int ctf_string_read(struct bt_stream_pos *pos, struct definition *definition);
+int ctf_string_read(struct bt_stream_pos *pos, struct bt_definition *definition);
 BT_HIDDEN
-int ctf_string_write(struct bt_stream_pos *pos, struct definition *definition);
+int ctf_string_write(struct bt_stream_pos *pos, struct bt_definition *definition);
 BT_HIDDEN
-int ctf_enum_read(struct bt_stream_pos *pos, struct definition *definition);
+int ctf_enum_read(struct bt_stream_pos *pos, struct bt_definition *definition);
 BT_HIDDEN
-int ctf_enum_write(struct bt_stream_pos *pos, struct definition *definition);
+int ctf_enum_write(struct bt_stream_pos *pos, struct bt_definition *definition);
 BT_HIDDEN
-int ctf_struct_rw(struct bt_stream_pos *pos, struct definition *definition);
+int ctf_struct_rw(struct bt_stream_pos *pos, struct bt_definition *definition);
 BT_HIDDEN
-int ctf_variant_rw(struct bt_stream_pos *pos, struct definition *definition);
+int ctf_variant_rw(struct bt_stream_pos *pos, struct bt_definition *definition);
 BT_HIDDEN
-int ctf_array_read(struct bt_stream_pos *pos, struct definition *definition);
+int ctf_array_read(struct bt_stream_pos *pos, struct bt_definition *definition);
 BT_HIDDEN
-int ctf_array_write(struct bt_stream_pos *pos, struct definition *definition);
+int ctf_array_write(struct bt_stream_pos *pos, struct bt_definition *definition);
 BT_HIDDEN
-int ctf_sequence_read(struct bt_stream_pos *pos, struct definition *definition);
+int ctf_sequence_read(struct bt_stream_pos *pos, struct bt_definition *definition);
 BT_HIDDEN
-int ctf_sequence_write(struct bt_stream_pos *pos, struct definition *definition);
+int ctf_sequence_write(struct bt_stream_pos *pos, struct bt_definition *definition);
 
 void ctf_packet_seek(struct bt_stream_pos *pos, size_t index, int whence);
 
diff --git a/include/babeltrace/types.h b/include/babeltrace/types.h
index 093ef0c..0b8d1c1 100644
--- a/include/babeltrace/types.h
+++ b/include/babeltrace/types.h
@@ -45,7 +45,7 @@
 struct ctf_stream_definition;
 struct bt_stream_pos;
 struct bt_format;
-struct definition;
+struct bt_definition;
 struct ctf_clock;
 
 /* type scope */
@@ -86,7 +86,7 @@ struct declaration {
 	 * declaration_free called with declaration ref is decremented to 0.
 	 */
 	void (*declaration_free)(struct declaration *declaration);
-	struct definition *
+	struct bt_definition *
 		(*definition_new)(struct declaration *declaration,
 				  struct definition_scope *parent_scope,
 				  GQuark field_name, int index,
@@ -94,10 +94,10 @@ struct declaration {
 	/*
 	 * definition_free called with definition ref is decremented to 0.
 	 */
-	void (*definition_free)(struct definition *definition);
+	void (*definition_free)(struct bt_definition *definition);
 };
 
-struct definition {
+struct bt_definition {
 	struct declaration *declaration;
 	int index;		/* Position of the definition in its container */
 	GQuark name;		/* Field name in its container (or 0 if unset) */
@@ -107,7 +107,7 @@ struct definition {
 };
 
 typedef int (*rw_dispatch)(struct bt_stream_pos *pos,
-			   struct definition *definition);
+			   struct bt_definition *definition);
 
 /* Parent of per-plugin positions */
 struct bt_stream_pos {
@@ -118,7 +118,7 @@ struct bt_stream_pos {
 };
 
 static inline
-int generic_rw(struct bt_stream_pos *pos, struct definition *definition)
+int generic_rw(struct bt_stream_pos *pos, struct bt_definition *definition)
 {
 	enum ctf_type_id dispatch_id = definition->declaration->id;
 	rw_dispatch call;
@@ -144,7 +144,7 @@ struct declaration_integer {
 };
 
 struct definition_integer {
-	struct definition p;
+	struct bt_definition p;
 	struct declaration_integer *declaration;
 	/* Last values read */
 	union {
@@ -163,7 +163,7 @@ struct declaration_float {
 };
 
 struct definition_float {
-	struct definition p;
+	struct bt_definition p;
 	struct declaration_float *declaration;
 	struct definition_integer *sign;
 	struct definition_integer *mantissa;
@@ -217,7 +217,7 @@ struct declaration_enum {
 };
 
 struct definition_enum {
-	struct definition p;
+	struct bt_definition p;
 	struct definition_integer *integer;
 	struct declaration_enum *declaration;
 	/* Last GQuark values read. Keeping a reference on the GQuark array. */
@@ -230,7 +230,7 @@ struct declaration_string {
 };
 
 struct definition_string {
-	struct definition p;
+	struct bt_definition p;
 	struct declaration_string *declaration;
 	char *value;	/* freed at definition_string teardown */
 	size_t len, alloc_len;
@@ -249,9 +249,9 @@ struct declaration_struct {
 };
 
 struct definition_struct {
-	struct definition p;
+	struct bt_definition p;
 	struct declaration_struct *declaration;
-	GPtrArray *fields;		/* Array of pointers to struct definition */
+	GPtrArray *fields;		/* Array of pointers to struct bt_definition */
 };
 
 struct declaration_untagged_variant {
@@ -269,11 +269,11 @@ struct declaration_variant {
 
 /* A variant needs to be tagged to be defined. */
 struct definition_variant {
-	struct definition p;
+	struct bt_definition p;
 	struct declaration_variant *declaration;
-	struct definition *enum_tag;
-	GPtrArray *fields;		/* Array of pointers to struct definition */
-	struct definition *current_field;	/* Last field read */
+	struct bt_definition *enum_tag;
+	GPtrArray *fields;		/* Array of pointers to struct bt_definition */
+	struct bt_definition *current_field;	/* Last field read */
 };
 
 struct declaration_array {
@@ -284,9 +284,9 @@ struct declaration_array {
 };
 
 struct definition_array {
-	struct definition p;
+	struct bt_definition p;
 	struct declaration_array *declaration;
-	GPtrArray *elems;		/* Array of pointers to struct definition */
+	GPtrArray *elems;		/* Array of pointers to struct bt_definition */
 	GString *string;		/* String for encoded integer children */
 };
 
@@ -298,10 +298,10 @@ struct declaration_sequence {
 };
 
 struct definition_sequence {
-	struct definition p;
+	struct bt_definition p;
 	struct declaration_sequence *declaration;
 	struct definition_integer *length;
-	GPtrArray *elems;		/* Array of pointers to struct definition */
+	GPtrArray *elems;		/* Array of pointers to struct bt_definition */
 	GString *string;		/* String for encoded integer children */
 };
 
@@ -343,12 +343,12 @@ void bt_free_declaration_scope(struct declaration_scope *scope);
  * field_definition is for field definitions. They are registered into
  * definition scopes.
  */
-struct definition *
+struct bt_definition *
 	bt_lookup_path_definition(GArray *cur_path,	/* array of GQuark */
 			       GArray *lookup_path,	/* array of GQuark */
 			       struct definition_scope *scope);
 int bt_register_field_definition(GQuark field_name,
-			      struct definition *definition,
+			      struct bt_definition *definition,
 			      struct definition_scope *scope);
 struct definition_scope *
 	bt_new_definition_scope(struct definition_scope *parent_scope,
@@ -359,7 +359,7 @@ GQuark bt_new_definition_path(struct definition_scope *parent_scope,
 			   GQuark field_name, const char *root_name);
 
 static inline
-int compare_definition_path(struct definition *definition, GQuark path)
+int compare_definition_path(struct bt_definition *definition, GQuark path)
 {
 	return definition->path == path;
 }
@@ -367,20 +367,20 @@ int compare_definition_path(struct definition *definition, GQuark path)
 void bt_declaration_ref(struct declaration *declaration);
 void bt_declaration_unref(struct declaration *declaration);
 
-void bt_definition_ref(struct definition *definition);
-void bt_definition_unref(struct definition *definition);
+void bt_definition_ref(struct bt_definition *definition);
+void bt_definition_unref(struct bt_definition *definition);
 
 struct declaration_integer *bt_integer_declaration_new(size_t len, int byte_order,
 				  int signedness, size_t alignment,
 				  int base, enum ctf_string_encoding encoding,
 				  struct ctf_clock *clock);
-uint64_t bt_get_unsigned_int(const struct definition *field);
-int64_t bt_get_signed_int(const struct definition *field);
-int bt_get_int_signedness(const struct definition *field);
-int bt_get_int_byte_order(const struct definition *field);
-int bt_get_int_base(const struct definition *field);
-size_t bt_get_int_len(const struct definition *field);	/* in bits */
-enum ctf_string_encoding bt_get_int_encoding(const struct definition *field);
+uint64_t bt_get_unsigned_int(const struct bt_definition *field);
+int64_t bt_get_signed_int(const struct bt_definition *field);
+int bt_get_int_signedness(const struct bt_definition *field);
+int bt_get_int_byte_order(const struct bt_definition *field);
+int bt_get_int_base(const struct bt_definition *field);
+size_t bt_get_int_len(const struct bt_definition *field);	/* in bits */
+enum ctf_string_encoding bt_get_int_encoding(const struct bt_definition *field);
 
 /*
  * mantissa_len is the length of the number of bytes represented by the mantissa
@@ -427,8 +427,8 @@ struct declaration_enum *
 
 struct declaration_string *
 	bt_string_declaration_new(enum ctf_string_encoding encoding);
-char *bt_get_string(const struct definition *field);
-enum ctf_string_encoding bt_get_string_encoding(const struct definition *field);
+char *bt_get_string(const struct bt_definition *field);
+enum ctf_string_encoding bt_get_string_encoding(const struct bt_definition *field);
 
 struct declaration_struct *
 	bt_struct_declaration_new(struct declaration_scope *parent_scope,
@@ -447,10 +447,10 @@ int bt_struct_declaration_lookup_field_index(struct declaration_struct *struct_d
 struct declaration_field *
 bt_struct_declaration_get_field_from_index(struct declaration_struct *struct_declaration,
 					int index);
-struct definition *
+struct bt_definition *
 bt_struct_definition_get_field_from_index(struct definition_struct *struct_definition,
 				       int index);
-int bt_struct_rw(struct bt_stream_pos *pos, struct definition *definition);
+int bt_struct_rw(struct bt_stream_pos *pos, struct bt_definition *definition);
 uint64_t bt_struct_declaration_len(struct declaration_struct *struct_declaration);
 
 /*
@@ -473,14 +473,14 @@ struct declaration_field *
  * Returns 0 on success, -EPERM on error.
  */
 int variant_definition_set_tag(struct definition_variant *variant,
-			       struct definition *enum_tag);
+			       struct bt_definition *enum_tag);
 /*
  * Returns the field selected by the current tag value.
  * field returned only valid as long as the variant structure is not appended
  * to.
  */
-struct definition *bt_variant_get_current_field(struct definition_variant *variant);
-int bt_variant_rw(struct bt_stream_pos *pos, struct definition *definition);
+struct bt_definition *bt_variant_get_current_field(struct definition_variant *variant);
+int bt_variant_rw(struct bt_stream_pos *pos, struct bt_definition *definition);
 
 /*
  * elem_declaration passed as parameter now belongs to the array. No
@@ -491,10 +491,10 @@ struct declaration_array *
 	bt_array_declaration_new(size_t len, struct declaration *elem_declaration,
 		struct declaration_scope *parent_scope);
 uint64_t bt_array_len(struct definition_array *array);
-struct definition *bt_array_index(struct definition_array *array, uint64_t i);
-int bt_array_rw(struct bt_stream_pos *pos, struct definition *definition);
-GString *bt_get_char_array(const struct definition *field);
-int bt_get_array_len(const struct definition *field);
+struct bt_definition *bt_array_index(struct definition_array *array, uint64_t i);
+int bt_array_rw(struct bt_stream_pos *pos, struct bt_definition *definition);
+GString *bt_get_char_array(const struct bt_definition *field);
+int bt_get_array_len(const struct bt_definition *field);
 
 /*
  * int_declaration and elem_declaration passed as parameter now belong
@@ -505,8 +505,8 @@ struct declaration_sequence *
 		struct declaration *elem_declaration,
 		struct declaration_scope *parent_scope);
 uint64_t bt_sequence_len(struct definition_sequence *sequence);
-struct definition *bt_sequence_index(struct definition_sequence *sequence, uint64_t i);
-int bt_sequence_rw(struct bt_stream_pos *pos, struct definition *definition);
+struct bt_definition *bt_sequence_index(struct definition_sequence *sequence, uint64_t i);
+int bt_sequence_rw(struct bt_stream_pos *pos, struct bt_definition *definition);
 
 /*
  * in: path (dot separated), out: q (GArray of GQuark)
@@ -516,15 +516,15 @@ void bt_append_scope_path(const char *path, GArray *q);
 /*
  * Lookup helpers.
  */
-struct definition *bt_lookup_definition(const struct definition *definition,
+struct bt_definition *bt_lookup_definition(const struct bt_definition *definition,
 				     const char *field_name);
-struct definition_integer *bt_lookup_integer(const struct definition *definition,
+struct definition_integer *bt_lookup_integer(const struct bt_definition *definition,
 					  const char *field_name,
 					  int signedness);
-struct definition_enum *bt_lookup_enum(const struct definition *definition,
+struct definition_enum *bt_lookup_enum(const struct bt_definition *definition,
 				    const char *field_name,
 				    int signedness);
-struct definition *bt_lookup_variant(const struct definition *definition,
+struct bt_definition *bt_lookup_variant(const struct bt_definition *definition,
 				  const char *field_name);
 
 static inline
diff --git a/types/array.c b/types/array.c
index 43decb5..debc15a 100644
--- a/types/array.c
+++ b/types/array.c
@@ -32,13 +32,13 @@
 #include <inttypes.h>
 
 static
-struct definition *_array_definition_new(struct declaration *declaration,
+struct bt_definition *_array_definition_new(struct declaration *declaration,
 			struct definition_scope *parent_scope,
 			GQuark field_name, int index, const char *root_name);
 static
-void _array_definition_free(struct definition *definition);
+void _array_definition_free(struct bt_definition *definition);
 
-int bt_array_rw(struct bt_stream_pos *pos, struct definition *definition)
+int bt_array_rw(struct bt_stream_pos *pos, struct bt_definition *definition)
 {
 	struct definition_array *array_definition =
 		container_of(definition, struct definition_array, p);
@@ -49,7 +49,7 @@ int bt_array_rw(struct bt_stream_pos *pos, struct definition *definition)
 
 	/* No need to align, because the first field will align itself. */
 	for (i = 0; i < array_declaration->len; i++) {
-		struct definition *field =
+		struct bt_definition *field =
 			g_ptr_array_index(array_definition->elems, i);
 		ret = generic_rw(pos, field);
 		if (ret)
@@ -93,7 +93,7 @@ struct declaration_array *
 }
 
 static
-struct definition *
+struct bt_definition *
 	_array_definition_new(struct declaration *declaration,
 			      struct definition_scope *parent_scope,
 			      GQuark field_name, int index, const char *root_name)
@@ -142,7 +142,7 @@ struct definition *
 	array->elems = g_ptr_array_sized_new(array_declaration->len);
 	g_ptr_array_set_size(array->elems, array_declaration->len);
 	for (i = 0; i < array_declaration->len; i++) {
-		struct definition **field;
+		struct bt_definition **field;
 		GString *str;
 		GQuark name;
 
@@ -151,7 +151,7 @@ struct definition *
 		name = g_quark_from_string(str->str);
 		(void) g_string_free(str, TRUE);
 
-		field = (struct definition **) &g_ptr_array_index(array->elems, i);
+		field = (struct bt_definition **) &g_ptr_array_index(array->elems, i);
 		*field = array_declaration->elem->definition_new(array_declaration->elem,
 					  array->p.scope,
 					  name, i, NULL);
@@ -163,7 +163,7 @@ struct definition *
 
 error:
 	for (i--; i >= 0; i--) {
-		struct definition *field;
+		struct bt_definition *field;
 
 		field = g_ptr_array_index(array->elems, i);
 		field->declaration->definition_free(field);
@@ -176,7 +176,7 @@ error:
 }
 
 static
-void _array_definition_free(struct definition *definition)
+void _array_definition_free(struct bt_definition *definition)
 {
 	struct definition_array *array =
 		container_of(definition, struct definition_array, p);
@@ -186,7 +186,7 @@ void _array_definition_free(struct definition *definition)
 		(void) g_string_free(array->string, TRUE);
 	if (array->elems) {
 		for (i = 0; i < array->elems->len; i++) {
-			struct definition *field;
+			struct bt_definition *field;
 
 			field = g_ptr_array_index(array->elems, i);
 			field->declaration->definition_free(field);
@@ -205,7 +205,7 @@ uint64_t bt_array_len(struct definition_array *array)
 	return array->elems->len;
 }
 
-struct definition *bt_array_index(struct definition_array *array, uint64_t i)
+struct bt_definition *bt_array_index(struct definition_array *array, uint64_t i)
 {
 	if (!array->elems)
 		return NULL;
@@ -214,7 +214,7 @@ struct definition *bt_array_index(struct definition_array *array, uint64_t i)
 	return g_ptr_array_index(array->elems, i);
 }
 
-int bt_get_array_len(const struct definition *field)
+int bt_get_array_len(const struct bt_definition *field)
 {
 	struct definition_array *array_definition;
 	struct declaration_array *array_declaration;
@@ -225,7 +225,7 @@ int bt_get_array_len(const struct definition *field)
 	return array_declaration->len;
 }
 
-GString *bt_get_char_array(const struct definition *field)
+GString *bt_get_char_array(const struct bt_definition *field)
 {
 	struct definition_array *array_definition;
 	struct declaration_array *array_declaration;
diff --git a/types/enum.c b/types/enum.c
index 2c0cfe8..e967e14 100644
--- a/types/enum.c
+++ b/types/enum.c
@@ -41,12 +41,12 @@
 #endif
 
 static
-struct definition *_enum_definition_new(struct declaration *declaration,
+struct bt_definition *_enum_definition_new(struct declaration *declaration,
 					struct definition_scope *parent_scope,
 					GQuark field_name, int index,
 					const char *root_name);
 static
-void _enum_definition_free(struct definition *definition);
+void _enum_definition_free(struct bt_definition *definition);
 
 static
 void enum_range_set_free(void *ptr)
@@ -417,7 +417,7 @@ struct declaration_enum *
 }
 
 static
-struct definition *
+struct bt_definition *
 	_enum_definition_new(struct declaration *declaration,
 			     struct definition_scope *parent_scope,
 			     GQuark field_name, int index,
@@ -426,7 +426,7 @@ struct definition *
 	struct declaration_enum *enum_declaration =
 		container_of(declaration, struct declaration_enum, p);
 	struct definition_enum *_enum;
-	struct definition *definition_integer_parent;
+	struct bt_definition *definition_integer_parent;
 	int ret;
 
 	_enum = g_new(struct definition_enum, 1);
@@ -456,7 +456,7 @@ struct definition *
 }
 
 static
-void _enum_definition_free(struct definition *definition)
+void _enum_definition_free(struct bt_definition *definition)
 {
 	struct definition_enum *_enum =
 		container_of(definition, struct definition_enum, p);
diff --git a/types/float.c b/types/float.c
index 16d4352..7aeb9c3 100644
--- a/types/float.c
+++ b/types/float.c
@@ -32,12 +32,12 @@
 #include <babeltrace/endian.h>
 
 static
-struct definition *_float_definition_new(struct declaration *declaration,
+struct bt_definition *_float_definition_new(struct declaration *declaration,
 				   struct definition_scope *parent_scope,
 				   GQuark field_name, int index,
 				   const char *root_name);
 static
-void _float_definition_free(struct definition *definition);
+void _float_definition_free(struct bt_definition *definition);
 
 static
 void _float_declaration_free(struct declaration *declaration)
@@ -81,7 +81,7 @@ struct declaration_float *
 }
 
 static
-struct definition *
+struct bt_definition *
 	_float_definition_new(struct declaration *declaration,
 			      struct definition_scope *parent_scope,
 			      GQuark field_name, int index,
@@ -90,7 +90,7 @@ struct definition *
 	struct declaration_float *float_declaration =
 		container_of(declaration, struct declaration_float, p);
 	struct definition_float *_float;
-	struct definition *tmp;
+	struct bt_definition *tmp;
 
 	_float = g_new(struct definition_float, 1);
 	bt_declaration_ref(&float_declaration->p);
@@ -138,7 +138,7 @@ struct definition *
 }
 
 static
-void _float_definition_free(struct definition *definition)
+void _float_definition_free(struct bt_definition *definition)
 {
 	struct definition_float *_float =
 		container_of(definition, struct definition_float, p);
diff --git a/types/integer.c b/types/integer.c
index 47f23eb..92c7eb1 100644
--- a/types/integer.c
+++ b/types/integer.c
@@ -33,12 +33,12 @@
 #include <stdint.h>
 
 static
-struct definition *_integer_definition_new(struct declaration *declaration,
+struct bt_definition *_integer_definition_new(struct declaration *declaration,
 			       struct definition_scope *parent_scope,
 			       GQuark field_name, int index,
 			       const char *root_name);
 static
-void _integer_definition_free(struct definition *definition);
+void _integer_definition_free(struct bt_definition *definition);
 
 static
 void _integer_declaration_free(struct declaration *declaration)
@@ -73,7 +73,7 @@ struct declaration_integer *
 }
 
 static
-struct definition *
+struct bt_definition *
 	_integer_definition_new(struct declaration *declaration,
 				struct definition_scope *parent_scope,
 				GQuark field_name, int index,
@@ -106,7 +106,7 @@ struct definition *
 }
 
 static
-void _integer_definition_free(struct definition *definition)
+void _integer_definition_free(struct bt_definition *definition)
 {
 	struct definition_integer *integer =
 		container_of(definition, struct definition_integer, p);
@@ -115,7 +115,7 @@ void _integer_definition_free(struct definition *definition)
 	g_free(integer);
 }
 
-enum ctf_string_encoding bt_get_int_encoding(const struct definition *field)
+enum ctf_string_encoding bt_get_int_encoding(const struct bt_definition *field)
 {
 	struct definition_integer *integer_definition;
 	const struct declaration_integer *integer_declaration;
@@ -126,7 +126,7 @@ enum ctf_string_encoding bt_get_int_encoding(const struct definition *field)
 	return integer_declaration->encoding;
 }
 
-int bt_get_int_base(const struct definition *field)
+int bt_get_int_base(const struct bt_definition *field)
 {
 	struct definition_integer *integer_definition;
 	const struct declaration_integer *integer_declaration;
@@ -137,7 +137,7 @@ int bt_get_int_base(const struct definition *field)
 	return integer_declaration->base;
 }
 
-size_t bt_get_int_len(const struct definition *field)
+size_t bt_get_int_len(const struct bt_definition *field)
 {
 	struct definition_integer *integer_definition;
 	const struct declaration_integer *integer_declaration;
@@ -148,7 +148,7 @@ size_t bt_get_int_len(const struct definition *field)
 	return integer_declaration->len;
 }
 
-int bt_get_int_byte_order(const struct definition *field)
+int bt_get_int_byte_order(const struct bt_definition *field)
 {
 	struct definition_integer *integer_definition;
 	const struct declaration_integer *integer_declaration;
@@ -159,7 +159,7 @@ int bt_get_int_byte_order(const struct definition *field)
 	return integer_declaration->byte_order;
 }
 
-int bt_get_int_signedness(const struct definition *field)
+int bt_get_int_signedness(const struct bt_definition *field)
 {
 	struct definition_integer *integer_definition;
 	const struct declaration_integer *integer_declaration;
@@ -170,7 +170,7 @@ int bt_get_int_signedness(const struct definition *field)
 	return integer_declaration->signedness;
 }
 
-uint64_t bt_get_unsigned_int(const struct definition *field)
+uint64_t bt_get_unsigned_int(const struct bt_definition *field)
 {
 	struct definition_integer *integer_definition;
 	const struct declaration_integer *integer_declaration;
@@ -186,7 +186,7 @@ uint64_t bt_get_unsigned_int(const struct definition *field)
 	return (uint64_t)integer_definition->value._signed;
 }
 
-int64_t bt_get_signed_int(const struct definition *field)
+int64_t bt_get_signed_int(const struct bt_definition *field)
 {
 	struct definition_integer *integer_definition;
 	const struct declaration_integer *integer_declaration;
diff --git a/types/sequence.c b/types/sequence.c
index a91a249..8792325 100644
--- a/types/sequence.c
+++ b/types/sequence.c
@@ -32,14 +32,14 @@
 #include <inttypes.h>
 
 static
-struct definition *_sequence_definition_new(struct declaration *declaration,
+struct bt_definition *_sequence_definition_new(struct declaration *declaration,
 					struct definition_scope *parent_scope,
 					GQuark field_name, int index,
 					const char *root_name);
 static
-void _sequence_definition_free(struct definition *definition);
+void _sequence_definition_free(struct bt_definition *definition);
 
-int bt_sequence_rw(struct bt_stream_pos *pos, struct definition *definition)
+int bt_sequence_rw(struct bt_stream_pos *pos, struct bt_definition *definition)
 {
 	struct definition_sequence *sequence_definition =
 		container_of(definition, struct definition_sequence, p);
@@ -62,7 +62,7 @@ int bt_sequence_rw(struct bt_stream_pos *pos, struct definition *definition)
 		g_ptr_array_set_size(sequence_definition->elems, len);
 
 	for (i = oldlen; i < len; i++) {
-		struct definition **field;
+		struct bt_definition **field;
 		GString *str;
 		GQuark name;
 
@@ -71,15 +71,15 @@ int bt_sequence_rw(struct bt_stream_pos *pos, struct definition *definition)
 		name = g_quark_from_string(str->str);
 		(void) g_string_free(str, TRUE);
 
-		field = (struct definition **) &g_ptr_array_index(sequence_definition->elems, i);
+		field = (struct bt_definition **) &g_ptr_array_index(sequence_definition->elems, i);
 		*field = sequence_declaration->elem->definition_new(sequence_declaration->elem,
 					  sequence_definition->p.scope,
 					  name, i, NULL);
 	}
 	for (i = 0; i < len; i++) {
-		struct definition **field;
+		struct bt_definition **field;
 
-		field = (struct definition **) &g_ptr_array_index(sequence_definition->elems, i);
+		field = (struct bt_definition **) &g_ptr_array_index(sequence_definition->elems, i);
 		ret = generic_rw(pos, *field);
 		if (ret)
 			return ret;
@@ -126,7 +126,7 @@ struct declaration_sequence *
 }
 
 static
-struct definition *_sequence_definition_new(struct declaration *declaration,
+struct bt_definition *_sequence_definition_new(struct declaration *declaration,
 				struct definition_scope *parent_scope,
 				GQuark field_name, int index,
 				const char *root_name)
@@ -134,7 +134,7 @@ struct definition *_sequence_definition_new(struct declaration *declaration,
 	struct declaration_sequence *sequence_declaration =
 		container_of(declaration, struct declaration_sequence, p);
 	struct definition_sequence *sequence;
-	struct definition *len_parent;
+	struct bt_definition *len_parent;
 	int ret;
 
 	sequence = g_new(struct definition_sequence, 1);
@@ -198,18 +198,18 @@ error:
 }
 
 static
-void _sequence_definition_free(struct definition *definition)
+void _sequence_definition_free(struct bt_definition *definition)
 {
 	struct definition_sequence *sequence =
 		container_of(definition, struct definition_sequence, p);
-	struct definition *len_definition = &sequence->length->p;
+	struct bt_definition *len_definition = &sequence->length->p;
 	uint64_t i;
 
 	if (sequence->string)
 		(void) g_string_free(sequence->string, TRUE);
 	if (sequence->elems) {
 		for (i = 0; i < sequence->elems->len; i++) {
-			struct definition *field;
+			struct bt_definition *field;
 
 			field = g_ptr_array_index(sequence->elems, i);
 			field->declaration->definition_free(field);
@@ -227,7 +227,7 @@ uint64_t bt_sequence_len(struct definition_sequence *sequence)
 	return sequence->length->value._unsigned;
 }
 
-struct definition *bt_sequence_index(struct definition_sequence *sequence, uint64_t i)
+struct bt_definition *bt_sequence_index(struct definition_sequence *sequence, uint64_t i)
 {
 	if (!sequence->elems)
 		return NULL;
diff --git a/types/string.c b/types/string.c
index dff27ee..5db1716 100644
--- a/types/string.c
+++ b/types/string.c
@@ -32,12 +32,12 @@
 #include <babeltrace/types.h>
 
 static
-struct definition *_string_definition_new(struct declaration *declaration,
+struct bt_definition *_string_definition_new(struct declaration *declaration,
 				struct definition_scope *parent_scope,
 				GQuark field_name, int index,
 				const char *root_name);
 static
-void _string_definition_free(struct definition *definition);
+void _string_definition_free(struct bt_definition *definition);
 
 static
 void _string_declaration_free(struct declaration *declaration)
@@ -64,7 +64,7 @@ struct declaration_string *
 }
 
 static
-struct definition *
+struct bt_definition *
 	_string_definition_new(struct declaration *declaration,
 			       struct definition_scope *parent_scope,
 			       GQuark field_name, int index,
@@ -99,7 +99,7 @@ struct definition *
 }
 
 static
-void _string_definition_free(struct definition *definition)
+void _string_definition_free(struct bt_definition *definition)
 {
 	struct definition_string *string =
 		container_of(definition, struct definition_string, p);
@@ -109,7 +109,7 @@ void _string_definition_free(struct definition *definition)
 	g_free(string);
 }
 
-enum ctf_string_encoding bt_get_string_encoding(const struct definition *field)
+enum ctf_string_encoding bt_get_string_encoding(const struct bt_definition *field)
 {
 	struct definition_string *string_definition;
 	const struct declaration_string *string_declaration;
@@ -120,7 +120,7 @@ enum ctf_string_encoding bt_get_string_encoding(const struct definition *field)
 	return string_declaration->encoding;
 }
 
-char *bt_get_string(const struct definition *field)
+char *bt_get_string(const struct bt_definition *field)
 {
 	struct definition_string *string_definition =
 		container_of(field, struct definition_string, p);
diff --git a/types/struct.c b/types/struct.c
index 219d523..fadc187 100644
--- a/types/struct.c
+++ b/types/struct.c
@@ -36,14 +36,14 @@
 #endif
 
 static
-struct definition *_struct_definition_new(struct declaration *declaration,
+struct bt_definition *_struct_definition_new(struct declaration *declaration,
 				struct definition_scope *parent_scope,
 				GQuark field_name, int index,
 				const char *root_name);
 static
-void _struct_definition_free(struct definition *definition);
+void _struct_definition_free(struct bt_definition *definition);
 
-int bt_struct_rw(struct bt_stream_pos *ppos, struct definition *definition)
+int bt_struct_rw(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
 	struct definition_struct *struct_definition =
 		container_of(definition, struct definition_struct, p);
@@ -51,7 +51,7 @@ int bt_struct_rw(struct bt_stream_pos *ppos, struct definition *definition)
 	int ret;
 
 	for (i = 0; i < struct_definition->fields->len; i++) {
-		struct definition *field =
+		struct bt_definition *field =
 			g_ptr_array_index(struct_definition->fields, i);
 		ret = generic_rw(ppos, field);
 		if (ret)
@@ -105,7 +105,7 @@ struct declaration_struct *
 }
 
 static
-struct definition *
+struct bt_definition *
 	_struct_definition_new(struct declaration *declaration,
 			       struct definition_scope *parent_scope,
 			       GQuark field_name, int index,
@@ -141,8 +141,8 @@ struct definition *
 		struct declaration_field *declaration_field =
 			&g_array_index(struct_declaration->fields,
 				       struct declaration_field, i);
-		struct definition **field =
-			(struct definition **) &g_ptr_array_index(_struct->fields, i);
+		struct bt_definition **field =
+			(struct bt_definition **) &g_ptr_array_index(_struct->fields, i);
 
 		*field = declaration_field->declaration->definition_new(declaration_field->declaration,
 							  _struct->p.scope,
@@ -154,7 +154,7 @@ struct definition *
 
 error:
 	for (i--; i >= 0; i--) {
-		struct definition *field = g_ptr_array_index(_struct->fields, i);
+		struct bt_definition *field = g_ptr_array_index(_struct->fields, i);
 		bt_definition_unref(field);
 	}
 	bt_free_definition_scope(_struct->p.scope);
@@ -164,7 +164,7 @@ error:
 }
 
 static
-void _struct_definition_free(struct definition *definition)
+void _struct_definition_free(struct bt_definition *definition)
 {
 	struct definition_struct *_struct =
 		container_of(definition, struct definition_struct, p);
@@ -172,7 +172,7 @@ void _struct_definition_free(struct definition *definition)
 
 	assert(_struct->fields->len == _struct->declaration->fields->len);
 	for (i = 0; i < _struct->fields->len; i++) {
-		struct definition *field = g_ptr_array_index(_struct->fields, i);
+		struct bt_definition *field = g_ptr_array_index(_struct->fields, i);
 		bt_definition_unref(field);
 	}
 	bt_free_definition_scope(_struct->p.scope);
@@ -241,7 +241,7 @@ struct declaration_field *
 /*
  * field returned only valid as long as the field structure is not appended to.
  */
-struct definition *
+struct bt_definition *
 bt_struct_definition_get_field_from_index(struct definition_struct *_struct,
 					int index)
 {
diff --git a/types/types.c b/types/types.c
index 3e20dfe..b235c13 100644
--- a/types/types.c
+++ b/types/types.c
@@ -92,7 +92,7 @@ int bt_register_declaration(GQuark name, struct declaration *declaration,
 }
 
 static
-struct definition *
+struct bt_definition *
 	lookup_field_definition_scope(GQuark field_name,
 		struct definition_scope *scope)
 {
@@ -158,7 +158,7 @@ end:
 }
 
 static struct definition_scope *
-	get_definition_scope(const struct definition *definition)
+	get_definition_scope(const struct bt_definition *definition)
 {
 	return definition->scope;
 }
@@ -183,12 +183,12 @@ static struct definition_scope *
  * lookup_path: the path leading to the enum we want to look for.
  * scope: the definition scope containing the variant definition.
  */
-struct definition *
+struct bt_definition *
 	bt_lookup_path_definition(GArray *cur_path,
 			       GArray *lookup_path,
 			       struct definition_scope *scope)
 {
-	struct definition *definition, *lookup_definition;
+	struct bt_definition *definition, *lookup_definition;
 	GQuark last;
 	int index;
 
@@ -262,7 +262,7 @@ lookup:
 	return NULL;
 }
 
-int bt_register_field_definition(GQuark field_name, struct definition *definition,
+int bt_register_field_definition(GQuark field_name, struct bt_definition *definition,
 		struct definition_scope *scope)
 {
 	if (!scope || !field_name)
@@ -292,12 +292,12 @@ void bt_declaration_unref(struct declaration *declaration)
 		declaration->declaration_free(declaration);
 }
 
-void bt_definition_ref(struct definition *definition)
+void bt_definition_ref(struct bt_definition *definition)
 {
 	definition->ref++;
 }
 
-void bt_definition_unref(struct definition *definition)
+void bt_definition_unref(struct bt_definition *definition)
 {
 	if (!definition)
 		return;
@@ -612,7 +612,7 @@ void bt_free_definition_scope(struct definition_scope *scope)
 	g_free(scope);
 }
 
-struct definition *bt_lookup_definition(const struct definition *definition,
+struct bt_definition *bt_lookup_definition(const struct bt_definition *definition,
 				     const char *field_name)
 {
 	struct definition_scope *scope = get_definition_scope(definition);
@@ -624,11 +624,11 @@ struct definition *bt_lookup_definition(const struct definition *definition,
 					     scope);
 }
 
-struct definition_integer *bt_lookup_integer(const struct definition *definition,
+struct definition_integer *bt_lookup_integer(const struct bt_definition *definition,
 					  const char *field_name,
 					  int signedness)
 {
-	struct definition *lookup;
+	struct bt_definition *lookup;
 	struct definition_integer *lookup_integer;
 
 	lookup = bt_lookup_definition(definition, field_name);
@@ -642,11 +642,11 @@ struct definition_integer *bt_lookup_integer(const struct definition *definition
 	return lookup_integer;
 }
 
-struct definition_enum *bt_lookup_enum(const struct definition *definition,
+struct definition_enum *bt_lookup_enum(const struct bt_definition *definition,
 				    const char *field_name,
 				    int signedness)
 {
-	struct definition *lookup;
+	struct bt_definition *lookup;
 	struct definition_enum *lookup_enum;
 
 	lookup = bt_lookup_definition(definition, field_name);
@@ -660,10 +660,10 @@ struct definition_enum *bt_lookup_enum(const struct definition *definition,
 	return lookup_enum;
 }
 
-struct definition *bt_lookup_variant(const struct definition *definition,
+struct bt_definition *bt_lookup_variant(const struct bt_definition *definition,
 				  const char *field_name)
 {
-	struct definition *lookup;
+	struct bt_definition *lookup;
 	struct definition_variant *bt_lookup_variant;
 
 	lookup = bt_lookup_definition(definition, field_name);
diff --git a/types/variant.c b/types/variant.c
index 4db0de9..ed29550 100644
--- a/types/variant.c
+++ b/types/variant.c
@@ -32,18 +32,18 @@
 #include <errno.h>
 
 static
-struct definition *_variant_definition_new(struct declaration *declaration,
+struct bt_definition *_variant_definition_new(struct declaration *declaration,
 				struct definition_scope *parent_scope,
 				GQuark field_name, int index,
 				const char *root_name);
 static
-void _variant_definition_free(struct definition *definition);
+void _variant_definition_free(struct bt_definition *definition);
 
-int bt_variant_rw(struct bt_stream_pos *ppos, struct definition *definition)
+int bt_variant_rw(struct bt_stream_pos *ppos, struct bt_definition *definition)
 {
 	struct definition_variant *variant_definition =
 		container_of(definition, struct definition_variant, p);
-	struct definition *field;
+	struct bt_definition *field;
 
 	field = bt_variant_get_current_field(variant_definition);
 	return generic_rw(ppos, field);
@@ -130,7 +130,7 @@ struct declaration_variant *
  */
 static
 int check_enum_tag(struct definition_variant *variant,
-		   struct definition *enum_tag)
+		   struct bt_definition *enum_tag)
 {
 	struct definition_enum *_enum =
 		container_of(enum_tag, struct definition_enum, p);
@@ -172,7 +172,7 @@ int check_enum_tag(struct definition_variant *variant,
 
 
 static
-struct definition *
+struct bt_definition *
 	_variant_definition_new(struct declaration *declaration,
 				struct definition_scope *parent_scope,
 				GQuark field_name, int index,
@@ -216,8 +216,8 @@ struct definition *
 		struct declaration_field *declaration_field =
 			&g_array_index(variant_declaration->untagged_variant->fields,
 				       struct declaration_field, i);
-		struct definition **field =
-			(struct definition **) &g_ptr_array_index(variant->fields, i);
+		struct bt_definition **field =
+			(struct bt_definition **) &g_ptr_array_index(variant->fields, i);
 
 		/*
 		 * All child definition are at index 0, because they are
@@ -239,7 +239,7 @@ error:
 }
 
 static
-void _variant_definition_free(struct definition *definition)
+void _variant_definition_free(struct bt_definition *definition)
 {
 	struct definition_variant *variant =
 		container_of(definition, struct definition_variant, p);
@@ -247,7 +247,7 @@ void _variant_definition_free(struct definition *definition)
 
 	assert(variant->fields->len == variant->declaration->untagged_variant->fields->len);
 	for (i = 0; i < variant->fields->len; i++) {
-		struct definition *field = g_ptr_array_index(variant->fields, i);
+		struct bt_definition *field = g_ptr_array_index(variant->fields, i);
 		bt_definition_unref(field);
 	}
 	bt_definition_unref(variant->enum_tag);
@@ -301,7 +301,7 @@ bt_untagged_variant_declaration_get_field_from_tag(struct declaration_untagged_v
 /*
  * field returned only valid as long as the field structure is not appended to.
  */
-struct definition *bt_variant_get_current_field(struct definition_variant *variant)
+struct bt_definition *bt_variant_get_current_field(struct definition_variant *variant)
 {
 	struct definition_enum *_enum =
 		container_of(variant->enum_tag, struct definition_enum, p);
-- 
1.7.10.4
