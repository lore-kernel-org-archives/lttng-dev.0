From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: consumer data pending for
	empty streams
Date: Wed, 28 Aug 2013 22:47:20 -0400
Message-ID: <20130829024720.GA20271__33720.5626572997$1377744494$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VEsGX-0005WJ-Rr
	for lttng-dev@lists.lttng.org; Wed, 28 Aug 2013 22:47:24 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

We should at least output one packet before a stream can be considered
as readable. So far, for PID buffers, if an application exits at the
wrong timing before a stop waiting for data pending, empty streams could
be visible by a babeltrace executed after data pending incorrectly
returned false.

Fix it by considering a stream for which the consumerd has written 0
bytes to the output as having data pending.

This applies to 2.3-rc and stable-2.2.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/src/common/consumer.c b/src/common/consumer.c
index 59207da..e64e2e2 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -498,6 +498,7 @@ struct lttng_consumer_stream *consumer_allocate_stream(uint64_t channel_key,
 	stream->key = stream_key;
 	stream->out_fd = -1;
 	stream->out_fd_offset = 0;
+	stream->output_written = 0;
 	stream->state = state;
 	stream->uid = uid;
 	stream->gid = gid;
@@ -1475,6 +1476,7 @@ ssize_t lttng_consumer_on_read_subbuffer_mmap(
 					SYNC_FILE_RANGE_WRITE);
 			stream->out_fd_offset += ret;
 		}
+		stream->output_written += ret;
 		written += ret;
 	}
 	lttng_consumer_sync_trace_file(stream, orig_offset);
@@ -1688,6 +1690,7 @@ ssize_t lttng_consumer_on_read_subbuffer_splice(
 					SYNC_FILE_RANGE_WRITE);
 			stream->out_fd_offset += ret_splice;
 		}
+		stream->output_written += ret_splice;
 		written += ret_splice;
 	}
 	lttng_consumer_sync_trace_file(stream, orig_offset);
@@ -3400,6 +3403,16 @@ int consumer_data_pending(uint64_t id)
 		 */
 		ret = cds_lfht_is_node_deleted(&stream->node.node);
 		if (!ret) {
+			/*
+			 * An empty output file is not valid. We need at
+			 * least one packet generated per stream, even
+			 * if it contains no event, so it contains at
+			 * least one packet header.
+			 */
+			if (stream->output_written == 0) {
+				pthread_mutex_unlock(&stream->lock);
+				goto data_pending;
+			}
 			/* Check the stream if there is data in the buffers. */
 			ret = data_pending(stream);
 			if (ret == 1) {
diff --git a/src/common/consumer.h b/src/common/consumer.h
index 2003cbe..91f6b5c 100644
--- a/src/common/consumer.h
+++ b/src/common/consumer.h
@@ -221,6 +221,8 @@ struct lttng_consumer_stream {
 	int out_fd; /* output file to write the data */
 	/* Write position in the output file descriptor */
 	off_t out_fd_offset;
+	/* Amount of bytes written to the output */
+	uint64_t output_written;
 	enum lttng_consumer_stream_state state;
 	int shm_fd_is_copy;
 	int data_read;

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
