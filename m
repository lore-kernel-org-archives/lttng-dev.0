From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 5/5] Print relayd stream indexes
Date: Wed,  9 Sep 2015 11:56:37 -0400
Message-ID: <1441814197-9941-5-git-send-email-mathieu.desnoyers__46873.6062678092$1441814312$gmane$org@efficios.com>
References: <1441814197-9941-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZZhjv-0006XT-0Y
 for lttng-dev@lists.lttng.org; Wed, 09 Sep 2015 11:56:51 -0400
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

In debug output, print leaking stream index information when exiting
from relay daemon.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-relayd/stream.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/src/bin/lttng-relayd/stream.c b/src/bin/lttng-relayd/stream.c
index cac8763..b604919 100644
--- a/src/bin/lttng-relayd/stream.c
+++ b/src/bin/lttng-relayd/stream.c
@@ -416,6 +416,27 @@ void try_stream_close(struct relay_stream *stream)
 	stream_put(stream);
 }
 
+static void print_stream_indexes(struct relay_stream *stream)
+{
+	struct lttng_ht_iter iter;
+	struct relay_index *index;
+
+	rcu_read_lock();
+	cds_lfht_for_each_entry(stream->indexes_ht->ht, &iter.iter, index,
+			index_n.node) {
+		DBG("index %p net_seq_num %" PRIu64 " refcount %ld"
+				" stream %" PRIu64 " trace %" PRIu64
+				" session %" PRIu64,
+				index,
+				index->index_n.key,
+				stream->ref.refcount,
+				index->stream->stream_handle,
+				index->stream->trace->id,
+				index->stream->trace->session->id);
+	}
+	rcu_read_unlock();
+}
+
 void print_relay_streams(void)
 {
 	struct lttng_ht_iter iter;
@@ -434,6 +455,7 @@ void print_relay_streams(void)
 				stream->stream_handle,
 				stream->trace->id,
 				stream->trace->session->id);
+		print_stream_indexes(stream);
 		stream_put(stream);
 	}
 	rcu_read_unlock();
-- 
2.1.4
