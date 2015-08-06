From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 1/3] Build: rename use_python to
	python_binding
Date: Thu,  6 Aug 2015 19:00:14 -0400
Message-ID: <1438902016-17511-1-git-send-email-jonathan.rajotte-julien__19326.3761736036$1438902114$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZNU9S-0007iR-0Z
 for lttng-dev@lists.lttng.org; Thu, 06 Aug 2015 19:00:42 -0400
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 configure.ac                     | 8 ++++----
 extras/bindings/swig/Makefile.am | 2 +-
 tests/Makefile.am                | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4e6c06e..312b9f7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -333,11 +333,11 @@ swig_version=2.0.0
 AC_ARG_ENABLE([python-bindings],
               [AC_HELP_STRING([--enable-python-bindings],
                               [compile Python bindings])],
-              [enable_python=yes], [enable_python=no])
+              [enable_python_binding=yes], [enable_python_binding=no])
 
-AM_CONDITIONAL([USE_PYTHON], [test "x${enable_python:-yes}" = xyes])
+AM_CONDITIONAL([PYTHON_BINDING], [test "x${enable_python_binding:-yes}" = xyes])
 
-if test "x${enable_python:-yes}" = xyes; then
+if test "x${enable_python_binding:-yes}" = xyes; then
   AX_PKG_SWIG($swig_version, [], [ AC_MSG_ERROR([SWIG $swig_version or newer is needed]) ])
   AM_PATH_PYTHON
 
@@ -608,7 +608,7 @@ AS_IF([test "x$test_java_agent_log4j" = "xyes"],[
 
 #Python binding enabled/disabled
 AS_ECHO_N("Python binding: ")
-AS_IF([test "x${enable_python:-yes}" = xyes], [
+AS_IF([test "x${enable_python_binding:-yes}" = xyes], [
 	AS_ECHO("Enabled")
 ],[
 	AS_ECHO("Disabled")
diff --git a/extras/bindings/swig/Makefile.am b/extras/bindings/swig/Makefile.am
index dcd868d..f1100d9 100644
--- a/extras/bindings/swig/Makefile.am
+++ b/extras/bindings/swig/Makefile.am
@@ -1,3 +1,3 @@
-if USE_PYTHON
+if PYTHON_BINDING
 SUBDIRS = python
 endif
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 2f1f1c3..d72b1ec 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -3,14 +3,14 @@ SUBDIRS = utils regression unit stress
 installcheck-am:
 	./run.sh unit_tests
 	./run.sh fast_regression
-if USE_PYTHON
+if PYTHON_BINDING
 	./run.sh with_bindings_regression
 endif
 
 check-am:
 	./run.sh unit_tests
 	./run.sh fast_regression
-if USE_PYTHON
+if PYTHON_BINDING
 	./run.sh with_bindings_regression
 endif
 
-- 
2.1.4
