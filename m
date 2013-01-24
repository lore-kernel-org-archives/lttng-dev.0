From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 08/18] namespace the enum functions
Date: Thu, 24 Jan 2013 16:21:40 -0500
Message-ID: <1359062510-7557-8-git-send-email-jdesfossez__844.135453417216$1359062610$gmane$org@efficios.com>
References: <1359062510-7557-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TyUFO-0008Ek-GY
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
 formats/ctf/events.c                               |    4 +--
 .../ctf/metadata/ctf-visitor-generate-io-struct.c  |    6 ++--
 formats/ctf/types/enum.c                           |    4 +--
 include/babeltrace/types.h                         |   14 ++++-----
 types/enum.c                                       |   30 ++++++++++----------
 types/variant.c                                    |    4 +--
 6 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/formats/ctf/events.c b/formats/ctf/events.c
index b530cd5..1d1ef6f 100644
--- a/formats/ctf/events.c
+++ b/formats/ctf/events.c
@@ -463,10 +463,10 @@ const char *bt_ctf_get_enum_str(const struct definition *field)
 	def_enum = container_of(field, const struct definition_enum, p);
 	decl_enum = def_enum->declaration;
 	if (get_int_signedness(&def_enum->integer->p)) {
-		array = enum_int_to_quark_set(decl_enum,
+		array = bt_enum_int_to_quark_set(decl_enum,
 			get_signed_int(&def_enum->integer->p));
 	} else {
-		array = enum_uint_to_quark_set(decl_enum,
+		array = bt_enum_uint_to_quark_set(decl_enum,
 			get_unsigned_int(&def_enum->integer->p));
 	}
 	if (!array) {
diff --git a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
index 9ade8c4..928262f 100644
--- a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
+++ b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
@@ -1007,7 +1007,7 @@ int ctf_enumerator_list_visit(FILE *fd, int depth,
 		if (nr_vals <= 1)
 			end = start;
 		last->u.s = end + 1;
-		enum_signed_insert(enum_declaration, start, end, q);
+		bt_enum_signed_insert(enum_declaration, start, end, q);
 	} else {
 		uint64_t start, end;
 		int nr_vals = 0;
@@ -1047,7 +1047,7 @@ int ctf_enumerator_list_visit(FILE *fd, int depth,
 		if (nr_vals <= 1)
 			end = start;
 		last->u.u = end + 1;
-		enum_unsigned_insert(enum_declaration, start, end, q);
+		bt_enum_unsigned_insert(enum_declaration, start, end, q);
 	}
 	return 0;
 }
@@ -1114,7 +1114,7 @@ struct declaration *ctf_declaration_enum_visit(FILE *fd, int depth,
 			return NULL;
 		}
 		integer_declaration = container_of(declaration, struct declaration_integer, p);
-		enum_declaration = enum_declaration_new(integer_declaration);
+		enum_declaration = bt_enum_declaration_new(integer_declaration);
 		bt_declaration_unref(&integer_declaration->p);	/* leave ref to enum */
 		if (enum_declaration->integer_declaration->signedness) {
 			last_value.u.s = 0;
diff --git a/formats/ctf/types/enum.c b/formats/ctf/types/enum.c
index e4e7ac8..1891175 100644
--- a/formats/ctf/types/enum.c
+++ b/formats/ctf/types/enum.c
@@ -48,14 +48,14 @@ int ctf_enum_read(struct stream_pos *ppos, struct definition *definition)
 	if (ret)
 		return ret;
 	if (!integer_declaration->signedness) {
-		qs = enum_uint_to_quark_set(enum_declaration,
+		qs = bt_enum_uint_to_quark_set(enum_declaration,
 			integer_definition->value._unsigned);
 		if (!qs) {
 			fprintf(stderr, "[warning] Unknown value %" PRIu64 " in enum.\n",
 				integer_definition->value._unsigned);
 		}
 	} else {
-		qs = enum_int_to_quark_set(enum_declaration,
+		qs = bt_enum_int_to_quark_set(enum_declaration,
 			integer_definition->value._signed);
 		if (!qs) {
 			fprintf(stderr, "[warning] Unknown value %" PRId64 " in enum.\n",
diff --git a/include/babeltrace/types.h b/include/babeltrace/types.h
index 1b0cd2b..15bbef3 100644
--- a/include/babeltrace/types.h
+++ b/include/babeltrace/types.h
@@ -399,14 +399,14 @@ struct declaration_float *float_declaration_new(size_t mantissa_len,
  * Returns a GArray of GQuark or NULL.
  * Caller must release the GArray with g_array_unref().
  */
-GArray *enum_uint_to_quark_set(const struct declaration_enum *enum_declaration,
+GArray *bt_enum_uint_to_quark_set(const struct declaration_enum *enum_declaration,
 			       uint64_t v);
 
 /*
  * Returns a GArray of GQuark or NULL.
  * Caller must release the GArray with g_array_unref().
  */
-GArray *enum_int_to_quark_set(const struct declaration_enum *enum_declaration,
+GArray *bt_enum_int_to_quark_set(const struct declaration_enum *enum_declaration,
 			      int64_t v);
 
 /*
@@ -414,16 +414,16 @@ GArray *enum_int_to_quark_set(const struct declaration_enum *enum_declaration,
  * Callers do _not_ own the returned GArray (and therefore _don't_ need to
  * release it).
  */
-GArray *enum_quark_to_range_set(const struct declaration_enum *enum_declaration,
+GArray *bt_enum_quark_to_range_set(const struct declaration_enum *enum_declaration,
 				GQuark q);
-void enum_signed_insert(struct declaration_enum *enum_declaration,
+void bt_enum_signed_insert(struct declaration_enum *enum_declaration,
                         int64_t start, int64_t end, GQuark q);
-void enum_unsigned_insert(struct declaration_enum *enum_declaration,
+void bt_enum_unsigned_insert(struct declaration_enum *enum_declaration,
 			  uint64_t start, uint64_t end, GQuark q);
-size_t enum_get_nr_enumerators(struct declaration_enum *enum_declaration);
+size_t bt_enum_get_nr_enumerators(struct declaration_enum *enum_declaration);
 
 struct declaration_enum *
-	enum_declaration_new(struct declaration_integer *integer_declaration);
+	bt_enum_declaration_new(struct declaration_integer *integer_declaration);
 
 struct declaration_string *
 	string_declaration_new(enum ctf_string_encoding encoding);
diff --git a/types/enum.c b/types/enum.c
index 43df4eb..6d33713 100644
--- a/types/enum.c
+++ b/types/enum.c
@@ -124,7 +124,7 @@ void enum_val_free(void *ptr)
  * Returns a GArray or NULL.
  * Caller must release the GArray with g_array_unref().
  */
-GArray *enum_uint_to_quark_set(const struct declaration_enum *enum_declaration,
+GArray *bt_enum_uint_to_quark_set(const struct declaration_enum *enum_declaration,
 			       uint64_t v)
 {
 	struct enum_range_to_quark *iter;
@@ -171,7 +171,7 @@ GArray *enum_uint_to_quark_set(const struct declaration_enum *enum_declaration,
  * Returns a GArray or NULL.
  * Caller must release the GArray with g_array_unref().
  */
-GArray *enum_int_to_quark_set(const struct declaration_enum *enum_declaration,
+GArray *bt_enum_int_to_quark_set(const struct declaration_enum *enum_declaration,
 			      int64_t v)
 {
 	struct enum_range_to_quark *iter;
@@ -215,7 +215,7 @@ GArray *enum_int_to_quark_set(const struct declaration_enum *enum_declaration,
 }
 
 static
-void enum_unsigned_insert_value_to_quark_set(struct declaration_enum *enum_declaration,
+void bt_enum_unsigned_insert_value_to_quark_set(struct declaration_enum *enum_declaration,
 			 uint64_t v, GQuark q)
 {
 	uint64_t *valuep;
@@ -241,7 +241,7 @@ void enum_unsigned_insert_value_to_quark_set(struct declaration_enum *enum_decla
 }
 
 static
-void enum_signed_insert_value_to_quark_set(struct declaration_enum *enum_declaration,
+void bt_enum_signed_insert_value_to_quark_set(struct declaration_enum *enum_declaration,
 			int64_t v, GQuark q)
 {
 	int64_t *valuep;
@@ -266,7 +266,7 @@ void enum_signed_insert_value_to_quark_set(struct declaration_enum *enum_declara
 	}
 }
 
-GArray *enum_quark_to_range_set(const struct declaration_enum *enum_declaration,
+GArray *bt_enum_quark_to_range_set(const struct declaration_enum *enum_declaration,
 				GQuark q)
 {
 	return g_hash_table_lookup(enum_declaration->table.quark_to_range_set,
@@ -274,7 +274,7 @@ GArray *enum_quark_to_range_set(const struct declaration_enum *enum_declaration,
 }
 
 static
-void enum_signed_insert_range_to_quark(struct declaration_enum *enum_declaration,
+void bt_enum_signed_insert_range_to_quark(struct declaration_enum *enum_declaration,
                         int64_t start, int64_t end, GQuark q)
 {
 	struct enum_range_to_quark *rtoq;
@@ -287,7 +287,7 @@ void enum_signed_insert_range_to_quark(struct declaration_enum *enum_declaration
 }
 
 static
-void enum_unsigned_insert_range_to_quark(struct declaration_enum *enum_declaration,
+void bt_enum_unsigned_insert_range_to_quark(struct declaration_enum *enum_declaration,
                         uint64_t start, uint64_t end, GQuark q)
 {
 	struct enum_range_to_quark *rtoq;
@@ -299,14 +299,14 @@ void enum_unsigned_insert_range_to_quark(struct declaration_enum *enum_declarati
 	rtoq->quark = q;
 }
 
-void enum_signed_insert(struct declaration_enum *enum_declaration,
+void bt_enum_signed_insert(struct declaration_enum *enum_declaration,
                         int64_t start, int64_t end, GQuark q)
 {
 	GArray *array;
 	struct enum_range *range;
 
 	if (start == end) {
-		enum_signed_insert_value_to_quark_set(enum_declaration, start, q);
+		bt_enum_signed_insert_value_to_quark_set(enum_declaration, start, q);
 	} else {
 		if (start > end) {
 			uint64_t tmp;
@@ -315,7 +315,7 @@ void enum_signed_insert(struct declaration_enum *enum_declaration,
 			start = end;
 			end = tmp;
 		}
-		enum_signed_insert_range_to_quark(enum_declaration, start, end, q);
+		bt_enum_signed_insert_range_to_quark(enum_declaration, start, end, q);
 	}
 
 	array = g_hash_table_lookup(enum_declaration->table.quark_to_range_set,
@@ -333,7 +333,7 @@ void enum_signed_insert(struct declaration_enum *enum_declaration,
 	range->end._signed = end;
 }
 
-void enum_unsigned_insert(struct declaration_enum *enum_declaration,
+void bt_enum_unsigned_insert(struct declaration_enum *enum_declaration,
 			  uint64_t start, uint64_t end, GQuark q)
 {
 	GArray *array;
@@ -341,7 +341,7 @@ void enum_unsigned_insert(struct declaration_enum *enum_declaration,
 
 
 	if (start == end) {
-		enum_unsigned_insert_value_to_quark_set(enum_declaration, start, q);
+		bt_enum_unsigned_insert_value_to_quark_set(enum_declaration, start, q);
 	} else {
 		if (start > end) {
 			uint64_t tmp;
@@ -350,7 +350,7 @@ void enum_unsigned_insert(struct declaration_enum *enum_declaration,
 			start = end;
 			end = tmp;
 		}
-		enum_unsigned_insert_range_to_quark(enum_declaration, start, end, q);
+		bt_enum_unsigned_insert_range_to_quark(enum_declaration, start, end, q);
 	}
 
 	array = g_hash_table_lookup(enum_declaration->table.quark_to_range_set,
@@ -368,7 +368,7 @@ void enum_unsigned_insert(struct declaration_enum *enum_declaration,
 	range->end._unsigned = end;
 }
 
-size_t enum_get_nr_enumerators(struct declaration_enum *enum_declaration)
+size_t bt_enum_get_nr_enumerators(struct declaration_enum *enum_declaration)
 {
 	return g_hash_table_size(enum_declaration->table.quark_to_range_set);
 }
@@ -391,7 +391,7 @@ void _enum_declaration_free(struct declaration *declaration)
 }
 
 struct declaration_enum *
-	enum_declaration_new(struct declaration_integer *integer_declaration)
+	bt_enum_declaration_new(struct declaration_integer *integer_declaration)
 {
 	struct declaration_enum *enum_declaration;
 
diff --git a/types/variant.c b/types/variant.c
index a58c17f..47c821e 100644
--- a/types/variant.c
+++ b/types/variant.c
@@ -144,14 +144,14 @@ int check_enum_tag(struct definition_variant *variant,
 	 * variant choice map to an enumerator too. We then validate that the
 	 * number of enumerators equals the number of variant choices.
 	 */
-	if (variant->declaration->untagged_variant->fields->len != enum_get_nr_enumerators(enum_declaration))
+	if (variant->declaration->untagged_variant->fields->len != bt_enum_get_nr_enumerators(enum_declaration))
 		return -EPERM;
 
 	for (i = 0; i < variant->declaration->untagged_variant->fields->len; i++) {
 		struct declaration_field *field_declaration =
 			&g_array_index(variant->declaration->untagged_variant->fields,
 				       struct declaration_field, i);
-		if (!enum_quark_to_range_set(enum_declaration, field_declaration->name)) {
+		if (!bt_enum_quark_to_range_set(enum_declaration, field_declaration->name)) {
 			missing_field = 1;
 			break;
 		}
-- 
1.7.10.4
