From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 07/18] namespace definition_ref and
	definition_unref
Date: Thu, 24 Jan 2013 16:21:39 -0500
Message-ID: <1359062510-7557-7-git-send-email-jdesfossez__28540.0696601302$1359062610$gmane$org@efficios.com>
References: <1359062510-7557-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TyUFN-0008Eh-FR
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
 formats/ctf/ctf.c                                     |   14 +++++++-------
 formats/ctf/metadata/ctf-visitor-generate-io-struct.c |   12 ++++++------
 formats/ctf/types/float.c                             |    4 ++--
 include/babeltrace/types.h                            |    4 ++--
 types/enum.c                                          |    2 +-
 types/float.c                                         |    6 +++---
 types/sequence.c                                      |    4 ++--
 types/struct.c                                        |    4 ++--
 types/types.c                                         |    4 ++--
 types/variant.c                                       |    6 +++---
 10 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index e18fffb..6a24087 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -1168,9 +1168,9 @@ struct ctf_event_definition *create_event_definitions(struct ctf_trace *td,
 
 error:
 	if (stream_event->event_fields)
-		definition_unref(&stream_event->event_fields->p);
+		bt_definition_unref(&stream_event->event_fields->p);
 	if (stream_event->event_context)
-		definition_unref(&stream_event->event_context->p);
+		bt_definition_unref(&stream_event->event_context->p);
 	return NULL;
 }
 
@@ -1246,11 +1246,11 @@ error_event:
 	g_ptr_array_free(stream->events_by_id, TRUE);
 error:
 	if (stream->stream_event_context)
-		definition_unref(&stream->stream_event_context->p);
+		bt_definition_unref(&stream->stream_event_context->p);
 	if (stream->stream_event_header)
-		definition_unref(&stream->stream_event_header->p);
+		bt_definition_unref(&stream->stream_event_header->p);
 	if (stream->stream_packet_context)
-		definition_unref(&stream->stream_packet_context->p);
+		bt_definition_unref(&stream->stream_packet_context->p);
 	return ret;
 }
 
@@ -1572,7 +1572,7 @@ int ctf_open_file_stream_read(struct ctf_trace *td, const char *path, int flags,
 
 error_index:
 	if (file_stream->parent.trace_packet_header)
-		definition_unref(&file_stream->parent.trace_packet_header->p);
+		bt_definition_unref(&file_stream->parent.trace_packet_header->p);
 error_def:
 	closeret = ctf_fini_pos(&file_stream->pos);
 	if (closeret) {
@@ -1811,7 +1811,7 @@ int ctf_open_mmap_stream_read(struct ctf_trace *td,
 
 error_index:
 	if (file_stream->parent.trace_packet_header)
-		definition_unref(&file_stream->parent.trace_packet_header->p);
+		bt_definition_unref(&file_stream->parent.trace_packet_header->p);
 error_def:
 	g_free(file_stream);
 	return ret;
diff --git a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
index 9693345..9ade8c4 100644
--- a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
+++ b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
@@ -3004,19 +3004,19 @@ int ctf_destroy_metadata(struct ctf_trace *trace)
 					if (!event)
 						continue;
 					if (&event->event_fields->p)
-						definition_unref(&event->event_fields->p);
+						bt_definition_unref(&event->event_fields->p);
 					if (&event->event_context->p)
-						definition_unref(&event->event_context->p);
+						bt_definition_unref(&event->event_context->p);
 					g_free(event);
 				}
 				if (&stream_def->trace_packet_header->p)
-					definition_unref(&stream_def->trace_packet_header->p);
+					bt_definition_unref(&stream_def->trace_packet_header->p);
 				if (&stream_def->stream_event_header->p)
-					definition_unref(&stream_def->stream_event_header->p);
+					bt_definition_unref(&stream_def->stream_event_header->p);
 				if (&stream_def->stream_packet_context->p)
-					definition_unref(&stream_def->stream_packet_context->p);
+					bt_definition_unref(&stream_def->stream_packet_context->p);
 				if (&stream_def->stream_event_context->p)
-					definition_unref(&stream_def->stream_event_context->p);
+					bt_definition_unref(&stream_def->stream_event_context->p);
 				g_ptr_array_free(stream_def->events_by_id, TRUE);
 				g_free(stream_def);
 			}
diff --git a/formats/ctf/types/float.c b/formats/ctf/types/float.c
index d77cff5..fc7c39c 100644
--- a/formats/ctf/types/float.c
+++ b/formats/ctf/types/float.c
@@ -216,7 +216,7 @@ int ctf_float_read(struct stream_pos *ppos, struct definition *definition)
 	}
 
 end_unref:
-	definition_unref(tmpdef);
+	bt_definition_unref(tmpdef);
 end:
 	float_unlock();
 	return ret;
@@ -272,7 +272,7 @@ int ctf_float_write(struct stream_pos *ppos, struct definition *definition)
 	ret = _ctf_float_copy(ppos, float_definition, &srcp.parent, tmpfloat);
 
 end_unref:
-	definition_unref(tmpdef);
+	bt_definition_unref(tmpdef);
 end:
 	float_unlock();
 	return ret;
diff --git a/include/babeltrace/types.h b/include/babeltrace/types.h
index 2348823..1b0cd2b 100644
--- a/include/babeltrace/types.h
+++ b/include/babeltrace/types.h
@@ -367,8 +367,8 @@ int compare_definition_path(struct definition *definition, GQuark path)
 void bt_declaration_ref(struct declaration *declaration);
 void bt_declaration_unref(struct declaration *declaration);
 
