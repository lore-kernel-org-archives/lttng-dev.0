From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH] Parse LTTng indexes
Date: Thu, 14 Nov 2013 11:03:33 -0500
Message-ID: <1384445013-14772-1-git-send-email-jdesfossez__22770.2684388079$1384445091$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1VgzOV-0007HQ-DY
	for lttng-dev@lists.lttng.org; Thu, 14 Nov 2013 11:03:53 -0500
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

If a trace file has an associated index (same filename and .idx suffix),
we open it and use it instead of generating the index at open.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 formats/ctf/ctf.c              | 213 +++++++++++++++++++++++++++++++++++++++--
 include/babeltrace/ctf/types.h |   1 +
 include/lttng-index.h          |  58 +++++++++++
 3 files changed, 266 insertions(+), 6 deletions(-)
 create mode 100644 include/lttng-index.h

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 60d9c9f..2439606 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -35,6 +35,7 @@
 #include <babeltrace/context-internal.h>
 #include <babeltrace/compat/uuid.h>
 #include <babeltrace/endian.h>
+#include <lttng-index.h>
 #include <inttypes.h>
 #include <stdio.h>
 #include <sys/mman.h>
@@ -1666,6 +1667,151 @@ error:
 	return ret;
 }
 
+static
+int import_stream_packet_index(struct ctf_trace *td,
+		struct ctf_file_stream *file_stream)
+{
+	struct ctf_stream_declaration *stream;
+	struct ctf_stream_pos *pos;
+	struct lttng_packet_index lttng_index;
+	struct lttng_packet_index_file_hdr index_hdr;
+	uint64_t packet_map_len = DEFAULT_HEADER_LEN;
+	struct packet_index index;
+	int ret, index_read;
+	int first_packet = 1;
+	size_t filesize;
+	struct stat filestats;
+
+	pos = &file_stream->pos;
+
+	ret = read(pos->index_fd, &index_hdr, sizeof(index_hdr));
+	if (ret < 0) {
+		perror("read index file header");
+		goto error;
+	}
+	/* Check the index header */
+	if (strncmp(index_hdr.magic, INDEX_MAGIC, sizeof(index_hdr.magic)) != 0) {
+		fprintf(stderr, "[error] wrong index magic\n");
+		ret = -1;
+		goto error;
+	}
+	if (be32toh(index_hdr.index_major) != INDEX_MAJOR ||
+			be32toh(index_hdr.index_minor) != INDEX_MINOR) {
+		fprintf(stderr, "[error] Incompatible index file %" PRIu64
+				".%" PRIu64 ", supported %d.%d\n",
+				be64toh(index_hdr.index_major),
+				be64toh(index_hdr.index_minor), INDEX_MAJOR,
+				INDEX_MINOR);
+		ret = -1;
+		goto error;
+	}
+
+	while ((index_read = read(pos->index_fd, &lttng_index,
+					sizeof(lttng_index)))) {
+		uint64_t stream_id;
+		int len_index;
+
+		index.offset = be64toh(lttng_index.offset);
+		index.packet_size = be64toh(lttng_index.packet_size);
+		index.content_size = be64toh(lttng_index.content_size);
+		index.timestamp_begin = be64toh(lttng_index.timestamp_begin);
+		index.timestamp_end = be64toh(lttng_index.timestamp_end);
+		index.events_discarded = be64toh(lttng_index.events_discarded);
+		stream_id = be64toh(lttng_index.stream_id);
+
+		if (!first_packet) {
+			/* add index to packet array */
+			g_array_append_val(file_stream->pos.packet_cycles_index, index);
+			continue;
+		}
+
+		file_stream->parent.stream_id = stream_id;
+		stream = g_ptr_array_index(td->streams, stream_id);
+		if (!stream) {
+			fprintf(stderr, "[error] Stream %" PRIu64
+					" is not declared in metadata.\n",
+					stream_id);
+			ret = -EINVAL;
+			goto error;
+		}
+		file_stream->parent.stream_class = stream;
+		ret = create_stream_definitions(td, &file_stream->parent);
+		if (ret)
+			goto error;
+
+		ret = fstat(pos->fd, &filestats);
+		if (ret < 0)
+			goto error;
+
+		if (!filestats.st_size) {
+			fprintf(stderr, "[error] Empty trace file\n");
+			ret = -1;
+			goto error;
+		}
+		filesize = filestats.st_size;
+
+		if (filesize - pos->mmap_offset < (packet_map_len >> LOG2_CHAR_BIT)) {
+			packet_map_len = (filesize - pos->mmap_offset) << LOG2_CHAR_BIT;
+		}
+
+		if (pos->base_mma) {
+			/* unmap old base */
+			ret = munmap_align(pos->base_mma);
+			if (ret) {
+				fprintf(stderr, "[error] Unable to unmap old base: %s.\n",
+						strerror(errno));
+				return ret;
+			}
+			pos->base_mma = NULL;
+		}
+		/* map new base. Need mapping length from header. */
+		pos->base_mma = mmap_align(packet_map_len >> LOG2_CHAR_BIT, PROT_READ,
+				MAP_PRIVATE, pos->fd, pos->mmap_offset);
+		assert(pos->base_mma != MAP_FAILED);
+		/*
+		 * Use current mapping size as temporary content and packet
+		 * size.
+		 */
+		pos->content_size = packet_map_len;
+		pos->packet_size = packet_map_len;
+		pos->offset = 0;	/* Position of the packet header */
+
+		/* update trace_packet_header and stream_packet_context */
+		if (pos->prot != PROT_WRITE && file_stream->parent.trace_packet_header) {
+			/* Read packet header */
+			ret = generic_rw(&pos->parent, &file_stream->parent.trace_packet_header->p);
+			assert(!ret);
+		}
+		if (pos->prot != PROT_WRITE && file_stream->parent.stream_packet_context) {
+			/* Read packet context */
+			ret = generic_rw(&pos->parent, &file_stream->parent.stream_packet_context->p);
+			assert(!ret);
+		}
+		index.data_offset = pos->offset;
+
+		/* read events discarded len from header */
+		len_index = bt_struct_declaration_lookup_field_index(
+				file_stream->parent.stream_packet_context->declaration,
+				g_quark_from_static_string("events_discarded"));
+		if (len_index >= 0) {
+			struct bt_definition *field;
+
+			field = bt_struct_definition_get_field_from_index(
+					file_stream->parent.stream_packet_context,
+					len_index);
+			index.events_discarded_len = bt_get_int_len(field);
+		}
+		first_packet = 0;
+		/* add index to packet array */
+		g_array_append_val(file_stream->pos.packet_cycles_index, index);
+	}
+
+	ret = 0;
+
+error:
+	return ret;
+}
+
 /*
  * Note: many file streams can inherit from the same stream class
  * description (metadata).
@@ -1675,9 +1821,10 @@ int ctf_open_file_stream_read(struct ctf_trace *td, const char *path, int flags,
 		void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence))
 {
-	int ret, fd, closeret;
+	int ret, fd, closeret, index_fd;
 	struct ctf_file_stream *file_stream;
 	struct stat statbuf;
+	char *index_name;
 
 	fd = openat(td->dirfd, path, flags);
 	if (fd < 0) {
@@ -1693,13 +1840,18 @@ int ctf_open_file_stream_read(struct ctf_trace *td, const char *path, int flags,
 		goto fstat_error;
 	}
 	if (S_ISDIR(statbuf.st_mode)) {
-		fprintf(stderr, "[warning] Skipping directory '%s' found in trace\n", path);
+		if (strncmp(path, "index", 5) != 0) {
+			fprintf(stderr, "[warning] Skipping directory '%s' "
+					"found in trace\n", path);
+		}
 		ret = 0;
 		goto fd_is_dir_ok;
 	}
 
 	file_stream = g_new0(struct ctf_file_stream, 1);
 	file_stream->pos.last_offset = LAST_OFFSET_POISON;
+	file_stream->pos.fd = -1;
+	file_stream->pos.index_fd = -1;
 
 	strncpy(file_stream->parent.path, path, PATH_MAX);
 	file_stream->parent.path[PATH_MAX - 1] = '\0';
@@ -1722,19 +1874,60 @@ int ctf_open_file_stream_read(struct ctf_trace *td, const char *path, int flags,
 	 * For now, only a single clock per trace is supported.
 	 */
 	file_stream->parent.current_clock = td->parent.single_clock;
