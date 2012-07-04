From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH lttng-tools] Fix mmap for large subbuffers
	and handle	EINTR
Date: Wed, 4 Jul 2012 12:10:09 -0400
Message-ID: <20120704161009.GA27758__1743.64616764269$1341418247$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SmS9b-0004Q2-KX
	for lttng-dev@lists.lttng.org; Wed, 04 Jul 2012 12:10:11 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com, jdesfossez@efficios.com, christian.babeux@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

With large subbuffer (packet) size, if write() returns before copying
the entire packet for mmap buffers, the consumerd restarts the write
infinitely, which is not good at all.

This affects both lttng-ust (in default mmap mode) and lttng-kernel (but
only for mmap buffers, which is not the default).

This issue would show up with large subbuffer size.

We need to handle this case, as well as EINTR errors (which need to
restart write).

Also fixing the return value of mmap read functions, which were
returning the amount of data written by the last invocation of write()
rather than the total number of bytes written. splice use had the same
issue.

Also now consider a write() that returns more bytes than requested as an
error.

Moreover, assigning error = ret after failed splice and write was a
mistake: error is holding the actual error value. ret just holds -1.

This needs testing. Feedback is welcome.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index bbc31f8..eca710d 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -49,7 +49,7 @@ ssize_t lttng_kconsumer_on_read_subbuffer_mmap(
 		struct lttng_consumer_stream *stream, unsigned long len)
 {
 	unsigned long mmap_offset;
-	ssize_t ret = 0;
+	ssize_t ret = 0, written = 0;
 	off_t orig_offset = stream->out_fd_offset;
 	int fd = stream->wait_fd;
 	int outfd = stream->out_fd;
@@ -64,25 +64,34 @@ ssize_t lttng_kconsumer_on_read_subbuffer_mmap(
 
 	while (len > 0) {
 		ret = write(outfd, stream->mmap_base + mmap_offset, len);
-		if (ret >= len) {
-			len = 0;
-		} else if (ret < 0) {
-			errno = -ret;
+		if (ret < 0) {
+			if (errno == EINTR) {
+				/* restart the interrupted system call */
+				continue;
+			} else {
+				perror("Error in file write");
+				if (written == 0) {
+					written = ret;
+				}
+				goto end;
+			}
+		} else if (ret > len) {
 			perror("Error in file write");
+			written += ret;
 			goto end;
+		} else {
+			len -= ret;
+			mmap_offset += ret;
 		}
 		/* This won't block, but will start writeout asynchronously */
 		lttng_sync_file_range(outfd, stream->out_fd_offset, ret,
 				SYNC_FILE_RANGE_WRITE);
 		stream->out_fd_offset += ret;
+		written += ret;
 	}
-
 	lttng_consumer_sync_trace_file(stream, orig_offset);
-
-	goto end;
-
 end:
-	return ret;
+	return written;
 }
 
 /*
@@ -94,7 +103,7 @@ ssize_t lttng_kconsumer_on_read_subbuffer_splice(
 		struct lttng_consumer_local_data *ctx,
 		struct lttng_consumer_stream *stream, unsigned long len)
 {
-	ssize_t ret = 0;
+	ssize_t ret = 0, written = 0;
 	loff_t offset = 0;
 	off_t orig_offset = stream->out_fd_offset;
 	int fd = stream->wait_fd;
@@ -107,8 +116,11 @@ ssize_t lttng_kconsumer_on_read_subbuffer_splice(
 				SPLICE_F_MOVE | SPLICE_F_MORE);
 		DBG("splice chan to pipe ret %zd", ret);
 		if (ret < 0) {
-			errno = -ret;
 			perror("Error in relay splice");
+			if (written == 0) {
+				written = ret;
+			}
+			ret = errno;
 			goto splice_error;
 		}
 
@@ -116,8 +128,18 @@ ssize_t lttng_kconsumer_on_read_subbuffer_splice(
 				SPLICE_F_MOVE | SPLICE_F_MORE);
 		DBG("splice pipe to file %zd", ret);
 		if (ret < 0) {
-			errno = -ret;
 			perror("Error in file splice");
+			if (written == 0) {
+				written = ret;
+			}
+			ret = errno;
+			goto splice_error;
+		}
+		if (ret > len) {
+			errno = EINVAL;
+			perror("Wrote more data than requested");
+			written += ret;
+			ret = errno;
 			goto splice_error;
 		}
 		len -= ret;
@@ -125,6 +147,7 @@ ssize_t lttng_kconsumer_on_read_subbuffer_splice(
 		lttng_sync_file_range(outfd, stream->out_fd_offset, ret,
 				SYNC_FILE_RANGE_WRITE);
 		stream->out_fd_offset += ret;
+		written += ret;
 	}
 	lttng_consumer_sync_trace_file(stream, orig_offset);
 
@@ -132,7 +155,7 @@ ssize_t lttng_kconsumer_on_read_subbuffer_splice(
 
 splice_error:
 	/* send the appropriate error description to sessiond */
-	switch(ret) {
+	switch (ret) {
 	case EBADF:
 		lttng_consumer_send_error(ctx, CONSUMERD_SPLICE_EBADF);
 		break;
@@ -148,7 +171,7 @@ splice_error:
 	}
 
 end:
-	return ret;
+	return written;
 }
 
 /*
@@ -351,13 +374,14 @@ ssize_t lttng_kconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
 
 			/* splice the subbuffer to the tracefile */
 			ret = lttng_consumer_on_read_subbuffer_splice(ctx, stream, len);
-			if (ret < 0) {
+			if (ret != len) {
 				/*
 				 * display the error but continue processing to try
 				 * to release the subbuffer
 				 */
 				ERR("Error splicing to tracefile");
 			}
+
 			break;
 		case LTTNG_EVENT_MMAP:
 			/* read the used subbuffer size */
@@ -369,7 +393,7 @@ ssize_t lttng_kconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
 			}
 			/* write the subbuffer to the tracefile */
 			ret = lttng_consumer_on_read_subbuffer_mmap(ctx, stream, len);
-			if (ret < 0) {
+			if (ret != len) {
 				/*
 				 * display the error but continue processing to try
 				 * to release the subbuffer
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index 2b55fd4..4db39d8 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -49,7 +49,7 @@ ssize_t lttng_ustconsumer_on_read_subbuffer_mmap(
 		struct lttng_consumer_stream *stream, unsigned long len)
 {
 	unsigned long mmap_offset;
-	long ret = 0;
+	long ret = 0, written = 0;
 	off_t orig_offset = stream->out_fd_offset;
 	int outfd = stream->out_fd;
 
@@ -63,25 +63,34 @@ ssize_t lttng_ustconsumer_on_read_subbuffer_mmap(
 	}
 	while (len > 0) {
 		ret = write(outfd, stream->mmap_base + mmap_offset, len);
-		if (ret >= len) {
-			len = 0;
-		} else if (ret < 0) {
-			errno = -ret;
-			PERROR("Error in file write");
+		if (ret < 0) {
+			if (errno == EINTR) {
+				/* restart the interrupted system call */
+				continue;
+			} else {
+				perror("Error in file write");
+				if (written == 0) {
+					written = ret;
+				}
+				goto end;
+			}
+		} else if (ret > len) {
+			perror("Error in file write");
+			written += ret;
 			goto end;
+		} else {
+			len -= ret;
+			mmap_offset += ret;
 		}
 		/* This won't block, but will start writeout asynchronously */
 		lttng_sync_file_range(outfd, stream->out_fd_offset, ret,
 				SYNC_FILE_RANGE_WRITE);
 		stream->out_fd_offset += ret;
+		written += ret;
 	}
-
 	lttng_consumer_sync_trace_file(stream, orig_offset);
-
-	goto end;
-
 end:
-	return ret;
+	return written;
 }
 
 /*
@@ -384,7 +393,7 @@ int lttng_ustconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
 	assert(err == 0);
 	/* write the subbuffer to the tracefile */
 	ret = lttng_consumer_on_read_subbuffer_mmap(ctx, stream, len);
-	if (ret < 0) {
+	if (ret != len) {
 		/*
 		 * display the error but continue processing to try
 		 * to release the subbuffer

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
