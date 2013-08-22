From: Jimmy Durand Wesolowski <jimmy.durand.wesolowski@gmail.com>
Subject: [PATCH 1/2] Introduce configure --with-urcu-prefix
Date: Thu, 22 Aug 2013 10:27:30 +0200
Message-ID: <1377160051-12449-2-git-send-email-jimmy.durand.wesolowski__46558.5579201162$1377160140$gmane$org@gmail.com>
References: <1377160051-12449-1-git-send-email-jimmy.durand.wesolowski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f181.google.com ([74.125.82.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jimmy.durand.wesolowski@gmail.com>)
	id 1VCQFG-0001e2-Ma
	for lttng-dev@lists.lttng.org; Thu, 22 Aug 2013 04:27:59 -0400
Received: by mail-we0-f181.google.com with SMTP id q57so1364309wes.12
	for <lttng-dev@lists.lttng.org>; Thu, 22 Aug 2013 01:27:49 -0700 (PDT)
In-Reply-To: <1377160051-12449-1-git-send-email-jimmy.durand.wesolowski@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Jimmy Durand Wesolowski <jimmy.durand-wesolowski-ext@oneaccess-net.com>
List-Id: lttng-dev@lists.lttng.org

From: Jimmy Durand Wesolowski <jimmy.durand-wesolowski-ext@oneaccess-net.com>

---
 configure.ac |   42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index 94f8182..164174d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -149,14 +149,34 @@ CFLAGS="-Wall $CFLAGS"
 
 # URCU
 
+AC_ARG_WITH([urcu-prefix],
+	AS_HELP_STRING([--with-urcu-prefix=PREFIX],
+                       [Specify the installation prefix of the URCU library.
+		        Headers must be in PREFIX/include; libraries in
+			PREFIX/lib.]),
+			[
+			  CPPFLAGS="$CPPFLAGS -I${withval}/include"
+			  LDFLAGS="$LDFLAGS -L${withval}/lib"
+			])
+
 # urcu - check if we just find the headers it out of the box.
-AC_CHECK_HEADERS([urcu-bp.h], [], [AC_MSG_ERROR([Cannot find [URCU] headers (urcu-bp.h). Use [CPPFLAGS]=-Idir to specify their location.
-This error can also occur when the liburcu package's configure script has not been run.])])
+AC_CHECK_HEADERS([urcu-bp.h],
+                 [],
+                 [
+			AC_MSG_ERROR([Cannot find [URCU] headers (urcu-bp.h).
+			              Use --with-urcu-prefix=PREFIX to
+				      specify its location.])
+                 ])
 
 # urcu-cds - check that URCU Concurrent Data Structure lib is available to compilation
 # Part of Userspace RCU library 0.7.2 or better.
-AC_CHECK_LIB([urcu-cds], [_cds_lfht_new], [], [AC_MSG_ERROR([Cannot find
-liburcu-cds lib, part of Userspace RCU 0.7 or better. Use [LDFLAGS]=-Ldir to specify its location.])])
+AC_CHECK_LIB([urcu-cds], [_cds_lfht_new], [],
+             [
+		AC_MSG_ERROR([Cannot find liburcu-cds lib, part of Userspace
+		              RCU 0.7 or better.
+		              Use --with-urcu-prefix=PREFIX to
+			      specify its location.])
+             ])
 
 AC_MSG_CHECKING([caa_likely()])
 AC_COMPILE_IFELSE([AC_LANG_SOURCE([[
@@ -175,10 +195,20 @@ void fct(void)
 ])
 
 # urcu - check that URCU lib is available to compilation
-AC_CHECK_LIB([urcu-bp], [synchronize_rcu_bp], [], [AC_MSG_ERROR([Cannot find liburcu-bp lib. Use [LDFLAGS]=-Ldir to specify its location.])])
+AC_CHECK_LIB([urcu-bp], [synchronize_rcu_bp], [],
+             [
+		AC_MSG_ERROR([Cannot find liburcu-bp lib.
+		              Use Use --with-urcu-prefix=PREFIX to
+			      specify its location.])
+             ])
 
 # urcu - check that URCU lib is at least version 0.6
-AC_CHECK_LIB([urcu-bp], [call_rcu_bp], [], [AC_MSG_ERROR([liburcu 0.6 or newer is needed, please update your version or use [LDFLAGS]=-Ldir to specify the right location.])])
+AC_CHECK_LIB([urcu-bp], [call_rcu_bp], [],
+             [
+		AC_MSG_ERROR([liburcu 0.6 or newer is needed, please update
+		              your version or use --with-urcu-prefix=PREFIX to
+			      specify its location.])
+             ])
 
 AC_MSG_CHECKING([host system alignment requirements])
 case $host_cpu in
-- 
1.7.10.4
