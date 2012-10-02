From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH v3 lttng-tools 1/5] Add testpoints in
	lttng-sessiond to instrument every threads
Date: Tue,  2 Oct 2012 16:00:27 -0400
Message-ID: <1349208027-14191-1-git-send-email-christian.babeux__7293.05859790674$1349208095$gmane$org@efficios.com>
References: <1348770199-1618-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TJ8e9-00056y-Ck
	for lttng-dev@lists.lttng.org; Tue, 02 Oct 2012 16:00:49 -0400
Received: by qcon41 with SMTP id n41so6464130qco.35
	for <lttng-dev@lists.lttng.org>; Tue, 02 Oct 2012 13:00:43 -0700 (PDT)
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
 src/bin/lttng-sessiond/Makefile.am |  6 ++++--
 src/bin/lttng-sessiond/main.c      | 18 ++++++++++++++++++
 src/bin/lttng-sessiond/testpoint.h | 29 +++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 2 deletions(-)
 create mode 100644 src/bin/lttng-sessiond/testpoint.h

diff --git a/src/bin/lttng-sessiond/Makefile.am b/src/bin/lttng-sessiond/Makefile.am
index 73be023..b13059d 100644
--- a/src/bin/lttng-sessiond/Makefile.am
+++ b/src/bin/lttng-sessiond/Makefile.am
@@ -21,7 +21,8 @@ lttng_sessiond_SOURCES = utils.c utils.h \
                        kernel-consumer.c kernel-consumer.h \
                        consumer.h filter.c filter.h \
                        health.c health.h \
-                       cmd.c cmd.h
+                       cmd.c cmd.h \
+                       testpoint.h
 
 if HAVE_LIBLTTNG_UST_CTL
 lttng_sessiond_SOURCES += trace-ust.c ust-app.c ust-consumer.c ust-consumer.h
@@ -38,7 +39,8 @@ lttng_sessiond_LDADD = -lrt -lurcu-common -lurcu \
 		$(top_builddir)/src/common/hashtable/libhashtable.la \
 		$(top_builddir)/src/common/libcommon.la \
 		$(top_builddir)/src/common/compat/libcompat.la \
-		$(top_builddir)/src/common/relayd/librelayd.la
+		$(top_builddir)/src/common/relayd/librelayd.la \
+		$(top_builddir)/src/common/testpoint/libtestpoint.la
 
 if HAVE_LIBLTTNG_UST_CTL
 lttng_sessiond_LDADD += -llttng-ust-ctl
diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
index 730ac65..2b78141 100644
--- a/src/bin/lttng-sessiond/main.c
+++ b/src/bin/lttng-sessiond/main.c
@@ -62,6 +62,7 @@
 #include "fd-limit.h"
 #include "filter.h"
 #include "health.h"
+#include "testpoint.h"
 
 #define CONSUMERD_FILE	"lttng-consumerd"
 
@@ -680,8 +681,12 @@ static void *thread_manage_kernel(void *data)
 
 	DBG("Thread manage kernel started");
 
+	testpoint(thread_manage_kernel);
+
 	health_code_update(&health_thread_kernel);
 
+	testpoint(thread_manage_kernel_before_loop);
+
 	ret = create_thread_poll_set(&events, 2);
 	if (ret < 0) {
 		goto error_poll_create;
@@ -829,6 +834,9 @@ static void *thread_manage_consumer(void *data)
 	/* Inifinite blocking call, waiting for transmission */
 restart:
 	health_poll_update(&consumer_data->health);
+
+	testpoint(thread_manage_consumer);
+
 	ret = lttng_poll_wait(&events, -1);
 	health_poll_update(&consumer_data->health);
 	if (ret < 0) {
@@ -1026,6 +1034,8 @@ static void *thread_manage_apps(void *data)
 
 	DBG("[thread] Manage application started");
 
+	testpoint(thread_manage_apps);
+
 	rcu_register_thread();
 	rcu_thread_online();
 
@@ -1041,6 +1051,8 @@ static void *thread_manage_apps(void *data)
 		goto error;
 	}
 
+	testpoint(thread_manage_apps_before_loop);
+
 	health_code_update(&health_thread_app_manage);
 
 	while (1) {
@@ -1264,6 +1276,8 @@ static void *thread_registration_apps(void *data)
 
 	DBG("[thread] Manage application registration started");
 
+	testpoint(thread_registration_apps);
+
 	ret = lttcomm_listen_unix_sock(apps_sock);
 	if (ret < 0) {
 		goto error_listen;
@@ -2912,6 +2926,8 @@ static void *thread_manage_clients(void *data)
 
 	DBG("[thread] Manage client started");
 
+	testpoint(thread_manage_clients);
+
 	rcu_register_thread();
 
 	health_code_update(&health_thread_cmd);
@@ -2943,6 +2959,8 @@ static void *thread_manage_clients(void *data)
 		kill(ppid, SIGUSR1);
 	}
 
+	testpoint(thread_manage_clients_before_loop);
+
 	health_code_update(&health_thread_cmd);
 
 	while (1) {
diff --git a/src/bin/lttng-sessiond/testpoint.h b/src/bin/lttng-sessiond/testpoint.h
new file mode 100644
index 0000000..5116548
--- /dev/null
+++ b/src/bin/lttng-sessiond/testpoint.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2012 - Christian Babeux <christian.babeux@efficios.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2 only,
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <common/testpoint/testpoint.h>
+
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
-- 
1.7.12.1
