From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: [PATCH] urcu-bp/urcu-qsbr: remove unneeded DEBUG_YIELD
	code
Date: Tue, 2 Dec 2014 17:32:32 +0800
Message-ID: <1417512752-9711-1-git-send-email-laijs__46093.3258444586$1417512601$gmane$org@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <laijs@cn.fujitsu.com>) id 1XvjlV-0001D8-Ma
 for lttng-dev@lists.lttng.org; Tue, 02 Dec 2014 04:29:04 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

They were moved to debug-yield.c

Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
---
 urcu-bp.c   |    5 -----
 urcu-qsbr.c |    5 -----
 2 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/urcu-bp.c b/urcu-bp.c
index 1856d3f..6b2875d 100644
--- a/urcu-bp.c
+++ b/urcu-bp.c
@@ -106,11 +106,6 @@ static int initialized;
 
 static pthread_key_t urcu_bp_key;
 
-#ifdef DEBUG_YIELD
-unsigned int rcu_yield_active;
-DEFINE_URCU_TLS(unsigned int, rcu_rand_yield);
-#endif
-
 struct rcu_gp rcu_gp = { .ctr = RCU_GP_COUNT };
 
 /*
diff --git a/urcu-qsbr.c b/urcu-qsbr.c
index 71e7a39..a35dcfc 100644
--- a/urcu-qsbr.c
+++ b/urcu-qsbr.c
@@ -66,11 +66,6 @@ struct rcu_gp rcu_gp = { .ctr = RCU_GP_ONLINE };
  */
 DEFINE_URCU_TLS(struct rcu_reader, rcu_reader);
 
-#ifdef DEBUG_YIELD
-unsigned int rcu_yield_active;
-DEFINE_URCU_TLS(unsigned int, rcu_rand_yield);
-#endif
-
 static CDS_LIST_HEAD(registry);
 
 /*
-- 
1.7.4.4
