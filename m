From: Romain Naour <romain.naour@openwide.fr>
Subject: [PATCH 1/1] Fix: disable liblttng-ust-dl if dlinfo is
	not available in C library
Date: Wed,  9 Apr 2014 23:55:07 +0200
Message-ID: <1397080507-20411-1-git-send-email-romain.naour__48848.4178823002$1397080594$gmane$org@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp4-g21.free.fr ([212.27.42.4])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <romain.naour@openwide.fr>) id 1WY0So-0003rE-Oh
 for lttng-dev@lists.lttng.org; Wed, 09 Apr 2014 17:55:28 -0400
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

According to uClibc commit [1], dlinfo is not available in recent uClibc (>0.9.33),
but available in older version of uClibc (<=0.9.33) whith a different prototype than glibc.

dlinfo used by liblttng-ust-dl require RTLD_DI_LINKMAP that is not available in uClibc.

To be able to use LTTng UST with uClibc, we need to disable
the Dynamic Linker Tracing functionality [2] if RTLD_DI_LINKMAP is not detected.

[1] http://git.uclibc.org/uClibc/commit/?id=f3c9dc499c5c787ddd8c4320f2d44d2ae6e40c22
[2] http://lists.lttng.org/pipermail/lttng-dev/2014-February/022423.html

Signed-off-by: Romain Naour <romain.naour@openwide.fr>
---
 Makefile.am  |  5 ++++-
 configure.ac | 10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index b79d2dd..c907ff1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -4,11 +4,14 @@ SUBDIRS = . include snprintf libringbuffer liblttng-ust-comm \
 		liblttng-ust \
 		liblttng-ust-ctl \
 		liblttng-ust-fork \
-		liblttng-ust-dl \
 		liblttng-ust-libc-wrapper \
 		liblttng-ust-cyg-profile \
 		tools
 
+if HAVE_DLINFO
+SUBDIRS += liblttng-ust-dl
+endif
+
 if BUILD_JNI_INTERFACE
 SUBDIRS += liblttng-ust-java liblttng-ust-jul
 endif
diff --git a/configure.ac b/configure.ac
index b04d4e3..b315d54 100644
--- a/configure.ac
+++ b/configure.ac
@@ -124,6 +124,16 @@ AM_CONDITIONAL([LTTNG_UST_BUILD_WITH_LIBC_DL], [test "x$have_libc_dl" = "xyes"])
 
 AC_CHECK_LIB([pthread], [pthread_create])
 
+# Check for dlfcn.h
+AC_CHECK_HEADER([dlfcn.h])
+AS_IF([test "${ac_cv_header_dlfcn_h}" = "yes"],
+	[AC_CHECK_DECLS([RTLD_DI_LINKMAP],,,
+		[#define _GNU_SOURCE /* Required on Linux to get GNU extensions */
+		#include <dlfcn.h>])
+	],
+	[ac_cv_have_decl_RTLD_DI_LINKMAP="no"])
+AM_CONDITIONAL([HAVE_DLINFO], [test "${ac_cv_have_decl_RTLD_DI_LINKMAP}" = "yes"])
+
 # Checks for header files.
 #AC_CHECK_HEADERS([fcntl.h stdint.h stdlib.h string.h sys/socket.h sys/time.h unistd.h])
 
-- 
1.9.0
