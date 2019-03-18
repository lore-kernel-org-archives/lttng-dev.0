From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 2/5] Fix: rcu: Remove wrapper
 definitions for obsolete RCU... (v5.1)
Date: Mon, 18 Mar 2019 16:20:33 -0400
Message-ID: <20190318202036.17523-2-mjeanson__3073.7266688206$1552940513$gmane$org@efficios.com>
References: <20190318202036.17523-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44NSHf4DQmz17XN
 for <lttng-dev@lists.lttng.org>; Mon, 18 Mar 2019 16:21:02 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id EB72D1C8D6D
 for <lttng-dev@lists.lttng.org>; Mon, 18 Mar 2019 16:21:01 -0400 (EDT)
In-Reply-To: <20190318202036.17523-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

See upstream commit :

commit 6ba7d681aca22e53385bdb35b1d7662e61905760
Author: Paul E. McKenney <paulmck@linux.ibm.com>
Date:   Wed Jan 9 15:22:03 2019 -0800

    rcu: Remove wrapper definitions for obsolete RCU update functions

    None of synchronize_rcu_bh, synchronize_rcu_bh_expedited, call_rcu_bh,
    rcu_barrier_bh, synchronize_sched, synchronize_sched_expedited,
    call_rcu_sched, rcu_barrier_sched, get_state_synchronize_sched, and
    cond_synchronize_sched are actually used.  This commit therefore removes
    their trivial wrapper-function definitions.
---
 lttng-events.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lttng-events.c b/lttng-events.c
index 566080a..f4206c5 100644
--- a/lttng-events.c
+++ b/lttng-events.c
@@ -75,7 +75,12 @@ int _lttng_field_statedump(struct lttng_session *session,
 
 void synchronize_trace(void)
 {
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,1,0))
+	synchronize_rcu();
+#else
 	synchronize_sched();
+#endif
+
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
 #ifdef CONFIG_PREEMPT_RT_FULL
 	synchronize_rcu();
-- 
2.17.1
