From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 1/4] Fix: sessiond vs consumerd
	push/get metadata deadlock
Date: Mon, 17 Aug 2015 11:12:07 -0700
Message-ID: <1439835130-8852-2-git-send-email-mathieu.desnoyers__44534.638655796$1439835232$gmane$org@efficios.com>
References: <1439835130-8852-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZROtU-0000qQ-KT
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

We need to unlock the registry while we push metadata to break a
circular dependency between the consumerd metadata lock and the sessiond
registry lock. Indeed, pushing metadata to the consumerd awaits that it
gets pushed all the way to relayd, but doing so requires grabbing the
metadata lock. If a concurrent metadata request is being performed by
consumerd, this can try to grab the registry lock on the sessiond while
holding the metadata lock on the consumer daemon. Those push and pull
schemes are performed on two different bidirectionnal communication
sockets.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/ust-app.c       | 100 +++++++++++++++++++++++----------
 src/bin/lttng-sessiond/ust-app.h       |   6 +-
 src/bin/lttng-sessiond/ust-consumer.c  |   2 +-
 src/common/ust-consumer/ust-consumer.c |   9 +++
 4 files changed, 84 insertions(+), 33 deletions(-)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 6f032da..d452986 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -436,21 +436,25 @@ void delete_ust_app_channel(int sock, struct ust_app_channel *ua_chan,
  * terminated concurrently).
  */
 ssize_t ust_app_push_metadata(struct ust_registry_session *registry,
-		struct consumer_socket *socket, int send_zero_data)
+		struct consumer_socket *socket, int send_zero_data,
+		int peek_consumer)
 {
 	int ret;
 	char *metadata_str = NULL;
 	size_t len, offset;
 	ssize_t ret_val;
+	uint64_t metadata_key;
 
 	assert(registry);
 	assert(socket);
 
+	metadata_key = registry->metadata_key;
+
 	/*
 	 * Means that no metadata was assigned to the session. This can
 	 * happens if no start has been done previously.
 	 */
-	if (!registry->metadata_key) {
+	if (!metadata_key) {
 		return 0;
 	}
 
@@ -466,6 +470,42 @@ ssize_t ust_app_push_metadata(struct ust_registry_session *registry,
 		return -EPIPE;
 	}
 
+	if (peek_consumer) {
+		pthread_mutex_unlock(&registry->lock);
+		/*
+		 * Always need to unlock registry while sending metadata to
+		 * consumer due to deadlock (see below). Try to push empty
+		 * metadata to detect cases where the metadata stream is not
+		 * created on the consumer side. This allows us to assume it is
+		 * there in the following push, which should not fail.
+		 */
+		ret = consumer_push_metadata(socket, metadata_key,
+				NULL, 0, 0);
+		pthread_mutex_lock(&registry->lock);
+		if (ret < 0) {
+			/*
+			 * There is an acceptable race here between the registry
+			 * metadata key assignment and the creation on the
+			 * consumer. The session daemon can concurrently push
+			 * metadata for this registry while being created on the
+			 * consumer since the metadata key of the registry is
+			 * assigned *before* it is setup to avoid the consumer
+			 * to ask for metadata that could possibly be not found
+			 * in the session daemon.
+			 *
+			 * The metadata will get pushed either by the session
+			 * being stopped or the consumer requesting metadata if
+			 * that race is triggered.
+			 */
+			if (ret == -LTTCOMM_CONSUMERD_CHANNEL_FAIL) {
+				ret = 0;
+			}
+
+			ret_val = ret;
+			goto error_push;
+		}
+	}
+
 	offset = registry->metadata_len_sent;
 	len = registry->metadata_len - registry->metadata_len_sent;
 	if (len == 0) {
@@ -488,39 +528,39 @@ ssize_t ust_app_push_metadata(struct ust_registry_session *registry,
 	}
 	/* Copy what we haven't send out. */
 	memcpy(metadata_str, registry->metadata + offset, len);
+	/*
+	 * Metadata may have been concurrently pushed, since we're not
+	 * holding the registry lock while pushing to consumer. This is
+	 * handled by the fact that we send the metadata content, size,
+	 * and the offset at which that metadata belongs. This may
+	 * arrive out of order on the consumer side, and the consumer is
+	 * able to reorder the fragments. The consumer supports
+	 * non-consecutive fragments, but not overlapping fragments.
+	 */
 	registry->metadata_len_sent += len;
 
 push_data:
-	ret = consumer_push_metadata(socket, registry->metadata_key,
+	pthread_mutex_unlock(&registry->lock);
+	/*
+	 * We need to unlock the registry while we push metadata to
+	 * break a circular dependency between the consumerd metadata
+	 * lock and the sessiond registry lock. Indeed, pushing metadata
+	 * to the consumerd awaits that it gets pushed all the way to
+	 * relayd, but doing so requires grabbing the metadata lock. If
+	 * a concurrent metadata request is being performed by
+	 * consumerd, this can try to grab the registry lock on the
+	 * sessiond while holding the metadata lock on the consumer
+	 * daemon. Those push and pull schemes are performed on two
+	 * different bidirectionnal communication sockets.
+	 */
+	ret = consumer_push_metadata(socket, metadata_key,
 			metadata_str, len, offset);
+	pthread_mutex_lock(&registry->lock);
 	if (ret < 0) {
-		/*
-		 * There is an acceptable race here between the registry
-		 * metadata key assignment and the creation on the
-		 * consumer. The session daemon can concurrently push
-		 * metadata for this registry while being created on the
-		 * consumer since the metadata key of the registry is
-		 * assigned *before* it is setup to avoid the consumer
-		 * to ask for metadata that could possibly be not found
-		 * in the session daemon.
-		 *
-		 * The metadata will get pushed either by the session
-		 * being stopped or the consumer requesting metadata if
-		 * that race is triggered.
-		 */
-		if (ret == -LTTCOMM_CONSUMERD_CHANNEL_FAIL) {
-			ret = 0;
-		}
-
-		/*
-		 * Update back the actual metadata len sent since it
-		 * failed here.
-		 */
-		registry->metadata_len_sent -= len;
-		ret_val = ret;
-		goto error_push;
+		ERR("Error pushing metadata to consumer");
+		ret_val = -LTTCOMM_CONSUMERD_CHANNEL_FAIL;
+		goto error;
 	}
-
 	free(metadata_str);
 	return len;
 
@@ -579,7 +619,7 @@ static int push_metadata(struct ust_registry_session *registry,
 		goto error;
 	}
 
-	ret = ust_app_push_metadata(registry, socket, 0);
+	ret = ust_app_push_metadata(registry, socket, 0, 1);
 	if (ret < 0) {
 		ret_val = ret;
 		goto error;
diff --git a/src/bin/lttng-sessiond/ust-app.h b/src/bin/lttng-sessiond/ust-app.h
index 102b05b..35da66b 100644
--- a/src/bin/lttng-sessiond/ust-app.h
+++ b/src/bin/lttng-sessiond/ust-app.h
@@ -326,7 +326,8 @@ void ust_app_add(struct ust_app *app);
 struct ust_app *ust_app_create(struct ust_register_msg *msg, int sock);
 void ust_app_notify_sock_unregister(int sock);
 ssize_t ust_app_push_metadata(struct ust_registry_session *registry,
-		struct consumer_socket *socket, int send_zero_data);
+		struct consumer_socket *socket, int send_zero_data,
+		int peek_consumer);
 void ust_app_destroy(struct ust_app *app);
 int ust_app_snapshot_record(struct ltt_ust_session *usess,
 		struct snapshot_output *output, int wait,
@@ -507,7 +508,8 @@ void ust_app_notify_sock_unregister(int sock)
 }
 static inline
 ssize_t ust_app_push_metadata(struct ust_registry_session *registry,
-		struct consumer_socket *socket, int send_zero_data)
+		struct consumer_socket *socket, int send_zero_data,
+		int peek_consumer)
 {
 	return 0;
 }
diff --git a/src/bin/lttng-sessiond/ust-consumer.c b/src/bin/lttng-sessiond/ust-consumer.c
index ad076e3..bacbf92 100644
--- a/src/bin/lttng-sessiond/ust-consumer.c
+++ b/src/bin/lttng-sessiond/ust-consumer.c
@@ -509,7 +509,7 @@ int ust_consumer_metadata_request(struct consumer_socket *socket)
 	assert(ust_reg);
 
 	pthread_mutex_lock(&ust_reg->lock);
-	ret_push = ust_app_push_metadata(ust_reg, socket, 1);
+	ret_push = ust_app_push_metadata(ust_reg, socket, 1, 0);
 	pthread_mutex_unlock(&ust_reg->lock);
 	if (ret_push == -EPIPE) {
 		DBG("Application or relay closed while pushing metadata");
diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-consumer/ust-consumer.c
index fbc3bbb..a3daff3 100644
--- a/src/common/ust-consumer/ust-consumer.c
+++ b/src/common/ust-consumer/ust-consumer.c
@@ -1578,6 +1578,15 @@ int lttng_ustconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
 
 		health_code_update();
 
+		if (!len) {
+			/*
+			 * There is nothing to receive. We have simply
+			 * checked whether the channel can be found.
+			 */
+			ret_code = LTTCOMM_CONSUMERD_SUCCESS;
+			goto end_msg_sessiond;
+		}
+
 		/* Tell session daemon we are ready to receive the metadata. */
 		ret = consumer_send_status_msg(sock, LTTCOMM_CONSUMERD_SUCCESS);
 		if (ret < 0) {
-- 
2.1.4
