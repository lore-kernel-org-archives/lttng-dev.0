From: Didier Nadeau <didier.nadeau@gmail.com>
Subject: [PATCH] Support for Xeon-Phi with newer MPSS
Date: Wed, 16 Dec 2015 15:02:47 -0500
Message-ID: <1450296167-9584-1-git-send-email-didier.nadeau__179.506225004111$1450296214$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <didier.nadeau@gmail.com>) id 1a9IHS-000550-KM
 for lttng-dev@lists.lttng.org; Wed, 16 Dec 2015 15:02:35 -0500
Received: by mail-ig0-f172.google.com with SMTP id to18so64275170igc.0
 for <lttng-dev@lists.lttng.org>; Wed, 16 Dec 2015 12:02:34 -0800 (PST)
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

The Xeon-Phi is now considered as a new architecture instead of a
vendor in MPSS version 3.4.4. This change is backward compatible with
previous MPSS versions.

Signed-off-by: Didier Nadeau <didier.nadeau@gmail.com>
---
 configure.ac | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index e7e300b..39a7777 100644
--- a/configure.ac
+++ b/configure.ac
@@ -103,6 +103,7 @@ AC_CHECK_HEADERS([ \
 
 # Find arch type
 AS_CASE([$host_cpu],
+	[k1om], [ARCHTYPE="x86"],
 	[i386], [ARCHTYPE="x86" && SUBARCHTYPE="x86compat"],
 	[i486], [ARCHTYPE="x86"],
 	[i586], [ARCHTYPE="x86"],
@@ -189,7 +190,7 @@ AS_IF([test "x$ARCHTYPE" = "xx86"],[
 	#
 	#k1om is the name for the Intel MIC family (Xeon Phi). It is an x86_64
 	#variant but lacks fence instructions.
-	AS_IF([test "x$host_cpu" != "xi386" -a "x$host_cpu" != "xi486" -a "x$host_cpu" != "xi586" -a "x$host_cpu" != "xi686" -a "x$host_vendor" != "xk1om"],[
+	AS_IF([test "x$host_cpu" != "xi386" -a "x$host_cpu" != "xi486" -a "x$host_cpu" != "xi586" -a "x$host_cpu" != "xi686" -a "x$host_vendor" != "xk1om" -a "x$host_cpu" != "xk1om"],[
 		AC_MSG_RESULT([yes])
 		AC_DEFINE([CONFIG_RCU_HAVE_FENCE], [1])
 	],[
-- 
1.9.1
