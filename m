From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools 3/3] Fix: sessiond: ust: deadlock
 with per-pid buffers
Date: Fri,  1 Nov 2019 16:23:05 -0400
Message-ID: <20191101202305.21496-3-mathieu.desnoyers__49833.8739898585$1572639877$gmane$org@efficios.com>
References: <20191101202305.21496-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 474YY04ydnzrVc
 for <lttng-dev@lists.lttng.org>; Fri,  1 Nov 2019 16:23:16 -0400 (EDT)
In-Reply-To: <20191101202305.21496-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Do not hold the registry lock while communicating with the consumerd,
because doing so causes inter-process deadlocks between consumerd and
sessiond with the metadata request notification.

The deadlock involves both sessiond and consumerd:

* lttng-sessiond:

thread 11 - thread_application_management

close_metadata()
  pthread_mutex_lock(&registry->lock);
  consumer_close_metadata()
    pthread_mutex_lock(socket->lock);

thread 15 - thread_consumer_management

ust_consumer_metadata_request()
  pthread_mutex_lock(&ust_reg->lock);

thread 8 - thread_manage_clients

consumer_is_data_pending
  pthread_mutex_lock(socket->lock);
  consumer_socket_recv()

* lttng-consumerd:

thread 4 - consumer_timer_thread

sample_channel_positions()
  pthread_mutex_lock(&stream->lock);

thread 8 - consumer_thread_sessiond_poll
  consumer_data_pending
  pthread_mutex_lock(&consumer_data.lock);
  pthread_mutex_lock(&stream->lock);

thread 7 - consumer_thread_data_poll

lttng_consumer_read_subbuffer
  pthread_mutex_lock(&stream->chan->lock);
  pthread_mutex_lock(&stream->lock);
  do_sync_metadata
    pthread_mutex_lock(&metadata->lock);
    lttng_ustconsumer_sync_metadata
      pthread_mutex_unlock(&metadata_stream->lock);
      lttng_ustconsumer_request_metadata()
        pthread_mutex_lock(&ctx->metadata_socket_lock);
        lttcomm_recv_unix_sock()

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/ust-app.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 1731c368..1ecff438 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -741,6 +741,10 @@ error:
  * nullified. The session lock MUST be held unless the application is
  * in the destroy path.
  *
+ * Do not hold the registry lock while communicating with the consumerd, because
+ * doing so causes inter-process deadlocks between consumerd and sessiond with
+ * the metadata request notification.
+ *
  * Return 0 on success else a negative value.
  */
 static int close_metadata(struct ust_registry_session *registry,
@@ -748,6 +752,7 @@ static int close_metadata(struct ust_registry_session *registry,
 {
 	int ret;
 	struct consumer_socket *socket;
+	uint64_t metadata_key;
 
 	assert(registry);
 	assert(consumer);
@@ -755,34 +760,34 @@ static int close_metadata(struct ust_registry_session *registry,
 	rcu_read_lock();
 
 	pthread_mutex_lock(&registry->lock);
-
-	if (!registry->metadata_key || registry->metadata_closed) {
+	metadata_key = registry->metadata_key;
+	if (!metadata_key || registry->metadata_closed) {
 		ret = 0;
+		pthread_mutex_unlock(&registry->lock);
 		goto end;
 	}
+	/*
+	 * Metadata closed. Even on error this means that the consumer is not
+	 * responding or not found so either way a second close should NOT be emit
+	 * for this registry.
+	 */
+	registry->metadata_closed = 1;
+	pthread_mutex_unlock(&registry->lock);
 
 	/* Get consumer socket to use to push the metadata.*/
 	socket = consumer_find_socket_by_bitness(registry->bits_per_long,
 			consumer);
 	if (!socket) {
 		ret = -1;
-		goto error;
+		goto end;
 	}
 
-	ret = consumer_close_metadata(socket, registry->metadata_key);
+	ret = consumer_close_metadata(socket, metadata_key);
 	if (ret < 0) {
-		goto error;
+		goto end;
 	}
 
-error:
-	/*
-	 * Metadata closed. Even on error this means that the consumer is not
-	 * responding or not found so either way a second close should NOT be emit
-	 * for this registry.
-	 */
-	registry->metadata_closed = 1;
 end:
-	pthread_mutex_unlock(&registry->lock);
 	rcu_read_unlock();
 	return ret;
 }
-- 
2.17.1
