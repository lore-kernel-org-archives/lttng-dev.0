From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 10/18] namespace the sequence
	functions
Date: Thu, 24 Jan 2013 16:21:42 -0500
Message-ID: <1359062510-7557-10-git-send-email-jdesfossez__3339.91635493494$1359064922$gmane$org@efficios.com>
References: <1359062510-7557-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TyUFS-0008F6-3l
	for lttng-dev@lists.lttng.org; Thu, 24 Jan 2013 16:22:14 -0500
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
 formats/ctf-text/types/sequence.c                     |    4 ++--
 formats/ctf/events.c                                  |    2 +-
 formats/ctf/metadata/ctf-visitor-generate-io-struct.c |    2 +-
 formats/ctf/types/sequence.c                          |    8 ++++----
 include/babeltrace/types.h                            |    8 ++++----
 types/sequence.c                                      |    8 ++++----
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/formats/ctf-text/types/sequence.c b/formats/ctf-text/types/sequence.c
index 20345cc..12574ee 100644
--- a/formats/ctf-text/types/sequence.c
+++ b/formats/ctf-text/types/sequence.c
@@ -63,7 +63,7 @@ int ctf_text_sequence_write(struct stream_pos *ppos, struct definition *definiti
 			    && integer_declaration->p.alignment == CHAR_BIT)) {
 				pos->string = sequence_definition->string;
 				g_string_assign(sequence_definition->string, "");
-				ret = sequence_rw(ppos, definition);
+				ret = bt_sequence_rw(ppos, definition);
 				pos->string = NULL;
 			}
 			fprintf(pos->fp, "\"%s\"", sequence_definition->string->str);
@@ -77,7 +77,7 @@ int ctf_text_sequence_write(struct stream_pos *ppos, struct definition *definiti
 	}
 	field_nr_saved = pos->field_nr;
 	pos->field_nr = 0;
-	ret = sequence_rw(ppos, definition);
+	ret = bt_sequence_rw(ppos, definition);
 	if (!pos->dummy) {
 		pos->depth--;
 		fprintf(pos->fp, " ]");
diff --git a/formats/ctf/events.c b/formats/ctf/events.c
index 372fdd1..036ce46 100644
--- a/formats/ctf/events.c
+++ b/formats/ctf/events.c
@@ -145,7 +145,7 @@ const struct definition *bt_ctf_get_index(const struct bt_ctf_event *ctf_event,
 		struct definition_sequence *sequence_definition;
 		sequence_definition = container_of(field,
 				struct definition_sequence, p);
-		ret = sequence_index(sequence_definition, index);
+		ret = bt_sequence_index(sequence_definition, index);
 	}
 	return ret;
 }
diff --git a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
index 928262f..94dd0c8 100644
--- a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
+++ b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
@@ -526,7 +526,7 @@ struct declaration *ctf_type_declarator_visit(FILE *fd, int depth,
 			char *length_name = concatenate_unary_strings(&node_type_declarator->u.type_declarator.u.nested.length);
 			struct declaration_sequence *sequence_declaration;
 
-			sequence_declaration = sequence_declaration_new(length_name, nested_declaration, declaration_scope);
+			sequence_declaration = bt_sequence_declaration_new(length_name, nested_declaration, declaration_scope);
 			if (!sequence_declaration) {
 				fprintf(fd, "[error] %s: cannot create sequence declaration.\n", __func__);
 				g_free(length_name);
diff --git a/formats/ctf/types/sequence.c b/formats/ctf/types/sequence.c
index 7f12bbc..2ff31b7 100644
--- a/formats/ctf/types/sequence.c
+++ b/formats/ctf/types/sequence.c
@@ -46,7 +46,7 @@ int ctf_sequence_read(struct stream_pos *ppos, struct definition *definition)
 
 			if (integer_declaration->len == CHAR_BIT
 			    && integer_declaration->p.alignment == CHAR_BIT) {
-				uint64_t len = sequence_len(sequence_definition);
+				uint64_t len = bt_sequence_len(sequence_definition);
 
 				ctf_align_pos(pos, integer_declaration->p.alignment);
 				if (!ctf_pos_access_ok(pos, len * CHAR_BIT))
@@ -60,7 +60,7 @@ int ctf_sequence_read(struct stream_pos *ppos, struct definition *definition)
 			}
 		}
 	}
