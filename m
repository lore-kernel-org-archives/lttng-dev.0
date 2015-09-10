From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 3/3] Report error if any disable
	action fails
Date: Thu, 10 Sep 2015 16:10:57 -0400
Message-ID: <1441915857-1544-3-git-send-email-jonathan.rajotte-julien__715.217370498244$1441915995$gmane$org@efficios.com>
References: <1441915857-1544-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1Za8Bx-0006zu-Ru
 for lttng-dev@lists.lttng.org; Thu, 10 Sep 2015 16:11:34 -0400
In-Reply-To: <1441915857-1544-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng-sessiond/event.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/bin/lttng-sessiond/event.c b/src/bin/lttng-sessiond/event.c
index b5087a2..cfb8549 100644
--- a/src/bin/lttng-sessiond/event.c
+++ b/src/bin/lttng-sessiond/event.c
@@ -359,7 +359,7 @@ error:
 int event_ust_disable_all_tracepoints(struct ltt_ust_session *usess,
 		struct ltt_ust_channel *uchan)
 {
-	int ret, i, size;
+	int ret, i, size, error = 0;
 	struct lttng_ht_iter iter;
 	struct ltt_ust_event *uevent = NULL;
 	struct lttng_event *events = NULL;
@@ -376,6 +376,7 @@ int event_ust_disable_all_tracepoints(struct ltt_ust_session *usess,
 			ret = event_ust_disable_tracepoint(usess, uchan,
 					uevent->attr.name);
 			if (ret < 0) {
+				error = LTTNG_ERR_UST_DISABLE_FAIL;
 				continue;
 			}
 		}
@@ -391,15 +392,14 @@ int event_ust_disable_all_tracepoints(struct ltt_ust_session *usess,
 	for (i = 0; i < size; i++) {
 		ret = event_ust_disable_tracepoint(usess, uchan,
 				events[i].name);
-		if (ret != LTTNG_OK) {
+		if (ret < 0) {
 			/* Continue to disable the rest... */
+			error = LTTNG_ERR_UST_DISABLE_FAIL;
 			continue;
 		}
 	}
-	free(events);
 
-	rcu_read_unlock();
-	return LTTNG_OK;
+	ret = error ? error : LTTNG_OK;
 
 error:
 	free(events);
-- 
2.1.4
