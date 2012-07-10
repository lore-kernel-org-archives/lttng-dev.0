From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH lttng-tools] kernel consumer should empty
	the input	splice pipe
Date: Mon, 9 Jul 2012 20:09:31 -0400
Message-ID: <20120710000931.GA28343__14799.4364066564$1341879001$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SoO1F-0002PI-Jn
	for lttng-dev@lists.lttng.org; Mon, 09 Jul 2012 20:09:33 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com, jdesfossez@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

When the splice pipe output cannot push all the data placed into the
pipe by the first splice call, we should continue writing data out to
the output file descriptor until we reach the amount of data that was
placed into the pipe.

This is probably the cause of the network streaming issues currently
encountered.

Testing is welcome.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
index bbc31f8..cc16f9f 100644
--- a/src/common/kernel-consumer/kernel-consumer.c
+++ b/src/common/kernel-consumer/kernel-consumer.c
@@ -101,6 +101,8 @@ ssize_t lttng_kconsumer_on_read_subbuffer_splice(
 	int outfd = stream->out_fd;
 
 	while (len > 0) {
+		ssize_t tosplice;
+
 		DBG("splice chan to pipe offset %lu (fd : %d)",
 				(unsigned long)offset, fd);
 		ret = splice(fd, &offset, ctx->consumer_thread_pipe[1], NULL, len,
@@ -111,20 +113,28 @@ ssize_t lttng_kconsumer_on_read_subbuffer_splice(
 			perror("Error in relay splice");
 			goto splice_error;
 		}
-
-		ret = splice(ctx->consumer_thread_pipe[0], NULL, outfd, NULL, ret,
-				SPLICE_F_MOVE | SPLICE_F_MORE);
-		DBG("splice pipe to file %zd", ret);
-		if (ret < 0) {
-			errno = -ret;
-			perror("Error in file splice");
-			goto splice_error;
+		tosplice = ret;
+		len -= tosplice;
+
+		while (tosplice > 0) {
+			ret = splice(ctx->consumer_thread_pipe[0], NULL, outfd,
+					NULL, tosplice,
+					SPLICE_F_MOVE | SPLICE_F_MORE);
+			DBG("splice pipe to file %zd", ret);
+			if (ret < 0) {
+				errno = -ret;
+				perror("Error in file splice");
+				goto splice_error;
+			}
+			tosplice -= ret;
+			/*
+			 * This won't block, but will start writeout
+			 * asynchronously.
+			 */
+			lttng_sync_file_range(outfd, stream->out_fd_offset, ret,
+					SYNC_FILE_RANGE_WRITE);
+			stream->out_fd_offset += ret;
 		}
-		len -= ret;
-		/* This won't block, but will start writeout asynchronously */
-		lttng_sync_file_range(outfd, stream->out_fd_offset, ret,
-				SYNC_FILE_RANGE_WRITE);
-		stream->out_fd_offset += ret;
 	}
 	lttng_consumer_sync_trace_file(stream, orig_offset);
 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
