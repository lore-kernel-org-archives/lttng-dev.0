From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2/5] Fix: relayd: handle consumerd
	crashes without leak
Date: Wed,  9 Sep 2015 11:56:34 -0400
Message-ID: <1441814197-9941-2-git-send-email-mathieu.desnoyers__44100.3332649872$1441814518$gmane$org@efficios.com>
References: <1441814197-9941-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZZhjw-0006XV-9c
 for lttng-dev@lists.lttng.org; Wed, 09 Sep 2015 11:56:53 -0400
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

We can be clever about indexes partially received in cases where we
received the data socket part, but not the control socket part: since
we're currently closing the stream on behalf of the control socket, we
*know* there won't be any more control information for this socket.
Therefore, we can destroy all indexes for which we have received only
the file descriptor (from data socket). This takes care of consumerd
crashes between sending the data and control information for a packet.
Since those are sent in that order, we take care of consumerd crashes.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-relayd/index.c  | 39 +++++++++++++++++++++++++++
 src/bin/lttng-relayd/index.h  |  2 ++
 src/bin/lttng-relayd/stream.c | 61 +++++++++++++++++++++++++++++++++----------
 3 files changed, 88 insertions(+), 14 deletions(-)

diff --git a/src/bin/lttng-relayd/index.c b/src/bin/lttng-relayd/index.c
index 7182e36..cb7ae3d 100644
--- a/src/bin/lttng-relayd/index.c
+++ b/src/bin/lttng-relayd/index.c
@@ -333,3 +333,42 @@ void relay_index_close_all(struct relay_stream *stream)
 	}
 	rcu_read_unlock();
 }
+
+void relay_index_close_partial_fd(struct relay_stream *stream)
+{
+	struct lttng_ht_iter iter;
+	struct relay_index *index;
+
+	rcu_read_lock();
+	cds_lfht_for_each_entry(stream->indexes_ht->ht, &iter.iter,
+			index, index_n.node) {
+		if (!index->index_fd) {
+			continue;
+		}
+		/*
+		 * Partial index has its index_fd: we have only
+		 * received its info from the data socket.
+		 * Put self-ref from index.
+		 */
+		relay_index_put(index);
+	}
+	rcu_read_unlock();
+}
+
+uint64_t relay_index_find_last(struct relay_stream *stream)
+{
+	struct lttng_ht_iter iter;
+	struct relay_index *index;
+	uint64_t net_seq_num = -1ULL;
+
+	rcu_read_lock();
+	cds_lfht_for_each_entry(stream->indexes_ht->ht, &iter.iter,
+			index, index_n.node) {
+		if (net_seq_num == -1ULL ||
+				index->index_n.key > net_seq_num) {
+			net_seq_num = index->index_n.key;
+		}
+	}
+	rcu_read_unlock();
+	return net_seq_num;
+}
diff --git a/src/bin/lttng-relayd/index.h b/src/bin/lttng-relayd/index.h
index e882ed9..15c4ac8 100644
--- a/src/bin/lttng-relayd/index.h
+++ b/src/bin/lttng-relayd/index.h
@@ -71,5 +71,7 @@ int relay_index_set_data(struct relay_index *index,
 int relay_index_try_flush(struct relay_index *index);
 
 void relay_index_close_all(struct relay_stream *stream);
+void relay_index_close_partial_fd(struct relay_stream *stream);
+uint64_t relay_index_find_last(struct relay_stream *stream);
 
 #endif /* _RELAY_INDEX_H */
diff --git a/src/bin/lttng-relayd/stream.c b/src/bin/lttng-relayd/stream.c
index 2a59d1e..cac8763 100644
--- a/src/bin/lttng-relayd/stream.c
+++ b/src/bin/lttng-relayd/stream.c
@@ -354,26 +354,59 @@ void try_stream_close(struct relay_stream *stream)
 	}
 
 	stream->close_requested = true;
-	/*
-	 * We shortcut the data pending check if no bound is known for this
-	 * stream. This prevents us from never closing the stream in the case
-	 * where a connection would be closed before a "close" command has
-	 * been received.
-	 *
-	 * TODO
-	 * This still leaves open the question of handling missing data after
-	 * a bound has been set by a stream close command. Since we have no
-	 * way of pairing data and control connection, and that a data
-	 * connection has no ownership of a stream, it is likely that a
-	 * timeout approach would be appropriate to handle dangling streams.
-	 */
+
+	if (stream->last_net_seq_num == -1ULL) {
+		/*
+		 * Handle connection close without explicit stream close
+		 * command.
+		 *
+		 * We can be clever about indexes partially received in
+		 * cases where we received the data socket part, but not
+		 * the control socket part: since we're currently closing
+		 * the stream on behalf of the control socket, we *know*
+		 * there won't be any more control information for this
+		 * socket. Therefore, we can destroy all indexes for
+		 * which we have received only the file descriptor (from
+		 * data socket). This takes care of consumerd crashes
+		 * between sending the data and control information for
+		 * a packet. Since those are sent in that order, we take
+		 * care of consumerd crashes.
+		 */
+		relay_index_close_partial_fd(stream);
+		/*
+		 * Use the highest net_seq_num we currently have pending
+		 * As end of stream indicator.  Leave last_net_seq_num
+		 * at -1ULL if we cannot find any index.
+		 */
+		stream->last_net_seq_num = relay_index_find_last(stream);
+		/* Fall-through into the next check. */
+	}
+
 	if (stream->last_net_seq_num != -1ULL &&
 			((int64_t) (stream->prev_seq - stream->last_net_seq_num)) < 0) {
-		/* Don't close since we still have data pending. */
+		/*
+		 * Don't close since we still have data pending. This
+		 * handles cases where an explicit close command has
+		 * been received for this stream, and cases where the
+		 * connection has been closed, and we are awaiting for
+		 * index information from the data socket. It is
+		 * therefore expected that all the index fd information
+		 * we need has already been received on the control
+		 * socket. Matching index information from data socket
+		 * should be Expected Soon(TM).
+		 *
+		 * TODO: We should implement a timer to garbage collect
+		 * streams after a timeout to be resilient against a
+		 * consumerd implementation that would not match this
+		 * expected behavior.
+		 */
 		pthread_mutex_unlock(&stream->lock);
 		DBG("closing stream %" PRIu64 " aborted since it still has data pending", stream->stream_handle);
 		return;
 	}
+	/*
+	 * We received all the indexes we can expect.
+	 */
 	stream_unpublish(stream);
 	stream->closed = true;
 	/* Relay indexes are only used by the "consumer/sessiond" end. */
-- 
2.1.4
