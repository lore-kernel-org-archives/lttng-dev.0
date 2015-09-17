From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/2] Fix: relayd: don't call
	lttng_ht_destroy in RCU read-side C.S.
Date: Thu, 17 Sep 2015 12:48:40 -0400
Message-ID: <1442508521-32200-1-git-send-email-mathieu.desnoyers__20681.6532802351$1442508686$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZccMd-0006Gn-Ax
 for lttng-dev@lists.lttng.org; Thu, 17 Sep 2015 12:48:52 -0400
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

It is forbidden to call lttng_ht_destroy() within a RCU read-side
critical section.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-relayd/session.c | 15 ++++++++-------
 src/bin/lttng-relayd/stream.c  |  5 +++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/src/bin/lttng-relayd/session.c b/src/bin/lttng-relayd/session.c
index 14ae874..2300e5f 100644
--- a/src/bin/lttng-relayd/session.c
+++ b/src/bin/lttng-relayd/session.c
@@ -131,7 +131,14 @@ static void rcu_destroy_session(struct rcu_head *rcu_head)
 	struct relay_session *session =
 			caa_container_of(rcu_head, struct relay_session,
 				rcu_node);
-
+	/*
+	 * Since each trace has a reference on the session, it means
+	 * that if we are at the point where we teardown the session, no
+	 * trace belonging to that session exist at this point.
+	 * Calling lttng_ht_destroy in call_rcu worker thread so we
+	 * don't hold the RCU read-side lock while calling it.
+	 */
+	lttng_ht_destroy(session->ctf_traces_ht);
 	free(session);
 }
 
@@ -155,12 +162,6 @@ static void destroy_session(struct relay_session *session)
 
 	ret = session_delete(session);
 	assert(!ret);
-	/*
-	 * Since each trace has a reference on the session, it means
-	 * that if we are at the point where we teardown the session, no
-	 * trace belonging to that session exist at this point.
-	 */
-	lttng_ht_destroy(session->ctf_traces_ht);
 	call_rcu(&session->rcu_node, rcu_destroy_session);
 }
 
diff --git a/src/bin/lttng-relayd/stream.c b/src/bin/lttng-relayd/stream.c
index b604919..8825d09 100644
--- a/src/bin/lttng-relayd/stream.c
+++ b/src/bin/lttng-relayd/stream.c
@@ -253,6 +253,11 @@ static void stream_unpublish(struct relay_stream *stream)
 static void stream_destroy(struct relay_stream *stream)
 {
 	if (stream->indexes_ht) {
+		/*
+		 * Calling lttng_ht_destroy in call_rcu worker thread so
+		 * we don't hold the RCU read-side lock while calling
+		 * it.
+		 */
 		lttng_ht_destroy(stream->indexes_ht);
 	}
 	if (stream->tfa) {
-- 
2.1.4
