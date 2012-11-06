From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH v2 lttng-tools] Fix: Do not install health tests
	helper libraries
Date: Tue,  6 Nov 2012 13:32:05 -0500
Message-ID: <1352226725-27207-1-git-send-email-christian.babeux__14520.1330575675$1352226812$gmane$org@efficios.com>
References: <1352150413-16685-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TVnxI-0000qT-NJ
	for lttng-dev@lists.lttng.org; Tue, 06 Nov 2012 13:32:57 -0500
Received: by mail-ie0-f176.google.com with SMTP id k11so1195731iea.35
	for <lttng-dev@lists.lttng.org>; Tue, 06 Nov 2012 10:32:51 -0800 (PST)
In-Reply-To: <1352150413-16685-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The libraries libhealthexit and libhealthstall should not be
installed on the user system. They are only useful for the
health check tests.

Furthermore, when adding libraries to noinst_LTLIBRARIES,
libtool will only build these as static libraries (see [1] for a
workaround). This is fine for most use cases, but for the health
tests, we _must_ have shared libraries (the nature of the tests
require LD_PRELOAD), hence we force the build of a shared object.

Forcing shared object has the unfortunate side-effect of breaking
builds where configure was invoked with "--disable-shared" flag.
Instead of failing badly, detect this flag and skip the health
tests altogether.

noinst shared libs:
[1] - https://lists.gnu.org/archive/html/libtool/2008-06/msg00082.html

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 configure.ac                   |  2 ++
 tests/tools/health/Makefile.am | 20 ++++++++++++--------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/configure.ac b/configure.ac
index 72daf7e..a3120fc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -39,6 +39,8 @@ AS_IF([test "x$libtool_fixup" = "xyes"],
 		  ])
 	    ])
 
+AM_CONDITIONAL([NO_SHARED], [test x$enable_shared = xno])
+
 AC_CHECK_HEADERS([ \
 	sys/types.h unistd.h fcntl.h string.h pthread.h limits.h \
 	signal.h stdlib.h sys/un.h sys/socket.h stdlib.h stdio.h \
diff --git a/tests/tools/health/Makefile.am b/tests/tools/health/Makefile.am
index 9fab582..f1a5d91 100644
--- a/tests/tools/health/Makefile.am
+++ b/tests/tools/health/Makefile.am
@@ -8,23 +8,27 @@ if LTTNG_TOOLS_BUILD_WITH_LIBC_DL
 AM_LDFLAGS += -lc
 endif
 
-UTILS=
-
-lib_LTLIBRARIES=libhealthexit.la libhealthstall.la
+if NO_SHARED
+# Do not build this test if shared libraries support was
+# explicitly disabled.
+else
+# In order to test the health check feature, the libhealth* libs
+# must be built as .so to be able to LD_PRELOAD them.
+FORCE_SHARED_LIB_OPTIONS = -module -shared -avoid-version \
+			   -rpath $(abs_builddir)
 
 # Health thread exit ld_preloaded test lib
 libhealthexit_la_SOURCES=health_exit.c
-libhealthexit_la_LDFLAGS= -module
+libhealthexit_la_LDFLAGS= $(FORCE_SHARED_LIB_OPTIONS)
 
 # Health thread stall ld_preloaded test lib
 libhealthstall_la_SOURCES=health_stall.c
-libhealthstall_la_LDFLAGS= -module
+libhealthstall_la_LDFLAGS= $(FORCE_SHARED_LIB_OPTIONS)
 
 noinst_PROGRAMS = health_check
+noinst_LTLIBRARIES = libhealthexit.la libhealthstall.la
 
 health_check_SOURCES = health_check.c $(UTILS)
 health_check_LDADD = $(top_builddir)/src/lib/lttng-ctl/liblttng-ctl.la \
 		     $(top_builddir)/src/common/libcommon.la
-
-noinst_SCRIPTS =
-EXTRA_DIST =
+endif
-- 
1.8.0
