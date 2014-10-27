From: Charles Briere <c.briere@samsung.com>
Subject: [PATCH lttng-tools 10/24] Add : Compatibility layer for
	netinet/in.h
Date: Mon, 27 Oct 2014 20:49:29 +0000
Message-ID: <1414442926-14381-11-git-send-email-c.briere__763.020051135932$1414443394$gmane$org@samsung.com>
References: <1414442926-14381-1-git-send-email-c.briere@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout3.w2.samsung.com ([211.189.100.13]
 helo=usmailout3.samsung.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <c.briere@samsung.com>) id 1XirEV-0007nm-ET
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 16:49:45 -0400
Received: from uscpsbgex4.samsung.com
 (u125.gpu85.samsung.co.kr [203.254.195.125]) by usmailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NE4003LKF6KW130@usmailout3.samsung.com> for
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

Add definition for in_port_t

Signed-off-by: Charles Briere <c.briere@samsung.com>
---
 configure.ac                   |  2 ++
 src/common/compat/Makefile.am  |  3 ++-
 src/common/compat/netinet/in.h | 35 +++++++++++++++++++++++++++++++++++
 src/common/uri.h               |  2 +-
 4 files changed, 40 insertions(+), 2 deletions(-)
 create mode 100644 src/common/compat/netinet/in.h

diff --git a/configure.ac b/configure.ac
index 1189d8e..3b880c9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -62,6 +62,8 @@ AC_CHECK_HEADERS([ \
 	[AC_CHECK_HEADERS([sys/syscall.h])]
 )
 
+AC_CHECK_TYPES([in_port_t], [], [], [[#include <netinet/in.h>]])
+
 # Babeltrace viewer check
 AC_ARG_WITH([babeltrace-bin],
 	AS_HELP_STRING([--with-babeltrace-bin],
diff --git a/src/common/compat/Makefile.am b/src/common/compat/Makefile.am
index 537375b..40495ed 100644
--- a/src/common/compat/Makefile.am
+++ b/src/common/compat/Makefile.am
@@ -9,4 +9,5 @@ COMPAT=compat-poll.c
 endif
 
 libcompat_la_SOURCES = poll.h fcntl.h endian.h mman.h clone.h \
-                       socket.h compat-fcntl.c uuid.h tid.h $(COMPAT)
+                       socket.h compat-fcntl.c uuid.h tid.h netinet/in.h \
+		       $(COMPAT)
diff --git a/src/common/compat/netinet/in.h b/src/common/compat/netinet/in.h
new file mode 100644
index 0000000..96981e2
--- /dev/null
+++ b/src/common/compat/netinet/in.h
@@ -0,0 +1,35 @@
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
+#ifndef LTTNG_NETINET_IN_H
+#define LTTNG_NETINET_IN_H
+
+#include <netinet/in.h>
+#include <config.h>
+
+# ifndef HAVE_IN_PORT_T
+typedef uint16_t in_port_t;
+# endif
+
+#endif
diff --git a/src/common/uri.h b/src/common/uri.h
index 3ef6669..7f2f5b6 100644
--- a/src/common/uri.h
+++ b/src/common/uri.h
@@ -18,7 +18,7 @@
 #ifndef URI_H
 #define URI_H
 
-#include <netinet/in.h>
+#include <common/compat/netinet/in.h>
 #include <lttng/lttng.h>
 
 /* Destination type of lttng URI */
-- 
2.1.2
