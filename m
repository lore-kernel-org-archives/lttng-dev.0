From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 2/7] Namespace struct stream_pos
Date: Fri, 15 Feb 2013 12:22:51 -0500
Message-ID: <1360948976-14999-2-git-send-email-jdesfossez__11564.4785263159$1360949041$gmane$org@efficios.com>
References: <1360948976-14999-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1U6P0A-0003vv-4Z
	for lttng-dev@lists.lttng.org; Fri, 15 Feb 2013 12:23:10 -0500
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

This struct is exposed by the API, so we need to namespace it.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 converter/babeltrace.c              |    2 +-
 formats/bt-dummy/bt-dummy.c         |    4 ++--
 formats/ctf-text/ctf-text.c         |    6 +++---
 formats/ctf-text/types/array.c      |    2 +-
 formats/ctf-text/types/enum.c       |    2 +-
 formats/ctf-text/types/float.c      |    2 +-
 formats/ctf-text/types/integer.c    |    2 +-
 formats/ctf-text/types/sequence.c   |    2 +-
 formats/ctf-text/types/string.c     |    2 +-
 formats/ctf-text/types/struct.c     |    2 +-
 formats/ctf-text/types/variant.c    |    2 +-
 formats/ctf/ctf.c                   |   24 +++++++++++------------
 formats/ctf/types/array.c           |    4 ++--
 formats/ctf/types/enum.c            |    4 ++--
 formats/ctf/types/float.c           |    8 ++++----
 formats/ctf/types/integer.c         |    8 ++++----
 formats/ctf/types/sequence.c        |    4 ++--
 formats/ctf/types/string.c          |    4 ++--
 formats/ctf/types/struct.c          |    2 +-
 formats/ctf/types/variant.c         |    2 +-
 include/babeltrace/context.h        |    4 ++--
 include/babeltrace/ctf-text/types.h |   22 ++++++++++-----------
 include/babeltrace/ctf/types.h      |   36 +++++++++++++++++------------------
 include/babeltrace/format.h         |    6 +++---
 include/babeltrace/types.h          |   18 +++++++++---------
 lib/context.c                       |    2 +-
 types/array.c                       |    2 +-
 types/sequence.c                    |    2 +-
 types/struct.c                      |    2 +-
 types/variant.c                     |    2 +-
 30 files changed, 92 insertions(+), 92 deletions(-)

