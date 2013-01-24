From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 16/18] namespace the variant functions
Date: Thu, 24 Jan 2013 16:21:48 -0500
Message-ID: <1359062510-7557-16-git-send-email-jdesfossez__44689.0648142018$1359064856$gmane$org@efficios.com>
References: <1359062510-7557-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TyUFX-0008GB-Tp
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
 formats/ctf-text/types/variant.c |    2 +-
 formats/ctf/ctf.c                |    2 +-
 formats/ctf/types/variant.c      |    2 +-
 include/babeltrace/types.h       |    6 +++---
 types/types.c                    |    8 ++++----
 types/variant.c                  |    6 +++---
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/formats/ctf-text/types/variant.c b/formats/ctf-text/types/variant.c
index 89d518a..e7e50ac 100644
--- a/formats/ctf-text/types/variant.c
+++ b/formats/ctf-text/types/variant.c
@@ -52,7 +52,7 @@ int ctf_text_variant_write(struct stream_pos *ppos, struct definition *definitio
 	}
 	field_nr_saved = pos->field_nr;
 	pos->field_nr = 0;
-	ret = variant_rw(ppos, definition);
+	ret = bt_variant_rw(ppos, definition);
 	if (!pos->dummy) {
 		pos->depth--;
 		if (pos->depth >= 0) {
diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index e2a109b..ba403aa 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -439,7 +439,7 @@ int ctf_read_event(struct stream_pos *ppos, struct ctf_stream_definition *stream
 			}
 		}
 
-		variant = lookup_variant(&stream->stream_event_header->p, "v");
+		variant = bt_lookup_variant(&stream->stream_event_header->p, "v");
 		if (variant) {
 			integer_definition = lookup_integer(variant, "id", FALSE);
 			if (integer_definition) {
diff --git a/formats/ctf/types/variant.c b/formats/ctf/types/variant.c
index 297f26f..f3559f5 100644
--- a/formats/ctf/types/variant.c
+++ b/formats/ctf/types/variant.c
@@ -34,5 +34,5 @@ int ctf_variant_rw(struct stream_pos *ppos, struct definition *definition)
 	struct ctf_stream_pos *pos = ctf_pos(ppos);
 
 	ctf_align_pos(pos, declaration->alignment);
-	return variant_rw(ppos, definition);
+	return bt_variant_rw(ppos, definition);
 }
diff --git a/include/babeltrace/types.h b/include/babeltrace/types.h
index 84d0c95..60bd4fd 100644
--- a/include/babeltrace/types.h
+++ b/include/babeltrace/types.h
@@ -479,8 +479,8 @@ int variant_definition_set_tag(struct definition_variant *variant,
  * field returned only valid as long as the variant structure is not appended
  * to.
  */
-struct definition *variant_get_current_field(struct definition_variant *variant);
-int variant_rw(struct stream_pos *pos, struct definition *definition);
+struct definition *bt_variant_get_current_field(struct definition_variant *variant);
+int bt_variant_rw(struct stream_pos *pos, struct definition *definition);
 
 /*
  * elem_declaration passed as parameter now belongs to the array. No
@@ -524,7 +524,7 @@ struct definition_integer *lookup_integer(const struct definition *definition,
 struct definition_enum *bt_lookup_enum(const struct definition *definition,
 				    const char *field_name,
 				    int signedness);
-struct definition *lookup_variant(const struct definition *definition,
+struct definition *bt_lookup_variant(const struct definition *definition,
 				  const char *field_name);
 
 static inline
diff --git a/types/types.c b/types/types.c
index 912c8d5..d60e577 100644
--- a/types/types.c
+++ b/types/types.c
@@ -660,19 +660,19 @@ struct definition_enum *bt_lookup_enum(const struct definition *definition,
 	return lookup_enum;
 }
 
-struct definition *lookup_variant(const struct definition *definition,
+struct definition *bt_lookup_variant(const struct definition *definition,
 				  const char *field_name)
 {
 	struct definition *lookup;
-	struct definition_variant *lookup_variant;
+	struct definition_variant *bt_lookup_variant;
 
 	lookup = lookup_definition(definition, field_name);
 	if (!lookup)
 		return NULL;
 	if (lookup->declaration->id != CTF_TYPE_VARIANT)
 		return NULL;
-	lookup_variant = container_of(lookup, struct definition_variant, p);
-	lookup = variant_get_current_field(lookup_variant);
+	bt_lookup_variant = container_of(lookup, struct definition_variant, p);
+	lookup = bt_variant_get_current_field(bt_lookup_variant);
 	assert(lookup);
 	return lookup;
 }
diff --git a/types/variant.c b/types/variant.c
index ba4179d..837875c 100644
--- a/types/variant.c
+++ b/types/variant.c
@@ -39,13 +39,13 @@ struct definition *_variant_definition_new(struct declaration *declaration,
 static
 void _variant_definition_free(struct definition *definition);
 
-int variant_rw(struct stream_pos *ppos, struct definition *definition)
+int bt_variant_rw(struct stream_pos *ppos, struct definition *definition)
 {
 	struct definition_variant *variant_definition =
 		container_of(definition, struct definition_variant, p);
 	struct definition *field;
 
-	field = variant_get_current_field(variant_definition);
+	field = bt_variant_get_current_field(variant_definition);
 	return generic_rw(ppos, field);
 }
 
@@ -301,7 +301,7 @@ bt_untagged_variant_declaration_get_field_from_tag(struct declaration_untagged_v
 /*
  * field returned only valid as long as the field structure is not appended to.
  */
-struct definition *variant_get_current_field(struct definition_variant *variant)
+struct definition *bt_variant_get_current_field(struct definition_variant *variant)
 {
 	struct definition_enum *_enum =
 		container_of(variant->enum_tag, struct definition_enum, p);
-- 
1.7.10.4