-	ret = create_stream_packet_index(td, file_stream);
-	if (ret) {
-		fprintf(stderr, "[error] Stream index creation error.\n");
-		goto error_index;
+
+	/*
+	 * Allocate the index name for this stream and try to open it.
+	 */
+	index_name = malloc((strlen(path) + 12) * sizeof(char));
+	if (!index_name) {
+		fprintf(stderr, "[error] Cannot allocate index filename\n");
+		goto error_def;
 	}
+	snprintf(index_name, strlen(path) + 12, "./index/%s.idx", path);
+
+	if (faccessat(td->dirfd, index_name, O_RDONLY, flags) == 0) {
+		index_fd = openat(td->dirfd, index_name, flags);
+		if (index_fd < 0) {
+			perror("Index file openat()");
+			ret = -1;
+			goto error_free;
+		}
+		file_stream->pos.index_fd = index_fd;
+		ret = import_stream_packet_index(td, file_stream);
+		if (ret) {
+			ret = -1;
+			goto error_index;
+		}
+		ret = close(file_stream->pos.index_fd);
+		if (ret < 0) {
+			perror("close index");
+			goto error_free;
+		}
+	} else {
+		ret = create_stream_packet_index(td, file_stream);
+		if (ret) {
+			fprintf(stderr, "[error] Stream index creation error.\n");
+			goto error_index;
+		}
+	}
+	free(index_name);
+
 	/* Add stream file to stream class */
 	g_ptr_array_add(file_stream->parent.stream_class->streams,
 			&file_stream->parent);
 	return 0;
 
 error_index:
+	if (file_stream->pos.index_fd > 0) {
+		ret = close(file_stream->pos.index_fd);
+		if (ret < 0) {
+			perror("close index");
+		}
+	}
 	if (file_stream->parent.trace_packet_header)
 		bt_definition_unref(&file_stream->parent.trace_packet_header->p);
+error_free:
+	free(index_name);
 error_def:
 	closeret = ctf_fini_pos(&file_stream->pos);
 	if (closeret) {
@@ -1761,6 +1954,7 @@ int ctf_open_trace_read(struct ctf_trace *td,
 	struct dirent *dirent;
 	struct dirent *diriter;
 	size_t dirent_len;
+	char *ext;
 
 	td->flags = flags;
 
@@ -1816,6 +2010,13 @@ int ctf_open_trace_read(struct ctf_trace *td,
 				|| !strcmp(diriter->d_name, "..")
 				|| !strcmp(diriter->d_name, "metadata"))
 			continue;
+
+		/* Ignore index files : *.idx */
+		ext = strrchr(diriter->d_name, '.');
+		if (ext && (!strcmp(ext, ".idx"))) {
+			continue;
+		}
+
 		ret = ctf_open_file_stream_read(td, diriter->d_name,
 					flags, packet_seek);
 		if (ret) {
diff --git a/include/babeltrace/ctf/types.h b/include/babeltrace/ctf/types.h
index 96c5083..e6d1d8e 100644
--- a/include/babeltrace/ctf/types.h
+++ b/include/babeltrace/ctf/types.h
@@ -61,6 +61,7 @@ struct packet_index {
 struct ctf_stream_pos {
 	struct bt_stream_pos parent;
 	int fd;			/* backing file fd. -1 if unset. */
+	int index_fd;		/* backing index file fd. -1 if unset. */
 	GArray *packet_cycles_index;	/* contains struct packet_index in cycles */
 	GArray *packet_real_index;	/* contains struct packet_index in ns */
 	int prot;		/* mmap protection */
diff --git a/include/lttng-index.h b/include/lttng-index.h
new file mode 100644
index 0000000..4327cbd
--- /dev/null
+++ b/include/lttng-index.h
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) 2013 - Julien Desfossez <jdesfossez@efficios.com>
+ *                      Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *                      David Goulet <dgoulet@efficios.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#ifndef LTTNG_INDEX_H
+#define LTTNG_INDEX_H
+
+#include <limits.h>
+
+#define INDEX_MAGIC "CTFIDX"
+#define INDEX_MAJOR 1
+#define INDEX_MINOR 0
+
+/*
+ * Header at the beginning of each index file.
+ * All integer fields are stored in big endian.
+ */
+struct lttng_packet_index_file_hdr {
+	char magic[6];
+	uint32_t index_major;
+	uint32_t index_minor;
+} __attribute__((__packed__));
+
+/*
+ * Packet index generated for each trace packet store in a trace file.
+ * All integer fields are stored in big endian.
+ */
+struct lttng_packet_index {
+	uint64_t offset;		/* offset of the packet in the file, in bytes */
+	uint64_t packet_size;		/* packet size, in bits */
+	uint64_t content_size;		/* content size, in bits */
+	uint64_t timestamp_begin;
+	uint64_t timestamp_end;
+	uint64_t events_discarded;
+	uint64_t stream_id;
+} __attribute__((__packed__));
+
+#endif /* LTTNG_INDEX_H */
-- 
1.8.3.2
