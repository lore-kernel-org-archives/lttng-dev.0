From: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
Subject: [PATCH lttng-ust v2] Fix: wait for initial statedump
 before proceeding to the main program
Date: Mon, 29 Jul 2019 18:05:35 -0400
Message-ID: <20190729220535.26748-1-gabriel.pollo-guilbert__125.087604259022$1564438002$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45yDKr3FFwz1GKC
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 18:06:24 -0400 (EDT)
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

In the case of short lived applications, the application may exit before
the initial statedump has completed.

Higher-level trace analysis features such as translating addresses to
symbols rely on statedump. That information is required for those
analyses to work on such short-lived applications.

Force the statedump to occur before handing the control to the
application.

Fixes #1190

Signed-off-by: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
v2:
	* renamed constructor_sem_posted -> registration_done
	* add sem_count_initial_value
	* add assert in decrement_sem_count()
	* edit documentation for handle_pending_statedump
	* reset registration_done and initial_statedump_done in cleanup_sock_info

 liblttng-ust/lttng-ust-comm.c | 88 ++++++++++++++++++++++++++---------
 1 file changed, 67 insertions(+), 21 deletions(-)

diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index a299ba84..0c6db9fe 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -228,7 +228,11 @@ static sem_t constructor_wait;
 /*
  * Doing this for both the global and local sessiond.
  */
-static int sem_count = { 2 };
+enum {
+	sem_count_initial_value = 4,
+};
+
+static int sem_count = sem_count_initial_value;
 
 /*
  * Counting nesting within lttng-ust. Used to ensure that calling fork()
@@ -243,7 +247,7 @@ struct sock_info {
 	const char *name;
 	pthread_t ust_listener;	/* listener thread */
 	int root_handle;
-	int constructor_sem_posted;
+	int registration_done;
 	int allowed;
 	int global;
 	int thread_active;
@@ -256,6 +260,7 @@ struct sock_info {
 	char *wait_shm_mmap;
 	/* Keep track of lazy state dump not performed yet. */
 	int statedump_pending;
+	int initial_statedump_done;
 };
 
 /* Socket from app (connect) to session daemon (listen) for communication */
