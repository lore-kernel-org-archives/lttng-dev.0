From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Fix: Proper teardown of
	thread_manage_clients on failure of listen/create_poll
Date: Tue,  6 Nov 2012 17:00:53 -0500
Message-ID: <1352239253-8665-1-git-send-email-christian.babeux__46270.6500351944$1352239315$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TVrCu-0002S7-7h
	for lttng-dev@lists.lttng.org; Tue, 06 Nov 2012 17:01:16 -0500
Received: by mail-ie0-f176.google.com with SMTP id k11so1587253iea.35
	for <lttng-dev@lists.lttng.org>; Tue, 06 Nov 2012 14:01:11 -0800 (PST)
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

Currently, if the call to lttcomm_listen_unix_sock or create_thread_poll_set
fails, the error handling and thread teardown code path is triggered via a
jump to an error label. This error handling path closes the sockets that
were used and cleanup the poll set. If the listen fails, the poll set will
tentatively be cleaned even though it has never been initialized.

This patch add 2 labels to differentiate the error handling paths needed
in case of failure of lttcomm_listen_unix_sock or create_thread_poll_set.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 src/bin/lttng-sessiond/main.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index ce2213c..39a2a41 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -3062,7 +3062,7 @@ static void *thread_manage_clients(void *data)
 
 	ret = lttcomm_listen_unix_sock(client_sock);
 	if (ret < 0) {
-		goto error;
+		goto error_listen;
 	}
 
 	/*
@@ -3071,7 +3071,7 @@ static void *thread_manage_clients(void *data)
 	 */
 	ret = create_thread_poll_set(&events, 2);
 	if (ret < 0) {
-		goto error;
+		goto error_create_poll;
 	}
 
 	/* Add the application registration socket */
@@ -3244,13 +3244,6 @@ static void *thread_manage_clients(void *data)
 
 exit:
 error:
-	if (err) {
-		health_error(&health_thread_cmd);
-		ERR("Health error occurred in %s", __func__);
-	}
-	health_exit(&health_thread_cmd);
-
-	DBG("Client thread dying");
 	unlink(client_unix_sock_path);
 	if (client_sock >= 0) {
 		ret = close(client_sock);
@@ -3268,6 +3261,16 @@ error:
 	lttng_poll_clean(&events);
 	clean_command_ctx(&cmd_ctx);
 
+error_listen:
+error_create_poll:
+	if (err) {
+		health_error(&health_thread_cmd);
+		ERR("Health error occurred in %s", __func__);
+	}
+	health_exit(&health_thread_cmd);
+
+	DBG("Client thread dying");
+
 	rcu_unregister_thread();
 	return NULL;
 }
-- 
1.8.0
