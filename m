From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools master,
 2.11] Fix: destroy command: put consumer output after destroy
 notifier
Date: Fri, 20 Sep 2019 17:41:14 -0400
Message-ID: <20190920214114.1073-1-mathieu.desnoyers__24535.2197600127$1569015722$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46ZnGY4wxSzr04
 for <lttng-dev@lists.lttng.org>; Fri, 20 Sep 2019 17:41:25 -0400 (EDT)
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

The destroy notifier needs to access the consumer output to format
the absolute path to the last chunk.

The observed problematic behavior can be observed by doing a
rotate and a destroy command in quick succession. Sometimes,
the resulting path printed by the destroy command is incomplete:

e.g. /archives/20190920T163616-0400-20190920T163618-0400-1

when we would expect:

/home/efficios/lttng-traces/auto-20190920-164425/archives/20190920T164437-0400-20190920T164439-0400-1

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/session.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/bin/lttng-sessiond/session.c b/src/bin/lttng-sessiond/session.c
index 9072a2ec..7fd4332e 100644
--- a/src/bin/lttng-sessiond/session.c
+++ b/src/bin/lttng-sessiond/session.c
@@ -811,7 +811,6 @@ void session_release(struct urcu_ref *ref)
 
 	DBG("Destroying session %s (id %" PRIu64 ")", session->name, session->id);
 
-	consumer_output_put(session->consumer);
 	snapshot_destroy(&session->snapshot);
 
 	pthread_mutex_destroy(&session->lock);
@@ -823,6 +822,7 @@ void session_release(struct urcu_ref *ref)
 	}
 	session_notify_destruction(session);
 
+	consumer_output_put(session->consumer);
 	kernel_free_session(ksess);
 	session->kernel_session = NULL;
 	if (usess) {
-- 
2.17.1
