From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Add return code to the testpoint
	mechanism
Date: Mon,  5 Nov 2012 12:33:57 -0500
Message-ID: <1352136837-20694-1-git-send-email-christian.babeux__47515.5084314339$1352136901$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TVQZ7-0006Fb-6g
	for lttng-dev@lists.lttng.org; Mon, 05 Nov 2012 12:34:25 -0500
Received: by mail-vc0-f176.google.com with SMTP id fo13so2068796vcb.35
	for <lttng-dev@lists.lttng.org>; Mon, 05 Nov 2012 09:34:19 -0800 (PST)
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

The testpoint processing could fail and currently there is no
mechanism to notify the caller of such failures. This patch add an
int return code to the testpoint prototype. Non-zero return code
indicate failure.

When using the testpoint mechanism, the caller should properly handle
testpoint failure cases and trigger the appropriate response
(error handling, thread teardown, etc.).

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 src/bin/lttng-sessiond/main.c     | 36 ++++++++++++++++++++++++++----------
 src/common/testpoint/testpoint.h  | 20 ++++++++++----------
 tests/tools/health/health_exit.c  | 20 +++++++++++++++-----
 tests/tools/health/health_stall.c | 12 +++++++++---
 4 files changed, 60 insertions(+), 28 deletions(-)

diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index cedd356..3d74b66 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -690,11 +690,15 @@ static void *thread_manage_kernel(void *data)
 
 	DBG("Thread manage kernel started");
 
-	testpoint(thread_manage_kernel);
+	if (testpoint(thread_manage_kernel)) {
+		goto error;
+	}
 
 	health_code_update(&health_thread_kernel);
 
-	testpoint(thread_manage_kernel_before_loop);
+	if (testpoint(thread_manage_kernel_before_loop)) {
+		goto error;
+	}
 
 	ret = create_thread_poll_set(&events, 2);
 	if (ret < 0) {
@@ -886,7 +890,9 @@ static void *thread_manage_consumer(void *data)
 restart:
 	health_poll_update(&consumer_data->health);
 
-	testpoint(thread_manage_consumer);
+	if (testpoint(thread_manage_consumer)) {
+		goto error;
+	}
 
 	ret = lttng_poll_wait(&events, -1);
 	health_poll_update(&consumer_data->health);
@@ -1085,11 +1091,13 @@ static void *thread_manage_apps(void *data)
 
 	DBG("[thread] Manage application started");
 
-	testpoint(thread_manage_apps);
-
 	rcu_register_thread();
 	rcu_thread_online();
 
+	if (testpoint(thread_manage_apps)) {
+		goto error;
+	}
+
 	health_code_update(&health_thread_app_manage);
 
 	ret = create_thread_poll_set(&events, 2);
@@ -1102,7 +1110,9 @@ static void *thread_manage_apps(void *data)
 		goto error;
 	}
 
-	testpoint(thread_manage_apps_before_loop);
+	if (testpoint(thread_manage_apps_before_loop)) {
+		goto error;
+	}
 
 	health_code_update(&health_thread_app_manage);
 
@@ -1327,7 +1337,9 @@ static void *thread_registration_apps(void *data)
 
 	DBG("[thread] Manage application registration started");
 
-	testpoint(thread_registration_apps);
+	if (testpoint(thread_registration_apps)) {
+		goto error;
+	}
 
 	ret = lttcomm_listen_unix_sock(apps_sock);
 	if (ret < 0) {
@@ -3054,10 +3066,12 @@ static void *thread_manage_clients(void *data)
 
 	DBG("[thread] Manage client started");
 
-	testpoint(thread_manage_clients);
-
 	rcu_register_thread();
 
+	if (testpoint(thread_manage_clients)) {
+		goto error;
+	}
+
 	health_code_update(&health_thread_cmd);
 
 	ret = lttcomm_listen_unix_sock(client_sock);
@@ -3087,7 +3101,9 @@ static void *thread_manage_clients(void *data)
 		kill(ppid, SIGUSR1);
 	}
 
-	testpoint(thread_manage_clients_before_loop);
+	if (testpoint(thread_manage_clients_before_loop)) {
+		goto error;
+	}
 
 	health_code_update(&health_thread_cmd);
 
diff --git a/src/common/testpoint/testpoint.h b/src/common/testpoint/testpoint.h
index ba3af8a..8d5d9db 100644
--- a/src/common/testpoint/testpoint.h
+++ b/src/common/testpoint/testpoint.h
@@ -32,37 +32,37 @@ void *lttng_testpoint_lookup(const char *name);
  * Testpoint is only active if the global lttng_testpoint_activated flag is
  * set.
  */
-#define testpoint(name)					\
-	do {							\
-		if (caa_unlikely(lttng_testpoint_activated)) {	\
-			__testpoint_##name##_wrapper();		\
-		}						\
-	} while (0)
+#define testpoint(name)				\
+	((caa_unlikely(lttng_testpoint_activated))	\
+	 ? __testpoint_##name##_wrapper() : 0)
 
 /*
  * One wrapper per testpoint is generated. This is to keep track of the symbol
  * lookup status and the corresponding function pointer, if any.
+ * Return a non-zero error code to indicate failure.
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
index f91bd49..6dddc2e 100644
--- a/tests/tools/health/health_stall.c
+++ b/tests/tools/health/health_stall.c
@@ -38,29 +38,35 @@ int check_env_var(const char *env)
 	return 0;
 }
 
-void __testpoint_thread_manage_clients_before_loop(void)
+int __testpoint_thread_manage_clients_before_loop(void)
 {
 	const char *var = "LTTNG_THREAD_MANAGE_CLIENTS_STALL";
 
 	if (check_env_var(var)) {
 		sleep(STALL_TIME);
 	}
+
+	return 0;
 }
 
-void __testpoint_thread_manage_kernel_before_loop(void)
+int __testpoint_thread_manage_kernel_before_loop(void)
 {
 	const char *var = "LTTNG_THREAD_MANAGE_KERNEL_STALL";
 
 	if (check_env_var(var)) {
 		sleep(STALL_TIME);
 	}
+
+	return 0;
 }
 
-void __testpoint_thread_manage_apps_before_loop(void)
+int __testpoint_thread_manage_apps_before_loop(void)
 {
 	const char *var = "LTTNG_THREAD_MANAGE_APPS_STALL";
 
 	if (check_env_var(var)) {
 		sleep(STALL_TIME);
 	}
+
+	return 0;
 }
-- 
1.8.0
