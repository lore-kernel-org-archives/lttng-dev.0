From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust] Cleanup: test Makefiles
Date: Mon, 14 Jan 2019 16:29:28 -0500
Message-ID: <20190114212928.6469-1-mjeanson__25819.7677707814$1547501270$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43dmp42lQmzp2v
 for <lttng-dev@lists.lttng.org>; Mon, 14 Jan 2019 16:29:48 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 5E86DB1DE3
 for <lttng-dev@lists.lttng.org>; Mon, 14 Jan 2019 16:29:42 -0500 (EST)
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

Remove unnessary complexity and use specific names for test programs.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 .gitignore                                    |  5 ++--
 configure.ac                                  |  2 ++
 tests/gcc-weak-hidden/Makefile.am             | 14 +++--------
 tests/gcc-weak-hidden/test_gcc_weak_hidden.in |  4 ----
 tests/snprintf/Makefile.am                    | 24 +++----------------
 tests/snprintf/{prog.c => snprintf.c}         |  0
 tests/snprintf/test_snprintf                  |  4 ----
 tests/ust-elf/Makefile.am                     | 14 ++++-------
 tests/ust-elf/test_ust_elf.in                 |  4 ++--
 tests/ust-elf/{prog.c => ust-elf.c}           |  0
 10 files changed, 16 insertions(+), 55 deletions(-)
 delete mode 100755 tests/gcc-weak-hidden/test_gcc_weak_hidden.in
 rename tests/snprintf/{prog.c => snprintf.c} (100%)
 delete mode 100755 tests/snprintf/test_snprintf
 mode change 100755 => 100644 tests/ust-elf/test_ust_elf.in
 rename tests/ust-elf/{prog.c => ust-elf.c} (100%)

diff --git a/.gitignore b/.gitignore
index 482c6520..78646d74 100644
--- a/.gitignore
+++ b/.gitignore
@@ -74,14 +74,13 @@ tests/ust-multi-test/ust-multi-test
 tests/trace_event/trace_event_test
 tests/tracepoint/benchmark/tracepoint_benchmark
 tests/tracepoint/tracepoint_test
-tests/snprintf/prog
-tests/ust-elf/prog
+tests/snprintf/test_snprintf
+tests/ust-elf/ust-elf
 tests/ust-elf/test_ust_elf
 tests/benchmark/bench1
 tests/benchmark/bench2
 tests/ctf-types/ctf-types
 tests/test-app-ctx/hello
-tests/gcc-weak-hidden/test-gcc-wh
 tests/gcc-weak-hidden/test_gcc_weak_hidden
 
 # Java agent library
diff --git a/configure.ac b/configure.ac
index f9ee053f..9ab76501 100644
--- a/configure.ac
+++ b/configure.ac
@@ -565,6 +565,8 @@ AC_CONFIG_LINKS([
 	python-lttngust/lttngust/loghandler.py:python-lttngust/lttngust/loghandler.py
 ])
 
+AC_CONFIG_FILES([tests/ust-elf/test_ust_elf],[chmod +x tests/ust-elf/test_ust_elf])
+
 AC_OUTPUT
 
 
diff --git a/tests/gcc-weak-hidden/Makefile.am b/tests/gcc-weak-hidden/Makefile.am
index eaeb2509..be9032a3 100644
--- a/tests/gcc-weak-hidden/Makefile.am
+++ b/tests/gcc-weak-hidden/Makefile.am
@@ -3,15 +3,7 @@ AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/tests/utils
 noinst_LTLIBRARIES = libgcc-wh.la
 libgcc_wh_la_SOURCES = c.c d.c
 
-noinst_PROGRAMS = test-gcc-wh
-test_gcc_wh_SOURCES = main.c b.c
-test_gcc_wh_LDADD = $(top_builddir)/tests/utils/libtap.a \
+noinst_PROGRAMS = test_gcc_weak_hidden
+test_gcc_weak_hidden_SOURCES = main.c b.c
+test_gcc_weak_hidden_LDADD = $(top_builddir)/tests/utils/libtap.a \
 	$(builddir)/libgcc-wh.la
