From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH] Fix: per-uid buffers should only be flushed
	once on	stop
Date: Fri, 26 Apr 2013 15:18:38 -0400
Message-ID: <20130426191838.GA21939__12285.9793402769$1367003948$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UVoAL-0005th-HD
	for lttng-dev@lists.lttng.org; Fri, 26 Apr 2013 15:18:41 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

They were flushed once per application previously, causing workload with
many applications to trigger too many flush on stop, which in turn
caused buffer padding bloat.

* The pseudo-code for stop behavior on per-uid buffers was:

flush session's buffers
for each application:
  - stop tracing
  - wait quiescent
  - flush buffers
  - push metadata

Now doing, for per-uid buffers:

for each application:
  - stop tracing
  - wait quiescent
  - push metadata
flush session's buffers

* And for per-pid buffers:

Previously:

for each application:
  - stop tracing
  - wait quiescent
  - flush buffers
  - push metadata

Now:

for each application:
  - stop tracing
  - wait quiescent
  - push metadata
for each application:
  - flush buffers

Refs: #497

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 9bd622d..9bd4e69 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -3550,6 +3550,7 @@ int ust_app_create_event_glb(struct ltt_ust_session *usess,
 /*
  * Start tracing for a specific UST session and app.
  */
+static
 int ust_app_start_trace(struct ltt_ust_session *usess, struct ust_app *app)
 {
 	int ret = 0;
@@ -3642,12 +3643,11 @@ error_unlock:
 /*
  * Stop tracing for a specific UST session and app.
  */
+static
 int ust_app_stop_trace(struct ltt_ust_session *usess, struct ust_app *app)
 {
 	int ret = 0;
-	struct lttng_ht_iter iter;
 	struct ust_app_session *ua_sess;
-	struct ust_app_channel *ua_chan;
 	struct ust_registry_session *registry;
 
 	DBG("Stopping tracing for ust app pid %d", app->pid);
@@ -3700,6 +3700,52 @@ int ust_app_stop_trace(struct ltt_ust_session *usess, struct ust_app *app)
 
 	health_code_update();
 
+	registry = get_session_registry(ua_sess);
+	assert(registry);
+	/* Push metadata for application before freeing the application. */
+	(void) push_metadata(registry, ua_sess->consumer);
+
+	pthread_mutex_unlock(&ua_sess->lock);
+end_no_session:
+	rcu_read_unlock();
+	health_code_update();
+	return 0;
+
+error_rcu_unlock:
+	pthread_mutex_unlock(&ua_sess->lock);
+	rcu_read_unlock();
+	health_code_update();
+	return -1;
+}
+
+/*
+ * Flush buffers for a specific UST session and app.
+ */
+static
+int ust_app_flush_trace(struct ltt_ust_session *usess, struct ust_app *app)
+{
+	int ret = 0;
+	struct lttng_ht_iter iter;
+	struct ust_app_session *ua_sess;
+	struct ust_app_channel *ua_chan;
+
+	DBG("Flushing buffers for ust app pid %d", app->pid);
+
+	rcu_read_lock();
+
+	if (!app->compatible) {
+		goto end_no_session;
+	}
+
+	ua_sess = lookup_session_by_app(usess, app);
+	if (ua_sess == NULL) {
+		goto end_no_session;
+	}
+
+	pthread_mutex_lock(&ua_sess->lock);
+
+	health_code_update();
+
 	/* Flushing buffers */
 	cds_lfht_for_each_entry(ua_sess->channels->ht, &iter.iter, ua_chan,
 			node.node) {
@@ -3723,22 +3769,11 @@ int ust_app_stop_trace(struct ltt_ust_session *usess, struct ust_app *app)
 
 	health_code_update();
 
-	registry = get_session_registry(ua_sess);
-	assert(registry);
-	/* Push metadata for application before freeing the application. */
-	(void) push_metadata(registry, ua_sess->consumer);
-
 	pthread_mutex_unlock(&ua_sess->lock);
 end_no_session:
 	rcu_read_unlock();
 	health_code_update();
 	return 0;
-
-error_rcu_unlock:
-	pthread_mutex_unlock(&ua_sess->lock);
-	rcu_read_unlock();
-	health_code_update();
-	return -1;
 }
 
 /*
@@ -3823,9 +3858,21 @@ int ust_app_stop_trace_all(struct ltt_ust_session *usess)
 
 	rcu_read_lock();
 
-	/* Flush all per UID buffers associated to that session. */
-	if (usess->buffer_type == LTTNG_BUFFER_PER_UID) {
+	cds_lfht_for_each_entry(ust_app_ht->ht, &iter.iter, app, pid_n.node) {
+		ret = ust_app_stop_trace(usess, app);
+		if (ret < 0) {
+			/* Continue to next apps even on error */
+			continue;
+		}
+	}
+
+	/* Flush buffers */
+	switch (usess->buffer_type) {
+	case LTTNG_BUFFER_PER_UID:
+	{
 		struct buffer_reg_uid *reg;
+
+		/* Flush all per UID buffers associated to that session. */
 		cds_list_for_each_entry(reg, &usess->buffer_reg_uid_list, lnode) {
 			struct buffer_reg_channel *reg_chan;
 			struct consumer_socket *socket;
@@ -3848,14 +3895,20 @@ int ust_app_stop_trace_all(struct ltt_ust_session *usess)
 				(void) consumer_flush_channel(socket, reg_chan->consumer_key);
 			}
 		}
+		break;
 	}
-
-	cds_lfht_for_each_entry(ust_app_ht->ht, &iter.iter, app, pid_n.node) {
-		ret = ust_app_stop_trace(usess, app);
-		if (ret < 0) {
-			/* Continue to next apps even on error */
-			continue;
+	case LTTNG_BUFFER_PER_PID:
+		cds_lfht_for_each_entry(ust_app_ht->ht, &iter.iter, app, pid_n.node) {
+			ret = ust_app_flush_trace(usess, app);
+			if (ret < 0) {
+				/* Continue to next apps even on error */
+				continue;
+			}
 		}
+		break;
+	default:
+		assert(0);
+		break;
 	}
 
 	rcu_read_unlock();
diff --git a/src/bin/lttng-sessiond/ust-app.h b/src/bin/lttng-sessiond/ust-app.h
index e0aa17a..255a75c 100644
--- a/src/bin/lttng-sessiond/ust-app.h
+++ b/src/bin/lttng-sessiond/ust-app.h
@@ -257,8 +257,6 @@ int ust_app_register_done(int sock)
 int ust_app_version(struct ust_app *app);
 void ust_app_unregister(int sock);
 unsigned long ust_app_list_count(void);
-int ust_app_start_trace(struct ltt_ust_session *usess, struct ust_app *app);
-int ust_app_stop_trace(struct ltt_ust_session *usess, struct ust_app *app);
 int ust_app_start_trace_all(struct ltt_ust_session *usess);
 int ust_app_stop_trace_all(struct ltt_ust_session *usess);
 int ust_app_destroy_trace_all(struct ltt_ust_session *usess);

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
