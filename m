From: Simon Marchi <simon.marchi@efficios.com>
Subject: [PATCH 1/2] doc: pass AR when building examples
Date: Mon, 18 Nov 2019 12:07:50 -0500
Message-ID: <20191118170751.32002-1-simon.marchi__42251.095936966$1574096898$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 47GwPs40mCzsZQ
 for <lttng-dev@lists.lttng.org>; Mon, 18 Nov 2019 12:08:01 -0500 (EST)
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
Cc: Simon Marchi <simon.marchi@efficios.com>, Rolf Eike Beer <eb@emlix.com>
List-Id: lttng-dev@lists.lttng.org

As reported here [1], when cross-compiling lttng-ust, the
"hello-static-lib" example uses the ar tool made for the --build machine
instead of the prefixed one, for the --host machine.

The Makefiles in the subdirectories of doc/examples are written by hand,
so that they can be easily copied and modified by users.  They are
therefore not integrated in the automake build system, and any value
detected by configure must be passed explicitly when invoking it.
For example, the CC value is already explicitly passed, so that the
compiler value found by configure is passed down.  We just need to do
the same for AR.

This patch adds AM_PROG_AR in configure.ac, so that configure finds the
prefixed version of ar, if cross-compiling.

It then sets the AR variable in doc/examples/Makefile.am, when invoking
sub-Makefiles.  I don't think we really need it in the cmake case, but
it doesn't hurt to have it there.

[1] https://lists.lttng.org/pipermail/lttng-dev/2019-November/029388.html

Reported-by: Rolf Eike Beer <eb@emlix.com>
Signed-off-by: Simon Marchi <simon.marchi@efficios.com>
---
 configure.ac             | 1 +
 doc/examples/Makefile.am | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 001c44289790..e07888c093fd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -66,6 +66,7 @@ AS_IF([test "x${ax_cv_sys_weak_alias}" = "xno"], [
 ])
 
 # Checks for programs.
+AM_PROG_AR
 AC_PROG_SED
 AC_PROG_GREP
 AC_PROG_LN_S
diff --git a/doc/examples/Makefile.am b/doc/examples/Makefile.am
index d5d00b090c61..2f9811ea4f9b 100644
--- a/doc/examples/Makefile.am
+++ b/doc/examples/Makefile.am
@@ -123,7 +123,7 @@ all-local:
 		rel_build_subdir="../"; \
 	fi; \
 	for subdir in $(SUBDIRS_PROXY); do \
-		(cd $$subdir && $(MAKE) CC="$(CC)" CPPFLAGS="$(CPPFLAGS)" AM_CPPFLAGS="$(AM_CPPFLAGS) -I$$rel_src_subdir$(top_srcdir)/include/ -I$$rel_build_subdir$(top_builddir)/include/" CFLAGS='$(CFLAGS)' AM_CFLAGS='$(AM_CFLAGS)' LDFLAGS="$(LDFLAGS)" AM_LDFLAGS='$(AM_LDFLAGS) -L../../../liblttng-ust/.libs -Wl,-rpath="$(PWD)/../../liblttng-ust/.libs/" -Wl,-rpath-link="$(PWD)/../../liblttng-ust/.libs/"' LTTNG_GEN_TP_PATH="../../../tools/" AM_V_P="$(AM_V_P)" AM_V_at="$(AM_V_at)" $(AM_MAKEFLAGS) all && cd ..) || exit 1; \
+		(cd $$subdir && $(MAKE) AR="$(AR)" CC="$(CC)" CPPFLAGS="$(CPPFLAGS)" AM_CPPFLAGS="$(AM_CPPFLAGS) -I$$rel_src_subdir$(top_srcdir)/include/ -I$$rel_build_subdir$(top_builddir)/include/" CFLAGS='$(CFLAGS)' AM_CFLAGS='$(AM_CFLAGS)' LDFLAGS="$(LDFLAGS)" AM_LDFLAGS='$(AM_LDFLAGS) -L../../../liblttng-ust/.libs -Wl,-rpath="$(PWD)/../../liblttng-ust/.libs/" -Wl,-rpath-link="$(PWD)/../../liblttng-ust/.libs/"' LTTNG_GEN_TP_PATH="../../../tools/" AM_V_P="$(AM_V_P)" AM_V_at="$(AM_V_at)" $(AM_MAKEFLAGS) all && cd ..) || exit 1; \
 	done; \
 	if [ x"$(SUBDIRS_JUL)" != x"" ]; then \
 		for subdir in $(SUBDIRS_JUL); do \
@@ -141,6 +141,7 @@ all-local:
 				cd $$subdir && \
 				$(MKDIR_P) build && \
 				cd build && \
+				AR="$(AR)" \
 				CC="$(CC)" \
 				CXX="$(CXX)" \
 				cmake \
-- 
2.24.0
