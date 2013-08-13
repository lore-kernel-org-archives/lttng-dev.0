From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS 2.4 PATCH] Generate local kernel and UST
	indexes
Date: Tue, 13 Aug 2013 15:40:51 -0400
Message-ID: <1376422851-15722-1-git-send-email-jdesfossez__14287.2423785322$1376422924$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1V9KSm-0008Rs-So
	for lttng-dev@lists.lttng.org; Tue, 13 Aug 2013 15:41:11 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

When the consumer creates a new trace file, it now creates as well an
index file that the viewers can use to navigate in the trace.
For now these indexes are only local and not sent to the relayd.

This patch requires additionnal ioctl and ustctl calls implemented
in lttng-modules and lttng-ust in separate patches.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 include/lttng/lttng-index.h                  |   52 ++++++++++++++++
 src/common/consumer.c                        |   40 ++++++++++++
 src/common/consumer.h                        |    6 ++
 src/common/kernel-consumer/kernel-consumer.c |   86 ++++++++++++++++++++++++++
 src/common/kernel-ctl/kernel-ctl.c           |   36 +++++++++++
 src/common/kernel-ctl/kernel-ctl.h           |    8 +++
 src/common/kernel-ctl/kernel-ioctl.h         |   13 ++++
 src/common/ust-consumer/ust-consumer.c       |   83 +++++++++++++++++++++++++
 8 files changed, 324 insertions(+)
 create mode 100644 include/lttng/lttng-index.h

diff --git a/include/lttng/lttng-index.h b/include/lttng/lttng-index.h
new file mode 100644
index 0000000..d85b0ed
--- /dev/null
+++ b/include/lttng/lttng-index.h
@@ -0,0 +1,52 @@
+/*
+ * Copyright (C) 2013 - Julien Desfossez <jdesfossez@efficios.com>
+ *                      David Goulet <dgoulet@efficios.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2 only,
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
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
diff --git a/src/common/consumer.c b/src/common/consumer.c
index 221c348..5cb25c9 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -505,6 +505,7 @@ struct lttng_consumer_stream *consumer_allocate_stream(uint64_t channel_key,
 	stream->session_id = session_id;
 	stream->monitor = monitor;
 	stream->endpoint_status = CONSUMER_ENDPOINT_ACTIVE;
+	stream->index_fd = -1;
 	pthread_mutex_init(&stream->lock, NULL);
 
 	/* If channel is the metadata, flag this stream as metadata. */
@@ -3515,3 +3516,42 @@ unsigned long consumer_get_consumed_maxsize(unsigned long consumed_pos,
 
 	return consumed_pos;
 }
+
+/*
+ * Create the index file associated with a trace file.
+ *
+ * Returns 0 on success, a negative value on error.
+ */
+int consumer_create_index_file(struct lttng_consumer_stream *stream)
+{
+	char *index_name;
+	struct lttng_packet_index_file_hdr hdr;
+	int ret;
+
+	ret = asprintf(&index_name, "%s.idx", stream->name);
+	if (ret < 0) {
+		PERROR("Allocating index name");
+		goto error;
+	}
+	ret = utils_create_stream_file(stream->chan->pathname,
+			index_name, 0, 0, stream->uid,
+			stream->gid);
+	free(index_name);
+	if (ret < 0) {
+		goto error;
+	}
+
+	stream->index_fd = ret;
+	memcpy(hdr.magic, INDEX_MAGIC, sizeof(hdr.magic));
+	hdr.index_major = htobe32(INDEX_MAJOR);
+	hdr.index_minor = htobe32(INDEX_MINOR);
+	do {
+		ret = write(stream->index_fd, &hdr, sizeof(hdr));
+	} while (ret < 0 && errno == EINTR);
+	if (ret < 0) {
+		PERROR("Writing index header");
+	}
+
+error:
+	return ret;
+}
diff --git a/src/common/consumer.h b/src/common/consumer.h
index 5021a10..f044a87 100644
--- a/src/common/consumer.h
+++ b/src/common/consumer.h
@@ -26,6 +26,7 @@
 #include <urcu/list.h>
 
 #include <lttng/lttng.h>
+#include <lttng/lttng-index.h>
 
 #include <common/hashtable/hashtable.h>
 #include <common/compat/fcntl.h>
