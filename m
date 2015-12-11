From: Nathan Lynch <nathan_lynch@mentor.com>
Subject: [PATCH] use AC_CHECK_TOOL for objcopy and strip
Date: Fri, 11 Dec 2015 10:43:24 -0600
Message-ID: <1449852204-11379-1-git-send-email-nathan_lynch__21771.8399981552$1449852281$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Nathan_Lynch@mentor.com>) id 1a7Qn8-0001up-Tv
 for lttng-dev@lists.lttng.org; Fri, 11 Dec 2015 11:43:42 -0500
Received: from svr-orw-fem-05.mgc.mentorg.com ([147.34.97.43])
 by relay1.mentorg.com with esmtp
 id 1a7Qn0-0003n7-TL from Nathan_Lynch@mentor.com
 for lttng-dev@lists.lttng.org; Fri, 11 Dec 2015 08:43:26 -0800
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The build steps for some tests refer directly to objcopy and strip,
which when cross-compiling can result in:

 objcopy --only-keep-debug prog prog.debug
 objcopy: Unable to recognise the format of the input file `prog'

Use AC_CHECK_TOOL to use appropriate programs for the target.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 configure.ac                                     | 2 ++
 tests/regression/ust/baddr-statedump/Makefile.am | 6 +++---
 tests/regression/ust/ust-dl/Makefile.am          | 6 +++---
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5537c154015e..64a6be9b8594 100644
--- a/configure.ac
+++ b/configure.ac
@@ -26,6 +26,8 @@ AC_PROG_LEX
 AC_PROG_MAKE_SET
 AC_PROG_SED
 AC_PROG_YACC
+AC_CHECK_TOOL([OBJCOPY], [objcopy])
+AC_CHECK_TOOL([STRIP], [strip])
 LT_INIT
 
 # Checks for typedefs, structures, and compiler characteristics.
diff --git a/tests/regression/ust/baddr-statedump/Makefile.am b/tests/regression/ust/baddr-statedump/Makefile.am
index f45c5aeeb155..8869ed55ef9e 100644
--- a/tests/regression/ust/baddr-statedump/Makefile.am
+++ b/tests/regression/ust/baddr-statedump/Makefile.am
@@ -13,9 +13,9 @@ all-local: prog$(EXEEXT)
 			cp -f $(srcdir)/$$script $(builddir); \
 		done; \
 	fi
-	objcopy --only-keep-debug prog prog.debug
-	strip -g prog
-	objcopy --add-gnu-debuglink prog.debug prog
+	$(OBJCOPY) --only-keep-debug prog prog.debug
+	$(STRIP) -g prog
+	$(OBJCOPY) --add-gnu-debuglink prog.debug prog
 
 clean-local:
 	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
diff --git a/tests/regression/ust/ust-dl/Makefile.am b/tests/regression/ust/ust-dl/Makefile.am
index 4893a97e4793..d3c975a4d6dc 100644
--- a/tests/regression/ust/ust-dl/Makefile.am
+++ b/tests/regression/ust/ust-dl/Makefile.am
@@ -18,9 +18,9 @@ all-local: libfoo.la
 			cp -f $(srcdir)/$$script $(builddir); \
 		done; \
 	fi
-	objcopy --only-keep-debug .libs/libfoo.so .libs/libfoo.so.debug
-	strip -g .libs/libfoo.so
-	objcopy --add-gnu-debuglink .libs/libfoo.so.debug .libs/libfoo.so
+	$(OBJCOPY) --only-keep-debug .libs/libfoo.so .libs/libfoo.so.debug
+	$(STRIP) -g .libs/libfoo.so
+	$(OBJCOPY) --add-gnu-debuglink .libs/libfoo.so.debug .libs/libfoo.so
 
 clean-local:
 	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
-- 
2.4.3
