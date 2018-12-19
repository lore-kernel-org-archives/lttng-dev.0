From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: don't start tracing twice for
 UST applications
Date: Wed, 19 Dec 2018 12:26:43 -0500
Message-ID: <20181219172643.28954-1-mathieu.desnoyers__24356.2369644225$1545240291$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43Khdh5FGhz16Pn
 for <lttng-dev@lists.lttng.org>; Wed, 19 Dec 2018 12:26:48 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The change introduced by commit 0498a00cbc "Fix: sessiond: don't
allocate buffers and files for inactive sessions" adds a
ust_app_global_update() for each application without removing the
pre-existing ust_app_start_trace(), which effectively attempts to start
tracing twice for each application already registered prior to the
"start" command.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/ust-app.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 0b0a6253..feb59d80 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -5018,7 +5018,6 @@ end:
  */
 int ust_app_start_trace_all(struct ltt_ust_session *usess)
 {
-	int ret = 0;
 	struct lttng_ht_iter iter;
 	struct ust_app *app;
 
@@ -5044,14 +5043,6 @@ int ust_app_start_trace_all(struct ltt_ust_session *usess)
 		ust_app_global_update(usess, app);
 	}
 
-	cds_lfht_for_each_entry(ust_app_ht->ht, &iter.iter, app, pid_n.node) {
-		ret = ust_app_start_trace(usess, app);
-		if (ret < 0) {
-			/* Continue to next apps even on error */
-			continue;
-		}
-	}
-
 	rcu_read_unlock();
 
 	return 0;
-- 
2.11.0
