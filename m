From: Charles Briere <c.briere@samsung.com>
Subject: [PATCH lttng-tools 09/24] Add : Compatibility layer for
	syscall.h
Date: Mon, 27 Oct 2014 20:49:29 +0000
Message-ID: <1414442926-14381-10-git-send-email-c.briere__49133.0618424856$1414443320$gmane$org@samsung.com>
References: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout3.w2.samsung.com ([211.189.100.13]
 helo=usmailout3.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1XirET-0007ni-2j
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:43 -0400
Received: from uscpsbgex1.samsung.com
 (u122.gpu85.samsung.co.kr [203.254.195.122]) by usmailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NE4004IKF6JPV30@usmailout3.samsung.com> for
 lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:31 -0400 (EDT)
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

Signed-off-by: Charles Briere <c.briere@samsung.com>
---
 configure.ac                |  6 ++++--
 src/common/compat/syscall.h | 36 ++++++++++++++++++++++++++++++++++++
 src/common/compat/tid.h     |  1 +
 src/common/futex.c          |  2 +-
 4 files changed, 42 insertions(+), 3 deletions(-)
 create mode 100644 src/common/compat/syscall.h

diff --git a/configure.ac b/configure.ac
index 3460f98..1189d8e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -57,8 +57,10 @@ AM_CONDITIONAL([NO_SHARED], [test x$enable_shared = xno])
 AC_CHECK_HEADERS([ \
 	sys/types.h unistd.h fcntl.h string.h pthread.h limits.h \
 	signal.h stdlib.h sys/un.h sys/socket.h stdlib.h stdio.h \
-	getopt.h sys/ipc.h sys/shm.h popt.h grp.h \
-])
+	getopt.h sys/ipc.h sys/shm.h popt.h grp.h syscall.h \
+	],[],
+	[AC_CHECK_HEADERS([sys/syscall.h])]
+)
 
 # Babeltrace viewer check
 AC_ARG_WITH([babeltrace-bin],
diff --git a/src/common/compat/syscall.h b/src/common/compat/syscall.h
new file mode 100644
index 0000000..62dabf6
--- /dev/null
+++ b/src/common/compat/syscall.h
@@ -0,0 +1,36 @@
+/*
+ * Copyright 2014 (c) - Charles Briere <c.briere@samsung.com>
+ *
+ * syscall compatibility layer.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to
+ * deal in the Software without restriction, including without limitation the
+ * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
+ * sell copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ */
+
+#ifndef LTTNG_SYSCALL_H
+#define LTTNG_SYSCALL_H
+
+#include <config.h>
+
+# if defined(HAVE_SYSCALL_H)
+#  include <syscall.h>
+# elif defined(HAVE_SYS_SYSCALL_H)
+#  include <sys/syscall.h>
+# endif
+
+#endif
diff --git a/src/common/compat/tid.h b/src/common/compat/tid.h
index 7645b90..5142ae8 100644
--- a/src/common/compat/tid.h
+++ b/src/common/compat/tid.h
@@ -26,6 +26,7 @@
 #define LTTNG_TID_H
 
 #include <config.h>
+#include <common/compat/syscall.h>
 
 #if !HAVE_DECL_GETTID
 # if defined(_syscall0)
diff --git a/src/common/futex.c b/src/common/futex.c
index 0b27a5b..b373ed5 100644
--- a/src/common/futex.c
+++ b/src/common/futex.c
@@ -18,7 +18,7 @@
 
 #define _GNU_SOURCE
 #include <limits.h>
-#include <sys/syscall.h>
+#include <common/compat/syscall.h>
 #include <unistd.h>
 #include <urcu.h>
 #include <urcu/futex.h>
-- 
2.1.2
