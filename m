From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 3/5] Tests: Add health check thread
	exit test
Date: Thu, 27 Sep 2012 14:23:17 -0400
Message-ID: <1348770199-1618-3-git-send-email-christian.babeux__23857.6826792725$1348770252$gmane$org@efficios.com>
References: <1348770199-1618-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1THIkS-0003Ln-DY
	for lttng-dev@lists.lttng.org; Thu, 27 Sep 2012 14:23:44 -0400
Received: by mail-qc0-f176.google.com with SMTP id n41so1937882qco.35
	for <lttng-dev@lists.lttng.org>; Thu, 27 Sep 2012 11:23:44 -0700 (PDT)
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

This test trigger a failure in a specified thread using the
recently introduced testpoint mechanism. The testpoints behavior
is implemented in health_exit.c. The testpoint code simply calls
pthread_exit(3) and effectively "kill" the thread without affecting
the other threads behavior.

The test select the thread to be "killed" by enabling a specific
environment variable.

With this test we ensure that each thread can be succesfully terminated
and that the health check feature properly detect a failure.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/tools/health/Makefile.am        |   6 ++
 tests/tools/health/health_exit.c      |  80 ++++++++++++++++++++++++++
 tests/tools/health/health_thread_exit | 105 ++++++++++++++++++++++++++++++++++
 3 files changed, 191 insertions(+)
 create mode 100644 tests/tools/health/health_exit.c
 create mode 100755 tests/tools/health/health_thread_exit

diff --git a/tests/tools/health/Makefile.am b/tests/tools/health/Makefile.am
index 09573db..0a3f6c5 100644
--- a/tests/tools/health/Makefile.am
+++ b/tests/tools/health/Makefile.am
@@ -10,6 +10,12 @@ endif
 
 UTILS=
 
+lib_LTLIBRARIES=libhealthexit.la
+
+# Health thread exit ld_preloaded test lib
+libhealthexit_la_SOURCES=health_exit.c
+libhealthexit_la_LDFLAGS= -module
+
 noinst_PROGRAMS = health_check
 
 health_check_SOURCES = health_check.c $(UTILS)
diff --git a/tests/tools/health/health_exit.c b/tests/tools/health/health_exit.c
new file mode 100644
index 0000000..c2382f2
--- /dev/null
+++ b/tests/tools/health/health_exit.c
@@ -0,0 +1,80 @@
+/*
+ * Copyright (C) 2012 - Christian Babeux <christian.babeux@efficios.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License, version 2 only, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc., 51
+ * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <stdlib.h>
+#include <string.h>
+#include <pthread.h>
+
+/*
+ * Check if the specified environment variable is set.
+ * Return 1 if set, otherwise 0.
+ */
+int check_env_var(const char *env)
+{
+	if (env) {
+		if (getenv(env) != NULL && (strncmp(env_val, "1", 1) == 0)) {
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+void __testpoint_thread_manage_clients(void)
+{
+	const char *var = "LTTNG_THREAD_MANAGE_CLIENTS_EXIT";
+
+	if (check_env_var(var)) {
+		pthread_exit(NULL);
+	}
+}
+
+void __testpoint_thread_registration_apps(void)
+{
+	const char *var = "LTTNG_THREAD_REG_APPS_EXIT";
+
+	if (check_env_var(var)) {
+		pthread_exit(NULL);
+	}
+}
+
+void __testpoint_thread_manage_apps(void)
+{
+	const char *var = "LTTNG_THREAD_MANAGE_APPS_EXIT";
+
+	if (check_env_var(var)) {
+		pthread_exit(NULL);
+	}
+}
+
+void __testpoint_thread_manage_kernel(void)
+{
+	const char *var = "LTTNG_THREAD_MANAGE_KERNEL_EXIT";
+
+	if (check_env_var(var)) {
+		pthread_exit(NULL);
+	}
+}
+
+void __testpoint_thread_manage_consumer(void)
+{
+	const char *var = "LTTNG_THREAD_MANAGE_CONSUMER_EXIT";
+
+	if (check_env_var(var)) {
+		pthread_exit(NULL);
+	}
+}
diff --git a/tests/tools/health/health_thread_exit b/tests/tools/health/health_thread_exit
new file mode 100755
index 0000000..dab6b64
--- /dev/null
+++ b/tests/tools/health/health_thread_exit
@@ -0,0 +1,105 @@
+#!/bin/bash
+#
+# Copyright (C) - 2012 Christian Babeux <christian.babeux@efficios.com>
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms of the GNU General Public License, version 2 only, as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+# more details.
+#
+# You should have received a copy of the GNU General Public License along with
+# this program; if not, write to the Free Software Foundation, Inc., 51
+# Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+TEST_DESC="Health check - Thread exit"
+
+CURDIR=$(dirname $0)/
+TESTDIR=$CURDIR/../..
+LTTNG_BIN="lttng"
+SESSION_NAME="health_thread_exit"
+EVENT_NAME="bogus"
+HEALTH_CHECK_BIN="health_check"
+SESSIOND_PRELOAD=".libs/libhealthexit.so"
+
+source $TESTDIR/utils.sh
+
+print_test_banner "$TEST_DESC"
+
+if [ ! -f "$SESSIOND_PRELOAD" ]; then
+	echo -e "libhealthexit.so not available for this test. Skipping."
+	exit 0
+fi
+
+function test_thread_exit
+{
+	test_thread_exit_name="$1"
+	test_thread_exit_code="$2"
+
+	echo ""
+	echo -e "=== Testing health failure with ${test_thread_exit_name}"
+
+	# Activate testpoints
+	export LTTNG_TESTPOINT_ENABLE=1
+
+	# Activate specific thread exit
+	export ${test_thread_exit_name}_EXIT=1
+
+	# Spawn sessiond with preload healthexit lib
+	export LD_PRELOAD="$CURDIR/$SESSIOND_PRELOAD"
+	start_lttng_sessiond
+
+	# Cleanup some env. var.
+	unset LD_PRELOAD
+	unset ${test_thread_exit_name}_EXIT
+
+	# Check initial health status
+	$CURDIR/$HEALTH_CHECK_BIN &> /dev/null
+
+	echo -n "Validating thread ${test_thread_exit_name} failure... "
+
+	# Wait
+	sleep 25
+
+	# Check health status, exit code should indicate failure
+	$CURDIR/$HEALTH_CHECK_BIN &> /dev/null
+
+	health_check_exit_code=$?
+
+	if [ $health_check_exit_code -eq $test_thread_exit_code ]; then
+		print_ok
+		stop_lttng_sessiond
+	else
+		print_fail
+		echo -e "Health returned: $health_check_exit_code\n"
+
+		stop_lttng_sessiond
+		return 1
+	fi
+}
+
+THREAD=("LTTNG_THREAD_MANAGE_CLIENTS"
+	"LTTNG_THREAD_MANAGE_APPS"
+	"LTTNG_THREAD_REG_APPS"
+	"LTTNG_THREAD_MANAGE_KERNEL")
+
+# Exit code value to indicate specific thread failure
+EXIT_CODE=(1 2 4 8)
+
+THREAD_COUNT=${#THREAD[@]}
+i=0
+while [ "$i" -lt "$THREAD_COUNT" ]; do
+	test_thread_exit "${THREAD[$i]}" "${EXIT_CODE[$i]}"
+
+	if [ $? -eq 1 ]; then
+		exit 1
+	fi
+
+	let "i++"
+done
+
+# Special case manage consumer, need to spawn consumer via commands.
+#"LTTNG_THREAD_MANAGE_CONSUMER"
-- 
1.7.12
