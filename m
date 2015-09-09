From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 4/5] Enhance relayd error reporting
Date: Wed,  9 Sep 2015 11:56:36 -0400
Message-ID: <1441814197-9941-4-git-send-email-mathieu.desnoyers__37018.2228427895$1441814442$gmane$org@efficios.com>
References: <1441814197-9941-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZZhjv-0006XU-JL
 for lttng-dev@lists.lttng.org; Wed, 09 Sep 2015 11:56:52 -0400
In-Reply-To: <1441814197-9941-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

relay_process_data has error cases that don't print any error to the
console. Add those cases, and enhance the information provided by error
output within handle_index_data().

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-relayd/main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index dcaaaa8..0c7ef8d 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -2084,8 +2084,8 @@ static int handle_index_data(struct relay_stream *stream, uint64_t net_seq_num,
 	/* Get data offset because we are about to update the index. */
 	data_offset = htobe64(stream->tracefile_size_current);
 
-	DBG("handle_index_data: stream %" PRIu64 " data offset %" PRIu64,
-		stream->stream_handle, stream->tracefile_size_current);
+	DBG("handle_index_data: stream %" PRIu64 " net_seq_num %" PRIu64 " data offset %" PRIu64,
+			stream->stream_handle, net_seq_num, stream->tracefile_size_current);
 
 	/*
 	 * Lookup for an existing index for that stream id/sequence
@@ -2183,6 +2183,7 @@ static int relay_process_data(struct relay_connection *conn)
 	stream_id = be64toh(data_hdr.stream_id);
 	stream = stream_get_by_id(stream_id);
 	if (!stream) {
+		ERR("relay_process_data: Cannot find stream %" PRIu64, stream_id);
 		ret = -1;
 		goto end;
 	}
@@ -2212,6 +2213,8 @@ static int relay_process_data(struct relay_connection *conn)
 		if (ret == 0) {
 			/* Orderly shutdown. Not necessary to print an error. */
 			DBG("Socket %d did an orderly shutdown", conn->sock->fd);
+		} else {
+			ERR("Socket %d error %d", conn->sock->fd, ret);
 		}
 		ret = -1;
 		goto end_stream_put;
@@ -2255,6 +2258,8 @@ static int relay_process_data(struct relay_connection *conn)
 	if (session->minor >= 4 && !session->snapshot) {
 		ret = handle_index_data(stream, net_seq_num, rotate_index);
 		if (ret < 0) {
+			ERR("handle_index_data: fail stream %" PRIu64 " net_seq_num %" PRIu64 " ret %d",
+					stream->stream_handle, net_seq_num, ret);
 			goto end_stream_unlock;
 		}
 	}
@@ -2273,6 +2278,8 @@ static int relay_process_data(struct relay_connection *conn)
 	ret = write_padding_to_file(stream->stream_fd->fd,
 			be32toh(data_hdr.padding_size));
 	if (ret < 0) {
+		ERR("write_padding_to_file: fail stream %" PRIu64 " net_seq_num %" PRIu64 " ret %d",
+				stream->stream_handle, net_seq_num, ret);
 		goto end_stream_unlock;
 	}
 	stream->tracefile_size_current +=
-- 
2.1.4
