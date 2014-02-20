From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [lttng-tools PATCH 2/2] Fix: miscellaneous memory
	handling fixes
Date: Thu, 20 Feb 2014 10:23:46 -0500
Message-ID: <1392909826-4726-2-git-send-email-mathieu.desnoyers__46429.8646468253$1392910026$gmane$org@efficios.com>
References: <1392909826-4726-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mathieu.desnoyers@efficios.com>) id 1WGVTo-0003kg-JI
	for lttng-dev@lists.lttng.org; Thu, 20 Feb 2014 10:24:12 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id F2330340222
	for <lttng-dev@lists.lttng.org>; Thu, 20 Feb 2014 15:24:04 +0000 (UTC)
In-Reply-To: <1392909826-4726-1-git-send-email-mathieu.desnoyers@efficios.com>
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

Issues found with Valgrind:

- Uninitialized memory sent through sendmsg,
- Uninitialized realloc memory,
- Erroneous pointer arithmetic in jul_list_events(),
- Memory leaks in kernel_consumer_add_channel(),
  kernel_consumer_add_metadata(),
- Memory leak (snapshot_destroy missing hash table cleanup),
- Uninitialized poll/epoll memory on realloc.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-consumerd/health-consumerd.c |    2 +-
 src/bin/lttng-relayd/health-relayd.c       |    2 +-
 src/bin/lttng-relayd/live.c                |    8 +++++
 src/bin/lttng-relayd/main.c                |   11 +++++++
 src/bin/lttng-sessiond/consumer.c          |   12 ++++++--
 src/bin/lttng-sessiond/jul.c               |   31 +++++++++++++-------
 src/bin/lttng-sessiond/kernel-consumer.c   |    8 +++--
 src/bin/lttng-sessiond/kernel.c            |   18 +++++++-----
 src/bin/lttng-sessiond/main.c              |    2 +-
 src/bin/lttng-sessiond/snapshot.c          |    2 ++
 src/bin/lttng-sessiond/ust-app.c           |   44 ++++++++++++++++++----------
 src/bin/lttng-sessiond/ust-consumer.c      |    3 ++
 src/common/compat/compat-epoll.c           |   10 +++++++
 src/common/compat/compat-poll.c            |    5 ++++
 src/common/consumer-metadata-cache.c       |    9 +++---
 src/common/consumer.c                      |    2 ++
 src/common/relayd/relayd.c                 |   10 +++++++
 src/common/ust-consumer/ust-consumer.c     |    2 ++
 src/lib/lttng-ctl/lttng-ctl-health.c       |    1 +
 src/lib/lttng-ctl/lttng-ctl.c              |   12 ++++++++
 20 files changed, 148 insertions(+), 46 deletions(-)

diff --git a/src/bin/lttng-consumerd/health-consumerd.c b/src/bin/lttng-consumerd/health-consumerd.c
index 1b649ba..d1478e5 100644
--- a/src/bin/lttng-consumerd/health-consumerd.c
+++ b/src/bin/lttng-consumerd/health-consumerd.c
@@ -303,7 +303,7 @@ restart:
 
 		assert(msg.cmd == HEALTH_CMD_CHECK);
 
