From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH babeltrace 3/3] Port: Add OSX libuuid compat
Date: Thu,  5 Nov 2015 12:51:55 -0500
Message-ID: <1446745915-1651-3-git-send-email-mjeanson__49462.3341168792$1446746000$gmane$org@efficios.com>
References: <1446745915-1651-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZuOhv-0004Ud-CO
 for lttng-dev@lists.lttng.org; Thu, 05 Nov 2015 12:52:22 -0500
In-Reply-To: <1446745915-1651-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

OSX has the libuuid symbols built in the system libraries.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 configure.ac | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/configure.ac b/configure.ac
index f23e460..9c42017 100644
--- a/configure.ac
+++ b/configure.ac
@@ -148,29 +148,37 @@ AM_CONDITIONAL([BABELTRACE_BUILD_WITH_MINGW], [test "x$MINGW32" = "xyes"])
 # Check what libraries are required on this platform to link sockets programs.
 AX_LIB_SOCKET_NSL
 
-# Check for libuuid
-AC_CHECK_LIB([uuid], [uuid_generate],
+# Check for uuid in system libs
+AC_CHECK_FUNCS([uuid_generate],
 [
-	AC_DEFINE_UNQUOTED([BABELTRACE_HAVE_LIBUUID], 1, [Has libuuid support.])
-	have_libuuid=yes
+  AC_DEFINE_UNQUOTED([BABELTRACE_HAVE_LIBUUID], 1, [Has libuuid support.])
+  link_with_libuuid=no
 ],
 [
-	# libuuid not found, check for uuid_create in libc.
-	AC_CHECK_LIB([c], [uuid_create],
-	[
-		AC_DEFINE_UNQUOTED([BABELTRACE_HAVE_LIBC_UUID], 1, [Has libc uuid support.])
-		have_libc_uuid=yes
-	],
-	[
-		# for MinGW32 we have our own internal implemenation of uuid using Windows functions.
-		if test "x$MINGW32" = xno; then
-			AC_MSG_ERROR([Cannot find libuuid uuid_generate nor libc uuid_create. Use [LDFLAGS]=-Ldir to specify their location.])
-		fi
-	])
-]
-)
-AM_CONDITIONAL([BABELTRACE_BUILD_WITH_LIBUUID], [test "x$have_libuuid" = "xyes"])
-AM_CONDITIONAL([BABELTRACE_BUILD_WITH_LIBC_UUID], [test "x$have_libc_uuid" = "xyes"])
+  # Check for libuuid
+  AC_CHECK_LIB([uuid], [uuid_generate],
+  [
+    AC_DEFINE_UNQUOTED([BABELTRACE_HAVE_LIBUUID], 1, [Has libuuid support.])
+    link_with_libuuid=yes
+  ],
+  [
+    # libuuid not found, check for uuid_create in libc.
+    AC_CHECK_LIB([c], [uuid_create],
+    [
+      AC_DEFINE_UNQUOTED([BABELTRACE_HAVE_LIBC_UUID], 1, [Has libc uuid support.])
+      link_with_libc_uuid=yes
+    ],
+    [
+      # for MinGW32 we have our own internal implemenation of uuid using Windows functions.
+      if test "x$MINGW32" = xno; then
+        AC_MSG_ERROR([Cannot find libuuid uuid_generate nor libc uuid_create. Use [LDFLAGS]=-Ldir to specify their location.])
+      fi
+    ])
+  ])
+])
+
+AM_CONDITIONAL([BABELTRACE_BUILD_WITH_LIBUUID], [test "x$link_with_libuuid" = "xyes"])
+AM_CONDITIONAL([BABELTRACE_BUILD_WITH_LIBC_UUID], [test "x$link_with_libc_uuid" = "xyes"])
 
 # Check for fmemopen
 AC_CHECK_LIB([c], [fmemopen],
-- 
1.9.1
