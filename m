From: David Goulet <dgoulet@efficios.com>
Subject: [PATCH 2/2] Fix: read subbuffer splice signedness issue
Date: Fri,  7 Feb 2014 15:42:40 -0500
Message-ID: <1391805760-30421-2-git-send-email-dgoulet__46404.3130785742$1391805934$gmane$org@efficios.com>
References: <1391805760-30421-1-git-send-email-dgoulet@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WBsGJ-0002LM-A8
	for lttng-dev@lists.lttng.org; Fri, 07 Feb 2014 15:43:05 -0500
In-Reply-To: <1391805760-30421-1-git-send-email-dgoulet@efficios.com>
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

Same issue as the previous fix in the mmap read subbuffer. However, this
patch keeps looping on the len since splice() does NOT give any
guarantee that it will splice the full count.

Signed-off-by: David Goulet <dgoulet@efficios.com>
---
 src/common/consumer.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/src/common/consumer.c b/src/common/consumer.c
index 59d4366..798e22e 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -1796,17 +1796,24 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
 	}
 
 	while (len > 0) {
+		/*
+		 * Set the len value to a signed value so the if/else statement can
+		 * evaluate it against the signed returned value from lttng_write since
+		 * -1 can be returned indicating a communication failure.
+		 */
+		ssize_t signed_len = len;
+
 		DBG("splice chan to pipe offset %lu of len %lu (fd : %d, pipe: %d)",
 				(unsigned long)offset, len, fd, splice_pipe[1]);
 		ret_splice = splice(fd, &offset, splice_pipe[1], NULL, len,
 				SPLICE_F_MOVE | SPLICE_F_MORE);
 		DBG("splice chan to pipe, ret %zd", ret_splice);
-		if (ret_splice < 0) {
-			PERROR("Error in relay splice");
+		if (ret_splice < signed_len) {
+			ret = errno;
 			if (written == 0) {
 				written = ret_splice;
 			}
-			ret = errno;
+			PERROR("Error in relay splice");
 			goto splice_error;
 		}
 
@@ -1824,6 +1831,8 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
 				 * argument to this function.
 				 */
 				written -= metadata_payload_size;
+				/* Take back a signed reference of the updated len. */
+				signed_len = len;
 			}
 		}
 
@@ -1831,28 +1840,33 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
 		ret_splice = splice(splice_pipe[0], NULL, outfd, NULL,
 				ret_splice, SPLICE_F_MOVE | SPLICE_F_MORE);
 		DBG("Consumer splice pipe to file, ret %zd", ret_splice);
-		if (ret_splice < 0) {
-			PERROR("Error in file splice");
+		if (ret_splice < signed_len) {
+			ret = errno;
 			if (written == 0) {
 				written = ret_splice;
 			}
 			/* Socket operation failed. We consider the relayd dead */
-			if (errno == EBADF || errno == EPIPE) {
+			if (errno == EBADF || errno == EPIPE || errno == ESPIPE) {
 				WARN("Remote relayd disconnected. Stopping");
 				relayd_hang_up = 1;
 				goto write_error;
 			}
-			ret = errno;
+			PERROR("Error in file splice");
 			goto splice_error;
-		} else if (ret_splice > len) {
-			errno = EINVAL;
-			PERROR("Wrote more data than requested %zd (len: %lu)",
-					ret_splice, len);
+		} else if (ret_splice > signed_len) {
+			/*
+			 * We don't expect this code path to be executed but you never know
+			 * so this is an extra protection agains a buggy splice().
+			 */
 			written += ret_splice;
 			ret = errno;
+			PERROR("Wrote more data than requested %zd (len: %lu)", ret_splice,
+					len);
 			goto splice_error;
+		} else {
+			/* All good, update current len and continue. */
+			len -= ret_splice;
 		}
-		len -= ret_splice;
 
 		/* This call is useless on a socket so better save a syscall. */
 		if (!relayd) {
@@ -1865,9 +1879,6 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
 		written += ret_splice;
 	}
 	lttng_consumer_sync_trace_file(stream, orig_offset);
-
-	ret = ret_splice;
-
 	goto end;
 
 write_error:
-- 
1.8.5.3
