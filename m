From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH lttng-tools] Fix: relayd: Swap endianness of
 packet index
Date: Fri,  8 Nov 2019 11:32:47 -0500
Message-ID: <20191108163247.6821-1-mathieu.desnoyers__15559.2538112373$1573230787$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 478m5t5CHHzrDN
 for <lttng-dev@lists.lttng.org>; Fri,  8 Nov 2019 11:32:50 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The packet index in stream_update_index() is meant to be stored
to disk, and therefore is kept in big endian.

Swap its endianness to host endian before using it internally.

Fixes "Fix: relayd: use packet sequence number for rotation position".

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-relayd/stream.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/bin/lttng-relayd/stream.c b/src/bin/lttng-relayd/stream.c
index c5bf3759..f9ff5e9a 100644
--- a/src/bin/lttng-relayd/stream.c
+++ b/src/bin/lttng-relayd/stream.c
@@ -1142,7 +1142,8 @@ int stream_update_index(struct relay_stream *stream, uint64_t net_seq_num,
 		tracefile_array_file_rotate(stream->tfa, TRACEFILE_ROTATE_READ);
 		tracefile_array_commit_seq(stream->tfa);
 		stream->index_received_seqcount++;
-		stream->received_packet_seq_num = index->index_data.packet_seq_num;
+		stream->received_packet_seq_num =
+				be64toh(index->index_data.packet_seq_num);
 		*flushed = true;
 	} else if (ret > 0) {
 		index->total_size = total_size;
-- 
2.17.1
