From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH] UST periodical metadata flush
Date: Mon, 25 Mar 2013 22:27:05 -0400
Message-ID: <1364264825-13550-1-git-send-email-jdesfossez__40442.4338638366$1364264897$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1UKJbc-0004nE-0M
	for lttng-dev@lists.lttng.org; Mon, 25 Mar 2013 22:27:20 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com, mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Add a new socket between the sessiond and the ust-consumer to allow
periodical flush of the metadata channel.
If enabled (by specifying the --switch-timer option on the metadata
channel), a new timer thread in the consumer asks the session daemon
for new metadata for a specific session.
All the metadata collected is written into a metadata cache in the
consumer, this mechanism is useful for synchronisation (to avoid race
conditions between two metadata updates) and will also be useful when we
implement the snapshots.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/bin/lttng-consumerd/lttng-consumerd.c |   53 ++++-
 src/bin/lttng-sessiond/consumer.c         |   20 +-
 src/bin/lttng-sessiond/consumer.h         |    4 +
 src/bin/lttng-sessiond/lttng-ust-ctl.h    |    1 +
 src/bin/lttng-sessiond/main.c             |  223 +++++++++++++----
 src/bin/lttng-sessiond/ust-app.c          |   38 ++-
 src/bin/lttng-sessiond/ust-app.h          |    4 +
 src/bin/lttng-sessiond/ust-consumer.c     |   92 +++++++
 src/bin/lttng-sessiond/ust-consumer.h     |    1 +
 src/common/Makefile.am                    |    5 +-
 src/common/consumer-metadata-cache.c      |  213 +++++++++++++++++
 src/common/consumer-metadata-cache.h      |   34 +++
 src/common/consumer.c                     |   16 ++
 src/common/consumer.h                     |   65 ++++-
 src/common/defaults.h                     |    9 +
 src/common/sessiond-comm/sessiond-comm.h  |   20 ++
 src/common/ust-consumer/ust-consumer.c    |  369 +++++++++++++++++++++++++++--
 src/common/ust-consumer/ust-consumer.h    |    4 +
 tests/unit/Makefile.am                    |    1 +
 19 files changed, 1072 insertions(+), 100 deletions(-)
 create mode 100644 src/common/consumer-metadata-cache.c
 create mode 100644 src/common/consumer-metadata-cache.h

diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c b/src/bin/lttng-consumerd/lttng-consumerd.c
index 8486807..afac445 100644
--- a/src/bin/lttng-consumerd/lttng-consumerd.c
+++ b/src/bin/lttng-consumerd/lttng-consumerd.c
@@ -52,7 +52,8 @@
 /* TODO : support UST (all direct kernel-ctl accesses). */
 
 /* threads (channel handling, poll, metadata, sessiond) */
-static pthread_t channel_thread, data_thread, metadata_thread, sessiond_thread;
+static pthread_t channel_thread, data_thread, metadata_thread,
+		 sessiond_thread, metadata_timer_thread;
 
 /* to count the number of times the user pressed ctrl+c */
 static int sigintcount = 0;
@@ -64,6 +65,7 @@ static int opt_daemon;
 static const char *progname;
 static char command_sock_path[PATH_MAX]; /* Global command socket path */
 static char error_sock_path[PATH_MAX]; /* Global error path */
+static char metadata_sock_path[PATH_MAX]; /* UST metadata socket path */
 static enum lttng_consumer_type opt_type = LTTNG_CONSUMER_KERNEL;
 
 /* the liblttngconsumerd context */
@@ -138,6 +140,8 @@ static void usage(FILE *fp)
 			"Specify path for the command socket\n");
 	fprintf(fp, "  -e, --consumerd-err-sock PATH     "
 			"Specify path for the error socket\n");