-		reply.ret_code = 0;
+		memset(&reply, 0, sizeof(reply));
 		for (i = 0; i < NR_HEALTH_CONSUMERD_TYPES; i++) {
 			/*
 			 * health_check_state return 0 if thread is in
diff --git a/src/bin/lttng-relayd/health-relayd.c b/src/bin/lttng-relayd/health-relayd.c
index 89b6402..8a5cbdf 100644
--- a/src/bin/lttng-relayd/health-relayd.c
+++ b/src/bin/lttng-relayd/health-relayd.c
@@ -368,7 +368,7 @@ restart:
 
 		assert(msg.cmd == HEALTH_CMD_CHECK);
 
-		reply.ret_code = 0;
+		memset(&reply, 0, sizeof(reply));
 		for (i = 0; i < NR_HEALTH_RELAYD_TYPES; i++) {
 			/*
 			 * health_check_state return 0 if thread is in
diff --git a/src/bin/lttng-relayd/live.c b/src/bin/lttng-relayd/live.c
index a720ed7..c60f7e4 100644
--- a/src/bin/lttng-relayd/live.c
+++ b/src/bin/lttng-relayd/live.c
@@ -931,6 +931,8 @@ int viewer_get_new_streams(struct relay_connection *conn)
 
 	health_code_update();
 
+	memset(&response, 0, sizeof(response));
+
 	rcu_read_lock();
 	session = session_find_by_id(conn->sessions_ht, session_id);
 	if (!session) {
@@ -1032,6 +1034,8 @@ int viewer_attach_session(struct relay_connection *conn)
 
 	health_code_update();
 
+	memset(&response, 0, sizeof(response));
+
 	if (!conn->viewer_session) {
 		DBG("Client trying to attach before creating a live viewer session");
 		response.status = htobe32(LTTNG_VIEWER_ATTACH_NO_SESSION);
@@ -1618,6 +1622,8 @@ int viewer_get_metadata(struct relay_connection *conn)
 	}
 	health_code_update();
 
+	memset(&reply, 0, sizeof(reply));
+
 	rcu_read_lock();
 	stream = viewer_stream_find_by_id(be64toh(request.stream_id));
 	if (!stream || !stream->metadata_flag) {
@@ -1718,6 +1724,7 @@ int viewer_create_session(struct relay_connection *conn)
 
 	DBG("Viewer create session received");
 
+	memset(&resp, 0, sizeof(resp));
 	resp.status = htobe32(LTTNG_VIEWER_CREATE_SESSION_OK);
 	conn->viewer_session = zmalloc(sizeof(*conn->viewer_session));
 	if (!conn->viewer_session) {
@@ -1749,6 +1756,7 @@ void live_relay_unknown_command(struct relay_connection *conn)
 {
 	struct lttcomm_relayd_generic_reply reply;
 
+	memset(&reply, 0, sizeof(reply));
 	reply.ret_code = htobe32(LTTNG_ERR_UNK);
 	(void) send_response(conn->sock, &reply, sizeof(reply));
 }
diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
index f6b23eb..60b6bf2 100644
--- a/src/bin/lttng-relayd/main.c
+++ b/src/bin/lttng-relayd/main.c
@@ -1261,6 +1261,7 @@ int relay_add_stream(struct lttcomm_relayd_hdr *recv_hdr,
 			stream->stream_handle);
 
 end:
+	memset(&reply, 0, sizeof(reply));
 	reply.handle = htobe64(stream->stream_handle);
 	/* send the session id to the client or a negative return code on error */
 	if (ret < 0) {
@@ -1342,6 +1343,7 @@ int relay_close_stream(struct lttcomm_relayd_hdr *recv_hdr,
 end_unlock:
 	rcu_read_unlock();
 
+	memset(&reply, 0, sizeof(reply));
 	if (ret < 0) {
 		reply.ret_code = htobe32(LTTNG_ERR_UNK);
 	} else {
@@ -1367,6 +1369,7 @@ void relay_unknown_command(struct relay_connection *conn)
 	struct lttcomm_relayd_generic_reply reply;
 	int ret;
 
+	memset(&reply, 0, sizeof(reply));
 	reply.ret_code = htobe32(LTTNG_ERR_UNK);
 	ret = conn->sock->ops->sendmsg(conn->sock, &reply,
 			sizeof(struct lttcomm_relayd_generic_reply), 0);
@@ -1392,6 +1395,7 @@ int relay_start(struct lttcomm_relayd_hdr *recv_hdr,
 		ret = htobe32(LTTNG_ERR_UNK);
 	}
 
+	memset(&reply, 0, sizeof(reply));
 	reply.ret_code = ret;
 	ret = conn->sock->ops->sendmsg(conn->sock, &reply,
 			sizeof(struct lttcomm_relayd_generic_reply), 0);
@@ -1553,6 +1557,7 @@ int relay_send_version(struct lttcomm_relayd_hdr *recv_hdr,
 		goto end;
 	}
 
+	memset(&reply, 0, sizeof(reply));
 	reply.major = RELAYD_VERSION_COMM_MAJOR;
 	reply.minor = RELAYD_VERSION_COMM_MINOR;
 
@@ -1652,6 +1657,7 @@ int relay_data_pending(struct lttcomm_relayd_hdr *recv_hdr,
 end_unlock:
 	rcu_read_unlock();
 
+	memset(&reply, 0, sizeof(reply));
 	reply.ret_code = htobe32(ret);
 	ret = conn->sock->ops->sendmsg(conn->sock, &reply, sizeof(reply), 0);
 	if (ret < 0) {
@@ -1715,6 +1721,7 @@ int relay_quiescent_control(struct lttcomm_relayd_hdr *recv_hdr,
 	}
 	rcu_read_unlock();
 
+	memset(&reply, 0, sizeof(reply));
 	reply.ret_code = htobe32(LTTNG_OK);
 	ret = conn->sock->ops->sendmsg(conn->sock, &reply, sizeof(reply), 0);
 	if (ret < 0) {
@@ -1785,6 +1792,7 @@ int relay_begin_data_pending(struct lttcomm_relayd_hdr *recv_hdr,
 	}
 	rcu_read_unlock();
 
+	memset(&reply, 0, sizeof(reply));
 	/* All good, send back reply. */
 	reply.ret_code = htobe32(LTTNG_OK);
 
@@ -1858,6 +1866,7 @@ int relay_end_data_pending(struct lttcomm_relayd_hdr *recv_hdr,
 	}
 	rcu_read_unlock();
 
+	memset(&reply, 0, sizeof(reply));
 	/* All good, send back reply. */
 	reply.ret_code = htobe32(is_data_inflight);
 
@@ -1976,6 +1985,7 @@ int relay_recv_index(struct lttcomm_relayd_hdr *recv_hdr,
 end_rcu_unlock:
 	rcu_read_unlock();
 
+	memset(&reply, 0, sizeof(reply));
 	if (ret < 0) {
 		reply.ret_code = htobe32(LTTNG_ERR_UNK);
 	} else {
@@ -2026,6 +2036,7 @@ int relay_streams_sent(struct lttcomm_relayd_hdr *recv_hdr,
 		uatomic_set(&conn->session->new_streams, 1);
 	}
 
+	memset(&reply, 0, sizeof(reply));
 	reply.ret_code = htobe32(LTTNG_OK);
 	send_ret = conn->sock->ops->sendmsg(conn->sock, &reply, sizeof(reply), 0);
 	if (send_ret < 0) {
diff --git a/src/bin/lttng-sessiond/consumer.c b/src/bin/lttng-sessiond/consumer.c
index 8806e9c..ce3e5da 100644
--- a/src/bin/lttng-sessiond/consumer.c
+++ b/src/bin/lttng-sessiond/consumer.c
@@ -207,6 +207,7 @@ int consumer_send_destroy_relayd(struct consumer_socket *sock,
 
 	DBG2("Sending destroy relayd command to consumer sock %d", *sock->fd_ptr);
 
+	memset(&msg, 0, sizeof(msg));
 	msg.cmd_type = LTTNG_CONSUMER_DESTROY_RELAYD;
 	msg.u.destroy_relayd.net_seq_idx = consumer->net_seq_index;
 
@@ -965,6 +966,7 @@ int consumer_send_relayd_socket(struct consumer_socket *consumer_sock,
 	assert(consumer);
 	assert(consumer_sock);
 
+	memset(&msg, 0, sizeof(msg));
 	/* Bail out if consumer is disabled */
 	if (!consumer->enabled) {
 		ret = LTTNG_OK;
@@ -1078,12 +1080,12 @@ int consumer_is_data_pending(uint64_t session_id,
 
 	assert(consumer);
 
-	msg.cmd_type = LTTNG_CONSUMER_DATA_PENDING;
+	DBG3("Consumer data pending for id %" PRIu64, session_id);
 
+	memset(&msg, 0, sizeof(msg));
+	msg.cmd_type = LTTNG_CONSUMER_DATA_PENDING;
 	msg.u.data_pending.session_id = session_id;
 
-	DBG3("Consumer data pending for id %" PRIu64, session_id);
-
 	/* Send command for each consumer */
 	rcu_read_lock();
 	cds_lfht_for_each_entry(consumer->socks->ht, &iter.iter, socket,
@@ -1136,6 +1138,7 @@ int consumer_flush_channel(struct consumer_socket *socket, uint64_t key)
 
 	DBG2("Consumer flush channel key %" PRIu64, key);
 
+	memset(&msg, 0, sizeof(msg));
 	msg.cmd_type = LTTNG_CONSUMER_FLUSH_CHANNEL;
 	msg.u.flush_channel.key = key;
 
@@ -1168,6 +1171,7 @@ int consumer_close_metadata(struct consumer_socket *socket,
 
 	DBG2("Consumer close metadata channel key %" PRIu64, metadata_key);
 
+	memset(&msg, 0, sizeof(msg));
 	msg.cmd_type = LTTNG_CONSUMER_CLOSE_METADATA;
 	msg.u.close_metadata.key = metadata_key;
 
@@ -1200,6 +1204,7 @@ int consumer_setup_metadata(struct consumer_socket *socket,
 
 	DBG2("Consumer setup metadata channel key %" PRIu64, metadata_key);
 
+	memset(&msg, 0, sizeof(msg));
 	msg.cmd_type = LTTNG_CONSUMER_SETUP_METADATA;
 	msg.u.setup_metadata.key = metadata_key;
 
@@ -1233,6 +1238,7 @@ int consumer_push_metadata(struct consumer_socket *socket,
 
 	DBG2("Consumer push metadata to consumer socket %d", *socket->fd_ptr);
 
+	memset(&msg, 0, sizeof(msg));
 	msg.cmd_type = LTTNG_CONSUMER_PUSH_METADATA;
 	msg.u.push_metadata.key = metadata_key;
 	msg.u.push_metadata.target_offset = target_offset;
diff --git a/src/bin/lttng-sessiond/jul.c b/src/bin/lttng-sessiond/jul.c
index 7b603cf..3c25199 100644
--- a/src/bin/lttng-sessiond/jul.c
+++ b/src/bin/lttng-sessiond/jul.c
@@ -67,6 +67,7 @@ static int send_header(struct lttcomm_sock *sock, uint64_t data_size,
 
 	assert(sock);
 
+	memset(&msg, 0, sizeof(msg));
 	msg.data_size = htobe64(data_size);
 	msg.cmd = htobe32(cmd);
 	msg.cmd_version = htobe32(cmd_version);
@@ -248,6 +249,7 @@ static int enable_event(struct jul_app *app, struct jul_event *event)
 		goto error_io;
 	}
 
+	memset(&msg, 0, sizeof(msg));
 	msg.loglevel = event->loglevel;
 	msg.loglevel_type = event->loglevel_type;
 	strncpy(msg.name, event->name, sizeof(msg.name));
@@ -309,6 +311,7 @@ static int disable_event(struct jul_app *app, struct jul_event *event)
 		goto error_io;
 	}
 
+	memset(&msg, 0, sizeof(msg));
 	strncpy(msg.name, event->name, sizeof(msg.name));
 	ret = send_payload(app->sock, &msg, sizeof(msg));
 	if (ret < 0) {
@@ -443,24 +446,30 @@ int jul_list_events(struct lttng_event **events)
 			goto error_unlock;
 		}
 
-		if (count >= nbmem) {
+		if (count + nb_ev > nbmem) {
 			/* In case the realloc fails, we free the memory */
-			void *ptr;
-
-			DBG2("Reallocating JUL event list from %zu to %zu entries", nbmem,
-					2 * nbmem);
-			nbmem *= 2;
-			ptr = realloc(tmp_events, nbmem * sizeof(*tmp_events));
-			if (!ptr) {
+			struct lttng_event *new_tmp_events;
+			size_t new_nbmem;
+
+			new_nbmem = max_t(size_t, count + nb_ev, nbmem << 1);
+			DBG2("Reallocating JUL event list from %zu to %zu entries",
+					nbmem, new_nbmem);
+			new_tmp_events = realloc(tmp_events,
+				new_nbmem * sizeof(*new_tmp_events));
+			if (!new_tmp_events) {
 				PERROR("realloc JUL events");
 				ret = -ENOMEM;
 				free(jul_events);
 				goto error_unlock;
 			}
-			tmp_events = ptr;
+			/* Zero the new memory */
+			memset(new_tmp_events + nbmem, 0,
+				(new_nbmem - nbmem) * sizeof(*new_tmp_events));
+			nbmem = new_nbmem;
+			tmp_events = new_tmp_events;
 		}
-		memcpy(tmp_events + (count * sizeof(*tmp_events)), jul_events,
-				nb_ev * sizeof(*tmp_events));
+		memcpy(tmp_events + count, jul_events,
+			nb_ev * sizeof(*tmp_events));
 		free(jul_events);
 		count += nb_ev;
 	}
diff --git a/src/bin/lttng-sessiond/kernel-consumer.c b/src/bin/lttng-sessiond/kernel-consumer.c
index 4153612..38820af 100644
--- a/src/bin/lttng-sessiond/kernel-consumer.c
+++ b/src/bin/lttng-sessiond/kernel-consumer.c
@@ -105,7 +105,7 @@ int kernel_consumer_add_channel(struct consumer_socket *sock,
 		}
 	} else {
 		/* Empty path. */
-		pathname = "";
+		pathname = strdup("");
 	}
 
 	/* Prep channel message structure */
@@ -136,6 +136,7 @@ int kernel_consumer_add_channel(struct consumer_socket *sock,
 	health_code_update();
 
 error:
+	free(pathname);
 	return ret;
 }
 
@@ -168,7 +169,7 @@ int kernel_consumer_add_metadata(struct consumer_socket *sock,
 		}
 	} else {
 		/* Empty path. */
-		pathname = "";
+		pathname = strdup("");
 	}
 
 	/* Prep channel message structure */
@@ -215,6 +216,7 @@ int kernel_consumer_add_metadata(struct consumer_socket *sock,
 	health_code_update();
 
 error:
+	free(pathname);
 	return ret;
 }
 
@@ -419,6 +421,7 @@ int kernel_consumer_destroy_channel(struct consumer_socket *socket,
 
 	DBG("Sending kernel consumer destroy channel key %d", channel->fd);
 
+	memset(&msg, 0, sizeof(msg));
 	msg.cmd_type = LTTNG_CONSUMER_DESTROY_CHANNEL;
 	msg.u.destroy_channel.key = channel->fd;
 
@@ -447,6 +450,7 @@ int kernel_consumer_destroy_metadata(struct consumer_socket *socket,
 
 	DBG("Sending kernel consumer destroy channel key %d", metadata->fd);
 
+	memset(&msg, 0, sizeof(msg));
 	msg.cmd_type = LTTNG_CONSUMER_DESTROY_CHANNEL;
 	msg.u.destroy_channel.key = metadata->fd;
 
diff --git a/src/bin/lttng-sessiond/kernel.c b/src/bin/lttng-sessiond/kernel.c
index 9e78268..b6b24a5 100644
--- a/src/bin/lttng-sessiond/kernel.c
+++ b/src/bin/lttng-sessiond/kernel.c
@@ -602,7 +602,7 @@ error:
  */
 ssize_t kernel_list_events(int tracer_fd, struct lttng_event **events)
 {
-	int fd, pos, ret;
+	int fd, ret;
 	char *event;
 	size_t nbmem, count = 0;
 	FILE *fp;
@@ -634,15 +634,15 @@ ssize_t kernel_list_events(int tracer_fd, struct lttng_event **events)
 		goto end;
 	}
 
-	while (fscanf(fp, "event { name = %m[^;]; };%n\n", &event, &pos) == 1) {
+	while (fscanf(fp, "event { name = %m[^;]; };\n", &event) == 1) {
 		if (count >= nbmem) {
 			struct lttng_event *new_elist;
+			size_t new_nbmem;
 
-			DBG("Reallocating event list from %zu to %zu bytes", nbmem,
-					nbmem * 2);
-			/* Double the size */
-			nbmem <<= 1;
-			new_elist = realloc(elist, nbmem * sizeof(struct lttng_event));
+			new_nbmem = nbmem << 1;
+			DBG("Reallocating event list from %zu to %zu bytes",
+					nbmem, new_nbmem);
+			new_elist = realloc(elist, new_nbmem * sizeof(struct lttng_event));
 			if (new_elist == NULL) {
 				PERROR("realloc list events");
 				free(event);
@@ -650,6 +650,10 @@ ssize_t kernel_list_events(int tracer_fd, struct lttng_event **events)
 				count = -ENOMEM;
 				goto end;
 			}
+			/* Zero the new memory */
+			memset(new_elist + nbmem, 0,
+				(new_nbmem - nbmem) * sizeof(struct lttng_event));
+			nbmem = new_nbmem;
 			elist = new_elist;
 		}
 		strncpy(elist[count].name, event, LTTNG_SYMBOL_NAME_LEN);
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index c3f564d..f0aaf73 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -3734,7 +3734,7 @@ restart:
 
 		rcu_thread_online();
 
-		reply.ret_code = 0;
+		memset(&reply, 0, sizeof(reply));
 		for (i = 0; i < NR_HEALTH_SESSIOND_TYPES; i++) {
 			/*
 			 * health_check_state returns 0 if health is
diff --git a/src/bin/lttng-sessiond/snapshot.c b/src/bin/lttng-sessiond/snapshot.c
index 6b1aa8d..8faf9a7 100644
--- a/src/bin/lttng-sessiond/snapshot.c
+++ b/src/bin/lttng-sessiond/snapshot.c
@@ -24,6 +24,7 @@
 #include <common/defaults.h>
 
 #include "snapshot.h"
+#include "utils.h"
 
 /*
  * Return the atomically incremented value of next_output_id.
@@ -321,4 +322,5 @@ void snapshot_destroy(struct snapshot *obj)
 		snapshot_output_destroy(output);
 	}
 	rcu_read_unlock();
+	ht_cleanup_push(obj->output_ht);
 }
diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 34d4c9b..c32bf2b 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -3144,19 +3144,25 @@ int ust_app_list_events(struct lttng_event **events)
 			health_code_update();
 			if (count >= nbmem) {
 				/* In case the realloc fails, we free the memory */
-				void *ptr;
-
-				DBG2("Reallocating event list from %zu to %zu entries", nbmem,
-						2 * nbmem);
-				nbmem *= 2;
-				ptr = realloc(tmp_event, nbmem * sizeof(struct lttng_event));
-				if (ptr == NULL) {
+				struct lttng_event *new_tmp_event;
+				size_t new_nbmem;
+
+				new_nbmem = nbmem << 1;
+				DBG2("Reallocating event list from %zu to %zu entries",
+						nbmem, new_nbmem);
+				new_tmp_event = realloc(tmp_event,
+					new_nbmem * sizeof(struct lttng_event));
+				if (new_tmp_event == NULL) {
 					PERROR("realloc ust app events");
 					free(tmp_event);
 					ret = -ENOMEM;
 					goto rcu_error;
 				}
-				tmp_event = ptr;
+				/* Zero the new memory */
+				memset(new_tmp_event + nbmem, 0,
+					(new_nbmem - nbmem) * sizeof(struct lttng_event));
+				nbmem = new_nbmem;
+				tmp_event = new_tmp_event;
 			}
 			memcpy(tmp_event[count].name, uiter.name, LTTNG_UST_SYM_NAME_LEN);
 			tmp_event[count].loglevel = uiter.loglevel;
@@ -3244,19 +3250,25 @@ int ust_app_list_event_fields(struct lttng_event_field **fields)
 			health_code_update();
 			if (count >= nbmem) {
 				/* In case the realloc fails, we free the memory */
-				void *ptr;
-
-				DBG2("Reallocating event field list from %zu to %zu entries", nbmem,
-						2 * nbmem);
-				nbmem *= 2;
-				ptr = realloc(tmp_event, nbmem * sizeof(struct lttng_event_field));
-				if (ptr == NULL) {
+				struct lttng_event_field *new_tmp_event;
+				size_t new_nbmem;
+
+				new_nbmem = nbmem << 1;
+				DBG2("Reallocating event field list from %zu to %zu entries",
+						nbmem, new_nbmem);
+				new_tmp_event = realloc(tmp_event,
+					new_nbmem * sizeof(struct lttng_event_field));
+				if (new_tmp_event == NULL) {
 					PERROR("realloc ust app event fields");
 					free(tmp_event);
 					ret = -ENOMEM;
 					goto rcu_error;
 				}
-				tmp_event = ptr;
+				/* Zero the new memory */
+				memset(new_tmp_event + nbmem, 0,
+					(new_nbmem - nbmem) * sizeof(struct lttng_event_field));
+				nbmem = new_nbmem;
+				tmp_event = new_tmp_event;
 			}
 
 			memcpy(tmp_event[count].field_name, uiter.field_name, LTTNG_UST_SYM_NAME_LEN);
diff --git a/src/bin/lttng-sessiond/ust-consumer.c b/src/bin/lttng-sessiond/ust-consumer.c
index b0a52b3..9715c42 100644
--- a/src/bin/lttng-sessiond/ust-consumer.c
+++ b/src/bin/lttng-sessiond/ust-consumer.c
@@ -250,6 +250,7 @@ int ust_consumer_get_channel(struct consumer_socket *socket,
 	assert(ua_chan);
 	assert(socket);
 
+	memset(&msg, 0, sizeof(msg));
 	msg.cmd_type = LTTNG_CONSUMER_GET_CHANNEL;
 	msg.u.get_channel.key = ua_chan->key;
 
@@ -344,6 +345,7 @@ int ust_consumer_destroy_channel(struct consumer_socket *socket,
 	assert(ua_chan);
 	assert(socket);
 
+	memset(&msg, 0, sizeof(msg));
 	msg.cmd_type = LTTNG_CONSUMER_DESTROY_CHANNEL;
 	msg.u.destroy_channel.key = ua_chan->key;
 
@@ -469,6 +471,7 @@ int ust_consumer_metadata_request(struct consumer_socket *socket)
 			DBG("PID registry not found for session id %" PRIu64,
 					request.session_id_per_pid);
 
+			memset(&msg, 0, sizeof(msg));
 			msg.cmd_type = LTTNG_ERR_UND;
 			(void) consumer_send_msg(socket, &msg);
 			/*
diff --git a/src/common/compat/compat-epoll.c b/src/common/compat/compat-epoll.c
index 25c9955..ecd09a0 100644
--- a/src/common/compat/compat-epoll.c
+++ b/src/common/compat/compat-epoll.c
@@ -51,6 +51,11 @@ static int resize_poll_event(struct lttng_poll_event *events,
 		PERROR("realloc epoll add");
 		goto error;
 	}
+	if (new_size > events->alloc_size) {
+		/* Zero newly allocated memory */
+		memset(ptr + events->alloc_size, 0,
+			(new_size - events->alloc_size) * sizeof(*ptr));
+	}
 	events->events = ptr;
 	events->alloc_size = new_size;
 
@@ -119,6 +124,11 @@ int compat_epoll_add(struct lttng_poll_event *events, int fd, uint32_t req_event
 		goto error;
 	}
 
+	/*
+	 * Zero struct epoll_event to ensure all representations of its
+	 * union are zeroed.
+	 */
+	memset(&ev, 0, sizeof(ev));
 	ev.events = req_events;
 	ev.data.fd = fd;
 
diff --git a/src/common/compat/compat-poll.c b/src/common/compat/compat-poll.c
index 79fcb7d..4893768 100644
--- a/src/common/compat/compat-poll.c
+++ b/src/common/compat/compat-poll.c
@@ -52,6 +52,11 @@ static int resize_poll_event(struct compat_poll_event_array *array,
 		PERROR("realloc epoll add");
 		goto error;
 	}
+	if (new_size > array->alloc_size) {
+		/* Zero newly allocated memory */
+		memset(ptr + array->alloc_size, 0,
+			(new_size - array->alloc_size) * sizeof(*ptr));
+	}
 	array->events = ptr;
 	array->alloc_size = new_size;
 
diff --git a/src/common/consumer-metadata-cache.c b/src/common/consumer-metadata-cache.c
index d8f5001..0f086fe 100644
--- a/src/common/consumer-metadata-cache.c
+++ b/src/common/consumer-metadata-cache.c
@@ -46,14 +46,13 @@ static int extend_metadata_cache(struct lttng_consumer_channel *channel,
 {
 	int ret = 0;
 	char *tmp_data_ptr;
-	unsigned int new_size;
+	unsigned int new_size, old_size;
 
 	assert(channel);
 	assert(channel->metadata_cache);
 
-	new_size = max_t(unsigned int,
-			channel->metadata_cache->cache_alloc_size + size,
-			channel->metadata_cache->cache_alloc_size << 1);
+	old_size = channel->metadata_cache->cache_alloc_size;
+	new_size = max_t(unsigned int, old_size + size, old_size << 1);
 	DBG("Extending metadata cache to %u", new_size);
 	tmp_data_ptr = realloc(channel->metadata_cache->data, new_size);
 	if (!tmp_data_ptr) {
@@ -62,6 +61,8 @@ static int extend_metadata_cache(struct lttng_consumer_channel *channel,
 		ret = -1;
 		goto end;
 	}
+	/* Zero newly allocated memory */
+	memset(tmp_data_ptr + old_size, 0, new_size - old_size);
 	channel->metadata_cache->data = tmp_data_ptr;
 	channel->metadata_cache->cache_alloc_size = new_size;
 
diff --git a/src/common/consumer.c b/src/common/consumer.c
index 821a04e..c842de9 100644
--- a/src/common/consumer.c
+++ b/src/common/consumer.c
@@ -3613,6 +3613,7 @@ int consumer_send_status_msg(int sock, int ret_code)
 {
 	struct lttcomm_consumer_status_msg msg;
 
+	memset(&msg, 0, sizeof(msg));
 	msg.ret_code = ret_code;
 
 	return lttcomm_send_unix_sock(sock, &msg, sizeof(msg));
@@ -3630,6 +3631,7 @@ int consumer_send_status_channel(int sock,
 
 	assert(sock >= 0);
 
+	memset(&msg, 0, sizeof(msg));
 	if (!channel) {
 		msg.ret_code = LTTCOMM_CONSUMERD_CHANNEL_FAIL;
 	} else {
diff --git a/src/common/relayd/relayd.c b/src/common/relayd/relayd.c
index ccb23c0..3de19c2 100644
--- a/src/common/relayd/relayd.c
+++ b/src/common/relayd/relayd.c
@@ -57,6 +57,7 @@ static int send_command(struct lttcomm_relayd_sock *rsock,
 		goto alloc_error;
 	}
 
+	memset(&header, 0, sizeof(header));
 	header.cmd = htobe32(cmd);
 	header.data_size = htobe64(size);
 
@@ -244,6 +245,7 @@ int relayd_add_stream(struct lttcomm_relayd_sock *rsock, const char *channel_nam
 
 	/* Compat with relayd 2.1 */
 	if (rsock->minor == 1) {
+		memset(&msg, 0, sizeof(msg));
 		strncpy(msg.channel_name, channel_name, sizeof(msg.channel_name));
 		strncpy(msg.pathname, pathname, sizeof(msg.pathname));
 
@@ -253,6 +255,7 @@ int relayd_add_stream(struct lttcomm_relayd_sock *rsock, const char *channel_nam
 			goto error;
 		}
 	} else {
+		memset(&msg_2_2, 0, sizeof(msg_2_2));
 		/* Compat with relayd 2.2+ */
 		strncpy(msg_2_2.channel_name, channel_name, sizeof(msg_2_2.channel_name));
 		strncpy(msg_2_2.pathname, pathname, sizeof(msg_2_2.pathname));
@@ -364,6 +367,7 @@ int relayd_version_check(struct lttcomm_relayd_sock *rsock)
 	DBG("Relayd version check for major.minor %u.%u", rsock->major,
 			rsock->minor);
 
+	memset(&msg, 0, sizeof(msg));
 	/* Prepare network byte order before transmission. */
 	msg.major = htobe32(rsock->major);
 	msg.minor = htobe32(rsock->minor);
@@ -565,6 +569,7 @@ int relayd_send_close_stream(struct lttcomm_relayd_sock *rsock, uint64_t stream_
 
 	DBG("Relayd closing stream id %" PRIu64, stream_id);
 
+	memset(&msg, 0, sizeof(msg));
 	msg.stream_id = htobe64(stream_id);
 	msg.last_net_seq_num = htobe64(last_net_seq_num);
 
@@ -614,6 +619,7 @@ int relayd_data_pending(struct lttcomm_relayd_sock *rsock, uint64_t stream_id,
 
 	DBG("Relayd data pending for stream id %" PRIu64, stream_id);
 
+	memset(&msg, 0, sizeof(msg));
 	msg.stream_id = htobe64(stream_id);
 	msg.last_net_seq_num = htobe64(last_net_seq_num);
 
@@ -662,6 +668,7 @@ int relayd_quiescent_control(struct lttcomm_relayd_sock *rsock,
 
 	DBG("Relayd checking quiescent control state");
 
+	memset(&msg, 0, sizeof(msg));
 	msg.stream_id = htobe64(metadata_stream_id);
 
 	/* Send command */
@@ -706,6 +713,7 @@ int relayd_begin_data_pending(struct lttcomm_relayd_sock *rsock, uint64_t id)
 
 	DBG("Relayd begin data pending");
 
+	memset(&msg, 0, sizeof(msg));
 	msg.session_id = htobe64(id);
 
 	/* Send command */
@@ -753,6 +761,7 @@ int relayd_end_data_pending(struct lttcomm_relayd_sock *rsock, uint64_t id,
 
 	DBG("Relayd end data pending");
 
+	memset(&msg, 0, sizeof(msg));
 	msg.session_id = htobe64(id);
 
 	/* Send command */
@@ -805,6 +814,7 @@ int relayd_send_index(struct lttcomm_relayd_sock *rsock,
 
 	DBG("Relayd sending index for stream ID %" PRIu64, relay_stream_id);
 
+	memset(&msg, 0, sizeof(msg));
 	msg.relay_stream_id = htobe64(relay_stream_id);
 	msg.net_seq_num = htobe64(net_seq_num);
 
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index b48a3c8..0707326 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -2212,6 +2212,8 @@ int lttng_ustconsumer_request_metadata(struct lttng_consumer_local_data *ctx,
 	assert(channel);
 	assert(channel->metadata_cache);
 
+	memset(&request, 0, sizeof(request));
+
 	/* send the metadata request to sessiond */
 	switch (consumer_data.type) {
 	case LTTNG_CONSUMER64_UST:
diff --git a/src/lib/lttng-ctl/lttng-ctl-health.c b/src/lib/lttng-ctl/lttng-ctl-health.c
index c78e0dc..ba9aac0 100644
--- a/src/lib/lttng-ctl/lttng-ctl-health.c
+++ b/src/lib/lttng-ctl/lttng-ctl-health.c
@@ -272,6 +272,7 @@ retry:
 		goto error;
 	}
 
+	memset(&msg, 0, sizeof(msg));
 	msg.cmd = HEALTH_CMD_CHECK;
 
 	ret = lttcomm_send_unix_sock(sock, (void *)&msg, sizeof(msg));
diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
index 7d06c7a..94f075b 100644
--- a/src/lib/lttng-ctl/lttng-ctl.c
+++ b/src/lib/lttng-ctl/lttng-ctl.c
@@ -520,6 +520,7 @@ int lttng_register_consumer(struct lttng_handle *handle,
 		return -LTTNG_ERR_INVALID;
 	}
 
+	memset(&lsm, 0, sizeof(lsm));
 	lsm.cmd_type = LTTNG_REGISTER_CONSUMER;
 	lttng_ctl_copy_string(lsm.session.name, handle->session_name,
 			sizeof(lsm.session.name));
@@ -542,6 +543,7 @@ int lttng_start_tracing(const char *session_name)
 		return -LTTNG_ERR_INVALID;
 	}
 
+	memset(&lsm, 0, sizeof(lsm));
 	lsm.cmd_type = LTTNG_START_TRACE;
 
 	lttng_ctl_copy_string(lsm.session.name, session_name,
@@ -562,6 +564,7 @@ static int _lttng_stop_tracing(const char *session_name, int wait)
 		return -LTTNG_ERR_INVALID;
 	}
 
+	memset(&lsm, 0, sizeof(lsm));
 	lsm.cmd_type = LTTNG_STOP_TRACE;
 
 	lttng_ctl_copy_string(lsm.session.name, session_name,
@@ -1004,6 +1007,7 @@ int lttng_list_tracepoints(struct lttng_handle *handle,
 		return -LTTNG_ERR_INVALID;
 	}
 
+	memset(&lsm, 0, sizeof(lsm));
 	lsm.cmd_type = LTTNG_LIST_TRACEPOINTS;
 	lttng_ctl_copy_lttng_domain(&lsm.domain, &handle->domain);
 
@@ -1031,6 +1035,7 @@ int lttng_list_tracepoint_fields(struct lttng_handle *handle,
 		return -LTTNG_ERR_INVALID;
 	}
 
+	memset(&lsm, 0, sizeof(lsm));
 	lsm.cmd_type = LTTNG_LIST_TRACEPOINT_FIELDS;
 	lttng_ctl_copy_lttng_domain(&lsm.domain, &handle->domain);
 
@@ -1099,6 +1104,7 @@ int lttng_destroy_session(const char *session_name)
 		return -LTTNG_ERR_INVALID;
 	}
 
+	memset(&lsm, 0, sizeof(lsm));
 	lsm.cmd_type = LTTNG_DESTROY_SESSION;
 
 	lttng_ctl_copy_string(lsm.session.name, session_name,
@@ -1118,6 +1124,7 @@ int lttng_list_sessions(struct lttng_session **sessions)
 	int ret;
 	struct lttcomm_session_msg lsm;
 
+	memset(&lsm, 0, sizeof(lsm));
 	lsm.cmd_type = LTTNG_LIST_SESSIONS;
 	ret = lttng_ctl_ask_sessiond(&lsm, (void**) sessions);
 	if (ret < 0) {
@@ -1143,6 +1150,7 @@ int lttng_list_domains(const char *session_name,
 		return -LTTNG_ERR_INVALID;
 	}
 
+	memset(&lsm, 0, sizeof(lsm));
 	lsm.cmd_type = LTTNG_LIST_DOMAINS;
 
 	lttng_ctl_copy_string(lsm.session.name, session_name,
@@ -1172,6 +1180,7 @@ int lttng_list_channels(struct lttng_handle *handle,
 		return -LTTNG_ERR_INVALID;
 	}
 
+	memset(&lsm, 0, sizeof(lsm));
 	lsm.cmd_type = LTTNG_LIST_CHANNELS;
 	lttng_ctl_copy_string(lsm.session.name, handle->session_name,
 			sizeof(lsm.session.name));
@@ -1203,6 +1212,7 @@ int lttng_list_events(struct lttng_handle *handle,
 		return -LTTNG_ERR_INVALID;
 	}
 
+	memset(&lsm, 0, sizeof(lsm));
 	lsm.cmd_type = LTTNG_LIST_EVENTS;
 	lttng_ctl_copy_string(lsm.session.name, handle->session_name,
 			sizeof(lsm.session.name));
@@ -1250,6 +1260,7 @@ int lttng_calibrate(struct lttng_handle *handle,
 		return -LTTNG_ERR_INVALID;
 	}
 
+	memset(&lsm, 0, sizeof(lsm));
 	lsm.cmd_type = LTTNG_CALIBRATE;
 	lttng_ctl_copy_lttng_domain(&lsm.domain, &handle->domain);
 
@@ -1480,6 +1491,7 @@ int lttng_data_pending(const char *session_name)
 		return -LTTNG_ERR_INVALID;
 	}
 
+	memset(&lsm, 0, sizeof(lsm));
 	lsm.cmd_type = LTTNG_DATA_PENDING;
 
 	lttng_ctl_copy_string(lsm.session.name, session_name,
-- 
1.7.10.4
