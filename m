From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: sessiond: disable: match app
	event by name
Date: Wed,  9 Sep 2015 17:08:20 -0400
Message-ID: <1441832900-7573-1-git-send-email-jonathan.rajotte-julien__29421.4311092675$1441832975$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1ZZmbb-0008Qv-Ch
 for lttng-dev@lists.lttng.org; Wed, 09 Sep 2015 17:08:37 -0400
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

The use of a simple lookup and match on event name is insufficient
to identify the corresponding ust app event.

Fixes #914

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng-sessiond/ust-app.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 4066b06..53a6f93 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -3873,7 +3873,7 @@ int ust_app_disable_event_glb(struct ltt_ust_session *usess,
 {
 	int ret = 0;
 	struct lttng_ht_iter iter, uiter;
-	struct lttng_ht_node_str *ua_chan_node, *ua_event_node;
+	struct lttng_ht_node_str *ua_chan_node;
 	struct ust_app *app;
 	struct ust_app_session *ua_sess;
 	struct ust_app_channel *ua_chan;
@@ -3910,14 +3910,14 @@ int ust_app_disable_event_glb(struct ltt_ust_session *usess,
 		}
 		ua_chan = caa_container_of(ua_chan_node, struct ust_app_channel, node);
 
-		lttng_ht_lookup(ua_chan->events, (void *)uevent->attr.name, &uiter);
-		ua_event_node = lttng_ht_iter_get_node_str(&uiter);
-		if (ua_event_node == NULL) {
+		ua_event = find_ust_app_event(ua_chan->events, uevent->attr.name,
+				uevent->filter, uevent->attr.loglevel,
+				uevent->exclusion);
+		if (ua_event == NULL) {
 			DBG2("Event %s not found in channel %s for app pid %d."
 					"Skipping", uevent->attr.name, uchan->name, app->pid);
 			continue;
 		}
-		ua_event = caa_container_of(ua_event_node, struct ust_app_event, node);
 
 		ret = disable_ust_app_event(ua_sess, ua_event, app);
 		if (ret < 0) {
-- 
2.1.4
