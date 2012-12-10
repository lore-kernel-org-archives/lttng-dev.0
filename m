From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH v2 lttng-tools] Add return code to the testpoint
	mechanism
Date: Mon, 10 Dec 2012 15:38:39 -0500
Message-ID: <1355171919-13833-1-git-send-email-christian.babeux__11327.3399569609$1355171979$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TiA7q-0003J8-4M
	for lttng-dev@lists.lttng.org; Mon, 10 Dec 2012 15:38:54 -0500
Received: by mail-ia0-f176.google.com with SMTP id y26so1945275iab.35
	for <lttng-dev@lists.lttng.org>; Mon, 10 Dec 2012 12:38:48 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

The testpoint processing could fail and currently there is no mechanism
to notify the caller of such failures. This patch adds an int return code
to the testpoint prototype. Non-zero return code indicate failure.

When using the testpoint mechanism, the caller should properly handle
testpoint failure cases and trigger the appropriate response
(error handling, thread teardown, etc.).

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 src/bin/lttng-sessiond/main.c     | 44 ++++++++++++++++++++++++++++-----------
 src/common/testpoint/testpoint.h  | 20 +++++++++---------
 tests/tools/health/health_exit.c  | 20 +++++++++++++-----
 tests/tools/health/health_stall.c | 12 ++++++++---
 4 files changed, 66 insertions(+), 30 deletions(-)

diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index d5cfc0e..6110ee9 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -689,14 +689,14 @@ static void *thread_manage_kernel(void *data)
 	char tmp;
 	struct lttng_poll_event events;
 
-	DBG("Thread manage kernel started");
+	DBG("[thread] Thread manage kernel started");
 
-	testpoint(thread_manage_kernel);
+	if (testpoint(thread_manage_kernel)) {
+		goto error_testpoint;
+	}
 
 	health_code_update(&health_thread_kernel);
 
-	testpoint(thread_manage_kernel_before_loop);
-
 	ret = create_thread_poll_set(&events, 2);
 	if (ret < 0) {
 		goto error_poll_create;
@@ -707,6 +707,10 @@ static void *thread_manage_kernel(void *data)
 		goto error;
 	}
 
