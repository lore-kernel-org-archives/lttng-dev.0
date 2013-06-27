From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [LTTng-tools PATCH] Update URCU detection to correctly
	check for a 0.7 version
Date: Thu, 27 Jun 2013 17:03:29 -0400
Message-ID: <1372367009-8377-1-git-send-email-yannick.brosseau__26757.0145465017$1372367053$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UsJLx-00055Z-9A
	for lttng-dev@lists.lttng.org; Thu, 27 Jun 2013 17:03:41 -0400
Received: by mail-ob0-f178.google.com with SMTP id fb19so1257597obc.9
	for <lttng-dev@lists.lttng.org>; Thu, 27 Jun 2013 14:03:35 -0700 (PDT)
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
 configure.ac |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure.ac b/configure.ac
index 792679a..36c4ae1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -162,6 +162,10 @@ AC_CHECK_DECL([rcu_thread_online], [],
 AC_CHECK_DECL([caa_likely], [],
 	[AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu.h>]]
 )
+#Function added in urcu 0.7.0
+AC_CHECK_DECL([cmm_smp_mb__before_uatomic_or], [],
+        [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu.h>]]
+)
 
 AC_ARG_WITH(lttng-ust-prefix,
   AS_HELP_STRING([--with-lttng-ust-prefix=PATH],
-- 
1.7.10.4
