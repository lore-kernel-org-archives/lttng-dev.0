From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 3/3] Fix: ust-app: per-PID app
	unregister vs tracing stop races
Date: Sun,  4 Jan 2015 21:25:09 -0500
Message-ID: <1420424709-15095-3-git-send-email-mathieu.desnoyers__2809.48656513846$1420424809$gmane$org@efficios.com>
References: <1420424709-15095-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y7xMI-0007ym-13
 for lttng-dev@lists.lttng.org; Sun, 04 Jan 2015 21:25:31 -0500
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

There are various races with UST application unregister performed
concurrently with tracing stop operation when tracing with per-pid
buffers. This randomly affects availability of data shortly after the
data pending check returns that no more data is available.

ust_app_stop_trace_all() iterates on all applications in the ust_app_ht
hash table to issue a flush on all buffers. This is needed to ensure
that the sub-buffers being written to are made available to the
consumer, for both data consumption, and for the data pending check.
Failure to execute the sub-buffer flush makes following data pending
check return that there is no data in the buffers too early, thus
resulting in an incomplete trace.

It is therefore important that an application flushes all its buffers
before it is removed from the ust_app_ht.

This is where ust_app_unregister() needs to be fixed. Note that
ust_app_unregister() executes concurrently with
ust_app_stop_trace_all(), only taking the per-session lock. The order of
flush vs hash table removal therefore matters:

We need to push the metadata before removing application from
ust_app_ht. We also need to issue a flush for all application buffers
before removing the application from ust_app_ht.

Once this is fixed, there is yet another race, this time in
ust_app_flush_trace() (now renamed ust_app_flush_session()). It is
caused by the use of ustctl_sock_flush_buffer() which asks the
application to perform the buffer flush. Unfortunately, if the
application vanishes (not reachable anymore), but its unregistration has
not yet been processed by sessiond, then ust_app_stop_trace_all() will
fail to flush the application buffers, because
ustctl_sock_flush_buffer() will fail.

This final issue is fixed by asking the consumer daemon to flush the
associated channel rather than relying on the application.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/ust-app.c | 137 +++++++++++++++++++++++----------------
 1 file changed, 80 insertions(+), 57 deletions(-)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 891d75f..64d2ed2 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -41,6 +41,9 @@
 #include "ust-ctl.h"
 #include "utils.h"
 
+static
+int ust_app_flush_app_session(struct ust_app *app, struct ust_app_session *ua_sess);
+
 /* Next available channel key. Access under next_channel_key_lock. */
 static uint64_t _next_channel_key;
 static pthread_mutex_t next_channel_key_lock = PTHREAD_MUTEX_INITIALIZER;
@@ -3062,6 +3065,7 @@ void ust_app_unregister(int sock)
 {
 	struct ust_app *lta;
 	struct lttng_ht_node_ulong *node;
+	struct lttng_ht_iter ust_app_sock_iter;
 	struct lttng_ht_iter iter;
 	struct ust_app_session *ua_sess;
 	int ret;
@@ -3069,39 +3073,19 @@ void ust_app_unregister(int sock)
 	rcu_read_lock();
 
 	/* Get the node reference for a call_rcu */
-	lttng_ht_lookup(ust_app_ht_by_sock, (void *)((unsigned long) sock), &iter);
-	node = lttng_ht_iter_get_node_ulong(&iter);
+	lttng_ht_lookup(ust_app_ht_by_sock, (void *)((unsigned long) sock), &ust_app_sock_iter);
+	node = lttng_ht_iter_get_node_ulong(&ust_app_sock_iter);
 	assert(node);
 
 	lta = caa_container_of(node, struct ust_app, sock_n);
 	DBG("PID %d unregistering with sock %d", lta->pid, sock);
 
-	/* Remove application from PID hash table */
-	ret = lttng_ht_del(ust_app_ht_by_sock, &iter);
-	assert(!ret);
-
 	/*
-	 * Remove application from notify hash table. The thread handling the
-	 * notify socket could have deleted the node so ignore on error because
-	 * either way it's valid. The close of that socket is handled by the other
-	 * thread.
+	 * Perform "push metadata" and flush all application streams
+	 * before removing app from hash tables, ensuring proper
+	 * behavior of data_pending check.
+	 * Remove sessions so they are not visible during deletion.
 	 */
-	iter.iter.node = &lta->notify_sock_n.node;
-	(void) lttng_ht_del(ust_app_ht_by_notify_sock, &iter);
-
-	/*
-	 * Ignore return value since the node might have been removed before by an
-	 * add replace during app registration because the PID can be reassigned by
-	 * the OS.
-	 */
-	iter.iter.node = &lta->pid_n.node;
-	ret = lttng_ht_del(ust_app_ht, &iter);
-	if (ret) {
-		DBG3("Unregister app by PID %d failed. This can happen on pid reuse",
-				lta->pid);
-	}
-
-	/* Remove sessions so they are not visible during deletion.*/
 	cds_lfht_for_each_entry(lta->sessions->ht, &iter.iter, ua_sess,
 			node.node) {
 		struct ust_registry_session *registry;
@@ -3112,6 +3096,8 @@ void ust_app_unregister(int sock)
 			continue;
 		}
 
+		(void) ust_app_flush_app_session(lta, ua_sess);
+
 		/*
 		 * Add session to list for teardown. This is safe since at this point we
 		 * are the only one using this list.
@@ -3146,11 +3132,36 @@ void ust_app_unregister(int sock)
 				(void) close_metadata(registry, ua_sess->consumer);
 			}
 		}
-
 		cds_list_add(&ua_sess->teardown_node, &lta->teardown_head);
+
 		pthread_mutex_unlock(&ua_sess->lock);
 	}
 
+	/* Remove application from PID hash table */
+	ret = lttng_ht_del(ust_app_ht_by_sock, &ust_app_sock_iter);
+	assert(!ret);
+
+	/*
+	 * Remove application from notify hash table. The thread handling the
+	 * notify socket could have deleted the node so ignore on error because
+	 * either way it's valid. The close of that socket is handled by the other
+	 * thread.
+	 */
+	iter.iter.node = &lta->notify_sock_n.node;
+	(void) lttng_ht_del(ust_app_ht_by_notify_sock, &iter);
+
+	/*
+	 * Ignore return value since the node might have been removed before by an
+	 * add replace during app registration because the PID can be reassigned by
+	 * the OS.
+	 */
+	iter.iter.node = &lta->pid_n.node;
+	ret = lttng_ht_del(ust_app_ht, &iter);
+	if (ret) {
+		DBG3("Unregister app by PID %d failed. This can happen on pid reuse",
+				lta->pid);
+	}
+
 	/* Free memory */
 	call_rcu(&lta->pid_n.head, delete_ust_app_rcu);
 
@@ -4008,28 +4019,21 @@ error_rcu_unlock:
 	return -1;
 }
 
