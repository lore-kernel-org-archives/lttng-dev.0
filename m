From: David Goulet <dgoulet@efficios.com>
Subject: [PATCH lttng-tools] UST periodical metadata flush
Date: Tue, 26 Mar 2013 13:49:59 -0400
Message-ID: <1364320199-30440-1-git-send-email-dgoulet__13474.5892872617$1364320270$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UKY0h-00041f-LJ
	for lttng-dev@lists.lttng.org; Tue, 26 Mar 2013 13:50:12 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

From: Julien Desfossez <jdesfossez@efficios.com>

Add a socket between the sessiond and the ust-consumer to allow
periodical flush of the metadata channel.

If enabled (by specifying the --switch-timer option on the metadata
channel), a new timer thread in the consumer asks the session daemon for
new metadata for a specific session.

All the metadata collected is written into a metadata cache in the
consumer, this mechanism is useful for synchronisation (to avoid race
conditions between two metadata updates) and will also be useful when we
implement the snapshots.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
Signed-off-by: David Goulet <dgoulet@efficios.com>
---
 src/bin/lttng-consumerd/lttng-consumerd.c |   29 ++++
 src/bin/lttng-sessiond/consumer.c         |    4 +-
 src/bin/lttng-sessiond/consumer.h         |    2 +
 src/bin/lttng-sessiond/main.c             |  147 +++++++++++++-------
 src/bin/lttng-sessiond/ust-app.c          |  109 +++++++++------
 src/bin/lttng-sessiond/ust-app.h          |    8 ++
 src/bin/lttng-sessiond/ust-consumer.c     |   77 ++++++++++
 src/bin/lttng-sessiond/ust-consumer.h     |    1 +
 src/common/Makefile.am                    |    6 +-
 src/common/consumer-metadata-cache.c      |  214 ++++++++++++++++++++++++++++
 src/common/consumer-metadata-cache.h      |   58 ++++++++
 src/common/consumer-timer.c               |  216 +++++++++++++++++++++++++++++
 src/common/consumer-timer.h               |   49 +++++++
 src/common/consumer.c                     |   43 ++++++
 src/common/consumer.h                     |   17 ++-
 src/common/defaults.h                     |    8 +-
 src/common/macros.h                       |    4 +
 src/common/sessiond-comm/sessiond-comm.h  |   15 ++
 src/common/ust-consumer/ust-consumer.c    |  194 ++++++++++++++++++++++----
 src/common/ust-consumer/ust-consumer.h    |    6 +
 tests/unit/Makefile.am                    |    5 +-
 21 files changed, 1082 insertions(+), 130 deletions(-)
 create mode 100644 src/common/consumer-metadata-cache.c
 create mode 100644 src/common/consumer-metadata-cache.h
 create mode 100644 src/common/consumer-timer.c
 create mode 100644 src/common/consumer-timer.h

diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c b/src/bin/lttng-consumerd/lttng-consumerd.c
index 8486807..7ca9688 100644
--- a/src/bin/lttng-consumerd/lttng-consumerd.c
+++ b/src/bin/lttng-consumerd/lttng-consumerd.c
@@ -44,6 +44,7 @@
 #include <common/defaults.h>
 #include <common/common.h>
 #include <common/consumer.h>
+#include <common/consumer-timer.h>
 #include <common/compat/poll.h>
 #include <common/sessiond-comm/sessiond-comm.h>
 
@@ -52,7 +53,9 @@
 /* TODO : support UST (all direct kernel-ctl accesses). */
 
 /* threads (channel handling, poll, metadata, sessiond) */
+
 static pthread_t channel_thread, data_thread, metadata_thread, sessiond_thread;
+static pthread_t metadata_timer_thread;
 
 /* to count the number of times the user pressed ctrl+c */
 static int sigintcount = 0;
@@ -363,6 +366,15 @@ int main(int argc, char **argv)
 	}
 	lttng_consumer_set_error_sock(ctx, ret);
 
+	/*
+	 * For UST consumer, we block RT signals used for periodical metadata flush
+	 * in main and create a dedicated thread to handle these signals.
+	 */
+	if (opt_type != LTTNG_CONSUMER_KERNEL) {
+		consumer_signal_init();
+	}
+	ctx->type = opt_type;
+
 	/* Create thread to manage channels */
 	ret = pthread_create(&channel_thread, NULL, consumer_thread_channel_poll,
 			(void *) ctx);
@@ -395,6 +407,23 @@ int main(int argc, char **argv)
 		goto sessiond_error;
 	}
 
+	if (opt_type != LTTNG_CONSUMER_KERNEL) {
+		/* Create the thread to manage the metadata periodic timers */
+		ret = pthread_create(&metadata_timer_thread, NULL,
+				consumer_timer_metadata_thread, (void *) ctx);
+		if (ret != 0) {
+			perror("pthread_create");
+			goto metadata_timer_error;
+		}
+
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
index 57b5b19..6719051 100644
--- a/src/bin/lttng-sessiond/consumer.c
+++ b/src/bin/lttng-sessiond/consumer.c
@@ -1072,7 +1072,7 @@ end:
 }
 
 /*
- * Send metadata string to consumer.
+ * Send metadata string to consumer. Socket lock MUST be acquired.
  *
  * Return 0 on success else a negative value.
  */