+	fprintf(fp, "  -e, --consumerd-metadata-sock PATH     "
+			"Specify path for the metadata socket (UST only)\n");
 	fprintf(fp, "  -d, --daemonize                    "
 			"Start as a daemon.\n");
 	fprintf(fp, "  -q, --quiet                        "
@@ -168,6 +172,7 @@ static void parse_args(int argc, char **argv)
 	static struct option long_options[] = {
 		{ "consumerd-cmd-sock", 1, 0, 'c' },
 		{ "consumerd-err-sock", 1, 0, 'e' },
+		{ "consumerd-metadata-sock", 1, 0, 'm' },
 		{ "daemonize", 0, 0, 'd' },
 		{ "help", 0, 0, 'h' },
 		{ "quiet", 0, 0, 'q' },
@@ -182,7 +187,7 @@ static void parse_args(int argc, char **argv)
 
 	while (1) {
 		int option_index = 0;
-		c = getopt_long(argc, argv, "dhqvVku" "c:e:", long_options, &option_index);
+		c = getopt_long(argc, argv, "dhqvVku" "c:e:m:", long_options, &option_index);
 		if (c == -1) {
 			break;
 		}
@@ -200,6 +205,9 @@ static void parse_args(int argc, char **argv)
 		case 'e':
 			snprintf(error_sock_path, PATH_MAX, "%s", optarg);
 			break;
+		case 'm':
+			snprintf(metadata_sock_path, PATH_MAX, "%s", optarg);
+			break;
 		case 'd':
 			opt_daemon = 1;
 			break;
@@ -339,10 +347,14 @@ int main(int argc, char **argv)
 		case LTTNG_CONSUMER64_UST:
 			snprintf(error_sock_path, PATH_MAX,
 					DEFAULT_USTCONSUMERD64_ERR_SOCK_PATH, DEFAULT_LTTNG_RUNDIR);
+			snprintf(metadata_sock_path, PATH_MAX,
+					DEFAULT_USTCONSUMERD64_META_SOCK_PATH, DEFAULT_LTTNG_RUNDIR);
 			break;
 		case LTTNG_CONSUMER32_UST:
 			snprintf(error_sock_path, PATH_MAX,
 					DEFAULT_USTCONSUMERD32_ERR_SOCK_PATH, DEFAULT_LTTNG_RUNDIR);
+			snprintf(metadata_sock_path, PATH_MAX,
+					DEFAULT_USTCONSUMERD32_META_SOCK_PATH, DEFAULT_LTTNG_RUNDIR);
 			break;
 		default:
 			WARN("Unknown consumerd type");
@@ -363,6 +375,27 @@ int main(int argc, char **argv)
 	}
 	lttng_consumer_set_error_sock(ctx, ret);
 
+	/* metadata socket only for UST */
+	if (*metadata_sock_path != '\0') {
+		/* Connect to the socket created by lttng-sessiond to ask metadata */
+		DBG("Connecting to error socket %s", metadata_sock_path);
+		ret = lttcomm_connect_unix_sock(metadata_sock_path);
+		/* not a fatal error, but all communication with lttng-sessiond will fail */
+		if (ret < 0) {
+			WARN("Cannot connect to metadata socket (is lttng-sessiond started?)");
+		}
+		lttng_consumer_set_metadata_sock(ctx, ret);
+	}
+
+	/*
+	 * for UST consumer, we block RT signals used for periodical
+	 * metadata flush in main and create a dedicated thread
+	 * to handle these signals.
+	 */
+	if (opt_type != LTTNG_CONSUMER_KERNEL) {
+		consumer_signal_init();
+	}
+
 	/* Create thread to manage channels */
 	ret = pthread_create(&channel_thread, NULL, consumer_thread_channel_poll,
 			(void *) ctx);
@@ -395,6 +428,22 @@ int main(int argc, char **argv)
 		goto sessiond_error;
 	}
 
+	if (opt_type != LTTNG_CONSUMER_KERNEL) {
+		/* Create the thread to manage the metadata periodic timers */
+		ret = pthread_create(&metadata_timer_thread, NULL, consumer_thread_metadata_timer,
+				(void *) ctx);
+		if (ret != 0) {
+			perror("pthread_create");
+			goto metadata_timer_error;
+		}
+		ret = pthread_detach(metadata_timer_thread);
+		if (ret) {
+			errno = ret;
+			perror("pthread_detach");
+		}
+	}
+
+metadata_timer_error:
 	ret = pthread_join(sessiond_thread, &status);
 	if (ret != 0) {
 		perror("pthread_join");
diff --git a/src/bin/lttng-sessiond/consumer.c b/src/bin/lttng-sessiond/consumer.c
index 57b5b19..ff3dde2 100644
--- a/src/bin/lttng-sessiond/consumer.c
+++ b/src/bin/lttng-sessiond/consumer.c
@@ -1107,17 +1107,19 @@ int consumer_push_metadata(struct consumer_socket *socket,
 		goto end;
 	}
 
-	DBG3("Consumer pushing metadata on sock %d of len %lu", socket->fd, len);
+	if (len > 0) {
+		DBG3("Consumer pushing metadata on sock %d of len %lu", socket->fd, len);
 
-	ret = lttcomm_send_unix_sock(socket->fd, metadata_str, len);
-	if (ret < 0) {
-		goto end;
-	}
+		ret = lttcomm_send_unix_sock(socket->fd, metadata_str, len);
+		if (ret < 0) {
+			goto end;
+		}
 
-	health_code_update();
-	ret = consumer_recv_status_reply(socket);
-	if (ret < 0) {
-		goto end;
+		health_code_update();
+		ret = consumer_recv_status_reply(socket);
+		if (ret < 0) {
+			goto end;
+		}
 	}
 
 end:
diff --git a/src/bin/lttng-sessiond/consumer.h b/src/bin/lttng-sessiond/consumer.h
index cde2d0d..01e96fe 100644
--- a/src/bin/lttng-sessiond/consumer.h
+++ b/src/bin/lttng-sessiond/consumer.h
@@ -84,6 +84,10 @@ struct consumer_data {
 	char err_unix_sock_path[PATH_MAX];
 	char cmd_unix_sock_path[PATH_MAX];
 
+	/* metadata socket to ask UST metadata to the sessiond */
+	char metadata_unix_sock_path[PATH_MAX];
+	int metadata_sock;
+
 	/* communication lock */
 	pthread_mutex_t lock;
 };
diff --git a/src/bin/lttng-sessiond/lttng-ust-ctl.h b/src/bin/lttng-sessiond/lttng-ust-ctl.h
index 7f59b86..cea35ba 100644
--- a/src/bin/lttng-sessiond/lttng-ust-ctl.h
+++ b/src/bin/lttng-sessiond/lttng-ust-ctl.h
@@ -50,6 +50,7 @@ struct ustctl_consumer_channel_attr {
 	int overwrite;				/* 1: overwrite, 0: discard */
 	unsigned int switch_timer_interval;	/* usec */
 	unsigned int read_timer_interval;	/* usec */
+	timer_t read_timer;			/* timer ID */
 	enum lttng_ust_output output;		/* splice, mmap */
 	uint32_t chan_id;           /* channel ID */
 	unsigned char uuid[LTTNG_UST_UUID_LEN]; /* Trace session unique ID */
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index d88bafe..8d5b38a 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -25,6 +25,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <inttypes.h>
 #include <sys/mman.h>
 #include <sys/mount.h>
 #include <sys/resource.h>
@@ -89,6 +90,7 @@ static struct consumer_data kconsumer_data = {
 	.cmd_unix_sock_path = DEFAULT_KCONSUMERD_CMD_SOCK_PATH,
 	.err_sock = -1,
 	.cmd_sock = -1,
+	.metadata_sock = -1,
 	.pid_mutex = PTHREAD_MUTEX_INITIALIZER,
 	.lock = PTHREAD_MUTEX_INITIALIZER,
 	.cond = PTHREAD_COND_INITIALIZER,
@@ -98,8 +100,10 @@ static struct consumer_data ustconsumer64_data = {
 	.type = LTTNG_CONSUMER64_UST,
 	.err_unix_sock_path = DEFAULT_USTCONSUMERD64_ERR_SOCK_PATH,
 	.cmd_unix_sock_path = DEFAULT_USTCONSUMERD64_CMD_SOCK_PATH,
+	.metadata_unix_sock_path = DEFAULT_USTCONSUMERD64_META_SOCK_PATH,
 	.err_sock = -1,
 	.cmd_sock = -1,
+	.metadata_sock = -1,
 	.pid_mutex = PTHREAD_MUTEX_INITIALIZER,
 	.lock = PTHREAD_MUTEX_INITIALIZER,
 	.cond = PTHREAD_COND_INITIALIZER,
@@ -109,8 +113,10 @@ static struct consumer_data ustconsumer32_data = {
 	.type = LTTNG_CONSUMER32_UST,
 	.err_unix_sock_path = DEFAULT_USTCONSUMERD32_ERR_SOCK_PATH,
 	.cmd_unix_sock_path = DEFAULT_USTCONSUMERD32_CMD_SOCK_PATH,
+	.metadata_unix_sock_path = DEFAULT_USTCONSUMERD32_META_SOCK_PATH,
 	.err_sock = -1,
 	.cmd_sock = -1,
+	.metadata_sock = -1,
 	.pid_mutex = PTHREAD_MUTEX_INITIALIZER,
 	.lock = PTHREAD_MUTEX_INITIALIZER,
 	.cond = PTHREAD_COND_INITIALIZER,
@@ -857,6 +863,8 @@ static void *thread_manage_consumer(void *data)
 	enum lttcomm_return_code code;
 	struct lttng_poll_event events;
 	struct consumer_data *consumer_data = data;
+	int metadata_sock_fd;
+	struct consumer_socket *metadata_sock = NULL;
 
 	DBG("[thread] Manage consumer started");
 
@@ -865,10 +873,11 @@ static void *thread_manage_consumer(void *data)
 	health_code_update();
 
 	/*
-	 * Pass 2 as size here for the thread quit pipe and kconsumerd_err_sock.
+	 * Pass 3 as size here for the thread quit pipe, kconsumerd_err_sock
+	 * and the metadata_sock.
 	 * Nothing more will be added to this poll set.
 	 */
-	ret = sessiond_set_thread_pollset(&events, 2);
+	ret = sessiond_set_thread_pollset(&events, 3);
 	if (ret < 0) {
 		goto error_poll;
 	}
@@ -884,8 +893,9 @@ static void *thread_manage_consumer(void *data)
 	}
 
 	health_code_update();
+	metadata_sock_fd = -1;
 
-	/* Inifinite blocking call, waiting for transmission */
+	/* Infinite blocking call, waiting for transmission */
 restart:
 	health_poll_entry();
 
@@ -982,60 +992,132 @@ restart:
 		goto error;
 	}
 
-	health_code_update();
-
-	/* Inifinite blocking call, waiting for transmission */
-restart_poll:
-	health_poll_entry();
-	ret = lttng_poll_wait(&events, -1);
-	health_poll_exit();
+	/*
+	 * The metadata socket here is already in a listening state which was done
+	 * just before spawning this thread to avoid a race between the consumer
+	 * daemon exec trying to connect and the listen() call.
+	 */
+	ret = lttng_poll_add(&events, consumer_data->metadata_sock, LPOLLIN | LPOLLRDHUP);
 	if (ret < 0) {
-		/*
-		 * Restart interrupted system call.
-		 */
-		if (errno == EINTR) {
-			goto restart_poll;
-		}
 		goto error;
 	}
 
-	nb_fd = ret;
+	health_code_update();
 
-	for (i = 0; i < nb_fd; i++) {
-		/* Fetch once the poll data */
-		revents = LTTNG_POLL_GETEV(&events, i);
-		pollfd = LTTNG_POLL_GETFD(&events, i);
+	/* Infinite blocking call, waiting for transmission */
+restart_poll:
+	while (1) {
+		health_poll_entry();
+		ret = lttng_poll_wait(&events, -1);
+		health_poll_exit();
+		if (ret < 0) {
+			/*
+			 * Restart interrupted system call.
+			 */
+			if (errno == EINTR) {
+				goto restart_poll;
+			}
+			goto error;
+		}
 
-		health_code_update();
+		nb_fd = ret;
 
-		/* Thread quit pipe has been closed. Killing thread. */
-		ret = sessiond_check_thread_quit_pipe(pollfd, revents);
-		if (ret) {
-			err = 0;
-			goto exit;
-		}
+		for (i = 0; i < nb_fd; i++) {
+			/* Fetch once the poll data */
+			revents = LTTNG_POLL_GETEV(&events, i);
+			pollfd = LTTNG_POLL_GETFD(&events, i);
 
-		/* Event on the kconsumerd socket */
-		if (pollfd == sock) {
-			if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
-				ERR("consumer err socket second poll error");
-				goto error;
+			health_code_update();
+
+			/* Thread quit pipe has been closed. Killing thread. */
+			ret = sessiond_check_thread_quit_pipe(pollfd, revents);
+			if (ret) {
+				err = 0;
+				goto exit;
 			}
-		}
-	}
 
-	health_code_update();
+			if (pollfd == sock) {
+				/* Event on the kconsumerd socket */
+				if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
+					ERR("consumer err socket second poll error");
+					goto error;
+				}
+				health_code_update();
+				/* Wait for any kconsumerd error */
+				ret = lttcomm_recv_unix_sock(sock, &code,
+						sizeof(enum lttcomm_return_code));
+				if (ret <= 0) {
+					ERR("consumer closed the command socket");
+					goto error;
+				}
 
-	/* Wait for any kconsumerd error */
-	ret = lttcomm_recv_unix_sock(sock, &code,
-			sizeof(enum lttcomm_return_code));
-	if (ret <= 0) {
-		ERR("consumer closed the command socket");
-		goto error;
-	}
+				ERR("consumer return code : %s",
+						lttcomm_get_readable_code(-code));
 
-	ERR("consumer return code : %s", lttcomm_get_readable_code(-code));
+				goto exit;
+			} else if (pollfd == consumer_data->metadata_sock) {
+				/* first connection on consumer_data->metadata_sock */
+				metadata_sock_fd =
+					lttcomm_accept_unix_sock(
+							consumer_data->metadata_sock);
+				if (metadata_sock_fd < 0) {
+					goto error;
+				}
+				DBG("Metadata socket (fd: %d)", metadata_sock_fd);
+				metadata_sock = consumer_allocate_socket(metadata_sock_fd);
+				if (metadata_sock == NULL) {
+					ret = -1;
+					goto error;
+				}
+				metadata_sock->lock = zmalloc(sizeof(pthread_mutex_t));
+				if (metadata_sock->lock == NULL) {
+					PERROR("zmalloc pthread mutex");
+					ret = -1;
+					goto error_free_sock;
+				}
+				pthread_mutex_init(metadata_sock->lock, NULL);
+
+				/*
+				 * Set the CLOEXEC flag. Return code is
+				 * useless because either way, the
+				 * show must go on.
+				 */
+				(void) utils_set_fd_cloexec(metadata_sock_fd);
+
+				/*
+				 * Remove the consumerd metadata sock since
+				 * we've established a connexion
+				 */
+				ret = lttng_poll_del(&events,
+						consumer_data->metadata_sock);
+				if (ret < 0) {
+					goto error_free_sock;
+				}
+
+				ret = lttng_poll_add(&events, metadata_sock_fd,
+						LPOLLIN | LPOLLRDHUP);
+				if (ret < 0) {
+					goto error_free_sock;
+				}
+				break;
+			} else if (pollfd == metadata_sock_fd) {
+				/* UST metadata requests */
+				ret = ust_consumer_metadata_request(metadata_sock);
+				if (ret < 0) {
+					ERR("Handling metadata request");
+					goto error_free_sock;
+				}
+				break;
+			} else {
+				ERR("Unknown pollfd");
+				goto error_free_sock;
+			}
+		}
+		health_code_update();
+	}
 
+error_free_sock:
+	consumer_destroy_socket(metadata_sock);
 exit:
 error:
 	/* Immediately set the consumerd state to stopped */
@@ -1061,6 +1143,12 @@ error:
 			PERROR("close");
 		}
 	}
+	if (consumer_data->metadata_sock >= 0) {
+		ret = close(consumer_data->metadata_sock);
+		if (ret) {
+			PERROR("close");
+		}
+	}
 	if (sock >= 0) {
 		ret = close(sock);
 		if (ret) {
@@ -1070,6 +1158,7 @@ error:
 
 	unlink(consumer_data->err_unix_sock_path);
 	unlink(consumer_data->cmd_unix_sock_path);
+	unlink(consumer_data->metadata_unix_sock_path);
 	consumer_data->pid = 0;
 
 	lttng_poll_clean(&events);
@@ -1893,6 +1982,7 @@ static pid_t spawn_consumerd(struct consumer_data *consumer_data)
 			ret = execl(consumerd64_bin, "lttng-consumerd", verbosity, "-u",
 					"--consumerd-cmd-sock", consumer_data->cmd_unix_sock_path,
 					"--consumerd-err-sock", consumer_data->err_unix_sock_path,
+					"--consumerd-metadata-sock", consumer_data->metadata_unix_sock_path,
 					NULL);
 			if (consumerd64_libdir[0] != '\0') {
 				free(tmpnew);
@@ -1938,6 +2028,7 @@ static pid_t spawn_consumerd(struct consumer_data *consumer_data)
 			ret = execl(consumerd32_bin, "lttng-consumerd", verbosity, "-u",
 					"--consumerd-cmd-sock", consumer_data->cmd_unix_sock_path,
 					"--consumerd-err-sock", consumer_data->err_unix_sock_path,
+					"--consumerd-metadata-sock", consumer_data->metadata_unix_sock_path,
 					NULL);
 			if (consumerd32_libdir[0] != '\0') {
 				free(tmpnew);
@@ -1981,6 +2072,10 @@ static int start_consumerd(struct consumer_data *consumer_data)
 	if (ret < 0) {
 		goto error;
 	}
+	ret = lttcomm_listen_unix_sock(consumer_data->metadata_sock);
+	if (ret < 0) {
+		goto error;
+	}
 
 	pthread_mutex_lock(&consumer_data->pid_mutex);
 	if (consumer_data->pid != 0) {
@@ -2011,7 +2106,7 @@ end:
 	return 0;
 
 error:
-	/* Cleanup already created socket on error. */
+	/* Cleanup already created sockets on error. */
 	if (consumer_data->err_sock >= 0) {
 		int err;
 
@@ -2020,6 +2115,14 @@ error:
 			PERROR("close consumer data error socket");
 		}
 	}
+	if (consumer_data->metadata_sock >= 0) {
+		int err;
+
+		err = close(consumer_data->metadata_sock);
+		if (err < 0) {
+			PERROR("close consumer metadata socket");
+		}
+	}
 	return ret;
 }
 
@@ -3846,6 +3949,28 @@ static int set_consumer_sockets(struct consumer_data *consumer_data,
 		goto error;
 	}
 
+	if (consumer_data->type != LTTNG_CONSUMER_KERNEL) {
+		/* Create the consumerd metadata unix socket for UST */
+		consumer_data->metadata_sock =
+			lttcomm_create_unix_sock(consumer_data->metadata_unix_sock_path);
+		if (consumer_data->metadata_sock < 0) {
+			ERR("Create unix sock failed: %s",
+					consumer_data->metadata_unix_sock_path);
+			ret = -1;
+			goto error;
+		}
+
+		/* File permission MUST be 660 */
+		ret = chmod(consumer_data->metadata_unix_sock_path,
+				S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
+		if (ret < 0) {
+			ERR("Set file permissions failed: %s",
+					consumer_data->metadata_unix_sock_path);
+			PERROR("chmod");
+			goto error;
+		}
+	}
+
 error:
 	return ret;
 }
@@ -4119,22 +4244,30 @@ int main(int argc, char **argv)
 			DEFAULT_USTCONSUMERD32_ERR_SOCK_PATH, rundir);
 	snprintf(ustconsumer32_data.cmd_unix_sock_path, PATH_MAX,
 			DEFAULT_USTCONSUMERD32_CMD_SOCK_PATH, rundir);
+	snprintf(ustconsumer32_data.metadata_unix_sock_path, PATH_MAX,
+			DEFAULT_USTCONSUMERD32_META_SOCK_PATH, rundir);
 
 	DBG2("UST consumer 32 bits err path: %s",
 			ustconsumer32_data.err_unix_sock_path);
 	DBG2("UST consumer 32 bits cmd path: %s",
 			ustconsumer32_data.cmd_unix_sock_path);
+	DBG2("UST consumer 32 bits metadata path: %s",
+			ustconsumer32_data.metadata_unix_sock_path);
 
 	/* 64 bits consumerd path setup */
 	snprintf(ustconsumer64_data.err_unix_sock_path, PATH_MAX,
 			DEFAULT_USTCONSUMERD64_ERR_SOCK_PATH, rundir);
 	snprintf(ustconsumer64_data.cmd_unix_sock_path, PATH_MAX,
 			DEFAULT_USTCONSUMERD64_CMD_SOCK_PATH, rundir);
+	snprintf(ustconsumer64_data.metadata_unix_sock_path, PATH_MAX,
+			DEFAULT_USTCONSUMERD64_META_SOCK_PATH, rundir);
 
 	DBG2("UST consumer 64 bits err path: %s",
 			ustconsumer64_data.err_unix_sock_path);
 	DBG2("UST consumer 64 bits cmd path: %s",
 			ustconsumer64_data.cmd_unix_sock_path);
+	DBG2("UST consumer 64 bits metadata path: %s",
+			ustconsumer64_data.metadata_unix_sock_path);
 
 	/*
 	 * See if daemon already exist.
diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 979ae7c..2250d0f 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -27,6 +27,7 @@
 #include <unistd.h>
 #include <urcu/compiler.h>
 #include <lttng/ust-error.h>
+#include <signal.h>
 
 #include <common/common.h>
 #include <common/sessiond-comm/sessiond-comm.h>
@@ -370,11 +371,15 @@ void delete_ust_app_channel(int sock, struct ust_app_channel *ua_chan,
 /*
  * For a given application and session, push metadata to consumer. The session
  * lock MUST be acquired here before calling this.
+ * Either sock or consumer is required : if sock is NULL, the default
+ * socket to send the metadata is retrieved from consumer, if sock
+ * is not NULL we use it to send the metadata.
  *
  * Return 0 on success else a negative error.
  */
-static int push_metadata(struct ust_registry_session *registry,
-		struct consumer_output *consumer)
+int ust_app_push_metadata(struct ust_registry_session *registry,
+		struct consumer_output *consumer,
+		struct consumer_socket *sock)
 {
 	int ret;
 	char *metadata_str = NULL;
@@ -382,7 +387,12 @@ static int push_metadata(struct ust_registry_session *registry,
 	struct consumer_socket *socket;
 
 	assert(registry);
-	assert(consumer);
+	if (consumer == NULL) {
+		assert(sock);
+	}
+	if (sock == NULL) {
+		assert(consumer);
+	}
 
 	rcu_read_lock();
 
@@ -395,12 +405,16 @@ static int push_metadata(struct ust_registry_session *registry,
 		goto error_rcu_unlock;
 	}
 
-	/* Get consumer socket to use to push the metadata.*/
-	socket = consumer_find_socket_by_bitness(registry->bits_per_long,
-			consumer);
-	if (!socket) {
-		ret = -1;
-		goto error_rcu_unlock;
+	if (sock == NULL) {
+		/* Get consumer socket to use to push the metadata.*/
+		socket = consumer_find_socket_by_bitness(registry->bits_per_long,
+				consumer);
+		if (!socket) {
+			ret = -1;
+			goto error_rcu_unlock;
+		}
+	} else {
+		socket = sock;
 	}
 
 	/*
@@ -527,7 +541,7 @@ void delete_ust_app_session(int sock, struct ust_app_session *ua_sess,
 	registry = get_session_registry(ua_sess);
 	if (registry) {
 		/* Push metadata for application before freeing the application. */
-		(void) push_metadata(registry, ua_sess->consumer);
+		(void) ust_app_push_metadata(registry, ua_sess->consumer, NULL);
 
 		/*
 		 * Don't ask to close metadata for global per UID buffers. Close
@@ -2770,7 +2784,7 @@ void ust_app_unregister(int sock)
 		registry = get_session_registry(ua_sess);
 		if (registry) {
 			/* Push metadata for application before freeing the application. */
-			(void) push_metadata(registry, ua_sess->consumer);
+			(void) ust_app_push_metadata(registry, ua_sess->consumer, NULL);
 
 			/*
 			 * Don't ask to close metadata for global per UID buffers. Close
@@ -3682,7 +3696,7 @@ int ust_app_stop_trace(struct ltt_ust_session *usess, struct ust_app *app)
 	registry = get_session_registry(ua_sess);
 	assert(registry);
 	/* Push metadata for application before freeing the application. */
-	(void) push_metadata(registry, ua_sess->consumer);
+	(void) ust_app_push_metadata(registry, ua_sess->consumer, NULL);
 
 	pthread_mutex_unlock(&ua_sess->lock);
 end_no_session:
diff --git a/src/bin/lttng-sessiond/ust-app.h b/src/bin/lttng-sessiond/ust-app.h
index 67088a7..32fb0fa 100644
--- a/src/bin/lttng-sessiond/ust-app.h
+++ b/src/bin/lttng-sessiond/ust-app.h
@@ -300,6 +300,10 @@ void ust_app_add(struct ust_app *app);
 struct ust_app *ust_app_create(struct ust_register_msg *msg, int sock);
 void ust_app_notify_sock_unregister(int sock);
 
+int ust_app_push_metadata(struct ust_registry_session *registry,
+		struct consumer_output *consumer,
+		struct consumer_socket *sock);
+
 #else /* HAVE_LIBLTTNG_UST_CTL */
 
 static inline
diff --git a/src/bin/lttng-sessiond/ust-consumer.c b/src/bin/lttng-sessiond/ust-consumer.c
index ba74112..cf62553 100644
--- a/src/bin/lttng-sessiond/ust-consumer.c
+++ b/src/bin/lttng-sessiond/ust-consumer.c
@@ -30,6 +30,8 @@
 #include "consumer.h"
 #include "health.h"
 #include "ust-consumer.h"
+#include "buffer-registry.h"
+#include "session.h"
 
 /*
  * Return allocated full pathname of the session using the consumer trace path
@@ -405,3 +407,93 @@ int ust_consumer_send_channel_to_ust(struct ust_app *app,
 error:
 	return ret;
 }
+
+/*
+ * Handle the metadata requests from the UST consumer
+ */
+int ust_consumer_metadata_request(struct consumer_socket *sock)
+{
+	int ret;
+	struct lttcomm_metadata request;
+	struct buffer_reg_uid *reg_uid;
+	struct buffer_reg_pid *reg_pid;
+	struct ust_registry_session *ust_reg;
+	struct lttcomm_consumer_msg msg;
+	uint64_t len;
+
+	/* Wait for a metadata request */
+	ret = lttcomm_recv_unix_sock(sock->fd, &request,
+			sizeof(struct lttcomm_metadata));
+	if (ret <= 0) {
+		ERR("consumer closed the metadata socket");
+		ret = -1;
+		goto end;
+	}
+
+	switch (request.command) {
+	case LTTCOMM_METADATA_REQUEST:
+		DBG("Metadata request received for session %u, key %" PRIu64,
+				request.u.metadata_request.session_id,
+				request.u.metadata_request.key);
+
+		rcu_read_lock();
+		reg_uid = buffer_reg_uid_find(request.u.metadata_request.session_id,
+				request.u.metadata_request.bits_per_long,
+				request.u.metadata_request.uid);
+		if (reg_uid) {
+			ust_reg = reg_uid->registry->reg.ust;
+		} else {
+			reg_pid = buffer_reg_pid_find(
+					request.u.metadata_request.session_id);
+			if (!reg_pid) {
+				DBG("Registry not found");
+
+				msg.cmd_type = LTTNG_ERR_UND;
+				ret = consumer_send_msg(sock, &msg);
+				if (ret < 0) {
+					ERR("Sending registry not found to consumer");
+				}
+				goto end_unlock;
+			}
+			ust_reg = reg_pid->registry->reg.ust;
+		}
+
+		pthread_mutex_lock(&ust_reg->lock);
+		len = ust_reg->metadata_len - ust_reg->metadata_len_sent;
+		pthread_mutex_unlock(&ust_reg->lock);
+
+		if (len == 0) {
+			DBG("No metadata to push");
+
+			pthread_mutex_lock(sock->lock);
+			ret = consumer_push_metadata(sock,
+					request.u.metadata_request.key,
+					NULL, len, 0);
+			if (ret < 0) {
+				ERR("Sending len = 0 to consumer");
+			}
+			pthread_mutex_unlock(sock->lock);
+			goto end_unlock;
+		}
+
+		session_lock_list();
+		ret = ust_app_push_metadata(ust_reg, NULL, sock);
+		if (ret < 0) {
+			ERR("Pushing metadata");
+			session_unlock_list();
+			goto end_unlock;
+		}
+		session_unlock_list();
+		DBG("Pushed metadata");
+		break;
+	default:
+		ERR("Unknown metadata request message");
+		ret = -1;
+		goto end;
+	}
+
+end_unlock:
+	rcu_read_unlock();
+end:
+	return ret;
+}
diff --git a/src/bin/lttng-sessiond/ust-consumer.h b/src/bin/lttng-sessiond/ust-consumer.h
index f5f63d9..d378202 100644
--- a/src/bin/lttng-sessiond/ust-consumer.h
+++ b/src/bin/lttng-sessiond/ust-consumer.h
@@ -36,5 +36,6 @@ int ust_consumer_send_stream_to_ust(struct ust_app *app,
 
 int ust_consumer_send_channel_to_ust(struct ust_app *app,
 		struct ust_app_session *ua_sess, struct ust_app_channel *channel);
+int ust_consumer_metadata_request(struct consumer_socket *sock);
 
 #endif /* _UST_CONSUMER_H */
diff --git a/src/common/Makefile.am b/src/common/Makefile.am
index c3a947a..f90a132 100644
--- a/src/common/Makefile.am
+++ b/src/common/Makefile.am
@@ -6,7 +6,8 @@ SUBDIRS = compat hashtable kernel-ctl sessiond-comm relayd \
 AM_CFLAGS = -fno-strict-aliasing
 
 noinst_HEADERS = lttng-kernel.h defaults.h macros.h error.h futex.h \
-				 uri.h utils.h lttng-kernel-old.h
+				 uri.h utils.h lttng-kernel-old.h \
+				 consumer-metadata-cache.h
 
 # Common library
 noinst_LTLIBRARIES = libcommon.la
@@ -18,7 +19,7 @@ libcommon_la_LIBADD = -luuid
 # Consumer library
 noinst_LTLIBRARIES += libconsumer.la
 
-libconsumer_la_SOURCES = consumer.c consumer.h
+libconsumer_la_SOURCES = consumer.c consumer.h consumer-metadata-cache.c
 
 libconsumer_la_LIBADD = \
 		$(top_builddir)/src/common/sessiond-comm/libsessiond-comm.la \
diff --git a/src/common/consumer-metadata-cache.c b/src/common/consumer-metadata-cache.c
new file mode 100644
index 0000000..f794c92
--- /dev/null
+++ b/src/common/consumer-metadata-cache.c
@@ -0,0 +1,213 @@
+/*
+ * Copyright (C) 2013 - Julien Desfossez <jdesfossez@efficios.com>
+ *                      David Goulet <dgoulet@efficios.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2 only,
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#define _GNU_SOURCE
+#include <assert.h>
+#include <pthread.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <inttypes.h>
+
+#include <common/common.h>
+#include <common/utils.h>
+#include <common/sessiond-comm/sessiond-comm.h>
+#include <common/ust-consumer/ust-consumer.h>
+#include <common/consumer.h>
+
+#include "consumer-metadata-cache.h"
+
+#ifndef max_t
+#define max_t(type, a, b)	((type) ((a) > (b) ? (a) : (b)))
+#endif
+
+
+/*
+ * Extend the allocated size of the metadata cache.
+ * Called only from lttng_ustconsumer_write_metadata_cache.
+ *
+ * Return 0 on success, a negative value on error.
+ */
+int lttng_consumer_extend_metadata_cache(struct lttng_consumer_channel *channel,
+		unsigned int size)
+{
+	int ret = 0;
+	char *tmp_data_ptr;
+	unsigned int new_size;
+
+	assert(channel);
+	assert(channel->metadata_cache);
+
+	new_size = max_t(unsigned int,
+			channel->metadata_cache->cache_alloc_size + size,
+			channel->metadata_cache->cache_alloc_size << 1);
+	DBG("Extending metadata cache to %u", new_size);
+	tmp_data_ptr = realloc(channel->metadata_cache->data, new_size);
+	if (!tmp_data_ptr) {
+		ERR("Reallocating metadata cache");
+		free(channel->metadata_cache->data);
+		ret = -1;
+		goto end;
+	}
+	channel->metadata_cache->data = tmp_data_ptr;
+	channel->metadata_cache->cache_alloc_size = new_size;
+
+end:
+	return ret;
+}
+
+/*
+ * Write metadata to the cache, extend the cache if necessary.
+ * We support non-contiguous updates but not overlapping ones.
+ * If there is contiguous metadata in the cache, we send it to the ring buffer.
+ * The metadata cache lock MUST be acquired to write in the cache.
+ *
+ * Return 0 on success, a negative value on error.
+ */
+int lttng_consumer_write_metadata_cache(struct lttng_consumer_channel *channel,
+		unsigned int offset, unsigned int len, char *data)
+{
+	int ret = 0;
+	struct lttng_consumer_metadata_cache *cache;
+
+	assert(channel);
+	assert(channel->metadata_cache);
+
+	cache = channel->metadata_cache;
+	DBG("Writing %u bytes from offset %u in metadata cache",
+			len, offset);
+
+	if (offset + len > cache->cache_alloc_size) {
+		ret = lttng_consumer_extend_metadata_cache(channel,
+				len - cache->cache_alloc_size + offset);
+		if (ret < 0) {
+			ERR("Extending metadata cache");
+			goto end;
+		}
+	}
+
+	memcpy(cache->data + offset, data, len);
+	cache->total_bytes_written += len;
+	if (offset + len > cache->max_offset) {
+		cache->max_offset = offset + len;
+	}
+
+	if (cache->max_offset == cache->total_bytes_written) {
+		offset = cache->rb_pushed;
+		len = cache->total_bytes_written - cache->rb_pushed;
+		ret = lttng_ustconsumer_push_metadata(channel, cache->data, offset, len);
+		if (ret < 0) {
+			ERR("Pushing metadata");
+			goto end;
+		}
+	}
+
+end:
+	return ret;
+}
+
+/*
+ * Create the metadata cache, original allocated size : max_sb_size
+ *
+ * Return 0 on success, a negative value on error.
+ */
+int lttng_consumer_allocate_metadata_cache(struct lttng_consumer_channel *channel)
+{
+	int ret;
+
+	channel->metadata_cache = zmalloc(sizeof(struct lttng_consumer_metadata_cache));
+	if (!channel->metadata_cache) {
+		PERROR("zmalloc metadata cache struct");
+		ret = -1;
+		goto end;
+	}
+	ret = pthread_mutex_init(&channel->metadata_cache->lock, NULL);
+	if (ret != 0) {
+		PERROR("mutex init");
+		goto end_free_cache;
+	}
+
+	channel->metadata_cache->cache_alloc_size =
+		DEFAULT_METADATA_CACHE_SIZE;
+	channel->metadata_cache->data = zmalloc(
+			channel->metadata_cache->cache_alloc_size * sizeof(char));
+	if (!channel->metadata_cache->data) {
+		PERROR("zmalloc metadata cache data");
+		ret = -1;
+		goto end_free_mutex;
+	}
+	DBG("Allocated metadata cache of %" PRIu64 " bytes",
+			channel->metadata_cache->cache_alloc_size);
+
+	ret = 0;
+	goto end;
+
+end_free_mutex:
+	pthread_mutex_destroy(&channel->metadata_cache->lock);
+end_free_cache:
+	free(channel->metadata_cache);
+end:
+	return ret;
+}
+
+/*
+ * Destroy and free the metadata cache
+ */
+void lttng_consumer_destroy_metadata_cache(struct lttng_consumer_channel *channel)
+{
+	if (!channel || !channel->metadata_cache) {
+		return;
+	}
+	DBG("Destroying metadata cache");
+
+	if (channel->metadata_cache->max_offset >
+			channel->metadata_cache->rb_pushed) {
+		ERR("Destroying a cache not entirely commited");
+	}
+	pthread_mutex_destroy(&channel->metadata_cache->lock);
+	free(channel->metadata_cache->data);
+	free(channel->metadata_cache);
+}
+
+/*
+ * Check if the cache is flushed up to the offset passed in parameter.
+ *
+ * Return 0 if everything has been flushed, 1 if there is data not flushed.
+ */
+int lttng_consumer_flushed_cache(struct lttng_consumer_channel *channel,
+		uint64_t offset)
+{
+	struct lttng_consumer_metadata_cache *cache;
+	int ret;
+
+	assert(channel);
+	assert(channel->metadata_cache);
+
+	cache = channel->metadata_cache;
+
+	pthread_mutex_lock(&channel->metadata_cache->lock);
+	if (cache->rb_pushed >= offset) {
+		ret = 0;
+	} else {
+		ret = 1;
+	}
+	pthread_mutex_unlock(&channel->metadata_cache->lock);
+
+	return ret;
+}
diff --git a/src/common/consumer-metadata-cache.h b/src/common/consumer-metadata-cache.h
new file mode 100644
index 0000000..fe0d833
--- /dev/null
+++ b/src/common/consumer-metadata-cache.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2013 - Julien Desfossez <jdesfossez@efficios.com>
+ *                      David Goulet <dgoulet@efficios.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2 only,
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef METADATA_CACHE_H
+#define METADATA_CACHE_H
+
+#include <common/consumer.h>
+
+int lttng_consumer_extend_metadata_cache(
+		struct lttng_consumer_channel *channel,
+		unsigned int size);
+int lttng_consumer_write_metadata_cache(
+		struct lttng_consumer_channel *channel,
+		unsigned int offset, unsigned int len, char *data);
+int lttng_consumer_allocate_metadata_cache(struct lttng_consumer_channel *channel);
+void lttng_consumer_destroy_metadata_cache(struct lttng_consumer_channel *channel);
+int lttng_consumer_flushed_cache(struct lttng_consumer_channel *channel,
+		uint64_t offset);
+#endif /* METADATA_CACHE_H */
diff --git a/src/common/consumer.c b/src/common/consumer.c
index 29bd0c0..d739839 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -28,6 +28,7 @@
 #include <sys/types.h>
 #include <unistd.h>
 #include <inttypes.h>
+#include <signal.h>
 
 #include <common/common.h>
 #include <common/utils.h>
@@ -1006,6 +1007,15 @@ void lttng_consumer_set_command_sock_path(
 }
 
 /*
+ * Set the metadata socket.
+ */
+void lttng_consumer_set_metadata_sock(struct lttng_consumer_local_data *ctx,
+		int sock)
+{
+	ctx->consumer_metadata_socket = sock;
+}
+
+/*
  * Send return code to the session daemon.
  * If the socket is not defined, we return 0, it is not a fatal error
  */
@@ -1141,6 +1151,7 @@ struct lttng_consumer_local_data *lttng_consumer_create(
 	}
 
 	ctx->consumer_error_socket = -1;
+	ctx->consumer_metadata_socket = -1;
 	/* assign the callbacks */
 	ctx->on_buffer_ready = buffer_ready;
 	ctx->on_recv_channel = recv_channel;
@@ -1227,6 +1238,10 @@ void lttng_consumer_destroy(struct lttng_consumer_local_data *ctx)
 	if (ret) {
 		PERROR("close");
 	}
+	ret = close(ctx->consumer_metadata_socket);
+	if (ret) {
+		PERROR("close");
+	}
 	utils_close_pipe(ctx->consumer_thread_pipe);
 	utils_close_pipe(ctx->consumer_channel_pipe);
 	utils_close_pipe(ctx->consumer_data_pipe);
@@ -1328,6 +1343,7 @@ ssize_t lttng_consumer_on_read_subbuffer_mmap(
 			goto end;
 		}
 		ret = lttng_ustctl_get_mmap_read_offset(stream, &mmap_offset);
+
 		break;
 	default:
 		ERR("Unknown consumer_data type");
diff --git a/src/common/consumer.h b/src/common/consumer.h
index 82b9bc6..5aff6b5 100644
--- a/src/common/consumer.h
+++ b/src/common/consumer.h
@@ -32,6 +32,10 @@
 #include <common/compat/uuid.h>
 #include <common/sessiond-comm/sessiond-comm.h>
 
+#define LTTNG_CONSUMER_SIG_SWITCH	SIGRTMIN + 10
+#define LTTNG_CONSUMER_SIG_TEARDOWN	SIGRTMIN + 11
+#define CLOCKID		CLOCK_MONOTONIC
+
 /* Commands for consumer */
 enum lttng_consumer_command {
 	LTTNG_CONSUMER_ADD_CHANNEL,
@@ -89,6 +93,33 @@ struct stream_list {
 	unsigned int count;
 };
 
+struct lttng_consumer_metadata_cache {
+	char *data;
+	uint64_t cache_alloc_size;
+	/*
+	 * How many bytes from the cache were already sent to
+	 * the ring buffer
+	 */
+	uint64_t rb_pushed;
+	/*
+	 * How many bytes are written in the buffer (excluding the wholes)
+	 */
+	uint64_t total_bytes_written;
+	/*
+	 * The upper-limit of data written inside the buffer.
+	 *
+	 * With the total_bytes_written it allows us to keep track of when the
+	 * cache contains contiguous metadata ready to be sent to the RB.
+	 * The metadata cache updates must not overlap.
+	 */
+	uint64_t max_offset;
+	/*
+	 * Lock to update the metadata cache and push into the
+	 * ring_buffer (ustctl_write_metadata_to_channel)
+	 */
+	pthread_mutex_t lock;
+};
+
 struct lttng_consumer_channel {
 	/* HT node used for consumer_data.channel_ht */
 	struct lttng_ht_node_u64 node;
@@ -132,16 +163,17 @@ struct lttng_consumer_channel {
 	 * regular channel, this is always set to NULL.
 	 */
 	struct lttng_consumer_stream *metadata_stream;
-	/*
-	 * Metadata written so far. Helps keeping track of
-	 * contiguousness and order.
-	 */
-	uint64_t contig_metadata_written;
 
 	/* for UST */
 	int wait_fd;
 	/* Node within channel thread ht */
 	struct lttng_ht_node_u64 wait_fd_node;
+
+	/* Metadata cache is metadata channel */
+	struct lttng_consumer_metadata_cache *metadata_cache;
+	/* For metadata periodical flush */
+	int switch_timer_enabled;
+	timer_t switch_timer;
 };
 
 /*
@@ -324,6 +356,8 @@ struct lttng_consumer_local_data {
 	int (*on_update_stream)(int sessiond_key, uint32_t state);
 	/* socket to communicate errors with sessiond */
 	int consumer_error_socket;
+	/* socket to ask metadata to sessiond */
+	int consumer_metadata_socket;
 	/* socket to exchange commands with sessiond */
 	char *consumer_command_sock_path;
 	/* communication with splice */
@@ -389,6 +423,19 @@ struct lttng_consumer_global_data {
 };
 
 /*
+ * Handle timer teardown race wrt memory free of private data by
+ * consumer signals are handled by a single thread, which permits
+ * a synchronization point between handling of each signal.
+ */
+struct timer_signal_data {
+	pthread_t tid;	/* thread id managing signals */
+	int setup_done;
+	int qs_done;
+};
+
+struct timer_signal_data timer_signal;
+
+/*
  * Init consumer data structures.
  */
 void lttng_consumer_init(void);
@@ -406,6 +453,12 @@ void lttng_consumer_set_command_sock_path(
 		struct lttng_consumer_local_data *ctx, char *sock);
 
 /*
+ * Set the socket to ask metadata to the sessiond
+ */
+void lttng_consumer_set_metadata_sock(struct lttng_consumer_local_data *ctx,
+		int sock);
+
+/*
  * Send return code to session daemon.
  *
  * Returns the return code of sendmsg : the number of bytes transmitted or -1
@@ -494,6 +547,7 @@ void *consumer_thread_metadata_poll(void *data);
 void *consumer_thread_data_poll(void *data);
 void *consumer_thread_sessiond_poll(void *data);
 void *consumer_thread_channel_poll(void *data);
+void *consumer_thread_metadata_timer(void *data);
 int lttng_consumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 		int sock, struct pollfd *consumer_sockpoll);
 
@@ -510,5 +564,6 @@ int consumer_data_pending(uint64_t id);
 int consumer_send_status_msg(int sock, int ret_code);
 int consumer_send_status_channel(int sock,
 		struct lttng_consumer_channel *channel);
+void consumer_signal_init(void);
 
 #endif /* LIB_CONSUMER_H */
diff --git a/src/common/defaults.h b/src/common/defaults.h
index 658e7d3..5271181 100644
--- a/src/common/defaults.h
+++ b/src/common/defaults.h
@@ -70,11 +70,13 @@
 #define DEFAULT_USTCONSUMERD64_PATH             DEFAULT_CONSUMERD_RUNDIR "/ustconsumerd64"
 #define DEFAULT_USTCONSUMERD64_CMD_SOCK_PATH    DEFAULT_USTCONSUMERD64_PATH "/command"
 #define DEFAULT_USTCONSUMERD64_ERR_SOCK_PATH    DEFAULT_USTCONSUMERD64_PATH "/error"
+#define DEFAULT_USTCONSUMERD64_META_SOCK_PATH   DEFAULT_USTCONSUMERD64_PATH "/metadata"
 
 /* UST 32-bit consumer path */
 #define DEFAULT_USTCONSUMERD32_PATH             DEFAULT_CONSUMERD_RUNDIR "/ustconsumerd32"
 #define DEFAULT_USTCONSUMERD32_CMD_SOCK_PATH    DEFAULT_USTCONSUMERD32_PATH "/command"
 #define DEFAULT_USTCONSUMERD32_ERR_SOCK_PATH    DEFAULT_USTCONSUMERD32_PATH "/error"
+#define DEFAULT_USTCONSUMERD32_META_SOCK_PATH   DEFAULT_USTCONSUMERD32_PATH "/metadata"
 
 
 /* Default lttng run directory */
@@ -124,6 +126,7 @@
 
 #define DEFAULT_METADATA_SUBBUF_SIZE    4096
 #define DEFAULT_METADATA_SUBBUF_NUM     2
+#define DEFAULT_METADATA_CACHE_SIZE     4096
 
 /* Kernel has different defaults */
 
@@ -179,6 +182,12 @@
 #define DEFAULT_DATA_AVAILABILITY_WAIT_TIME 200000  /* usec */
 
 /*
+ * Wait period before retrying the lttng_consumer_flushed_cache when
+ * the consumer receives metadata.
+ */
+#define DEFAULT_METADATA_AVAILABILITY_WAIT_TIME 200000  /* usec */
+
+/*
  * Default receiving and sending timeout for an application socket.
  */
 #define DEFAULT_APP_SOCKET_RW_TIMEOUT       5  /* sec */
diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index 6350fd1..eb0df5e 100644
--- a/src/common/sessiond-comm/sessiond-comm.h
+++ b/src/common/sessiond-comm/sessiond-comm.h
@@ -138,6 +138,26 @@ enum lttcomm_sock_domain {
 	LTTCOMM_INET6     = 1,
 };
 
+enum lttcomm_metadata_command {
+	LTTCOMM_METADATA_REQUEST = 1,
+};
+
+/*
+ * Commands sent from the consumerd to the sessiond to request
+ * if new metadata is available
+ */
+struct lttcomm_metadata {
+	enum lttcomm_metadata_command command;
+	union {
+		struct {
+			unsigned int session_id; /* Tracing session id */
+			uint32_t bits_per_long; /* Consumer ABI */
+			uint32_t uid;
+			uint64_t key; /* Metadata channel key. */
+		} LTTNG_PACKED metadata_request;
+	} u;
+} LTTNG_PACKED;
+
 struct lttcomm_sockaddr {
 	enum lttcomm_sock_domain type;
 	union {
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index 06b59c5..108e18b 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -30,11 +30,13 @@
 #include <inttypes.h>
 #include <unistd.h>
 #include <urcu/list.h>
+#include <signal.h>
 
 #include <common/common.h>
 #include <common/sessiond-comm/sessiond-comm.h>
 #include <common/relayd/relayd.h>
 #include <common/compat/fcntl.h>
+#include <common/consumer-metadata-cache.h>
 
 #include "ust-consumer.h"
 
@@ -530,10 +532,12 @@ error:
 /*
  * Write metadata to the given channel using ustctl to convert the string to
  * the ringbuffer.
+ * Called only from lttng_consumer_write_metadata_cache.
+ * The metadata cache lock MUST be acquired to write in the cache.
  *
  * Return 0 on success else a negative value.
  */
-static int push_metadata(struct lttng_consumer_channel *metadata,
+int lttng_ustconsumer_push_metadata(struct lttng_consumer_channel *metadata,
 		const char *metadata_str, uint64_t target_offset, uint64_t len)
 {
 	int ret;
@@ -543,13 +547,13 @@ static int push_metadata(struct lttng_consumer_channel *metadata,
 
 	DBG("UST consumer writing metadata to channel %s", metadata->name);
 
-	assert(target_offset == metadata->contig_metadata_written);
+	assert(target_offset <= metadata->metadata_cache->max_offset);
 	ret = ustctl_write_metadata_to_channel(metadata->uchan, metadata_str, len);
 	if (ret < 0) {
 		ERR("ustctl write metadata fail with ret %d, len %ld", ret, len);
 		goto error;
 	}
-	metadata->contig_metadata_written += len;
+	metadata->metadata_cache->rb_pushed += len;
 
 	ustctl_flush_buffer(metadata->metadata_stream->ustream, 1);
 
@@ -557,6 +561,54 @@ error:
 	return ret;
 }
 
+static
+void consumer_switch_timer_stop(struct lttng_consumer_channel *channel)
+{
+	sigset_t pending_set;
+	int ret;
+
+	ret = timer_delete(channel->switch_timer);
+	if (ret == -1) {
+		PERROR("timer_delete");
+	}
+
+	/*
+	 * Ensure we don't have any signal queued for this channel.
+	 */
+	for (;;) {
+		ret = sigemptyset(&pending_set);
+		if (ret == -1) {
+			PERROR("sigemptyset");
+		}
+		ret = sigpending(&pending_set);
+		if (ret == -1) {
+			PERROR("sigpending");
+		}
+		if (!sigismember(&pending_set, LTTNG_CONSUMER_SIG_SWITCH))
+			break;
+		caa_cpu_relax();
+	}
+
+	/*
+	 * From this point, no new signal handler will be fired that
+	 * would try to access "chan". However, we still need to wait
+	 * for any currently executing handler to complete.
+	 */
+	cmm_smp_mb();
+	CMM_STORE_SHARED(timer_signal.qs_done, 0);
+	cmm_smp_mb();
+	/*
+	 * Kill with LTTNG_CONSUMER_SIG_TEARDOWN, so signal management
+	 * thread wakes up.
+	 */
+	kill(getpid(), LTTNG_CONSUMER_SIG_TEARDOWN);
+
+	while (!CMM_LOAD_SHARED(timer_signal.qs_done)) {
+		caa_cpu_relax();
+	}
+	cmm_smp_mb();
+}
+
 /*
  * Flush channel's streams using the given key to retrieve the channel.
  *
@@ -619,6 +671,11 @@ static int close_metadata(uint64_t chan_key)
 		ret = LTTCOMM_CONSUMERD_ERROR_METADATA;
 		goto error;
 	}
+	if (channel->switch_timer_enabled == 1) {
+		DBG("Deleting timer on metadata channel");
+		consumer_switch_timer_stop(channel);
+	}
+	lttng_consumer_destroy_metadata_cache(channel);
 
 error:
 	return ret;
@@ -679,6 +736,88 @@ error:
 }
 
 /*
+ * Set the timer for periodical metadata flush
+ */
+static void consumer_switch_timer_start(struct lttng_consumer_channel *channel,
+		struct ustctl_consumer_channel_attr *attr)
+{
+	struct sigevent sev;
+	struct itimerspec its;
+	int ret;
+
+	if (attr->switch_timer_interval == 0) {
+		return;
+	}
+
+	sev.sigev_notify = SIGEV_SIGNAL;
+	sev.sigev_signo = LTTNG_CONSUMER_SIG_SWITCH;
+	sev.sigev_value.sival_ptr = channel;
+	ret = timer_create(CLOCKID, &sev, &channel->switch_timer);
+	if (ret == -1) {
+		PERROR("timer_create");
+	}
+	channel->switch_timer_enabled = 1;
+
+	its.it_value.tv_sec = attr->switch_timer_interval / 1000000;
+	its.it_value.tv_nsec = attr->switch_timer_interval % 1000000;
+	its.it_interval.tv_sec = its.it_value.tv_sec;
+	its.it_interval.tv_nsec = its.it_value.tv_nsec;
+
+	ret = timer_settime(channel->switch_timer, 0, &its, NULL);
+	if (ret == -1) {
+		PERROR("timer_settime");
+	}
+	attr->switch_timer_interval = 0;
+}
+
+/*
+ * Receive the metadata updates from the sessiond.
+ */
+int lttng_ustconsumer_recv_metadata(int sock, uint64_t key, uint64_t offset,
+		uint64_t len, struct lttng_consumer_channel *channel)
+{
+	int ret, ret_code = LTTNG_OK;
+	char *metadata_str;
+
+	DBG("UST consumer push metadata key %lu of len %lu", key, len);
+
+	metadata_str = zmalloc(len * sizeof(char));
+	if (!metadata_str) {
+		PERROR("zmalloc metadata string");
+		ret_code = LTTCOMM_CONSUMERD_ENOMEM;
+		goto end;
+	}
+
+	/* Receive metadata string. */
+	ret = lttcomm_recv_unix_sock(sock, metadata_str, len);
+	if (ret < 0) {
+		/* Session daemon is dead so return gracefully. */
+		ret_code = ret;
+		goto end_free;
+	}
+
+	pthread_mutex_lock(&channel->metadata_cache->lock);
+	ret = lttng_consumer_write_metadata_cache(channel, offset, len,
+			metadata_str);
+	if (ret < 0) {
+		/* Unable to handle metadata. Notify session daemon. */
+		ret_code = LTTCOMM_CONSUMERD_ERROR_METADATA;
+	}
+	pthread_mutex_unlock(&channel->metadata_cache->lock);
+
+	while (lttng_consumer_flushed_cache(channel, offset + len)) {
+		DBG("Waiting for metadata to be flushed");
+		usleep(DEFAULT_METADATA_AVAILABILITY_WAIT_TIME);
+	}
+
+end_free:
+	free(metadata_str);
+
+end:
+	return ret_code;
+}
+
+/*
  * Receive command from session daemon and process it.
  *
  * Return 1 on success else a negative value or 0.
@@ -847,6 +986,7 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 			goto end_channel_error;
 		}
 
+
 		/*
 		 * Channel and streams are now created. Inform the session daemon that
 		 * everything went well and should wait to receive the channel and
@@ -861,6 +1001,15 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 			goto end_nosignal;
 		}
 
+		if (msg.u.ask_channel.type == LTTNG_UST_CHAN_METADATA) {
+			ret = lttng_consumer_allocate_metadata_cache(channel);
+			if (ret < 0) {
+				ERR("Allocating metadata cache");
+				goto end_channel_error;
+			}
+			consumer_switch_timer_start(channel, &attr);
+		}
+
 		break;
 	}
 	case LTTNG_CONSUMER_GET_CHANNEL:
@@ -957,10 +1106,9 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 	{
 		int ret;
 		uint64_t len = msg.u.push_metadata.len;
-		uint64_t target_offset = msg.u.push_metadata.target_offset;
 		uint64_t key = msg.u.push_metadata.key;
+		uint64_t offset = msg.u.push_metadata.target_offset;
 		struct lttng_consumer_channel *channel;
-		char *metadata_str;
 
 		DBG("UST consumer push metadata key %lu of len %lu", key, len);
 
@@ -968,14 +1116,6 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 		if (!channel) {
 			ERR("UST consumer push metadata %lu not found", key);
 			ret_code = LTTNG_ERR_UST_CHAN_NOT_FOUND;
-			goto end_msg_sessiond;
-		}
-
-		metadata_str = zmalloc(len * sizeof(char));
-		if (!metadata_str) {
-			PERROR("zmalloc metadata string");
-			ret_code = LTTCOMM_CONSUMERD_ENOMEM;
-			goto end_msg_sessiond;
 		}
 
 		/* Tell session daemon we are ready to receive the metadata. */
@@ -990,22 +1130,15 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 			goto end_nosignal;
 		}
 
-		/* Receive metadata string. */
-		ret = lttcomm_recv_unix_sock(sock, metadata_str, len);
+		ret = lttng_ustconsumer_recv_metadata(sock, key, offset,
+				len, channel);
 		if (ret < 0) {
-			/* Session daemon is dead so return gracefully. */
+			/* error receiving from sessiond */
 			goto end_nosignal;
-		}
-
-		ret = push_metadata(channel, metadata_str, target_offset, len);
-		free(metadata_str);
-		if (ret < 0) {
-			/* Unable to handle metadata. Notify session daemon. */
-			ret_code = LTTCOMM_CONSUMERD_ERROR_METADATA;
+		} else {
+			ret_code = ret;
 			goto end_msg_sessiond;
 		}
-
-		goto end_msg_sessiond;
 	}
 	case LTTNG_CONSUMER_SETUP_METADATA:
 	{
@@ -1223,6 +1356,7 @@ int lttng_ustconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
 	}
 	err = ustctl_put_next_subbuf(ustream);
 	assert(err == 0);
+
 end:
 	return ret;
 }
@@ -1343,3 +1477,188 @@ void lttng_ustconsumer_close_stream_wakeup(struct lttng_consumer_stream *stream)
 		ERR("Unable to close wakeup fd");
 	}
 }
+
+static void consumer_setmask(sigset_t *mask)
+{
+	int ret;
+
+	ret = sigemptyset(mask);
+	if (ret) {
+		PERROR("sigemptyset");
+	}
+	ret = sigaddset(mask, LTTNG_CONSUMER_SIG_SWITCH);
+	if (ret) {
+		PERROR("sigaddset");
+	}
+	ret = sigaddset(mask, LTTNG_CONSUMER_SIG_TEARDOWN);
+	if (ret) {
+		PERROR("sigaddset");
+	}
+}
+
+/*
+ * Block the RT signals for the entire process. It must be called
+ * from the consumer main before creating the threads
+ */
+void consumer_signal_init(void)
+{
+	sigset_t mask;
+	int ret;
+
+	/*
+	 * Block signal for entire process, so only our thread processes
+	 * it.
+	 */
+	consumer_setmask(&mask);
+	ret = pthread_sigmask(SIG_BLOCK, &mask, NULL);
+	if (ret) {
+		errno = ret;
+		PERROR("pthread_sigmask");
+	}
+}
+
+static int sessiond_request_metadata(struct lttng_consumer_local_data *ctx,
+		struct lttng_consumer_channel *channel)
+{
+	struct lttcomm_metadata metadata_request;
+	struct lttcomm_consumer_msg msg;
+	enum lttng_error_code ret_code = LTTNG_OK;
+	uint64_t len, key, offset;
+	int ret;
+
+	assert(channel);
+	assert(channel->metadata_cache);
+
+	/* send the metadata request to sessiond */
+	metadata_request.command = LTTCOMM_METADATA_REQUEST;
+	switch (consumer_data.type) {
+	case LTTNG_CONSUMER64_UST:
+		metadata_request.u.metadata_request.bits_per_long = 64;
+		break;
+	case LTTNG_CONSUMER32_UST:
+		metadata_request.u.metadata_request.bits_per_long = 32;
+		break;
+	default:
+		metadata_request.u.metadata_request.bits_per_long = 0;
+		break;
+	}
+	metadata_request.u.metadata_request.session_id =
+		channel->session_id;
+	metadata_request.u.metadata_request.uid =
+		channel->uid;
+	metadata_request.u.metadata_request.key =
+		channel->key;
+	DBG("Sending metadata request to sessiond, session %" PRIu64,
+			channel->session_id);
+	ret = lttcomm_send_unix_sock(ctx->consumer_metadata_socket,
+			&metadata_request,
+			sizeof(metadata_request));
+	if (ret < 0) {
+		ERR("Asking metadata to sessiond");
+		goto end;
+	}
+
+	/* Receive the metadata from sessiond */
+	ret = lttcomm_recv_unix_sock(ctx->consumer_metadata_socket,
+			&msg, sizeof(msg));
+	if (ret != sizeof(msg)) {
+		DBG("Consumer received unexpected message size %d (expects %lu)",
+			ret, sizeof(msg));
+		lttng_consumer_send_error(ctx, LTTCOMM_CONSUMERD_ERROR_RECV_CMD);
+		/*
+		 * The ret value might 0 meaning an orderly shutdown but this is ok
+		 * since the caller handles this.
+		 */
+		goto end;
+	}
+	if (msg.cmd_type == LTTNG_ERR_UND) {
+		/* No registry found */
+		(void) consumer_send_status_msg(ctx->consumer_metadata_socket,
+				ret_code);
+		ret = 0;
+		goto end;
+	} else if (msg.cmd_type != LTTNG_CONSUMER_PUSH_METADATA) {
+		ERR("Unexpected cmd_type received %d", msg.cmd_type);
+		ret = -1;
+		goto end;
+	}
+
+	len = msg.u.push_metadata.len;
+	key = msg.u.push_metadata.key;
+	offset = msg.u.push_metadata.target_offset;
+
+	assert(key == channel->key);
+	if (len == 0) {
+		DBG("No new metadata to receive");
+		ret = 0;
+	}
+
+	/* Tell session daemon we are ready to receive the metadata. */
+	ret = consumer_send_status_msg(ctx->consumer_metadata_socket,
+			LTTNG_OK);
+	if (ret < 0) {
+		/* Somehow, the session daemon is not responding anymore. */
+		goto end;
+	}
+
+	if (len > 0) {
+		ret_code = lttng_ustconsumer_recv_metadata(
+				ctx->consumer_metadata_socket,
+				key, offset, len, channel);
+		(void) consumer_send_status_msg(ctx->consumer_metadata_socket,
+				ret_code);
+		ret = 0;
+	}
+
+end:
+	return ret;
+}
+
+static
+void consumer_switch_timer(struct lttng_consumer_local_data *ctx, int sig,
+		siginfo_t *si, void *uc)
+{
+	struct lttng_consumer_channel *channel;
+
+	channel = si->si_value.sival_ptr;
+	DBG("Switch timer for channel %" PRIu64, channel->key);
+	sessiond_request_metadata(ctx, channel);
+}
+
+/*
+ * This thread is the sighandler for signals LTTNG_CONSUMER_SIG_SWITCH and
+ * LTTNG_CONSUMER_SIG_TEARDOWN that are emitted by the
+ * periodic timer to check if new metadata is available.
+ */
+void *consumer_thread_metadata_timer(void *data)
+{
+	sigset_t mask;
+	siginfo_t info;
+	int signr;
+	struct lttng_consumer_local_data *ctx = data;
+
+	/* Only self thread will receive signal mask. */
+	consumer_setmask(&mask);
+	CMM_STORE_SHARED(timer_signal.tid, pthread_self());
+
+	for (;;) {
+		signr = sigwaitinfo(&mask, &info);
+		if (signr == -1) {
+			if (errno != EINTR)
+				PERROR("sigwaitinfo");
+			continue;
+		}
+		if (signr == LTTNG_CONSUMER_SIG_SWITCH) {
+			consumer_switch_timer(ctx, info.si_signo,
+					&info, NULL);
+		} else if (signr == LTTNG_CONSUMER_SIG_TEARDOWN) {
+			cmm_smp_mb();
+			CMM_STORE_SHARED(timer_signal.qs_done, 1);
+			cmm_smp_mb();
+			DBG("Signal teardown");
+		} else {
+			ERR("Unexpected signal %d\n", info.si_signo);
+		}
+	}
+	return NULL;
+}
diff --git a/src/common/ust-consumer/ust-consumer.h b/src/common/ust-consumer/ust-consumer.h
index bbaff6c..6011f8b 100644
--- a/src/common/ust-consumer/ust-consumer.h
+++ b/src/common/ust-consumer/ust-consumer.h
@@ -51,6 +51,10 @@ void *lttng_ustctl_get_mmap_base(struct lttng_consumer_stream *stream);
 int lttng_ustconsumer_data_pending(struct lttng_consumer_stream *stream);
 void lttng_ustconsumer_close_metadata(struct lttng_ht *ht);
 void lttng_ustconsumer_close_stream_wakeup(struct lttng_consumer_stream *stream);
+int lttng_ustconsumer_recv_metadata(int sock, uint64_t key, uint64_t offset,
+		uint64_t len, struct lttng_consumer_channel *channel);
+int lttng_ustconsumer_push_metadata(struct lttng_consumer_channel *metadata,
+		const char *metadata_str, uint64_t target_offset, uint64_t len);
 
 #else /* HAVE_LIBLTTNG_UST_CTL */
 
diff --git a/tests/unit/Makefile.am b/tests/unit/Makefile.am
index a9d65ab..76210f1 100644
--- a/tests/unit/Makefile.am
+++ b/tests/unit/Makefile.am
@@ -47,6 +47,7 @@ UST_DATA_TRACE=$(top_srcdir)/src/bin/lttng-sessiond/trace-ust.c \
 		   $(top_srcdir)/src/bin/lttng-sessiond/ust-consumer.c \
 		   $(top_srcdir)/src/bin/lttng-sessiond/fd-limit.c \
 		   $(top_srcdir)/src/bin/lttng-sessiond/health.c \
+		   $(top_srcdir)/src/bin/lttng-sessiond/session.c \
 	       $(top_srcdir)/src/common/uri.c \
 	       $(top_srcdir)/src/common/utils.c
 
-- 
1.7.10.4
