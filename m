From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] Fix: per-pid ust buffers flush race with
	application unregister
Date: Tue, 23 Feb 2016 19:41:40 -0500
Message-ID: <1456274500-9781-1-git-send-email-mathieu.desnoyers__28393.8889312141$1456274567$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1aYNWZ-0001yK-La
 for lttng-dev@lists.lttng.org; Tue, 23 Feb 2016 19:41:52 -0500
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

If an application exits between the moment we create the ust app session
(shadow copy) and the moment we send channels to the application,
sending channels may fail. If the application unregisters between the
the end of ust app session creation and the destroy that follows (ust
app session lock is released in between), we may see is_sent being
false.

This assert was initially there in the early days of lttng-tools when
the application was responsible for doing the flush. Now that the flush
has been moved to the consumer daemon, we don't need this assertion
anymore.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/ust-app.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 8c45a89..160a156 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -4469,7 +4469,6 @@ int ust_app_flush_app_session(struct ust_app *app,
 		cds_lfht_for_each_entry(ua_sess->channels->ht, &iter.iter, ua_chan,
 				node.node) {
 			health_code_update();
-			assert(ua_chan->is_sent);
 			ret = consumer_flush_channel(socket, ua_chan->key);
 			if (ret) {
 				ERR("Error flushing consumer channel");
-- 
2.1.4
