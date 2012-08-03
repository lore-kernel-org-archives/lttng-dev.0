From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools 1/2] Fix: Libtool fails to find
	dependent libraries when cross-compiling lttng-tools
Date: Fri,  3 Aug 2012 16:31:27 -0400
Message-ID: <e54a3e0eee9d87417e44f1de7f0d445d0e27476f.1344025572.git.christian.babeux__3937.51529413766$1344025965$gmane$org@efficios.com>
References: <cover.1344025572.git.christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-gg0-f176.google.com ([209.85.161.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1SxOXm-0007oS-42
	for lttng-dev@lists.lttng.org; Fri, 03 Aug 2012 16:32:22 -0400
Received: by mail-gg0-f176.google.com with SMTP id s6so1586555ggc.35
	for <lttng-dev@lists.lttng.org>; Fri, 03 Aug 2012 13:32:22 -0700 (PDT)
In-Reply-To: <cover.1344025572.git.christian.babeux@efficios.com>
In-Reply-To: <cover.1344025572.git.christian.babeux@efficios.com>
References: <cover.1344025572.git.christian.babeux@efficios.com>
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

This problem arise when cross compiling and linking libraries with
indirect libraries dependencies (such as liblttng-ust). This "bug" is
caused by an upstream modification in the libtool package on Debian
system. The libtool "link_all_deplibs" flag is set to "no" by default
on linux targets (AFAIK, other distros set it to "unknown").

The chosen solution is to detect such cases via the configure script
and automagically patch the libtool.m4 by forcing the "link_all_deplibs"
to "unknown".

This fixup can be disabled with the appropriate configure flag:

./configure --disable-libtool-linkdep-fixup

Sample configure output on affected systems:

checking for occurence(s) of link_all_deplibs = no in
	 ./config/libtool.m4... 3
configure: WARNING: the detected libtool will not link all
 	   dependencies, forcing link_all_deplibs = unknown

Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 configure.ac | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/configure.ac b/configure.ac
index 17e6b67..3a023cd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -14,6 +14,31 @@ AC_DEFINE_UNQUOTED([VERSION_DESCRIPTION], ["$version_description"], "")
 
 AC_CONFIG_HEADERS([include/config.h])
 
+AC_PROG_GREP
+# libtool link_all_deplibs fixup. See http://bugs.lttng.org/issues/321.
+AC_ARG_ENABLE(libtool-linkdep-fixup,
+	AS_HELP_STRING([--disable-libtool-linkdep-fixup],
+			[disable the libtool fixup for linking all dependent libraries (link_all_deplibs)]),
+	libtool_fixup=$enableval,
+	libtool_fixup=yes)
+
+AS_IF([test "x$libtool_fixup" = "xyes"],
+	    [
+	    libtool_m4="$srcdir/config/libtool.m4"
+	    libtool_flag_pattern=".*link_all_deplibs\s*,\s*\$1\s*)"
+	    AC_MSG_CHECKING([for occurence(s) of link_all_deplibs = no in $libtool_m4])
+	    libtool_flag_pattern_count=$(grep -c "$libtool_flag_pattern\s*=\s*no" $libtool_m4)
+	    AS_IF([test $libtool_flag_pattern_count -ne 0],
+	    [
+		  AC_MSG_RESULT([$libtool_flag_pattern_count])
+		  AC_MSG_WARN([the detected libtool will not link all dependencies, forcing link_all_deplibs = unknown])
+		  sed -i "s/\($libtool_flag_pattern\)\s*=\s*no/\1=unknown/g" $libtool_m4
+		  ],
+		  [
+		  AC_MSG_RESULT([none])
+		  ])
+	    ])
+
 AC_CHECK_HEADERS([ \
 	sys/types.h unistd.h fcntl.h string.h pthread.h limits.h \
 	signal.h stdlib.h sys/un.h sys/socket.h stdlib.h stdio.h \
-- 
1.7.11.3
