From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] fix: check for dtrace and sdt.h
 before enabling SDT uprobe tests
Date: Thu, 31 Oct 2019 16:12:46 -0400
Message-ID: <20191031201246.5944-1-mjeanson__47051.7126073659$1572552799$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 473xMZ4PKhzs8K
 for <lttng-dev@lists.lttng.org>; Thu, 31 Oct 2019 16:12:58 -0400 (EDT)
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

Add a configure switch '--enable-sdt-uprobe / --disable-sdt-uprobe', the
default behavior of enabling the test if the requirements are found is
kept but it's now possible to explicitly disable it.

Also add the detection of the dtrace binary and its override trough the
DTRACE environment variable.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 configure.ac                                  | 37 +++++++++++++++++--
 tests/utils/testapp/Makefile.am               |  4 +-
 .../userspace-probe-sdt-binary/Makefile.am    |  8 +++-
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index 8c0683fe2..ab0a15b2d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -25,9 +25,6 @@ AC_PROG_CXX
 RW_PROG_CXX_WORKS
 AM_CONDITIONAL([CXX_WORKS], [test "x$rw_cv_prog_cxx_works" = "xyes"])
 
-LTTNG_CHECK_SDT_WORKS
-AM_CONDITIONAL([SDT_WORKS], [test "x$lttng_cv_sdt_works" = "xyes"])
-
 # Checks for programs.
 AC_PROG_GREP
 AC_PROG_MAKE_SET
@@ -815,6 +812,36 @@ AC_SUBST([RUN_PYTHON_AGENT_TEST])
 AC_SUBST([PYTHON2_AGENT])
 AC_SUBST([PYTHON3_AGENT])
 
+AC_ARG_ENABLE([test-sdt-uprobe],
+  [AS_HELP_STRING([--enable-test-sdt-uprobe], [enable the LTTng UST SDT uprobe tests [default=autodetect]])],
+  [test_sdt_uprobe="$enableval"],
+  [test_sdt_uprobe=autodetect]
+)
+
+AS_IF([test "$test_sdt_uprobe" != "no"], [
+  LTTNG_CHECK_SDT_WORKS
+  AC_PATH_PROG([DTRACE], [dtrace])
+])
+
+AS_IF([test "$test_sdt_uprobe" = "yes"], [
+  AS_IF([test "$lttng_cv_sdt_works" = "no"], [
+    AC_MSG_ERROR([Cannot find 'sys/sdt.h'.])
+  ])
+  AS_IF([test "x$DTRACE" = "x"], [
+    AC_MSG_ERROR([Cannot find SystemTap dtrace. You can set the DTRACE variable to override automatic detection.])
+  ])
+])
+
+AS_IF([test "$test_sdt_uprobe" = "autodetect"], [
+  AS_IF([test "$lttng_cv_sdt_works" = "yes"], [
+    AS_IF([test "x$DTRACE" != "x"], [
+      test_sdt_uprobe=yes
+    ])
+  ])
+])
+
+AM_CONDITIONAL([TEST_SDT_UPROBE], [test "$test_sdt_uprobe" = "yes"])
+
 # Arguments for binaries build exclusion
 AC_ARG_ENABLE([bin-lttng], AS_HELP_STRING([--disable-bin-lttng],[Disable the build of lttng binaries]))
 AC_ARG_ENABLE([bin-lttng-consumerd], AS_HELP_STRING([--disable-bin-lttng-consumerd],
@@ -1243,6 +1270,10 @@ PPRINT_PROP_BOOL([LTTng-UST Python2 agent tests], $value)
 test ! -z "$PYTHON3_AGENT" && value=1 || value=0
 PPRINT_PROP_BOOL([LTTng-UST Python3 agent tests], $value)
 
+# LTTng UST Java agent Log4j tests enabled/disabled
+test "x$test_sdt_uprobe" = "xyes" && value=1 || value=0
+PPRINT_PROP_BOOL([LTTng-UST SDT uprobe tests], $value)
+
 #Python binding enabled/disabled
 test "x$enable_python_binding" = xyes && value=1 || value=0
 AS_ECHO
diff --git a/tests/utils/testapp/Makefile.am b/tests/utils/testapp/Makefile.am
index 2a4cf5c7b..e2ad1f235 100644
--- a/tests/utils/testapp/Makefile.am
+++ b/tests/utils/testapp/Makefile.am
@@ -12,9 +12,9 @@ if CXX_WORKS
 SUBDIRS += userspace-probe-elf-cxx-binary
 endif # CXX_WORKS
 
-if SDT_WORKS
+if TEST_SDT_UPROBE
 SUBDIRS += userspace-probe-sdt-binary
-endif # SDT_WORKS
+endif # TEST_SDT_UPROBE
 
 if HAVE_MODULES_USERSPACE_CALLSTACK_CONTEXT
 SUBDIRS += gen-syscall-events-callstack
diff --git a/tests/utils/testapp/userspace-probe-sdt-binary/Makefile.am b/tests/utils/testapp/userspace-probe-sdt-binary/Makefile.am
index d79ce0ea3..591f4aa6c 100644
--- a/tests/utils/testapp/userspace-probe-sdt-binary/Makefile.am
+++ b/tests/utils/testapp/userspace-probe-sdt-binary/Makefile.am
@@ -26,10 +26,14 @@ libzzz_la_CFLAGS = -I$(abs_builddir)
 libzzz_la_LDFLAGS = -module -shared -avoid-version -rpath $(abs_builddir)/.libs/
 nodist_libzzz_la_SOURCES = $(abs_builddir)/foobar_provider.h
 
+dtrace_verbose = $(dtrace_verbose_@AM_V@)
+dtrace_verbose_ = $(dtrace_verbose_@AM_DEFAULT_V@)
+dtrace_verbose_0 = @echo "  DTRACE  " $@;
+
 foobar_provider.h: foobar_provider.d
-	dtrace -s $< -o $@ -h
+	$(dtrace_verbose)$(DTRACE) -s $< -o $@ -h
 
 foobar_provider.o: foobar_provider.d
-	dtrace -s $< -o $@ -G
+	$(dtrace_verbose)$(DTRACE) -s $< -o $@ -G
 
 CLEANFILES = foobar_provider.h
-- 
2.17.1
