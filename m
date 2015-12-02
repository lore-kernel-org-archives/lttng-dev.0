From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Tests: fix make targets using
	objcopy
Date: Wed,  2 Dec 2015 13:26:09 -0500
Message-ID: <1449080769-18845-1-git-send-email-mjeanson__5104.94237901202$1449080871$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1a4C6s-0005Ge-Pt
 for lttng-dev@lists.lttng.org; Wed, 02 Dec 2015 13:26:38 -0500
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

Add detection for objcopy using AC_CHECK_TOOL and use dedicated make
targets for each file.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 .gitignore                                          |  2 ++
 configure.ac                                        |  6 ++++++
 tests/regression/ust/baddr-statedump/Makefile.am    | 21 ++++++++++++++++-----
 .../ust/baddr-statedump/test_baddr-statedump.py     |  2 +-
 tests/regression/ust/ust-dl/Makefile.am             | 21 ++++++++++++++++-----
 tests/regression/ust/ust-dl/test_ust-dl.py          |  2 +-
 6 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/.gitignore b/.gitignore
index 0efccfa..ca08d95 100644
--- a/.gitignore
+++ b/.gitignore
@@ -95,7 +95,9 @@ health_check
 tests/regression/ust/python-logging/test_python_logging
 /tests/regression/ust/baddr-statedump/prog
 /tests/regression/ust/baddr-statedump/prog.debug
+/tests/regression/ust/baddr-statedump/prog.strip
 /tests/regression/ust/ust-dl/prog
+/tests/regression/ust/ust-dl/libfoo.so.debug
 /tests/utils/testapp/gen-ust-nevents/gen-ust-nevents
 /tests/utils/testapp/gen-ust-tracef/gen-ust-tracef
 /tests/regression/tools/live/live_test
diff --git a/configure.ac b/configure.ac
index 978e3bc..4100fe1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -28,6 +28,12 @@ AC_PROG_SED
 AC_PROG_YACC
 LT_INIT
 
+# Check for objcopy, required by the base address statedump and dynamic linker tests
+AC_CHECK_TOOL([OBJCOPY], objcopy, no)
+AS_IF([test "x$OBJCOPY" = xno],
+	[AC_MSG_ERROR([Cannont find objcopy. Install the binutils package.])]
+)
+
 # Checks for typedefs, structures, and compiler characteristics.
 AC_C_INLINE
 AC_TYPE_INT32_T
diff --git a/tests/regression/ust/baddr-statedump/Makefile.am b/tests/regression/ust/baddr-statedump/Makefile.am
index f45c5ae..7caf457 100644
--- a/tests/regression/ust/baddr-statedump/Makefile.am
+++ b/tests/regression/ust/baddr-statedump/Makefile.am
@@ -1,3 +1,7 @@
+objcopy_verbose = $(objcopy_verbose_@AM_V@)
+objcopy_verbose_ = $(objcopy_verbose_@AM_DEFAULT_V@)
+objcopy_verbose_0 = @echo OBJCOPY $@;
+
 AM_CPPFLAGS = -I$(srcdir) -g
 
 noinst_PROGRAMS = prog
@@ -7,15 +11,21 @@ prog_LDADD = -llttng-ust -ldl
 noinst_SCRIPTS = test_baddr-statedump test_baddr-statedump.py
 EXTRA_DIST = test_baddr-statedump test_baddr-statedump.py
 
-all-local: prog$(EXEEXT)
+# Extract debug symbols
+prog.debug: prog
+	$(objcopy_verbose)$(OBJCOPY) --only-keep-debug prog prog.debug
+
+# Strip and add debuglink
+prog.strip: prog.debug
+	@cp -f prog prog.strip
+	$(objcopy_verbose)$(OBJCOPY) --strip-debug --add-gnu-debuglink=prog.debug prog.strip
+
+all-local: prog.strip
 	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
 		for script in $(EXTRA_DIST); do \
 			cp -f $(srcdir)/$$script $(builddir); \
 		done; \
 	fi