@@ -264,6 +269,7 @@ struct sock_info global_apps = {
 	.global = 1,
 
 	.root_handle = -1,
+	.registration_done = 0,
 	.allowed = 0,
 	.thread_active = 0,
 
@@ -274,6 +280,7 @@ struct sock_info global_apps = {
 	.wait_shm_path = "/" LTTNG_UST_WAIT_FILENAME,
 
 	.statedump_pending = 0,
+	.initial_statedump_done = 0,
 };
 
 /* TODO: allow global_apps_sock_path override */
@@ -282,6 +289,7 @@ struct sock_info local_apps = {
 	.name = "local",
 	.global = 0,
 	.root_handle = -1,
+	.registration_done = 0,
 	.allowed = 0,	/* Check setuid bit first */
 	.thread_active = 0,
 
@@ -289,6 +297,7 @@ struct sock_info local_apps = {
 	.notify_socket = -1,
 
 	.statedump_pending = 0,
+	.initial_statedump_done = 0,
 };
 
 static int wait_poll_fallback;
@@ -621,45 +630,81 @@ int send_reply(int sock, struct ustcomm_ust_reply *lur)
 }
 
 static
-int handle_register_done(struct sock_info *sock_info)
+void decrement_sem_count(unsigned int count)
 {
 	int ret;
 
-	if (sock_info->constructor_sem_posted)
-		return 0;
-	sock_info->constructor_sem_posted = 1;
+	assert(uatomic_read(&sem_count) >= count);
+
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
+	if (sock_info->registration_done)
+		return 0;
+	sock_info->registration_done = 1;
+
+	decrement_sem_count(1);
+
+	return 0;
+}
+
+static
+int handle_register_failed(struct sock_info *sock_info)
+{
+	if (sock_info->registration_done)
+		return 0;
+	sock_info->registration_done = 1;
+	sock_info->initial_statedump_done = 1;
+
+	decrement_sem_count(2);
+
 	return 0;
 }
 
 /*
  * Only execute pending statedump after the constructor semaphore has
- * been posted by each listener thread. This means statedump will only
- * be performed after the "registration done" command is received from
- * each session daemon the application is connected to.
+ * been posted by the current listener thread. This means statedump will
+ * only be performed after the "registration done" command is received
+ * from this thread's session daemon.
  *
  * This ensures we don't run into deadlock issues with the dynamic
  * loader mutex, which is held while the constructor is called and
  * waiting on the constructor semaphore. All operations requiring this
  * dynamic loader lock need to be postponed using this mechanism.
+ *
+ * In a scenario with two session daemons connected to the application,
+ * it is possible that the first listener thread which receives the
+ * registration done command issues its statedump while the dynamic
+ * loader lock is still held by the application constructor waiting on
+ * the semaphore. It will however be allowed to proceed when the
+ * second session daemon sends the registration done command to the
+ * second listener thread. This situation therefore does not produce
+ * a deadlock.
  */
 static
 void handle_pending_statedump(struct sock_info *sock_info)
 {
-	int ctor_passed = sock_info->constructor_sem_posted;
-
-	if (ctor_passed && sock_info->statedump_pending) {
+	if (sock_info->registration_done && sock_info->statedump_pending) {
 		sock_info->statedump_pending = 0;
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
 
@@ -1069,7 +1114,8 @@ void cleanup_sock_info(struct sock_info *sock_info, int exiting)
 		}
 		sock_info->root_handle = -1;
 	}
-	sock_info->constructor_sem_posted = 0;
+	sock_info->registration_done = 0;
+	sock_info->initial_statedump_done = 0;
 
 	/*
 	 * wait_shm_mmap, socket and notify socket are used by listener
@@ -1477,7 +1523,7 @@ restart:
 		 * If we cannot find the sessiond daemon, don't delay
 		 * constructor execution.
 		 */
-		ret = handle_register_done(sock_info);
+		ret = handle_register_failed(sock_info);
 		assert(!ret);
 		ust_unlock();
 		goto restart;
@@ -1531,7 +1577,7 @@ restart:
 		 * If we cannot register to the sessiond daemon, don't
 		 * delay constructor execution.
 		 */
-		ret = handle_register_done(sock_info);
+		ret = handle_register_failed(sock_info);
 		assert(!ret);
 		ust_unlock();
 		goto restart;
@@ -1560,7 +1606,7 @@ restart:
 		 * If we cannot find the sessiond daemon, don't delay
 		 * constructor execution.
 		 */
-		ret = handle_register_done(sock_info);
+		ret = handle_register_failed(sock_info);
 		assert(!ret);
 		ust_unlock();
 		goto restart;
@@ -1624,7 +1670,7 @@ restart:
 		 * If we cannot register to the sessiond daemon, don't
 		 * delay constructor execution.
 		 */
-		ret = handle_register_done(sock_info);
+		ret = handle_register_failed(sock_info);
 		assert(!ret);
 		ust_unlock();
 		goto restart;
@@ -1654,7 +1700,7 @@ restart:
 			 * If we cannot register to the sessiond daemon, don't
 			 * delay constructor execution.
 			 */
-			ret = handle_register_done(sock_info);
+			ret = handle_register_failed(sock_info);
 			assert(!ret);
 			ust_unlock();
 			goto end;
@@ -1923,7 +1969,7 @@ void lttng_ust_cleanup(int exiting)
 	exit_tracepoint();
 	if (!exiting) {
 		/* Reinitialize values for fork */
-		sem_count = 2;
+		sem_count = sem_count_initial_value;
 		lttng_ust_comm_should_quit = 0;
 		initialized = 0;
 	}
-- 
2.22.0
