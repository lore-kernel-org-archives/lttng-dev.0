From: David Goulet <dgoulet@efficios.com>
Subject: [lttng-tools PATCH] Don't send the subbuffer padding
	for streaming
Date: Thu, 13 Sep 2012 14:25:15 -0400
Message-ID: <1347560715-18710-1-git-send-email-dgoulet__35367.1875935563$1347565424$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TCFJB-0001CM-UD
	for lttng-dev@lists.lttng.org; Thu, 13 Sep 2012 15:42:42 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: David Goulet <dgoulet@efficios.com>
List-Id: lttng-dev@lists.lttng.org

For network streaming, with the mmap() mechanism only for now, the
consumer does NOT send the padding over the network. Instead, the size
of the padding is specified in the data header or metadata payload.

The lttng-relayd now is the one appending the zeros to the trace files.

Again, this functionnality is NOT available yet for splice output.

Signed-off-by: David Goulet <dgoulet@efficios.com>
---
 src/bin/lttng-relayd/main.c                  |   39 ++++++++++
 src/common/consumer.c                        |   97 ++++++++++++++----------
 src/common/consumer.h                        |    6 +-
 src/common/kernel-consumer/kernel-consumer.c |  105 +++++++++++++++-----------
 src/common/sessiond-comm/relayd.h            |    2 +
 src/common/ust-consumer/ust-consumer.c       |   19 +++--
 src/common/ust-consumer/ust-consumer.h       |    6 +-
 7 files changed, 183 insertions(+), 91 deletions(-)

diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index e9b70a3..f60199b 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -1145,6 +1145,31 @@ end:
 }
 
 /*
+ * Append padding to the file pointed by the file descriptor fd.
+ */
+static int write_padding_to_file(int fd, uint32_t size)
+{
+	int ret = 0;
+	char zeros[size];
+
+	if (size == 0) {
+		goto end;
+	}
+
+	memset(zeros, 0, size);
+
+	do {
+		ret = write(fd, zeros, size);
+	} while (ret < 0 && errno == EINTR);
+	if (ret < 0) {
+		PERROR("write padding to file");
+	}
+
+end:
+	return ret;
+}
+
+/*
  * relay_recv_metadata: receive the metada for the session.
  */
 static
@@ -1208,6 +1233,14 @@ int relay_recv_metadata(struct lttcomm_relayd_hdr *recv_hdr,
 		ret = -1;
 		goto end_unlock;
 	}
+
+
+	ret = write_padding_to_file(metadata_stream->fd,
+			be32toh(metadata_struct->padding_size));
+	if (ret < 0) {
+		goto end_unlock;
+	}
+
 	DBG2("Relay metadata written");
 
 end_unlock:
@@ -1357,6 +1390,12 @@ int relay_process_data(struct relay_command *cmd, struct lttng_ht *streams_ht)
 		ret = -1;
 		goto end_unlock;
 	}
+
+	ret = write_padding_to_file(stream->fd, be32toh(data_hdr.padding_size));
+	if (ret < 0) {
+		goto end_unlock;
+	}
+
 	DBG2("Relay wrote %d bytes to tracefile for stream id %" PRIu64,
 		ret, stream->stream_handle);
 
