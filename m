From: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
Subject: [PATCH lttng-ust] Fix: wait for initial statedump
 before proceding to the main program
Date: Tue, 16 Jul 2019 14:15:15 -0400
Message-ID: <20190716181515.12702-1-gabriel.pollo-guilbert__11032.7227086358$1563300971$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45p7qv17l3z17W6
 for <lttng-dev@lists.lttng.org>; Tue, 16 Jul 2019 14:15:54 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

In the case of short lived applications, a race condition may occur before
the initial statedump is done and the end of the application. We force the
statedump to occur before handing the control to the application.

fixes #1190

Signed-off-by: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
---
 liblttng-ust/lttng-ust-comm.c | 54 +++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index 61dbb41b..5d0e4a99 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -228,7 +228,7 @@ static sem_t constructor_wait;
 /*
  * Doing this for both the global and local sessiond.
  */
-static int sem_count = { 2 };
+static int sem_count = 4;
 
 /*
  * Counting nesting within lttng-ust. Used to ensure that calling fork()
@@ -256,6 +256,7 @@ struct sock_info {
 	char *wait_shm_mmap;
 	/* Keep track of lazy state dump not performed yet. */
 	int statedump_pending;
+	int initial_statedump_done;
 };
 
 /* Socket from app (connect) to session daemon (listen) for communication */
@@ -274,6 +275,7 @@ struct sock_info global_apps = {
 	.wait_shm_path = "/" LTTNG_UST_WAIT_FILENAME,
 
 	.statedump_pending = 0,
+	.initial_statedump_done = 0,
 };
 
 /* TODO: allow global_apps_sock_path override */
@@ -289,6 +291,7 @@ struct sock_info local_apps = {
 	.notify_socket = -1,
 
 	.statedump_pending = 0,
+	.initial_statedump_done = 0,
 };
 
 static int wait_poll_fallback;
@@ -621,21 +624,43 @@ int send_reply(int sock, struct ustcomm_ust_reply *lur)
 }
 
 static
-int handle_register_done(struct sock_info *sock_info)
+void decrement_sem_count(unsigned count)
 {
 	int ret;
 
-	if (sock_info->constructor_sem_posted)
-		return 0;
-	sock_info->constructor_sem_posted = 1;
 	if (uatomic_read(&sem_count) <= 0) {
-		return 0;
+		return;
 	}
-	ret = uatomic_add_return(&sem_count, -1);
+
+	ret = uatomic_add_return(&sem_count, -count);
 	if (ret == 0) {
 		ret = sem_post(&constructor_wait);
 		assert(!ret);
 	}
+}
+
+static
+int handle_register_done(struct sock_info *sock_info)
+{
+	if (sock_info->constructor_sem_posted)
+		return 0;
+	sock_info->constructor_sem_posted = 1;
+
+	decrement_sem_count(1);
+
+	return 0;
+}
+
+static
+int handle_register_failed(struct sock_info *sock_info)
+{
+	if (sock_info->constructor_sem_posted)
+		return 0;
+	sock_info->constructor_sem_posted = 1;
+	sock_info->initial_statedump_done = 1;
+
+	decrement_sem_count(2);
+
 	return 0;
 }
 
@@ -660,6 +685,11 @@ void handle_pending_statedump(struct sock_info *sock_info)
 		pthread_mutex_lock(&ust_fork_mutex);
 		lttng_handle_pending_statedump(sock_info);
 		pthread_mutex_unlock(&ust_fork_mutex);
+
+		if (!sock_info->initial_statedump_done) {
+			sock_info->initial_statedump_done = 1;
+			decrement_sem_count(1);
+		}
 	}
 }
 
@@ -1476,7 +1506,7 @@ restart:
 		 * If we cannot find the sessiond daemon, don't delay
 		 * constructor execution.
 		 */
-		ret = handle_register_done(sock_info);
+		ret = handle_register_failed(sock_info);
 		assert(!ret);
 		ust_unlock();
 		goto restart;
@@ -1530,7 +1560,7 @@ restart:
 		 * If we cannot register to the sessiond daemon, don't
 		 * delay constructor execution.
 		 */
-		ret = handle_register_done(sock_info);
+		ret = handle_register_failed(sock_info);
 		assert(!ret);
 		ust_unlock();
 		goto restart;
@@ -1559,7 +1589,7 @@ restart:
 		 * If we cannot find the sessiond daemon, don't delay
 		 * constructor execution.
 		 */
-		ret = handle_register_done(sock_info);
+		ret = handle_register_failed(sock_info);
 		assert(!ret);
 		ust_unlock();
 		goto restart;
@@ -1623,7 +1653,7 @@ restart:
 		 * If we cannot register to the sessiond daemon, don't
 		 * delay constructor execution.
 		 */
-		ret = handle_register_done(sock_info);
+		ret = handle_register_failed(sock_info);
 		assert(!ret);
 		ust_unlock();
 		goto restart;
@@ -1653,7 +1683,7 @@ restart:
 			 * If we cannot register to the sessiond daemon, don't
 			 * delay constructor execution.
 			 */
-			ret = handle_register_done(sock_info);
+			ret = handle_register_failed(sock_info);
 			assert(!ret);
 			ust_unlock();
 			goto end;
-- 
2.22.0