@@ -318,6 +319,10 @@ struct lttng_consumer_stream {
 	 * to the channel.
 	 */
 	uint64_t ust_metadata_pushed;
+	/*
+	 * FD of the index file for this stream.
+	 */
+	int index_fd;
 };
 
 /*
@@ -624,5 +629,6 @@ int consumer_add_data_stream(struct lttng_consumer_stream *stream);
 void consumer_del_stream_for_data(struct lttng_consumer_stream *stream);
 int consumer_add_metadata_stream(struct lttng_consumer_stream *stream);
 void consumer_del_stream_for_metadata(struct lttng_consumer_stream *stream);
+int consumer_create_index_file(struct lttng_consumer_stream *stream);
 
 #endif /* LIB_CONSUMER_H */
diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index bfec4d2..cb6149a 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -38,6 +38,7 @@
 #include <common/relayd/relayd.h>
 #include <common/utils.h>
 #include <common/consumer-stream.h>
+#include <lttng/lttng-index.h>
 
 #include "kernel-consumer.h"
 
@@ -843,6 +844,56 @@ error_fatal:
 	return -1;
 }
 
+static int get_index_values(struct lttng_packet_index *index, int infd)
+{
+	int ret;
+
+	ret = kernctl_get_timestamp_begin(infd, &index->timestamp_begin);
+	if (ret < 0) {
+		PERROR("kernctl_get_timestamp_begin");
+		goto error;
+	}
+	index->timestamp_begin = htobe64(index->timestamp_begin);
+
+	ret = kernctl_get_timestamp_end(infd, &index->timestamp_end);
+	if (ret < 0) {
+		PERROR("kernctl_get_timestamp_end");
+		goto error;
+	}
+	index->timestamp_end = htobe64(index->timestamp_end);
+
+	ret = kernctl_get_events_discarded(infd, &index->events_discarded);
+	if (ret < 0) {
+		PERROR("kernctl_get_events_discarded");
+		goto error;
+	}
+	index->events_discarded = htobe64(index->events_discarded);
+
+	ret = kernctl_get_content_size(infd, &index->content_size);
+	if (ret < 0) {
+		PERROR("kernctl_get_content_size");
+		goto error;
+	}
+	index->content_size = htobe64(index->content_size);
+
+	ret = kernctl_get_packet_size(infd, &index->packet_size);
+	if (ret < 0) {
+		PERROR("kernctl_get_packet_size");
+		goto error;
+	}
+	index->packet_size = htobe64(index->packet_size);
+
+	ret = kernctl_get_stream_id(infd, &index->stream_id);
+	if (ret < 0) {
+		PERROR("kernctl_get_stream_id");
+		goto error;
+	}
+	index->stream_id = htobe64(index->stream_id);
+
+error:
+	return ret;
+}
+
 /*
  * Consume data on a file descriptor and write it on a trace file.
  */
@@ -853,6 +904,7 @@ ssize_t lttng_kconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
 	int err;
 	ssize_t ret = 0;
 	int infd = stream->wait_fd;
+	struct lttng_packet_index index;
 
 	DBG("In read_subbuffer (infd : %d)", infd);
 	/* Get the next subbuffer */
@@ -878,6 +930,14 @@ ssize_t lttng_kconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
 		goto end;
 	}
 
