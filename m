From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-ust] Fix: Use $enableval with AC_ARG_ENABLE
Date: Wed,  8 Jul 2015 14:24:57 -0400
Message-ID: <1436379897-32219-1-git-send-email-mjeanson__33307.2949470536$1436380055$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZCu1v-0006wG-Cy
 for lttng-dev@lists.lttng.org; Wed, 08 Jul 2015 14:25:23 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3E01934033E
 for <lttng-dev@lists.lttng.org>; Wed,  8 Jul 2015 18:25:07 +0000 (UTC)
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
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 8bbf7b9..cb4bb21 100644
--- a/configure.ac
+++ b/configure.ac
@@ -255,7 +255,7 @@ fi
 # Check for JNI header files if requested
 AC_ARG_ENABLE([jni-interface],
 	[AS_HELP_STRING([--enable-jni-interface],[build JNI interface between C and Java. Needs Java include files [default=no]])],
-	[jni_interface=$withval],
+	[jni_interface=$enableval],
 	[jni_interface=no]
 )
 
-- 
1.9.1
