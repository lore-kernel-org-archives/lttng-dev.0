From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: [PATCH 1/3] urcu: avoid "expression result unused" from
	clang
Date: Fri, 7 Dec 2012 17:24:53 +0800
Message-ID: <1354872295-32371-1-git-send-email-laijs__20378.195323474$1354872359$gmane$org@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1TguBH-0007oh-Gu
	for lttng-dev@lists.lttng.org; Fri, 07 Dec 2012 04:25:16 -0500
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id qB79PaMH016399
	for <lttng-dev@lists.lttng.org>; Fri, 7 Dec 2012 17:25:36 +0800
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

The last expression result is unused and clang will complain.
The trick in the patch supresses the complaint

Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
---
 urcu/system.h        |    5 ++++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/urcu/system.h b/urcu/system.h
index 2a45f22..6b7b0af 100644
--- a/urcu/system.h
+++ b/urcu/system.h
@@ -46,12 +46,15 @@
 /*
  * Store v into x, where x is located in shared memory. Performs the
  * required cache flush after writing. Returns v.
+ * "_w" here avoids the warning from clang:
+ * 	warning: expression result unused [-Wunused-value]
  */
 #define CMM_STORE_SHARED(x, v)		\
 	({				\
 		__typeof__(x) _v = _CMM_STORE_SHARED(x, v);	\
+		__typeof__(x) _w;	\
 		cmm_smp_wmc();		\
-		_v;			\
+		_w = _v;		\
 	})
 
 #endif /* _URCU_SYSTEM_H */
-- 
1.7.4.4
