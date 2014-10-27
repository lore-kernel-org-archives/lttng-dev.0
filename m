From: Charles Briere <c.briere@samsung.com>
Subject: [PATCH lttng-tools 16/24] Add : Compatibility layer for
	pwd.h
Date: Mon, 27 Oct 2014 20:49:29 +0000
Message-ID: <1414442926-14381-17-git-send-email-c.briere__9927.68219807676$1414443594$gmane$org@samsung.com>
References: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout3.w2.samsung.com ([211.189.100.13]
 helo=usmailout3.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1XirEY-0007nm-Vn
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:48 -0400
Received: from uscpsbgex2.samsung.com
 (u123.gpu85.samsung.co.kr [203.254.195.123]) by usmailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NE4003LOF6LW130@usmailout3.samsung.com> for
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

getpwuid_r() is not implemented in BIONIC ( Android's ) libc
As it is only used to get home directtory, only implemented
that part.

Signed-off-by: Charles Briere <c.briere@samsung.com>
---
 configure.ac                   |  1 +
 src/common/compat/Makefile.am  |  2 +-
 src/common/compat/compat-pwd.c | 28 ++++++++++++++++++++++++++++
 src/common/compat/pwd.h        | 38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 src/common/compat/compat-pwd.c
 create mode 100644 src/common/compat/pwd.h

diff --git a/configure.ac b/configure.ac
index 333d172..f372b07 100644
--- a/configure.ac
+++ b/configure.ac
@@ -66,6 +66,7 @@ AC_CHECK_HEADERS([ \
 AC_CHECK_TYPES([in_port_t], [], [], [[#include <netinet/in.h>]])
 
 AC_CHECK_DECLS([sigwaitinfo],[],[], [[#include <signal.h>]])
+AC_CHECK_FUNCS([getpwuid_r],[],[])
 
 # Babeltrace viewer check
 AC_ARG_WITH([babeltrace-bin],
diff --git a/src/common/compat/Makefile.am b/src/common/compat/Makefile.am
index 5fb04a8..2ebe84f 100644
--- a/src/common/compat/Makefile.am
+++ b/src/common/compat/Makefile.am
@@ -10,4 +10,4 @@ endif
 
 libcompat_la_SOURCES = poll.h fcntl.h endian.h mman.h clone.h \
                        socket.h compat-fcntl.c uuid.h tid.h netinet/in.h \
-		       limits.h compat-signal.c $(COMPAT)
+		       limits.h compat-signal.c compat-pwd.c $(COMPAT)
diff --git a/src/common/compat/compat-pwd.c b/src/common/compat/compat-pwd.c
new file mode 100644
index 0000000..52fc1fc
--- /dev/null
+++ b/src/common/compat/compat-pwd.c
@@ -0,0 +1,28 @@
+/*
+ * Copyright (C)  2014 - Charles Briere <c.briere@samsung.com>
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
+#include <common/compat/pwd.h>
+
+#ifndef HAVE_GETPWUID_R
+
+int getpwuid_r(uid_t uid, struct passwd *pwd, char *buf, size_t buflen, struct passwd **result)
+{
+	strcpy(pwd->pw_dir, "/sdcard");
+	return 0;
+}
+
+#endif
diff --git a/src/common/compat/pwd.h b/src/common/compat/pwd.h
new file mode 100644
index 0000000..6debf92
--- /dev/null
+++ b/src/common/compat/pwd.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright 2014 (c) - Charles Briere <c.briere@samsung.com>
+ *
+ * pwd compatibility layer.
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
+#include <sys/types.h>
+#include <pwd.h>
+
+#ifndef LTTNG_PWD_H
+#define LTTNG_PWD_H
+
+# ifndef HAVE_GETPWUID_R
+
+#include <string.h>
+
+int getpwuid_r(uid_t uid, struct passwd *pwd, char *buf, size_t buflen, struct passwd **result);
+
+# endif
+#endif
-- 
2.1.2
