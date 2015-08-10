From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-ust] Build: only check if python exist in
	path
Date: Mon, 10 Aug 2015 14:45:30 -0400
Message-ID: <1439232334-31308-1-git-send-email-jonathan.rajotte-julien__11448.533277917$1439232505$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZOs6a-0001TE-9O
 for lttng-dev@lists.lttng.org; Mon, 10 Aug 2015 14:47:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id EFFB434053D
 for <lttng-dev@lists.lttng.org>; Mon, 10 Aug 2015 18:47:22 +0000 (UTC)
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

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 0e9886b..d2b6bcb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -363,7 +363,7 @@ AC_ARG_WITH([lttng-system-rundir],
 AC_DEFINE_UNQUOTED([LTTNG_SYSTEM_RUNDIR], ["$lttng_system_rundir"],
 	[LTTng system runtime directory])
 
-AM_PATH_PYTHON([2.7],BUILD_GEN_TP_EXAMPLES=1,[:])
+AC_CHECK_PROG([BUILD_GEN_TP_EXAMPLES],[python],["yes"])
 AM_CONDITIONAL([BUILD_GEN_TP_EXAMPLES], [test $BUILD_GEN_TP_EXAMPLES], [Build examples requiring lttng-gen-tp])
 
 AC_CONFIG_FILES([
-- 
2.1.4