+	if (!stream->metadata_flag) {
+		index.offset = htobe64(stream->out_fd_offset);
+		ret = get_index_values(&index, infd);
+		if (ret < 0) {
+			goto end;
+		}
+	}
+
 	switch (stream->chan->output) {
 	case CONSUMER_CHANNEL_SPLICE:
 		/*
@@ -954,6 +1014,25 @@ ssize_t lttng_kconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
 		goto end;
 	}
 
+	if (stream->index_fd < 0) {
+		ret = 0;
+		goto end;
+	}
+
+	if (stream->index_fd < 0) {
+		ret = 0;
+		goto end;
+	}
+
+	do {
+		ret = write(stream->index_fd, &index, sizeof(index));
+	} while (ret < 0 && errno == EINTR);
+	if (ret < 0) {
+		PERROR("Writing index file");
+		goto end;
+	}
+	ret = 0;
+
 end:
 	return ret;
 }
@@ -977,6 +1056,13 @@ int lttng_kconsumer_on_recv_stream(struct lttng_consumer_stream *stream)
 		}
 		stream->out_fd = ret;
 		stream->tracefile_size_current = 0;
+
+		if (!stream->metadata_flag) {
+			ret = consumer_create_index_file(stream);
+			if (ret < 0) {
+				goto error;
+			}
+		}
 	}
 
 	if (stream->output == LTTNG_EVENT_MMAP) {
diff --git a/src/common/kernel-ctl/kernel-ctl.c b/src/common/kernel-ctl/kernel-ctl.c
index d850f38..495301e 100644
--- a/src/common/kernel-ctl/kernel-ctl.c
+++ b/src/common/kernel-ctl/kernel-ctl.c
@@ -390,3 +390,39 @@ int kernctl_put_subbuf(int fd)
 {
 	return ioctl(fd, RING_BUFFER_PUT_SUBBUF);
 }
+
+/* Returns the timestamp begin of the current sub-buffer. */
+int kernctl_get_timestamp_begin(int fd, uint64_t *timestamp_begin)
+{
+	return ioctl(fd, LTTNG_RING_BUFFER_GET_TIMESTAMP_BEGIN, timestamp_begin);
+}
+
+/* Returns the timestamp end of the current sub-buffer. */
+int kernctl_get_timestamp_end(int fd, uint64_t *timestamp_end)
+{
+	return ioctl(fd, LTTNG_RING_BUFFER_GET_TIMESTAMP_END, timestamp_end);
+}
+
+/* Returns the number of discarded events in the current sub-buffer. */
+int kernctl_get_events_discarded(int fd, uint64_t *events_discarded)
+{
+	return ioctl(fd, LTTNG_RING_BUFFER_GET_EVENTS_DISCARDED, events_discarded);
+}
+
+/* Returns the content size in the current sub-buffer. */
+int kernctl_get_content_size(int fd, uint64_t *content_size)
+{
+	return ioctl(fd, LTTNG_RING_BUFFER_GET_CONTENT_SIZE, content_size);
+}
+
+/* Returns the packet size in the current sub-buffer. */
+int kernctl_get_packet_size(int fd, uint64_t *packet_size)
+{
+	return ioctl(fd, LTTNG_RING_BUFFER_GET_PACKET_SIZE, packet_size);
+}
+
+/* Returns the stream id of the current sub-buffer. */
+int kernctl_get_stream_id(int fd, uint64_t *stream_id)
+{
+	return ioctl(fd, LTTNG_RING_BUFFER_GET_STREAM_ID, stream_id);
+}
diff --git a/src/common/kernel-ctl/kernel-ctl.h b/src/common/kernel-ctl/kernel-ctl.h
index ea2aa58..badf609 100644
--- a/src/common/kernel-ctl/kernel-ctl.h
+++ b/src/common/kernel-ctl/kernel-ctl.h
@@ -67,4 +67,12 @@ int kernctl_put_subbuf(int fd);
 
 int kernctl_buffer_flush(int fd);
 
+/* index */
+int kernctl_get_timestamp_begin(int fd, uint64_t *timestamp_begin);
+int kernctl_get_timestamp_end(int fd, uint64_t *timestamp_end);
+int kernctl_get_events_discarded(int fd, uint64_t *events_discarded);
+int kernctl_get_content_size(int fd, uint64_t *content_size);
+int kernctl_get_packet_size(int fd, uint64_t *packet_size);
+int kernctl_get_stream_id(int fd, uint64_t *stream_id);
+
 #endif /* _LTTNG_KERNEL_CTL_H */
diff --git a/src/common/kernel-ctl/kernel-ioctl.h b/src/common/kernel-ctl/kernel-ioctl.h
index 75d6da0..1a3b169 100644
--- a/src/common/kernel-ctl/kernel-ioctl.h
+++ b/src/common/kernel-ctl/kernel-ioctl.h
@@ -47,6 +47,19 @@
 /* flush the current sub-buffer */
 #define RING_BUFFER_FLUSH                   _IO(0xF6, 0x0C)
 
+/* returns the timestamp begin of the current sub-buffer */
+#define LTTNG_RING_BUFFER_GET_TIMESTAMP_BEGIN     _IOR(0xF6, 0x20, uint64_t)
+/* returns the timestamp end of the current sub-buffer */
+#define LTTNG_RING_BUFFER_GET_TIMESTAMP_END       _IOR(0xF6, 0x21, uint64_t)
+/* returns the number of events discarded */
+#define LTTNG_RING_BUFFER_GET_EVENTS_DISCARDED    _IOR(0xF6, 0x22, uint64_t)
+/* returns the packet payload size */
+#define LTTNG_RING_BUFFER_GET_CONTENT_SIZE        _IOR(0xF6, 0x23, uint64_t)
+/* returns the actual packet size */
+#define LTTNG_RING_BUFFER_GET_PACKET_SIZE         _IOR(0xF6, 0x24, uint64_t)
+/* returns the stream id */
+#define LTTNG_RING_BUFFER_GET_STREAM_ID           _IOR(0xF6, 0x25, uint64_t)
+
 /* Old ABI (without support for 32/64 bits compat) */
 /* LTTng file descriptor ioctl */
 #define LTTNG_KERNEL_OLD_SESSION                _IO(0xF6, 0x40)
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index 9612b9a..d884815 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -1573,6 +1573,58 @@ void lttng_ustconsumer_del_stream(struct lttng_consumer_stream *stream)
 	ustctl_destroy_stream(stream->ustream);
 }
 
