From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 13/13] Refactor relayd
	main/set_options/cleanup
Date: Wed, 17 Dec 2014 20:45:24 -0500
Message-ID: <1418867124-17343-14-git-send-email-mathieu.desnoyers__33344.547803472$1418867411$gmane$org@efficios.com>
References: <1418867124-17343-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y1QAJ-0006Do-NJ
 for lttng-dev@lists.lttng.org; Wed, 17 Dec 2014 20:46:09 -0500
In-Reply-To: <1418867124-17343-1-git-send-email-mathieu.desnoyers@efficios.com>
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

- Enforce symmetry between allocation and teardown,
- Handle all errors,
- Return all errors as EXIT_FAILURE,
- Standardize on zero being success, nonzero being error,
  (rather than < 0 being error),
- Fix pthread PERROR: we need to store ret into errno before
  calling PERROR, since pthread API does not set errno,
- Join errors now fall-through, rather than rely on the OS
  to teardown the rest.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-relayd/live.c | 127 ++++++++++++++++-----------
 src/bin/lttng-relayd/live.h |   5 +-
 src/bin/lttng-relayd/main.c | 207 ++++++++++++++++++++++++++------------------
 3 files changed, 202 insertions(+), 137 deletions(-)

diff --git a/src/bin/lttng-relayd/live.c b/src/bin/lttng-relayd/live.c
index 93d458b..beb67b2 100644
--- a/src/bin/lttng-relayd/live.c
+++ b/src/bin/lttng-relayd/live.c
@@ -95,7 +95,7 @@ static uint64_t last_relay_viewer_session_id;
  * Cleanup the daemon
  */
 static
-void cleanup(void)
+void cleanup_relayd_live(void)
 {
 	DBG("Cleaning up");
 
@@ -346,20 +346,22 @@ int notify_thread_pipe(int wpipe)
  * Stop all threads by closing the thread quit pipe.
  */
 static
-void stop_threads(void)
+int stop_threads(void)
 {
-	int ret;
+	int ret, retval = 0;
 
 	/* Stopping all threads */
 	DBG("Terminating all live threads");
 	ret = notify_thread_pipe(thread_quit_pipe[1]);
 	if (ret < 0) {
 		ERR("write error on thread quit pipe");
+		retval = -1;
 	}
 
 	/* Dispatch thread */
 	CMM_STORE_SHARED(live_dispatch_thread_exit, 1);
 	futex_nto1_wake(&viewer_conn_queue.futex);
+	return retval;
 }
 
 /*
@@ -591,7 +593,9 @@ error_sock_control:
 	}
 	health_unregister(health_relayd);
 	DBG("Live viewer listener thread cleanup complete");
-	stop_threads();
+	if (stop_threads()) {
+		ERR("Error stopping live threads");
+	}
 	return NULL;
 }
 
@@ -668,7 +672,9 @@ error_testpoint:
 	}
 	health_unregister(health_relayd);
 	DBG("Live viewer dispatch thread dying");
-	stop_threads();
+	if (stop_threads()) {
+		ERR("Error stopping live threads");
+	}
 	return NULL;
 }
 
@@ -2032,7 +2038,9 @@ error_testpoint:
 		ERR("Health error occurred in %s", __func__);
 	}
 	health_unregister(health_relayd);
-	stop_threads();
+	if (stop_threads()) {
+		ERR("Error stopping live threads");
+	}
 	rcu_unregister_thread();
 	return NULL;
 }
@@ -2043,55 +2051,59 @@ error_testpoint:
  */
 static int create_conn_pipe(void)
 {
-	int ret;
-
-	ret = utils_create_pipe_cloexec(live_conn_pipe);
+	return utils_create_pipe_cloexec(live_conn_pipe);
+}
 
-	return ret;
+int relayd_live_stop(void)
+{
+	return stop_threads();
 }
 
-void live_stop_threads(void)
+int relayd_live_join(void)
 {
-	int ret;
+	int ret, retval = 0;
 	void *status;
 
-	stop_threads();
-
 	ret = pthread_join(live_listener_thread, &status);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_join live listener");
-		goto error;	/* join error, exit without cleanup */
+		retval = -1;
 	}
 
 	ret = pthread_join(live_worker_thread, &status);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_join live worker");
-		goto error;	/* join error, exit without cleanup */
+		retval = -1;
 	}
 
 	ret = pthread_join(live_dispatcher_thread, &status);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_join live dispatcher");
