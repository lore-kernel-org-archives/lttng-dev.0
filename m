From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [LTTng-tools PATCH] Test for presence of bison and flex
	when building from git
Date: Tue, 16 Jul 2013 16:31:35 -0400
Message-ID: <1374006695-2055-1-git-send-email-yannick.brosseau__2709.5464211472$1374006769$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UzBuX-00018b-Ei
	for lttng-dev@lists.lttng.org; Tue, 16 Jul 2013 16:31:55 -0400
Received: by mail-ob0-f181.google.com with SMTP id 16so1333746obc.12
	for <lttng-dev@lists.lttng.org>; Tue, 16 Jul 2013 13:31:44 -0700 (PDT)
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

Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
---
 configure.ac |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index b430152..b34e39a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -287,7 +287,19 @@ LT_INIT
 AC_PROG_YACC
 AC_PROG_LEX
 
-AC_DEFUN([AC_PROG_BISON], [AC_CHECK_PROGS(BISON, bison, bison)])
+if test ! -f "src/lib/lttng-ctl/filter/filter-parser.h"; then
+	if test x"$YACC" != "xbison -y"; then
+		AC_MSG_ERROR([[bison not found and is required when building from git.
+		Please install bison]])
+	fi
+fi
+
+if test ! -f "src/lib/lttng-ctl/filter/filter-lexer.c"; then
+	if test x"$LEX" != "xflex"; then
+		AC_MSG_ERROR([[flex not found and is required when building from git.
+		Please install flex]])
+	fi
+fi
 
 CFLAGS="-Wall $CFLAGS -g -fno-strict-aliasing"
 
-- 
1.7.10.4
