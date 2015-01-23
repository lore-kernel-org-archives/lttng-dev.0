From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 2/2] Fix: deadlock between UST
	registry lock and consumer lock
Date: Fri, 23 Jan 2015 11:29:00 -0500
Message-ID: <1422030540-3544-2-git-send-email-mathieu.desnoyers__36418.2576573969$1422030697$gmane$org@efficios.com>
References: <1422030540-3544-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1YEh6d-00081G-Vi
 for lttng-dev@lists.lttng.org; Fri, 23 Jan 2015 11:29:14 -0500
In-Reply-To: <1422030540-3544-1-git-send-email-mathieu.desnoyers@efficios.com>
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

Reorganize locking of ust registry and consumer socket communication.

commit ce34fcd0 "Fix: per-uid flush and ust registry locking" attempted
to fix locking related to the UST registry, but doing so introduced a
deadlock. The actual solution is to reverse the order in which the UST
registry and the consumer lock nest: the UST registry will now to
responsible for serializing the registry content, and the consumer lock
will only protect communication with the consumer, as it should. This
deals with a TODO in the code.

The reason why this was not done from the beginning is that there was
originally an intent to make sure the ust registry lock is not held for
a long time, thus not while communicating with the consumer daemon.
However, when live has been implemented, it required communication with
the consumer daemon while the ust registry is held anyway. Therefore,
there is not much point anymore in trying to make sure this lock is not
held across the communication with consumerd in push_metadata. This
allows us to greatly simplify locking of the UST registry.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/consumer.c     |  9 +++-
 src/bin/lttng-sessiond/ust-app.c      | 84 +++++++++++++++--------------------
 src/bin/lttng-sessiond/ust-consumer.c |  7 +--
 src/bin/lttng-sessiond/ust-registry.h | 16 ++++---
 4 files changed, 59 insertions(+), 57 deletions(-)

diff --git a/src/bin/lttng-sessiond/consumer.c b/src/bin/lttng-sessiond/consumer.c
index 9b8a0a7..b7394d9 100644
--- a/src/bin/lttng-sessiond/consumer.c
+++ b/src/bin/lttng-sessiond/consumer.c
@@ -1158,7 +1158,8 @@ end:
 }
 
 /*
- * Send a close metdata command to consumer using the given channel key.
+ * Send a close metadata command to consumer using the given channel key.
+ * Called with registry lock held.
  *
  * Return 0 on success else a negative value.
  */
@@ -1224,7 +1225,8 @@ end:
 }
 
 /*
- * Send metadata string to consumer. Socket lock MUST be acquired.
+ * Send metadata string to consumer.
+ * RCU read-side lock must be held to guarantee existence of socket.
  *
  * Return 0 on success else a negative value.
  */
@@ -1239,6 +1241,8 @@ int consumer_push_metadata(struct consumer_socket *socket,
 
 	DBG2("Consumer push metadata to consumer socket %d", *socket->fd_ptr);
 
+	pthread_mutex_lock(socket->lock);
+
 	memset(&msg, 0, sizeof(msg));
 	msg.cmd_type = LTTNG_CONSUMER_PUSH_METADATA;
 	msg.u.push_metadata.key = metadata_key;
@@ -1266,6 +1270,7 @@ int consumer_push_metadata(struct consumer_socket *socket,
 	}
 
 end:
+	pthread_mutex_unlock(socket->lock);
 	health_code_update();
 	return ret;
 }
diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index bdee8e6..2366fd3 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -426,8 +426,9 @@ void delete_ust_app_channel(int sock, struct ust_app_channel *ua_chan,
 /*
  * Push metadata to consumer socket.
  *
- * The socket lock MUST be acquired.
- * The ust app session lock MUST be acquired.
+ * RCU read-side lock must be held to guarantee existance of socket.
+ * Must be called with the ust app session lock held.
+ * Must be called with the registry lock held.
  *
  * On success, return the len of metadata pushed or else a negative value.
  */
@@ -442,25 +443,22 @@ ssize_t ust_app_push_metadata(struct ust_registry_session *registry,
 	assert(registry);
 	assert(socket);
 
-	pthread_mutex_lock(&registry->lock);
-
 	/*
-	 * Means that no metadata was assigned to the session. This can happens if
-	 * no start has been done previously.
+	 * Means that no metadata was assigned to the session. This can
+	 * happens if no start has been done previously.
 	 */
 	if (!registry->metadata_key) {
-		pthread_mutex_unlock(&registry->lock);
 		return 0;
 	}
 
 	/*
-	 * On a push metadata error either the consumer is dead or the metadata
-	 * channel has been destroyed because its endpoint might have died (e.g:
-	 * relayd). If so, the metadata closed flag is set to 1 so we deny pushing
-	 * metadata again which is not valid anymore on the consumer side.
+	 * On a push metadata error either the consumer is dead or the
+	 * metadata channel has been destroyed because its endpoint
+	 * might have died (e.g: relayd). If so, the metadata closed
+	 * flag is set to 1 so we deny pushing metadata again which is
+	 * not valid anymore on the consumer side.
 	 */
 	if (registry->metadata_closed) {
-		pthread_mutex_unlock(&registry->lock);
 		return -EPIPE;
 	}
 
@@ -489,29 +487,32 @@ ssize_t ust_app_push_metadata(struct ust_registry_session *registry,
 	registry->metadata_len_sent += len;
 
 push_data:
-	pthread_mutex_unlock(&registry->lock);
 	ret = consumer_push_metadata(socket, registry->metadata_key,
 			metadata_str, len, offset);
 	if (ret < 0) {
 		/*
-		 * There is an acceptable race here between the registry metadata key
-		 * assignment and the creation on the consumer. The session daemon can
-		 * concurrently push metadata for this registry while being created on
-		 * the consumer since the metadata key of the registry is assigned
-		 * *before* it is setup to avoid the consumer to ask for metadata that
-		 * could possibly be not found in the session daemon.
+		 * There is an acceptable race here between the registry
+		 * metadata key assignment and the creation on the
+		 * consumer. The session daemon can concurrently push
+		 * metadata for this registry while being created on the
+		 * consumer since the metadata key of the registry is
+		 * assigned *before* it is setup to avoid the consumer
+		 * to ask for metadata that could possibly be not found
+		 * in the session daemon.
 		 *
-		 * The metadata will get pushed either by the session being stopped or
-		 * the consumer requesting metadata if that race is triggered.
+		 * The metadata will get pushed either by the session
+		 * being stopped or the consumer requesting metadata if
+		 * that race is triggered.
 		 */
 		if (ret == -LTTCOMM_CONSUMERD_CHANNEL_FAIL) {
 			ret = 0;
 		}
 
-		/* Update back the actual metadata len sent since it failed here. */
-		pthread_mutex_lock(&registry->lock);
+		/*
+		 * Update back the actual metadata len sent since it
+		 * failed here.
+		 */
 		registry->metadata_len_sent -= len;
-		pthread_mutex_unlock(&registry->lock);
 		ret_val = ret;
 		goto error_push;
 	}
@@ -523,13 +524,14 @@ end:
 error:
 	if (ret_val) {
 		/*
-		 * On error, flag the registry that the metadata is closed. We were unable
-		 * to push anything and this means that either the consumer is not
-		 * responding or the metadata cache has been destroyed on the consumer.
+		 * On error, flag the registry that the metadata is
+		 * closed. We were unable to push anything and this
+		 * means that either the consumer is not responding or
+		 * the metadata cache has been destroyed on the
+		 * consumer.
 		 */
 		registry->metadata_closed = 1;
 	}
-	pthread_mutex_unlock(&registry->lock);
 error_push:
 	free(metadata_str);
 	return ret_val;
@@ -541,7 +543,8 @@ error_push:
  * socket to send the metadata is retrieved from consumer, if sock
  * is not NULL we use it to send the metadata.
  * RCU read-side lock must be held while calling this function,
- * therefore ensuring existance of registry.
+ * therefore ensuring existance of registry. It also ensures existance
+ * of socket throughout this function.
  *
  * Return 0 on success else a negative error.
  */
@@ -556,50 +559,37 @@ static int push_metadata(struct ust_registry_session *registry,
 	assert(consumer);
 
 	pthread_mutex_lock(&registry->lock);
-
 	if (registry->metadata_closed) {
-		pthread_mutex_unlock(&registry->lock);
-		return -EPIPE;
+		ret_val = -EPIPE;
+		goto error;
 	}
 
 	/* Get consumer socket to use to push the metadata.*/
 	socket = consumer_find_socket_by_bitness(registry->bits_per_long,
 			consumer);
-	pthread_mutex_unlock(&registry->lock);
 	if (!socket) {
 		ret_val = -1;
 		goto error;
 	}
 
-	/*
-	 * TODO: Currently, we hold the socket lock around sampling of the next
-	 * metadata segment to ensure we send metadata over the consumer socket in
-	 * the correct order. This makes the registry lock nest inside the socket
-	 * lock.
-	 *
-	 * Please note that this is a temporary measure: we should move this lock
-	 * back into ust_consumer_push_metadata() when the consumer gets the
-	 * ability to reorder the metadata it receives.
-	 */
-	pthread_mutex_lock(socket->lock);
 	ret = ust_app_push_metadata(registry, socket, 0);
-	pthread_mutex_unlock(socket->lock);
 	if (ret < 0) {
 		ret_val = ret;
 		goto error;
 	}
-
+	pthread_mutex_unlock(&registry->lock);
 	return 0;
 
 error:
 end:
+	pthread_mutex_unlock(&registry->lock);
 	return ret_val;
 }
 
 /*
  * Send to the consumer a close metadata command for the given session. Once
  * done, the metadata channel is deleted and the session metadata pointer is
- * nullified. The session lock MUST be acquired here unless the application is
+ * nullified. The session lock MUST be held unless the application is
  * in the destroy path.
  *
  * Return 0 on success else a negative value.
diff --git a/src/bin/lttng-sessiond/ust-consumer.c b/src/bin/lttng-sessiond/ust-consumer.c
index f120144..611b54d 100644
--- a/src/bin/lttng-sessiond/ust-consumer.c
+++ b/src/bin/lttng-sessiond/ust-consumer.c
@@ -448,12 +448,12 @@ int ust_consumer_metadata_request(struct consumer_socket *socket)
 	assert(socket);
 
 	rcu_read_lock();
-	pthread_mutex_lock(socket->lock);
-
 	health_code_update();
 
 	/* Wait for a metadata request */
+	pthread_mutex_lock(socket->lock);
 	ret = consumer_socket_recv(socket, &request, sizeof(request));
+	pthread_mutex_unlock(socket->lock);
 	if (ret < 0) {
 		goto end;
 	}
@@ -488,7 +488,9 @@ int ust_consumer_metadata_request(struct consumer_socket *socket)
 	}
 	assert(ust_reg);
 
+	pthread_mutex_lock(&ust_reg->lock);
 	ret_push = ust_app_push_metadata(ust_reg, socket, 1);
+	pthread_mutex_unlock(&ust_reg->lock);
 	if (ret_push < 0) {
 		ERR("Pushing metadata");
 		ret = -1;
@@ -498,7 +500,6 @@ int ust_consumer_metadata_request(struct consumer_socket *socket)
 	ret = 0;
 
 end:
-	pthread_mutex_unlock(socket->lock);
 	rcu_read_unlock();
 	return ret;
 }
diff --git a/src/bin/lttng-sessiond/ust-registry.h b/src/bin/lttng-sessiond/ust-registry.h
index f195b74..0cba8a3 100644
--- a/src/bin/lttng-sessiond/ust-registry.h
+++ b/src/bin/lttng-sessiond/ust-registry.h
@@ -33,8 +33,12 @@ struct ust_app;
 
 struct ust_registry_session {
 	/*
-	 * With multiple writers and readers, use this lock to access the registry.
-	 * Can nest within the ust app session lock.
+	 * With multiple writers and readers, use this lock to access
+	 * the registry. Can nest within the ust app session lock.
+	 * Also acts as a registry serialization lock. Used by registry
+	 * readers to serialize the registry information sent from the
+	 * sessiond to the consumerd.
+	 * The consumer socket lock nests within this lock.
 	 */
 	pthread_mutex_t lock;
 	/* Next channel ID available for a newly registered channel. */
@@ -63,11 +67,13 @@ struct ust_registry_session {
 	/* Length of bytes sent to the consumer. */
 	size_t metadata_len_sent;
 	/*
-	 * Hash table containing channels sent by the UST tracer. MUST be accessed
-	 * with a RCU read side lock acquired.
+	 * Hash table containing channels sent by the UST tracer. MUST
+	 * be accessed with a RCU read side lock acquired.
 	 */
 	struct lttng_ht *channels;
-	/* Unique key to identify the metadata on the consumer side. */
+	/*
+	 * Unique key to identify the metadata on the consumer side.
+	 */
 	uint64_t metadata_key;
 	/*
 	 * Indicates if the metadata is closed on the consumer side. This is to
-- 
2.1.1
