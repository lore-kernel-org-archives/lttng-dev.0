From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 2/5] Tests: Add a health check
	utility program
Date: Thu, 27 Sep 2012 14:23:16 -0400
Message-ID: <1348770199-1618-2-git-send-email-christian.babeux__43490.3870257132$1348770250$gmane$org@efficios.com>
References: <1348770199-1618-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1THIkP-0003MF-CH
	for lttng-dev@lists.lttng.org; Thu, 27 Sep 2012 14:23:41 -0400
Received: by qatp27 with SMTP id p27so5263137qat.14
	for <lttng-dev@lists.lttng.org>; Thu, 27 Sep 2012 11:23:35 -0700 (PDT)
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

The health_check program is a simple utility to query the health
status of the different threads of the sessiond.

Sample output:

> ./health_check
Health check cmd: 0
Health check app. manage: 0
Health check app. registration: 0
Health check kernel: 0
Health check consumer: 0

The return code is encoded to indicate which thread has failed.

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 tests/tools/health/Makefile.am    | 20 +++++++++++
 tests/tools/health/health_check.c | 73 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100644 tests/tools/health/Makefile.am
 create mode 100644 tests/tools/health/health_check.c

diff --git a/tests/tools/health/Makefile.am b/tests/tools/health/Makefile.am
new file mode 100644
index 0000000..09573db
--- /dev/null
+++ b/tests/tools/health/Makefile.am
@@ -0,0 +1,20 @@
+AM_CFLAGS = -I. -O2 -g -I../../../include
+AM_LDFLAGS =
+
+if LTTNG_TOOLS_BUILD_WITH_LIBDL
+AM_LDFLAGS += -ldl
+endif
+if LTTNG_TOOLS_BUILD_WITH_LIBC_DL
+AM_LDFLAGS += -lc
+endif
+
+UTILS=
+
+noinst_PROGRAMS = health_check
+
+health_check_SOURCES = health_check.c $(UTILS)
+health_check_LDADD = $(top_builddir)/src/lib/lttng-ctl/liblttng-ctl.la \
+		     $(top_builddir)/src/common/libcommon.la
+
+noinst_SCRIPTS =
+EXTRA_DIST =
diff --git a/tests/tools/health/health_check.c b/tests/tools/health/health_check.c
new file mode 100644
index 0000000..3eef110
--- /dev/null
+++ b/tests/tools/health/health_check.c
@@ -0,0 +1,73 @@
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
+#include <stdio.h>
+
+#include "lttng/lttng.h"
+
+#define HEALTH_CMD_FAIL     (1 << 0)
+#define HEALTH_APP_MNG_FAIL (1 << 1)
+#define HEALTH_APP_REG_FAIL (1 << 2)
+#define HEALTH_KERNEL_FAIL  (1 << 3)
+#define HEALTH_CSMR_FAIL    (1 << 4)
+
+int main(int argc, char *argv[])
+{
+	int health = -1;
+	int status = 0;
+
+	/* Command thread */
+	health = lttng_health_check(LTTNG_HEALTH_CMD);
+	printf("Health check cmd: %d\n", health);
+
+	if (health) {
+		status |= HEALTH_CMD_FAIL;
+	}
+
+	/* App manage thread */
+	health = lttng_health_check(LTTNG_HEALTH_APP_MANAGE);
+	printf("Health check app. manage: %d\n", health);
+
+	if (health) {
+		status |= HEALTH_APP_MNG_FAIL;
+	}
+	/* App registration thread */
+	health = lttng_health_check(LTTNG_HEALTH_APP_REG);
+	printf("Health check app. registration: %d\n", health);
+
+	if (health) {
+		status |= HEALTH_APP_REG_FAIL;
+	}
+
+	/* Kernel thread */
+	health = lttng_health_check(LTTNG_HEALTH_KERNEL);
+	printf("Health check kernel: %d\n", health);
+
+	if (health) {
+		status |= HEALTH_KERNEL_FAIL;
+	}
+
+	/* Consumer thread */
+	health = lttng_health_check(LTTNG_HEALTH_CONSUMER);
+	printf("Health check consumer: %d\n", health);
+
+	if (health) {
+		status |= HEALTH_CSMR_FAIL;
+	}
+
+	return status;
+}
-- 
1.7.12
