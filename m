From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 12/13] Refactor consumerd
	main/cleanup
Date: Wed, 17 Dec 2014 20:45:23 -0500
Message-ID: <1418867124-17343-13-git-send-email-mathieu.desnoyers__16586.4941817292$1418867454$gmane$org@efficios.com>
References: <1418867124-17343-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y1QAP-0006EF-Ej
 for lttng-dev@lists.lttng.org; Wed, 17 Dec 2014 20:46:15 -0500
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
 src/bin/lttng-consumerd/lttng-consumerd.c | 259 ++++++++++++++++++++----------
 1 file changed, 170 insertions(+), 89 deletions(-)

diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c b/src/bin/lttng-consumerd/lttng-consumerd.c
index d0d8398..b43e8f1 100644
--- a/src/bin/lttng-consumerd/lttng-consumerd.c
+++ b/src/bin/lttng-consumerd/lttng-consumerd.c
@@ -294,12 +294,20 @@ static void set_ulimit(void)
  */
 int main(int argc, char **argv)
 {
-	int ret = 0;
+	int ret = 0, retval = 0;
 	void *status;
 
+	if (set_signal_handler()) {
+		retval = -1;
+		goto exit_set_signal_handler;
+	}
+
 	/* Parse arguments */
 	progname = argv[0];
-	parse_args(argc, argv);
+	if (parse_args(argc, argv)) {
+		retval = -1;
+		goto exit_options;
+	}
 
 	/* Daemonize */
 	if (opt_daemon) {
@@ -313,7 +321,8 @@ int main(int argc, char **argv)
 		ret = daemon(0, 0);
 		if (ret < 0) {
 			PERROR("daemon");
-			goto error;
+			retval = -1;
+			goto exit_options;
 		}
 		/*
 		 * We are in the child. Make sure all other file
@@ -325,36 +334,65 @@ int main(int argc, char **argv)
 		}
 	}
 
+	/*
+	 * Starting from here, we can create threads. This needs to be after
+	 * lttng_daemonize due to RCU.
+	 */
+
+	health_consumerd = health_app_create(NR_HEALTH_CONSUMERD_TYPES);
+	if (!health_consumerd) {
+		retval = -1;
+		goto exit_health_consumerd_cleanup;
+	}
+
 	/* Set up max poll set size */
 	lttng_poll_set_max_size();
 
 	if (*command_sock_path == '\0') {
 		switch (opt_type) {
 		case LTTNG_CONSUMER_KERNEL:
-			snprintf(command_sock_path, PATH_MAX, DEFAULT_KCONSUMERD_CMD_SOCK_PATH,
+			ret = snprintf(command_sock_path, PATH_MAX,
+					DEFAULT_KCONSUMERD_CMD_SOCK_PATH,
 					DEFAULT_LTTNG_RUNDIR);
+			if (ret < 0) {
+				retval = -1;
+				goto exit_init_data;
+			}
 			break;
 		case LTTNG_CONSUMER64_UST:
-			snprintf(command_sock_path, PATH_MAX,
-					DEFAULT_USTCONSUMERD64_CMD_SOCK_PATH, DEFAULT_LTTNG_RUNDIR);
+			ret = snprintf(command_sock_path, PATH_MAX,
+					DEFAULT_USTCONSUMERD64_CMD_SOCK_PATH,
+					DEFAULT_LTTNG_RUNDIR);
+			if (ret < 0) {
+				retval = -1;
+				goto exit_init_data;
+			}
 			break;
 		case LTTNG_CONSUMER32_UST:
-			snprintf(command_sock_path, PATH_MAX,
-					DEFAULT_USTCONSUMERD32_CMD_SOCK_PATH, DEFAULT_LTTNG_RUNDIR);
+			ret = snprintf(command_sock_path, PATH_MAX,
+					DEFAULT_USTCONSUMERD32_CMD_SOCK_PATH,
+					DEFAULT_LTTNG_RUNDIR);
+			if (ret < 0) {
+				retval = -1;
+				goto exit_init_data;
+			}
 			break;
 		default:
-			WARN("Unknown consumerd type");
-			goto error;
+			ERR("Unknown consumerd type");
+			retval = -1;
+			goto exit_init_data;
 		}
 	}
 
 	/* Init */
-	if (lttng_consumer_init() < 0) {
-		goto error;
+	if (lttng_consumer_init()) {
+		retval = -1;
+		goto exit_init_data;
 	}
 
-	/* Init socket timeouts */
+	/* Initialize communication library */
 	lttcomm_init();
+	/* Initialize TCP timeout values */
 	lttcomm_inet_init();
 
 	if (!getuid()) {
@@ -362,47 +400,58 @@ int main(int argc, char **argv)
 		set_ulimit();
 	}
 
-	health_consumerd = health_app_create(NR_HEALTH_CONSUMERD_TYPES);
-	if (!health_consumerd) {
-		goto error;
-	}
-
 	/* create the consumer instance with and assign the callbacks */
 	ctx = lttng_consumer_create(opt_type, lttng_consumer_read_subbuffer,
 		NULL, lttng_consumer_on_recv_stream, NULL);
-	if (ctx == NULL) {
-		goto error;
+	if (!ctx) {
+		retval = -1;
+		goto exit_init_data;
 	}
 
 	lttng_consumer_set_command_sock_path(ctx, command_sock_path);
 	if (*error_sock_path == '\0') {
 		switch (opt_type) {
 		case LTTNG_CONSUMER_KERNEL:
-			snprintf(error_sock_path, PATH_MAX, DEFAULT_KCONSUMERD_ERR_SOCK_PATH,
+			ret = snprintf(error_sock_path, PATH_MAX,
+					DEFAULT_KCONSUMERD_ERR_SOCK_PATH,
 					DEFAULT_LTTNG_RUNDIR);
+			if (ret < 0) {
+				retval = -1;
+				goto exit_init_data;
+			}
 			break;
 		case LTTNG_CONSUMER64_UST:
-			snprintf(error_sock_path, PATH_MAX,
-					DEFAULT_USTCONSUMERD64_ERR_SOCK_PATH, DEFAULT_LTTNG_RUNDIR);
+			ret = snprintf(error_sock_path, PATH_MAX,
+					DEFAULT_USTCONSUMERD64_ERR_SOCK_PATH,
+					DEFAULT_LTTNG_RUNDIR);
+			if (ret < 0) {
+				retval = -1;
+				goto exit_init_data;
+			}
 			break;
 		case LTTNG_CONSUMER32_UST:
-			snprintf(error_sock_path, PATH_MAX,
-					DEFAULT_USTCONSUMERD32_ERR_SOCK_PATH, DEFAULT_LTTNG_RUNDIR);
+			ret = snprintf(error_sock_path, PATH_MAX,
+					DEFAULT_USTCONSUMERD32_ERR_SOCK_PATH,
+					DEFAULT_LTTNG_RUNDIR);
+			if (ret < 0) {
+				retval = -1;
+				goto exit_init_data;
+			}
 			break;
 		default:
-			WARN("Unknown consumerd type");
-			goto error;
+			ERR("Unknown consumerd type");
+			retval = -1;
+			goto exit_init_data;
 		}
 	}
 
-	if (set_signal_handler() < 0) {
-		goto error;
-	}
-
 	/* Connect to the socket created by lttng-sessiond to report errors */
 	DBG("Connecting to error socket %s", error_sock_path);
 	ret = lttcomm_connect_unix_sock(error_sock_path);
-	/* not a fatal error, but all communication with lttng-sessiond will fail */
+	/*
+	 * Not a fatal error, but all communication with lttng-sessiond will
+	 * fail.
+	 */
 	if (ret < 0) {
 		WARN("Cannot connect to error socket (is lttng-sessiond started?)");
 	}
@@ -412,21 +461,26 @@ int main(int argc, char **argv)
 	 * Block RT signals used for UST periodical metadata flush and the live
 	 * timer in main, and create a dedicated thread to handle these signals.
 	 */
-	consumer_signal_init();
+	if (consumer_signal_init()) {
+		retval = -1;
+		goto exit_init_data;
+	}
 
 	ctx->type = opt_type;
 
-	ret = utils_create_pipe(health_quit_pipe);
-	if (ret < 0) {
-		goto error_health_pipe;
+	if (utils_create_pipe(health_quit_pipe)) {
+		retval = -1;
+		goto exit_health_pipe;
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
 
 	/*
@@ -439,35 +493,46 @@ int main(int argc, char **argv)
 	cmm_smp_mb();	/* Read ready before following operations */
 
 	/* Create thread to manage channels */
-	ret = pthread_create(&channel_thread, NULL, consumer_thread_channel_poll,
+	ret = pthread_create(&channel_thread, NULL,
+			consumer_thread_channel_poll,
 			(void *) ctx);
-	if (ret != 0) {
-		perror("pthread_create");
-		goto channel_error;
+	if (ret) {
+		errno = ret;
+		PERROR("pthread_create");
+		retval = -1;
+		goto exit_channel_thread;
 	}
 
 	/* Create thread to manage the polling/writing of trace metadata */
-	ret = pthread_create(&metadata_thread, NULL, consumer_thread_metadata_poll,
+	ret = pthread_create(&metadata_thread, NULL,
+			consumer_thread_metadata_poll,
 			(void *) ctx);
-	if (ret != 0) {
-		perror("pthread_create");
-		goto metadata_error;
+	if (ret) {
+		errno = ret;
+		PERROR("pthread_create");
+		retval = -1;
+		goto exit_metadata_thread;
 	}
 
 	/* Create thread to manage the polling/writing of trace data */
 	ret = pthread_create(&data_thread, NULL, consumer_thread_data_poll,
 			(void *) ctx);
-	if (ret != 0) {
-		perror("pthread_create");
-		goto data_error;
+	if (ret) {
+		errno = ret;
+		PERROR("pthread_create");
+		retval = -1;
+		goto exit_data_thread;
 	}
 
 	/* Create the thread to manage the receive of fd */
-	ret = pthread_create(&sessiond_thread, NULL, consumer_thread_sessiond_poll,
+	ret = pthread_create(&sessiond_thread, NULL,
+			consumer_thread_sessiond_poll,
 			(void *) ctx);
-	if (ret != 0) {
-		perror("pthread_create");
-		goto sessiond_error;
+	if (ret) {
+		errno = ret;
+		PERROR("pthread_create");
+		retval = -1;
+		goto exit_sessiond_thread;
 	}
 
 	/*
@@ -476,70 +541,86 @@ int main(int argc, char **argv)
 	 */
 	ret = pthread_create(&metadata_timer_thread, NULL,
 			consumer_timer_thread, (void *) ctx);
-	if (ret != 0) {
-		perror("pthread_create");
-		goto metadata_timer_error;
+	if (ret) {
+		errno = ret;
+		PERROR("pthread_create");
+		retval = -1;
+		goto exit_metadata_timer_thread;
 	}
 
 	ret = pthread_detach(metadata_timer_thread);
 	if (ret) {
 		errno = ret;
-		perror("pthread_detach");
+		PERROR("pthread_detach");
+		retval = -1;
+		goto exit_metadata_timer_detach;
 	}
 
-metadata_timer_error:
+	/*
+	 * This is where we start awaiting program completion (e.g. through
+	 * signal that asks threads to teardown.
+	 */
+
+exit_metadata_timer_detach:
+exit_metadata_timer_thread:
 	ret = pthread_join(sessiond_thread, &status);
-	if (ret != 0) {
-		perror("pthread_join");
-		goto error;
+	if (ret) {
+		errno = ret;
+		PERROR("pthread_join sessiond_thread");
+		retval = -1;
 	}
+exit_sessiond_thread:
 
-sessiond_error:
 	ret = pthread_join(data_thread, &status);
-	if (ret != 0) {
-		perror("pthread_join");
-		goto error;
+	if (ret) {
+		errno = ret;
+		PERROR("pthread_join data_thread");
+		retval = -1;
 	}
+exit_data_thread:
 
-data_error:
 	ret = pthread_join(metadata_thread, &status);
-	if (ret != 0) {
-		perror("pthread_join");
-		goto error;
+	if (ret) {
+		errno = ret;
+		PERROR("pthread_join metadata_thread");
+		retval = -1;
 	}
+exit_metadata_thread:
 
-metadata_error:
 	ret = pthread_join(channel_thread, &status);
-	if (ret != 0) {
-		perror("pthread_join");
-		goto error;
+	if (ret) {
+		errno = ret;
+		PERROR("pthread_join channel_thread");
+		retval = -1;
 	}
+exit_channel_thread:
 
-channel_error:
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
 
-health_error:
 	utils_close_pipe(health_quit_pipe);
+exit_health_pipe:
 
-error_health_pipe:
-	if (!ret) {
-		ret = EXIT_SUCCESS;
-		goto end;
-	}
-
-error:
-	ret = EXIT_FAILURE;
-
-end:
+exit_init_data:
 	lttng_consumer_destroy(ctx);
 	lttng_consumer_cleanup();
+
 	if (health_consumerd) {
 		health_app_destroy(health_consumerd);
 	}
+exit_health_consumerd_cleanup:
 
-	return ret;
+exit_options:
+
+exit_set_signal_handler:
+	if (!retval) {
+		exit(EXIT_SUCCESS);
+	} else {
+		exit(EXIT_FAILURE);
+	}
 }
-- 
2.1.1