-void definition_ref(struct definition *definition);
-void definition_unref(struct definition *definition);
+void bt_definition_ref(struct definition *definition);
+void bt_definition_unref(struct definition *definition);
 
 struct declaration_integer *integer_declaration_new(size_t len, int byte_order,
 				  int signedness, size_t alignment,
diff --git a/types/enum.c b/types/enum.c
index 2ea40ba..43df4eb 100644
--- a/types/enum.c
+++ b/types/enum.c
@@ -461,7 +461,7 @@ void _enum_definition_free(struct definition *definition)
 	struct definition_enum *_enum =
 		container_of(definition, struct definition_enum, p);
 
-	definition_unref(&_enum->integer->p);
+	bt_definition_unref(&_enum->integer->p);
 	free_definition_scope(_enum->p.scope);
 	bt_declaration_unref(_enum->p.declaration);
 	if (_enum->value)
diff --git a/types/float.c b/types/float.c
index 5c80312..0fc137f 100644
--- a/types/float.c
+++ b/types/float.c
@@ -143,9 +143,9 @@ void _float_definition_free(struct definition *definition)
 	struct definition_float *_float =
 		container_of(definition, struct definition_float, p);
 
-	definition_unref(&_float->sign->p);
-	definition_unref(&_float->exp->p);
-	definition_unref(&_float->mantissa->p);
+	bt_definition_unref(&_float->sign->p);
+	bt_definition_unref(&_float->exp->p);
+	bt_definition_unref(&_float->mantissa->p);
 	free_definition_scope(_float->p.scope);
 	bt_declaration_unref(_float->p.declaration);
 	g_free(_float);
diff --git a/types/sequence.c b/types/sequence.c
index 18d7e35..736e866 100644
--- a/types/sequence.c
+++ b/types/sequence.c
@@ -166,7 +166,7 @@ struct definition *_sequence_definition_new(struct declaration *declaration,
 		printf("[error] Sequence length field should be unsigned.\n");
 		goto error;
 	}
-	definition_ref(len_parent);
+	bt_definition_ref(len_parent);
 
 	sequence->string = NULL;
 	sequence->elems = NULL;
@@ -216,7 +216,7 @@ void _sequence_definition_free(struct definition *definition)
 		}
 		(void) g_ptr_array_free(sequence->elems, TRUE);
 	}
-	definition_unref(len_definition);
+	bt_definition_unref(len_definition);
 	free_definition_scope(sequence->p.scope);
 	bt_declaration_unref(sequence->p.declaration);
 	g_free(sequence);
diff --git a/types/struct.c b/types/struct.c
index 5cc0849..cf8fef6 100644
--- a/types/struct.c
+++ b/types/struct.c
@@ -155,7 +155,7 @@ struct definition *
 error:
 	for (i--; i >= 0; i--) {
 		struct definition *field = g_ptr_array_index(_struct->fields, i);
-		definition_unref(field);
+		bt_definition_unref(field);
 	}
 	free_definition_scope(_struct->p.scope);
 	bt_declaration_unref(&struct_declaration->p);
@@ -173,7 +173,7 @@ void _struct_definition_free(struct definition *definition)
 	assert(_struct->fields->len == _struct->declaration->fields->len);
 	for (i = 0; i < _struct->fields->len; i++) {
 		struct definition *field = g_ptr_array_index(_struct->fields, i);
-		definition_unref(field);
+		bt_definition_unref(field);
 	}
 	free_definition_scope(_struct->p.scope);
 	bt_declaration_unref(_struct->p.declaration);
diff --git a/types/types.c b/types/types.c
index 5bb051f..a6c8abe 100644
--- a/types/types.c
+++ b/types/types.c
@@ -292,12 +292,12 @@ void bt_declaration_unref(struct declaration *declaration)
 		declaration->declaration_free(declaration);
 }
 
-void definition_ref(struct definition *definition)
+void bt_definition_ref(struct definition *definition)
 {
 	definition->ref++;
 }
 
-void definition_unref(struct definition *definition)
+void bt_definition_unref(struct definition *definition)
 {
 	if (!definition)
 		return;
diff --git a/types/variant.c b/types/variant.c
index 4d00a3b..a58c17f 100644
--- a/types/variant.c
+++ b/types/variant.c
@@ -209,7 +209,7 @@ struct definition *
 	if (!variant->enum_tag
 	    || check_enum_tag(variant, variant->enum_tag) < 0)
 		goto error;
-	definition_ref(variant->enum_tag);
+	bt_definition_ref(variant->enum_tag);
 	variant->fields = g_ptr_array_sized_new(variant_declaration->untagged_variant->fields->len);
 	g_ptr_array_set_size(variant->fields, variant_declaration->untagged_variant->fields->len);
 	for (i = 0; i < variant_declaration->untagged_variant->fields->len; i++) {
@@ -248,9 +248,9 @@ void _variant_definition_free(struct definition *definition)
 	assert(variant->fields->len == variant->declaration->untagged_variant->fields->len);
 	for (i = 0; i < variant->fields->len; i++) {
 		struct definition *field = g_ptr_array_index(variant->fields, i);
-		definition_unref(field);
+		bt_definition_unref(field);
 	}
-	definition_unref(variant->enum_tag);
+	bt_definition_unref(variant->enum_tag);
 	free_definition_scope(variant->p.scope);
 	bt_declaration_unref(variant->p.declaration);
 	g_ptr_array_free(variant->fields, TRUE);
-- 
1.7.10.4
