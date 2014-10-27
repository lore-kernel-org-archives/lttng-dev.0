From: Charles Briere <c.briere@samsung.com>
Subject: [PATCH lttng-tools 18/24] Add : Compatibility layer for
	shm.h
Date: Mon, 27 Oct 2014 20:49:30 +0000
Message-ID: <1414442926-14381-19-git-send-email-c.briere__46745.2668388889$1414443166$gmane$org@samsung.com>
References: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout2.w2.samsung.com ([211.189.100.12]
 helo=usmailout2.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1XirEQ-0007nj-OF
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:40 -0400
Received: from uscpsbgex4.samsung.com
 (u125.gpu85.samsung.co.kr [203.254.195.125]) by mailout2.w2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NE400GQVF6L9B30@mailout2.w2.samsung.com> for
 lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:33 -0400 (EDT)
In-reply-to: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Content-language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "jeremie.galarneau@efficios.com" <jeremie.galarneau@efficios.com>, "dgoulet@efficios.com" <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "karim.yaghmour@opersys.com" <karim.yaghmour@opersys.com>
List-Id: lttng-dev@lists.lttng.org

From: Charles Briere <c.briere@samsung.com>

Linking libcutils for Android that uses ashmem

Signed-off-by: Charles Briere <c.briere@samsung.com>
---
 configure.ac                 | 14 ++++++++++++++
 src/bin/lttng-sessiond/shm.c |  5 +++--
 src/common/compat/shm.h      | 37 +++++++++++++++++++++++++++++++++++++
 src/common/defaults.h        |  1 +
 4 files changed, 55 insertions(+), 2 deletions(-)
 create mode 100644 src/common/compat/shm.h

diff --git a/configure.ac b/configure.ac
index e219689..16852b1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -194,6 +194,20 @@ AC_CHECK_LIB([rt], [shm_open],
 AM_CONDITIONAL([LTTNG_BUILD_WITH_LIBUUID], [test "x$have_libuuid" = "xyes"])
 AM_CONDITIONAL([LTTNG_BUILD_WITH_LIBC_UUID], [test "x$have_libc_uuid" = "xyes"])
 
+# Check for libcutils
+AC_CHECK_LIB([cutils], [ashmem_create],
+	     [AC_SUBST(LIBCUTILS_LIBS, '-lcutils')],
+	     [AC_SUBST(LIBCUTILS_LIBS, '')],
+)
+AC_CHECK_HEADERS([cutils/ashmem.h],
+	[AC_CHECK_DECLS([ashmem_create], [], [], [[#include <cutils/ashmem.h>]])],
+)
+
+AS_CASE([$host],[*-*-linux-androideabi],
+	[AM_CONDITIONAL(TARGET_IS_ANDROID, true)],
+	[AM_CONDITIONAL(TARGET_IS_ANDROID, false)]
+)
+
 # URCU library version needed or newer
 liburcu_version=">= 0.8.0"
 
diff --git a/src/bin/lttng-sessiond/shm.c b/src/bin/lttng-sessiond/shm.c
index e9ed714..dba3679 100644
--- a/src/bin/lttng-sessiond/shm.c
+++ b/src/bin/lttng-sessiond/shm.c
@@ -30,7 +30,7 @@
 
 #include <common/error.h>
 
-#include "shm.h"
+#include <common/compat/shm.h>
 
 /*
  * Using fork to set umask in the child process (not multi-thread safe). We
@@ -73,7 +73,8 @@ static int get_wait_shm(char *shm_path, size_t mmap_size, int global)
 	 * Try creating shm (or get rw access). We don't do an exclusive open,
 	 * because we allow other processes to create+ftruncate it concurrently.
 	 */
-	wait_shm_fd = shm_open(shm_path, O_RDWR | O_CREAT, mode);
+	wait_shm_fd = lttng_shm_open(shm_path, O_RDWR | O_CREAT, mode);
+
 	if (wait_shm_fd < 0) {
 		PERROR("shm_open wait shm");
 		goto error;
diff --git a/src/common/compat/shm.h b/src/common/compat/shm.h
new file mode 100644
index 0000000..28e498a
--- /dev/null
+++ b/src/common/compat/shm.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright (C) 2014 - Charles Briere <c.briere@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2 only,
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef _COMPAT_SYS_SHM_H
+#define _COMPAT_SYS_SHM_H
+
+# if defined(HAVE_SYS_SHM_H)
+
+#include <sys/shm.h>
+
+#define lttng_shm_open(name, oflag, mode) \
+	shm_open(name, oflag, mode)
+
+# elif defined(HAVE_CUTILS_ASHMEM_H)
+
+#include <cutils/ashmem.h>
+
+#define lttng_shm_open(name, oflag, mode) \
+	open(name, oflag, mode)
+
+# endif /* HAVE_SYS_SHM_H */
+
+#endif  /*_COMPAT_SYS_SHM_H */
diff --git a/src/common/defaults.h b/src/common/defaults.h
index 25d7b32..8951179 100644
--- a/src/common/defaults.h
+++ b/src/common/defaults.h
@@ -143,6 +143,7 @@
 #define DEFAULT_HOME_APPS_UNIX_SOCK \
 	DEFAULT_LTTNG_HOME_RUNDIR "/" LTTNG_UST_SOCK_FILENAME
 #define DEFAULT_GLOBAL_APPS_WAIT_SHM_PATH \
+	DEFAULT_LTTNG_RUNDIR \
 	"/" LTTNG_UST_WAIT_FILENAME
 #define DEFAULT_HOME_APPS_WAIT_SHM_PATH \
 	DEFAULT_GLOBAL_APPS_WAIT_SHM_PATH "-%d"
-- 
2.1.2