+static int get_index_values(struct lttng_packet_index *index,
+		struct ustctl_consumer_stream *ustream)
+{
+	int ret;
+
+	ret = ustctl_get_timestamp_begin(ustream, &index->timestamp_begin);
+	if (ret < 0) {
+		PERROR("ustctl_get_timestamp_begin");
+		goto error;
+	}
+	index->timestamp_begin = htobe64(index->timestamp_begin);
+
+	ret = ustctl_get_timestamp_end(ustream, &index->timestamp_end);
+	if (ret < 0) {
+		PERROR("ustctl_get_timestamp_end");
+		goto error;
+	}
+	index->timestamp_end = htobe64(index->timestamp_end);
+
+	ret = ustctl_get_events_discarded(ustream, &index->events_discarded);
+	if (ret < 0) {
+		PERROR("ustctl_get_events_discarded");
+		goto error;
+	}
+	index->events_discarded = htobe64(index->events_discarded);
+
+	ret = ustctl_get_content_size(ustream, &index->content_size);
+	if (ret < 0) {
+		PERROR("ustctl_get_content_size");
+		goto error;
+	}
+	index->content_size = htobe64(index->content_size);
+
+	ret = ustctl_get_packet_size(ustream, &index->packet_size);
+	if (ret < 0) {
+		PERROR("ustctl_get_packet_size");
+		goto error;
+	}
+	index->packet_size = htobe64(index->packet_size);
+
+	ret = ustctl_get_stream_id(ustream, &index->stream_id);
+	if (ret < 0) {
+		PERROR("ustctl_get_stream_id");
+		goto error;
+	}
+	index->stream_id = htobe64(index->stream_id);
+
+error:
+	return ret;
+}
+
+
 int lttng_ustconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
 		struct lttng_consumer_local_data *ctx)
 {
@@ -1581,6 +1633,7 @@ int lttng_ustconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
 	long ret = 0;
 	char dummy;
 	struct ustctl_consumer_stream *ustream;
+	struct lttng_packet_index index;
 
 	assert(stream);
 	assert(stream->ustream);
@@ -1649,6 +1702,15 @@ retry:
 		goto end;
 	}
 	assert(stream->chan->output == CONSUMER_CHANNEL_MMAP);
+
+	if (!stream->metadata_flag) {
+		index.offset = htobe64(stream->out_fd_offset);
+		ret = get_index_values(&index, ustream);
+		if (ret < 0) {
+			goto end;
+		}
+	}
+
 	/* Get the full padded subbuffer size */
 	err = ustctl_get_padded_subbuf_size(ustream, &len);
 	assert(err == 0);
@@ -1684,6 +1746,20 @@ retry:
 	err = ustctl_put_next_subbuf(ustream);
 	assert(err == 0);
 
+	if (stream->index_fd < 0) {
+		ret = 0;
+		goto end;
+	}
+
+	do {
+		ret = write(stream->index_fd, &index, sizeof(index));
+	} while (ret < 0 && errno == EINTR);
+	if (ret < 0) {
+		PERROR("Writing index file");
+		goto end;
+	}
+	ret = 0;
+
 end:
 	return ret;
 }
@@ -1709,6 +1785,13 @@ int lttng_ustconsumer_on_recv_stream(struct lttng_consumer_stream *stream)
 		}
 		stream->out_fd = ret;
 		stream->tracefile_size_current = 0;
+
+		if (!stream->metadata_flag) {
+			ret = consumer_create_index_file(stream);
+			if (ret < 0) {
+				goto error;
+			}
+		}
 	}
 	ret = 0;
 
-- 
1.7.10.4
