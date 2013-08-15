From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [Babeltrace PATCH] Test for presence of bison and flex
	when building from git
Date: Thu, 15 Aug 2013 15:29:25 -0400
Message-ID: <1376594965-30440-1-git-send-email-yannick.brosseau__37874.47412401$1376595039$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1VA3Eq-0000f5-2R
	for lttng-dev@lists.lttng.org; Thu, 15 Aug 2013 15:29:45 -0400
Received: by mail-ie0-f172.google.com with SMTP id 17so1958145iea.17
	for <lttng-dev@lists.lttng.org>; Thu, 15 Aug 2013 12:29:34 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

Fixes #74

Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
---
 configure.ac |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index a22b1b9..2b9cc0d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -23,7 +23,20 @@ LT_INIT
 AC_PROG_YACC
 AC_PROG_LEX
 
-AC_DEFUN([AC_PROG_BISON], [AC_CHECK_PROGS(BISON, bison, bison)]) 
+if test ! -f "$srcdir/formats/ctf/metadata/ctf-parser.h"; then
+        if test x"$YACC" != "xbison -y"; then
+                AC_MSG_ERROR([[bison not found and is required when building from git.
+                Please install bison]])
+        fi
+fi
+
+if test ! -f "$srcdir/formats/ctf/metadata/ctf-lexer.c"; then
+        if test x"$LEX" != "xflex"; then
+                AC_MSG_ERROR([[flex not found and is required when building from git.
+                Please install flex]])
+        fi
+fi
+
 
 AM_PATH_GLIB_2_0(2.22.0, ,AC_MSG_ERROR([glib is required in order to compile BabelTrace - download it from ftp://ftp.gtk.org/pub/gtk]) , gmodule)
 
-- 
1.7.10.4
