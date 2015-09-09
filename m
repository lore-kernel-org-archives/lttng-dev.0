From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 3/5] Fix: consumerd:
	consumer_stream_write_index error handling
Date: Wed,  9 Sep 2015 11:56:35 -0400
Message-ID: <1441814197-9941-3-git-send-email-mathieu.desnoyers__5142.9838444621$1441814315$gmane$org@efficios.com>
References: <1441814197-9941-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZZhjt-0006XS-Uc
 for lttng-dev@lists.lttng.org; Wed, 09 Sep 2015 11:56:50 -0400
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

When consumer_stream_write_index cannot find the relay daemon, it
currently assumes that the reason for this situation is that it should
write to a file. Add a check to see if indeed we should write to a file,
of if this is caused by a removed relayd. Return an error and print an
error to the console in this situation.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/consumer-stream.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/common/consumer-stream.c b/src/common/consumer-stream.c
index 604e2f4..23cc882 100644
--- a/src/common/consumer-stream.c
+++ b/src/common/consumer-stream.c
@@ -374,10 +374,18 @@ int consumer_stream_write_index(struct lttng_consumer_stream *stream,
 		pthread_mutex_lock(&relayd->ctrl_sock_mutex);
 		ret = relayd_send_index(&relayd->control_sock, index,
 				stream->relayd_stream_id, stream->next_net_seq_num - 1);
+
 		pthread_mutex_unlock(&relayd->ctrl_sock_mutex);
 	} else {
 		ssize_t size_ret;
 
+		if (stream->net_seq_idx != -1ULL) {
+			ERR("Cannot find relayd for write index, net_seq_idx %" PRIu64,
+				stream->net_seq_idx);
+			ret = -1;
+			goto error;
+		}
+
 		size_ret = index_write(stream->index_fd, index,
 				sizeof(struct ctf_packet_index));
 		if (size_ret < sizeof(struct ctf_packet_index)) {
-- 
2.1.4
