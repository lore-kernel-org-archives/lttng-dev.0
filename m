From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust] Default to no unaligned access on
	unsupported archs
Date: Tue, 30 Jun 2015 11:55:40 -0400
Message-ID: <1435679740-32074-1-git-send-email-mjeanson__28200.302195228$1435679846$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1Z9xt8-000726-Hj
 for lttng-dev@lists.lttng.org; Tue, 30 Jun 2015 11:56:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7A2D3340482
 for <lttng-dev@lists.lttng.org>; Tue, 30 Jun 2015 15:55:53 +0000 (UTC)
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

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 configure.ac | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 03483a7..5901dfb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -241,7 +241,10 @@ changequote([,])dnl
 	aarch64) NO_UNALIGNED_ACCESS=1 ;;
 	mips*) NO_UNALIGNED_ACCESS=1 ;;
 	tile*) NO_UNALIGNED_ACCESS=1 ;;
-	*) AC_MSG_ERROR([unable to detect alignment requirements (unsupported architecture ($host_cpu)?)]) ;;
+	*)
+		UNSUPPORTED_ARCH=1
+		NO_UNALIGNED_ACCESS=1
+		;;
 esac
 AC_MSG_RESULT([$host_cpu])
 
@@ -423,5 +426,10 @@ AS_ECHO_N("sdt.h integration:  ")
 AS_IF([test "x$with_sdt" = "xyes"], [AS_ECHO("Enabled")], [AS_ECHO("Disabled")])
 
 AS_ECHO()
+AS_ECHO_N("Architecture ($host_cpu) has efficient unaligned memory access: ")
+AS_IF([test "x$NO_UNALIGNED_ACCESS" != "x1"], [AS_ECHO("yes")], [AS_IF([test "x$UNSUPPORTED_ARCH" != "x1"], [AS_ECHO("no")], [AS_ECHO("unknown")])])
+AS_IF([test "x$UNSUPPORTED_ARCH" = "x1"], [AC_MSG_WARN([Your architecture ($host_cpu) is unsupported, using safe default of no unaligned access])])
+AS_ECHO()
+
 AS_ECHO("Type 'make' to compile.")
 
-- 
1.9.1
