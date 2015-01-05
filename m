From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2/3] Fix: data pending: allow empty
	streams
Date: Sun,  4 Jan 2015 21:25:08 -0500
Message-ID: <1420424709-15095-2-git-send-email-mathieu.desnoyers__43109.4671170742$1420424780$gmane$org@efficios.com>
References: <1420424709-15095-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y7xME-0007yl-FT
 for lttng-dev@lists.lttng.org; Sun, 04 Jan 2015 21:25:27 -0500
In-Reply-To: <1420424709-15095-1-git-send-email-mathieu.desnoyers@efficios.com>
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

There are cases where a stream can be completely empty (no packet to
write) with UST: for instance, if a traced application is either
preempted for a long time, terminated, or stopped, between reserve and
commit. This will make the consumer consider that this stream has no
data ready. If this situation occurs in the first sub-buffer of a
stream, this stream will have no data at all (0 bytes).

Therefore, we need to let the data pending check consider that no data
is pending in this situation, otherwise it can make the data pending
check always return that there is data pending.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/consumer.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/src/common/consumer.c b/src/common/consumer.c
index 1333263..3f72af3 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -3548,15 +3548,6 @@ int consumer_data_pending(uint64_t id)
 		 */
 		ret = cds_lfht_is_node_deleted(&stream->node.node);
 		if (!ret) {
-			/*
-			 * An empty output file is not valid. We need at least one packet
-			 * generated per stream, even if it contains no event, so it
-			 * contains at least one packet header.
-			 */
-			if (stream->output_written == 0) {
-				pthread_mutex_unlock(&stream->lock);
-				goto data_pending;
-			}
 			/* Check the stream if there is data in the buffers. */
 			ret = data_pending(stream);
 			if (ret == 1) {
-- 
2.1.1