diff --git a/converter/babeltrace.c b/converter/babeltrace.c
index 31e3d6e..b1f32c9 100644
--- a/converter/babeltrace.c
+++ b/converter/babeltrace.c
@@ -461,7 +461,7 @@ static int traverse_trace_dir(const char *fpath, const struct stat *sb,
  */
 int bt_context_add_traces_recursive(struct bt_context *ctx, const char *path,
 		const char *format_str,
-		void (*packet_seek)(struct stream_pos *pos,
+		void (*packet_seek)(struct bt_stream_pos *pos,
 			size_t offset, int whence))
 {
 
diff --git a/formats/bt-dummy/bt-dummy.c b/formats/bt-dummy/bt-dummy.c
index b55dd69..537e6bb 100644
--- a/formats/bt-dummy/bt-dummy.c
+++ b/formats/bt-dummy/bt-dummy.c
@@ -39,14 +39,14 @@
 #include <stdlib.h>
 
 static
-int bt_dummy_write_event(struct stream_pos *ppos, struct ctf_stream_definition *stream)
+int bt_dummy_write_event(struct bt_stream_pos *ppos, struct ctf_stream_definition *stream)
 {
 	return 0;
 }
 
 static
 struct trace_descriptor *bt_dummy_open_trace(const char *path, int flags,
-		void (*packet_seek)(struct stream_pos *pos, size_t index,
+		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence), FILE *metadata_fp)
 {
 	struct ctf_text_stream_pos *pos;
diff --git a/formats/ctf-text/ctf-text.c b/formats/ctf-text/ctf-text.c
index d344c1c..1f798b2 100644
--- a/formats/ctf-text/ctf-text.c
+++ b/formats/ctf-text/ctf-text.c
@@ -88,7 +88,7 @@ enum bt_loglevel {
 
 static
 struct trace_descriptor *ctf_text_open_trace(const char *path, int flags,
-		void (*packet_seek)(struct stream_pos *pos, size_t index,
+		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence), FILE *metadata_fp);
 static
 int ctf_text_close_trace(struct trace_descriptor *descriptor);
@@ -232,7 +232,7 @@ const char *print_loglevel(int value)
 }
 
 static
-int ctf_text_write_event(struct stream_pos *ppos, struct ctf_stream_definition *stream)
+int ctf_text_write_event(struct bt_stream_pos *ppos, struct ctf_stream_definition *stream)
 			 
 {
 	struct ctf_text_stream_pos *pos =
@@ -556,7 +556,7 @@ error:
 
 static
 struct trace_descriptor *ctf_text_open_trace(const char *path, int flags,
-		void (*packet_seek)(struct stream_pos *pos, size_t index,
+		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence), FILE *metadata_fp)
 {
 	struct ctf_text_stream_pos *pos;
diff --git a/formats/ctf-text/types/array.c b/formats/ctf-text/types/array.c
index e2ed7b3..9e7d49f 100644
--- a/formats/ctf-text/types/array.c
+++ b/formats/ctf-text/types/array.c
@@ -29,7 +29,7 @@
 #include <babeltrace/ctf-text/types.h>
 #include <stdio.h>
 
-int ctf_text_array_write(struct stream_pos *ppos, struct definition *definition)
+int ctf_text_array_write(struct bt_stream_pos *ppos, struct definition *definition)
 {
 	struct ctf_text_stream_pos *pos = ctf_text_pos(ppos);
 	struct definition_array *array_definition =
diff --git a/formats/ctf-text/types/enum.c b/formats/ctf-text/types/enum.c
index 9df8da8..8a2463b 100644
--- a/formats/ctf-text/types/enum.c
+++ b/formats/ctf-text/types/enum.c
@@ -30,7 +30,7 @@
 #include <stdio.h>
 #include <stdint.h>
 
-int ctf_text_enum_write(struct stream_pos *ppos, struct definition *definition)
+int ctf_text_enum_write(struct bt_stream_pos *ppos, struct definition *definition)
 {
 	struct definition_enum *enum_definition =
 		container_of(definition, struct definition_enum, p);
diff --git a/formats/ctf-text/types/float.c b/formats/ctf-text/types/float.c
index 199b013..a925480 100644
--- a/formats/ctf-text/types/float.c
+++ b/formats/ctf-text/types/float.c
@@ -31,7 +31,7 @@
 #include <babeltrace/ctf-text/types.h>
 #include <stdio.h>
 
-int ctf_text_float_write(struct stream_pos *ppos, struct definition *definition)
+int ctf_text_float_write(struct bt_stream_pos *ppos, struct definition *definition)
 {
 	struct definition_float *float_definition =
 		container_of(definition, struct definition_float, p);
diff --git a/formats/ctf-text/types/integer.c b/formats/ctf-text/types/integer.c
index 0886b06..3a469f6 100644
--- a/formats/ctf-text/types/integer.c
+++ b/formats/ctf-text/types/integer.c
@@ -32,7 +32,7 @@
 #include <stdint.h>
 #include <babeltrace/bitfield.h>
 
-int ctf_text_integer_write(struct stream_pos *ppos, struct definition *definition)
+int ctf_text_integer_write(struct bt_stream_pos *ppos, struct definition *definition)
 {
 	struct definition_integer *integer_definition =
 		container_of(definition, struct definition_integer, p);
diff --git a/formats/ctf-text/types/sequence.c b/formats/ctf-text/types/sequence.c
index 12574ee..61be860 100644
--- a/formats/ctf-text/types/sequence.c
+++ b/formats/ctf-text/types/sequence.c
@@ -29,7 +29,7 @@
 #include <babeltrace/ctf-text/types.h>
 #include <stdio.h>
 
-int ctf_text_sequence_write(struct stream_pos *ppos, struct definition *definition)
+int ctf_text_sequence_write(struct bt_stream_pos *ppos, struct definition *definition)
 {
 	struct ctf_text_stream_pos *pos = ctf_text_pos(ppos);
 	struct definition_sequence *sequence_definition =
diff --git a/formats/ctf-text/types/string.c b/formats/ctf-text/types/string.c
index 44aeb40..f49d1b7 100644
--- a/formats/ctf-text/types/string.c
+++ b/formats/ctf-text/types/string.c
@@ -31,7 +31,7 @@
 #include <limits.h>		/* C99 limits */
 #include <string.h>
 
-int ctf_text_string_write(struct stream_pos *ppos,
+int ctf_text_string_write(struct bt_stream_pos *ppos,
 			  struct definition *definition)
 {
 	struct definition_string *string_definition =
diff --git a/formats/ctf-text/types/struct.c b/formats/ctf-text/types/struct.c
index e9365af..a727a89 100644
--- a/formats/ctf-text/types/struct.c
+++ b/formats/ctf-text/types/struct.c
@@ -29,7 +29,7 @@
 #include <babeltrace/ctf-text/types.h>
 #include <stdio.h>
 
-int ctf_text_struct_write(struct stream_pos *ppos, struct definition *definition)
+int ctf_text_struct_write(struct bt_stream_pos *ppos, struct definition *definition)
 {
 	struct declaration *declaration = definition->declaration;
 	struct declaration_struct *struct_declaration =
diff --git a/formats/ctf-text/types/variant.c b/formats/ctf-text/types/variant.c
index e7e50ac..ca7c1ae 100644
--- a/formats/ctf-text/types/variant.c
+++ b/formats/ctf-text/types/variant.c
@@ -29,7 +29,7 @@
 #include <babeltrace/ctf-text/types.h>
 #include <stdio.h>
 
-int ctf_text_variant_write(struct stream_pos *ppos, struct definition *definition)
+int ctf_text_variant_write(struct bt_stream_pos *ppos, struct definition *definition)
 {
 	struct ctf_text_stream_pos *pos = ctf_text_pos(ppos);
 	int field_nr_saved;
diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 552133c..c6b148c 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -77,13 +77,13 @@ extern int yydebug;
 
 static
 struct trace_descriptor *ctf_open_trace(const char *path, int flags,
-		void (*packet_seek)(struct stream_pos *pos, size_t index,
+		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence),
 		FILE *metadata_fp);
 static
 struct trace_descriptor *ctf_open_mmap_trace(
 		struct mmap_stream_list *mmap_list,
-		void (*packet_seek)(struct stream_pos *pos, size_t index,
+		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence),
 		FILE *metadata_fp);
 static
@@ -392,7 +392,7 @@ void ctf_print_timestamp(FILE *fp,
 }
 
 static
-int ctf_read_event(struct stream_pos *ppos, struct ctf_stream_definition *stream)
+int ctf_read_event(struct bt_stream_pos *ppos, struct ctf_stream_definition *stream)
 {
 	struct ctf_stream_pos *pos =
 		container_of(ppos, struct ctf_stream_pos, parent);
@@ -504,7 +504,7 @@ error:
 }
 
 static
-int ctf_write_event(struct stream_pos *pos, struct ctf_stream_definition *stream)
+int ctf_write_event(struct bt_stream_pos *pos, struct ctf_stream_definition *stream)
 {
 	struct ctf_stream_declaration *stream_class = stream->stream_class;
 	struct ctf_event_definition *event;
@@ -617,7 +617,7 @@ int ctf_fini_pos(struct ctf_stream_pos *pos)
  * for SEEK_CUR: go to next packet.
  * for SEEK_POS: go to packet numer (index).
  */
-void ctf_packet_seek(struct stream_pos *stream_pos, size_t index, int whence)
+void ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
 {
 	struct ctf_stream_pos *pos =
 		container_of(stream_pos, struct ctf_stream_pos, parent);
@@ -1018,7 +1018,7 @@ int ctf_open_trace_metadata_stream_read(struct ctf_trace *td, FILE **fp,
 
 static
 int ctf_open_trace_metadata_read(struct ctf_trace *td,
-		void (*packet_seek)(struct stream_pos *pos, size_t index,
+		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence), FILE *metadata_fp)
 {
 	struct ctf_scanner *scanner;
@@ -1523,7 +1523,7 @@ error:
  */
 static
 int ctf_open_file_stream_read(struct ctf_trace *td, const char *path, int flags,
-		void (*packet_seek)(struct stream_pos *pos, size_t index,
+		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence))
 {
 	int ret, fd, closeret;
@@ -1600,7 +1600,7 @@ error:
 static
 int ctf_open_trace_read(struct ctf_trace *td,
 		const char *path, int flags,
-		void (*packet_seek)(struct stream_pos *pos, size_t index,
+		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence), FILE *metadata_fp)
 {
 	int ret, closeret;
@@ -1696,7 +1696,7 @@ error:
  */
 static
 struct trace_descriptor *ctf_open_trace(const char *path, int flags,
-		void (*packet_seek)(struct stream_pos *pos, size_t index,
+		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence), FILE *metadata_fp)
 {
 	struct ctf_trace *td;
@@ -1786,7 +1786,7 @@ end:
 static
 int ctf_open_mmap_stream_read(struct ctf_trace *td,
 		struct mmap_stream *mmap_info,
-		void (*packet_seek)(struct stream_pos *pos, size_t index,
+		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence))
 {
 	int ret;
@@ -1828,7 +1828,7 @@ error_def:
 static
 int ctf_open_mmap_trace_read(struct ctf_trace *td,
 		struct mmap_stream_list *mmap_list,
-		void (*packet_seek)(struct stream_pos *pos, size_t index,
+		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence),
 		FILE *metadata_fp)
 {
@@ -1861,7 +1861,7 @@ error:
 static
 struct trace_descriptor *ctf_open_mmap_trace(
 		struct mmap_stream_list *mmap_list,
-		void (*packet_seek)(struct stream_pos *pos, size_t index,
+		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence),
 		FILE *metadata_fp)
 {
diff --git a/formats/ctf/types/array.c b/formats/ctf/types/array.c
index 006f0ce..b1cbe2f 100644
--- a/formats/ctf/types/array.c
+++ b/formats/ctf/types/array.c
@@ -28,7 +28,7 @@
 
 #include <babeltrace/ctf/types.h>
 
-int ctf_array_read(struct stream_pos *ppos, struct definition *definition)
+int ctf_array_read(struct bt_stream_pos *ppos, struct definition *definition)
 {
 	struct definition_array *array_definition =
 		container_of(definition, struct definition_array, p);
@@ -64,7 +64,7 @@ int ctf_array_read(struct stream_pos *ppos, struct definition *definition)
 	return bt_array_rw(ppos, definition);
 }
 
-int ctf_array_write(struct stream_pos *ppos, struct definition *definition)
+int ctf_array_write(struct bt_stream_pos *ppos, struct definition *definition)
 {
 	struct definition_array *array_definition =
 		container_of(definition, struct definition_array, p);
diff --git a/formats/ctf/types/enum.c b/formats/ctf/types/enum.c
index 1891175..9371b27 100644
--- a/formats/ctf/types/enum.c
+++ b/formats/ctf/types/enum.c
@@ -31,7 +31,7 @@
 #include <stdint.h>
 #include <glib.h>
 
-int ctf_enum_read(struct stream_pos *ppos, struct definition *definition)
+int ctf_enum_read(struct bt_stream_pos *ppos, struct definition *definition)
 {
 	struct definition_enum *enum_definition =
 		container_of(definition, struct definition_enum, p);
@@ -69,7 +69,7 @@ int ctf_enum_read(struct stream_pos *ppos, struct definition *definition)
 	return 0;
 }
 
-int ctf_enum_write(struct stream_pos *pos, struct definition *definition)
+int ctf_enum_write(struct bt_stream_pos *pos, struct definition *definition)
 {
 	struct definition_enum *enum_definition =
 		container_of(definition, struct definition_enum, p);
diff --git a/formats/ctf/types/float.c b/formats/ctf/types/float.c
index 2dfef86..f46e26a 100644
--- a/formats/ctf/types/float.c
+++ b/formats/ctf/types/float.c
@@ -96,9 +96,9 @@ static void float_unlock(void)
 	assert(!ret);
 }
 
-static int _ctf_float_copy(struct stream_pos *destp,
+static int _ctf_float_copy(struct bt_stream_pos *destp,
 		    struct definition_float *dest_definition,
-		    struct stream_pos *srcp,
+		    struct bt_stream_pos *srcp,
 		    const struct definition_float *src_definition)
 {
 	int ret;
@@ -165,7 +165,7 @@ static int _ctf_float_copy(struct stream_pos *destp,
 	return 0;
 }
 
-int ctf_float_read(struct stream_pos *ppos, struct definition *definition)
+int ctf_float_read(struct bt_stream_pos *ppos, struct definition *definition)
 {
 	struct definition_float *float_definition =
 		container_of(definition, struct definition_float, p);
@@ -222,7 +222,7 @@ end:
 	return ret;
 }
 
-int ctf_float_write(struct stream_pos *ppos, struct definition *definition)
+int ctf_float_write(struct bt_stream_pos *ppos, struct definition *definition)
 {
 	struct definition_float *float_definition =
 		container_of(definition, struct definition_float, p);
diff --git a/formats/ctf/types/integer.c b/formats/ctf/types/integer.c
index 66036ae..1267925 100644
--- a/formats/ctf/types/integer.c
+++ b/formats/ctf/types/integer.c
@@ -39,7 +39,7 @@
  */
 
 static
-int _aligned_integer_read(struct stream_pos *ppos,
+int _aligned_integer_read(struct bt_stream_pos *ppos,
 			  struct definition *definition)
 {
 	struct definition_integer *integer_definition =
@@ -141,7 +141,7 @@ int _aligned_integer_read(struct stream_pos *ppos,
 }
 
 static
-int _aligned_integer_write(struct stream_pos *ppos,
+int _aligned_integer_write(struct bt_stream_pos *ppos,
 			    struct definition *definition)
 {
 	struct definition_integer *integer_definition =
@@ -211,7 +211,7 @@ end:
 	return 0;
 }
 
-int ctf_integer_read(struct stream_pos *ppos, struct definition *definition)
+int ctf_integer_read(struct bt_stream_pos *ppos, struct definition *definition)
 {
 	struct definition_integer *integer_definition =
 		container_of(definition, struct definition_integer, p);
@@ -256,7 +256,7 @@ int ctf_integer_read(struct stream_pos *ppos, struct definition *definition)
 	return 0;
 }
 
-int ctf_integer_write(struct stream_pos *ppos, struct definition *definition)
+int ctf_integer_write(struct bt_stream_pos *ppos, struct definition *definition)
 {
 	struct definition_integer *integer_definition =
 		container_of(definition, struct definition_integer, p);
diff --git a/formats/ctf/types/sequence.c b/formats/ctf/types/sequence.c
index 2ff31b7..b2221ea 100644
--- a/formats/ctf/types/sequence.c
+++ b/formats/ctf/types/sequence.c
@@ -28,7 +28,7 @@
 
 #include <babeltrace/ctf/types.h>
 
-int ctf_sequence_read(struct stream_pos *ppos, struct definition *definition)
+int ctf_sequence_read(struct bt_stream_pos *ppos, struct definition *definition)
 {
 	struct definition_sequence *sequence_definition =
 		container_of(definition, struct definition_sequence, p);
@@ -63,7 +63,7 @@ int ctf_sequence_read(struct stream_pos *ppos, struct definition *definition)
 	return bt_sequence_rw(ppos, definition);
 }
 
-int ctf_sequence_write(struct stream_pos *ppos, struct definition *definition)
+int ctf_sequence_write(struct bt_stream_pos *ppos, struct definition *definition)
 {
 	struct definition_sequence *sequence_definition =
 		container_of(definition, struct definition_sequence, p);
diff --git a/formats/ctf/types/string.c b/formats/ctf/types/string.c
index 357e273..5771733 100644
--- a/formats/ctf/types/string.c
+++ b/formats/ctf/types/string.c
@@ -31,7 +31,7 @@
 #include <limits.h>		/* C99 limits */
 #include <string.h>
 
-int ctf_string_read(struct stream_pos *ppos, struct definition *definition)
+int ctf_string_read(struct bt_stream_pos *ppos, struct definition *definition)
 {
 	struct definition_string *string_definition =
 		container_of(definition, struct definition_string, p);
@@ -68,7 +68,7 @@ int ctf_string_read(struct stream_pos *ppos, struct definition *definition)
 	return 0;
 }
 
-int ctf_string_write(struct stream_pos *ppos,
+int ctf_string_write(struct bt_stream_pos *ppos,
 		      struct definition *definition)
 {
 	struct definition_string *string_definition =
diff --git a/formats/ctf/types/struct.c b/formats/ctf/types/struct.c
index b0d9e4a..7c1562b 100644
--- a/formats/ctf/types/struct.c
+++ b/formats/ctf/types/struct.c
@@ -28,7 +28,7 @@
 
 #include <babeltrace/ctf/types.h>
 
-int ctf_struct_rw(struct stream_pos *ppos, struct definition *definition)
+int ctf_struct_rw(struct bt_stream_pos *ppos, struct definition *definition)
 {
 	struct declaration *declaration = definition->declaration;
 	struct ctf_stream_pos *pos = ctf_pos(ppos);
diff --git a/formats/ctf/types/variant.c b/formats/ctf/types/variant.c
index f3559f5..3c0c371 100644
--- a/formats/ctf/types/variant.c
+++ b/formats/ctf/types/variant.c
@@ -28,7 +28,7 @@
 
 #include <babeltrace/ctf/types.h>
 
-int ctf_variant_rw(struct stream_pos *ppos, struct definition *definition)
+int ctf_variant_rw(struct bt_stream_pos *ppos, struct definition *definition)
 {
 	struct declaration *declaration = definition->declaration;
 	struct ctf_stream_pos *pos = ctf_pos(ppos);
diff --git a/include/babeltrace/context.h b/include/babeltrace/context.h
index f29ccf0..f3763e1 100644
--- a/include/babeltrace/context.h
+++ b/include/babeltrace/context.h
@@ -40,7 +40,7 @@ extern "C" {
 
 /* struct bt_context is opaque to the user */
 struct bt_context;
-struct stream_pos;
+struct bt_stream_pos;
 struct bt_ctf_event;
 
 /*
@@ -82,7 +82,7 @@ struct bt_context *bt_context_create(void);
  */
 int bt_context_add_trace(struct bt_context *ctx, const char *path,
 		const char *format,
-		void (*packet_seek)(struct stream_pos *pos,
+		void (*packet_seek)(struct bt_stream_pos *pos,
 			size_t index, int whence),
 		struct mmap_stream_list *stream_list,
 		FILE *metadata);
diff --git a/include/babeltrace/ctf-text/types.h b/include/babeltrace/ctf-text/types.h
index debecfe..8681f39 100644
--- a/include/babeltrace/ctf-text/types.h
+++ b/include/babeltrace/ctf-text/types.h
@@ -37,10 +37,10 @@
 #include <babeltrace/format.h>
 
 /*
- * Inherit from both struct stream_pos and struct trace_descriptor.
+ * Inherit from both struct bt_stream_pos and struct trace_descriptor.
  */
 struct ctf_text_stream_pos {
-	struct stream_pos parent;
+	struct bt_stream_pos parent;
 	struct trace_descriptor trace_descriptor;
 	FILE *fp;		/* File pointer. NULL if unset. */
 	int depth;
@@ -53,7 +53,7 @@ struct ctf_text_stream_pos {
 };
 
 static inline
-struct ctf_text_stream_pos *ctf_text_pos(struct stream_pos *pos)
+struct ctf_text_stream_pos *ctf_text_pos(struct bt_stream_pos *pos)
 {
 	return container_of(pos, struct ctf_text_stream_pos, parent);
 }
@@ -62,21 +62,21 @@ struct ctf_text_stream_pos *ctf_text_pos(struct stream_pos *pos)
  * Write only is supported for now.
  */
 BT_HIDDEN
-int ctf_text_integer_write(struct stream_pos *pos, struct definition *definition);
+int ctf_text_integer_write(struct bt_stream_pos *pos, struct definition *definition);
 BT_HIDDEN
-int ctf_text_float_write(struct stream_pos *pos, struct definition *definition);
+int ctf_text_float_write(struct bt_stream_pos *pos, struct definition *definition);
 BT_HIDDEN
-int ctf_text_string_write(struct stream_pos *pos, struct definition *definition);
+int ctf_text_string_write(struct bt_stream_pos *pos, struct definition *definition);
 BT_HIDDEN
-int ctf_text_enum_write(struct stream_pos *pos, struct definition *definition);
+int ctf_text_enum_write(struct bt_stream_pos *pos, struct definition *definition);
 BT_HIDDEN
-int ctf_text_struct_write(struct stream_pos *pos, struct definition *definition);
+int ctf_text_struct_write(struct bt_stream_pos *pos, struct definition *definition);
 BT_HIDDEN
-int ctf_text_variant_write(struct stream_pos *pos, struct definition *definition);
+int ctf_text_variant_write(struct bt_stream_pos *pos, struct definition *definition);
 BT_HIDDEN
-int ctf_text_array_write(struct stream_pos *pos, struct definition *definition);
+int ctf_text_array_write(struct bt_stream_pos *pos, struct definition *definition);
 BT_HIDDEN
-int ctf_text_sequence_write(struct stream_pos *pos, struct definition *definition);
+int ctf_text_sequence_write(struct bt_stream_pos *pos, struct definition *definition);
 
 static inline
 void print_pos_tabs(struct ctf_text_stream_pos *pos)
diff --git a/include/babeltrace/ctf/types.h b/include/babeltrace/ctf/types.h
index 8bd0102..f7b93d3 100644
--- a/include/babeltrace/ctf/types.h
+++ b/include/babeltrace/ctf/types.h
@@ -59,7 +59,7 @@ struct packet_index {
  * Always update ctf_stream_pos with ctf_move_pos and ctf_init_pos.
  */
 struct ctf_stream_pos {
-	struct stream_pos parent;
+	struct bt_stream_pos parent;
 	int fd;			/* backing file fd. -1 if unset. */
 	GArray *packet_cycles_index;	/* contains struct packet_index in cycles */
 	GArray *packet_real_index;	/* contains struct packet_index in ns */
@@ -77,7 +77,7 @@ struct ctf_stream_pos {
 	int64_t last_offset;	/* offset before the last read_event */
 	uint64_t cur_index;	/* current index in packet index */
 	uint64_t last_events_discarded;	/* last known amount of event discarded */
-	void (*packet_seek)(struct stream_pos *pos, size_t index,
+	void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence); /* function called to switch packet */
 
 	int dummy;		/* dummy position, for length calculation */
@@ -85,41 +85,41 @@ struct ctf_stream_pos {
 };
 
 static inline
-struct ctf_stream_pos *ctf_pos(struct stream_pos *pos)
+struct ctf_stream_pos *ctf_pos(struct bt_stream_pos *pos)
 {
 	return container_of(pos, struct ctf_stream_pos, parent);
 }
 
 BT_HIDDEN
-int ctf_integer_read(struct stream_pos *pos, struct definition *definition);
+int ctf_integer_read(struct bt_stream_pos *pos, struct definition *definition);
 BT_HIDDEN
-int ctf_integer_write(struct stream_pos *pos, struct definition *definition);
+int ctf_integer_write(struct bt_stream_pos *pos, struct definition *definition);
 BT_HIDDEN
-int ctf_float_read(struct stream_pos *pos, struct definition *definition);
+int ctf_float_read(struct bt_stream_pos *pos, struct definition *definition);
 BT_HIDDEN
-int ctf_float_write(struct stream_pos *pos, struct definition *definition);
+int ctf_float_write(struct bt_stream_pos *pos, struct definition *definition);
 BT_HIDDEN
-int ctf_string_read(struct stream_pos *pos, struct definition *definition);
+int ctf_string_read(struct bt_stream_pos *pos, struct definition *definition);
 BT_HIDDEN
-int ctf_string_write(struct stream_pos *pos, struct definition *definition);
+int ctf_string_write(struct bt_stream_pos *pos, struct definition *definition);
 BT_HIDDEN
-int ctf_enum_read(struct stream_pos *pos, struct definition *definition);
+int ctf_enum_read(struct bt_stream_pos *pos, struct definition *definition);
 BT_HIDDEN
-int ctf_enum_write(struct stream_pos *pos, struct definition *definition);
+int ctf_enum_write(struct bt_stream_pos *pos, struct definition *definition);
 BT_HIDDEN
-int ctf_struct_rw(struct stream_pos *pos, struct definition *definition);
+int ctf_struct_rw(struct bt_stream_pos *pos, struct definition *definition);
 BT_HIDDEN
-int ctf_variant_rw(struct stream_pos *pos, struct definition *definition);
+int ctf_variant_rw(struct bt_stream_pos *pos, struct definition *definition);
 BT_HIDDEN
-int ctf_array_read(struct stream_pos *pos, struct definition *definition);
+int ctf_array_read(struct bt_stream_pos *pos, struct definition *definition);
 BT_HIDDEN
-int ctf_array_write(struct stream_pos *pos, struct definition *definition);
+int ctf_array_write(struct bt_stream_pos *pos, struct definition *definition);
 BT_HIDDEN
-int ctf_sequence_read(struct stream_pos *pos, struct definition *definition);
+int ctf_sequence_read(struct bt_stream_pos *pos, struct definition *definition);
 BT_HIDDEN
-int ctf_sequence_write(struct stream_pos *pos, struct definition *definition);
+int ctf_sequence_write(struct bt_stream_pos *pos, struct definition *definition);
 
-void ctf_packet_seek(struct stream_pos *pos, size_t index, int whence);
+void ctf_packet_seek(struct bt_stream_pos *pos, size_t index, int whence);
 
 int ctf_init_pos(struct ctf_stream_pos *pos, int fd, int open_flags);
 int ctf_fini_pos(struct ctf_stream_pos *pos);
diff --git a/include/babeltrace/format.h b/include/babeltrace/format.h
index c6faca7..fa0e325 100644
--- a/include/babeltrace/format.h
+++ b/include/babeltrace/format.h
@@ -41,7 +41,7 @@ extern "C" {
 typedef int bt_intern_str;
 
 /* forward declaration */
-struct stream_pos;
+struct bt_stream_pos;
 struct bt_context;
 struct bt_trace_handle;
 
@@ -62,12 +62,12 @@ struct format {
 	bt_intern_str name;
 
 	struct trace_descriptor *(*open_trace)(const char *path, int flags,
-			void (*packet_seek)(struct stream_pos *pos,
+			void (*packet_seek)(struct bt_stream_pos *pos,
 				size_t index, int whence),
 			FILE *metadata_fp);
 	struct trace_descriptor *(*open_mmap_trace)(
 			struct mmap_stream_list *mmap_list,
-			void (*packet_seek)(struct stream_pos *pos,
+			void (*packet_seek)(struct bt_stream_pos *pos,
 				size_t index, int whence),
 			FILE *metadata_fp);
 	int (*close_trace)(struct trace_descriptor *descriptor);
diff --git a/include/babeltrace/types.h b/include/babeltrace/types.h
index d742b40..310a269 100644
--- a/include/babeltrace/types.h
+++ b/include/babeltrace/types.h
@@ -43,7 +43,7 @@
 #define DEFAULT_NR_STRUCT_FIELDS 8
 
 struct ctf_stream_definition;
-struct stream_pos;
+struct bt_stream_pos;
 struct format;
 struct definition;
 struct ctf_clock;
@@ -106,19 +106,19 @@ struct definition {
 	struct definition_scope *scope;
 };
 
-typedef int (*rw_dispatch)(struct stream_pos *pos,
+typedef int (*rw_dispatch)(struct bt_stream_pos *pos,
 			   struct definition *definition);
 
 /* Parent of per-plugin positions */
-struct stream_pos {
+struct bt_stream_pos {
 	/* read/write dispatch table. Specific to plugin used for stream. */
 	rw_dispatch *rw_table;	/* rw dispatch table */
-	int (*event_cb)(struct stream_pos *pos,
+	int (*event_cb)(struct bt_stream_pos *pos,
 			struct ctf_stream_definition *stream);
 };
 
 static inline
-int generic_rw(struct stream_pos *pos, struct definition *definition)
+int generic_rw(struct bt_stream_pos *pos, struct definition *definition)
 {
 	enum ctf_type_id dispatch_id = definition->declaration->id;
 	rw_dispatch call;
@@ -450,7 +450,7 @@ bt_struct_declaration_get_field_from_index(struct declaration_struct *struct_dec
 struct definition *
 bt_struct_definition_get_field_from_index(struct definition_struct *struct_definition,
 				       int index);
-int bt_struct_rw(struct stream_pos *pos, struct definition *definition);
+int bt_struct_rw(struct bt_stream_pos *pos, struct definition *definition);
 uint64_t bt_struct_declaration_len(struct declaration_struct *struct_declaration);
 
 /*
@@ -480,7 +480,7 @@ int variant_definition_set_tag(struct definition_variant *variant,
  * to.
  */
 struct definition *bt_variant_get_current_field(struct definition_variant *variant);
-int bt_variant_rw(struct stream_pos *pos, struct definition *definition);
+int bt_variant_rw(struct bt_stream_pos *pos, struct definition *definition);
 
 /*
  * elem_declaration passed as parameter now belongs to the array. No
@@ -492,7 +492,7 @@ struct declaration_array *
 		struct declaration_scope *parent_scope);
 uint64_t bt_array_len(struct definition_array *array);
 struct definition *bt_array_index(struct definition_array *array, uint64_t i);
-int bt_array_rw(struct stream_pos *pos, struct definition *definition);
+int bt_array_rw(struct bt_stream_pos *pos, struct definition *definition);
 GString *bt_get_char_array(const struct definition *field);
 int bt_get_array_len(const struct definition *field);
 
@@ -506,7 +506,7 @@ struct declaration_sequence *
 		struct declaration_scope *parent_scope);
 uint64_t bt_sequence_len(struct definition_sequence *sequence);
 struct definition *bt_sequence_index(struct definition_sequence *sequence, uint64_t i);
-int bt_sequence_rw(struct stream_pos *pos, struct definition *definition);
+int bt_sequence_rw(struct bt_stream_pos *pos, struct definition *definition);
 
 /*
  * in: path (dot separated), out: q (GArray of GQuark)
diff --git a/lib/context.c b/lib/context.c
index b728298..18e2e22 100644
--- a/lib/context.c
+++ b/lib/context.c
@@ -67,7 +67,7 @@ struct bt_context *bt_context_create(void)
 
 int bt_context_add_trace(struct bt_context *ctx, const char *path,
 		const char *format_name,
-		void (*packet_seek)(struct stream_pos *pos, size_t index,
+		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence),
 		struct mmap_stream_list *stream_list,
 		FILE *metadata)
diff --git a/types/array.c b/types/array.c
index 30699b1..43decb5 100644
--- a/types/array.c
+++ b/types/array.c
@@ -38,7 +38,7 @@ struct definition *_array_definition_new(struct declaration *declaration,
 static
 void _array_definition_free(struct definition *definition);
 
-int bt_array_rw(struct stream_pos *pos, struct definition *definition)
+int bt_array_rw(struct bt_stream_pos *pos, struct definition *definition)
 {
 	struct definition_array *array_definition =
 		container_of(definition, struct definition_array, p);
diff --git a/types/sequence.c b/types/sequence.c
index 2646cef..a91a249 100644
--- a/types/sequence.c
+++ b/types/sequence.c
@@ -39,7 +39,7 @@ struct definition *_sequence_definition_new(struct declaration *declaration,
 static
 void _sequence_definition_free(struct definition *definition);
 
-int bt_sequence_rw(struct stream_pos *pos, struct definition *definition)
+int bt_sequence_rw(struct bt_stream_pos *pos, struct definition *definition)
 {
 	struct definition_sequence *sequence_definition =
 		container_of(definition, struct definition_sequence, p);
diff --git a/types/struct.c b/types/struct.c
index 5da9033..219d523 100644
--- a/types/struct.c
+++ b/types/struct.c
@@ -43,7 +43,7 @@ struct definition *_struct_definition_new(struct declaration *declaration,
 static
 void _struct_definition_free(struct definition *definition);
 
-int bt_struct_rw(struct stream_pos *ppos, struct definition *definition)
+int bt_struct_rw(struct bt_stream_pos *ppos, struct definition *definition)
 {
 	struct definition_struct *struct_definition =
 		container_of(definition, struct definition_struct, p);
diff --git a/types/variant.c b/types/variant.c
index ebaf43c..4db0de9 100644
--- a/types/variant.c
+++ b/types/variant.c
@@ -39,7 +39,7 @@ struct definition *_variant_definition_new(struct declaration *declaration,
 static
 void _variant_definition_free(struct definition *definition);
 
-int bt_variant_rw(struct stream_pos *ppos, struct definition *definition)
+int bt_variant_rw(struct bt_stream_pos *ppos, struct definition *definition)
 {
 	struct definition_variant *variant_definition =
 		container_of(definition, struct definition_variant, p);
-- 
1.7.10.4
