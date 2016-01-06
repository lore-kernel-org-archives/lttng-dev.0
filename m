From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-tools] Fix: missing $ in SED variable
Date: Wed,  6 Jan 2016 12:31:42 -0500
Message-ID: <1452101502-9478-1-git-send-email-mjeanson__35607.9976576895$1452101598$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1aGrwS-0004Vf-Vq
 for lttng-dev@lists.lttng.org; Wed, 06 Jan 2016 12:32:17 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 5537c15..f851be8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -90,7 +90,7 @@ AS_IF([test "x$libtool_fixup" = "xyes"],
 	    [
 		  AC_MSG_RESULT([$libtool_flag_pattern_count])
 		  AC_MSG_WARN([the detected libtool will not link all dependencies, forcing link_all_deplibs = unknown])
-		  SED -i "s/\($libtool_flag_pattern\)\s*=\s*no/\1=unknown/g" $libtool_m4
+		  $SED -i "s/\($libtool_flag_pattern\)\s*=\s*no/\1=unknown/g" $libtool_m4
 		  ],
 		  [
 		  AC_MSG_RESULT([none])
-- 
2.7.0.rc3
