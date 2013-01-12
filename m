From: Samuel Martin <s.martin49@gmail.com>
Subject: [PATCH] don't build C++ example if a C++ compiler isn't
	available
Date: Sat, 12 Jan 2013 09:24:48 +0100
Message-ID: <1357979088-28687-1-git-send-email-s.martin49__7818.08023243702$1357979176$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <s.martin49@gmail.com>) id 1TtwPF-0007nE-J5
	for lttng-dev@lists.lttng.org; Sat, 12 Jan 2013 03:25:33 -0500
Received: by mail-wi0-f181.google.com with SMTP id hq4so291179wib.8
	for <lttng-dev@lists.lttng.org>; Sat, 12 Jan 2013 00:25:27 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

By default lttng-ust builds a hello.cxx C++ example that demonstrates
the usage of the userspace tracing library in a C++ program.
Unfortunately, when no C++ support is available, the build of lttng-ust
fails just because of this example code. So we make the compilation of
this code conditional on whether a working C++ compiler was found.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Samuel Martin <s.martin49@gmail.com>
---
 configure.ac      | 12 ++++++++++++
 tests/Makefile.am |  6 +++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index c4377a5..d33be32 100644
--- a/configure.ac
+++ b/configure.ac
@@ -77,6 +77,18 @@ AC_PROG_CXX
 AC_PROG_MAKE_SET
 LT_INIT
 
+# rw_PROG_CXX_WORKS
+# Check whether the C++ compiler works.
+AC_CACHE_CHECK([whether the C++ compiler works],
+		[rw_cv_prog_cxx_works],
+		[AC_LANG_PUSH([C++])
+		AC_LINK_IFELSE([AC_LANG_PROGRAM([], [])],
+				[rw_cv_prog_cxx_works=yes],
+				[rw_cv_prog_cxx_works=no])
+		AC_LANG_POP([C++])])
+
+AM_CONDITIONAL([CXX_WORKS], [test "x$rw_cv_prog_cxx_works" = "xyes"])
+
 ## Checks for libraries.
 AC_CHECK_LIB([dl], [dlopen],
 [
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 2b12422..7365ce4 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -1,7 +1,11 @@
 SUBDIRS = . hello hello-static-lib fork ust-basic-tracing ust-multi-test \
-		demo hello.cxx daemon
+		demo daemon
 #SUBDIRS = . hello2 basic basic_long simple_include snprintf test-nevents test-libustinstr-malloc dlopen same_line_marker trace_event register_test tracepoint libustctl_function_tests exit-fast
 
+if CXX_WORKS
+SUBDIRS += hello.cxx
+endif
+
 dist_noinst_SCRIPTS = test_loop runtests trace_matches
 
 noinst_LIBRARIES = libtap.a
-- 
1.8.1