diff --git a/src/common/consumer.c b/src/common/consumer.c
index f093f0c..16a6c47 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -542,7 +542,8 @@ error:
  * Return destination file descriptor or negative value on error.
  */
 static int write_relayd_stream_header(struct lttng_consumer_stream *stream,
-		size_t data_size, struct consumer_relayd_sock_pair *relayd)
+		size_t data_size, unsigned long padding,
+		struct consumer_relayd_sock_pair *relayd)
 {
 	int outfd = -1, ret;
 	struct lttcomm_relayd_data_hdr data_hdr;
@@ -567,6 +568,7 @@ static int write_relayd_stream_header(struct lttng_consumer_stream *stream,
 		/* Set header with stream information */
 		data_hdr.stream_id = htobe64(stream->relayd_stream_id);
 		data_hdr.data_size = htobe32(data_size);
+		data_hdr.padding_size = htobe32(padding);
 		data_hdr.net_seq_num = htobe64(stream->next_net_seq_num++);
 		/* Other fields are zeroed previously */
 
@@ -1094,22 +1096,23 @@ void lttng_consumer_destroy(struct lttng_consumer_local_data *ctx)
  */
 static int write_relayd_metadata_id(int fd,
 		struct lttng_consumer_stream *stream,
-		struct consumer_relayd_sock_pair *relayd)
+		struct consumer_relayd_sock_pair *relayd,
+		unsigned long padding)
 {
 	int ret;
-	uint64_t metadata_id;
+	struct lttcomm_relayd_metadata_payload hdr;
 
-	metadata_id = htobe64(stream->relayd_stream_id);
+	hdr.stream_id = htobe64(stream->relayd_stream_id);
+	hdr.padding_size = htobe32(padding);
 	do {
-		ret = write(fd, (void *) &metadata_id,
-				sizeof(stream->relayd_stream_id));
+		ret = write(fd, (void *) &hdr, sizeof(hdr));
 	} while (ret < 0 && errno == EINTR);
 	if (ret < 0) {
 		PERROR("write metadata stream id");
 		goto end;
 	}
-	DBG("Metadata stream id %" PRIu64 " written before data",
-			stream->relayd_stream_id);
+	DBG("Metadata stream id %" PRIu64 " with padding %lu written before data",
+			stream->relayd_stream_id, padding);
 
 end:
 	return ret;
@@ -1126,7 +1129,8 @@ end:
  */
 ssize_t lttng_consumer_on_read_subbuffer_mmap(
 		struct lttng_consumer_local_data *ctx,
-		struct lttng_consumer_stream *stream, unsigned long len)
+		struct lttng_consumer_stream *stream, unsigned long len,
+		unsigned long padding)
 {
 	unsigned long mmap_offset;
 	ssize_t ret = 0, written = 0;
@@ -1178,17 +1182,17 @@ ssize_t lttng_consumer_on_read_subbuffer_mmap(
 		if (stream->metadata_flag) {
 			/* Metadata requires the control socket. */
 			pthread_mutex_lock(&relayd->ctrl_sock_mutex);
-			netlen += sizeof(stream->relayd_stream_id);
+			netlen += sizeof(struct lttcomm_relayd_metadata_payload);
 		}
 
-		ret = write_relayd_stream_header(stream, netlen, relayd);
+		ret = write_relayd_stream_header(stream, netlen, padding, relayd);
 		if (ret >= 0) {
 			/* Use the returned socket. */
 			outfd = ret;
 
 			/* Write metadata stream id before payload */
 			if (stream->metadata_flag) {
-				ret = write_relayd_metadata_id(outfd, stream, relayd);
+				ret = write_relayd_metadata_id(outfd, stream, relayd, padding);
 				if (ret < 0) {
 					written = ret;
 					goto end;
@@ -1196,12 +1200,16 @@ ssize_t lttng_consumer_on_read_subbuffer_mmap(
 			}
 		}
 		/* Else, use the default set before which is the filesystem. */
+	} else {
+		/* No streaming, we have to set the len with the full padding */
+		len += padding;
 	}
 
 	while (len > 0) {
 		do {
 			ret = write(outfd, stream->mmap_base + mmap_offset, len);
 		} while (ret < 0 && errno == EINTR);
+		DBG("Consumer mmap write() ret %zd (len %lu)", ret, len);
 		if (ret < 0) {
 			PERROR("Error in file write");
 			if (written == 0) {
@@ -1216,7 +1224,6 @@ ssize_t lttng_consumer_on_read_subbuffer_mmap(
 			len -= ret;
 			mmap_offset += ret;
 		}
-		DBG("Consumer mmap write() ret %zd (len %lu)", ret, len);
 
 		/* This call is useless on a socket so better save a syscall. */
 		if (!relayd) {
@@ -1246,7 +1253,8 @@ end:
  */
 ssize_t lttng_consumer_on_read_subbuffer_splice(
 		struct lttng_consumer_local_data *ctx,
-		struct lttng_consumer_stream *stream, unsigned long len)
+		struct lttng_consumer_stream *stream, unsigned long len,
+		unsigned long padding)
 {
 	ssize_t ret = 0, written = 0, ret_splice = 0;
 	loff_t offset = 0;
@@ -1292,23 +1300,42 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
 	}
 
 	/* Write metadata stream id before payload */
-	if (stream->metadata_flag && relayd) {
-		/*
-		 * Lock the control socket for the complete duration of the function
-		 * since from this point on we will use the socket.
-		 */
-		pthread_mutex_lock(&relayd->ctrl_sock_mutex);
+	if (relayd) {
+		int total_len = len;
 
-		ret = write_relayd_metadata_id(splice_pipe[1], stream, relayd);
-		if (ret < 0) {
-			written = ret;
+		if (stream->metadata_flag) {
+			/*
+			 * Lock the control socket for the complete duration of the function
+			 * since from this point on we will use the socket.
+			 */
+			pthread_mutex_lock(&relayd->ctrl_sock_mutex);
+
+			ret = write_relayd_metadata_id(splice_pipe[1], stream, relayd,
+					padding);
+			if (ret < 0) {
+				written = ret;
+				goto end;
+			}
+
+			total_len += sizeof(struct lttcomm_relayd_metadata_payload);
+		}
+
+		ret = write_relayd_stream_header(stream, total_len, padding, relayd);
+		if (ret >= 0) {
+			/* Use the returned socket. */
+			outfd = ret;
+		} else {
+			ERR("Remote relayd disconnected. Stopping");
 			goto end;
 		}
+	} else {
+		/* No streaming, we have to set the len with the full padding */
+		len += padding;
 	}
 
 	while (len > 0) {
-		DBG("splice chan to pipe offset %lu of len %lu (fd : %d)",
-				(unsigned long)offset, len, fd);
+		DBG("splice chan to pipe offset %lu of len %lu (fd : %d, pipe: %d)",
+				(unsigned long)offset, len, fd, splice_pipe[1]);
 		ret_splice = splice(fd, &offset, splice_pipe[1], NULL, len,
 				SPLICE_F_MOVE | SPLICE_F_MORE);
 		DBG("splice chan to pipe, ret %zd", ret_splice);
@@ -1324,30 +1351,24 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
 		/* Handle stream on the relayd if the output is on the network */
 		if (relayd) {
 			if (stream->metadata_flag) {
+				size_t metadata_payload_size =
+					sizeof(struct lttcomm_relayd_metadata_payload);
+
 				/* Update counter to fit the spliced data */
-				ret_splice += sizeof(stream->relayd_stream_id);
-				len += sizeof(stream->relayd_stream_id);
+				ret_splice += metadata_payload_size;
+				len += metadata_payload_size;
 				/*
 				 * We do this so the return value can match the len passed as
 				 * argument to this function.
 				 */
-				written -= sizeof(stream->relayd_stream_id);
-			}
-
-			ret = write_relayd_stream_header(stream, ret_splice, relayd);
-			if (ret >= 0) {
-				/* Use the returned socket. */
-				outfd = ret;
-			} else {
-				ERR("Remote relayd disconnected. Stopping");
-				goto end;
+				written -= metadata_payload_size;
 			}
 		}
 
 		/* Splice data out */
 		ret_splice = splice(splice_pipe[0], NULL, outfd, NULL,
 				ret_splice, SPLICE_F_MOVE | SPLICE_F_MORE);
-		DBG("Kernel consumer splice pipe to file, ret %zd", ret_splice);
+		DBG("Consumer splice pipe to file, ret %zd", ret_splice);
 		if (ret_splice < 0) {
 			PERROR("Error in file splice");
 			if (written == 0) {
diff --git a/src/common/consumer.h b/src/common/consumer.h
index e307b18..4da4b70 100644
--- a/src/common/consumer.h
+++ b/src/common/consumer.h
@@ -364,10 +364,12 @@ extern struct lttng_consumer_local_data *lttng_consumer_create(
 extern void lttng_consumer_destroy(struct lttng_consumer_local_data *ctx);
 extern ssize_t lttng_consumer_on_read_subbuffer_mmap(
 		struct lttng_consumer_local_data *ctx,
-		struct lttng_consumer_stream *stream, unsigned long len);
+		struct lttng_consumer_stream *stream, unsigned long len,
+		unsigned long padding);
 extern ssize_t lttng_consumer_on_read_subbuffer_splice(
 		struct lttng_consumer_local_data *ctx,
-		struct lttng_consumer_stream *stream, unsigned long len);
+		struct lttng_consumer_stream *stream, unsigned long len,
+		unsigned long padding);
 extern int lttng_consumer_take_snapshot(struct lttng_consumer_local_data *ctx,
 		struct lttng_consumer_stream *stream);
 extern int lttng_consumer_get_produced_snapshot(
diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index fe93c2e..56f3011 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -295,7 +295,7 @@ end_nosignal:
 ssize_t lttng_kconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
 		struct lttng_consumer_local_data *ctx)
 {
-	unsigned long len;
+	unsigned long len, subbuf_size, padding;
 	int err;
 	ssize_t ret = 0;
 	int infd = stream->wait_fd;
@@ -304,7 +304,7 @@ ssize_t lttng_kconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
 	/* Get the next subbuffer */
 	err = kernctl_get_next_subbuf(infd);
 	if (err != 0) {
-		ret = -err;
+		ret = err;
 		/*
 		 * This is a debug message even for single-threaded consumer,
 		 * because poll() have more relaxed criterions than get subbuf,
@@ -316,51 +316,68 @@ ssize_t lttng_kconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
 		goto end;
 	}
 
+	/* Get the full subbuffer size including padding */
+	err = kernctl_get_padded_subbuf_size(infd, &len);
+	if (err != 0) {
+		errno = -err;
+		perror("Getting sub-buffer len failed.");
+		ret = -err;
+		goto end;
+	}
+
 	switch (stream->output) {
-		case LTTNG_EVENT_SPLICE:
-			/* read the whole subbuffer */
-			err = kernctl_get_padded_subbuf_size(infd, &len);
-			if (err != 0) {
-				errno = -err;
-				perror("Getting sub-buffer len failed.");
-				ret = -err;
-				goto end;
-			}
+	case LTTNG_EVENT_SPLICE:
 
-			/* splice the subbuffer to the tracefile */
-			ret = lttng_consumer_on_read_subbuffer_splice(ctx, stream, len);
-			if (ret != len) {
-				/*
-				 * display the error but continue processing to try
-				 * to release the subbuffer
-				 */
-				ERR("Error splicing to tracefile (ret: %zd != len: %lu)",
-						ret, len);
-			}
+		/*
+		 * XXX: The lttng-modules splice "actor" does not handle copying
+		 * partial pages hence only using the subbuffer size without the
+		 * padding makes the splice fail.
+		 */
+		subbuf_size = len;
+		padding = 0;
+
+		/* splice the subbuffer to the tracefile */
+		ret = lttng_consumer_on_read_subbuffer_splice(ctx, stream,
+				subbuf_size, padding);
+		if (ret != subbuf_size) {
+			/*
+			 * display the error but continue processing to try
+			 * to release the subbuffer
+			 */
+			ERR("Error splicing to tracefile (ret: %zd != len: %lu)",
+					ret, subbuf_size);
+		}
+		break;
+	case LTTNG_EVENT_MMAP:
+		/* Get subbuffer size without padding */
+		err = kernctl_get_subbuf_size(infd, &subbuf_size);
+		if (err != 0) {
+			errno = -err;
+			perror("Getting sub-buffer len failed.");
+			ret = -err;
+			goto end;
+		}
 
-			break;
-		case LTTNG_EVENT_MMAP:
-			/* read the used subbuffer size */
-			err = kernctl_get_padded_subbuf_size(infd, &len);
-			if (err != 0) {
-				errno = -err;
-				perror("Getting sub-buffer len failed.");
-				ret = -err;
-				goto end;
-			}
-			/* write the subbuffer to the tracefile */
-			ret = lttng_consumer_on_read_subbuffer_mmap(ctx, stream, len);
-			if (ret != len) {
-				/*
-				 * display the error but continue processing to try
-				 * to release the subbuffer
-				 */
-				ERR("Error writing to tracefile");
-			}
-			break;
-		default:
-			ERR("Unknown output method");
-			ret = -1;
+		/* Make sure the tracer is not gone mad on us! */
+		assert(len >= subbuf_size);
+
+		padding = len - subbuf_size;
+
+		/* write the subbuffer to the tracefile */
+		ret = lttng_consumer_on_read_subbuffer_mmap(ctx, stream,
+				subbuf_size, padding);
+		if (ret != subbuf_size) {
+			/*
+			 * display the error but continue processing to try
+			 * to release the subbuffer
+			 */
+			ERR("Error writing to tracefile (ret: %zd != len: %lu",
+					ret, subbuf_size);
+		}
+		break;
+	default:
+		ERR("Unknown output method");
+		ret = -1;
 	}
 
 	err = kernctl_put_next_subbuf(infd);
diff --git a/src/common/sessiond-comm/relayd.h b/src/common/sessiond-comm/relayd.h
index 24b7c91..5d4fddf 100644
--- a/src/common/sessiond-comm/relayd.h
+++ b/src/common/sessiond-comm/relayd.h
@@ -49,6 +49,7 @@ struct lttcomm_relayd_data_hdr {
 	uint64_t stream_id;     /* Stream ID known by the relayd */
 	uint64_t net_seq_num;   /* Network sequence number, per stream. */
 	uint32_t data_size;     /* data size following this header */
+	uint32_t padding_size;  /* Size of 0 padding the data */
 } __attribute__ ((__packed__));
 
 /*
@@ -94,6 +95,7 @@ struct lttcomm_relayd_version {
  */
 struct lttcomm_relayd_metadata_payload {
 	uint64_t stream_id;
+	uint32_t padding_size;
 	char payload[];
 } __attribute__ ((__packed__));
 
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index 1544ddb..e7d6dd4 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -399,7 +399,7 @@ void lttng_ustconsumer_del_stream(struct lttng_consumer_stream *stream)
 int lttng_ustconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
 		struct lttng_consumer_local_data *ctx)
 {
-	unsigned long len;
+	unsigned long len, subbuf_size, padding;
 	int err;
 	long ret = 0;
 	struct lttng_ust_shm_handle *handle;
@@ -426,7 +426,7 @@ int lttng_ustconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
 	/* Get the next subbuffer */
 	err = ustctl_get_next_subbuf(handle, buf);
 	if (err != 0) {
-		ret = -err;	/* ustctl_get_next_subbuf returns negative, caller expect positive. */
+		ret = err;	/* ustctl_get_next_subbuf returns negative, caller expect positive. */
 		/*
 		 * This is a debug message even for single-threaded consumer,
 		 * because poll() have more relaxed criterions than get subbuf,
@@ -438,12 +438,21 @@ int lttng_ustconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
 		goto end;
 	}
 	assert(stream->output == LTTNG_EVENT_MMAP);
-	/* read the used subbuffer size */
+	/* Get the full padded subbuffer size */
 	err = ustctl_get_padded_subbuf_size(handle, buf, &len);
 	assert(err == 0);
+
+	/* Get subbuffer data size (without padding) */
+	err = ustctl_get_subbuf_size(handle, buf, &subbuf_size);
+	assert(err == 0);
+
+	/* Make sure we don't get a subbuffer size bigger than the padded */
+	assert(len >= subbuf_size);
+
+	padding = len - subbuf_size;
 	/* write the subbuffer to the tracefile */
-	ret = lttng_consumer_on_read_subbuffer_mmap(ctx, stream, len);
-	if (ret != len) {
+	ret = lttng_consumer_on_read_subbuffer_mmap(ctx, stream, subbuf_size, padding);
+	if (ret != subbuf_size) {
 		/*
 		 * display the error but continue processing to try
 		 * to release the subbuffer
diff --git a/src/common/ust-consumer/ust-consumer.h b/src/common/ust-consumer/ust-consumer.h
index 7e055a9..3f76f23 100644
--- a/src/common/ust-consumer/ust-consumer.h
+++ b/src/common/ust-consumer/ust-consumer.h
@@ -67,7 +67,8 @@ extern int lttng_ustctl_get_mmap_read_offset(
 static inline
 ssize_t lttng_ustconsumer_on_read_subbuffer_mmap(
 		struct lttng_consumer_local_data *ctx,
-		struct lttng_consumer_stream *stream, unsigned long len)
+		struct lttng_consumer_stream *stream, unsigned long len,
+		unsigned long padding)
 {
 	return -ENOSYS;
 }
@@ -75,7 +76,8 @@ ssize_t lttng_ustconsumer_on_read_subbuffer_mmap(
 static inline
 ssize_t lttng_ustconsumer_on_read_subbuffer_splice(
 		struct lttng_consumer_local_data *ctx,
-		struct lttng_consumer_stream *uststream, unsigned long len)
+		struct lttng_consumer_stream *uststream, unsigned long len,
+		unsigned long padding)
 {
 	return -ENOSYS;
 }
-- 
1.7.10.4
