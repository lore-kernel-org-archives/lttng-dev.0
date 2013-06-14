From: David Goulet <dgoulet@efficios.com>
Subject: [PATCH lttng-tools] Fix: sanitize wait queue in the
	dispatch thread
Date: Fri, 14 Jun 2013 10:39:43 -0400
Message-ID: <1371220783-5652-1-git-send-email-dgoulet__42074.062411166$1371220878$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UnVBA-0004Ej-6I
	for lttng-dev@lists.lttng.org; Fri, 14 Jun 2013 10:40:40 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is to avoid memory leaks when the notify socket is never received
thus cleaning the wait node for command socket that are invalid.

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: David Goulet <dgoulet@efficios.com>
---
 src/bin/lttng-sessiond/lttng-sessiond.h |   18 +++++
 src/bin/lttng-sessiond/main.c           |  111 ++++++++++++++++++++++++++++---
 src/bin/lttng-sessiond/ust-app.c        |   12 ++++
 src/bin/lttng-sessiond/ust-app.h        |    6 ++
 4 files changed, 139 insertions(+), 8 deletions(-)

diff --git a/src/bin/lttng-sessiond/lttng-sessiond.h b/src/bin/lttng-sessiond/lttng-sessiond.h
index 6090e08..aeb0303 100644
--- a/src/bin/lttng-sessiond/lttng-sessiond.h
+++ b/src/bin/lttng-sessiond/lttng-sessiond.h
@@ -66,6 +66,24 @@ struct ust_cmd_queue {
 };
 
 /*
+ * This is the wait queue containing wait nodes during the application
+ * registration process.
+ */
+struct ust_reg_wait_queue {
+	unsigned long count;
+	struct cds_list_head head;
+};
+
+/*
+ * Use by the dispatch registration to queue UST command socket to wait for the
+ * notify socket.
+ */
+struct ust_reg_wait_node {
+	struct ust_app *app;
+	struct cds_list_head head;
+};
+
+/*
  * This pipe is used to inform the thread managing application notify
  * communication that a command is queued and ready to be processed.
  */
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 007c722..14bdaf6 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -1335,6 +1335,91 @@ error:
 }
 
 /*
+ * Sanitize the wait queue of the dispatch registration thread meaning removing
+ * invalid nodes from it. This is to avoid memory leaks for the case the UST
+ * notify socket is never received.
+ */
+void sanitize_wait_queue(struct ust_reg_wait_queue *wait_queue)
+{
+	int ret, nb_fd = 0, i;
+	unsigned int fd_added = 0;
+	struct lttng_poll_event events;
+	struct ust_reg_wait_node *wait_node = NULL, *tmp_wait_node;
+
+	assert(wait_queue);
+
+	lttng_poll_init(&events);
+
+	/* Just skip everything for an empty queue. */
+	if (!wait_queue->count) {
+		goto end;
+	}
+
+	ret = lttng_poll_create(&events, wait_queue->count, LTTNG_CLOEXEC);
+	if (ret < 0) {
+		goto error_create;
+	}
+
+	cds_list_for_each_entry_safe(wait_node, tmp_wait_node,
+			&wait_queue->head, head) {
+		assert(wait_node->app);
+		ret = lttng_poll_add(&events, wait_node->app->sock,
+				LPOLLHUP | LPOLLERR);
+		if (ret < 0) {
+			goto error;
+		}
+
+		fd_added = 1;
+	}
+
+	if (!fd_added) {
+		goto end;
+	}
+
+	/*
+	 * Poll but don't block so we can quickly identify the faulty events and
+	 * clean them afterwards from the wait queue.
+	 */
+	ret = lttng_poll_wait(&events, 0);
+	if (ret < 0) {
+		goto error;
+	}
+	nb_fd = ret;
+
+	for (i = 0; i < nb_fd; i++) {
+		/* Get faulty FD. */
+		uint32_t revents = LTTNG_POLL_GETEV(&events, i);
+		int pollfd = LTTNG_POLL_GETFD(&events, i);
+
+		cds_list_for_each_entry_safe(wait_node, tmp_wait_node,
+				&wait_queue->head, head) {
+			if (pollfd == wait_node->app->sock &&
+					(revents & (LPOLLHUP | LPOLLERR))) {
+				cds_list_del(&wait_node->head);
+				wait_queue->count--;
+				ust_app_destroy(wait_node->app);
+				free(wait_node);
+				break;
+			}
+		}
+	}
+
+	if (nb_fd > 0) {
+		DBG("Wait queue sanitized, %d node were cleaned up", nb_fd);
+	}
+
+end:
+	lttng_poll_clean(&events);
+	return;
+
+error:
+	lttng_poll_clean(&events);
+error_create:
+	ERR("Unable to sanitize wait queue");
+	return;
+}
+
+/*
  * Dispatch request from the registration threads to the application
  * communication thread.
  */