-		goto error;	/* join error, exit without cleanup */
+		retval = -1;
 	}
 
-	cleanup();
+	cleanup_relayd_live();
 
-error:
-	return;
+	return retval;
 }
 
 /*
  * main
  */
-int live_start_threads(struct lttng_uri *uri,
+int relayd_live_create(struct lttng_uri *uri,
 		struct relay_local_data *relay_ctx)
 {
-	int ret = 0;
+	int ret = 0, retval = 0;
 	void *status;
 	int is_root;
 
-	assert(uri);
+	if (!uri) {
+		retval = -1;
+		goto exit_init_data;
+	}
 	live_uri = uri;
 
 	/* Check if daemon is UID = 0 */
@@ -2100,14 +2112,15 @@ int live_start_threads(struct lttng_uri *uri,
 	if (!is_root) {
 		if (live_uri->port < 1024) {
 			ERR("Need to be root to use ports < 1024");
-			ret = -1;
-			goto exit;
+			retval = -1;
+			goto exit_init_data;
 		}
 	}
 
 	/* Setup the thread apps communication pipe. */
-	if ((ret = create_conn_pipe()) < 0) {
-		goto exit;
+	if (create_conn_pipe()) {
+		retval = -1;
+		goto exit_init_data;
 	}
 
 	/* Init relay command queue. */
@@ -2119,55 +2132,65 @@ int live_start_threads(struct lttng_uri *uri,
 	/* Setup the dispatcher thread */
 	ret = pthread_create(&live_dispatcher_thread, NULL,
 			thread_dispatcher, (void *) NULL);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_create viewer dispatcher");
-		goto exit_dispatcher;
+		retval = -1;
+		goto exit_dispatcher_thread;
 	}
 
 	/* Setup the worker thread */
 	ret = pthread_create(&live_worker_thread, NULL,
 			thread_worker, relay_ctx);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_create viewer worker");
-		goto exit_worker;
+		retval = -1;
+		goto exit_worker_thread;
 	}
 
 	/* Setup the listener thread */
 	ret = pthread_create(&live_listener_thread, NULL,
 			thread_listener, (void *) NULL);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_create viewer listener");
-		goto exit_listener;
+		retval = -1;
+		goto exit_listener_thread;
 	}
 
-	ret = 0;
-	goto end;
+	/*
+	 * All OK, started all threads.
+	 */
+	return retval;
+
 
-exit_listener:
 	ret = pthread_join(live_listener_thread, &status);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_join live listener");
-		goto error;	/* join error, exit without cleanup */
+		retval = -1;
 	}
+exit_listener_thread:
 
-exit_worker:
 	ret = pthread_join(live_worker_thread, &status);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_join live worker");
-		goto error;	/* join error, exit without cleanup */
+		retval = -1;
 	}
+exit_worker_thread:
 
-exit_dispatcher:
 	ret = pthread_join(live_dispatcher_thread, &status);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_join live dispatcher");
-		goto error;	/* join error, exit without cleanup */
+		retval = -1;
 	}
+exit_dispatcher_thread:
 
-exit:
-	cleanup();
+exit_init_data:
+	cleanup_relayd_live();
 
-end:
-error:
-	return ret;
+	return retval;
 }
diff --git a/src/bin/lttng-relayd/live.h b/src/bin/lttng-relayd/live.h
index 52608a4..5db940b 100644
--- a/src/bin/lttng-relayd/live.h
+++ b/src/bin/lttng-relayd/live.h
@@ -23,9 +23,10 @@
 
 #include "lttng-relayd.h"
 
