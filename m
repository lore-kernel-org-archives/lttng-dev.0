From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 09/18] namespace the int functions
Date: Thu, 24 Jan 2013 16:21:41 -0500
Message-ID: <1359062510-7557-9-git-send-email-jdesfossez__20693.2321576916$1359062610$gmane$org@efficios.com>
References: <1359062510-7557-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TyUFP-0008Ey-MM
	for lttng-dev@lists.lttng.org; Thu, 24 Jan 2013 16:22:12 -0500
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
 formats/ctf/ctf.c          |   18 +++++++++---------
 formats/ctf/events.c       |   10 +++++-----
 include/babeltrace/types.h |   14 +++++++-------
 types/integer.c            |   14 +++++++-------
 4 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 6a24087..45ab65e 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -1317,7 +1317,7 @@ int create_stream_packet_index(struct ctf_trace *td,
 				uint64_t magic;
 
 				field = struct_definition_get_field_from_index(file_stream->parent.trace_packet_header, len_index);
-				magic = get_unsigned_int(field);
+				magic = bt_get_unsigned_int(field);
 				if (magic != CTF_MAGIC) {
 					fprintf(stderr, "[error] Invalid magic number 0x%" PRIX64 " at packet %u (file offset %zd).\n",
 							magic,
@@ -1344,7 +1344,7 @@ int create_stream_packet_index(struct ctf_trace *td,
 					struct definition *elem;
 
 					elem = bt_array_index(defarray, i);
-					uuidval[i] = get_unsigned_int(elem);
+					uuidval[i] = bt_get_unsigned_int(elem);
 				}
 				ret = babeltrace_uuid_compare(td->uuid, uuidval);
 				if (ret) {
@@ -1359,7 +1359,7 @@ int create_stream_packet_index(struct ctf_trace *td,
 				struct definition *field;
 
 				field = struct_definition_get_field_from_index(file_stream->parent.trace_packet_header, len_index);
-				stream_id = get_unsigned_int(field);
+				stream_id = bt_get_unsigned_int(field);
 			}
 		}
 
@@ -1396,7 +1396,7 @@ int create_stream_packet_index(struct ctf_trace *td,
 				struct definition *field;
 
 				field = struct_definition_get_field_from_index(file_stream->parent.stream_packet_context, len_index);
-				packet_index.content_size = get_unsigned_int(field);
+				packet_index.content_size = bt_get_unsigned_int(field);
 			} else {
 				/* Use file size for packet size */
 				packet_index.content_size = filestats.st_size * CHAR_BIT;
@@ -1408,7 +1408,7 @@ int create_stream_packet_index(struct ctf_trace *td,
 				struct definition *field;
 
 				field = struct_definition_get_field_from_index(file_stream->parent.stream_packet_context, len_index);
-				packet_index.packet_size = get_unsigned_int(field);
+				packet_index.packet_size = bt_get_unsigned_int(field);
 			} else {
 				/* Use content size if non-zero, else file size */
 				packet_index.packet_size = packet_index.content_size ? : filestats.st_size * CHAR_BIT;
@@ -1420,7 +1420,7 @@ int create_stream_packet_index(struct ctf_trace *td,
 				struct definition *field;
 
 				field = struct_definition_get_field_from_index(file_stream->parent.stream_packet_context, len_index);
-				packet_index.timestamp_begin = get_unsigned_int(field);
+				packet_index.timestamp_begin = bt_get_unsigned_int(field);
 				if (file_stream->parent.stream_class->trace->collection) {
 					packet_index.timestamp_begin =
 						ctf_get_real_timestamp(
@@ -1435,7 +1435,7 @@ int create_stream_packet_index(struct ctf_trace *td,
 				struct definition *field;
 
 				field = struct_definition_get_field_from_index(file_stream->parent.stream_packet_context, len_index);
-				packet_index.timestamp_end = get_unsigned_int(field);
+				packet_index.timestamp_end = bt_get_unsigned_int(field);
 				if (file_stream->parent.stream_class->trace->collection) {
 					packet_index.timestamp_end =
 						ctf_get_real_timestamp(
@@ -1450,8 +1450,8 @@ int create_stream_packet_index(struct ctf_trace *td,
 				struct definition *field;
 
 				field = struct_definition_get_field_from_index(file_stream->parent.stream_packet_context, len_index);
-				packet_index.events_discarded = get_unsigned_int(field);
-				packet_index.events_discarded_len = get_int_len(field);
+				packet_index.events_discarded = bt_get_unsigned_int(field);
+				packet_index.events_discarded_len = bt_get_int_len(field);
 			}
 		} else {
 			/* Use file size for packet size */
diff --git a/formats/ctf/events.c b/formats/ctf/events.c
index 1d1ef6f..372fdd1 100644
--- a/formats/ctf/events.c
+++ b/formats/ctf/events.c
@@ -462,12 +462,12 @@ const char *bt_ctf_get_enum_str(const struct definition *field)
 	}
 	def_enum = container_of(field, const struct definition_enum, p);
 	decl_enum = def_enum->declaration;
-	if (get_int_signedness(&def_enum->integer->p)) {
+	if (bt_get_int_signedness(&def_enum->integer->p)) {
 		array = bt_enum_int_to_quark_set(decl_enum,
-			get_signed_int(&def_enum->integer->p));
+			bt_get_signed_int(&def_enum->integer->p));
 	} else {
 		array = bt_enum_uint_to_quark_set(decl_enum,
-			get_unsigned_int(&def_enum->integer->p));
+			bt_get_unsigned_int(&def_enum->integer->p));
 	}
 	if (!array) {
 		bt_ctf_field_set_error(-ENOENT);
@@ -559,7 +559,7 @@ uint64_t bt_ctf_get_uint64(const struct definition *field)
 	uint64_t ret = 0;
 
 	if (field && bt_ctf_field_type(bt_ctf_get_decl_from_def(field)) == CTF_TYPE_INTEGER)
-		ret = get_unsigned_int(field);
+		ret = bt_get_unsigned_int(field);
 	else
 		bt_ctf_field_set_error(-EINVAL);
 
@@ -571,7 +571,7 @@ int64_t bt_ctf_get_int64(const struct definition *field)
 	int64_t ret = 0;
 
 	if (field && bt_ctf_field_type(bt_ctf_get_decl_from_def(field)) == CTF_TYPE_INTEGER)
-		ret = get_signed_int(field);
+		ret = bt_get_signed_int(field);
 	else
 		bt_ctf_field_set_error(-EINVAL);
 
diff --git a/include/babeltrace/types.h b/include/babeltrace/types.h
index 15bbef3..7b3485d 100644
--- a/include/babeltrace/types.h
+++ b/include/babeltrace/types.h
@@ -374,13 +374,13 @@ struct declaration_integer *integer_declaration_new(size_t len, int byte_order,
 				  int signedness, size_t alignment,
 				  int base, enum ctf_string_encoding encoding,
 				  struct ctf_clock *clock);
-uint64_t get_unsigned_int(const struct definition *field);
-int64_t get_signed_int(const struct definition *field);
-int get_int_signedness(const struct definition *field);
-int get_int_byte_order(const struct definition *field);
-int get_int_base(const struct definition *field);
-size_t get_int_len(const struct definition *field);	/* in bits */
-enum ctf_string_encoding get_int_encoding(const struct definition *field);
+uint64_t bt_get_unsigned_int(const struct definition *field);
+int64_t bt_get_signed_int(const struct definition *field);
+int bt_get_int_signedness(const struct definition *field);
+int bt_get_int_byte_order(const struct definition *field);
+int bt_get_int_base(const struct definition *field);
+size_t bt_get_int_len(const struct definition *field);	/* in bits */
+enum ctf_string_encoding bt_get_int_encoding(const struct definition *field);
 
 /*
  * mantissa_len is the length of the number of bytes represented by the mantissa
diff --git a/types/integer.c b/types/integer.c
index 20e7688..58b6104 100644
--- a/types/integer.c
+++ b/types/integer.c
@@ -115,7 +115,7 @@ void _integer_definition_free(struct definition *definition)
 	g_free(integer);
 }
 
-enum ctf_string_encoding get_int_encoding(const struct definition *field)
+enum ctf_string_encoding bt_get_int_encoding(const struct definition *field)
 {
 	struct definition_integer *integer_definition;
 	const struct declaration_integer *integer_declaration;
@@ -126,7 +126,7 @@ enum ctf_string_encoding get_int_encoding(const struct definition *field)
 	return integer_declaration->encoding;
 }
 
-int get_int_base(const struct definition *field)
+int bt_get_int_base(const struct definition *field)
 {
 	struct definition_integer *integer_definition;
 	const struct declaration_integer *integer_declaration;
@@ -137,7 +137,7 @@ int get_int_base(const struct definition *field)
 	return integer_declaration->base;
 }
 
-size_t get_int_len(const struct definition *field)
+size_t bt_get_int_len(const struct definition *field)
 {
 	struct definition_integer *integer_definition;
 	const struct declaration_integer *integer_declaration;
@@ -148,7 +148,7 @@ size_t get_int_len(const struct definition *field)
 	return integer_declaration->len;
 }
 
-int get_int_byte_order(const struct definition *field)
+int bt_get_int_byte_order(const struct definition *field)
 {
 	struct definition_integer *integer_definition;
 	const struct declaration_integer *integer_declaration;
@@ -159,7 +159,7 @@ int get_int_byte_order(const struct definition *field)
 	return integer_declaration->byte_order;
 }
 
-int get_int_signedness(const struct definition *field)
+int bt_get_int_signedness(const struct definition *field)
 {
 	struct definition_integer *integer_definition;
 	const struct declaration_integer *integer_declaration;
@@ -170,7 +170,7 @@ int get_int_signedness(const struct definition *field)
 	return integer_declaration->signedness;
 }
 
-uint64_t get_unsigned_int(const struct definition *field)
+uint64_t bt_get_unsigned_int(const struct definition *field)
 {
 	struct definition_integer *integer_definition;
 	const struct declaration_integer *integer_declaration;
@@ -186,7 +186,7 @@ uint64_t get_unsigned_int(const struct definition *field)
 	return (uint64_t)integer_definition->value._signed;
 }
 
-int64_t get_signed_int(const struct definition *field)
+int64_t bt_get_signed_int(const struct definition *field)
 {
 	struct definition_integer *integer_definition;
 	const struct declaration_integer *integer_declaration;
-- 
1.7.10.4