-	return sequence_rw(ppos, definition);
+	return bt_sequence_rw(ppos, definition);
 }
 
 int ctf_sequence_write(struct stream_pos *ppos, struct definition *definition)
@@ -81,7 +81,7 @@ int ctf_sequence_write(struct stream_pos *ppos, struct definition *definition)
 
 			if (integer_declaration->len == CHAR_BIT
 			    && integer_declaration->p.alignment == CHAR_BIT) {
-				uint64_t len = sequence_len(sequence_definition);
+				uint64_t len = bt_sequence_len(sequence_definition);
 
 				ctf_align_pos(pos, integer_declaration->p.alignment);
 				if (!ctf_pos_access_ok(pos, len * CHAR_BIT))
@@ -94,5 +94,5 @@ int ctf_sequence_write(struct stream_pos *ppos, struct definition *definition)
 			}
 		}
 	}
-	return sequence_rw(ppos, definition);
+	return bt_sequence_rw(ppos, definition);
 }
diff --git a/include/babeltrace/types.h b/include/babeltrace/types.h
index 7b3485d..a0c5467 100644
--- a/include/babeltrace/types.h
+++ b/include/babeltrace/types.h
@@ -501,12 +501,12 @@ int bt_get_array_len(const struct definition *field);
  * to the sequence. No need to free them explicitly.
  */
 struct declaration_sequence *
-	sequence_declaration_new(const char *length_name,
+	bt_sequence_declaration_new(const char *length_name,
 		struct declaration *elem_declaration,
 		struct declaration_scope *parent_scope);
-uint64_t sequence_len(struct definition_sequence *sequence);
-struct definition *sequence_index(struct definition_sequence *sequence, uint64_t i);
-int sequence_rw(struct stream_pos *pos, struct definition *definition);
+uint64_t bt_sequence_len(struct definition_sequence *sequence);
+struct definition *bt_sequence_index(struct definition_sequence *sequence, uint64_t i);
+int bt_sequence_rw(struct stream_pos *pos, struct definition *definition);
 
 /*
  * in: path (dot separated), out: q (GArray of GQuark)
diff --git a/types/sequence.c b/types/sequence.c
index 736e866..6ed168c 100644
--- a/types/sequence.c
+++ b/types/sequence.c
@@ -39,7 +39,7 @@ struct definition *_sequence_definition_new(struct declaration *declaration,
 static
 void _sequence_definition_free(struct definition *definition);
 
-int sequence_rw(struct stream_pos *pos, struct definition *definition)
+int bt_sequence_rw(struct stream_pos *pos, struct definition *definition)
 {
 	struct definition_sequence *sequence_definition =
 		container_of(definition, struct definition_sequence, p);
@@ -100,7 +100,7 @@ void _sequence_declaration_free(struct declaration *declaration)
 }
 
 struct declaration_sequence *
-	sequence_declaration_new(const char *length,
+	bt_sequence_declaration_new(const char *length,
 			  struct declaration *elem_declaration,
 			  struct declaration_scope *parent_scope)
 {
@@ -222,12 +222,12 @@ void _sequence_definition_free(struct definition *definition)
 	g_free(sequence);
 }
 
-uint64_t sequence_len(struct definition_sequence *sequence)
+uint64_t bt_sequence_len(struct definition_sequence *sequence)
 {
 	return sequence->length->value._unsigned;
 }
 
-struct definition *sequence_index(struct definition_sequence *sequence, uint64_t i)
+struct definition *bt_sequence_index(struct definition_sequence *sequence, uint64_t i)
 {
 	if (!sequence->elems)
 		return NULL;
-- 
1.7.10.4