-	objcopy --only-keep-debug prog prog.debug
-	strip -g prog
-	objcopy --add-gnu-debuglink prog.debug prog
 
 clean-local:
 	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
@@ -23,4 +33,5 @@ clean-local:
 			rm -f $(builddir)/$$script; \
 		done; \
 	fi
-	rm -f prog.debug
+
+CLEANFILES = prog.debug prog.strip
diff --git a/tests/regression/ust/baddr-statedump/test_baddr-statedump.py b/tests/regression/ust/baddr-statedump/test_baddr-statedump.py
index 308eff4..47ed9d6 100644
--- a/tests/regression/ust/baddr-statedump/test_baddr-statedump.py
+++ b/tests/regression/ust/baddr-statedump/test_baddr-statedump.py
@@ -45,7 +45,7 @@ session_info = create_session()
 enable_ust_tracepoint_event(session_info, "*")
 start_session(session_info)
 
-test_process = subprocess.Popen(test_path + "prog", stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+test_process = subprocess.Popen(test_path + "prog.strip", stdout=subprocess.PIPE, stderr=subprocess.PIPE)
 if sys.version_info >= (3, 3):
     try:
         test_process.wait(5)
diff --git a/tests/regression/ust/ust-dl/Makefile.am b/tests/regression/ust/ust-dl/Makefile.am
index 4893a97..c12da16 100644
--- a/tests/regression/ust/ust-dl/Makefile.am
+++ b/tests/regression/ust/ust-dl/Makefile.am
@@ -1,3 +1,7 @@
+objcopy_verbose = $(objcopy_verbose_@AM_V@)
+objcopy_verbose_ = $(objcopy_verbose_@AM_DEFAULT_V@)
+objcopy_verbose_0 = @echo OBJCOPY $@;
+
 AM_CPPFLAGS = -I$(srcdir) -g
 
 noinst_PROGRAMS = prog
@@ -12,15 +16,21 @@ libfoo_la_LDFLAGS = -module -shared -avoid-version \
 noinst_SCRIPTS = test_ust-dl test_ust-dl.py
 EXTRA_DIST = test_ust-dl test_ust-dl.py
 
-all-local: libfoo.la
+# Extract debug symbols
+libfoo.so.debug: libfoo.la
+	$(objcopy_verbose)$(OBJCOPY) --only-keep-debug .libs/libfoo.so libfoo.so.debug
+
+# Strip and add debuglink
+libfoo.so: libfoo.so.debug
+	@cp -f .libs/libfoo.so libfoo.so
+	$(objcopy_verbose)$(OBJCOPY) --strip-debug --add-gnu-debuglink=libfoo.so.debug libfoo.so
+
+all-local: libfoo.so
 	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
 		for script in $(EXTRA_DIST); do \
 			cp -f $(srcdir)/$$script $(builddir); \
 		done; \
 	fi
-	objcopy --only-keep-debug .libs/libfoo.so .libs/libfoo.so.debug
-	strip -g .libs/libfoo.so
-	objcopy --add-gnu-debuglink .libs/libfoo.so.debug .libs/libfoo.so
 
 clean-local:
 	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
@@ -28,4 +38,5 @@ clean-local:
 			rm -f $(builddir)/$$script; \
 		done; \
 	fi
-	rm -f .libs/libfoo.so.debug
+
+CLEANFILES = libfoo.so libfoo.so.debug
diff --git a/tests/regression/ust/ust-dl/test_ust-dl.py b/tests/regression/ust/ust-dl/test_ust-dl.py
index 1e5e96b..dc73270 100644
--- a/tests/regression/ust/ust-dl/test_ust-dl.py
+++ b/tests/regression/ust/ust-dl/test_ust-dl.py
@@ -47,7 +47,7 @@ start_session(session_info)
 
 test_env = os.environ.copy()
 test_env["LD_PRELOAD"] = "liblttng-ust-dl.so"
-test_env["LD_LIBRARY_PATH"] = test_path + ".libs/"
+test_env["LD_LIBRARY_PATH"] = test_path
 test_process = subprocess.Popen(test_path + "prog",
                                 stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                                 env=test_env)
-- 
1.9.1
