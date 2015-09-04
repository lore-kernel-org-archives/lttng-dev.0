From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: unpublish stream on close
Date: Fri,  4 Sep 2015 15:44:23 -0400
Message-ID: <1441395863-31567-1-git-send-email-mathieu.desnoyers__7742.68142781711$1441395928$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZXwuX-0004hP-Oi
 for lttng-dev@lists.lttng.org; Fri, 04 Sep 2015 15:44:34 -0400
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

Fixes race where data connection can still add indexes after close,
preventing graceful teardown of the stream.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-relayd/main.c   | 11 +++++++++--
 src/bin/lttng-relayd/stream.c | 29 ++++++++++++++++-------------
 src/bin/lttng-relayd/stream.h |  1 +
 3 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index 7b385b4..40ce50a 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -1267,8 +1267,16 @@ static int relay_close_stream(struct lttcomm_relayd_hdr *recv_hdr,
 		goto end;
 	}
 	pthread_mutex_lock(&stream->lock);
-	stream->closed = true;
 	stream->last_net_seq_num = be64toh(stream_info.last_net_seq_num);
+	pthread_mutex_unlock(&stream->lock);
+
+	/*
+	 * Set last_net_seq_num before the close flag. Required by data
+	 * pending check.
+	 */
+
+	stream_close(stream);
+
 	if (stream->is_metadata) {
 		struct relay_viewer_stream *vstream;
 
@@ -1287,7 +1295,6 @@ static int relay_close_stream(struct lttcomm_relayd_hdr *recv_hdr,
 			viewer_stream_put(vstream);
 		}
 	}
-	pthread_mutex_unlock(&stream->lock);
 	stream_put(stream);
 
 end:
diff --git a/src/bin/lttng-relayd/stream.c b/src/bin/lttng-relayd/stream.c
index 870b75a..fca358f 100644
--- a/src/bin/lttng-relayd/stream.c
+++ b/src/bin/lttng-relayd/stream.c
@@ -168,6 +168,7 @@ struct relay_stream *stream_create(struct ctf_trace *trace,
 	 * side of the relayd does not have the concept of session.
 	 */
 	lttng_ht_add_unique_u64(relay_streams_ht, &stream->node);
+	stream->in_stream_ht = true;
 
 	DBG("Relay new stream added %s with ID %" PRIu64, stream->channel_name,
 			stream->stream_handle);
@@ -231,14 +232,21 @@ unlock:
  */
 static void stream_unpublish(struct relay_stream *stream)
 {
-	if (!stream->published) {
-		return;
+	if (stream->in_stream_ht) {
+		struct lttng_ht_iter iter;
+		int ret;
+
+		iter.iter.node = &stream->node.node;
+		ret = lttng_ht_del(relay_streams_ht, &iter);
+		assert(!ret);
+		stream->in_stream_ht = false;
+	}
+	if (stream->published) {
+		pthread_mutex_lock(&stream->trace->stream_list_lock);
+		cds_list_del_rcu(&stream->stream_node);
+		pthread_mutex_unlock(&stream->trace->stream_list_lock);
+		stream->published = false;
 	}
-	pthread_mutex_lock(&stream->trace->stream_list_lock);
-	cds_list_del_rcu(&stream->stream_node);
-	pthread_mutex_unlock(&stream->trace->stream_list_lock);
-
-	stream->published = false;
 }
 
 static void stream_destroy(struct relay_stream *stream)
@@ -267,8 +275,6 @@ static void stream_release(struct urcu_ref *ref)
 	struct relay_stream *stream =
 		caa_container_of(ref, struct relay_stream, ref);
 	struct relay_session *session;
-	int ret;
-	struct lttng_ht_iter iter;
 
 	session = stream->trace->session;
 
@@ -282,10 +288,6 @@ static void stream_release(struct urcu_ref *ref)
 	}
 	pthread_mutex_unlock(&session->recv_list_lock);
 
-	iter.iter.node = &stream->node.node;
-	ret = lttng_ht_del(relay_streams_ht, &iter);
-	assert(!ret);
-
 	stream_unpublish(stream);
 
 	if (stream->stream_fd) {
@@ -333,6 +335,7 @@ void stream_close(struct relay_stream *stream)
 {
 	DBG("closing stream %" PRIu64, stream->stream_handle);
 	pthread_mutex_lock(&stream->lock);
+	stream_unpublish(stream);
 	stream->closed = true;
 	relay_index_close_all(stream);
 	pthread_mutex_unlock(&stream->lock);
diff --git a/src/bin/lttng-relayd/stream.h b/src/bin/lttng-relayd/stream.h
index ca6be81..542e05c 100644
--- a/src/bin/lttng-relayd/stream.h
+++ b/src/bin/lttng-relayd/stream.h
@@ -132,6 +132,7 @@ struct relay_stream {
 	 * Node of stream within global stream hash table.
 	 */
 	struct lttng_ht_node_u64 node;
+	bool in_stream_ht;		/* is stream in stream hash table. */
 	struct rcu_head rcu_node;	/* For call_rcu teardown. */
 };
 
-- 
2.1.4
