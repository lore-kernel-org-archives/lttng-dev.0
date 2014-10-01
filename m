From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [MODULES PATCH 3/4] Reverse version check logic in
	lttng_statedump_process_ns
Date: Wed,  1 Oct 2014 11:05:10 -0400
Message-ID: <1412175911-27001-3-git-send-email-jdesfossez__7306.71441783688$1412176091$gmane$org@efficios.com>
References: <1412175911-27001-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1XZLT3-0004eD-97
 for lttng-dev@lists.lttng.org; Wed, 01 Oct 2014 11:05:30 -0400
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

This allows to keep the most up-to-date branch on top.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 lttng-statedump-impl.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lttng-statedump-impl.c b/lttng-statedump-impl.c
index 656cebb..d4f29fd 100644
--- a/lttng-statedump-impl.c
+++ b/lttng-statedump-impl.c
@@ -411,12 +411,12 @@ void lttng_statedump_process_ns(struct lttng_session *session,
 	 * "namespaces: Use task_lock and not rcu to protect nsproxy"
 	 * for details.
 	 */
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0))
+	proxy = p->nsproxy;
+#else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)) */
 	rcu_read_lock();
 	proxy = task_nsproxy(p);
-#else /* #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)) */
-	proxy = p->nsproxy;
-#endif /* #else #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)) */
+#endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)) */
 	if (proxy) {
 		pid_ns = lttng_get_proxy_pid_ns(proxy);
 		do {
@@ -428,9 +428,11 @@ void lttng_statedump_process_ns(struct lttng_session *session,
 		trace_lttng_statedump_process_state(session,
 			p, type, mode, submode, status, NULL);
 	}
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0))
+	/* (nothing) */
+#else /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)) */
 	rcu_read_unlock();
-#endif /* #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)) */
+#endif /* #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)) */
 }
 
 static
-- 
1.9.1
