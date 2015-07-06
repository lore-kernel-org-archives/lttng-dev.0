From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH lttng-tools] Fix: metadata push -EPIPE
	should be recoverable
Date: Mon,  6 Jul 2015 12:21:06 -0400
Message-ID: <1436199666-10305-1-git-send-email-mathieu.desnoyers__25675.8807962344$1436199761$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZC98w-0008MA-OQ
 for lttng-dev@lists.lttng.org; Mon, 06 Jul 2015 12:21:27 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: Aravind HT <aravind.ht@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This return value can be caused by application terminating concurrently
(when using per-PID buffers), so it should not make the consumer
management thread exit.

CC: Aravind HT <aravind.ht@gmail.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/ust-app.c      | 13 ++++++++++---
 src/bin/lttng-sessiond/ust-consumer.c |  7 +++++--
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index c30792c..6f032da 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -431,6 +431,9 @@ void delete_ust_app_channel(int sock, struct ust_app_channel *ua_chan,
  * Must be called with the registry lock held.
  *
  * On success, return the len of metadata pushed or else a negative value.
+ * Returning a -EPIPE return value means we could not send the metadata,
+ * but it can be caused by recoverable errors (e.g. the application has
+ * terminated concurrently).
  */
 ssize_t ust_app_push_metadata(struct ust_registry_session *registry,
 		struct consumer_socket *socket, int send_zero_data)
@@ -454,9 +457,10 @@ ssize_t ust_app_push_metadata(struct ust_registry_session *registry,
 	/*
 	 * On a push metadata error either the consumer is dead or the
 	 * metadata channel has been destroyed because its endpoint
-	 * might have died (e.g: relayd). If so, the metadata closed
-	 * flag is set to 1 so we deny pushing metadata again which is
-	 * not valid anymore on the consumer side.
+	 * might have died (e.g: relayd), or because the application has
+	 * exited. If so, the metadata closed flag is set to 1 so we
+	 * deny pushing metadata again which is not valid anymore on the
+	 * consumer side.
 	 */
 	if (registry->metadata_closed) {
 		return -EPIPE;
@@ -547,6 +551,9 @@ error_push:
  * of socket throughout this function.
  *
  * Return 0 on success else a negative error.
+ * Returning a -EPIPE return value means we could not send the metadata,
+ * but it can be caused by recoverable errors (e.g. the application has
+ * terminated concurrently).
  */
 static int push_metadata(struct ust_registry_session *registry,
 		struct consumer_output *consumer)
diff --git a/src/bin/lttng-sessiond/ust-consumer.c b/src/bin/lttng-sessiond/ust-consumer.c
index 78e50df..ad076e3 100644
--- a/src/bin/lttng-sessiond/ust-consumer.c
+++ b/src/bin/lttng-sessiond/ust-consumer.c
@@ -511,12 +511,15 @@ int ust_consumer_metadata_request(struct consumer_socket *socket)
 	pthread_mutex_lock(&ust_reg->lock);
 	ret_push = ust_app_push_metadata(ust_reg, socket, 1);
 	pthread_mutex_unlock(&ust_reg->lock);
-	if (ret_push < 0) {
+	if (ret_push == -EPIPE) {
+		DBG("Application or relay closed while pushing metadata");
+	} else if (ret_push < 0) {
 		ERR("Pushing metadata");
 		ret = -1;
 		goto end;
+	} else {
+		DBG("UST Consumer metadata pushed successfully");
 	}
-	DBG("UST Consumer metadata pushed successfully");
 	ret = 0;
 
 end:
-- 
2.1.4
