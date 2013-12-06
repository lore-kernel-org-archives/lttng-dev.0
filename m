From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH userspace-rcu] Set RCU_HAVE_FENCE to false on
	Intel Xeon Phi
Date: Fri,  6 Dec 2013 16:17:55 -0500
Message-ID: <1386364675-9225-1-git-send-email-simon.marchi__38122.7441983812$1386364706$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simon.marchi@polymtl.ca>) id 1Vp2lu-0005yl-4R
	for lttng-dev@lists.lttng.org; Fri, 06 Dec 2013 16:17:19 -0500
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

It currently fails to compile, because the Phi does not have fence
instructions.

It will use lock prefixed instructions for all memory barriers, which
is overkill for this platform, but at least it will work.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 configure.ac |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index 774094e..079c145 100644
--- a/configure.ac
+++ b/configure.ac
@@ -140,7 +140,10 @@ AS_IF([test "x$ARCHTYPE" = "xx86"],[
 	#For now, using lock; addl compatibility mode even for i686, because the
 	#Pentium III is seen as a i686, but lacks mfence instruction.
 	#Only using fence for x86_64.
-	AS_IF([test "x$host_cpu" != "xi386" -a "x$host_cpu" != "xi486" -a "x$host_cpu" != "xi586" -a "x$host_cpu" != "xi686"],[
+	#
+	#k1om is the name for the Intel MIC family (Xeon Phi). It is an x86_64
+	#variant but lacks fence instructions.
+	AS_IF([test "x$host_cpu" != "xi386" -a "x$host_cpu" != "xi486" -a "x$host_cpu" != "xi586" -a "x$host_cpu" != "xi686" -a "x$host_vendor" != "xk1om"],[
 		AC_MSG_RESULT([yes])
 		AC_DEFINE([CONFIG_RCU_HAVE_FENCE], [1])
 	],[
-- 
1.7.1
