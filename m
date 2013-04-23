From: Stefan Seefeld <stefan@codesourcery.com>
Subject: [PATCH lttng-tools] Add --with-lttng-ust-prefix config
	option.
Date: Tue, 23 Apr 2013 13:44:48 -0400
Message-ID: <5176C890.6060607__38001.2240646922$1366741583$gmane$org@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1UUhGy-000401-QB
	for lttng-dev@lists.lttng.org; Tue, 23 Apr 2013 13:44:56 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This patch adds a configure option to the lttng-tools build system to
support lttng-ust being installed in a non-default location.
While configure.ac indicated to use "LDFLAGS=-L<prefix>/lib" for this,
in reality this doesn't work since the include search path needs to be
adjusted as well. The patch sets both of these by means of a single new
config option.


Signed-off-by: Stefan Seefeld <stefan@codesourcery.com>
---
 configure.ac | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 4f85fc1..5b37780 100644
--- a/configure.ac
+++ b/configure.ac
@@ -163,6 +163,15 @@ AC_CHECK_DECL([caa_likely], [],
     [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])],
[[#include <urcu.h>]]
 )
 
+AC_ARG_WITH(lttng-ust-prefix,
+  AS_HELP_STRING([--with-lttng-ust-prefix=PATH],
+                 [Specify the installation prefix of the lttng-ust library.
+              Headers must be in PATH/include; libraries in PATH/lib.]),
+          [
+            CPPFLAGS="$CPPFLAGS -I${withval}/include"
+            LDFLAGS="$LDFLAGS -L${withval}/lib64 -L${withval}/lib"
+          ])
+
 # Check liblttng-ust-ctl library
 AC_ARG_ENABLE(lttng-ust,
     AS_HELP_STRING([--disable-lttng-ust],[build without LTTng-UST
(Userspace Tracing) support]),
@@ -174,7 +183,7 @@ AS_IF([test "x$lttng_ust_support" = "xyes"], [
             AC_DEFINE([HAVE_LIBLTTNG_UST_CTL], [1], [has LTTng-UST
control support])
             lttng_ust_ctl_found=yes
         ],
-        [AC_MSG_ERROR([Cannot find LTTng-UST 2.1.x. Use [LDFLAGS]=-Ldir
to specify its location, or specify --disable-lttng-ust to build
lttng-tools without LTTng-UST support.])],
+        [AC_MSG_ERROR([Cannot find LTTng-UST >= 2.1.x. Use
--with-lttng-ust-prefix=PREFIX to specify its location, or specify
--disable-lttng-ust to build lttng-tools without LTTng-UST support.])],
         [-lurcu-common -lurcu-bp -lurcu-cds -lrt]
     )
 ])
-- 
1.8.1.4

-- 
Stefan Seefeld
CodeSourcery / Mentor Graphics
stefan@codesourcery.com
