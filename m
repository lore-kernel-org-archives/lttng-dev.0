From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust 2/4] Use config.h to define SONAME
 major number
Date: Thu, 20 Dec 2018 15:22:40 -0500
Message-ID: <20181220202242.6119-2-mjeanson__42219.3075101406$1545337265$gmane$org@efficios.com>
References: <20181220202242.6119-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43LNVL6JbRz16bn
 for <lttng-dev@lists.lttng.org>; Thu, 20 Dec 2018 15:22:50 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id D7167A7B9B
 for <lttng-dev@lists.lttng.org>; Thu, 20 Dec 2018 15:22:50 -0500 (EST)
In-Reply-To: <20181220202242.6119-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 configure.ac                  | 2 +-
 liblttng-ust/Makefile.am      | 2 --
 liblttng-ust/lttng-ust-comm.c | 2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 431ed21a..9ab76501 100644
--- a/configure.ac
+++ b/configure.ac
@@ -25,7 +25,7 @@ m4_define([UST_LIB_V_MINOR], [0])
 m4_define([UST_LIB_V_PATCH], [0])
 
 AC_SUBST([LTTNG_UST_LIBRARY_VERSION], [UST_LIB_V_MAJOR:UST_LIB_V_MINOR:UST_LIB_V_PATCH])
-AC_SUBST([LTTNG_UST_LIBRARY_VERSION_MAJOR], [UST_LIB_V_MAJOR])
+AC_DEFINE([CONFIG_LTTNG_UST_LIBRARY_VERSION_MAJOR], [UST_LIB_V_MAJOR], [Major SONAME number of the ust library])
 # note: remember to update tracepoint.h dlopen() to match this version
 # number. TODO: eventually automate by exporting the major number.
 
diff --git a/liblttng-ust/Makefile.am b/liblttng-ust/Makefile.am
index ea4c8f61..15655280 100644
--- a/liblttng-ust/Makefile.am
+++ b/liblttng-ust/Makefile.am
@@ -63,8 +63,6 @@ liblttng_ust_runtime_la_SOURCES = \
 	string-utils.c \
 	string-utils.h
 
-liblttng_ust_runtime_la_CFLAGS = -DLTTNG_UST_LIBRARY_VERSION_MAJOR=\"$(LTTNG_UST_LIBRARY_VERSION_MAJOR)\"
-
 if HAVE_PERF_EVENT
 liblttng_ust_runtime_la_SOURCES += \
 	lttng-context-perf-counters.c \
diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
index a09f676a..eab2d8eb 100644
--- a/liblttng-ust/lttng-ust-comm.c
+++ b/liblttng-ust/lttng-ust-comm.c
@@ -61,7 +61,7 @@
 #include "getenv.h"
 
 /* Concatenate lttng ust shared library name with its major version number. */
-#define LTTNG_UST_LIB_SO_NAME "liblttng-ust.so." LTTNG_UST_LIBRARY_VERSION_MAJOR
+#define LTTNG_UST_LIB_SO_NAME "liblttng-ust.so." __ust_stringify(CONFIG_LTTNG_UST_LIBRARY_VERSION_MAJOR)
 
 /*
  * Has lttng ust comm constructor been called ?
-- 
2.17.1
