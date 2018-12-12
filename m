From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: do not repurpose iterator
 while it is being used
Date: Wed, 12 Dec 2018 17:24:11 -0500
Message-ID: <20181212222411.24517-1-mathieu.desnoyers__21192.1462476768$1544653337$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43FWZ66xZgz15mw
 for <lttng-dev@lists.lttng.org>; Wed, 12 Dec 2018 17:24:14 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jgalar@efficios.com, joraj@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The hash table iteration uses an iterator that needs to stay valid for
the next loop. Using that same iterator variable in a nested lookup
in a different hash table leads to segmentation fault.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng-sessiond/notification-thread-events.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng-sessiond/notification-thread-events.c b/src/bin/lttng-sessiond/notification-thread-events.c
index 9cc91cc4..9d82b831 100644
--- a/src/bin/lttng-sessiond/notification-thread-events.c
+++ b/src/bin/lttng-sessiond/notification-thread-events.c
@@ -1931,6 +1931,7 @@ int bind_trigger_to_matching_channels(const struct lttng_trigger *trigger,
 			channels_ht_node) {
 		struct lttng_trigger_list_element *trigger_list_element;
 		struct lttng_channel_trigger_list *trigger_list;
+		struct cds_lfht_iter lookup_iter;
 
 		if (!trigger_applies_to_channel(trigger, channel)) {
 			continue;
@@ -1940,8 +1941,8 @@ int bind_trigger_to_matching_channels(const struct lttng_trigger *trigger,
 				hash_channel_key(&channel->key),
 				match_channel_trigger_list,
 				&channel->key,
-				&iter);
-		node = cds_lfht_iter_get_node(&iter);
+				&lookup_iter);
+		node = cds_lfht_iter_get_node(&lookup_iter);
 		assert(node);
 		trigger_list = caa_container_of(node,
 				struct lttng_channel_trigger_list,
-- 
2.11.0
