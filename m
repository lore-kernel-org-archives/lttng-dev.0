From: Olof Johansson <olof.johansson@axis.com>
Subject: [PATCH] Fix: configure.ac: check for possibly required
	libs for clock_gettime
Date: Wed, 10 Feb 2016 10:39:50 +0100
Message-ID: <1455097190-11550-1-git-send-email-olofjn__39309.4460167505$1455099189$gmane$org@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from bes.se.axis.com ([195.60.68.10])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <olof.johansson@axis.com>) id 1aTRkg-0005j0-6U
 for lttng-dev@lists.lttng.org; Wed, 10 Feb 2016 05:12:05 -0500
Received: from localhost (localhost [127.0.0.1])
 by bes.se.axis.com (Postfix) with ESMTP id 619F62E151
 for <lttng-dev@lists.lttng.org>; Wed, 10 Feb 2016 11:11:56 +0100 (CET)
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
 by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 3qoxNe0tzJSs for <lttng-dev@lists.lttng.org>;
 Wed, 10 Feb 2016 11:11:55 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
 by bes.se.axis.com (Postfix) with ESMTP id A0ADB2E14D
 for <lttng-dev@lists.lttng.org>; Wed, 10 Feb 2016 11:11:55 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
 by postfix.imss71 (Postfix) with ESMTP id 7B40D1289
 for <lttng-dev@lists.lttng.org>; Wed, 10 Feb 2016 11:11:55 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
 by boulder.se.axis.com (Postfix) with ESMTP id 700E4E0
 for <lttng-dev@lists.lttng.org>; Wed, 10 Feb 2016 11:11:55 +0100 (CET)
Received: from lnxolofjn.se.axis.com (lnxolofjn.se.axis.com [10.92.17.1])
 by thoth.se.axis.com (Postfix) with ESMTP id 6DCB434240
 for <lttng-dev@lists.lttng.org>; Wed, 10 Feb 2016 11:11:55 +0100 (CET)
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

From: Olof Johansson <olof.johansson@axis.com>

On some platforms, you have to link with rt to get clock_gettime. This
solves errors like:

 undefined reference to `clock_gettime'

Fixes: #996

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 configure.ac | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 39a7777..c3cf60e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -79,7 +79,6 @@ AC_FUNC_MMAP
 AC_FUNC_FORK
 AC_CHECK_FUNCS([ \
 	atexit \
-	clock_gettime \
 	getcpuid \
 	gettid \
 	gettimeofday \
@@ -215,6 +214,11 @@ AC_COMPILE_IFELSE([AC_LANG_SOURCE([[
 	compat_futex_test=1
 ])
 
+# Search for clock_gettime
+AC_SEARCH_LIBS([clock_gettime], [rt], [],
+	[AC_MSG_ERROR([Cannot find clock_gettime function.])]
+)
+
 # Check for pthread
 AC_CHECK_LIB([pthread], [pthread_create],
 	[AM_CONDITIONAL(LIBC_INCLUDES_PTHREAD, false)],
-- 
2.1.4
