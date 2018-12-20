From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Remove duplicate check for dlopen
Date: Thu, 20 Dec 2018 16:16:47 -0500
Message-ID: <20181220211647.19327-1-mjeanson__33163.6869967498$1545340502$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43LPhn754Lz16ld
 for <lttng-dev@lists.lttng.org>; Thu, 20 Dec 2018 16:16:57 -0500 (EST)
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
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 configure.ac | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/configure.ac b/configure.ac
index bf1ef6f2..fa0edc44 100644
--- a/configure.ac
+++ b/configure.ac
@@ -217,15 +217,18 @@ AC_CHECK_LIB([rt], [clock_gettime, timer_create, timer_settime, timer_delete])
 AC_CHECK_LIB([dl], [dlopen], [
 	have_libdl=yes
 	libdl_name=dl
+	DL_LIBS="-ldl"
 ], [
 	# libdl not found, check for dlopen in libc.
 	AC_CHECK_LIB([c], [dlopen], [
 		have_libc_dl=yes
 		libdl_name=c
+		DL_LIBS="-lc"
 	], [
 		AC_MSG_ERROR([Cannot find dlopen in libdl nor libc. Use [LDFLAGS]=-Ldir to specify their location.])
 	])
 ])
+AC_SUBST(DL_LIBS)
 
 # Check if libdl has dlmopen support.
 AH_TEMPLATE([HAVE_DLMOPEN], ["Define to 1 if dlmopen is available."])
@@ -570,20 +573,6 @@ AS_IF([test "x$with_lttng_ust" = "xyes"],
 AM_CONDITIONAL([HAVE_LIBLTTNG_UST_CTL], [test "x$with_lttng_ust" = "xyes"])
 
 
-
-# check for dlopen
-AC_CHECK_LIB([dl], [dlopen],
-  [DL_LIBS="-ldl"],
-  [
-    #libdl not found, check for dlopen in libc.
-    AC_CHECK_LIB([c], [dlopen],
-      [DL_LIBS="-lc"],
-      [AC_MSG_FAILURE([Cannot find dlopen in libdl nor libc. Use [LDFLAGS]=-Ldir to specify their location.])]
-    )
-  ]
-)
-AC_SUBST(DL_LIBS)
-
 # Check for fmemopen
 AC_CHECK_LIB([c], [fmemopen],
 [
-- 
2.17.1
