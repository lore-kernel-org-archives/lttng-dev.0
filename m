From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 11/13] Refactor sessiond
	main/cleanup/ht-cleanup
Date: Wed, 17 Dec 2014 20:45:22 -0500
Message-ID: <1418867124-17343-12-git-send-email-mathieu.desnoyers__23759.11829663$1418867516$gmane$org@efficios.com>
References: <1418867124-17343-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y1QAT-0006Eh-3l
 for lttng-dev@lists.lttng.org; Wed, 17 Dec 2014 20:46:21 -0500
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

Main reason for this entire patchset: move teardown of ht-cleanup thread
_after_ the sessiond cleanup which needs to destroy hash tables. This
fixes leaks at sessiond teardown that makes the valgrind output hard to
use. As this has been done, various other issues with error handling,
leaks, and symmetry of allocation and teardown have been fixed, which
makes this a refactoring.

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
 src/bin/lttng-sessiond/ht-cleanup.c     |  41 +-
 src/bin/lttng-sessiond/lttng-sessiond.h |   4 +
 src/bin/lttng-sessiond/main.c           | 781 ++++++++++++++++++++------------
 3 files changed, 529 insertions(+), 297 deletions(-)

diff --git a/src/bin/lttng-sessiond/ht-cleanup.c b/src/bin/lttng-sessiond/ht-cleanup.c
index 0469f92..79fb9cd 100644
--- a/src/bin/lttng-sessiond/ht-cleanup.c
+++ b/src/bin/lttng-sessiond/ht-cleanup.c
@@ -47,7 +47,7 @@ void *thread_ht_cleanup(void *data)
 
 	health_code_update();
 
-	ret = sessiond_set_thread_pollset(&events, 2);
+	ret = sessiond_set_ht_cleanup_thread_pollset(&events, 2);
 	if (ret < 0) {
 		goto error_poll_create;
 	}
@@ -61,11 +61,14 @@ void *thread_ht_cleanup(void *data)
 	health_code_update();
 
 	while (1) {
+		int handled_event;
+
 		DBG3("[ht-thread] Polling on %d fds.",
 			LTTNG_POLL_GETNB(&events));
 
 		/* Inifinite blocking call, waiting for transmission */
 restart:
+		handled_event = 0;
 		health_poll_entry();
 		ret = lttng_poll_wait(&events, -1);
 		health_poll_exit();
@@ -90,13 +93,9 @@ restart:
 			revents = LTTNG_POLL_GETEV(&events, i);
 			pollfd = LTTNG_POLL_GETFD(&events, i);
 
-			/* Thread quit pipe has been closed. Killing thread. */
-			ret = sessiond_check_thread_quit_pipe(pollfd, revents);
-			if (ret) {
-				err = 0;
-				goto exit;
+			if (pollfd != ht_cleanup_pipe[0]) {
+				continue;
 			}
-			assert(pollfd == ht_cleanup_pipe[0]);
 
 			if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
 				ERR("ht cleanup pipe error");
@@ -125,6 +124,30 @@ restart:
 
 			health_code_update();
 		}
+
+		/* Only check cleanup quit when no more work to do. */
+		if (handled_event) {
+			continue;
+		}
+
+		for (i = 0; i < nb_fd; i++) {
+			health_code_update();
+
+			/* Fetch once the poll data */
+			revents = LTTNG_POLL_GETEV(&events, i);
+			pollfd = LTTNG_POLL_GETFD(&events, i);
+
+			if (pollfd == ht_cleanup_pipe[0]) {
+				continue;
+			}
+
+			/* Thread quit pipe has been closed. Killing thread. */
+			ret = sessiond_check_ht_cleanup_quit(pollfd, revents);
+			if (ret) {
+				err = 0;
+				goto exit;
+			}
+		}
 	}
 
 exit:
@@ -132,9 +155,7 @@ error:
 	lttng_poll_clean(&events);
 error_poll_create:
 error_testpoint:
-	utils_close_pipe(ht_cleanup_pipe);
-	ht_cleanup_pipe[0] = ht_cleanup_pipe[1] = -1;
-	DBG("[ust-thread] cleanup complete.");
+	DBG("[ht-cleanup] Thread terminates.");
 	if (err) {
 		health_error();
 		ERR("Health error occurred in %s", __func__);
diff --git a/src/bin/lttng-sessiond/lttng-sessiond.h b/src/bin/lttng-sessiond/lttng-sessiond.h
index 488cf2f..07a6edd 100644
--- a/src/bin/lttng-sessiond/lttng-sessiond.h
+++ b/src/bin/lttng-sessiond/lttng-sessiond.h
@@ -121,6 +121,10 @@ extern int is_root;
 int sessiond_set_thread_pollset(struct lttng_poll_event *events, size_t size);
 int sessiond_check_thread_quit_pipe(int fd, uint32_t events);
 
+int sessiond_set_ht_cleanup_thread_pollset(struct lttng_poll_event *events,
+		size_t size);
+int sessiond_check_ht_cleanup_quit(int fd, uint32_t events);
+
 void *thread_ht_cleanup(void *data);
 
 void sessiond_notify_ready(void);
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 0b116e1..f418d74 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -189,6 +189,7 @@ static int kernel_poll_pipe[2] = { -1, -1 };
  * for all threads when receiving an event on the pipe.
  */
 static int thread_quit_pipe[2] = { -1, -1 };
+static int ht_cleanup_quit_pipe[2] = { -1, -1 };
 
 /*
  * This pipe is used to inform the thread managing application communication
@@ -384,10 +385,9 @@ void setup_consumerd_path(void)
 	}
 }
 
-/*
- * Create a poll set with O_CLOEXEC and add the thread quit pipe to the set.
- */
-int sessiond_set_thread_pollset(struct lttng_poll_event *events, size_t size)
+static
+int __sessiond_set_thread_pollset(struct lttng_poll_event *events, size_t size,
+		int *a_pipe)
 {
 	int ret;
 
@@ -399,7 +399,7 @@ int sessiond_set_thread_pollset(struct lttng_poll_event *events, size_t size)
 	}
 
 	/* Add quit pipe */
-	ret = lttng_poll_add(events, thread_quit_pipe[0], LPOLLIN | LPOLLERR);
+	ret = lttng_poll_add(events, a_pipe[0], LPOLLIN | LPOLLERR);
 	if (ret < 0) {
 		goto error;
 	}
@@ -411,17 +411,52 @@ error:
 }
 
 /*
+ * Create a poll set with O_CLOEXEC and add the thread quit pipe to the set.
+ */
+int sessiond_set_thread_pollset(struct lttng_poll_event *events, size_t size)
+{
+	return __sessiond_set_thread_pollset(events, size, thread_quit_pipe);
+}
+
+/*
+ * Create a poll set with O_CLOEXEC and add the thread quit pipe to the set.
+ */
+int sessiond_set_ht_cleanup_thread_pollset(struct lttng_poll_event *events,
+		size_t size)
+{
+	return __sessiond_set_thread_pollset(events, size,
+			ht_cleanup_quit_pipe);
+}
+
+static
+int __sessiond_check_thread_quit_pipe(int fd, uint32_t events, int a_pipe)
+{
+	if (fd == a_pipe && (events & LPOLLIN)) {
+		return 1;
+	}
+	return 0;
+}
+
+/*
  * Check if the thread quit pipe was triggered.
  *
  * Return 1 if it was triggered else 0;
  */
 int sessiond_check_thread_quit_pipe(int fd, uint32_t events)
 {
-	if (fd == thread_quit_pipe[0] && (events & LPOLLIN)) {
-		return 1;
-	}
+	return __sessiond_check_thread_quit_pipe(fd, events,
+			thread_quit_pipe[0]);
+}
 
