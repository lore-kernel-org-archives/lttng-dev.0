From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Cleanup: relayd: centralize thread
	stopping function
Date: Thu, 18 Dec 2014 13:02:07 -0500
Message-ID: <1418925727-10309-1-git-send-email-mathieu.desnoyers__33415.496958378$1418925800$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y1fP2-0003Fd-Gz
 for lttng-dev@lists.lttng.org; Thu, 18 Dec 2014 13:02:26 -0500
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

Rather than relying on having main.c and live.c threads both using the
same notification pipe from different stop_thread implementations,
centralize thread stop in one central function exposed to both main.c
and live.c

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-relayd/live.c         | 53 +++++++------------------------------
 src/bin/lttng-relayd/lttng-relayd.h |  1 +
 src/bin/lttng-relayd/main.c         | 45 ++++++++++++++++++++-----------
 3 files changed, 39 insertions(+), 60 deletions(-)

diff --git a/src/bin/lttng-relayd/live.c b/src/bin/lttng-relayd/live.c
index beb67b2..fd570e0 100644
--- a/src/bin/lttng-relayd/live.c
+++ b/src/bin/lttng-relayd/live.c
@@ -326,42 +326,12 @@ error_unlock:
 	return ret;
 }
 
-/*
- * Write to writable pipe used to notify a thread.
- */
-static
-int notify_thread_pipe(int wpipe)
-{
-	ssize_t ret;
-
-	ret = lttng_write(wpipe, "!", 1);
-	if (ret < 1) {
-		PERROR("write poll pipe");
-	}
-
-	return (int) ret;
-}
-
-/*
- * Stop all threads by closing the thread quit pipe.
- */
-static
-int stop_threads(void)
+int relayd_live_stop(void)
 {
-	int ret, retval = 0;
-
-	/* Stopping all threads */
-	DBG("Terminating all live threads");
-	ret = notify_thread_pipe(thread_quit_pipe[1]);
-	if (ret < 0) {
-		ERR("write error on thread quit pipe");
-		retval = -1;
-	}
-
-	/* Dispatch thread */
+	/* Stop dispatch thread */
 	CMM_STORE_SHARED(live_dispatch_thread_exit, 1);
 	futex_nto1_wake(&viewer_conn_queue.futex);
-	return retval;
+	return 0;
 }
 
 /*
@@ -593,8 +563,8 @@ error_sock_control:
 	}
 	health_unregister(health_relayd);
 	DBG("Live viewer listener thread cleanup complete");
-	if (stop_threads()) {
-		ERR("Error stopping live threads");
+	if (lttng_relay_stop_threads()) {
+		ERR("Error stopping threads");
 	}
 	return NULL;
 }
@@ -672,8 +642,8 @@ error_testpoint:
 	}
 	health_unregister(health_relayd);
 	DBG("Live viewer dispatch thread dying");
-	if (stop_threads()) {
-		ERR("Error stopping live threads");
+	if (lttng_relay_stop_threads()) {
+		ERR("Error stopping threads");
 	}
 	return NULL;
 }
@@ -2038,8 +2008,8 @@ error_testpoint:
 		ERR("Health error occurred in %s", __func__);
 	}
 	health_unregister(health_relayd);
-	if (stop_threads()) {
-		ERR("Error stopping live threads");
+	if (lttng_relay_stop_threads()) {
+		ERR("Error stopping threads");
 	}
 	rcu_unregister_thread();
 	return NULL;
@@ -2054,11 +2024,6 @@ static int create_conn_pipe(void)
 	return utils_create_pipe_cloexec(live_conn_pipe);
 }
 
-int relayd_live_stop(void)
-{
-	return stop_threads();
-}
-
 int relayd_live_join(void)
 {
 	int ret, retval = 0;
diff --git a/src/bin/lttng-relayd/lttng-relayd.h b/src/bin/lttng-relayd/lttng-relayd.h
index 0a3ce47..245c5fd 100644
--- a/src/bin/lttng-relayd/lttng-relayd.h
+++ b/src/bin/lttng-relayd/lttng-relayd.h
@@ -57,5 +57,6 @@ extern const char * const config_section_name;
 extern int thread_quit_pipe[2];
 
 void lttng_relay_notify_ready(void);
+int lttng_relay_stop_threads(void);
 
 #endif /* LTTNG_RELAYD_H */
diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index 35725b6..1ec1eea 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -494,46 +494,55 @@ int notify_thread_pipe(int wpipe)
 	ret = lttng_write(wpipe, "!", 1);
 	if (ret < 1) {
 		PERROR("write poll pipe");
+		goto end;
 	}
-
+	ret = 0;
+end:
 	return ret;
 }
 
-static void notify_health_quit_pipe(int *pipe)
+static
+int notify_health_quit_pipe(int *pipe)
 {
 	ssize_t ret;
 
 	ret = lttng_write(pipe[1], "4", 1);
 	if (ret < 1) {
 		PERROR("write relay health quit");
+		goto end;
 	}
+	ret = 0;
+end:
+	return ret;
 }
 
 /*
- * Stop all threads by closing the thread quit pipe.
+ * Stop all relayd and relayd-live threads.
  */
-static
-void stop_threads(void)
+int lttng_relay_stop_threads(void)
 {
-	int ret;
+	int retval = 0;
 
 	/* Stopping all threads */
 	DBG("Terminating all threads");
-	ret = notify_thread_pipe(thread_quit_pipe[1]);
-	if (ret < 0) {
+	if (notify_thread_pipe(thread_quit_pipe[1])) {
 		ERR("write error on thread quit pipe");
+		retval = -1;
 	}
 
-	notify_health_quit_pipe(health_quit_pipe);
+	if (notify_health_quit_pipe(health_quit_pipe)) {
+		ERR("write error on health quit pipe");
+	}
 
 	/* Dispatch thread */
 	CMM_STORE_SHARED(dispatch_thread_exit, 1);
 	futex_nto1_wake(&relay_conn_queue.futex);
 
-	ret = relayd_live_stop();
-	if (ret) {
+	if (relayd_live_stop()) {
 		ERR("Error stopping live threads");
+		retval = -1;
 	}
+	return retval;
 }
 
 /*
@@ -551,11 +560,15 @@ void sighandler(int sig)
 		return;
 	case SIGINT:
 		DBG("SIGINT caught");
-		stop_threads();
+		if (lttng_relay_stop_threads()) {
+			ERR("Error stopping threads");
+		}
 		break;
 	case SIGTERM:
 		DBG("SIGTERM caught");
-		stop_threads();
+		if (lttng_relay_stop_threads()) {
+			ERR("Error stopping threads");
+		}
 		break;
 	case SIGUSR1:
 		CMM_STORE_SHARED(recv_child_signal, 1);
@@ -948,7 +961,7 @@ error_sock_control:
 	}
 	health_unregister(health_relayd);
 	DBG("Relay listener thread cleanup complete");
-	stop_threads();
+	lttng_relay_stop_threads();
 	return NULL;
 }
 
@@ -1024,7 +1037,7 @@ error_testpoint:
 	}
 	health_unregister(health_relayd);
 	DBG("Dispatch thread dying");
-	stop_threads();
+	lttng_relay_stop_threads();
 	return NULL;
 }
 
@@ -2711,7 +2724,7 @@ error_testpoint:
 	}
 	health_unregister(health_relayd);
 	rcu_unregister_thread();
-	stop_threads();
+	lttng_relay_stop_threads();
 	return NULL;
 }
 
-- 
2.1.1
