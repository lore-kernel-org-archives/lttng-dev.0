From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 03/18] Hide internal functions of
	libbabeltrace-ctf
Date: Thu, 24 Jan 2013 17:08:35 -0500
Message-ID: <1359065315-17252-1-git-send-email-jdesfossez__48440.0764493786$1359065366$gmane$org@efficios.com>
References: <1359062510-7557-3-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TyUyU-0000aQ-JI
	for lttng-dev@lists.lttng.org; Thu, 24 Jan 2013 17:08:46 -0500
In-Reply-To: <1359062510-7557-3-git-send-email-jdesfossez@efficios.com>
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
 formats/ctf/ctf.c                           |    5 ++++-
 formats/ctf/metadata/ctf-ast.h              |    5 +++++
 formats/ctf/types/float.c                   |    4 +++-
 include/babeltrace/ctf/callbacks-internal.h |    1 +
 include/babeltrace/ctf/types.h              |   14 ++++++++++++++
 5 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index a8f8408..a55f5e4 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -307,6 +307,7 @@ void ctf_update_timestamp(struct ctf_stream_definition *stream,
  * Print timestamp, rescaling clock frequency to nanoseconds and
  * applying offsets as needed (unix time).
  */
+static
 void ctf_print_timestamp_real(FILE *fp,
 			struct ctf_stream_definition *stream,
 			uint64_t timestamp)
@@ -371,6 +372,7 @@ end:
 /*
  * Print timestamp, in cycles
  */
+static
 void ctf_print_timestamp_cycles(FILE *fp,
 		struct ctf_stream_definition *stream,
 		uint64_t timestamp)
@@ -1724,7 +1726,7 @@ error:
 	return NULL;
 }
 
-
+static
 void ctf_init_mmap_pos(struct ctf_stream_pos *pos,
 		struct mmap_stream *mmap_info)
 {
@@ -1815,6 +1817,7 @@ error_def:
 	return ret;
 }
 
+static
 int ctf_open_mmap_trace_read(struct ctf_trace *td,
 		struct mmap_stream_list *mmap_list,
 		void (*packet_seek)(struct stream_pos *pos, size_t index,
diff --git a/formats/ctf/metadata/ctf-ast.h b/formats/ctf/metadata/ctf-ast.h
index d5a0544..1368627 100644
--- a/formats/ctf/metadata/ctf-ast.h
+++ b/formats/ctf/metadata/ctf-ast.h
@@ -302,11 +302,16 @@ const char *node_type(struct ctf_node *node);
 
 struct ctf_trace;
 
+BT_HIDDEN
 int ctf_visitor_print_xml(FILE *fd, int depth, struct ctf_node *node);
+BT_HIDDEN
 int ctf_visitor_semantic_check(FILE *fd, int depth, struct ctf_node *node);
+BT_HIDDEN
 int ctf_visitor_parent_links(FILE *fd, int depth, struct ctf_node *node);
+BT_HIDDEN
 int ctf_visitor_construct_metadata(FILE *fd, int depth, struct ctf_node *node,
 			struct ctf_trace *trace, int byte_order);
+BT_HIDDEN
 int ctf_destroy_metadata(struct ctf_trace *trace);
 
 #endif /* _CTF_AST_H */
diff --git a/formats/ctf/types/float.c b/formats/ctf/types/float.c
index 0cf9cae..054e262 100644
--- a/formats/ctf/types/float.c
+++ b/formats/ctf/types/float.c
@@ -96,7 +96,7 @@ static void float_unlock(void)
 	assert(!ret);
 }
 
-int _ctf_float_copy(struct stream_pos *destp,
+static int _ctf_float_copy(struct stream_pos *destp,
 		    struct definition_float *dest_definition,
 		    struct stream_pos *srcp,
 		    const struct definition_float *src_definition)
@@ -278,6 +278,7 @@ end:
 	return ret;
 }
 
+static
 void __attribute__((constructor)) ctf_float_init(void)
 {
 	static_float_declaration =
@@ -292,6 +293,7 @@ void __attribute__((constructor)) ctf_float_init(void)
 				__alignof__(double));
 }
 
+static
 void __attribute__((destructor)) ctf_float_fini(void)
 {
 	declaration_unref(&static_float_declaration->p);
diff --git a/include/babeltrace/ctf/callbacks-internal.h b/include/babeltrace/ctf/callbacks-internal.h
index 0390b9a..41bc846 100644
--- a/include/babeltrace/ctf/callbacks-internal.h
+++ b/include/babeltrace/ctf/callbacks-internal.h
@@ -60,6 +60,7 @@ struct bt_dependencies {
 	int refcount;			/* free when decremented to 0 */
 };
 
+BT_HIDDEN
 void process_callbacks(struct bt_ctf_iter *iter, struct ctf_stream_definition *stream);
 
 #endif /* _BABELTRACE_CALLBACKS_INTERNAL_H */
diff --git a/include/babeltrace/ctf/types.h b/include/babeltrace/ctf/types.h
index 6b8752e..8bd0102 100644
--- a/include/babeltrace/ctf/types.h
+++ b/include/babeltrace/ctf/types.h
@@ -90,19 +90,33 @@ struct ctf_stream_pos *ctf_pos(struct stream_pos *pos)
 	return container_of(pos, struct ctf_stream_pos, parent);
 }
 
+BT_HIDDEN
 int ctf_integer_read(struct stream_pos *pos, struct definition *definition);
+BT_HIDDEN
 int ctf_integer_write(struct stream_pos *pos, struct definition *definition);
+BT_HIDDEN
 int ctf_float_read(struct stream_pos *pos, struct definition *definition);
+BT_HIDDEN
 int ctf_float_write(struct stream_pos *pos, struct definition *definition);
+BT_HIDDEN
 int ctf_string_read(struct stream_pos *pos, struct definition *definition);
+BT_HIDDEN
 int ctf_string_write(struct stream_pos *pos, struct definition *definition);
+BT_HIDDEN
 int ctf_enum_read(struct stream_pos *pos, struct definition *definition);
+BT_HIDDEN
 int ctf_enum_write(struct stream_pos *pos, struct definition *definition);
+BT_HIDDEN
 int ctf_struct_rw(struct stream_pos *pos, struct definition *definition);
+BT_HIDDEN
 int ctf_variant_rw(struct stream_pos *pos, struct definition *definition);
+BT_HIDDEN
 int ctf_array_read(struct stream_pos *pos, struct definition *definition);
+BT_HIDDEN
 int ctf_array_write(struct stream_pos *pos, struct definition *definition);
+BT_HIDDEN
 int ctf_sequence_read(struct stream_pos *pos, struct definition *definition);
+BT_HIDDEN
 int ctf_sequence_write(struct stream_pos *pos, struct definition *definition);
 
 void ctf_packet_seek(struct stream_pos *pos, size_t index, int whence);
-- 
1.7.10.4
