From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Tests: Fix possible segfault in
	health check thread exit test
Date: Wed, 22 May 2013 16:29:33 -0400
Message-ID: <1369254573-1342-1-git-send-email-christian.babeux__40578.5804534846$1369254634$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-gg0-f171.google.com ([209.85.161.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UfFfX-0004Im-TO
	for lttng-dev@lists.lttng.org; Wed, 22 May 2013 16:29:56 -0400
Received: by mail-gg0-f171.google.com with SMTP id h13so848189ggd.30
	for <lttng-dev@lists.lttng.org>; Wed, 22 May 2013 13:29:50 -0700 (PDT)
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

The testpoints in the thread_manage_clients and thread_manage_apps
are called after a rcu_register_thread() call. The testpoints were
not unregistering their respective thread which could later on cause
a segfault when shutting down the session daemon.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/regression/tools/health/health_exit.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/regression/tools/health/health_exit.c b/tests/regression/tools/health/health_exit.c
index 8e41405..8d1d05c 100644
--- a/tests/regression/tools/health/health_exit.c
+++ b/tests/regression/tools/health/health_exit.c
@@ -18,6 +18,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <pthread.h>
+#include <urcu.h>
 
 /*
  * Check if the specified environment variable is set.
@@ -40,6 +41,7 @@ int __testpoint_thread_manage_clients(void)
 	const char *var = "LTTNG_THREAD_MANAGE_CLIENTS_EXIT";
 
 	if (check_env_var(var)) {
+		rcu_unregister_thread();
 		pthread_exit(NULL);
 	}
 
@@ -62,6 +64,7 @@ int __testpoint_thread_manage_apps(void)
 	const char *var = "LTTNG_THREAD_MANAGE_APPS_EXIT";
 
 	if (check_env_var(var)) {
+		rcu_unregister_thread();
 		pthread_exit(NULL);
 	}
 
-- 
1.8.2.2