-
-noinst_SCRIPTS = test_gcc_weak_hidden
-CLEANFILES = $(noinst_SCRIPTS)
-EXTRA_DIST = test_gcc_weak_hidden.in
-
-$(noinst_SCRIPTS): %: %.in
-	$(SED) "s#@ABSTOPSRCDIR@#$(abs_top_srcdir)#g" < $< > $@
-	chmod +x $@
diff --git a/tests/gcc-weak-hidden/test_gcc_weak_hidden.in b/tests/gcc-weak-hidden/test_gcc_weak_hidden.in
deleted file mode 100755
index 7ad101f7..00000000
--- a/tests/gcc-weak-hidden/test_gcc_weak_hidden.in
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/bash
-
-TEST_DIR=$(dirname $0)
-./${TEST_DIR}/test-gcc-wh
diff --git a/tests/snprintf/Makefile.am b/tests/snprintf/Makefile.am
index 43021562..719e1cc8 100644
--- a/tests/snprintf/Makefile.am
+++ b/tests/snprintf/Makefile.am
@@ -1,24 +1,6 @@
 AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/tests/utils
 
-noinst_PROGRAMS = prog
-prog_SOURCES = prog.c
-prog_LDADD = $(top_builddir)/snprintf/libustsnprintf.la \
+noinst_PROGRAMS = test_snprintf
+test_snprintf_SOURCES = snprintf.c
+test_snprintf_LDADD = $(top_builddir)/snprintf/libustsnprintf.la \
 	$(top_builddir)/tests/utils/libtap.a
-
-SCRIPT_LIST = test_snprintf
-
-dist_noinst_SCRIPTS = $(SCRIPT_LIST)
-
-all-local:
-	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
-		for script in $(SCRIPT_LIST); do \
-			cp -f $(srcdir)/$$script $(builddir); \
-		done; \
-	fi
-
-clean-local:
-	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
-		for script in $(SCRIPT_LIST); do \
-			rm -f $(builddir)/$$script; \
-		done; \
-	fi
diff --git a/tests/snprintf/prog.c b/tests/snprintf/snprintf.c
similarity index 100%
rename from tests/snprintf/prog.c
rename to tests/snprintf/snprintf.c
diff --git a/tests/snprintf/test_snprintf b/tests/snprintf/test_snprintf
deleted file mode 100755
index cc77d408..00000000
--- a/tests/snprintf/test_snprintf
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/bash
-
-TEST_DIR=$(dirname $0)
-./${TEST_DIR}/prog
diff --git a/tests/ust-elf/Makefile.am b/tests/ust-elf/Makefile.am
index 203272ed..f115eea4 100644
--- a/tests/ust-elf/Makefile.am
+++ b/tests/ust-elf/Makefile.am
@@ -1,13 +1,11 @@
 AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/tests/utils
 
-noinst_PROGRAMS = prog
-prog_SOURCES = prog.c
-prog_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la \
+noinst_PROGRAMS = ust-elf
+ust_elf_SOURCES = ust-elf.c
+ust_elf_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la \
 	$(top_builddir)/tests/utils/libtap.a
 
-noinst_SCRIPTS = test_ust_elf
-CLEANFILES = $(noinst_SCRIPTS)
-EXTRA_DIST = test_ust_elf.in \
+EXTRA_DIST = \
 	$(srcdir)/data/main.c \
 	$(srcdir)/data/aarch64_be/main.elf \
 	$(srcdir)/data/aarch64_be/main.elf.debug \
@@ -22,7 +20,3 @@ EXTRA_DIST = test_ust_elf.in \
 	$(srcdir)/data/pic/hello.pic \
 	$(srcdir)/data/pic/hello.c \
 	$(srcdir)/data/pic/libhello.c
-
-$(noinst_SCRIPTS): %: %.in
-	$(SED) "s#@ABSTOPSRCDIR@#$(abs_top_srcdir)#g" < $< > $@
-	chmod +x $@
diff --git a/tests/ust-elf/test_ust_elf.in b/tests/ust-elf/test_ust_elf.in
old mode 100755
new mode 100644
index 03a995fc..5aed2cba
--- a/tests/ust-elf/test_ust_elf.in
+++ b/tests/ust-elf/test_ust_elf.in
@@ -1,4 +1,4 @@
 #!/bin/bash
 
-TEST_DIR=$(dirname $0)
-./${TEST_DIR}/prog @ABSTOPSRCDIR@/tests/ust-elf
+TEST_DIR=$(dirname "$0")
+"${TEST_DIR}/ust-elf" "@abs_top_srcdir@/tests/ust-elf"
diff --git a/tests/ust-elf/prog.c b/tests/ust-elf/ust-elf.c
similarity index 100%
rename from tests/ust-elf/prog.c
rename to tests/ust-elf/ust-elf.c
-- 
2.17.1