-/*
- * Flush buffers for a specific UST session and app.
- */
 static
-int ust_app_flush_trace(struct ltt_ust_session *usess, struct ust_app *app)
+int ust_app_flush_app_session(struct ust_app *app,
+		struct ust_app_session *ua_sess)
 {
-	int ret = 0;
+	int ret, retval = 0;
 	struct lttng_ht_iter iter;
-	struct ust_app_session *ua_sess;
 	struct ust_app_channel *ua_chan;
+	struct consumer_socket *socket;
 
-	DBG("Flushing buffers for ust app pid %d", app->pid);
+	DBG("Flushing app session buffers for ust app pid %d", app->pid);
 
 	rcu_read_lock();
 
 	if (!app->compatible) {
-		goto end_no_session;
-	}
-
-	ua_sess = lookup_session_by_app(usess, app);
-	if (ua_sess == NULL) {
-		goto end_no_session;
+		goto end_not_compatible;
 	}
 
 	pthread_mutex_lock(&ua_sess->lock);
@@ -4037,25 +4041,16 @@ int ust_app_flush_trace(struct ltt_ust_session *usess, struct ust_app *app)
 	health_code_update();
 
 	/* Flushing buffers */
+	socket = consumer_find_socket_by_bitness(app->bits_per_long,
+			ua_sess->consumer);
 	cds_lfht_for_each_entry(ua_sess->channels->ht, &iter.iter, ua_chan,
 			node.node) {
 		health_code_update();
 		assert(ua_chan->is_sent);
-		ret = ustctl_sock_flush_buffer(app->sock, ua_chan->obj);
-		if (ret < 0) {
-			if (ret != -EPIPE && ret != -LTTNG_UST_ERR_EXITING) {
-				ERR("UST app PID %d channel %s flush failed with ret %d",
-						app->pid, ua_chan->name, ret);
-			} else {
-				DBG3("UST app failed to flush %s. Application is dead.",
-						ua_chan->name);
-				/*
-				 * This is normal behavior, an application can die during the
-				 * creation process. Don't report an error so the execution can
-				 * continue normally.
-				 */
-			}
-			/* Continuing flushing all buffers */
+		ret = consumer_flush_channel(socket, ua_chan->key);
+		if (ret) {
+			ERR("Error flushing consumer channel");
+			retval = -1;
 			continue;
 		}
 	}
@@ -4063,10 +4058,38 @@ int ust_app_flush_trace(struct ltt_ust_session *usess, struct ust_app *app)
 	health_code_update();
 
 	pthread_mutex_unlock(&ua_sess->lock);
+end_not_compatible:
+	rcu_read_unlock();
+	health_code_update();
+	return retval;
+}
+
+/*
+ * Flush buffers for a specific UST session and app.
+ */
+static
+int ust_app_flush_session(struct ust_app *app, struct ltt_ust_session *usess)
+
+{
+	int ret;
+	struct lttng_ht_iter iter;
+	struct ust_app_session *ua_sess;
+
+	DBG("Flushing session buffers for ust app pid %d", app->pid);
+
+	rcu_read_lock();
+
+	ua_sess = lookup_session_by_app(usess, app);
+	if (ua_sess == NULL) {
+		ret = -1;
+		goto end_no_session;
+	}
+	ret = ust_app_flush_app_session(app, ua_sess);
+
 end_no_session:
 	rcu_read_unlock();
 	health_code_update();
-	return 0;
+	return ret;
 }
 
 /*
@@ -4200,7 +4223,7 @@ int ust_app_stop_trace_all(struct ltt_ust_session *usess)
 	}
 	case LTTNG_BUFFER_PER_PID:
 		cds_lfht_for_each_entry(ust_app_ht->ht, &iter.iter, app, pid_n.node) {
-			ret = ust_app_flush_trace(usess, app);
+			ret = ust_app_flush_session(app, usess);
 			if (ret < 0) {
 				/* Continue to next apps even on error */
 				continue;
-- 
2.1.1
