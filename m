From: Paul Woegerer <paul_woegerer@mentor.com>
Subject: [PATCH lttng-ust v2] Fix: baddr_statedump deadlock with
	JUL tracing
Date: Fri, 29 Nov 2013 14:32:54 +0100
Message-ID: <1385731974-12135-2-git-send-email-paul_woegerer__13089.297960005$1385732115$gmane$org@mentor.com>
References: <1385731974-12135-1-git-send-email-paul_woegerer@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1VmOC8-000220-So
	for lttng-dev@lists.lttng.org; Fri, 29 Nov 2013 08:33:23 -0500
In-Reply-To: <1385731974-12135-1-git-send-email-paul_woegerer@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
---
 include/lttng/ust-events.h       |  6 ++++++
 liblttng-ust/lttng-events.c      | 19 ++++++++++++++++++-
 liblttng-ust/lttng-tracer-core.h |  3 +--
 liblttng-ust/lttng-ust-comm.c    | 30 +++++++++++++++++-------------
 4 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/include/lttng/ust-events.h b/include/lttng/ust-events.h
index 5d43570..28f7391 100644
--- a/include/lttng/ust-events.h
+++ b/include/lttng/ust-events.h
@@ -513,6 +513,9 @@ struct lttng_session {
 	struct lttng_ust_event_ht events_ht;	/* ht of events */
 	void *owner;				/* object owner */
 	int tstate:1;				/* Transient enable state */
+
+	/* New UST 2.4 */
+	int statedump_pending:1;
 };
 
 struct lttng_transport {
@@ -606,4 +609,7 @@ void lttng_filter_sync_state(struct lttng_bytecode_runtime *runtime);
 struct cds_list_head *lttng_get_probe_list_head(void);
 int lttng_session_active(void);
 
+typedef int (*t_statedump_func_ptr)(struct lttng_session *session);
+int lttng_handle_pending_statedumps(t_statedump_func_ptr statedump_func_ptr);
+
 #endif /* _LTTNG_UST_EVENTS_H */
diff --git a/liblttng-ust/lttng-events.c b/liblttng-ust/lttng-events.c
index 7751584..9380e9c 100644
--- a/liblttng-ust/lttng-events.c
+++ b/liblttng-ust/lttng-events.c
@@ -294,7 +294,8 @@ int lttng_session_enable(struct lttng_session *session)
 	CMM_ACCESS_ONCE(session->active) = 1;
 	CMM_ACCESS_ONCE(session->been_active) = 1;
 
-	lttng_ust_sockinfo_session_enabled(session->owner, session);
+	session->statedump_pending = 1;
+	lttng_ust_sockinfo_session_enabled(session->owner);
 end:
 	return ret;
 }
@@ -675,6 +676,22 @@ int lttng_fix_pending_events(void)
 }
 
 /*
+ * Called after session enable: For each session, execute pending statedumps.
+ */
+int lttng_handle_pending_statedumps(t_statedump_func_ptr statedump_func_ptr)
+{
+	struct lttng_session *session;
+
+	cds_list_for_each_entry(session, &sessions, node) {
+		if (session->statedump_pending) {
+			session->statedump_pending = 0;
+			statedump_func_ptr(session);
+		}
+	}
+	return 0;
+}
+
+/*
  * Only used internally at session destruction.
  */
 static
diff --git a/liblttng-ust/lttng-tracer-core.h b/liblttng-ust/lttng-tracer-core.h
index e7f549e..57df175 100644
--- a/liblttng-ust/lttng-tracer-core.h
+++ b/liblttng-ust/lttng-tracer-core.h
@@ -45,7 +45,6 @@ const char *lttng_ust_obj_get_name(int id);
 
 int lttng_get_notify_socket(void *owner);
 
-void lttng_ust_sockinfo_session_enabled(void *owner,
-		struct lttng_session *session_enabled);
+void lttng_ust_sockinfo_session_enabled(void *owner);
 
 #endif /* _LTTNG_TRACER_CORE_H */
diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index b99bf00..4724fab 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -108,7 +108,7 @@ struct sock_info {
 
 	char wait_shm_path[PATH_MAX];
 	char *wait_shm_mmap;
-	struct lttng_session *session_enabled;
+	int session_enabled;
 };
 
 /* Socket from app (connect) to session daemon (listen) for communication */
@@ -126,7 +126,7 @@ struct sock_info global_apps = {
 
 	.wait_shm_path = "/" LTTNG_UST_WAIT_FILENAME,
 
-	.session_enabled = NULL,
+	.session_enabled = 0,
 };
 
 /* TODO: allow global_apps_sock_path override */
@@ -141,7 +141,7 @@ struct sock_info local_apps = {
 	.socket = -1,
 	.notify_socket = -1,
 
-	.session_enabled = NULL,
+	.session_enabled = 0,
 };
 
 static int wait_poll_fallback;
@@ -709,6 +709,17 @@ error:
 }
 
 static
+void handle_pending_statedumps(struct sock_info *sock_info)
+{
+	int ctor_passed = sock_info->constructor_sem_posted;
+
+	if (ctor_passed && sock_info->session_enabled) {
+		sock_info->session_enabled = 0;
+		lttng_handle_pending_statedumps(&lttng_ust_baddr_statedump);
+	}
+}
+
+static
 void cleanup_sock_info(struct sock_info *sock_info, int exiting)
 {
 	int ret;
@@ -1214,13 +1225,7 @@ restart:
 			if (ret) {
 				ERR("Error handling message for %s socket", sock_info->name);
 			} else {
-				struct lttng_session *session;
-
-				session = sock_info->session_enabled;
-				if (session) {
-					sock_info->session_enabled = NULL;
-					lttng_ust_baddr_statedump(session);
-				}
+				handle_pending_statedumps(sock_info);
 			}
 			continue;
 		default:
@@ -1535,9 +1540,8 @@ void ust_after_fork_child(sigset_t *restore_sigset)
 	lttng_ust_init();
 }
 
-void lttng_ust_sockinfo_session_enabled(void *owner,
-		struct lttng_session *session_enabled)
+void lttng_ust_sockinfo_session_enabled(void *owner)
 {
 	struct sock_info *sock_info = owner;
-	sock_info->session_enabled = session_enabled;
+	sock_info->session_enabled = 1;
 }
-- 
1.8.4