+	if (testpoint(thread_manage_kernel_before_loop)) {
+		goto error;
+	}
+
 	while (1) {
 		health_code_update(&health_thread_kernel);
 
@@ -794,6 +798,7 @@ exit:
 error:
 	lttng_poll_clean(&events);
 error_poll_create:
+error_testpoint:
 	utils_close_pipe(kernel_poll_pipe);
 	kernel_poll_pipe[0] = kernel_poll_pipe[1] = -1;
 	if (err) {
@@ -889,7 +894,9 @@ static void *thread_manage_consumer(void *data)
 restart:
 	health_poll_update(&consumer_data->health);
 
-	testpoint(thread_manage_consumer);
+	if (testpoint(thread_manage_consumer)) {
+		goto error;
+	}
 
 	ret = lttng_poll_wait(&events, -1);
 	health_poll_update(&consumer_data->health);
@@ -1093,11 +1100,13 @@ static void *thread_manage_apps(void *data)
 
 	DBG("[thread] Manage application started");
 
-	testpoint(thread_manage_apps);
-
 	rcu_register_thread();
 	rcu_thread_online();
 
+	if (testpoint(thread_manage_apps)) {
+		goto error_testpoint;
+	}
+
 	health_code_update(&health_thread_app_manage);
 
 	ret = create_thread_poll_set(&events, 2);
@@ -1110,7 +1119,9 @@ static void *thread_manage_apps(void *data)
 		goto error;
 	}
 
-	testpoint(thread_manage_apps_before_loop);
+	if (testpoint(thread_manage_apps_before_loop)) {
+		goto error;
+	}
 
 	health_code_update(&health_thread_app_manage);
 
@@ -1250,6 +1261,7 @@ exit:
 error:
 	lttng_poll_clean(&events);
 error_poll_create:
+error_testpoint:
 	utils_close_pipe(apps_cmd_pipe);
 	apps_cmd_pipe[0] = apps_cmd_pipe[1] = -1;
 
@@ -1358,7 +1370,9 @@ static void *thread_registration_apps(void *data)
 
 	DBG("[thread] Manage application registration started");
 
-	testpoint(thread_registration_apps);
+	if (testpoint(thread_registration_apps)) {
+		goto error_testpoint;
+	}
 
 	ret = lttcomm_listen_unix_sock(apps_sock);
 	if (ret < 0) {
@@ -1537,6 +1551,7 @@ error_poll_add:
 	lttng_poll_clean(&events);
 error_listen:
 error_create_poll:
+error_testpoint:
 	DBG("UST Registration thread cleanup complete");
 
 	return NULL;
@@ -3122,10 +3137,12 @@ static void *thread_manage_clients(void *data)
 
 	DBG("[thread] Manage client started");
 
-	testpoint(thread_manage_clients);
-
 	rcu_register_thread();
 
+	if (testpoint(thread_manage_clients)) {
+		goto error_testpoint;
+	}
+
 	health_code_update(&health_thread_cmd);
 
 	ret = lttcomm_listen_unix_sock(client_sock);
@@ -3155,7 +3172,9 @@ static void *thread_manage_clients(void *data)
 		kill(ppid, SIGUSR1);
 	}
 
-	testpoint(thread_manage_clients_before_loop);
+	if (testpoint(thread_manage_clients_before_loop)) {
+		goto error;
+	}
 
 	health_code_update(&health_thread_cmd);
 
@@ -3330,6 +3349,7 @@ error:
 
 error_listen:
 error_create_poll:
+error_testpoint:
 	unlink(client_unix_sock_path);
 	if (client_sock >= 0) {
 		ret = close(client_sock);
diff --git a/src/common/testpoint/testpoint.h b/src/common/testpoint/testpoint.h
index ba3af8a..dc5be83 100644
--- a/src/common/testpoint/testpoint.h
+++ b/src/common/testpoint/testpoint.h
@@ -31,38 +31,38 @@ void *lttng_testpoint_lookup(const char *name);
 /*
  * Testpoint is only active if the global lttng_testpoint_activated flag is
  * set.
+ * Return a non-zero error code to indicate failure.
  */
-#define testpoint(name)					\
-	do {							\
-		if (caa_unlikely(lttng_testpoint_activated)) {	\
-			__testpoint_##name##_wrapper();		\
-		}						\
-	} while (0)
+#define testpoint(name)				\
+	((caa_unlikely(lttng_testpoint_activated))	\
+	? __testpoint_##name##_wrapper() : 0)
 
 /*
  * One wrapper per testpoint is generated. This is to keep track of the symbol
  * lookup status and the corresponding function pointer, if any.
  */
 #define _TESTPOINT_DECL(_name)						\
-	static inline void __testpoint_##_name##_wrapper(void)		\
+	static inline int __testpoint_##_name##_wrapper(void)		\
 	{								\
-		static void (*tp)(void);				\
+		int ret = 0;						\
+		static int (*tp)(void);					\
 		static int found;					\
 		const char *tp_name = "__testpoint_" #_name;		\
 									\
 		if (tp) {						\
-			tp();						\
+			ret = tp();					\
 		} else {						\
 			if (!found) {					\
 				tp = lttng_testpoint_lookup(tp_name);	\
 				if (tp) {				\
 					found = 1;			\
-					tp();				\
+					ret = tp();			\
 				} else {				\
 					found = -1;			\
 				}					\
 			}						\
 		}							\
+		return ret;						\
 	}
 
 /* Testpoint declaration */
diff --git a/tests/tools/health/health_exit.c b/tests/tools/health/health_exit.c
index 258b08d..8e41405 100644
--- a/tests/tools/health/health_exit.c
+++ b/tests/tools/health/health_exit.c
@@ -35,47 +35,57 @@ int check_env_var(const char *env)
 	return 0;
 }
 
-void __testpoint_thread_manage_clients(void)
+int __testpoint_thread_manage_clients(void)
 {
 	const char *var = "LTTNG_THREAD_MANAGE_CLIENTS_EXIT";
 
 	if (check_env_var(var)) {
 		pthread_exit(NULL);
 	}
+
+	return 0;
 }
 
-void __testpoint_thread_registration_apps(void)
+int __testpoint_thread_registration_apps(void)
 {
 	const char *var = "LTTNG_THREAD_REG_APPS_EXIT";
 
 	if (check_env_var(var)) {
 		pthread_exit(NULL);
 	}
+
+	return 0;
 }
 
-void __testpoint_thread_manage_apps(void)
+int __testpoint_thread_manage_apps(void)
 {
 	const char *var = "LTTNG_THREAD_MANAGE_APPS_EXIT";
 
 	if (check_env_var(var)) {
 		pthread_exit(NULL);
 	}
+
+	return 0;
 }
 
-void __testpoint_thread_manage_kernel(void)
+int __testpoint_thread_manage_kernel(void)
 {
 	const char *var = "LTTNG_THREAD_MANAGE_KERNEL_EXIT";
 
 	if (check_env_var(var)) {
 		pthread_exit(NULL);
 	}
+
+	return 0;
 }
 
-void __testpoint_thread_manage_consumer(void)
+int __testpoint_thread_manage_consumer(void)
 {
 	const char *var = "LTTNG_THREAD_MANAGE_CONSUMER_EXIT";
 
 	if (check_env_var(var)) {
 		pthread_exit(NULL);
 	}
+
+	return 0;
 }
diff --git a/tests/tools/health/health_stall.c b/tests/tools/health/health_stall.c
index 38fe5f8..127f5fc 100644
--- a/tests/tools/health/health_stall.c
+++ b/tests/tools/health/health_stall.c
@@ -38,7 +38,7 @@ int check_env_var(const char *env)
 	return 0;
 }
 
-void __testpoint_thread_manage_clients_before_loop(void)
+int __testpoint_thread_manage_clients_before_loop(void)
 {
 	const char *var = "LTTNG_THREAD_MANAGE_CLIENTS_STALL";
 
@@ -48,9 +48,11 @@ void __testpoint_thread_manage_clients_before_loop(void)
 			sleep_time = sleep(sleep_time);
 		}
 	}
+
+	return 0;
 }
 
-void __testpoint_thread_manage_kernel_before_loop(void)
+int __testpoint_thread_manage_kernel_before_loop(void)
 {
 	const char *var = "LTTNG_THREAD_MANAGE_KERNEL_STALL";
 
@@ -60,9 +62,11 @@ void __testpoint_thread_manage_kernel_before_loop(void)
 			sleep_time = sleep(sleep_time);
 		}
 	}
+
+	return 0;
 }
 
-void __testpoint_thread_manage_apps_before_loop(void)
+int __testpoint_thread_manage_apps_before_loop(void)
 {
 	const char *var = "LTTNG_THREAD_MANAGE_APPS_STALL";
 
@@ -72,4 +76,6 @@ void __testpoint_thread_manage_apps_before_loop(void)
 			sleep_time = sleep(sleep_time);
 		}
 	}
+
+	return 0;
 }
-- 
1.8.0.1
