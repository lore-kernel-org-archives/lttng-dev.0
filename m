From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH v2 lttng-tools 1/5] Add testpoints in
	lttng-sessiond to instrument every threads
Date: Tue,  2 Oct 2012 14:18:29 -0400
Message-ID: <1349201909-9906-1-git-send-email-christian.babeux__8820.12055158175$1349202002$gmane$org@efficios.com>
References: <1348770199-1618-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TJ73T-00048Z-HU
	for lttng-dev@lists.lttng.org; Tue, 02 Oct 2012 14:18:51 -0400
Received: by qadc11 with SMTP id c11so917728qad.14
	for <lttng-dev@lists.lttng.org>; Tue, 02 Oct 2012 11:18:46 -0700 (PDT)
In-Reply-To: <1348770199-1618-1-git-send-email-christian.babeux@efficios.com>
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

This commit adds 8 new testpoints in the lttng-sessiond binary.
These testpoints rely on the testpoints infrastructure introduced
recently.

Testpoints:

thread_manage_clients
thread_manage_clients_before_loop
thread_registration_apps
thread_manage_apps
thread_manage_apps_before_loop
thread_manage_kernel
thread_manage_kernel_before_loop
thread_manage_consumer

The thread_<thread_name> testpoints are placed directly at the thread
start and they can be used to trigger failure in <thread_name>.

The thread_<thread_name>_before_loop testpoints are placed
directly before the main processing loop of the thread and thus can be
used to stall the processing of the thread.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 src/bin/lttng-sessiond/Makefile.am |  3 ++-
 src/bin/lttng-sessiond/main.c      | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/src/bin/lttng-sessiond/Makefile.am b/src/bin/lttng-sessiond/Makefile.am
index 73be023..733818e 100644
--- a/src/bin/lttng-sessiond/Makefile.am
+++ b/src/bin/lttng-sessiond/Makefile.am
@@ -38,7 +38,8 @@ lttng_sessiond_LDADD = -lrt -lurcu-common -lurcu \
 		$(top_builddir)/src/common/hashtable/libhashtable.la \
 		$(top_builddir)/src/common/libcommon.la \
 		$(top_builddir)/src/common/compat/libcompat.la \
-		$(top_builddir)/src/common/relayd/librelayd.la
+		$(top_builddir)/src/common/relayd/librelayd.la \
+		$(top_builddir)/src/common/testpoint/libtestpoint.la
 
 if HAVE_LIBLTTNG_UST_CTL
 lttng_sessiond_LDADD += -llttng-ust-ctl
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 730ac65..6e93cf0 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -45,6 +45,7 @@
 #include <common/futex.h>
 #include <common/relayd/relayd.h>
 #include <common/utils.h>
+#include <common/testpoint/testpoint.h>
 
 #include "lttng-sessiond.h"
 #include "channel.h"
@@ -65,6 +66,16 @@
 
 #define CONSUMERD_FILE	"lttng-consumerd"
 
+/* Testpoints, internal use only */
+TESTPOINT_DECL(thread_manage_clients);
+TESTPOINT_DECL(thread_manage_clients_before_loop);
+TESTPOINT_DECL(thread_registration_apps);
+TESTPOINT_DECL(thread_manage_apps);
+TESTPOINT_DECL(thread_manage_apps_before_loop);
+TESTPOINT_DECL(thread_manage_kernel);
+TESTPOINT_DECL(thread_manage_kernel_before_loop);
+TESTPOINT_DECL(thread_manage_consumer);
+
 /* Const values */
 const char default_home_dir[] = DEFAULT_HOME_DIR;
 const char default_tracing_group[] = DEFAULT_TRACING_GROUP;
@@ -680,8 +691,12 @@ static void *thread_manage_kernel(void *data)
 
 	DBG("Thread manage kernel started");
 
+	testpoint(thread_manage_kernel);
+
 	health_code_update(&health_thread_kernel);
 
+	testpoint(thread_manage_kernel_before_loop);
+
 	ret = create_thread_poll_set(&events, 2);
 	if (ret < 0) {
 		goto error_poll_create;
@@ -829,6 +844,9 @@ static void *thread_manage_consumer(void *data)
 	/* Inifinite blocking call, waiting for transmission */
 restart:
 	health_poll_update(&consumer_data->health);
+
+	testpoint(thread_manage_consumer);
+
 	ret = lttng_poll_wait(&events, -1);
 	health_poll_update(&consumer_data->health);
 	if (ret < 0) {
@@ -1026,6 +1044,8 @@ static void *thread_manage_apps(void *data)
 
 	DBG("[thread] Manage application started");
 
+	testpoint(thread_manage_apps);
+
 	rcu_register_thread();
 	rcu_thread_online();
 
@@ -1041,6 +1061,8 @@ static void *thread_manage_apps(void *data)
 		goto error;
 	}
 
+	testpoint(thread_manage_apps_before_loop);
+
 	health_code_update(&health_thread_app_manage);
 
 	while (1) {
@@ -1264,6 +1286,8 @@ static void *thread_registration_apps(void *data)
 
 	DBG("[thread] Manage application registration started");
 
+	testpoint(thread_registration_apps);
+
 	ret = lttcomm_listen_unix_sock(apps_sock);
 	if (ret < 0) {
 		goto error_listen;
@@ -2912,6 +2936,8 @@ static void *thread_manage_clients(void *data)
 
 	DBG("[thread] Manage client started");
 
+	testpoint(thread_manage_clients);
+
 	rcu_register_thread();
 
 	health_code_update(&health_thread_cmd);
@@ -2943,6 +2969,8 @@ static void *thread_manage_clients(void *data)
 		kill(ppid, SIGUSR1);
 	}
 
+	testpoint(thread_manage_clients_before_loop);
+
 	health_code_update(&health_thread_cmd);
 
 	while (1) {
-- 
1.7.12.1
