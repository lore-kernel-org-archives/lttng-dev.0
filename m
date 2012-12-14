From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [BABELTRACE PATCH] Provides a basic pkg-config file for
	libbabeltrace
Date: Fri, 14 Dec 2012 01:11:43 -0500
Message-ID: <1355465503-1266-1-git-send-email-yannick.brosseau__48914.3241233707$1355465568$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1TjOVE-0003z9-0O
	for lttng-dev@lists.lttng.org; Fri, 14 Dec 2012 01:12:08 -0500
Received: by mail-ie0-f176.google.com with SMTP id 13so5257738iea.35
	for <lttng-dev@lists.lttng.org>; Thu, 13 Dec 2012 22:12:02 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This pkg-config file specify the usage of libbabeltrace and libbabeltrace-ctf since ctf is
the only format currently supported and tested.

Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
---
 Makefile.am      |    3 +++
 babeltrace.pc.in |   14 ++++++++++++++
 configure.ac     |    1 +
 3 files changed, 18 insertions(+)
 create mode 100644 babeltrace.pc.in

diff --git a/Makefile.am b/Makefile.am
index 7a63612..b25b58f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -8,3 +8,6 @@ dist_doc_DATA = ChangeLog LICENSE mit-license.txt gpl-2.0.txt \
 		std-ext-lib.txt
 
 dist_noinst_DATA = CodingStyle
+
+pkgconfigdir = $(libdir)/pkgconfig
+pkgconfig_DATA = babeltrace.pc
diff --git a/babeltrace.pc.in b/babeltrace.pc.in
new file mode 100644
index 0000000..12349dd
--- /dev/null
+++ b/babeltrace.pc.in
@@ -0,0 +1,14 @@
+prefix=@prefix@
+exec_prefix=@exec_prefix@
+libdir=@libdir@
+includedir=@includedir@
+
+Name: Babeltrace
+Description: libbabeltrace provides a reader for trace files, reading mainly the 
+Common Trace Format (CTF).
+Version: @PACKAGE_VERSION@
+Requires:
+Requires.private: uuid popt
+Libs: -L${libdir} -lbabeltrace -lbabeltrace-ctf
+Cflags: -I${includedir} 
+
diff --git a/configure.ac b/configure.ac
index 19f16a6..86dd17c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -109,5 +109,6 @@ AC_CONFIG_FILES([
 	tests/lib/Makefile
 	extras/Makefile
 	extras/valgrind/Makefile
+	babeltrace.pc
 ])
 AC_OUTPUT
-- 
1.7.10.4