-int live_start_threads(struct lttng_uri *live_uri,
+int relayd_live_create(struct lttng_uri *live_uri,
 		struct relay_local_data *relay_ctx);
-void live_stop_threads(void);
+int relayd_live_stop(void);
+int relayd_live_join(void);
 
 struct relay_viewer_stream *live_find_viewer_stream_by_id(uint64_t stream_id);
 
diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index 27a428a..35725b6 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -336,7 +336,7 @@ end:
 static
 int set_options(int argc, char **argv)
 {
-	int c, ret = 0, option_index = 0;
+	int c, ret = 0, option_index = 0, retval = 0;
 	int orig_optopt = optopt, orig_optind = optind;
 	char *default_address, *optstring;
 	const char *config_path = NULL;
@@ -344,7 +344,7 @@ int set_options(int argc, char **argv)
 	optstring = utils_generate_optstring(long_options,
 			sizeof(long_options) / sizeof(struct option));
 	if (!optstring) {
-		ret = -ENOMEM;
+		retval = -ENOMEM;
 		goto exit;
 	}
 
@@ -353,7 +353,7 @@ int set_options(int argc, char **argv)
 	while ((c = getopt_long(argc, argv, optstring, long_options,
 					&option_index)) != -1) {
 		if (c == '?') {
-			ret = -EINVAL;
+			retval = -EINVAL;
 			goto exit;
 		} else if (c != 'f') {
 			continue;
@@ -370,8 +370,8 @@ int set_options(int argc, char **argv)
 	if (ret) {
 		if (ret > 0) {
 			ERR("Invalid configuration option at line %i", ret);
-			ret = -1;
 		}
+		retval = -1;
 		goto exit;
 	}
 
@@ -386,6 +386,7 @@ int set_options(int argc, char **argv)
 
 		ret = set_option(c, optarg, long_options[option_index].name);
 		if (ret < 0) {
+			retval = -1;
 			goto exit;
 		}
 	}
@@ -397,6 +398,7 @@ int set_options(int argc, char **argv)
 			DEFAULT_NETWORK_CONTROL_PORT);
 		if (ret < 0) {
 			PERROR("asprintf default data address");
+			retval = -1;
 			goto exit;
 		}
 
@@ -404,6 +406,7 @@ int set_options(int argc, char **argv)
 		free(default_address);
 		if (ret < 0) {
 			ERR("Invalid control URI specified");
+			retval = -1;
 			goto exit;
 		}
 	}
@@ -413,6 +416,7 @@ int set_options(int argc, char **argv)
 			DEFAULT_NETWORK_DATA_PORT);
 		if (ret < 0) {
 			PERROR("asprintf default data address");
+			retval = -1;
 			goto exit;
 		}
 
@@ -420,6 +424,7 @@ int set_options(int argc, char **argv)
 		free(default_address);
 		if (ret < 0) {
 			ERR("Invalid data URI specified");
+			retval = -1;
 			goto exit;
 		}
 	}
@@ -429,6 +434,7 @@ int set_options(int argc, char **argv)
 			DEFAULT_NETWORK_VIEWER_PORT);
 		if (ret < 0) {
 			PERROR("asprintf default viewer control address");
+			retval = -1;
 			goto exit;
 		}
 
@@ -436,23 +442,32 @@ int set_options(int argc, char **argv)
 		free(default_address);
 		if (ret < 0) {
 			ERR("Invalid viewer control URI specified");
+			retval = -1;
 			goto exit;
 		}
 	}
 
 exit:
 	free(optstring);
-	return ret;
+	return retval;
 }
 
 /*
  * Cleanup the daemon
  */
 static
