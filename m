From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/2] Fix: per-uid flush and ust
	registry locking
Date: Thu, 15 Jan 2015 17:24:26 -0500
Message-ID: <1421360667-9017-1-git-send-email-mathieu.desnoyers__42517.3234464184$1421360785$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1YBsqK-0002pg-LV
 for lttng-dev@lists.lttng.org; Thu, 15 Jan 2015 17:24:48 -0500
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

Commit c4b88406 "Fix: ust-app: per-PID app unregister vs tracing stop
races" introduces a regression for per-UID flush. It can be triggered by
the test_high_throughput_limits (root regression) test. For per-UID
tracing, we need to use the registry channel ID, not the per-application
channel ID, when asking the consumer daemon to flush.

When doing this fix, we notice that the locking rules of push_metadata()
are weird. A per-ust app session lock is protecting registry data, which
makes it impossible to call push_metadata from a ust session level (for
the entire session) in the case of per-UID tracing. Moreover, it's
unclear how holding a per-application lock can protect a registry shared
across applications in per-UID tracing. Therefore, we move all accesses
to the registry metadata_key and metadata_closed fields into the
registry lock critical section. We now only rely on RCU to ensure
existance of registry across push_metadata(), rather than relying on the
per-application session lock.

It also takes care of a documentation vs code mismatch: push_metadata()
documents that "The session lock MUST be acquired here before calling
this.", but in reality, it's the application session lock which is held
across those calls. Removing this requirement, and relying on RCU
instead, fixes this mismatch.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/ust-app.c | 243 +++++++++++++++++++++------------------
 1 file changed, 132 insertions(+), 111 deletions(-)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index dcb6e7c..0c4045c 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -442,21 +442,28 @@ ssize_t ust_app_push_metadata(struct ust_registry_session *registry,
 	assert(registry);
 	assert(socket);
 
+	pthread_mutex_lock(&registry->lock);
+
+	/*
+	 * Means that no metadata was assigned to the session. This can happens if
+	 * no start has been done previously.
+	 */
+	if (!registry->metadata_key) {
+		pthread_mutex_unlock(&registry->lock);
+		return 0;
+	}
+
 	/*
 	 * On a push metadata error either the consumer is dead or the metadata
 	 * channel has been destroyed because its endpoint might have died (e.g:
 	 * relayd). If so, the metadata closed flag is set to 1 so we deny pushing
 	 * metadata again which is not valid anymore on the consumer side.
-	 *
-	 * The ust app session mutex locked allows us to make this check without
-	 * the registry lock.
 	 */
 	if (registry->metadata_closed) {
+		pthread_mutex_unlock(&registry->lock);
 		return -EPIPE;
 	}
 
-	pthread_mutex_lock(&registry->lock);
-
 	offset = registry->metadata_len_sent;
 	len = registry->metadata_len - registry->metadata_len_sent;
 	if (len == 0) {
@@ -514,6 +521,14 @@ push_data:
 
 end:
 error:
+	if (ret_val) {
+		/*
+		 * On error, flag the registry that the metadata is closed. We were unable
+		 * to push anything and this means that either the consumer is not
+		 * responding or the metadata cache has been destroyed on the consumer.
+		 */
+		registry->metadata_closed = 1;
+	}
 	pthread_mutex_unlock(&registry->lock);
 error_push:
 	free(metadata_str);
@@ -521,11 +536,12 @@ error_push:
 }
 
 /*
- * For a given application and session, push metadata to consumer. The session
- * lock MUST be acquired here before calling this.
+ * For a given application and session, push metadata to consumer.
  * Either sock or consumer is required : if sock is NULL, the default
  * socket to send the metadata is retrieved from consumer, if sock
  * is not NULL we use it to send the metadata.
+ * RCU read-side lock must be held while calling this function,
+ * therefore ensuring existance of registry.
  *
  * Return 0 on success else a negative error.
  */
@@ -539,23 +555,20 @@ static int push_metadata(struct ust_registry_session *registry,
 	assert(registry);
 	assert(consumer);
 
-	rcu_read_lock();
+	pthread_mutex_lock(&registry->lock);
 
-	/*
-	 * Means that no metadata was assigned to the session. This can happens if
-	 * no start has been done previously.
-	 */
-	if (!registry->metadata_key) {
-		ret_val = 0;
-		goto end_rcu_unlock;
+	if (registry->metadata_closed) {
+		pthread_mutex_unlock(&registry->lock);
+		return -EPIPE;
 	}
 
 	/* Get consumer socket to use to push the metadata.*/
 	socket = consumer_find_socket_by_bitness(registry->bits_per_long,
 			consumer);
+	pthread_mutex_unlock(&registry->lock);
 	if (!socket) {
 		ret_val = -1;
-		goto error_rcu_unlock;
+		goto error;
 	}
 
 	/*
@@ -573,21 +586,13 @@ static int push_metadata(struct ust_registry_session *registry,
 	pthread_mutex_unlock(socket->lock);
 	if (ret < 0) {
 		ret_val = ret;
-		goto error_rcu_unlock;
+		goto error;
 	}
 
-	rcu_read_unlock();
 	return 0;
 
-error_rcu_unlock:
-	/*
-	 * On error, flag the registry that the metadata is closed. We were unable
-	 * to push anything and this means that either the consumer is not
-	 * responding or the metadata cache has been destroyed on the consumer.
-	 */
-	registry->metadata_closed = 1;
-end_rcu_unlock:
-	rcu_read_unlock();
+error:
+end:
 	return ret_val;
 }
 
@@ -610,6 +615,8 @@ static int close_metadata(struct ust_registry_session *registry,
 
 	rcu_read_lock();
 
+	pthread_mutex_lock(&registry->lock);
+
 	if (!registry->metadata_key || registry->metadata_closed) {
 		ret = 0;
 		goto end;
@@ -636,6 +643,7 @@ error:
 	 */
 	registry->metadata_closed = 1;
 end:
+	pthread_mutex_unlock(&registry->lock);
 	rcu_read_unlock();
 	return ret;
 }
@@ -674,7 +682,7 @@ void delete_ust_app_session(int sock, struct ust_app_session *ua_sess,
 	pthread_mutex_lock(&ua_sess->lock);
 
 	registry = get_session_registry(ua_sess);
-	if (registry && !registry->metadata_closed) {
+	if (registry) {
 		/* Push metadata for application before freeing the application. */
 		(void) push_metadata(registry, ua_sess->consumer);
 
@@ -684,8 +692,7 @@ void delete_ust_app_session(int sock, struct ust_app_session *ua_sess,
 		 * previous push metadata could have flag the metadata registry to
 		 * close so don't send a close command if closed.
 		 */
-		if (ua_sess->buffer_type != LTTNG_BUFFER_PER_UID &&
-				!registry->metadata_closed) {
+		if (ua_sess->buffer_type != LTTNG_BUFFER_PER_UID) {
 			/* And ask to close it for this session registry. */
 			(void) close_metadata(registry, ua_sess->consumer);
 		}
@@ -2841,6 +2848,8 @@ static int create_ust_app_metadata(struct ust_app_session *ua_sess,
 	registry = get_session_registry(ua_sess);
 	assert(registry);
 
+	pthread_mutex_lock(&registry->lock);
+
 	/* Metadata already exists for this registry or it was closed previously */
 	if (registry->metadata_key || registry->metadata_closed) {
 		ret = 0;
@@ -2913,6 +2922,7 @@ error_consumer:
 	lttng_fd_put(LTTNG_FD_APPS, 1);
 	delete_ust_app_channel(-1, metadata, app);
 error:
+	pthread_mutex_unlock(&registry->lock);
 	return ret;
 }
 
@@ -3098,9 +3108,9 @@ void ust_app_unregister(int sock)
 	DBG("PID %d unregistering with sock %d", lta->pid, sock);
 
 	/*
-	 * Perform "push metadata" and flush all application streams
-	 * before removing app from hash tables, ensuring proper
-	 * behavior of data_pending check.
+	 * For per-PID buffers, perform "push metadata" and flush all
+	 * application streams before removing app from hash tables,
+	 * ensuring proper behavior of data_pending check.
 	 * Remove sessions so they are not visible during deletion.
 	 */
 	cds_lfht_for_each_entry(lta->sessions->ht, &iter.iter, ua_sess,
@@ -3113,7 +3123,9 @@ void ust_app_unregister(int sock)
 			continue;
 		}
 
-		(void) ust_app_flush_app_session(lta, ua_sess);
+		if (ua_sess->buffer_type == LTTNG_BUFFER_PER_PID) {
+			(void) ust_app_flush_app_session(lta, ua_sess);
+		}
 
 		/*
 		 * Add session to list for teardown. This is safe since at this point we
@@ -3133,7 +3145,7 @@ void ust_app_unregister(int sock)
 		 * session so the delete session will NOT push/close a second time.
 		 */
 		registry = get_session_registry(ua_sess);
-		if (registry && !registry->metadata_closed) {
+		if (registry) {
 			/* Push metadata for application before freeing the application. */
 			(void) push_metadata(registry, ua_sess->consumer);
 
@@ -3143,8 +3155,7 @@ void ust_app_unregister(int sock)
 			 * previous push metadata could have flag the metadata registry to
 			 * close so don't send a close command if closed.
 			 */
-			if (ua_sess->buffer_type != LTTNG_BUFFER_PER_UID &&
-					!registry->metadata_closed) {
+			if (ua_sess->buffer_type != LTTNG_BUFFER_PER_UID) {
 				/* And ask to close it for this session registry. */
 				(void) close_metadata(registry, ua_sess->consumer);
 			}
@@ -4039,10 +4050,8 @@ int ust_app_stop_trace(struct ltt_ust_session *usess, struct ust_app *app)
 	registry = get_session_registry(ua_sess);
 	assert(registry);
 
-	if (!registry->metadata_closed) {
-		/* Push metadata for application before freeing the application. */
-		(void) push_metadata(registry, ua_sess->consumer);
-	}
+	/* Push metadata for application before freeing the application. */
+	(void) push_metadata(registry, ua_sess->consumer);
 
 end_unlock:
 	pthread_mutex_unlock(&ua_sess->lock);
@@ -4082,21 +4091,32 @@ int ust_app_flush_app_session(struct ust_app *app,
 	/* Flushing buffers */
 	socket = consumer_find_socket_by_bitness(app->bits_per_long,
 			ua_sess->consumer);
-	cds_lfht_for_each_entry(ua_sess->channels->ht, &iter.iter, ua_chan,
-			node.node) {
-		health_code_update();
-		assert(ua_chan->is_sent);
-		ret = consumer_flush_channel(socket, ua_chan->key);
-		if (ret) {
-			ERR("Error flushing consumer channel");
-			retval = -1;
-			continue;
+
+	/* Flush buffers and push metadata. */
+	switch (ua_sess->buffer_type) {
+	case LTTNG_BUFFER_PER_PID:
+		cds_lfht_for_each_entry(ua_sess->channels->ht, &iter.iter, ua_chan,
+				node.node) {
+			health_code_update();
+			assert(ua_chan->is_sent);
+			ret = consumer_flush_channel(socket, ua_chan->key);
+			if (ret) {
+				ERR("Error flushing consumer channel");
+				retval = -1;
+				continue;
+			}
 		}
+		break;
+	case LTTNG_BUFFER_PER_UID:
+	default:
+		assert(0);
+		break;
 	}
 
 	health_code_update();
 
 	pthread_mutex_unlock(&ua_sess->lock);
+
 end_not_compatible:
 	rcu_read_unlock();
 	health_code_update();
@@ -4104,25 +4124,76 @@ end_not_compatible:
 }
 
 /*
- * Flush buffers for a specific UST session and app.
+ * Flush buffers for all applications for a specific UST session.
+ * Called with UST session lock held.
  */
 static
-int ust_app_flush_session(struct ust_app *app, struct ltt_ust_session *usess)
+int ust_app_flush_session(struct ltt_ust_session *usess)
 
 {
 	int ret;
-	struct ust_app_session *ua_sess;
 
-	DBG("Flushing session buffers for ust app pid %d", app->pid);
+	DBG("Flushing session buffers for all ust apps");
 
 	rcu_read_lock();
 
-	ua_sess = lookup_session_by_app(usess, app);
-	if (ua_sess == NULL) {
-		ret = -1;
-		goto end_no_session;
+	/* Flush buffers and push metadata. */
+	switch (usess->buffer_type) {
+	case LTTNG_BUFFER_PER_UID:
+	{
+		struct buffer_reg_uid *reg;
+		struct lttng_ht_iter iter;
+
+		/* Flush all per UID buffers associated to that session. */
+		cds_list_for_each_entry(reg, &usess->buffer_reg_uid_list, lnode) {
+			struct ust_registry_session *ust_session_reg;
+			struct buffer_reg_channel *reg_chan;
+			struct consumer_socket *socket;
+
+			/* Get consumer socket to use to push the metadata.*/
+			socket = consumer_find_socket_by_bitness(reg->bits_per_long,
+					usess->consumer);
+			if (!socket) {
+				/* Ignore request if no consumer is found for the session. */
+				continue;
+			}
+
+			cds_lfht_for_each_entry(reg->registry->channels->ht, &iter.iter,
+					reg_chan, node.node) {
+				/*
+				 * The following call will print error values so the return
+				 * code is of little importance because whatever happens, we
+				 * have to try them all.
+				 */
+				(void) consumer_flush_channel(socket, reg_chan->consumer_key);
+			}
+
+			ust_session_reg = reg->registry->reg.ust;
+			/* Push metadata. */
+			(void) push_metadata(ust_session_reg, usess->consumer);
+		}
+		ret = 0;
+		break;
+	}
+	case LTTNG_BUFFER_PER_PID:
+	{
+		struct ust_app_session *ua_sess;
+		struct lttng_ht_iter iter;
+		struct ust_app *app;
+
+		cds_lfht_for_each_entry(ust_app_ht->ht, &iter.iter, app, pid_n.node) {
+			ua_sess = lookup_session_by_app(usess, app);
+			if (ua_sess == NULL) {
+				continue;
+			}
+			(void) ust_app_flush_app_session(app, ua_sess);
+		}
+		break;
+	}
+	default:
+		assert(0);
+		break;
 	}
-	ret = ust_app_flush_app_session(app, ua_sess);
 
 end_no_session:
 	rcu_read_unlock();
@@ -4201,6 +4272,7 @@ int ust_app_start_trace_all(struct ltt_ust_session *usess)
 
 /*
  * Start tracing for the UST session.
+ * Called with UST session lock held.
  */
 int ust_app_stop_trace_all(struct ltt_ust_session *usess)
 {
@@ -4220,58 +4292,7 @@ int ust_app_stop_trace_all(struct ltt_ust_session *usess)
 		}
 	}
 
-	/* Flush buffers and push metadata (for UID buffers). */
-	switch (usess->buffer_type) {
-	case LTTNG_BUFFER_PER_UID:
-	{
-		struct buffer_reg_uid *reg;
-
-		/* Flush all per UID buffers associated to that session. */
-		cds_list_for_each_entry(reg, &usess->buffer_reg_uid_list, lnode) {
-			struct ust_registry_session *ust_session_reg;
-			struct buffer_reg_channel *reg_chan;
-			struct consumer_socket *socket;
-
-			/* Get consumer socket to use to push the metadata.*/
-			socket = consumer_find_socket_by_bitness(reg->bits_per_long,
-					usess->consumer);
-			if (!socket) {
-				/* Ignore request if no consumer is found for the session. */
-				continue;
-			}
-
-			cds_lfht_for_each_entry(reg->registry->channels->ht, &iter.iter,
-					reg_chan, node.node) {
-				/*
-				 * The following call will print error values so the return
-				 * code is of little importance because whatever happens, we
-				 * have to try them all.
-				 */
-				(void) consumer_flush_channel(socket, reg_chan->consumer_key);
-			}
-
-			ust_session_reg = reg->registry->reg.ust;
-			if (!ust_session_reg->metadata_closed) {
-				/* Push metadata. */
-				(void) push_metadata(ust_session_reg, usess->consumer);
-			}
-		}
-
-		break;
-	}
-	case LTTNG_BUFFER_PER_PID:
-		cds_lfht_for_each_entry(ust_app_ht->ht, &iter.iter, app, pid_n.node) {
-			ret = ust_app_flush_session(app, usess);
-			if (ret < 0) {
-				/* Continue to next apps even on error */
-				continue;
-			}
-		}
-		break;
-	default:
-		assert(0);
-		break;
-	}
+	(void) ust_app_flush_session(usess);
 
 	rcu_read_unlock();
 
-- 
2.1.1
