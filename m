From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2/4] Fix: sessiond ust-app session
	teardown race
Date: Mon, 17 Aug 2015 11:12:08 -0700
Message-ID: <1439835130-8852-3-git-send-email-mathieu.desnoyers__43563.0621076145$1439835266$gmane$org@efficios.com>
References: <1439835130-8852-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZROtV-0000qR-Hw
 for lttng-dev@lists.lttng.org; Mon, 17 Aug 2015 14:12:26 -0400
In-Reply-To: <1439835130-8852-1-git-send-email-mathieu.desnoyers@efficios.com>
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

Add a deleted flag within the ust app session which is raised (with ust
app session lock held) at delete, and checked within each RCU traversal,
again with ust app session lock held.

This takes care of races between teardown of an application (unregister)
and execution of commands which are accessing the app session
concurrently.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/ust-app.c | 57 ++++++++++++++++++++++++++++++++++++++++
 src/bin/lttng-sessiond/ust-app.h |  2 ++
 2 files changed, 59 insertions(+)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index d452986..369eab9 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -717,6 +717,9 @@ void delete_ust_app_session(int sock, struct ust_app_session *ua_sess,
 
 	pthread_mutex_lock(&ua_sess->lock);
 
+	assert(!ua_sess->deleted);
+	ua_sess->deleted = true;
+
 	registry = get_session_registry(ua_sess);
 	if (registry) {
 		/* Push metadata for application before freeing the application. */
@@ -3209,6 +3212,11 @@ void ust_app_unregister(int sock)
 		 */
 		pthread_mutex_lock(&ua_sess->lock);
 
+		if (ua_sess->deleted) {
+			pthread_mutex_unlock(&ua_sess->lock);
+			continue;
+		}
+
 		/*
 		 * Normally, this is done in the delete session process which is
 		 * executed in the call rcu below. However, upon registration we can't
@@ -3801,6 +3809,12 @@ int ust_app_create_channel_glb(struct ltt_ust_session *usess,
 		assert(ua_sess);
 
 		pthread_mutex_lock(&ua_sess->lock);
+
+		if (ua_sess->deleted) {
+			pthread_mutex_unlock(&ua_sess->lock);
+			continue;
+		}
+
 		if (!strncmp(uchan->name, DEFAULT_METADATA_NAME,
 					sizeof(uchan->name))) {
 			copy_channel_attr_to_ustctl(&ua_sess->metadata_attr, &uchan->attr);
@@ -3870,6 +3884,11 @@ int ust_app_enable_event_glb(struct ltt_ust_session *usess,
 
 		pthread_mutex_lock(&ua_sess->lock);
 
+		if (ua_sess->deleted) {
+			pthread_mutex_unlock(&ua_sess->lock);
+			continue;
+		}
+
 		/* Lookup channel in the ust app session */
 		lttng_ht_lookup(ua_sess->channels, (void *)uchan->name, &uiter);
 		ua_chan_node = lttng_ht_iter_get_node_str(&uiter);
@@ -3936,6 +3955,12 @@ int ust_app_create_event_glb(struct ltt_ust_session *usess,
 		}
 
 		pthread_mutex_lock(&ua_sess->lock);
+
+		if (ua_sess->deleted) {
+			pthread_mutex_unlock(&ua_sess->lock);
+			continue;
+		}
+
 		/* Lookup channel in the ust app session */
 		lttng_ht_lookup(ua_sess->channels, (void *)uchan->name, &uiter);
 		ua_chan_node = lttng_ht_iter_get_node_str(&uiter);
@@ -3987,6 +4012,11 @@ int ust_app_start_trace(struct ltt_ust_session *usess, struct ust_app *app)
 
 	pthread_mutex_lock(&ua_sess->lock);
 
+	if (ua_sess->deleted) {
+		pthread_mutex_unlock(&ua_sess->lock);
+		goto end;
+	}
+
 	/* Upon restart, we skip the setup, already done */
 	if (ua_sess->started) {
 		goto skip_setup;
@@ -4087,6 +4117,11 @@ int ust_app_stop_trace(struct ltt_ust_session *usess, struct ust_app *app)
 
 	pthread_mutex_lock(&ua_sess->lock);
 
+	if (ua_sess->deleted) {
+		pthread_mutex_unlock(&ua_sess->lock);
+		goto end_no_session;
+	}
+
 	/*
 	 * If started = 0, it means that stop trace has been called for a session
 	 * that was never started. It's possible since we can have a fail start
@@ -4167,6 +4202,10 @@ int ust_app_flush_app_session(struct ust_app *app,
 
 	pthread_mutex_lock(&ua_sess->lock);
 
+	if (ua_sess->deleted) {
+		goto end_deleted;
+	}
+
 	health_code_update();
 
 	/* Flushing buffers */
@@ -4196,6 +4235,7 @@ int ust_app_flush_app_session(struct ust_app *app,
 
 	health_code_update();
 
+end_deleted:
 	pthread_mutex_unlock(&ua_sess->lock);
 
 end_not_compatible:
@@ -4429,6 +4469,11 @@ void ust_app_global_create(struct ltt_ust_session *usess, struct ust_app *app)
 
 	pthread_mutex_lock(&ua_sess->lock);
 
+	if (ua_sess->deleted) {
+		pthread_mutex_unlock(&ua_sess->lock);
+		goto end;
+	}
+
 	/*
 	 * We can iterate safely here over all UST app session since the create ust
 	 * app session above made a shadow copy of the UST global domain from the
@@ -4571,6 +4616,12 @@ int ust_app_add_ctx_channel_glb(struct ltt_ust_session *usess,
 		}
 
 		pthread_mutex_lock(&ua_sess->lock);
+
+		if (ua_sess->deleted) {
+			pthread_mutex_unlock(&ua_sess->lock);
+			continue;
+		}
+
 		/* Lookup channel in the ust app session */
 		lttng_ht_lookup(ua_sess->channels, (void *)uchan->name, &uiter);
 		ua_chan_node = lttng_ht_iter_get_node_str(&uiter);
@@ -4629,6 +4680,12 @@ int ust_app_enable_event_pid(struct ltt_ust_session *usess,
 	}
 
 	pthread_mutex_lock(&ua_sess->lock);
+
+	if (ua_sess->deleted) {
+		ret = 0;
+		goto end_unlock;
+	}
+
 	/* Lookup channel in the ust app session */
 	lttng_ht_lookup(ua_sess->channels, (void *)uchan->name, &iter);
 	ua_chan_node = lttng_ht_iter_get_node_str(&iter);
diff --git a/src/bin/lttng-sessiond/ust-app.h b/src/bin/lttng-sessiond/ust-app.h
index 35da66b..60569d0 100644
--- a/src/bin/lttng-sessiond/ust-app.h
+++ b/src/bin/lttng-sessiond/ust-app.h
@@ -182,6 +182,8 @@ struct ust_app_session {
 	int started;  /* allows detection of start vs restart. */
 	int handle;   /* used has unique identifier for app session */
 
+	bool deleted;	/* Session deleted flag. Check with lock held. */
+
 	/*
 	 * Tracing session ID. Multiple ust app session can have the same tracing
 	 * session id making this value NOT unique to the object.
-- 
2.1.4