-void cleanup(void)
+void relayd_cleanup(struct relay_local_data *relay_ctx)
 {
 	DBG("Cleaning up");
 
+	if (viewer_streams_ht)
+		lttng_ht_destroy(viewer_streams_ht);
+	if (relay_streams_ht)
+		lttng_ht_destroy(relay_streams_ht);
+	if (relay_ctx && relay_ctx->sessions_ht)
+		lttng_ht_destroy(relay_ctx->sessions_ht);
+	free(relay_ctx);
+
 	/* free the dynamically allocated opt_output_path */
 	free(opt_output_path);
 
@@ -514,6 +529,11 @@ void stop_threads(void)
 	/* Dispatch thread */
 	CMM_STORE_SHARED(dispatch_thread_exit, 1);
 	futex_nto1_wake(&relay_conn_queue.futex);
+
+	ret = relayd_live_stop();
+	if (ret) {
+		ERR("Error stopping live threads");
+	}
 }
 
 /*
@@ -2713,31 +2733,35 @@ static int create_relay_conn_pipe(void)
  */
 int main(int argc, char **argv)
 {
-	int ret = 0;
+	int ret = 0, retval = 0;
 	void *status;
-	struct relay_local_data *relay_ctx;
+	struct relay_local_data *relay_ctx = NULL;
 
 	/* Parse arguments */
 	progname = argv[0];
-	if ((ret = set_options(argc, argv)) < 0) {
-		goto exit;
+	if (set_options(argc, argv)) {
+		retval = -1;
+		goto exit_options;
 	}
 
-	if ((ret = set_signal_handler()) < 0) {
-		goto exit;
+	if (set_signal_handler()) {
+		retval = -1;
+		goto exit_options;
 	}
 
 	/* Try to create directory if -o, --output is specified. */
 	if (opt_output_path) {
 		if (*opt_output_path != '/') {
 			ERR("Please specify an absolute path for -o, --output PATH");
-			goto exit;
+			retval = -1;
+			goto exit_options;
 		}
 
 		ret = utils_mkdir_recursive(opt_output_path, S_IRWXU | S_IRWXG);
 		if (ret < 0) {
 			ERR("Unable to create %s", opt_output_path);
-			goto exit;
+			retval = -1;
+			goto exit_options;
 		}
 	}
 
@@ -2748,7 +2772,8 @@ int main(int argc, char **argv)
 		ret = lttng_daemonize(&child_ppid, &recv_child_signal,
 			!opt_background);
 		if (ret < 0) {
-			goto exit;
+			retval = -1;
+			goto exit_options;
 		}
 
 		/*
@@ -2761,9 +2786,19 @@ int main(int argc, char **argv)
 		}
 	}
 
+
+	/* Initialize thread health monitoring */
+	health_relayd = health_app_create(NR_HEALTH_RELAYD_TYPES);
+	if (!health_relayd) {
+		PERROR("health_app_create error");
+		retval = -1;
+		goto exit_health_app_create;
+	}
+
 	/* Create thread quit pipe */
-	if ((ret = init_thread_quit_pipe()) < 0) {
-		goto error;
+	if (init_thread_quit_pipe()) {
+		retval = -1;
+		goto exit_init_data;
 	}
 
 	/* We need those values for the file/dir creation. */
@@ -2774,14 +2809,15 @@ int main(int argc, char **argv)
 	if (relayd_uid == 0) {
 		if (control_uri->port < 1024 || data_uri->port < 1024 || live_uri->port < 1024) {
 			ERR("Need to be root to use ports < 1024");
-			ret = -1;
-			goto exit;
+			retval = -1;
+			goto exit_init_data;
 		}
 	}
 
 	/* Setup the thread apps communication pipe. */
-	if ((ret = create_relay_conn_pipe()) < 0) {
-		goto exit;
+	if (create_relay_conn_pipe()) {
+		retval = -1;
+		goto exit_init_data;
 	}
 
 	/* Init relay command queue. */
@@ -2797,134 +2833,139 @@ int main(int argc, char **argv)
 	relay_ctx = zmalloc(sizeof(struct relay_local_data));
 	if (!relay_ctx) {
 		PERROR("relay_ctx");
-		goto exit;
+		retval = -1;
+		goto exit_init_data;
 	}
 
 	/* tables of sessions indexed by session ID */
 	relay_ctx->sessions_ht = lttng_ht_new(0, LTTNG_HT_TYPE_U64);
 	if (!relay_ctx->sessions_ht) {
-		goto exit_relay_ctx_sessions;
+		retval = -1;
+		goto exit_init_data;
 	}
 
 	/* tables of streams indexed by stream ID */
 	relay_streams_ht = lttng_ht_new(0, LTTNG_HT_TYPE_U64);
 	if (!relay_streams_ht) {
-		goto exit_relay_ctx_streams;
+		retval = -1;
+		goto exit_init_data;
 	}
 
 	/* tables of streams indexed by stream ID */
 	viewer_streams_ht = lttng_ht_new(0, LTTNG_HT_TYPE_U64);
 	if (!viewer_streams_ht) {
-		goto exit_relay_ctx_viewer_streams;
-	}
-
-	/* Initialize thread health monitoring */
-	health_relayd = health_app_create(NR_HEALTH_RELAYD_TYPES);
-	if (!health_relayd) {
-		PERROR("health_app_create error");
-		goto exit_health_app_create;
+		retval = -1;
+		goto exit_init_data;
 	}
 
 	ret = utils_create_pipe(health_quit_pipe);
-	if (ret < 0) {
-		goto error_health_pipe;
+	if (ret) {
+		retval = -1;
+		goto exit_health_quit_pipe;
 	}
 
 	/* Create thread to manage the client socket */
 	ret = pthread_create(&health_thread, NULL,
 			thread_manage_health, (void *) NULL);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_create health");
-		goto health_error;
+		retval = -1;
+		goto exit_health_thread;
 	}
 
 	/* Setup the dispatcher thread */
 	ret = pthread_create(&dispatcher_thread, NULL,
 			relay_thread_dispatcher, (void *) NULL);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_create dispatcher");
-		goto exit_dispatcher;
+		retval = -1;
+		goto exit_dispatcher_thread;
 	}
 
 	/* Setup the worker thread */
 	ret = pthread_create(&worker_thread, NULL,
 			relay_thread_worker, (void *) relay_ctx);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_create worker");
-		goto exit_worker;
+		retval = -1;
+		goto exit_worker_thread;
 	}
 
 	/* Setup the listener thread */
 	ret = pthread_create(&listener_thread, NULL,
 			relay_thread_listener, (void *) NULL);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_create listener");
-		goto exit_listener;
+		retval = -1;
+		goto exit_listener_thread;
 	}
 
-	ret = live_start_threads(live_uri, relay_ctx);
-	if (ret != 0) {
+	ret = relayd_live_create(live_uri, relay_ctx);
+	if (ret) {
 		ERR("Starting live viewer threads");
+		retval = -1;
 		goto exit_live;
 	}
 
+	/*
+	 * This is where we start awaiting program completion (e.g. through
+	 * signal that asks threads to teardown).
+	 */
+
+	ret = relayd_live_join();
+	if (ret) {
+		retval = -1;
+	}
 exit_live:
+
 	ret = pthread_join(listener_thread, &status);
-	if (ret != 0) {
-		PERROR("pthread_join");
-		goto error;	/* join error, exit without cleanup */
+	if (ret) {
+		errno = ret;
+		PERROR("pthread_join listener_thread");
+		retval = -1;
 	}
 
-exit_listener:
+exit_listener_thread:
 	ret = pthread_join(worker_thread, &status);
-	if (ret != 0) {
-		PERROR("pthread_join");
-		goto error;	/* join error, exit without cleanup */
+	if (ret) {
+		errno = ret;
+		PERROR("pthread_join worker_thread");
+		retval = -1;
 	}
 
-exit_worker:
+exit_worker_thread:
 	ret = pthread_join(dispatcher_thread, &status);
-	if (ret != 0) {
-		PERROR("pthread_join");
-		goto error;	/* join error, exit without cleanup */
+	if (ret) {
+		errno = ret;
+		PERROR("pthread_join dispatcher_thread");
+		retval = -1;
 	}
+exit_dispatcher_thread:
 
-exit_dispatcher:
 	ret = pthread_join(health_thread, &status);
-	if (ret != 0) {
-		PERROR("pthread_join health thread");
-		goto error;	/* join error, exit without cleanup */
+	if (ret) {
+		errno = ret;
+		PERROR("pthread_join health_thread");
+		retval = -1;
 	}
+exit_health_thread:
 
-	/*
-	 * Stop live threads only after joining other threads.
-	 */
-	live_stop_threads();
-
-health_error:
 	utils_close_pipe(health_quit_pipe);
+exit_health_quit_pipe:
 
-error_health_pipe:
+exit_init_data:
 	health_app_destroy(health_relayd);
-
 exit_health_app_create:
-	lttng_ht_destroy(viewer_streams_ht);
-
-exit_relay_ctx_viewer_streams:
-	lttng_ht_destroy(relay_streams_ht);
-
-exit_relay_ctx_streams:
-	lttng_ht_destroy(relay_ctx->sessions_ht);
+exit_options:
+	relayd_cleanup(relay_ctx);
 
-exit_relay_ctx_sessions:
-	free(relay_ctx);
-
-exit:
-	cleanup();
-	if (!ret) {
+	if (!retval) {
 		exit(EXIT_SUCCESS);
+	} else {
+		exit(EXIT_FAILURE);
 	}
-
-error:
-	exit(EXIT_FAILURE);
 }
-- 
2.1.1
