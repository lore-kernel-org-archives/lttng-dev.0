From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH lttng-tools] relay: use
	urcu_ref_get_unless_zero
Date: Thu, 17 Sep 2015 12:24:32 -0400
Message-ID: <1442507072-4178-1-git-send-email-mathieu.desnoyers__4374.94363072819$1442507147$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZcbzJ-00068Y-4K
 for lttng-dev@lists.lttng.org; Thu, 17 Sep 2015 12:24:47 -0400
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

This allows removing the reflock be performing this check and increment
atomically.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 doc/relayd-architecture.txt          |  7 +------
 src/bin/lttng-relayd/connection.c    | 14 +-------------
 src/bin/lttng-relayd/connection.h    |  1 -
 src/bin/lttng-relayd/ctf-trace.c     | 15 +--------------
 src/bin/lttng-relayd/ctf-trace.h     |  4 ----
 src/bin/lttng-relayd/index.c         | 15 +--------------
 src/bin/lttng-relayd/index.h         |  1 -
 src/bin/lttng-relayd/session.c       | 14 +-------------
 src/bin/lttng-relayd/session.h       |  2 --
 src/bin/lttng-relayd/stream.c        | 27 ++-------------------------
 src/bin/lttng-relayd/stream.h        |  6 ------
 src/bin/lttng-relayd/viewer-stream.c | 14 +-------------
 src/bin/lttng-relayd/viewer-stream.h |  1 -
 13 files changed, 8 insertions(+), 113 deletions(-)

diff --git a/doc/relayd-architecture.txt b/doc/relayd-architecture.txt
index 1491da9..56c8124 100644
--- a/doc/relayd-architecture.txt
+++ b/doc/relayd-architecture.txt
@@ -44,10 +44,7 @@ A RCU lookup+refcounting scheme has been introduced for all objects
 scheme allows looking up the objects or doing a traversal on the RCU
 linked list or hash table in combination with a getter on the object.
 This getter validates that there is still at least one reference to the
-object, else the lookup acts just as if the object does not exist. This
-scheme is protected by a "reflock" mutex in each object. "reflock"
-mutexes can be nested from the innermost object to the outermost object.
-IOW, the session reflock can nest within the ctf-trace reflock.
+object, else the lookup acts just as if the object does not exist.
 
 The relay_connection (connection between the sessiond/consumer and the
 relayd) is the outermost object of its hierarchy.
@@ -61,8 +58,6 @@ live.c client thread) when objects are shared. Locks can be nested from
 the outermost object to the innermost object. IOW, the ctf-trace lock can
 nest within the session lock.
 
