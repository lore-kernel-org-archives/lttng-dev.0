From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [MODULES PATCH 4/4] Fix: compile
	lttng_statedump_process_ns on Ubuntu
Date: Wed,  1 Oct 2014 11:05:11 -0400
Message-ID: <1412175911-27001-4-git-send-email-jdesfossez__22152.8860893615$1412175977$gmane$org@efficios.com>
References: <1412175911-27001-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1XZLT2-0004eB-7b
 for lttng-dev@lists.lttng.org; Wed, 01 Oct 2014 11:05:25 -0400
In-Reply-To: <1412175911-27001-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Fixes: #838

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 lttng-statedump-impl.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lttng-statedump-impl.c b/lttng-statedump-impl.c
index d4f29fd..bab5d9f 100644
--- a/lttng-statedump-impl.c
+++ b/lttng-statedump-impl.c
@@ -411,12 +411,13 @@ void lttng_statedump_process_ns(struct lttng_session *session,
 	 * "namespaces: Use task_lock and not rcu to protect nsproxy"
 	 * for details.
 	 */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0) || \
+		LTTNG_UBUNTU_KERNEL_RANGE(3,13,11,36, 3,14,0,0))
 	proxy = p->nsproxy;
-#else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)) */
+#else
 	rcu_read_lock();
 	proxy = task_nsproxy(p);
-#endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)) */
+#endif
 	if (proxy) {
 		pid_ns = lttng_get_proxy_pid_ns(proxy);
 		do {
@@ -428,11 +429,12 @@ void lttng_statedump_process_ns(struct lttng_session *session,
 		trace_lttng_statedump_process_state(session,
 			p, type, mode, submode, status, NULL);
 	}
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0) || \
+		LTTNG_UBUNTU_KERNEL_RANGE(3,13,11,36, 3,14,0,0))
 	/* (nothing) */
-#else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)) */
+#else
 	rcu_read_unlock();
-#endif /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)) */
+#endif
 }
 
 static
-- 
1.9.1
