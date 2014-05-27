From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 1/2] Implement tracef test application
	"gen-ust-tracef"
Date: Tue, 27 May 2014 16:25:25 -0400
Message-ID: <1401222326-29474-1-git-send-email-mathieu.desnoyers__18756.6723245711$1401222772$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1WpO0U-0003dH-7p
 for lttng-dev@lists.lttng.org; Tue, 27 May 2014 16:30:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2316634023D
 for <lttng-dev@lists.lttng.org>; Tue, 27 May 2014 20:29:58 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 configure.ac                                       |    1 +
 tests/utils/testapp/Makefile.am                    |    2 +-
 tests/utils/testapp/gen-ust-tracef/Makefile.am     |   15 ++++
 .../utils/testapp/gen-ust-tracef/gen-ust-tracef.c  |   83 ++++++++++++++++++++
 4 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 tests/utils/testapp/gen-ust-tracef/Makefile.am
 create mode 100644 tests/utils/testapp/gen-ust-tracef/gen-ust-tracef.c

diff --git a/configure.ac b/configure.ac
index 5c5562e..cea504b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -444,6 +444,7 @@ AC_CONFIG_FILES([
 	tests/utils/testapp/Makefile
 	tests/utils/testapp/gen-ust-events/Makefile
 	tests/utils/testapp/gen-ust-nevents/Makefile
+	tests/utils/testapp/gen-ust-tracef/Makefile
 ])
 
 AC_OUTPUT
diff --git a/tests/utils/testapp/Makefile.am b/tests/utils/testapp/Makefile.am
index be2758d..0341de4 100644
--- a/tests/utils/testapp/Makefile.am
+++ b/tests/utils/testapp/Makefile.am
@@ -1,2 +1,2 @@
-SUBDIRS = gen-ust-events gen-ust-nevents
+SUBDIRS = gen-ust-events gen-ust-nevents gen-ust-tracef
 
diff --git a/tests/utils/testapp/gen-ust-tracef/Makefile.am b/tests/utils/testapp/gen-ust-tracef/Makefile.am
new file mode 100644
index 0000000..4385b40
--- /dev/null
+++ b/tests/utils/testapp/gen-ust-tracef/Makefile.am
@@ -0,0 +1,15 @@
+AM_CFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/src -I$(srcdir) -O2 -g
+AM_LDFLAGS =
+
+if LTTNG_TOOLS_BUILD_WITH_LIBDL
+AM_LDFLAGS += -ldl
+endif
+if LTTNG_TOOLS_BUILD_WITH_LIBC_DL
+AM_LDFLAGS += -lc
+endif
+
+if HAVE_LIBLTTNG_UST_CTL
+noinst_PROGRAMS = gen-ust-tracef
+gen_ust_tracef_SOURCES = gen-ust-tracef.c
+gen_ust_tracef_LDADD = -llttng-ust
+endif
diff --git a/tests/utils/testapp/gen-ust-tracef/gen-ust-tracef.c b/tests/utils/testapp/gen-ust-tracef/gen-ust-tracef.c
new file mode 100644
index 0000000..1c3493d
--- /dev/null
+++ b/tests/utils/testapp/gen-ust-tracef/gen-ust-tracef.c
@@ -0,0 +1,83 @@
+/*
+ * Copyright (C) - 2012 David Goulet <dgoulet@efficios.com>
+ * Copyright (C) - 2014 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * This library is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU Lesser General Public License as published by the
+ * Free Software Foundation; version 2.1 of the License.
+ *
+ * This library is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public License
+ * along with this library; if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
+ */
+
+#include <assert.h>
+#include <fcntl.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include <lttng/tracef.h>
+
+const char *str = "test string";
+
+void create_file(const char *path)
+{
+	int ret;
+
+	assert(path);
+
+	ret = creat(path, S_IRWXU);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to create file %s\n", path);
+		return;
+	}
+
+	(void) close(ret);
+}
+
+int main(int argc, char **argv)
+{
+	int i;
+	unsigned int nr_iter = 100;
+	useconds_t nr_usec = 0;
+	char *tmp_file_path = NULL;
+
+	if (argc >= 2) {
+		nr_iter = atoi(argv[1]);
+	}
+
+	if (argc >= 3) {
+		/* By default, don't wait unless user specifies. */
+		nr_usec = atoi(argv[2]);
+	}
+
+	if (argc >= 4) {
+		tmp_file_path = argv[3];
+	}
+
+	for (i = 0; i < nr_iter; i++) {
+		tracef("Test message %d with string \"%s\"", i, str);
+
+		/*
+		 * First loop we create the file if asked to indicate
+		 * that at least one tracepoint has been hit.
+		 */
+		if (i == 0 && tmp_file_path) {
+			create_file(tmp_file_path);
+		}
+		usleep(nr_usec);
+	}
+
+	return 0;
+}
-- 
1.7.10.4