@@ -1103,7 +1103,7 @@ int consumer_push_metadata(struct consumer_socket *socket,
 
 	health_code_update();
 	ret = consumer_send_msg(socket, &msg);
-	if (ret < 0) {
+	if (ret < 0 || len == 0) {
 		goto end;
 	}
 
diff --git a/src/bin/lttng-sessiond/consumer.h b/src/bin/lttng-sessiond/consumer.h
index cde2d0d..b767589 100644
--- a/src/bin/lttng-sessiond/consumer.h
+++ b/src/bin/lttng-sessiond/consumer.h
@@ -78,7 +78,9 @@ struct consumer_data {
 	pid_t pid;
 
 	int err_sock;
+	/* These two sockets uses the cmd_unix_sock_path. */
 	int cmd_sock;
+	struct consumer_socket metadata_sock;
 
 	/* consumer error and command Unix socket path */
 	char err_unix_sock_path[PATH_MAX];
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index d88bafe..a98b4f2 100644
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
+	.metadata_sock.fd = -1,
 	.pid_mutex = PTHREAD_MUTEX_INITIALIZER,
 	.lock = PTHREAD_MUTEX_INITIALIZER,
 	.cond = PTHREAD_COND_INITIALIZER,
@@ -100,6 +102,7 @@ static struct consumer_data ustconsumer64_data = {
 	.cmd_unix_sock_path = DEFAULT_USTCONSUMERD64_CMD_SOCK_PATH,
 	.err_sock = -1,
 	.cmd_sock = -1,
+	.metadata_sock.fd = -1,
 	.pid_mutex = PTHREAD_MUTEX_INITIALIZER,
 	.lock = PTHREAD_MUTEX_INITIALIZER,
 	.cond = PTHREAD_COND_INITIALIZER,
@@ -111,6 +114,7 @@ static struct consumer_data ustconsumer32_data = {
 	.cmd_unix_sock_path = DEFAULT_USTCONSUMERD32_CMD_SOCK_PATH,
 	.err_sock = -1,
 	.cmd_sock = -1,
+	.metadata_sock.fd = -1,
 	.pid_mutex = PTHREAD_MUTEX_INITIALIZER,
 	.lock = PTHREAD_MUTEX_INITIALIZER,
 	.cond = PTHREAD_COND_INITIALIZER,
@@ -865,10 +869,10 @@ static void *thread_manage_consumer(void *data)
 	health_code_update();
 
 	/*
-	 * Pass 2 as size here for the thread quit pipe and kconsumerd_err_sock.
-	 * Nothing more will be added to this poll set.
+	 * Pass 3 as size here for the thread quit pipe, consumerd_err_sock and the
+	 * metadata_sock. Nothing more will be added to this poll set.
 	 */
-	ret = sessiond_set_thread_pollset(&events, 2);
+	ret = sessiond_set_thread_pollset(&events, 3);
 	if (ret < 0) {
 		goto error_poll;
 	}
@@ -885,7 +889,7 @@ static void *thread_manage_consumer(void *data)
 
 	health_code_update();
 
-	/* Inifinite blocking call, waiting for transmission */
+	/* Infinite blocking call, waiting for transmission */
 restart:
 	health_poll_entry();
 
@@ -955,87 +959,126 @@ restart:
 	health_code_update();
 
 	if (code == LTTCOMM_CONSUMERD_COMMAND_SOCK_READY) {
+		/* Connect both socket, command and metadata. */
 		consumer_data->cmd_sock =
 			lttcomm_connect_unix_sock(consumer_data->cmd_unix_sock_path);
-		if (consumer_data->cmd_sock < 0) {
+		consumer_data->metadata_sock.fd =
+			lttcomm_connect_unix_sock(consumer_data->cmd_unix_sock_path);
+		if (consumer_data->cmd_sock < 0 ||
+				consumer_data->metadata_sock.fd < 0) {
+			PERROR("consumer connect cmd socket");
 			/* On error, signal condition and quit. */
 			signal_consumer_condition(consumer_data, -1);
-			PERROR("consumer connect");
 			goto error;
 		}
+		/* Create metadata socket lock. */
+		consumer_data->metadata_sock.lock = zmalloc(sizeof(pthread_mutex_t));
+		if (consumer_data->metadata_sock.lock == NULL) {
+			PERROR("zmalloc pthread mutex");
+			ret = -1;
+			goto error;
+		}
+		pthread_mutex_init(consumer_data->metadata_sock.lock, NULL);
+
 		signal_consumer_condition(consumer_data, 1);
-		DBG("Consumer command socket ready");
+		DBG("Consumer command socket ready (fd: %d", consumer_data->cmd_sock);
+		DBG("Consumer metadata socket ready (fd: %d)",
+				consumer_data->metadata_sock.fd);
 	} else {
 		ERR("consumer error when waiting for SOCK_READY : %s",
 				lttcomm_get_readable_code(-code));
 		goto error;
 	}
 
-	/* Remove the kconsumerd error sock since we've established a connexion */
+	/* Remove the consumerd error sock since we've established a connexion */
 	ret = lttng_poll_del(&events, consumer_data->err_sock);
 	if (ret < 0) {
 		goto error;
 	}
 
+	/* Add new accepted error socket. */
 	ret = lttng_poll_add(&events, sock, LPOLLIN | LPOLLRDHUP);
 	if (ret < 0) {
 		goto error;
 	}
 
+	/* Add metadata socket that is successfully connected. */
+	ret = lttng_poll_add(&events, consumer_data->metadata_sock.fd,
+			LPOLLIN | LPOLLRDHUP);
+	if (ret < 0) {
+		goto error;
+	}
+
 	health_code_update();
 
-	/* Inifinite blocking call, waiting for transmission */
+	/* Infinite blocking call, waiting for transmission */
 restart_poll:
-	health_poll_entry();
-	ret = lttng_poll_wait(&events, -1);
-	health_poll_exit();
-	if (ret < 0) {
-		/*
-		 * Restart interrupted system call.
-		 */
-		if (errno == EINTR) {
-			goto restart_poll;
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
 		}
-		goto error;
-	}
 
-	nb_fd = ret;
+		nb_fd = ret;
 
-	for (i = 0; i < nb_fd; i++) {
-		/* Fetch once the poll data */
-		revents = LTTNG_POLL_GETEV(&events, i);
-		pollfd = LTTNG_POLL_GETFD(&events, i);
+		for (i = 0; i < nb_fd; i++) {
+			/* Fetch once the poll data */
+			revents = LTTNG_POLL_GETEV(&events, i);
+			pollfd = LTTNG_POLL_GETFD(&events, i);
 
-		health_code_update();
+			health_code_update();
 
-		/* Thread quit pipe has been closed. Killing thread. */
-		ret = sessiond_check_thread_quit_pipe(pollfd, revents);
-		if (ret) {
-			err = 0;
-			goto exit;
-		}
+			/* Thread quit pipe has been closed. Killing thread. */
+			ret = sessiond_check_thread_quit_pipe(pollfd, revents);
+			if (ret) {
+				err = 0;
+				goto exit;
+			}
 
-		/* Event on the kconsumerd socket */
-		if (pollfd == sock) {
-			if (revents & (LPOLLERR | LPOLLHUP | LPOLLRDHUP)) {
-				ERR("consumer err socket second poll error");
+			if (pollfd == sock) {
+				/* Event on the consumerd socket */
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
+
+				ERR("consumer return code : %s",
+						lttcomm_get_readable_code(-code));
+
+				goto exit;
+			} else if (pollfd == consumer_data->metadata_sock.fd) {
+				/* UST metadata requests */
+				ret = ust_consumer_metadata_request(
+						&consumer_data->metadata_sock);
+				if (ret < 0) {
+					ERR("Handling metadata request");
+					goto error;
+				}
+				break;
+			} else {
+				ERR("Unknown pollfd");
 				goto error;
 			}
 		}
+		health_code_update();
 	}
 
-	health_code_update();
-
-	/* Wait for any kconsumerd error */
-	ret = lttcomm_recv_unix_sock(sock, &code,
-			sizeof(enum lttcomm_return_code));
-	if (ret <= 0) {
-		ERR("consumer closed the command socket");
-		goto error;
-	}
-
-	ERR("consumer return code : %s", lttcomm_get_readable_code(-code));
-
 exit:
 error:
 	/* Immediately set the consumerd state to stopped */
@@ -1061,6 +1104,12 @@ error:
 			PERROR("close");
 		}
 	}
+	if (consumer_data->metadata_sock.fd >= 0) {
+		ret = close(consumer_data->metadata_sock.fd);
+		if (ret) {
+			PERROR("close");
+		}
+	}
 	if (sock >= 0) {
 		ret = close(sock);
 		if (ret) {
@@ -2011,7 +2060,7 @@ end:
 	return 0;
 
 error:
-	/* Cleanup already created socket on error. */
+	/* Cleanup already created sockets on error. */
 	if (consumer_data->err_sock >= 0) {
 		int err;
 
diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 979ae7c..2cb92e4 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -27,6 +27,7 @@
 #include <unistd.h>
 #include <urcu/compiler.h>
 #include <lttng/ust-error.h>
+#include <signal.h>
 
 #include <common/common.h>
 #include <common/sessiond-comm/sessiond-comm.h>
@@ -368,17 +369,72 @@ void delete_ust_app_channel(int sock, struct ust_app_channel *ua_chan,
 }
 
 /*
+ * Push metadata to consumer socket. The socket lock MUST be acquired.
+ *
+ * On success, return the len of metadata pushed or else a negative value.
+ */
+ssize_t ust_app_push_metadata(struct ust_registry_session *registry,
+		struct consumer_socket *socket)
+{
+	int ret;
+	char *metadata_str = NULL;
+	size_t len, offset;
+	ssize_t ret_val;
+
+	assert(registry);
+	assert(socket);
+
+	pthread_mutex_lock(&registry->lock);
+
+	offset = registry->metadata_len_sent;
+	len = registry->metadata_len - registry->metadata_len_sent;
+	if (len == 0) {
+		DBG3("No metadata to push for metadata key %" PRIu64,
+				registry->metadata_key);
+		goto end;
+	}
+
+	/* Allocate only what we have to send. */
+	metadata_str = zmalloc(len);
+	if (!metadata_str) {
+		PERROR("zmalloc ust app metadata string");
+		ret_val = -ENOMEM;
+		goto error;
+	}
+	/* Copy what we haven't send out. */
+	memcpy(metadata_str, registry->metadata + offset, len);
+
+	ret = consumer_push_metadata(socket, registry->metadata_key,
+			metadata_str, len, offset);
+	if (ret < 0) {
+		ret_val = ret;
+		goto error;
+	}
+
+	registry->metadata_len_sent += len;
+
+end:
+	ret_val = len;
+error:
+	free(metadata_str);
+	pthread_mutex_unlock(&registry->lock);
+	return ret_val;
+}
+
+/*
  * For a given application and session, push metadata to consumer. The session
  * lock MUST be acquired here before calling this.
+ * Either sock or consumer is required : if sock is NULL, the default
+ * socket to send the metadata is retrieved from consumer, if sock
+ * is not NULL we use it to send the metadata.
  *
  * Return 0 on success else a negative error.
  */
 static int push_metadata(struct ust_registry_session *registry,
 		struct consumer_output *consumer)
 {
-	int ret;
-	char *metadata_str = NULL;
-	size_t len, offset;
+	int ret_val;
+	ssize_t ret;
 	struct consumer_socket *socket;
 
 	assert(registry);
@@ -391,7 +447,7 @@ static int push_metadata(struct ust_registry_session *registry,
 	 * no start has been done previously.
 	 */
 	if (!registry->metadata_key) {
-		ret = 0;
+		ret_val = 0;
 		goto error_rcu_unlock;
 	}
 
@@ -399,7 +455,7 @@ static int push_metadata(struct ust_registry_session *registry,
 	socket = consumer_find_socket_by_bitness(registry->bits_per_long,
 			consumer);
 	if (!socket) {
-		ret = -1;
+		ret_val = -1;
 		goto error_rcu_unlock;
 	}
 
@@ -414,54 +470,19 @@ static int push_metadata(struct ust_registry_session *registry,
 	 * ability to reorder the metadata it receives.
 	 */
 	pthread_mutex_lock(socket->lock);
-	pthread_mutex_lock(&registry->lock);
-
-	offset = registry->metadata_len_sent;
-	len = registry->metadata_len - registry->metadata_len_sent;
-	if (len == 0) {
-		DBG3("No metadata to push for metadata key %" PRIu64,
-				registry->metadata_key);
-		ret = 0;
-		goto error_reg_unlock;
-	}
-	assert(len > 0);
-
-	/* Allocate only what we have to send. */
-	metadata_str = zmalloc(len);
-	if (!metadata_str) {
-		PERROR("zmalloc ust app metadata string");
-		ret = -ENOMEM;
-		goto error_reg_unlock;
-	}
-	/* Copy what we haven't send out. */
-	memcpy(metadata_str, registry->metadata + offset, len);
-
-	pthread_mutex_unlock(&registry->lock);
-
-	ret = consumer_push_metadata(socket, registry->metadata_key,
-			metadata_str, len, offset);
+	ret = ust_app_push_metadata(registry, socket);
+	pthread_mutex_unlock(socket->lock);
 	if (ret < 0) {
-		pthread_mutex_unlock(socket->lock);
+		ret_val = ret;
 		goto error_rcu_unlock;
 	}
 
-	/* Update len sent of the registry. */
-	pthread_mutex_lock(&registry->lock);
-	registry->metadata_len_sent += len;
-	pthread_mutex_unlock(&registry->lock);
-	pthread_mutex_unlock(socket->lock);
-
 	rcu_read_unlock();
-	free(metadata_str);
 	return 0;
 
-error_reg_unlock:
-	pthread_mutex_unlock(&registry->lock);
-	pthread_mutex_unlock(socket->lock);
 error_rcu_unlock:
 	rcu_read_unlock();
-	free(metadata_str);
-	return ret;
+	return ret_val;
 }
 
 /*
diff --git a/src/bin/lttng-sessiond/ust-app.h b/src/bin/lttng-sessiond/ust-app.h
index 67088a7..776dc0e 100644
--- a/src/bin/lttng-sessiond/ust-app.h
+++ b/src/bin/lttng-sessiond/ust-app.h
@@ -299,6 +299,8 @@ int ust_app_recv_notify(int sock);
 void ust_app_add(struct ust_app *app);
 struct ust_app *ust_app_create(struct ust_register_msg *msg, int sock);
 void ust_app_notify_sock_unregister(int sock);
+ssize_t ust_app_push_metadata(struct ust_registry_session *registry,
+		struct consumer_socket *socket);
 
 #else /* HAVE_LIBLTTNG_UST_CTL */
 
@@ -485,6 +487,12 @@ static inline
 void ust_app_notify_sock_unregister(int sock)
 {
 }
+static inline
+ssize_t ust_app_push_metadata(struct ust_registry_session *registry,
+		struct consumer_socket *socket)
+{
+	return 0;
+}
 
 #endif /* HAVE_LIBLTTNG_UST_CTL */
 
diff --git a/src/bin/lttng-sessiond/ust-consumer.c b/src/bin/lttng-sessiond/ust-consumer.c
index ba74112..2b6f813 100644
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
@@ -405,3 +407,78 @@ int ust_consumer_send_channel_to_ust(struct ust_app *app,
 error:
 	return ret;
 }
+
+/*
+ * Handle the metadata requests from the UST consumer
+ *
+ * Return 0 on success else a negative value.
+ */
+int ust_consumer_metadata_request(struct consumer_socket *socket)
+{
+	int ret;
+	ssize_t ret_push;
+	struct lttcomm_metadata_request_msg request;
+	struct buffer_reg_uid *reg_uid;
+	struct ust_registry_session *ust_reg;
+	struct lttcomm_consumer_msg msg;
+	uint64_t len;
+
+	assert(socket);
+
+	rcu_read_lock();
+	pthread_mutex_lock(socket->lock);
+
+	health_code_update();
+
+	/* Wait for a metadata request */
+	ret = lttcomm_recv_unix_sock(socket->fd, &request, sizeof(request));
+	if (ret <= 0) {
+		ERR("Consumer closed the metadata socket");
+		ret = -1;
+		goto end;
+	}
+
+	DBG("Metadata request received for session %u, key %" PRIu64,
+			request.session_id, request.key);
+
+	reg_uid = buffer_reg_uid_find(request.session_id,
+			request.bits_per_long, request.uid);
+	if (reg_uid) {
+		ust_reg = reg_uid->registry->reg.ust;
+	} else {
+		struct buffer_reg_pid *reg_pid =
+			buffer_reg_pid_find(request.session_id);
+		if (!reg_pid) {
+			DBG("PID registry not found for session id %u",
+					request.session_id);
+
+			msg.cmd_type = LTTNG_ERR_UND;
+			(void) consumer_send_msg(socket, &msg);
+			ret = -1;
+			goto end;
+		}
+		ust_reg = reg_pid->registry->reg.ust;
+	}
+	assert(ust_reg);
+
+	len = ust_reg->metadata_len - ust_reg->metadata_len_sent;
+	if (len == 0) {
+		DBG("No metadata to push");
+		ret = consumer_push_metadata(socket, request.key, NULL, len, 0);
+		goto end;
+	}
+
+	ret_push = ust_app_push_metadata(ust_reg, socket);
+	if (ret_push < 0) {
+		ERR("Pushing metadata");
+		ret = -1;
+		goto end;
+	}
+	DBG("UST Consumer metadata pushed successfully");
+	ret = 0;
+
+end:
+	pthread_mutex_unlock(socket->lock);
+	rcu_read_unlock();
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
index c3a947a..f2ea40a 100644
--- a/src/common/Makefile.am
+++ b/src/common/Makefile.am
@@ -6,7 +6,8 @@ SUBDIRS = compat hashtable kernel-ctl sessiond-comm relayd \
 AM_CFLAGS = -fno-strict-aliasing
 
 noinst_HEADERS = lttng-kernel.h defaults.h macros.h error.h futex.h \
-				 uri.h utils.h lttng-kernel-old.h
+				 uri.h utils.h lttng-kernel-old.h \
+				 consumer-metadata-cache.h consumer-timer.h
 
 # Common library
 noinst_LTLIBRARIES = libcommon.la
@@ -18,7 +19,8 @@ libcommon_la_LIBADD = -luuid
 # Consumer library
 noinst_LTLIBRARIES += libconsumer.la
 
-libconsumer_la_SOURCES = consumer.c consumer.h
+libconsumer_la_SOURCES = consumer.c consumer.h consumer-metadata-cache.c \
+                         consumer-timer.c
 
 libconsumer_la_LIBADD = \
 		$(top_builddir)/src/common/sessiond-comm/libsessiond-comm.la \
diff --git a/src/common/consumer-metadata-cache.c b/src/common/consumer-metadata-cache.c
new file mode 100644
index 0000000..979521f
--- /dev/null
+++ b/src/common/consumer-metadata-cache.c
@@ -0,0 +1,214 @@
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
+/*
+ * Extend the allocated size of the metadata cache. Called only from
+ * lttng_ustconsumer_write_metadata_cache.
+ *
+ * Return 0 on success, a negative value on error.
+ */
+static int extend_metadata_cache(struct lttng_consumer_channel *channel,
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
+ * Write metadata to the cache, extend the cache if necessary. We support
+ * non-contiguous updates but not overlapping ones. If there is contiguous
+ * metadata in the cache, we send it to the ring buffer. The metadata cache
+ * lock MUST be acquired to write in the cache.
+ *
+ * Return 0 on success, a negative value on error.
+ */
+int consumer_metadata_cache_write(struct lttng_consumer_channel *channel,
+		unsigned int offset, unsigned int len, char *data)
+{
+	int ret = 0;
+	struct consumer_metadata_cache *cache;
+
+	assert(channel);
+	assert(channel->metadata_cache);
+
+	cache = channel->metadata_cache;
+	DBG("Writing %u bytes from offset %u in metadata cache",
+			len, offset);
+
+	if (offset + len > cache->cache_alloc_size) {
+		ret = extend_metadata_cache(channel,
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
+		ret = lttng_ustconsumer_push_metadata(channel, cache->data, offset,
+				len);
+		if (ret < 0) {
+			ERR("Pushing metadata");
+			goto end;
+		}
+		cache->rb_pushed += len;
+	}
+
+end:
+	return ret;
+}
+
+/*
+ * Create the metadata cache, original allocated size: max_sb_size
+ *
+ * Return 0 on success, a negative value on error.
+ */
+int consumer_metadata_cache_allocate(struct lttng_consumer_channel *channel)
+{
+	int ret;
+
+	assert(channel);
+
+	channel->metadata_cache = zmalloc(
+			sizeof(struct consumer_metadata_cache));
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
+	channel->metadata_cache->cache_alloc_size = DEFAULT_METADATA_CACHE_SIZE;
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
+void consumer_metadata_cache_destroy(struct lttng_consumer_channel *channel)
+{
+	if (!channel || !channel->metadata_cache) {
+		return;
+	}
+
+	DBG("Destroying metadata cache");
+
+	if (channel->metadata_cache->max_offset >
+			channel->metadata_cache->rb_pushed) {
+		ERR("Destroying a cache not entirely commited");
+	}
+
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
+int consumer_metadata_cache_flushed(struct lttng_consumer_channel *channel,
+		uint64_t offset)
+{
+	int ret;
+	struct consumer_metadata_cache *cache;
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
index 0000000..1d76b50
--- /dev/null
+++ b/src/common/consumer-metadata-cache.h
@@ -0,0 +1,58 @@
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
+#ifndef CONSUMER_METADATA_CACHE_H
+#define CONSUMER_METADATA_CACHE_H
+
+#include <common/consumer.h>
+
+struct consumer_metadata_cache {
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
+int consumer_metadata_cache_write(struct lttng_consumer_channel *channel,
+		unsigned int offset, unsigned int len, char *data);
+int consumer_metadata_cache_allocate(struct lttng_consumer_channel *channel);
+void consumer_metadata_cache_destroy(struct lttng_consumer_channel *channel);
+int consumer_metadata_cache_flushed(struct lttng_consumer_channel *channel,
+		uint64_t offset);
+
+#endif /* CONSUMER_METADATA_CACHE_H */
diff --git a/src/common/consumer-timer.c b/src/common/consumer-timer.c
new file mode 100644
index 0000000..80087fd
--- /dev/null
+++ b/src/common/consumer-timer.c
@@ -0,0 +1,216 @@
+/*
+ * Copyright (C) 2012 - Julien Desfossez <julien.desfossez@efficios.com>
+ *                      David Goulet <dgoulet@efficios.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License, version 2 only, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc., 51
+ * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#define _GNU_SOURCE
+#include <assert.h>
+#include <inttypes.h>
+#include <signal.h>
+
+#include <common/common.h>
+
+#include "consumer-timer.h"
+#include "ust-consumer/ust-consumer.h"
+
+static struct timer_signal_data timer_signal;
+
+/*
+ * Set custom signal mask to current thread.
+ */
+static void setmask(sigset_t *mask)
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
+ * Execute action on a timer switch.
+ */
+static void metadata_switch_timer(struct lttng_consumer_local_data *ctx,
+		int sig, siginfo_t *si, void *uc)
+{
+	struct lttng_consumer_channel *channel;
+
+	channel = si->si_value.sival_ptr;
+	assert(channel);
+
+	DBG("Switch timer for channel %" PRIu64, channel->key);
+	switch (ctx->type) {
+	case LTTNG_CONSUMER32_UST:
+	case LTTNG_CONSUMER64_UST:
+		(void) lttng_ustconsumer_request_metadata(ctx, channel);
+		break;
+	case LTTNG_CONSUMER_KERNEL:
+	case LTTNG_CONSUMER_UNKNOWN:
+		assert(0);
+		break;
+	}
+}
+
+/*
+ * Set the timer for periodical metadata flush.
+ */
+void consumer_timer_switch_start(struct lttng_consumer_channel *channel,
+		unsigned int switch_timer_interval)
+{
+	int ret;
+	struct sigevent sev;
+	struct itimerspec its;
+
+	if (switch_timer_interval == 0) {
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
+	its.it_value.tv_sec = switch_timer_interval / 1000000;
+	its.it_value.tv_nsec = switch_timer_interval % 1000000;
+	its.it_interval.tv_sec = its.it_value.tv_sec;
+	its.it_interval.tv_nsec = its.it_value.tv_nsec;
+
+	ret = timer_settime(channel->switch_timer, 0, &its, NULL);
+	if (ret == -1) {
+		PERROR("timer_settime");
+	}
+}
+
+/*
+ * Stop and delete timer.
+ */
+void consumer_timer_switch_stop(struct lttng_consumer_channel *channel)
+{
+	int ret;
+	sigset_t pending_set;
+
+	assert(channel);
+
+	ret = timer_delete(channel->switch_timer);
+	if (ret == -1) {
+		PERROR("timer_delete");
+	}
+
+	/* Ensure we don't have any signal queued for this channel. */
+	for (;;) {
+		ret = sigemptyset(&pending_set);
+		if (ret == -1) {
+			PERROR("sigemptyset");
+		}
+		ret = sigpending(&pending_set);
+		if (ret == -1) {
+			PERROR("sigpending");
+		}
+		if (!sigismember(&pending_set, LTTNG_CONSUMER_SIG_SWITCH)) {
+			break;
+		}
+		caa_cpu_relax();
+	}
+
+	/*
+	 * From this point, no new signal handler will be fired that would try to
+	 * access "chan". However, we still need to wait for any currently
+	 * executing handler to complete.
+	 */
+	cmm_smp_mb();
+	CMM_STORE_SHARED(timer_signal.qs_done, 0);
+	cmm_smp_mb();
+
+	/*
+	 * Kill with LTTNG_CONSUMER_SIG_TEARDOWN, so signal management thread wakes
+	 * up.
+	 */
+	kill(getpid(), LTTNG_CONSUMER_SIG_TEARDOWN);
+
+	while (!CMM_LOAD_SHARED(timer_signal.qs_done)) {
+		caa_cpu_relax();
+	}
+	cmm_smp_mb();
+}
+
+/*
+ * Block the RT signals for the entire process. It must be called from the
+ * consumer main before creating the threads
+ */
+void consumer_signal_init(void)
+{
+	int ret;
+	sigset_t mask;
+
+	/* Block signal for entire process, so only our thread processes it. */
+	setmask(&mask);
+	ret = pthread_sigmask(SIG_BLOCK, &mask, NULL);
+	if (ret) {
+		errno = ret;
+		PERROR("pthread_sigmask");
+	}
+}
+
+/*
+ * This thread is the sighandler for signals LTTNG_CONSUMER_SIG_SWITCH and
+ * LTTNG_CONSUMER_SIG_TEARDOWN that are emitted by the periodic timer to check
+ * if new metadata is available.
+ */
+void *consumer_timer_metadata_thread(void *data)
+{
+	int signr;
+	sigset_t mask;
+	siginfo_t info;
+	struct lttng_consumer_local_data *ctx = data;
+
+	/* Only self thread will receive signal mask. */
+	setmask(&mask);
+	CMM_STORE_SHARED(timer_signal.tid, pthread_self());
+
+	while (1) {
+		signr = sigwaitinfo(&mask, &info);
+		if (signr == -1) {
+			if (errno != EINTR) {
+				PERROR("sigwaitinfo");
+			}
+			continue;
+		} else if (signr == LTTNG_CONSUMER_SIG_SWITCH) {
+			metadata_switch_timer(ctx, info.si_signo, &info, NULL);
+		} else if (signr == LTTNG_CONSUMER_SIG_TEARDOWN) {
+			cmm_smp_mb();
+			CMM_STORE_SHARED(timer_signal.qs_done, 1);
+			cmm_smp_mb();
+			DBG("Signal timer metadata thread teardown");
+		} else {
+			ERR("Unexpected signal %d\n", info.si_signo);
+		}
+	}
+
+	return NULL;
+}
diff --git a/src/common/consumer-timer.h b/src/common/consumer-timer.h
new file mode 100644
index 0000000..8406158
--- /dev/null
+++ b/src/common/consumer-timer.h
@@ -0,0 +1,49 @@
+/*
+ * Copyright (C) 2011 - Julien Desfossez <julien.desfossez@polymtl.ca>
+ *                      Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *               2012 - David Goulet <dgoulet@efficios.com>
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
+#ifndef CONSUMER_TIMER_H
+#define CONSUMER_TIMER_H
+
+#include <pthread.h>
+
+#include "consumer.h"
+
+#define LTTNG_CONSUMER_SIG_SWITCH	SIGRTMIN + 10
+#define LTTNG_CONSUMER_SIG_TEARDOWN	SIGRTMIN + 11
+
+#define CLOCKID CLOCK_MONOTONIC
+
+/*
+ * Handle timer teardown race wrt memory free of private data by consumer
+ * signals are handled by a single thread, which permits a synchronization
+ * point between handling of each signal.
+ */
+struct timer_signal_data {
+	pthread_t tid;	/* thread id managing signals */
+	int setup_done;
+	int qs_done;
+};
+
+void consumer_timer_switch_start(struct lttng_consumer_channel *channel,
+		unsigned int switch_timer_interval);
+void consumer_timer_switch_stop(struct lttng_consumer_channel *channel);
+void *consumer_timer_metadata_thread(void *data);
+void consumer_signal_init(void);
+
+#endif /* CONSUMER_TIMER_H */
diff --git a/src/common/consumer.c b/src/common/consumer.c
index 29bd0c0..5f87f4b 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -28,6 +28,7 @@
 #include <sys/types.h>
 #include <unistd.h>
 #include <inttypes.h>
+#include <signal.h>
 
 #include <common/common.h>
 #include <common/utils.h>
@@ -1141,6 +1142,7 @@ struct lttng_consumer_local_data *lttng_consumer_create(
 	}
 
 	ctx->consumer_error_socket = -1;
+	ctx->consumer_metadata_socket = -1;
 	/* assign the callbacks */
 	ctx->on_buffer_ready = buffer_ready;
 	ctx->on_recv_channel = recv_channel;
@@ -1227,6 +1229,10 @@ void lttng_consumer_destroy(struct lttng_consumer_local_data *ctx)
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
@@ -1328,6 +1334,7 @@ ssize_t lttng_consumer_on_read_subbuffer_mmap(
 			goto end;
 		}
 		ret = lttng_ustctl_get_mmap_read_offset(stream, &mmap_offset);
+
 		break;
 	default:
 		ERR("Unknown consumer_data type");
@@ -2707,6 +2714,33 @@ end_ht:
 	return NULL;
 }
 
+static int set_metadata_socket(struct lttng_consumer_local_data *ctx,
+		struct pollfd *sockpoll, int client_socket)
+{
+	int ret;
+
+	assert(ctx);
+	assert(sockpoll);
+
+	if (lttng_consumer_poll_socket(sockpoll) < 0) {
+		ret = -1;
+		goto error;
+	}
+	DBG("Metadata connection on client_socket");
+
+	/* Blocking call, waiting for transmission */
+	ctx->consumer_metadata_socket = lttcomm_accept_unix_sock(client_socket);
+	if (ctx->consumer_metadata_socket < 0) {
+		WARN("On accept metadata");
+		ret = -1;
+		goto error;
+	}
+	ret = 0;
+
+error:
+	return ret;
+}
+
 /*
  * This thread listens on the consumerd socket and receives the file
  * descriptors from the session daemon.
@@ -2773,6 +2807,15 @@ void *consumer_thread_sessiond_poll(void *data)
 		goto end;
 	}
 
+	/*
+	 * Setup metadata socket which is the second socket connection on the
+	 * command unix socket.
+	 */
+	ret = set_metadata_socket(ctx, consumer_sockpoll, client_socket);
+	if (ret < 0) {
+		goto end;
+	}
+
 	/* This socket is not useful anymore. */
 	ret = close(client_socket);
 	if (ret < 0) {
diff --git a/src/common/consumer.h b/src/common/consumer.h
index 82b9bc6..4638752 100644
--- a/src/common/consumer.h
+++ b/src/common/consumer.h
@@ -89,6 +89,9 @@ struct stream_list {
 	unsigned int count;
 };
 
+/* Stub. */
+struct consumer_metadata_cache;
+
 struct lttng_consumer_channel {
 	/* HT node used for consumer_data.channel_ht */
 	struct lttng_ht_node_u64 node;
@@ -132,16 +135,17 @@ struct lttng_consumer_channel {
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
+	struct consumer_metadata_cache *metadata_cache;
+	/* For metadata periodical flush */
+	int switch_timer_enabled;
+	timer_t switch_timer;
 };
 
 /*
@@ -322,8 +326,11 @@ struct lttng_consumer_local_data {
 	 *    < 0 (error)
 	 */
 	int (*on_update_stream)(int sessiond_key, uint32_t state);
+	enum lttng_consumer_type type;
 	/* socket to communicate errors with sessiond */
 	int consumer_error_socket;
+	/* socket to ask metadata to sessiond */
+	int consumer_metadata_socket;
 	/* socket to exchange commands with sessiond */
 	char *consumer_command_sock_path;
 	/* communication with splice */
diff --git a/src/common/defaults.h b/src/common/defaults.h
index 658e7d3..94a2a35 100644
--- a/src/common/defaults.h
+++ b/src/common/defaults.h
@@ -76,7 +76,6 @@
 #define DEFAULT_USTCONSUMERD32_CMD_SOCK_PATH    DEFAULT_USTCONSUMERD32_PATH "/command"
 #define DEFAULT_USTCONSUMERD32_ERR_SOCK_PATH    DEFAULT_USTCONSUMERD32_PATH "/error"
 
-
 /* Default lttng run directory */
 #define DEFAULT_LTTNG_RUNDIR                    "/var/run/lttng"
 #define DEFAULT_LTTNG_HOME_RUNDIR               "%s/.lttng"
@@ -124,6 +123,7 @@
 
 #define DEFAULT_METADATA_SUBBUF_SIZE    4096
 #define DEFAULT_METADATA_SUBBUF_NUM     2
+#define DEFAULT_METADATA_CACHE_SIZE     4096
 
 /* Kernel has different defaults */
 
@@ -179,6 +179,12 @@
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
diff --git a/src/common/macros.h b/src/common/macros.h
index f6f975d..fc159c0 100644
--- a/src/common/macros.h
+++ b/src/common/macros.h
@@ -56,6 +56,10 @@
 #define max(a, b) ((a) > (b) ? (a) : (b))
 #endif
 
+#ifndef max_t
+#define max_t(type, a, b)	((type) max(a, b))
+#endif
+
 #ifndef min
 #define min(a, b) ((a) < (b) ? (a) : (b))
 #endif
diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
index 6350fd1..cb5a88b 100644
--- a/src/common/sessiond-comm/sessiond-comm.h
+++ b/src/common/sessiond-comm/sessiond-comm.h
@@ -138,6 +138,21 @@ enum lttcomm_sock_domain {
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
+struct lttcomm_metadata_request_msg {
+	unsigned int session_id; /* Tracing session id */
+	uint32_t bits_per_long; /* Consumer ABI */
+	uint32_t uid;
+	uint64_t key; /* Metadata channel key. */
+} LTTNG_PACKED;
+
 struct lttcomm_sockaddr {
 	enum lttcomm_sock_domain type;
 	union {
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index 06b59c5..e56f023 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -30,11 +30,14 @@
 #include <inttypes.h>
 #include <unistd.h>
 #include <urcu/list.h>
+#include <signal.h>
 
 #include <common/common.h>
 #include <common/sessiond-comm/sessiond-comm.h>
 #include <common/relayd/relayd.h>
 #include <common/compat/fcntl.h>
+#include <common/consumer-metadata-cache.h>
+#include <common/consumer-timer.h>
 
 #include "ust-consumer.h"
 
@@ -530,10 +533,12 @@ error:
 /*
  * Write metadata to the given channel using ustctl to convert the string to
  * the ringbuffer.
+ * Called only from consumer_metadata_cache_write.
+ * The metadata cache lock MUST be acquired to write in the cache.
  *
  * Return 0 on success else a negative value.
  */
-static int push_metadata(struct lttng_consumer_channel *metadata,
+int lttng_ustconsumer_push_metadata(struct lttng_consumer_channel *metadata,
 		const char *metadata_str, uint64_t target_offset, uint64_t len)
 {
 	int ret;
@@ -543,13 +548,13 @@ static int push_metadata(struct lttng_consumer_channel *metadata,
 
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
 
@@ -619,6 +624,11 @@ static int close_metadata(uint64_t chan_key)
 		ret = LTTCOMM_CONSUMERD_ERROR_METADATA;
 		goto error;
 	}
+	if (channel->switch_timer_enabled == 1) {
+		DBG("Deleting timer on metadata channel");
+		consumer_timer_switch_stop(channel);
+	}
+	consumer_metadata_cache_destroy(channel);
 
 error:
 	return ret;
@@ -679,6 +689,51 @@ error:
 }
 
 /*
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
+	ret = consumer_metadata_cache_write(channel, offset, len, metadata_str);
+	if (ret < 0) {
+		/* Unable to handle metadata. Notify session daemon. */
+		ret_code = LTTCOMM_CONSUMERD_ERROR_METADATA;
+	}
+	pthread_mutex_unlock(&channel->metadata_cache->lock);
+
+	while (consumer_metadata_cache_flushed(channel, offset + len)) {
+		DBG("Waiting for metadata to be flushed");
+		usleep(DEFAULT_METADATA_AVAILABILITY_WAIT_TIME);
+	}
+
+end_free:
+	free(metadata_str);
+end:
+	return ret_code;
+}
+
+/*
  * Receive command from session daemon and process it.
  *
  * Return 1 on success else a negative value or 0.
@@ -847,6 +902,7 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 			goto end_channel_error;
 		}
 
+
 		/*
 		 * Channel and streams are now created. Inform the session daemon that
 		 * everything went well and should wait to receive the channel and
@@ -861,6 +917,16 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 			goto end_nosignal;
 		}
 
+		if (msg.u.ask_channel.type == LTTNG_UST_CHAN_METADATA) {
+			ret = consumer_metadata_cache_allocate(channel);
+			if (ret < 0) {
+				ERR("Allocating metadata cache");
+				goto end_channel_error;
+			}
+			consumer_timer_switch_start(channel, attr.switch_timer_interval);
+			attr.switch_timer_interval = 0;
+		}
+
 		break;
 	}
 	case LTTNG_CONSUMER_GET_CHANNEL:
@@ -957,10 +1023,9 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 	{
 		int ret;
 		uint64_t len = msg.u.push_metadata.len;
-		uint64_t target_offset = msg.u.push_metadata.target_offset;
 		uint64_t key = msg.u.push_metadata.key;
+		uint64_t offset = msg.u.push_metadata.target_offset;
 		struct lttng_consumer_channel *channel;
-		char *metadata_str;
 
 		DBG("UST consumer push metadata key %lu of len %lu", key, len);
 
@@ -968,14 +1033,6 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
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
@@ -990,22 +1047,15 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
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
@@ -1223,6 +1273,7 @@ int lttng_ustconsumer_read_subbuffer(struct lttng_consumer_stream *stream,
 	}
 	err = ustctl_put_next_subbuf(ustream);
 	assert(err == 0);
+
 end:
 	return ret;
 }
@@ -1343,3 +1394,96 @@ void lttng_ustconsumer_close_stream_wakeup(struct lttng_consumer_stream *stream)
 		ERR("Unable to close wakeup fd");
 	}
 }
+
+int lttng_ustconsumer_request_metadata(struct lttng_consumer_local_data *ctx,
+		struct lttng_consumer_channel *channel)
+{
+	struct lttcomm_metadata_request_msg request;
+	struct lttcomm_consumer_msg msg;
+	enum lttng_error_code ret_code = LTTNG_OK;
+	uint64_t len, key, offset;
+	int ret;
+
+	assert(channel);
+	assert(channel->metadata_cache);
+
+	/* send the metadata request to sessiond */
+	switch (consumer_data.type) {
+	case LTTNG_CONSUMER64_UST:
+		request.bits_per_long = 64;
+		break;
+	case LTTNG_CONSUMER32_UST:
+		request.bits_per_long = 32;
+		break;
+	default:
+		request.bits_per_long = 0;
+		break;
+	}
+
+	request.session_id = channel->session_id;
+	request.uid = channel->uid;
+	request.key = channel->key;
+	DBG("Sending metadata request to sessiond, session %" PRIu64,
+			channel->session_id);
+
+	ret = lttcomm_send_unix_sock(ctx->consumer_metadata_socket, &request,
+			sizeof(request));
+	if (ret < 0) {
+		ERR("Asking metadata to sessiond");
+		goto end;
+	}
+
+	/* Receive the metadata from sessiond */
+	ret = lttcomm_recv_unix_sock(ctx->consumer_metadata_socket, &msg,
+			sizeof(msg));
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
+
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
+		DBG("No new metadata to receive for key %" PRIu64, key);
+	}
+
+	/* Tell session daemon we are ready to receive the metadata. */
+	ret = consumer_send_status_msg(ctx->consumer_metadata_socket,
+			LTTNG_OK);
+	if (ret < 0 || len == 0) {
+		/*
+		 * Somehow, the session daemon is not responding anymore or there is
+		 * nothing to receive.
+		 */
+		goto end;
+	}
+
+	ret_code = lttng_ustconsumer_recv_metadata(ctx->consumer_metadata_socket,
+			key, offset, len, channel);
+	(void) consumer_send_status_msg(ctx->consumer_metadata_socket, ret_code);
+	ret = 0;
+
+end:
+	return ret;
+}
diff --git a/src/common/ust-consumer/ust-consumer.h b/src/common/ust-consumer/ust-consumer.h
index bbaff6c..d748582 100644
--- a/src/common/ust-consumer/ust-consumer.h
+++ b/src/common/ust-consumer/ust-consumer.h
@@ -51,6 +51,12 @@ void *lttng_ustctl_get_mmap_base(struct lttng_consumer_stream *stream);
 int lttng_ustconsumer_data_pending(struct lttng_consumer_stream *stream);
 void lttng_ustconsumer_close_metadata(struct lttng_ht *ht);
 void lttng_ustconsumer_close_stream_wakeup(struct lttng_consumer_stream *stream);
+int lttng_ustconsumer_recv_metadata(int sock, uint64_t key, uint64_t offset,
+		uint64_t len, struct lttng_consumer_channel *channel);
+int lttng_ustconsumer_push_metadata(struct lttng_consumer_channel *metadata,
+		const char *metadata_str, uint64_t target_offset, uint64_t len);
+int lttng_ustconsumer_request_metadata(struct lttng_consumer_local_data *ctx,
+		struct lttng_consumer_channel *channel);
 
 #else /* HAVE_LIBLTTNG_UST_CTL */
 
diff --git a/tests/unit/Makefile.am b/tests/unit/Makefile.am
index a9d65ab..169ca2e 100644
--- a/tests/unit/Makefile.am
+++ b/tests/unit/Makefile.am
@@ -47,8 +47,9 @@ UST_DATA_TRACE=$(top_srcdir)/src/bin/lttng-sessiond/trace-ust.c \
 		   $(top_srcdir)/src/bin/lttng-sessiond/ust-consumer.c \
 		   $(top_srcdir)/src/bin/lttng-sessiond/fd-limit.c \
 		   $(top_srcdir)/src/bin/lttng-sessiond/health.c \
-	       $(top_srcdir)/src/common/uri.c \
-	       $(top_srcdir)/src/common/utils.c
+		   $(top_srcdir)/src/bin/lttng-sessiond/session.c \
+		   $(top_srcdir)/src/common/uri.c \
+		   $(top_srcdir)/src/common/utils.c
 
 test_ust_data_SOURCES = test_ust_data.c $(UST_DATA_TRACE)
 test_ust_data_LDADD = $(LIBTAP) $(LIBCOMMON) $(LIBSESSIOND_COMM) $(LIBHASHTABLE) \
-- 
1.7.10.4
