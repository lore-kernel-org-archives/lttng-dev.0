From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH] Fix data_offset when importing the
	indexes
Date: Fri, 29 Nov 2013 11:12:02 -0500
Message-ID: <1385741522-25767-1-git-send-email-jdesfossez__43208.7007131942$1385741593$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1VmQfv-0003zb-4J
	for lttng-dev@lists.lttng.org; Fri, 29 Nov 2013 11:12:21 -0500
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

The data_offset is the same for all the packets of a stream and is
computed from reading the headers and context of the first packet in a
stream.
When importing an index, we don't have this information and we want to
mmap the tracefile only when needed, so we introduce a new function to
only compute this information when we are going to use the first packet
of a stream. Once we find the data_offset, we copy it to the
ctf_stream_pos to avoid recomputing it for each packet (since it won't
be written in the index at open time).

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 formats/ctf/ctf.c              | 102 +++++++++++++++++++++++++++++++++++++++++
 include/babeltrace/ctf/types.h |   1 +
 2 files changed, 103 insertions(+)

diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
index 5cf8097..5e7ae17 100644
--- a/formats/ctf/ctf.c
+++ b/formats/ctf/ctf.c
@@ -627,10 +627,103 @@ error:
 	return ret;
 }
 
+static
+int find_data_offset(struct ctf_stream_pos *pos,
+		struct ctf_file_stream *file_stream)
+{
+	uint64_t packet_map_len = DEFAULT_HEADER_LEN, tmp_map_len;
+	struct stat filestats;
+	int ret;
+	size_t filesize;
+
+	pos = &file_stream->pos;
+
+	ret = fstat(pos->fd, &filestats);
+	if (ret < 0)
+		return ret;
+	filesize = filestats.st_size;
+
+	/* Deal with empty files */
+	if (!filesize) {
+		return 0;
+	}
+
+begin:
+	if (filesize - pos->mmap_offset < (packet_map_len >> LOG2_CHAR_BIT)) {
+		packet_map_len = (filesize - pos->mmap_offset) << LOG2_CHAR_BIT;
+	}
+
+	if (pos->base_mma) {
+		/* unmap old base */
+		ret = munmap_align(pos->base_mma);
+		if (ret) {
+			fprintf(stderr, "[error] Unable to unmap old base: %s.\n",
+					strerror(errno));
+			return ret;
+		}
+		pos->base_mma = NULL;
+	}
+	/* map new base. Need mapping length from header. */
+	pos->base_mma = mmap_align(packet_map_len >> LOG2_CHAR_BIT, PROT_READ,
+			MAP_PRIVATE, pos->fd, pos->mmap_offset);
+	assert(pos->base_mma != MAP_FAILED);
+
+	/* update trace_packet_header and stream_packet_context */
+	if (pos->prot != PROT_WRITE && file_stream->parent.trace_packet_header) {
+		/* Read packet header */
+		ret = generic_rw(&pos->parent, &file_stream->parent.trace_packet_header->p);
+		if (ret) {
+			if (ret == -EFAULT)
+				goto retry;
+		}
+	}
+	if (pos->prot != PROT_WRITE && file_stream->parent.stream_packet_context) {
+		/* Read packet context */
+		ret = generic_rw(&pos->parent, &file_stream->parent.stream_packet_context->p);
+		if (ret) {
+			if (ret == -EFAULT)
+				goto retry;
+		}
+	}
+	pos->data_offset = pos->offset;
+
+	/* unmap old base */
+	ret = munmap_align(pos->base_mma);
+	if (ret) {
+		fprintf(stderr, "[error] Unable to unmap old base: %s.\n",
+				strerror(errno));
+		return ret;
+	}
+	pos->base_mma = NULL;
+
+	return 0;
+
+	/* Retry with larger mapping */
+retry:
+	if (packet_map_len == ((filesize - pos->mmap_offset) << LOG2_CHAR_BIT)) {
+		/*
+		 * Reached EOF, but still expecting header/context data.
+		 */
+		fprintf(stderr, "[error] Reached end of file, but still expecting header or context fields.\n");
+		return -EFAULT;
+	}
+	/* Double the mapping len, and retry */
+	tmp_map_len = packet_map_len << 1;
+	if (tmp_map_len >> 1 != packet_map_len) {
+		/* Overflow */
+		fprintf(stderr, "[error] Packet mapping length overflow\n");
+		return -EFAULT;
+	}
+	packet_map_len = tmp_map_len;
+	goto begin;
+}
+
+
 int ctf_init_pos(struct ctf_stream_pos *pos, struct bt_trace_descriptor *trace,
 		int fd, int open_flags)
 {
 	pos->fd = fd;
+	pos->data_offset = -1;
 	if (fd >= 0) {
 		pos->packet_cycles_index = g_array_new(FALSE, TRUE,
 						sizeof(struct packet_index));
@@ -850,6 +943,14 @@ void ctf_packet_seek(struct bt_stream_pos *stream_pos, size_t index, int whence)
 		/* Lookup context/packet size in index */
 		pos->content_size = packet_index->content_size;
 		pos->packet_size = packet_index->packet_size;
+		if (pos->data_offset != -1) {
+			packet_index->data_offset = pos->data_offset;
+		} else {
+			ret = find_data_offset(pos, file_stream);
+			if (ret < 0) {
+				return;
+			}
+		}
 		if (packet_index->data_offset < packet_index->content_size) {
 			pos->offset = 0;	/* will read headers */
 		} else if (packet_index->data_offset == packet_index->content_size) {
@@ -1593,6 +1694,7 @@ begin:
 
 	/* Save position after header and context */
 	packet_index.data_offset = pos->offset;
+	pos->data_offset = pos->offset;
 
 	/* add index to packet array */
 	g_array_append_val(file_stream->pos.packet_cycles_index, packet_index);
diff --git a/include/babeltrace/ctf/types.h b/include/babeltrace/ctf/types.h
index e90464d..5f32b9b 100644
--- a/include/babeltrace/ctf/types.h
+++ b/include/babeltrace/ctf/types.h
@@ -78,6 +78,7 @@ struct ctf_stream_pos {
 	int64_t last_offset;	/* offset before the last read_event */
 	uint64_t cur_index;	/* current index in packet index */
 	uint64_t last_events_discarded;	/* last known amount of event discarded */
+	int64_t data_offset;	/* offset of data within the packet, in bits */
 	void (*packet_seek)(struct bt_stream_pos *pos, size_t index,
 			int whence); /* function called to switch packet */
 
-- 
1.8.3.2
