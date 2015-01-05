From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: ust-app null pointer check
	needed for main refactoring
Date: Mon,  5 Jan 2015 15:05:22 -0500
Message-ID: <1420488322-23132-1-git-send-email-mathieu.desnoyers__20081.3260781162$1420488466$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1Y8Du9-00054T-A2
 for lttng-dev@lists.lttng.org; Mon, 05 Jan 2015 15:05:37 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/ust-app.c | 42 ++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 9ab5f77..bc1d62d 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -3408,31 +3408,43 @@ void ust_app_clean_list(void)
 
 	rcu_read_lock();
 
-	cds_lfht_for_each_entry(ust_app_ht->ht, &iter.iter, app, pid_n.node) {
-		ret = lttng_ht_del(ust_app_ht, &iter);
-		assert(!ret);
-		call_rcu(&app->pid_n.head, delete_ust_app_rcu);
+	if (ust_app_ht) {
+		cds_lfht_for_each_entry(ust_app_ht->ht, &iter.iter, app, pid_n.node) {
+			ret = lttng_ht_del(ust_app_ht, &iter);
+			assert(!ret);
+			call_rcu(&app->pid_n.head, delete_ust_app_rcu);
+		}
 	}
 
 	/* Cleanup socket hash table */
-	cds_lfht_for_each_entry(ust_app_ht_by_sock->ht, &iter.iter, app,
-			sock_n.node) {
-		ret = lttng_ht_del(ust_app_ht_by_sock, &iter);
-		assert(!ret);
+	if (ust_app_ht_by_sock) {
+		cds_lfht_for_each_entry(ust_app_ht_by_sock->ht, &iter.iter, app,
+				sock_n.node) {
+			ret = lttng_ht_del(ust_app_ht_by_sock, &iter);
+			assert(!ret);
+		}
 	}
 
 	/* Cleanup notify socket hash table */
-	cds_lfht_for_each_entry(ust_app_ht_by_notify_sock->ht, &iter.iter, app,
-			notify_sock_n.node) {
-		ret = lttng_ht_del(ust_app_ht_by_notify_sock, &iter);
-		assert(!ret);
+	if (ust_app_ht_by_notify_sock) {
+		cds_lfht_for_each_entry(ust_app_ht_by_notify_sock->ht, &iter.iter, app,
+				notify_sock_n.node) {
+			ret = lttng_ht_del(ust_app_ht_by_notify_sock, &iter);
+			assert(!ret);
+		}
 	}
 	rcu_read_unlock();
 
 	/* Destroy is done only when the ht is empty */
-	ht_cleanup_push(ust_app_ht);
-	ht_cleanup_push(ust_app_ht_by_sock);
-	ht_cleanup_push(ust_app_ht_by_notify_sock);
+	if (ust_app_ht) {
+		ht_cleanup_push(ust_app_ht);
+	}
+	if (ust_app_ht_by_sock) {
+		ht_cleanup_push(ust_app_ht_by_sock);
+	}
+	if (ust_app_ht_by_notify_sock) {
+		ht_cleanup_push(ust_app_ht_by_notify_sock);
+	}
 }
 
 /*
-- 
2.1.1