@@ -1343,16 +1428,16 @@ static void *thread_dispatch_ust_registration(void *data)
 	int ret, err = -1;
 	struct cds_wfq_node *node;
 	struct ust_command *ust_cmd = NULL;
-	struct {
-		struct ust_app *app;
-		struct cds_list_head head;
-	} *wait_node = NULL, *tmp_wait_node;
+	struct ust_reg_wait_node *wait_node = NULL, *tmp_wait_node;
+	struct ust_reg_wait_queue wait_queue = {
+		.count = 0,
+	};
 
 	health_register(HEALTH_TYPE_APP_REG_DISPATCH);
 
 	health_code_update();
 
-	CDS_LIST_HEAD(wait_queue);
+	CDS_INIT_LIST_HEAD(&wait_queue.head);
 
 	DBG("[thread] Dispatch UST command started");
 
@@ -1366,6 +1451,13 @@ static void *thread_dispatch_ust_registration(void *data)
 			struct ust_app *app = NULL;
 			ust_cmd = NULL;
 
+			/*
+			 * Make sure we don't have node(s) that have hung up before receiving
+			 * the notify socket. This is to clean the list in order to avoid
+			 * memory leaks from notify socket that are never seen.
+			 */
+			sanitize_wait_queue(&wait_queue);
+
 			health_code_update();
 			/* Dequeue command for registration */
 			node = cds_wfq_dequeue_blocking(&ust_cmd_queue.queue);
@@ -1415,7 +1507,8 @@ static void *thread_dispatch_ust_registration(void *data)
 				 * Add application to the wait queue so we can set the notify
 				 * socket before putting this object in the global ht.
 				 */
-				cds_list_add(&wait_node->head, &wait_queue);
+				cds_list_add(&wait_node->head, &wait_queue.head);
+				wait_queue.count++;
 
 				free(ust_cmd);
 				/*
@@ -1430,11 +1523,12 @@ static void *thread_dispatch_ust_registration(void *data)
 				 * notify socket if found.
 				 */
 				cds_list_for_each_entry_safe(wait_node, tmp_wait_node,
-						&wait_queue, head) {
+						&wait_queue.head, head) {
 					health_code_update();
 					if (wait_node->app->pid == ust_cmd->reg_msg.pid) {
 						wait_node->app->notify_sock = ust_cmd->sock;
 						cds_list_del(&wait_node->head);
+						wait_queue.count--;
 						app = wait_node->app;
 						free(wait_node);
 						DBG3("UST app notify socket %d is set", ust_cmd->sock);
@@ -1529,8 +1623,9 @@ static void *thread_dispatch_ust_registration(void *data)
 error:
 	/* Clean up wait queue. */
 	cds_list_for_each_entry_safe(wait_node, tmp_wait_node,
-			&wait_queue, head) {
+			&wait_queue.head, head) {
 		cds_list_del(&wait_node->head);
+		wait_queue.count--;
 		free(wait_node);
 	}
 
diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 37f6442..12ea705 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -4806,3 +4806,15 @@ close_socket:
 		call_rcu(&obj->head, close_notify_sock_rcu);
 	}
 }
+
+/*
+ * Destroy a ust app data structure and free its memory.
+ */
+void ust_app_destroy(struct ust_app *app)
+{
+	if (!app) {
+		return;
+	}
+
+	call_rcu(&app->pid_n.head, delete_ust_app_rcu);
+}
diff --git a/src/bin/lttng-sessiond/ust-app.h b/src/bin/lttng-sessiond/ust-app.h
index 6e6ff02..30835e0 100644
--- a/src/bin/lttng-sessiond/ust-app.h
+++ b/src/bin/lttng-sessiond/ust-app.h
@@ -305,6 +305,7 @@ struct ust_app *ust_app_create(struct ust_register_msg *msg, int sock);
 void ust_app_notify_sock_unregister(int sock);
 ssize_t ust_app_push_metadata(struct ust_registry_session *registry,
 		struct consumer_socket *socket, int send_zero_data);
+void ust_app_destroy(struct ust_app *app);
 
 #else /* HAVE_LIBLTTNG_UST_CTL */
 
@@ -497,6 +498,11 @@ ssize_t ust_app_push_metadata(struct ust_registry_session *registry,
 {
 	return 0;
 }
+static inline
+void ust_app_destroy(struct ust_app *app)
+{
+	return;
+}
 
 #endif /* HAVE_LIBLTTNG_UST_CTL */
 
-- 
1.7.10.4