-A "lock" should never nest within a "reflock".
-
 RCU linked lists are used to iterate using RCU, and are protected by
 their own mutex for modifications. Iterations should be confirmed using
 the object "getter" to ensure its refcount is not 0 (except in cases
diff --git a/src/bin/lttng-relayd/connection.c b/src/bin/lttng-relayd/connection.c
index fce6c84..b3a9c06 100644
--- a/src/bin/lttng-relayd/connection.c
+++ b/src/bin/lttng-relayd/connection.c
@@ -28,16 +28,7 @@
 
 bool connection_get(struct relay_connection *conn)
 {
-	bool has_ref = false;
-
-	pthread_mutex_lock(&conn->reflock);
-	if (conn->ref.refcount != 0) {
-		has_ref = true;
-		urcu_ref_get(&conn->ref);
-	}
-	pthread_mutex_unlock(&conn->reflock);
-
-	return has_ref;
+	return urcu_ref_get_unless_zero(&conn->ref);
 }
 
 struct relay_connection *connection_get_by_sock(struct lttng_ht *relay_connections_ht,
@@ -76,7 +67,6 @@ struct relay_connection *connection_create(struct lttcomm_sock *sock,
 		PERROR("zmalloc relay connection");
 		goto end;
 	}
-	pthread_mutex_init(&conn->reflock, NULL);
 	urcu_ref_init(&conn->ref);
 	conn->type = type;
 	conn->sock = sock;
@@ -132,9 +122,7 @@ static void connection_release(struct urcu_ref *ref)
 void connection_put(struct relay_connection *conn)
 {
 	rcu_read_lock();
-	pthread_mutex_lock(&conn->reflock);
 	urcu_ref_put(&conn->ref, connection_release);
-	pthread_mutex_unlock(&conn->reflock);
 	rcu_read_unlock();
 }
 
diff --git a/src/bin/lttng-relayd/connection.h b/src/bin/lttng-relayd/connection.h
index 4438638..43e8a1d 100644
--- a/src/bin/lttng-relayd/connection.h
+++ b/src/bin/lttng-relayd/connection.h
@@ -77,7 +77,6 @@ struct relay_connection {
 	uint32_t minor;
 
 	struct urcu_ref ref;
-	pthread_mutex_t reflock;
 
 	bool version_check_done;
 
diff --git a/src/bin/lttng-relayd/ctf-trace.c b/src/bin/lttng-relayd/ctf-trace.c
index 7c88262..b90e2a1 100644
--- a/src/bin/lttng-relayd/ctf-trace.c
+++ b/src/bin/lttng-relayd/ctf-trace.c
@@ -76,17 +76,7 @@ void ctf_trace_release(struct urcu_ref *ref)
  */
 bool ctf_trace_get(struct ctf_trace *trace)
 {
-	bool has_ref = false;
-
-	/* Confirm that the trace refcount has not reached 0. */
-	pthread_mutex_lock(&trace->reflock);
-	if (trace->ref.refcount != 0) {
-		has_ref = true;
-		urcu_ref_get(&trace->ref);
-	}
-	pthread_mutex_unlock(&trace->reflock);
-
-	return has_ref;
+	return urcu_ref_get_unless_zero(&trace->ref);
 }
 
 /*
@@ -124,7 +114,6 @@ static struct ctf_trace *ctf_trace_create(struct relay_session *session,
 	trace->session = session;
 	urcu_ref_init(&trace->ref);
 	pthread_mutex_init(&trace->lock, NULL);
-	pthread_mutex_init(&trace->reflock, NULL);
 	pthread_mutex_init(&trace->stream_list_lock, NULL);
 	lttng_ht_add_str(session->ctf_traces_ht, &trace->node);
 
@@ -169,9 +158,7 @@ end:
 void ctf_trace_put(struct ctf_trace *trace)
 {
 	rcu_read_lock();
-	pthread_mutex_lock(&trace->reflock);
 	urcu_ref_put(&trace->ref, ctf_trace_release);
-	pthread_mutex_unlock(&trace->reflock);
 	rcu_read_unlock();
 }
 
diff --git a/src/bin/lttng-relayd/ctf-trace.h b/src/bin/lttng-relayd/ctf-trace.h
index d051f80..9903d38 100644
--- a/src/bin/lttng-relayd/ctf-trace.h
+++ b/src/bin/lttng-relayd/ctf-trace.h
@@ -30,10 +30,6 @@
 #include "viewer-stream.h"
 
 struct ctf_trace {
-	/*
-	 * The ctf_trace reflock nests inside the stream reflock.
-	 */
-	pthread_mutex_t reflock;	/* Protects refcounting */
 	struct urcu_ref ref;		/* Every stream has a ref on the trace. */
 	struct relay_session *session;	/* Back ref to trace session */
 
diff --git a/src/bin/lttng-relayd/index.c b/src/bin/lttng-relayd/index.c
index 5b5c711..04aa244 100644
--- a/src/bin/lttng-relayd/index.c
+++ b/src/bin/lttng-relayd/index.c
@@ -59,7 +59,6 @@ static struct relay_index *relay_index_create(struct relay_stream *stream,
 
 	lttng_ht_node_init_u64(&index->index_n, net_seq_num);
 	pthread_mutex_init(&index->lock, NULL);
-	pthread_mutex_init(&index->reflock, NULL);
 	urcu_ref_init(&index->ref);
 
 end:
@@ -99,21 +98,11 @@ static struct relay_index *relay_index_add_unique(struct relay_stream *stream,
  */
 static bool relay_index_get(struct relay_index *index)
 {
-	bool has_ref = false;
-
 	DBG2("index get for stream id %" PRIu64 " and seqnum %" PRIu64 " refcount %d",
 			index->stream->stream_handle, index->index_n.key,
 			(int) index->ref.refcount);
 
-	/* Confirm that the index refcount has not reached 0. */
-	pthread_mutex_lock(&index->reflock);
-	if (index->ref.refcount != 0) {
-		has_ref = true;
-		urcu_ref_get(&index->ref);
-	}
-	pthread_mutex_unlock(&index->reflock);
-
-	return has_ref;
+	return urcu_ref_get_unless_zero(&index->ref);
 }
 
 /*
@@ -265,10 +254,8 @@ void relay_index_put(struct relay_index *index)
 	 * Index lock ensures that concurrent test and update of stream
 	 * ref is atomic.
 	 */
-	pthread_mutex_lock(&index->reflock);
 	assert(index->ref.refcount != 0);
 	urcu_ref_put(&index->ref, index_release);
-	pthread_mutex_unlock(&index->reflock);
 	rcu_read_unlock();
 }
 
diff --git a/src/bin/lttng-relayd/index.h b/src/bin/lttng-relayd/index.h
index 15c4ac8..c63f165 100644
--- a/src/bin/lttng-relayd/index.h
+++ b/src/bin/lttng-relayd/index.h
@@ -34,7 +34,6 @@ struct relay_index {
 	/*
 	 * index lock nests inside stream lock.
 	 */
-	pthread_mutex_t reflock;	/* Protects refcounting. */
 	struct urcu_ref ref;		/* Reference from getters. */
 	struct relay_stream *stream;	/* Back ref to stream */
 
diff --git a/src/bin/lttng-relayd/session.c b/src/bin/lttng-relayd/session.c
index 14ae874..466229a 100644
--- a/src/bin/lttng-relayd/session.c
+++ b/src/bin/lttng-relayd/session.c
@@ -65,7 +65,6 @@ struct relay_session *session_create(const char *session_name,
 	urcu_ref_init(&session->ref);
 	CDS_INIT_LIST_HEAD(&session->recv_list);
 	pthread_mutex_init(&session->lock, NULL);
-	pthread_mutex_init(&session->reflock, NULL);
 	pthread_mutex_init(&session->recv_list_lock, NULL);
 
 	strncpy(session->session_name, session_name,
@@ -84,16 +83,7 @@ error:
 /* Should be called with RCU read-side lock held. */
 bool session_get(struct relay_session *session)
 {
-	bool has_ref = false;
-
-	pthread_mutex_lock(&session->reflock);
-	if (session->ref.refcount != 0) {
-		has_ref = true;
-		urcu_ref_get(&session->ref);
-	}
-	pthread_mutex_unlock(&session->reflock);
-
-	return has_ref;
+	return urcu_ref_get_unless_zero(&session->ref);
 }
 
 /*
@@ -175,9 +165,7 @@ void session_release(struct urcu_ref *ref)
 void session_put(struct relay_session *session)
 {
 	rcu_read_lock();
-	pthread_mutex_lock(&session->reflock);
 	urcu_ref_put(&session->ref, session_release);
-	pthread_mutex_unlock(&session->reflock);
 	rcu_read_unlock();
 }
 
diff --git a/src/bin/lttng-relayd/session.h b/src/bin/lttng-relayd/session.h
index 1a37cfe..362216a 100644
--- a/src/bin/lttng-relayd/session.h
+++ b/src/bin/lttng-relayd/session.h
@@ -53,8 +53,6 @@ struct relay_session {
 	 */
 
 	struct urcu_ref ref;
-	/* session reflock nests inside ctf_trace reflock. */
-	pthread_mutex_t reflock;
 
 	pthread_mutex_t lock;
 
diff --git a/src/bin/lttng-relayd/stream.c b/src/bin/lttng-relayd/stream.c
index b604919..3fd5bc0 100644
--- a/src/bin/lttng-relayd/stream.c
+++ b/src/bin/lttng-relayd/stream.c
@@ -33,16 +33,7 @@
 /* Should be called with RCU read-side lock held. */
 bool stream_get(struct relay_stream *stream)
 {
-	bool has_ref = false;
-
-	pthread_mutex_lock(&stream->reflock);
-	if (stream->ref.refcount != 0) {
-		has_ref = true;
-		urcu_ref_get(&stream->ref);
-	}
-	pthread_mutex_unlock(&stream->reflock);
-
-	return has_ref;
+	return urcu_ref_get_unless_zero(&stream->ref);
 }
 
 /*
@@ -101,7 +92,6 @@ struct relay_stream *stream_create(struct ctf_trace *trace,
 	stream->channel_name = channel_name;
 	lttng_ht_node_init_u64(&stream->node, stream->stream_handle);
 	pthread_mutex_init(&stream->lock, NULL);
-	pthread_mutex_init(&stream->reflock, NULL);
 	urcu_ref_init(&stream->ref);
 	ctf_trace_get(trace);
 	stream->trace = trace;
@@ -228,8 +218,7 @@ unlock:
 
 /*
  * Stream must be protected by holding the stream lock or by virtue of being
- * called from stream_destroy, in which case it is guaranteed to be accessed
- * from a single thread by the reflock.
+ * called from stream_destroy.
  */
 static void stream_unpublish(struct relay_stream *stream)
 {
@@ -274,9 +263,6 @@ static void stream_destroy_rcu(struct rcu_head *rcu_head)
 /*
  * No need to take stream->lock since this is only called on the final
  * stream_put which ensures that a single thread may act on the stream.
- *
- * At that point, the object is also protected by the reflock which
- * guarantees that no other thread may share ownership of this stream.
  */
 static void stream_release(struct urcu_ref *ref)
 {
@@ -317,15 +303,7 @@ static void stream_release(struct urcu_ref *ref)
 void stream_put(struct relay_stream *stream)
 {
 	DBG("stream put for stream id %" PRIu64, stream->stream_handle);
-	/*
-	 * Ensure existence of stream->reflock for stream unlock.
-	 */
 	rcu_read_lock();
-	/*
-	 * Stream reflock ensures that concurrent test and update of
-	 * stream ref is atomic.
-	 */
-	pthread_mutex_lock(&stream->reflock);
 	assert(stream->ref.refcount != 0);
 	/*
 	 * Wait until we have processed all the stream packets before
@@ -335,7 +313,6 @@ void stream_put(struct relay_stream *stream)
 			stream->stream_handle,
 			(int) stream->ref.refcount);
 	urcu_ref_put(&stream->ref, stream_release);
-	pthread_mutex_unlock(&stream->reflock);
 	rcu_read_unlock();
 }
 
diff --git a/src/bin/lttng-relayd/stream.h b/src/bin/lttng-relayd/stream.h
index 5030e5d..efbbd12 100644
--- a/src/bin/lttng-relayd/stream.h
+++ b/src/bin/lttng-relayd/stream.h
@@ -37,12 +37,6 @@
 struct relay_stream {
 	uint64_t stream_handle;
 
-	/*
-	 * reflock used to synchronize the closing of this stream.
-	 * stream reflock nests inside viewer stream reflock.
-	 * stream reflock nests inside index reflock.
-	 */
-	pthread_mutex_t reflock;
 	struct urcu_ref ref;
 	/* Back reference to trace. Protected by refcount on trace object. */
 	struct ctf_trace *trace;
diff --git a/src/bin/lttng-relayd/viewer-stream.c b/src/bin/lttng-relayd/viewer-stream.c
index 333246a..537db47 100644
--- a/src/bin/lttng-relayd/viewer-stream.c
+++ b/src/bin/lttng-relayd/viewer-stream.c
@@ -153,7 +153,6 @@ struct relay_viewer_stream *viewer_stream_create(struct relay_stream *stream,
 	lttng_ht_node_init_u64(&vstream->stream_n, stream->stream_handle);
 	lttng_ht_add_unique_u64(viewer_streams_ht, &vstream->stream_n);
 
-	pthread_mutex_init(&vstream->reflock, NULL);
 	urcu_ref_init(&vstream->ref);
 
 	return vstream;
@@ -206,16 +205,7 @@ static void viewer_stream_release(struct urcu_ref *ref)
 /* Must be called with RCU read-side lock held. */
 bool viewer_stream_get(struct relay_viewer_stream *vstream)
 {
-	bool has_ref = false;
-
-	pthread_mutex_lock(&vstream->reflock);
-	if (vstream->ref.refcount != 0) {
-		has_ref = true;
-		urcu_ref_get(&vstream->ref);
-	}
-	pthread_mutex_unlock(&vstream->reflock);
-
-	return has_ref;
+	return urcu_ref_get_unless_zero(&vstream->ref);
 }
 
 /*
@@ -248,9 +238,7 @@ end:
 void viewer_stream_put(struct relay_viewer_stream *vstream)
 {
 	rcu_read_lock();
-	pthread_mutex_lock(&vstream->reflock);
 	urcu_ref_put(&vstream->ref, viewer_stream_release);
-	pthread_mutex_unlock(&vstream->reflock);
 	rcu_read_unlock();
 }
 
diff --git a/src/bin/lttng-relayd/viewer-stream.h b/src/bin/lttng-relayd/viewer-stream.h
index 5dc135d..848f72a 100644
--- a/src/bin/lttng-relayd/viewer-stream.h
+++ b/src/bin/lttng-relayd/viewer-stream.h
@@ -45,7 +45,6 @@ struct relay_stream;
  */
 struct relay_viewer_stream {
 	struct urcu_ref ref;
-	pthread_mutex_t reflock;
 
 	/* Back ref to stream. */
 	struct relay_stream *stream;
-- 
2.1.4
