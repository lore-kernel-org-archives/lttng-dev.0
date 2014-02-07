From: David Goulet <dgoulet@efficios.com>
Subject: [PATCH 1/2] Fix: read subbuffer mmap signedness issue
Date: Fri,  7 Feb 2014 15:42:39 -0500
Message-ID: <1391805760-30421-1-git-send-email-dgoulet__15157.6838725761$1391805838$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WBsGF-0002LL-PO
	for lttng-dev@lists.lttng.org; Fri, 07 Feb 2014 15:43:02 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed and unsigned values were compared thus making the code path where
ret = -1 being interpreted as ret > len == true thus not cleaning up the
relayd.

This patch simplifies the read subbuffer mmap operation since
lttng_write() now provides a guarantee that the return data is either
equal to the count passed or less which the later means the endpoint has
stop working.

Signed-off-by: David Goulet <dgoulet@efficios.com>
---
 src/common/consumer.c | 82 +++++++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 35 deletions(-)

diff --git a/src/common/consumer.c b/src/common/consumer.c
index 36ec024..59d4366 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -1451,7 +1451,7 @@ ssize_t lttng_consumer_on_read_subbuffer_mmap(
 {
 	unsigned long mmap_offset;
 	void *mmap_base;
-	ssize_t ret = 0, written = 0;
+	ssize_t ret = 0, written = 0, signed_len;
 	off_t orig_offset = stream->out_fd_offset;
 	/* Default is on the disk */
 	int outfd = stream->out_fd;
@@ -1584,44 +1584,56 @@ ssize_t lttng_consumer_on_read_subbuffer_mmap(
 		}
 	}
 
-	while (len > 0) {
-		ret = lttng_write(outfd, mmap_base + mmap_offset, len);
-		DBG("Consumer mmap write() ret %zd (len %lu)", ret, len);
-		if (ret < len) {
-			/*
-			 * This is possible if the fd is closed on the other side (outfd)
-			 * or any write problem. It can be verbose a bit for a normal
-			 * execution if for instance the relayd is stopped abruptly. This
-			 * can happen so set this to a DBG statement.
-			 */
-			DBG("Error in file write mmap");
-			if (written == 0) {
-				written = -errno;
-			}
-			/* Socket operation failed. We consider the relayd dead */
-			if (errno == EPIPE || errno == EINVAL) {
-				relayd_hang_up = 1;
-				goto write_error;
-			}
-			goto end;
-		} else if (ret > len) {
-			PERROR("Error in file write (ret %zd > len %lu)", ret, len);
-			written += ret;
-			goto end;
+	/*
+	 * Set the len value to a signed value so the if/else statement can
+	 * evaluate it against the signed returned value from lttng_write since
+	 * -1 can be returned indicating a communication failure.
+	 */
+	signed_len = len;
+
+	/*
+	 * This call guarantee that len or less is returned. It's impossible to
+	 * receive a ret value that is bigger than len.
+	 */
+	ret = lttng_write(outfd, mmap_base + mmap_offset, len);
+	DBG("Consumer mmap write() ret %zd (len %lu)", ret, len);
+	if (ret != signed_len) {
+		/*
+		 * Report error to caller if nothing was written else at least send the
+		 * amount written.
+		 */
+		if (ret < 0) {
+			written = -errno;
 		} else {
-			len -= ret;
-			mmap_offset += ret;
+			written = ret;
 		}
 
-		/* This call is useless on a socket so better save a syscall. */
-		if (!relayd) {
-			/* This won't block, but will start writeout asynchronously */
-			lttng_sync_file_range(outfd, stream->out_fd_offset, ret,
-					SYNC_FILE_RANGE_WRITE);
-			stream->out_fd_offset += ret;
+		/* Socket operation failed. We consider the relayd dead */
+		if (errno == EPIPE || errno == EINVAL) {
+			/*
+			 * This is possible if the fd is closed on the other side
+			 * (outfd) or any write problem. It can be verbose a bit for a
+			 * normal execution if for instance the relayd is stopped
+			 * abruptly. This can happen so set this to a DBG statement.
+			 */
+			DBG("Consumer mmap write detected relayd hang up");
+			relayd_hang_up = 1;
+			goto write_error;
 		}
-		stream->output_written += ret;
-		written += ret;
+
+		/* Unhandled error, print it and stop function right now. */
+		PERROR("Error in write mmap (ret %zd < len %lu)", ret, len);
+		goto end;
+	}
+	stream->output_written += ret;
+	written = ret;
+
+	/* This call is useless on a socket so better save a syscall. */
+	if (!relayd) {
+		/* This won't block, but will start writeout asynchronously */
+		lttng_sync_file_range(outfd, stream->out_fd_offset, len,
+				SYNC_FILE_RANGE_WRITE);
+		stream->out_fd_offset += len;
 	}
 	lttng_consumer_sync_trace_file(stream, orig_offset);
 
-- 
1.8.5.3
