From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH urcu] x86: drop extra semi-colon in caa_cpu_relax
Date: Thu, 31 Jul 2014 00:21:51 +0000
Message-ID: <20140731002151.GA32652__318.351659416471$1406766170$gmane$org@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from dcvr.yhbt.net ([64.71.152.64] ident=normalperson)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <normalperson@yhbt.net>) id 1XCe80-0007Py-96
 for lttng-dev@lists.lttng.org; Wed, 30 Jul 2014 20:21:56 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This fixes compilation in braceless if/else constructs:

	if (expr)
		caa_cpu_relax();
	else
		...

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
  Btw, did you notice my rculfhash patches last month.
  I just realize I forgot to Cc you directly.
  Thanks for URCU!

 urcu/arch/x86.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/urcu/arch/x86.h b/urcu/arch/x86.h
index 7af1ca5..ccc4ce8 100644
--- a/urcu/arch/x86.h
+++ b/urcu/arch/x86.h
@@ -66,7 +66,7 @@ extern "C" {
 #endif
 #endif
 
-#define caa_cpu_relax()	__asm__ __volatile__ ("rep; nop" : : : "memory");
+#define caa_cpu_relax()	__asm__ __volatile__ ("rep; nop" : : : "memory")
 
 #define rdtscll(val)							  \
 	do {						  		  \
-- 
EW
