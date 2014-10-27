From: Charles Briere <c.briere@samsung.com>
Subject: [PATCH lttng-tools 12/24] Add : Compatibility layer for
	ulimit.h
Date: Mon, 27 Oct 2014 20:49:29 +0000
Message-ID: <1414442926-14381-13-git-send-email-c.briere__9075.84852907366$1414443432$gmane$org@samsung.com>
References: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout1.w2.samsung.com ([211.189.100.11]
 helo=usmailout1.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1XirEV-0007nk-B3
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:45 -0400
Received: from uscpsbgex2.samsung.com
 (u123.gpu85.samsung.co.kr [203.254.195.123]) by mailout1.w2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NE400F00F6K0940@mailout1.w2.samsung.com> for
 lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:32 -0400 (EDT)
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
 configure.ac                               |  1 +
 src/bin/lttng-consumerd/health-consumerd.c |  2 +-
 src/bin/lttng-consumerd/lttng-consumerd.c  |  2 +-
 src/bin/lttng-relayd/health-relayd.c       |  2 +-
 src/common/compat/ulimit.h                 | 29 +++++++++++++++++++++++++++++
 5 files changed, 33 insertions(+), 3 deletions(-)
 create mode 100644 src/common/compat/ulimit.h

diff --git a/configure.ac b/configure.ac
index 3b880c9..fc08cc6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -58,6 +58,7 @@ AC_CHECK_HEADERS([ \
 	sys/types.h unistd.h fcntl.h string.h pthread.h limits.h \
 	signal.h stdlib.h sys/un.h sys/socket.h stdlib.h stdio.h \
 	getopt.h sys/ipc.h sys/shm.h popt.h grp.h syscall.h \
+	ulimit.h \
 	],[],
 	[AC_CHECK_HEADERS([sys/syscall.h])]
 )
diff --git a/src/bin/lttng-consumerd/health-consumerd.c b/src/bin/lttng-consumerd/health-consumerd.c
index 079a14b..3af18e7 100644
--- a/src/bin/lttng-consumerd/health-consumerd.c
+++ b/src/bin/lttng-consumerd/health-consumerd.c
@@ -38,7 +38,6 @@
 #include <assert.h>
 #include <config.h>
 #include <urcu/compiler.h>
-#include <ulimit.h>
 #include <inttypes.h>
 
 #include <common/defaults.h>
@@ -46,6 +45,7 @@
 #include <common/consumer.h>
 #include <common/consumer-timer.h>
 #include <common/compat/poll.h>
+#include <common/compat/ulimit.h>
 #include <common/sessiond-comm/sessiond-comm.h>
 #include <common/utils.h>
 
diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c b/src/bin/lttng-consumerd/lttng-consumerd.c
index bdd8ddc..f1bd287 100644
--- a/src/bin/lttng-consumerd/lttng-consumerd.c
+++ b/src/bin/lttng-consumerd/lttng-consumerd.c
@@ -39,13 +39,13 @@
 #include <assert.h>
 #include <config.h>
 #include <urcu/compiler.h>
-#include <ulimit.h>
 
 #include <common/defaults.h>
 #include <common/common.h>
 #include <common/consumer.h>
 #include <common/consumer-timer.h>
 #include <common/compat/poll.h>
+#include <common/compat/ulimit.h>
 #include <common/sessiond-comm/sessiond-comm.h>
 #include <common/utils.h>
 
diff --git a/src/bin/lttng-relayd/health-relayd.c b/src/bin/lttng-relayd/health-relayd.c
index 3a5cc90..312edd5 100644
--- a/src/bin/lttng-relayd/health-relayd.c
+++ b/src/bin/lttng-relayd/health-relayd.c
@@ -38,7 +38,6 @@
 #include <assert.h>
 #include <config.h>
 #include <urcu/compiler.h>
-#include <ulimit.h>
 #include <inttypes.h>
 
 #include <common/defaults.h>
@@ -46,6 +45,7 @@
 #include <common/consumer.h>
 #include <common/consumer-timer.h>
 #include <common/compat/poll.h>
+#include <common/compat/ulimit.h>
 #include <common/sessiond-comm/sessiond-comm.h>
 #include <common/utils.h>
 
diff --git a/src/common/compat/ulimit.h b/src/common/compat/ulimit.h
new file mode 100644
index 0000000..1140c99
--- /dev/null
+++ b/src/common/compat/ulimit.h
@@ -0,0 +1,29 @@
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
+#ifndef _COMPAT_ULIMIT_H
+#define _COMPAT_ULIMIT_H
+
+#include <config.h>
+
+# ifdef HAVE_ULIMIT
+#  include <ulimit.h>
+# else
+
+# endif /* HAVE_ULIMIT */
+
+#endif  /*_COMPAT_ULIMIT_H */
-- 
2.1.2
