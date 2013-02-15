From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 4/7] Namespace the struct mmap_stream
Date: Fri, 15 Feb 2013 12:22:53 -0500
Message-ID: <1360948976-14999-4-git-send-email-jdesfossez__16171.5124537752$1360949049$gmane$org@efficios.com>
References: <1360948976-14999-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1U6P0B-0003wD-DW
	for lttng-dev@lists.lttng.org; Fri, 15 Feb 2013 12:23:11 -0500
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

This struct is exposed in the public API so we need to namespace it.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 formats/ctf/ctf.c            |   12 ++++++------
 include/babeltrace/context.h |    2 +-
 include/babeltrace/format.h  |    6 +++---
 lib/context.c                |    2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 2411f7f..3bd1cc1 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -82,7 +82,7 @@ struct bt_trace_descriptor *ctf_open_trace(const char *path, int flags,
 		FILE *metadata_fp);
 static
 struct bt_trace_descriptor *ctf_open_mmap_trace(
-		struct mmap_stream_list *mmap_list,
+		struct bt_mmap_stream_list *mmap_list,
 		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence),
 		FILE *metadata_fp);
@@ -1736,7 +1736,7 @@ error:
 
 static
 void ctf_init_mmap_pos(struct ctf_stream_pos *pos,
-		struct mmap_stream *mmap_info)
+		struct bt_mmap_stream *mmap_info)
 {
 	pos->mmap_offset = 0;
 	pos->packet_size = 0;
@@ -1785,7 +1785,7 @@ end:
 
 static
 int ctf_open_mmap_stream_read(struct ctf_trace *td,
-		struct mmap_stream *mmap_info,
+		struct bt_mmap_stream *mmap_info,
 		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence))
 {
@@ -1827,13 +1827,13 @@ error_def:
 
 static
 int ctf_open_mmap_trace_read(struct ctf_trace *td,
-		struct mmap_stream_list *mmap_list,
+		struct bt_mmap_stream_list *mmap_list,
 		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence),
 		FILE *metadata_fp)
 {
 	int ret;
-	struct mmap_stream *mmap_info;
+	struct bt_mmap_stream *mmap_info;
 
 	ret = ctf_open_trace_metadata_read(td, ctf_packet_seek, metadata_fp);
 	if (ret) {
@@ -1860,7 +1860,7 @@ error:
 
 static
 struct bt_trace_descriptor *ctf_open_mmap_trace(
-		struct mmap_stream_list *mmap_list,
+		struct bt_mmap_stream_list *mmap_list,
 		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence),
 		FILE *metadata_fp)
diff --git a/include/babeltrace/context.h b/include/babeltrace/context.h
index f3763e1..b28df09 100644
--- a/include/babeltrace/context.h
+++ b/include/babeltrace/context.h
@@ -84,7 +84,7 @@ int bt_context_add_trace(struct bt_context *ctx, const char *path,
 		const char *format,
 		void (*packet_seek)(struct bt_stream_pos *pos,
 			size_t index, int whence),
-		struct mmap_stream_list *stream_list,
+		struct bt_mmap_stream_list *stream_list,
 		FILE *metadata);
 
 /*
diff --git a/include/babeltrace/format.h b/include/babeltrace/format.h
index d0f9378..8d4ac4b 100644
--- a/include/babeltrace/format.h
+++ b/include/babeltrace/format.h
@@ -49,12 +49,12 @@ struct bt_trace_handle;
 struct bt_trace_descriptor {
 };
 
-struct mmap_stream {
+struct bt_mmap_stream {
 	int fd;
 	struct bt_list_head list;
 };
 
-struct mmap_stream_list {
+struct bt_mmap_stream_list {
 	struct bt_list_head head;
 };
 
@@ -66,7 +66,7 @@ struct format {
 				size_t index, int whence),
 			FILE *metadata_fp);
 	struct bt_trace_descriptor *(*open_mmap_trace)(
-			struct mmap_stream_list *mmap_list,
+			struct bt_mmap_stream_list *mmap_list,
 			void (*packet_seek)(struct bt_stream_pos *pos,
 				size_t index, int whence),
 			FILE *metadata_fp);
diff --git a/lib/context.c b/lib/context.c
index e6b60fa..0040972 100644
--- a/lib/context.c
+++ b/lib/context.c
@@ -69,7 +69,7 @@ int bt_context_add_trace(struct bt_context *ctx, const char *path,
 		const char *format_name,
 		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence),
-		struct mmap_stream_list *stream_list,
+		struct bt_mmap_stream_list *stream_list,
 		FILE *metadata)
 {
 	struct bt_trace_descriptor *td;
-- 
1.7.10.4
