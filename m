From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 3/4] Fix: sessiond should not error
	on channel creation vs app exit
Date: Mon, 17 Aug 2015 11:12:09 -0700
Message-ID: <1439835130-8852-4-git-send-email-mathieu.desnoyers__18559.419833082$1439835287$gmane$org@efficios.com>
References: <1439835130-8852-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZROtX-0000qS-AD
 for lttng-dev@lists.lttng.org; Mon, 17 Aug 2015 14:12:29 -0400
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

We should not report an error when creating a channel if the application
is exiting concurrently.

Also, remove an inappropriate assert() in ust_app_create_event_glb: it
is possible to have a channel lookup fail if channel/event creation
occurs concurrently with an application exit.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/ust-app.c | 82 +++++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 23 deletions(-)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 369eab9..db13601 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -1416,7 +1416,10 @@ static int send_channel_pid_to_ust(struct ust_app *app,
 
 	/* Send channel to the application. */
 	ret = ust_consumer_send_channel_to_ust(app, ua_sess, ua_chan);
-	if (ret < 0) {
+	if (ret == -EPIPE || ret == -LTTNG_UST_ERR_EXITING) {
+		ret = -ENOTCONN;	/* Caused by app exiting. */
+		goto error;
+	} else if (ret < 0) {
 		goto error;
 	}
 
@@ -1425,7 +1428,10 @@ static int send_channel_pid_to_ust(struct ust_app *app,
 	/* Send all streams to application. */
 	cds_list_for_each_entry_safe(stream, stmp, &ua_chan->streams.head, list) {
 		ret = ust_consumer_send_stream_to_ust(app, ua_chan, stream);
-		if (ret < 0) {
+		if (ret == -EPIPE || ret == -LTTNG_UST_ERR_EXITING) {
+			ret = -ENOTCONN;	/* Caused by app exiting. */
+			goto error;
+		} else if (ret < 0) {
 			goto error;
 		}
 		/* We don't need the stream anymore once sent to the tracer. */
@@ -2557,7 +2563,10 @@ static int send_channel_uid_to_ust(struct buffer_reg_channel *reg_chan,
 
 	/* Send channel to the application. */
 	ret = ust_consumer_send_channel_to_ust(app, ua_sess, ua_chan);
-	if (ret < 0) {
+	if (ret == -EPIPE || ret == -LTTNG_UST_ERR_EXITING) {
+		ret = -ENOTCONN;	/* Caused by app exiting. */
+		goto error;
+	} else if (ret < 0) {
 		goto error;
 	}
 
@@ -2576,6 +2585,12 @@ static int send_channel_uid_to_ust(struct buffer_reg_channel *reg_chan,
 		ret = ust_consumer_send_stream_to_ust(app, ua_chan, &stream);
 		if (ret < 0) {
 			(void) release_ust_app_stream(-1, &stream);
+			if (ret == -EPIPE || ret == -LTTNG_UST_ERR_EXITING) {
+				ret = -ENOTCONN; /* Caused by app exiting. */
+				goto error;
+			} else if (ret < 0) {
+				goto error;
+			}
 			goto error_stream_unlock;
 		}
 
@@ -2669,10 +2684,9 @@ static int create_channel_per_uid(struct ust_app *app,
 	/* Send buffers to the application. */
 	ret = send_channel_uid_to_ust(reg_chan, app, ua_sess, ua_chan);
 	if (ret < 0) {
-		/*
-		 * Don't report error to the console, since it may be
-		 * caused by application concurrently exiting.
-		 */
+		if (ret != -ENOTCONN) {
+			ERR("Error sending channel to application");
+		}
 		goto error;
 	}
 
@@ -2723,10 +2737,9 @@ static int create_channel_per_pid(struct ust_app *app,
 
 	ret = send_channel_pid_to_ust(app, ua_sess, ua_chan);
 	if (ret < 0) {
-		/*
-		 * Don't report error to the console, since it may be
-		 * caused by application concurrently exiting.
-		 */
+		if (ret != -ENOTCONN) {
+			ERR("Error sending channel to application");
+		}
 		goto error;
 	}
 
@@ -2740,7 +2753,8 @@ error:
  * need and send it to the application. This MUST be called with a RCU read
  * side lock acquired.
  *
- * Return 0 on success or else a negative value.
+ * Return 0 on success or else a negative value. Returns -ENOTCONN if
+ * the application exited concurrently.
  */
 static int do_create_channel(struct ust_app *app,
 		struct ltt_ust_session *usess, struct ust_app_session *ua_sess,
@@ -2799,7 +2813,8 @@ error:
  *
  * Called with UST app session lock and RCU read-side lock held.
  *
- * Return 0 on success or else a negative value.
+ * Return 0 on success or else a negative value. Returns -ENOTCONN if
+ * the application exited concurrently.
  */
 static int create_ust_app_channel(struct ust_app_session *ua_sess,
 		struct ltt_ust_channel *uchan, struct ust_app *app,
@@ -3800,6 +3815,7 @@ int ust_app_create_channel_glb(struct ltt_ust_session *usess,
 				 * or a timeout on it. We can't inform the caller that for a
 				 * specific app, the session failed so lets continue here.
 				 */
+				ret = 0;	/* Not an error. */
 				continue;
 			case -ENOMEM:
 			default:
@@ -3826,14 +3842,24 @@ int ust_app_create_channel_glb(struct ltt_ust_session *usess,
 		}
 		pthread_mutex_unlock(&ua_sess->lock);
 		if (ret < 0) {
-			if (ret == -ENOMEM) {
-				/* No more memory is a fatal error. Stop right now. */
-				goto error_rcu_unlock;
-			}
 			/* Cleanup the created session if it's the case. */
 			if (created) {
 				destroy_app_session(app, ua_sess);
 			}
+			switch (ret) {
+			case -ENOTCONN:
+				/*
+				 * The application's socket is not valid. Either a bad socket
+				 * or a timeout on it. We can't inform the caller that for a
+				 * specific app, the session failed so lets continue here.
+				 */
+				ret = 0;	/* Not an error. */
+				continue;
+			case -ENOMEM:
+			default:
+
+				goto error_rcu_unlock;
+			}
 		}
 	}
 
@@ -3964,8 +3990,15 @@ int ust_app_create_event_glb(struct ltt_ust_session *usess,
 		/* Lookup channel in the ust app session */
 		lttng_ht_lookup(ua_sess->channels, (void *)uchan->name, &uiter);
 		ua_chan_node = lttng_ht_iter_get_node_str(&uiter);
-		/* If the channel is not found, there is a code flow error */
-		assert(ua_chan_node);
+		/*
+		 * It is possible that the channel cannot be found is
+		 * the channel/event creation occurs concurrently with
+		 * an application exit.
+		 */
+		if (!ua_chan_node) {
+			pthread_mutex_unlock(&ua_sess->lock);
+			continue;
+		}
 
 		ua_chan = caa_container_of(ua_chan_node, struct ust_app_channel, node);
 
@@ -4482,11 +4515,14 @@ void ust_app_global_create(struct ltt_ust_session *usess, struct ust_app *app)
 	cds_lfht_for_each_entry(ua_sess->channels->ht, &iter.iter, ua_chan,
 			node.node) {
 		ret = do_create_channel(app, usess, ua_sess, ua_chan);
-		if (ret < 0) {
+		if (ret < 0 && ret != -ENOTCONN) {
 			/*
-			 * Stop everything. On error, the application failed, no more
-			 * file descriptor are available or ENOMEM so stopping here is
-			 * the only thing we can do for now.
+			 * Stop everything. On error, the application
+			 * failed, no more file descriptor are available
+			 * or ENOMEM so stopping here is the only thing
+			 * we can do for now. The only exception is
+			 * -ENOTCONN, which indicates that the application
+			 * has exit.
 			 */
 			goto error_unlock;
 		}
-- 
2.1.4