-	return 0;
+/*
+ * Check if the ht_cleanup thread quit pipe was triggered.
+ *
+ * Return 1 if it was triggered else 0;
+ */
+int sessiond_check_ht_cleanup_quit(int fd, uint32_t events)
+{
+	return __sessiond_check_thread_quit_pipe(fd, events,
+			ht_cleanup_quit_pipe[0]);
 }
 
 /*
@@ -429,18 +464,18 @@ int sessiond_check_thread_quit_pipe(int fd, uint32_t events)
  *
  * Return -1 on error or 0 if all pipes are created.
  */
-static int init_thread_quit_pipe(void)
+static int __init_thread_quit_pipe(int *a_pipe)
 {
 	int ret, i;
 
-	ret = pipe(thread_quit_pipe);
+	ret = pipe(a_pipe);
 	if (ret < 0) {
 		PERROR("thread quit pipe");
 		goto error;
 	}
 
 	for (i = 0; i < 2; i++) {
-		ret = fcntl(thread_quit_pipe[i], F_SETFD, FD_CLOEXEC);
+		ret = fcntl(a_pipe[i], F_SETFD, FD_CLOEXEC);
 		if (ret < 0) {
 			PERROR("fcntl");
 			goto error;
@@ -451,6 +486,16 @@ error:
 	return ret;
 }
 
+static int init_thread_quit_pipe(void)
+{
+	return __init_thread_quit_pipe(thread_quit_pipe);
+}
+
+static int init_ht_cleanup_quit_pipe(void)
+{
+	return __init_thread_quit_pipe(ht_cleanup_quit_pipe);
+}
+
 /*
  * Stop all threads by closing the thread quit pipe.
  */
@@ -537,15 +582,15 @@ static int generate_lock_file_path(char *path, size_t len)
 }
 
 /*
- * Cleanup the daemon
+ * Cleanup the session daemon's data structures.
  */
-static void cleanup(void)
+static void sessiond_cleanup(void)
 {
 	int ret;
 	struct ltt_session *sess, *stmp;
 	char path[PATH_MAX];
 
-	DBG("Cleaning up");
+	DBG("Cleanup up sessiond");
 
 	/*
 	 * Close the thread quit pipe. It has already done its job,
@@ -649,34 +694,6 @@ static void cleanup(void)
 
 	close_consumer_sockets();
 
-	/*
-	 * If the override option is set, the pointer points to a *non* const thus
-	 * freeing it even though the variable type is set to const.
-	 */
-	if (tracing_group_name_override) {
-		free((void *) tracing_group_name);
-	}
-	if (consumerd32_bin_override) {
-		free((void *) consumerd32_bin);
-	}
-	if (consumerd64_bin_override) {
-		free((void *) consumerd64_bin);
-	}
-	if (consumerd32_libdir_override) {
-		free((void *) consumerd32_libdir);
-	}
-	if (consumerd64_libdir_override) {
-		free((void *) consumerd64_libdir);
-	}
-
-	if (opt_pidfile) {
-		free(opt_pidfile);
-	}
-
-	if (opt_load_session_path) {
-		free(opt_load_session_path);
-	}
-
 	if (load_info) {
 		load_session_destroy_data(load_info);
 		free(load_info);
@@ -689,7 +706,8 @@ static void cleanup(void)
 	if (lockfile_fd >= 0) {
 		char lockfile_path[PATH_MAX];
 
-		ret = generate_lock_file_path(lockfile_path, sizeof(lockfile_path));
+		ret = generate_lock_file_path(lockfile_path,
+				sizeof(lockfile_path));
 		if (ret > 0) {
 			ret = remove(lockfile_path);
 			if (ret < 0) {
@@ -709,6 +727,39 @@ static void cleanup(void)
 	 */
 
 	free(rundir);
+}
+
+/*
+ * Cleanup the daemon's option data structures.
+ */
+static void sessiond_cleanup_options(void)
+{
+	DBG("Cleaning up options");
+
+	/*
+	 * If the override option is set, the pointer points to a *non* const
+	 * thus freeing it even though the variable type is set to const.
+	 */
+	if (tracing_group_name_override) {
+		free((void *) tracing_group_name);
+	}
+	if (consumerd32_bin_override) {
+		free((void *) consumerd32_bin);
+	}
+	if (consumerd64_bin_override) {
+		free((void *) consumerd64_bin);
+	}
+	if (consumerd32_libdir_override) {
+		free((void *) consumerd32_libdir);
+	}
+	if (consumerd64_libdir_override) {
+		free((void *) consumerd64_libdir);
+	}
+
+	free(opt_pidfile);
+	free(opt_load_session_path);
+	free(kmod_probes_list);
+	free(kmod_extra_probes_list);
 
 	/* <fun> */
 	DBG("%c[%d;%dm*** assert failed :-) *** ==> %c[%dm%c[%d;%dm"
@@ -873,42 +924,47 @@ static int update_kernel_stream(struct consumer_data *consumer_data, int fd)
 		}
 		ksess = session->kernel_session;
 
-		cds_list_for_each_entry(channel, &ksess->channel_list.head, list) {
-			if (channel->fd == fd) {
-				DBG("Channel found, updating kernel streams");
-				ret = kernel_open_channel_stream(channel);
-				if (ret < 0) {
-					goto error;
-				}
-				/* Update the stream global counter */
-				ksess->stream_count_global += ret;
+		cds_list_for_each_entry(channel,
+				&ksess->channel_list.head, list) {
+			struct lttng_ht_iter iter;
+			struct consumer_socket *socket;
 
-				/*
-				 * Have we already sent fds to the consumer? If yes, it means
-				 * that tracing is started so it is safe to send our updated
-				 * stream fds.
-				 */
-				if (ksess->consumer_fds_sent == 1 && ksess->consumer != NULL) {
-					struct lttng_ht_iter iter;
-					struct consumer_socket *socket;
-
-					rcu_read_lock();
-					cds_lfht_for_each_entry(ksess->consumer->socks->ht,
-							&iter.iter, socket, node.node) {
-						pthread_mutex_lock(socket->lock);
-						ret = kernel_consumer_send_channel_stream(socket,
-								channel, ksess,
-								session->output_traces ? 1 : 0);
-						pthread_mutex_unlock(socket->lock);
-						if (ret < 0) {
-							rcu_read_unlock();
-							goto error;
-						}
-					}
+			if (channel->fd != fd) {
+				continue;
+			}
+			DBG("Channel found, updating kernel streams");
+			ret = kernel_open_channel_stream(channel);
+			if (ret < 0) {
+				goto error;
+			}
+			/* Update the stream global counter */
+			ksess->stream_count_global += ret;
+
+			/*
+			 * Have we already sent fds to the consumer? If yes, it
+			 * means that tracing is started so it is safe to send
+			 * our updated stream fds.
+			 */
+			if (ksess->consumer_fds_sent != 1
+					|| ksess->consumer == NULL) {
+				ret = -1;
+				goto error;
+			}
+
+			rcu_read_lock();
+			cds_lfht_for_each_entry(ksess->consumer->socks->ht,
+					&iter.iter, socket, node.node) {
+				pthread_mutex_lock(socket->lock);
+				ret = kernel_consumer_send_channel_stream(socket,
+						channel, ksess,
+						session->output_traces ? 1 : 0);
+				pthread_mutex_unlock(socket->lock);
+				if (ret < 0) {
 					rcu_read_unlock();
+					goto error;
 				}
-				goto error;
 			}
+			rcu_read_unlock();
 		}
 		session_unlock(session);
 	}
@@ -2148,7 +2204,7 @@ static int spawn_consumer_thread(struct consumer_data *consumer_data)
 
 	/* Setup pthread condition */
 	ret = pthread_condattr_init(&consumer_data->condattr);
-	if (ret != 0) {
+	if (ret) {
 		errno = ret;
 		PERROR("pthread_condattr_init consumer data");
 		goto error;
@@ -2160,14 +2216,14 @@ static int spawn_consumer_thread(struct consumer_data *consumer_data)
 	 * for a more details and how we noticed it.
 	 */
 	ret = pthread_condattr_setclock(&consumer_data->condattr, CLOCK_MONOTONIC);
-	if (ret != 0) {
+	if (ret) {
 		errno = ret;
 		PERROR("pthread_condattr_setclock consumer data");
 		goto error;
 	}
 
 	ret = pthread_cond_init(&consumer_data->cond, &consumer_data->condattr);
-	if (ret != 0) {
+	if (ret) {
 		errno = ret;
 		PERROR("pthread_cond_init consumer data");
 		goto error;
@@ -2175,7 +2231,8 @@ static int spawn_consumer_thread(struct consumer_data *consumer_data)
 
 	ret = pthread_create(&consumer_data->thread, NULL, thread_manage_consumer,
 			consumer_data);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_create consumer");
 		ret = -1;
 		goto error;
@@ -2271,7 +2328,7 @@ static int join_consumer_thread(struct consumer_data *consumer_data)
 		int ret;
 		ret = kill(consumer_data->pid, SIGTERM);
 		if (ret) {
-			ERR("Error killing consumer daemon");
+			PERROR("Error killing consumer daemon");
 			return ret;
 		}
 		return pthread_join(consumer_data->thread, &status);
@@ -4193,6 +4250,28 @@ error_create_poll:
 	DBG("Client thread dying");
 
 	rcu_unregister_thread();
+
+	/*
+	 * Since we are creating the consumer threads, we own them, so we need
+	 * to join them before our thread exits.
+	 */
+	ret = join_consumer_thread(&kconsumer_data);
+	if (ret) {
+		errno = ret;
+		PERROR("join_consumer");
+	}
+
+	ret = join_consumer_thread(&ustconsumer32_data);
+	if (ret) {
+		errno = ret;
+		PERROR("join_consumer ust32");
+	}
+
+	ret = join_consumer_thread(&ustconsumer64_data);
+	if (ret) {
+		errno = ret;
+		PERROR("join_consumer ust64");
+	}
 	return NULL;
 }
 
@@ -4291,7 +4370,7 @@ static int set_option(int opt, const char *arg, const char *optname)
 		break;
 	case 'h':
 		usage();
-		exit(EXIT_FAILURE);
+		exit(EXIT_SUCCESS);
 	case 'V':
 		fprintf(stdout, "%s\n", VERSION);
 		exit(EXIT_SUCCESS);
@@ -4926,7 +5005,7 @@ static void set_ulimit(void)
 /*
  * Write pidfile using the rundir and opt_pidfile.
  */
-static void write_pidfile(void)
+static int write_pidfile(void)
 {
 	int ret;
 	char pidfile_path[PATH_MAX];
@@ -4946,13 +5025,11 @@ static void write_pidfile(void)
 	}
 
 	/*
-	 * Create pid file in rundir. Return value is of no importance. The
-	 * execution will continue even though we are not able to write the file.
+	 * Create pid file in rundir.
 	 */
-	(void) utils_create_pid_file(getpid(), pidfile_path);
-
+	ret = utils_create_pid_file(getpid(), pidfile_path);
 error:
-	return;
+	return ret;
 }
 
 /*
@@ -4976,7 +5053,7 @@ error:
 /*
  * Write agent TCP port using the rundir.
  */
-static void write_agent_port(void)
+static int write_agent_port(void)
 {
 	int ret;
 	char path[PATH_MAX];
@@ -4991,43 +5068,12 @@ static void write_agent_port(void)
 	}
 
 	/*
-	 * Create TCP agent port file in rundir. Return value is of no importance.
-	 * The execution will continue even though we are not able to write the
-	 * file.
+	 * Create TCP agent port file in rundir.
 	 */
-	(void) utils_create_pid_file(agent_tcp_port, path);
+	ret = utils_create_pid_file(agent_tcp_port, path);
 
 error:
-	return;
-}
-
-/*
- * Start the load session thread and dettach from it so the main thread can
- * continue. This does not return a value since whatever the outcome, the main
- * thread will continue.
- */
-static void start_load_session_thread(void)
-{
-	int ret;
-
-	/* Create session loading thread. */
-	ret = pthread_create(&load_session_thread, NULL, thread_load_session,
-			load_info);
-	if (ret != 0) {
-		PERROR("pthread_create load_session_thread");
-		goto error_create;
-	}
-
-	ret = pthread_detach(load_session_thread);
-	if (ret != 0) {
-		PERROR("pthread_detach load_session_thread");
-	}
-
-	/* Everything went well so don't cleanup anything. */
-
-error_create:
-	/* The cleanup() function will destroy the load_info data. */
-	return;
+	return ret;
 }
 
 /*
@@ -5035,7 +5081,7 @@ error_create:
  */
 int main(int argc, char **argv)
 {
-	int ret = 0;
+	int ret = 0, retval = 0;
 	void *status;
 	const char *home_path, *env_app_timeout;
 
@@ -5043,8 +5089,9 @@ int main(int argc, char **argv)
 
 	rcu_register_thread();
 
-	if ((ret = set_signal_handler()) < 0) {
-		goto error;
+	if (set_signal_handler()) {
+		retval = -1;
+		goto exit_set_signal_handler;
 	}
 
 	setup_consumerd_path();
@@ -5056,10 +5103,18 @@ int main(int argc, char **argv)
 		WARN("Fallback page size to %ld", page_size);
 	}
 
-	/* Parse arguments and load the daemon configuration file */
+	/*
+	 * Parse arguments and load the daemon configuration file.
+	 *
+	 * We have an exit_options exit path to free memory reserved by
+	 * set_options. This is needed because the rest of sessiond_cleanup()
+	 * depends on ht_cleanup_thread, which depends on lttng_daemonize, which
+	 * depends on set_options.
+	 */
 	progname = argv[0];
-	if ((ret = set_options(argc, argv)) < 0) {
-		goto error;
+	if (set_options(argc, argv)) {
+		retval = -1;
+		goto exit_options;
 	}
 
 	/* Daemonize */
@@ -5069,22 +5124,61 @@ int main(int argc, char **argv)
 		ret = lttng_daemonize(&child_ppid, &recv_child_signal,
 			!opt_background);
 		if (ret < 0) {
-			goto error;
+			retval = -1;
+			goto exit_options;
 		}
 
 		/*
 		 * We are in the child. Make sure all other file descriptors are
-		 * closed, in case we are called with more opened file descriptors than
-		 * the standard ones.
+		 * closed, in case we are called with more opened file
+		 * descriptors than the standard ones.
 		 */
 		for (i = 3; i < sysconf(_SC_OPEN_MAX); i++) {
 			(void) close(i);
 		}
 	}
 
+	/*
+	 * Starting from here, we can create threads. This needs to be after
+	 * lttng_daemonize due to RCU.
+	 */
+
+	/*
+	 * Initialize the health check subsystem. This call should set the
+	 * appropriate time values.
+	 */
+	health_sessiond = health_app_create(NR_HEALTH_SESSIOND_TYPES);
+	if (!health_sessiond) {
+		PERROR("health_app_create error");
+		retval = -1;
+		goto exit_health_sessiond_cleanup;
+	}
+
+	if (init_ht_cleanup_quit_pipe()) {
+		retval = -1;
+		goto exit_ht_cleanup_quit_pipe;
+	}
+
+	/* Setup the thread ht_cleanup communication pipe. */
+	if (utils_create_pipe_cloexec(ht_cleanup_pipe)) {
+		retval = -1;
+		goto exit_ht_cleanup_pipe;
+	}
+
+	/* Create thread to clean up RCU hash tables */
+	ret = pthread_create(&ht_cleanup_thread, NULL,
+			thread_ht_cleanup, (void *) NULL);
+	if (ret) {
+		errno = ret;
+		PERROR("pthread_create ht_cleanup");
+		retval = -1;
+		goto exit_ht_cleanup;
+	}
+
 	/* Create thread quit pipe */
-	if ((ret = init_thread_quit_pipe()) < 0) {
-		goto error;
+	if (init_thread_quit_pipe()) {
+		retval = -1;
+		goto exit_init_data;
 	}
 
 	/* Check if daemon is UID = 0 */
@@ -5093,42 +5187,67 @@ int main(int argc, char **argv)
 	if (is_root) {
 		rundir = strdup(DEFAULT_LTTNG_RUNDIR);
 		if (!rundir) {
-			ret = -ENOMEM;
-			goto error;
+			retval = -1;
+			goto exit_init_data;
 		}
 
 		/* Create global run dir with root access */
-		ret = create_lttng_rundir(rundir);
-		if (ret < 0) {
-			goto error;
+		if (create_lttng_rundir(rundir)) {
+			retval = -1;
+			goto exit_init_data;
 		}
 
 		if (strlen(apps_unix_sock_path) == 0) {
-			snprintf(apps_unix_sock_path, PATH_MAX,
+			ret = snprintf(apps_unix_sock_path, PATH_MAX,
 					DEFAULT_GLOBAL_APPS_UNIX_SOCK);
+			if (ret < 0) {
+				retval = -1;
+				goto exit_init_data;
+			}
 		}
 
 		if (strlen(client_unix_sock_path) == 0) {
-			snprintf(client_unix_sock_path, PATH_MAX,
+			ret = snprintf(client_unix_sock_path, PATH_MAX,
 					DEFAULT_GLOBAL_CLIENT_UNIX_SOCK);
+			if (ret < 0) {
+				retval = -1;
+				goto exit_init_data;
+			}
 		}
 
 		/* Set global SHM for ust */
 		if (strlen(wait_shm_path) == 0) {
-			snprintf(wait_shm_path, PATH_MAX,
+			ret = snprintf(wait_shm_path, PATH_MAX,
 					DEFAULT_GLOBAL_APPS_WAIT_SHM_PATH);
+			if (ret < 0) {
+				retval = -1;
+				goto exit_init_data;
+			}
 		}
 
 		if (strlen(health_unix_sock_path) == 0) {
-			snprintf(health_unix_sock_path, sizeof(health_unix_sock_path),
+			ret = snprintf(health_unix_sock_path,
+					sizeof(health_unix_sock_path),
 					DEFAULT_GLOBAL_HEALTH_UNIX_SOCK);
+			if (ret < 0) {
+				retval = -1;
+				goto exit_init_data;
+			}
 		}
 
 		/* Setup kernel consumerd path */
-		snprintf(kconsumer_data.err_unix_sock_path, PATH_MAX,
+		ret = snprintf(kconsumer_data.err_unix_sock_path, PATH_MAX,
 				DEFAULT_KCONSUMERD_ERR_SOCK_PATH, rundir);
-		snprintf(kconsumer_data.cmd_unix_sock_path, PATH_MAX,
+		if (ret < 0) {
+			retval = -1;
+			goto exit_init_data;
+		}
+		ret = snprintf(kconsumer_data.cmd_unix_sock_path, PATH_MAX,
 				DEFAULT_KCONSUMERD_CMD_SOCK_PATH, rundir);
+		if (ret < 0) {
+			retval = -1;
+			goto exit_init_data;
+		}
 
 		DBG2("Kernel consumer err path: %s",
 				kconsumer_data.err_unix_sock_path);
@@ -5139,8 +5258,8 @@ int main(int argc, char **argv)
 		if (home_path == NULL) {
 			/* TODO: Add --socket PATH option */
 			ERR("Can't get HOME directory for sockets creation.");
-			ret = -EPERM;
-			goto error;
+			retval = -1;
+			goto exit_init_data;
 		}
 
 		/*
@@ -5149,42 +5268,64 @@ int main(int argc, char **argv)
 		 */
 		ret = asprintf(&rundir, DEFAULT_LTTNG_HOME_RUNDIR, home_path);
 		if (ret < 0) {
-			ret = -ENOMEM;
-			goto error;
+			retval = -1;
+			goto exit_init_data;
 		}
 
-		ret = create_lttng_rundir(rundir);
-		if (ret < 0) {
-			goto error;
+		if (create_lttng_rundir(rundir)) {
+			retval = -1;
+			goto exit_init_data;
 		}
 
 		if (strlen(apps_unix_sock_path) == 0) {
-			snprintf(apps_unix_sock_path, PATH_MAX,
-					DEFAULT_HOME_APPS_UNIX_SOCK, home_path);
+			ret = snprintf(apps_unix_sock_path, PATH_MAX,
+					DEFAULT_HOME_APPS_UNIX_SOCK,
+					home_path);
+			if (ret < 0) {
+				retval = -1;
+				goto exit_init_data;
+			}
 		}
 
 		/* Set the cli tool unix socket path */
 		if (strlen(client_unix_sock_path) == 0) {
-			snprintf(client_unix_sock_path, PATH_MAX,
-					DEFAULT_HOME_CLIENT_UNIX_SOCK, home_path);
+			ret = snprintf(client_unix_sock_path, PATH_MAX,
+					DEFAULT_HOME_CLIENT_UNIX_SOCK,
+					home_path);
+			if (ret < 0) {
+				retval = -1;
+				goto exit_init_data;
+			}
 		}
 
 		/* Set global SHM for ust */
 		if (strlen(wait_shm_path) == 0) {
-			snprintf(wait_shm_path, PATH_MAX,
-					DEFAULT_HOME_APPS_WAIT_SHM_PATH, getuid());
+			ret = snprintf(wait_shm_path, PATH_MAX,
+					DEFAULT_HOME_APPS_WAIT_SHM_PATH,
+					getuid());
+			if (ret < 0) {
+				retval = -1;
+				goto exit_init_data;
+			}
 		}
 
 		/* Set health check Unix path */
 		if (strlen(health_unix_sock_path) == 0) {
-			snprintf(health_unix_sock_path, sizeof(health_unix_sock_path),
-					DEFAULT_HOME_HEALTH_UNIX_SOCK, home_path);
+			ret = snprintf(health_unix_sock_path,
+					sizeof(health_unix_sock_path),
+					DEFAULT_HOME_HEALTH_UNIX_SOCK,
+					home_path);
+			if (ret < 0) {
+				retval = -1;
+				goto exit_init_data;
+			}
 		}
 	}
 
 	lockfile_fd = create_lockfile();
 	if (lockfile_fd < 0) {
-		goto error;
+		retval = -1;
+		goto exit_init_data;
 	}
 
 	/* Set consumer initial state */
@@ -5197,10 +5338,20 @@ int main(int argc, char **argv)
 	DBG("LTTng run directory path: %s", rundir);
 
 	/* 32 bits consumerd path setup */
-	snprintf(ustconsumer32_data.err_unix_sock_path, PATH_MAX,
+	ret = snprintf(ustconsumer32_data.err_unix_sock_path, PATH_MAX,
 			DEFAULT_USTCONSUMERD32_ERR_SOCK_PATH, rundir);
-	snprintf(ustconsumer32_data.cmd_unix_sock_path, PATH_MAX,
+	if (ret < 0) {
+		PERROR("snprintf 32-bit consumer error socket path");
+		retval = -1;
+		goto exit_init_data;
+	}
+	ret = snprintf(ustconsumer32_data.cmd_unix_sock_path, PATH_MAX,
 			DEFAULT_USTCONSUMERD32_CMD_SOCK_PATH, rundir);
+	if (ret < 0) {
+		PERROR("snprintf 32-bit consumer command socket path");
+		retval = -1;
+		goto exit_init_data;
+	}
 
 	DBG2("UST consumer 32 bits err path: %s",
 			ustconsumer32_data.err_unix_sock_path);
@@ -5208,10 +5359,20 @@ int main(int argc, char **argv)
 			ustconsumer32_data.cmd_unix_sock_path);
 
 	/* 64 bits consumerd path setup */
-	snprintf(ustconsumer64_data.err_unix_sock_path, PATH_MAX,
+	ret = snprintf(ustconsumer64_data.err_unix_sock_path, PATH_MAX,
 			DEFAULT_USTCONSUMERD64_ERR_SOCK_PATH, rundir);
-	snprintf(ustconsumer64_data.cmd_unix_sock_path, PATH_MAX,
+	if (ret < 0) {
+		PERROR("snprintf 64-bit consumer error socket path");
+		retval = -1;
+		goto exit_init_data;
+	}
+	ret = snprintf(ustconsumer64_data.cmd_unix_sock_path, PATH_MAX,
 			DEFAULT_USTCONSUMERD64_CMD_SOCK_PATH, rundir);
+	if (ret < 0) {
+		PERROR("snprintf 64-bit consumer command socket path");
+		retval = -1;
+		goto exit_init_data;
+	}
 
 	DBG2("UST consumer 64 bits err path: %s",
 			ustconsumer64_data.err_unix_sock_path);
@@ -5221,29 +5382,32 @@ int main(int argc, char **argv)
 	/*
 	 * See if daemon already exist.
 	 */
-	if ((ret = check_existing_daemon()) < 0) {
+	if (check_existing_daemon()) {
 		ERR("Already running daemon.\n");
 		/*
 		 * We do not goto exit because we must not cleanup()
 		 * because a daemon is already running.
 		 */
-		goto error;
+		retval = -1;
+		goto exit_init_data;
 	}
 
 	/*
 	 * Init UST app hash table. Alloc hash table before this point since
 	 * cleanup() can get called after that point.
 	 */
-	ust_app_ht_alloc();
+	if (ust_app_ht_alloc()) {
+		retval = -1;
+		goto exit_init_data;
+	}
 
 	/* Initialize agent domain subsystem. */
-	if ((ret = agent_setup()) < 0) {
+	if (agent_setup()) {
 		/* ENOMEM at this point. */
-		goto error;
+		retval = -1;
+		goto exit_init_data;
 	}
 
-	/* After this point, we can safely call cleanup() with "goto exit" */
-
 	/*
 	 * These actions must be executed as root. We do that *after* setting up
 	 * the sockets path because we MUST make the check for another daemon using
@@ -5251,9 +5415,9 @@ int main(int argc, char **argv)
 	 * kernel tracer.
 	 */
 	if (is_root) {
-		ret = set_consumer_sockets(&kconsumer_data, rundir);
-		if (ret < 0) {
-			goto exit;
+		if (set_consumer_sockets(&kconsumer_data, rundir)) {
+			retval = -1;
+			goto exit_init_data;
 		}
 
 		/* Setup kernel tracer */
@@ -5262,8 +5426,9 @@ int main(int argc, char **argv)
 			if (kernel_tracer_fd >= 0) {
 				ret = syscall_init_table();
 				if (ret < 0) {
-					ERR("Unable to populate syscall table. Syscall tracing"
-							" won't work for this session daemon.");
+					ERR("Unable to populate syscall table. "
+						"Syscall tracing won't work "
+						"for this session daemon.");
 				}
 			}
 		}
@@ -5274,24 +5439,26 @@ int main(int argc, char **argv)
 	/* init lttng_fd tracking must be done after set_ulimit. */
 	lttng_fd_init();
 
-	ret = set_consumer_sockets(&ustconsumer64_data, rundir);
-	if (ret < 0) {
-		goto exit;
+	if (set_consumer_sockets(&ustconsumer64_data, rundir)) {
+		retval = -1;
+		goto exit_init_data;
 	}
 
-	ret = set_consumer_sockets(&ustconsumer32_data, rundir);
-	if (ret < 0) {
-		goto exit;
+	if (set_consumer_sockets(&ustconsumer32_data, rundir)) {
+		retval = -1;
+		goto exit_init_data;
 	}
 
 	/* Setup the needed unix socket */
-	if ((ret = init_daemon_socket()) < 0) {
-		goto exit;
+	if (init_daemon_socket()) {
+		retval = -1;
+		goto exit_init_data;
 	}
 
 	/* Set credentials to socket */
-	if (is_root && ((ret = set_permissions(rundir)) < 0)) {
-		goto exit;
+	if (is_root && set_permissions(rundir)) {
+		retval = -1;
+		goto exit_init_data;
 	}
 
 	/* Get parent pid if -S, --sig-parent is specified. */
@@ -5301,24 +5468,22 @@ int main(int argc, char **argv)
 
 	/* Setup the kernel pipe for waking up the kernel thread */
 	if (is_root && !opt_no_kernel) {
-		if ((ret = utils_create_pipe_cloexec(kernel_poll_pipe)) < 0) {
-			goto exit;
+		if (utils_create_pipe_cloexec(kernel_poll_pipe)) {
+			retval = -1;
+			goto exit_init_data;
 		}
 	}
 
-	/* Setup the thread ht_cleanup communication pipe. */
-	if (utils_create_pipe_cloexec(ht_cleanup_pipe) < 0) {
-		goto exit;
-	}
-
 	/* Setup the thread apps communication pipe. */
-	if ((ret = utils_create_pipe_cloexec(apps_cmd_pipe)) < 0) {
-		goto exit;
+	if (utils_create_pipe_cloexec(apps_cmd_pipe)) {
+		retval = -1;
+		goto exit_init_data;
 	}
 
 	/* Setup the thread apps notify communication pipe. */
-	if (utils_create_pipe_cloexec(apps_cmd_notify_pipe) < 0) {
-		goto exit;
+	if (utils_create_pipe_cloexec(apps_cmd_notify_pipe)) {
+		retval = -1;
+		goto exit_init_data;
 	}
 
 	/* Initialize global buffer per UID and PID registry. */
@@ -5329,8 +5494,8 @@ int main(int argc, char **argv)
 	cds_wfcq_init(&ust_cmd_queue.head, &ust_cmd_queue.tail);
 
 	/*
-	 * Get session list pointer. This pointer MUST NOT be free(). This list is
-	 * statically declared in session.c
+	 * Get session list pointer. This pointer MUST NOT be free'd. This list
+	 * is statically declared in session.c
 	 */
 	session_list_ptr = session_get_list();
 
@@ -5347,90 +5512,97 @@ int main(int argc, char **argv)
 		app_socket_timeout = DEFAULT_APP_SOCKET_RW_TIMEOUT;
 	}
 
-	write_pidfile();
-	write_agent_port();
+	ret = write_pidfile();
+	if (ret) {
+		ERR("Error in write_pidfile");
+		retval = -1;
+		goto exit_init_data;
+	}
+	ret = write_agent_port();
+	if (ret) {
+		ERR("Error in write_agent_port");
+		retval = -1;
+		goto exit_init_data;
+	}
 
 	/* Initialize communication library */
 	lttcomm_init();
-	/* This is to get the TCP timeout value. */
+	/* Initialize TCP timeout values */
 	lttcomm_inet_init();
 
 	if (load_session_init_data(&load_info) < 0) {
-		goto exit;
+		retval = -1;
+		goto exit_init_data;
 	}
 	load_info->path = opt_load_session_path;
 
-	/*
-	 * Initialize the health check subsystem. This call should set the
-	 * appropriate time values.
-	 */
-	health_sessiond = health_app_create(NR_HEALTH_SESSIOND_TYPES);
-	if (!health_sessiond) {
-		PERROR("health_app_create error");
-		goto exit_health_sessiond_cleanup;
-	}
-
-	/* Create thread to clean up RCU hash tables */
-	ret = pthread_create(&ht_cleanup_thread, NULL,
-			thread_ht_cleanup, (void *) NULL);
-	if (ret != 0) {
-		PERROR("pthread_create ht_cleanup");
-		goto exit_ht_cleanup;
-	}
-
 	/* Create health-check thread */
 	ret = pthread_create(&health_thread, NULL,
 			thread_manage_health, (void *) NULL);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_create health");
+		retval = -1;
 		goto exit_health;
 	}
 
 	/* Create thread to manage the client socket */
 	ret = pthread_create(&client_thread, NULL,
 			thread_manage_clients, (void *) NULL);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_create clients");
+		retval = -1;
 		goto exit_client;
 	}
 
 	/* Create thread to dispatch registration */
 	ret = pthread_create(&dispatch_thread, NULL,
 			thread_dispatch_ust_registration, (void *) NULL);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_create dispatch");
+		retval = -1;
 		goto exit_dispatch;
 	}
 
 	/* Create thread to manage application registration. */
 	ret = pthread_create(&reg_apps_thread, NULL,
 			thread_registration_apps, (void *) NULL);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_create registration");
+		retval = -1;
 		goto exit_reg_apps;
 	}
 
 	/* Create thread to manage application socket */
 	ret = pthread_create(&apps_thread, NULL,
 			thread_manage_apps, (void *) NULL);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_create apps");
+		retval = -1;
 		goto exit_apps;
 	}
 
 	/* Create thread to manage application notify socket */
 	ret = pthread_create(&apps_notify_thread, NULL,
 			ust_thread_manage_notify, (void *) NULL);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_create notify");
+		retval = -1;
 		goto exit_apps_notify;
 	}
 
 	/* Create agent registration thread. */
 	ret = pthread_create(&agent_reg_thread, NULL,
 			agent_thread_manage_registration, (void *) NULL);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_create agent");
+		retval = -1;
 		goto exit_agent_reg;
 	}
 
@@ -5439,111 +5611,146 @@ int main(int argc, char **argv)
 		/* Create kernel thread to manage kernel event */
 		ret = pthread_create(&kernel_thread, NULL,
 				thread_manage_kernel, (void *) NULL);
-		if (ret != 0) {
+		if (ret) {
+			errno = ret;
 			PERROR("pthread_create kernel");
+			retval = -1;
 			goto exit_kernel;
 		}
 	}
 
-	/* Load possible session(s). */
-	start_load_session_thread();
+	/* Create session loading thread. */
+	ret = pthread_create(&load_session_thread, NULL, thread_load_session,
+			load_info);
+	if (ret) {
+		errno = ret;
+		PERROR("pthread_create load_session_thread");
+		retval = -1;
+		goto exit_load_session;
+	}
+
+	/*
+	 * This is where we start awaiting program completion (e.g. through
+	 * signal that asks threads to teardown).
+	 */
+
+	ret = pthread_join(load_session_thread, &status);
+	if (ret) {
+		errno = ret;
+		PERROR("pthread_join load_session_thread");
+		retval = -1;
+	}
+exit_load_session:
 
 	if (is_root && !opt_no_kernel) {
 		ret = pthread_join(kernel_thread, &status);
-		if (ret != 0) {
+		if (ret) {
+			errno = ret;
 			PERROR("pthread_join");
-			goto error;	/* join error, exit without cleanup */
+			retval = -1;
 		}
 	}
-
 exit_kernel:
+
 	ret = pthread_join(agent_reg_thread, &status);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_join agent");
-		goto error;	/* join error, exit without cleanup */
+		retval = -1;
 	}
-
 exit_agent_reg:
+
 	ret = pthread_join(apps_notify_thread, &status);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_join apps notify");
-		goto error;	/* join error, exit without cleanup */
+		retval = -1;
 	}
-
 exit_apps_notify:
+
 	ret = pthread_join(apps_thread, &status);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_join apps");
-		goto error;	/* join error, exit without cleanup */
+		retval = -1;
 	}
-
-
 exit_apps:
+
 	ret = pthread_join(reg_apps_thread, &status);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_join");
-		goto error;	/* join error, exit without cleanup */
+		retval = -1;
 	}
-
 exit_reg_apps:
+
 	ret = pthread_join(dispatch_thread, &status);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_join");
-		goto error;	/* join error, exit without cleanup */
+		retval = -1;
 	}
-
 exit_dispatch:
+
 	ret = pthread_join(client_thread, &status);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_join");
-		goto error;	/* join error, exit without cleanup */
-	}
-
-	ret = join_consumer_thread(&kconsumer_data);
-	if (ret != 0) {
-		PERROR("join_consumer");
-		goto error;	/* join error, exit without cleanup */
+		retval = -1;
 	}
+exit_client:
 
-	ret = join_consumer_thread(&ustconsumer32_data);
-	if (ret != 0) {
-		PERROR("join_consumer ust32");
-		goto error;	/* join error, exit without cleanup */
+	ret = pthread_join(health_thread, &status);
+	if (ret) {
+		errno = ret;
+		PERROR("pthread_join health thread");
+		retval = -1;
 	}
+exit_health:
 
-	ret = join_consumer_thread(&ustconsumer64_data);
-	if (ret != 0) {
-		PERROR("join_consumer ust64");
-		goto error;	/* join error, exit without cleanup */
-	}
+exit_init_data:
+	/*
+	 * sessiond_cleanup() is called when no other thread is running, except
+	 * the ht_cleanup thread, which is needed to destroy the hash tables.
+	 */
+	rcu_thread_online();
+	sessiond_cleanup();
+	rcu_thread_offline();
+	rcu_unregister_thread();
 
-exit_client:
-	ret = pthread_join(health_thread, &status);
-	if (ret != 0) {
-		PERROR("pthread_join health thread");
-		goto error;	/* join error, exit without cleanup */
+	ret = notify_thread_pipe(ht_cleanup_quit_pipe[1]);
+	if (ret < 0) {
+		ERR("write error on ht_cleanup quit pipe");
+		retval = -1;
 	}
 
-exit_health:
 	ret = pthread_join(ht_cleanup_thread, &status);
-	if (ret != 0) {
+	if (ret) {
+		errno = ret;
 		PERROR("pthread_join ht cleanup thread");
-		goto error;	/* join error, exit without cleanup */
+		retval = -1;
 	}
 exit_ht_cleanup:
-	health_app_destroy(health_sessiond);
-exit_health_sessiond_cleanup:
-exit:
+
+	utils_close_pipe(ht_cleanup_pipe);
+exit_ht_cleanup_pipe:
+
 	/*
-	 * cleanup() is called when no other thread is running.
+	 * Close the ht_cleanup quit pipe.
 	 */
-	rcu_thread_online();
-	cleanup();
-	rcu_thread_offline();
-	rcu_unregister_thread();
-	if (!ret) {
+	utils_close_pipe(ht_cleanup_quit_pipe);
+exit_ht_cleanup_quit_pipe:
+
+	health_app_destroy(health_sessiond);
+exit_health_sessiond_cleanup:
+
+exit_options:
+	sessiond_cleanup_options();
+
+exit_set_signal_handler:
+	if (!retval) {
 		exit(EXIT_SUCCESS);
+	} else {
+		exit(EXIT_FAILURE);
 	}
-error:
-	exit(EXIT_FAILURE);
 }
-- 
2.1.1
