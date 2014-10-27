From: Charles Briere <c.briere@samsung.com>
Subject: [PATCH lttng-tools 17/24] Add : Compatibility layer for
	pthread
Date: Mon, 27 Oct 2014 20:49:29 +0000
Message-ID: <1414442926-14381-18-git-send-email-c.briere__21407.983711879$1414443897$gmane$org@samsung.com>
References: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout4.w2.samsung.com ([211.189.100.14]
 helo=usmailout4.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1XirEd-0007nh-4G
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:54 -0400
Received: from uscpsbgex1.samsung.com
 (u122.gpu85.samsung.co.kr [203.254.195.122]) by usmailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NE400KYSF6LOX20@usmailout4.samsung.com> for
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

pthread_cond_timedwait:
	As pthread_cond_timedwait is only used with MONOTONIC
	and that Android provides pthread_cond_timedwait_monotonic_np,
	use that one in the compatibility layer for now.

pthread_cancel:
	pthread_kill with sigkill

Signed-off-by: Charles Briere <c.briere@samsung.com>
---
 configure.ac                               |  3 +++
 src/bin/lttng-consumerd/health-consumerd.c |  2 +-
 src/bin/lttng-consumerd/lttng-consumerd.c  |  2 +-
 src/bin/lttng-relayd/health-relayd.c       |  2 +-
 src/common/compat/Makefile.am              |  3 ++-
 src/common/compat/compat-pthread.c         | 30 +++++++++++++++++++++++++++++
 src/common/compat/pthread.h                | 31 ++++++++++++++++++++++++++++++
 7 files changed, 69 insertions(+), 4 deletions(-)
 create mode 100644 src/common/compat/compat-pthread.c
 create mode 100644 src/common/compat/pthread.h

diff --git a/configure.ac b/configure.ac
index f372b07..e219689 100644
--- a/configure.ac
+++ b/configure.ac
@@ -66,8 +66,11 @@ AC_CHECK_HEADERS([ \
 AC_CHECK_TYPES([in_port_t], [], [], [[#include <netinet/in.h>]])
 
 AC_CHECK_DECLS([sigwaitinfo],[],[], [[#include <signal.h>]])
+AC_CHECK_DECLS([pthread_cancel], [], [], [[#include <pthread.h>]])
+
 AC_CHECK_FUNCS([getpwuid_r],[],[])
 
+
 # Babeltrace viewer check
 AC_ARG_WITH([babeltrace-bin],
 	AS_HELP_STRING([--with-babeltrace-bin],
diff --git a/src/bin/lttng-consumerd/health-consumerd.c b/src/bin/lttng-consumerd/health-consumerd.c
index 5f2415b..618497f 100644
--- a/src/bin/lttng-consumerd/health-consumerd.c
+++ b/src/bin/lttng-consumerd/health-consumerd.c
@@ -27,7 +27,6 @@
 #include <string.h>
 #include <sys/ipc.h>
 #include <sys/resource.h>
-#include <sys/shm.h>
 #include <sys/socket.h>
 #include <common/compat/stat.h>
 #include <sys/types.h>
@@ -46,6 +45,7 @@
 #include <common/consumer-timer.h>
 #include <common/compat/poll.h>
 #include <common/compat/ulimit.h>
+#include <common/compat/shm.h>
 #include <common/sessiond-comm/sessiond-comm.h>
 #include <common/utils.h>
 
diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c b/src/bin/lttng-consumerd/lttng-consumerd.c
index 70605bf..a74ab8b 100644
--- a/src/bin/lttng-consumerd/lttng-consumerd.c
+++ b/src/bin/lttng-consumerd/lttng-consumerd.c
@@ -28,7 +28,6 @@
 #include <string.h>
 #include <sys/ipc.h>
 #include <sys/resource.h>
-#include <sys/shm.h>
 #include <sys/socket.h>
 #include <common/compat/stat.h>
 #include <sys/types.h>
@@ -46,6 +45,7 @@
 #include <common/consumer-timer.h>
 #include <common/compat/poll.h>
 #include <common/compat/ulimit.h>
+#include <common/compat/shm.h>
 #include <common/sessiond-comm/sessiond-comm.h>
 #include <common/utils.h>
 
diff --git a/src/bin/lttng-relayd/health-relayd.c b/src/bin/lttng-relayd/health-relayd.c
index 812fb03..4e22f08 100644
--- a/src/bin/lttng-relayd/health-relayd.c
+++ b/src/bin/lttng-relayd/health-relayd.c
@@ -27,7 +27,6 @@
 #include <string.h>
 #include <sys/ipc.h>
 #include <sys/resource.h>
-#include <sys/shm.h>
 #include <sys/socket.h>
 #include <common/compat/stat.h>
 #include <sys/types.h>
@@ -46,6 +45,7 @@
 #include <common/consumer-timer.h>
 #include <common/compat/poll.h>
 #include <common/compat/ulimit.h>
+#include <common/compat/shm.h>
 #include <common/sessiond-comm/sessiond-comm.h>
 #include <common/utils.h>
 
diff --git a/src/common/compat/Makefile.am b/src/common/compat/Makefile.am
index 2ebe84f..181a80d 100644
--- a/src/common/compat/Makefile.am
+++ b/src/common/compat/Makefile.am
@@ -10,4 +10,5 @@ endif
 
 libcompat_la_SOURCES = poll.h fcntl.h endian.h mman.h clone.h \
                        socket.h compat-fcntl.c uuid.h tid.h netinet/in.h \
-		       limits.h compat-signal.c compat-pwd.c $(COMPAT)
+		       limits.h compat-signal.c compat-pwd.c \
+		       compat-pthread.c $(COMPAT)
diff --git a/src/common/compat/compat-pthread.c b/src/common/compat/compat-pthread.c
new file mode 100644
index 0000000..1573cfc
--- /dev/null
+++ b/src/common/compat/compat-pthread.c
@@ -0,0 +1,30 @@
+#include <common/compat/pthread.h>
+
+# if !HAVE_DECL_PTHREAD_CANCEL
+int pthread_cancel(pthread_t thread) {
+	pthread_kill(thread, SIGKILL);
+}
+
+/*
+ * As for now, Android doesnt support pthread_cond_timedwait but there is a
+ * commit on master which fixes that, but isnt' available in any relases yet.
+ * As of now, pthead_cond_timedwait is only used with MONOTONIC clock so we
+ * will use pthread_cond_timedwait_monotonic instead.
+ *
+ * https://android-review.googlesource.com/#/c/83881/
+ */
+int pthread_condattr_setclock(pthread_condattr_t* cond, clockid_t clockid)
+{
+	return 0;
+}
+
+int pthread_cond_timedwait(pthread_cond_t *cond,
+	       pthread_mutex_t *mutex,
+	       const struct timespec *abstime)
+{
+	return pthread_cond_timedwait_monotonic_np(
+			cond,
+			mutex,
+			abstime);
+}
+# endif /* !HAVE_PTHREAD_CANCEL */
diff --git a/src/common/compat/pthread.h b/src/common/compat/pthread.h
new file mode 100644
index 0000000..8f38321
--- /dev/null
+++ b/src/common/compat/pthread.h
@@ -0,0 +1,31 @@
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
+#ifndef _COMPAT_PTHREAD_H
+#define _COMPAT_PTHREAD_H
+
+# include <pthread.h>
+
+# if !HAVE_DECL_PTHREAD_CANCEL
+int pthread_cancel(pthread_t);
+int pthread_condattr_setclock(pthread_condattr_t *cond, clockid_t clockid);
+int pthread_cond_timedwait(pthread_cond_t *cond,
+	       pthread_mutex_t *mutex,
+	       const struct timespec *abstime);
+# endif /* HAVE_PTHREAD_CANCEL */
+
+#endif /* _COMPAT_PTHREAD_H */
-- 
2.1.2
