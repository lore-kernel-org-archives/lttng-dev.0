From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 1/3] Make disable-event ignore
 exclusions in the event.
Date: Fri, 27 Sep 2013 07:14:39 +0000
Message-ID: <009B25148989C6458484484699278506E538A670__1640.23136389932$1380266174$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VPSGF-0002Jn-Fm
	for lttng-dev@lists.lttng.org; Fri, 27 Sep 2013 03:14:51 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

When looking for suitable events in disable-event,
ignore the exclusion parts of the enabled event names.
---
 src/bin/lttng-sessiond/event.c     | 57 ++++++++++++++++----------------------
 src/bin/lttng-sessiond/trace-ust.c | 20 +++++++------
 2 files changed, 36 insertions(+), 41 deletions(-)

diff --git a/src/bin/lttng-sessiond/event.c b/src/bin/lttng-sessiond/event.c
index 9a8ed63..55501b5 100644
--- a/src/bin/lttng-sessiond/event.c
+++ b/src/bin/lttng-sessiond/event.c
@@ -505,48 +505,39 @@ int event_ust_disable_tracepoint(struct ltt_ust_session *usess,
 	assert(event_name);
 
 	ht = uchan->events;
+	int none_found = 1;
 
 	rcu_read_lock();
 
-	/*
-	 * We use a custom lookup since we need the iterator for the next_duplicate
-	 * call in the do while loop below.
-	 */
-	cds_lfht_lookup(ht->ht, ht->hash_fct((void *) event_name, lttng_ht_seed),
-			trace_ust_ht_match_event_by_name, event_name, &iter.iter);
+	cds_lfht_first(ht->ht, &iter.iter);
 	node = lttng_ht_iter_get_node_str(&iter);
-	if (node == NULL) {
+	while (node != NULL) {
+		if (trace_ust_ht_match_event_by_name(&(node->node), event_name)) {
+			none_found = 0;
+			uevent = caa_container_of(node, struct ltt_ust_event, node);
+			assert(uevent);
+			if (uevent->enabled == 1) {
+
+				ret = ust_app_disable_event_glb(usess, uchan, uevent);
+				if (ret < 0 && ret != -LTTNG_UST_ERR_EXIST) {
+					ret = LTTNG_ERR_UST_DISABLE_FAIL;
+					goto error;
+				}
+				uevent->enabled = 0;
+
+				DBG2("Event UST %s disabled in channel %s", uevent->attr.name,
+					uchan->name);
+			}
+		}
+		cds_lfht_next(ht->ht, &iter.iter);
+		node = lttng_ht_iter_get_node_str(&iter);
+	}
+	if (none_found == 1) {
 		DBG2("Trace UST event NOT found by name %s", event_name);
 		ret = LTTNG_ERR_UST_EVENT_NOT_FOUND;
 		goto error;
 	}
 
-	do {
-		uevent = caa_container_of(node, struct ltt_ust_event, node);
-		assert(uevent);
-
-		if (uevent->enabled == 0) {
-			/* It's already disabled so everything is OK */
-			goto next;
-		}
-
-		ret = ust_app_disable_event_glb(usess, uchan, uevent);
-		if (ret < 0 && ret != -LTTNG_UST_ERR_EXIST) {
-			ret = LTTNG_ERR_UST_DISABLE_FAIL;
-			goto error;
-		}
-		uevent->enabled = 0;
-
-		DBG2("Event UST %s disabled in channel %s", uevent->attr.name,
-				uchan->name);
-
-next:
-		/* Get next duplicate event by name. */
-		cds_lfht_next_duplicate(ht->ht, trace_ust_ht_match_event_by_name,
-				event_name, &iter.iter);
-		node = lttng_ht_iter_get_node_str(&iter);
-	} while (node);
-
 	ret = LTTNG_OK;
 
 error:
diff --git a/src/bin/lttng-sessiond/trace-ust.c b/src/bin/lttng-sessiond/trace-ust.c
index 8363ae2..8ba6f92 100644
--- a/src/bin/lttng-sessiond/trace-ust.c
+++ b/src/bin/lttng-sessiond/trace-ust.c
@@ -38,20 +38,24 @@ int trace_ust_ht_match_event_by_name(struct cds_lfht_node *node,
 		const void *_key)
 {
 	struct ltt_ust_event *event;
-	const char *name;
-
+	int length;
 	assert(node);
 	assert(_key);
-
 	event = caa_container_of(node, struct ltt_ust_event, node.node);
-	name = _key;
-
-	/* Event name */
-	if (strncmp(event->attr.name, name, sizeof(event->attr.name)) != 0) {
+	/* a full name match is accepted */
+	if (strncmp(event->attr.name, _key, sizeof(event->attr.name) == 0))
+		goto match;
+	/* compare to event name up to the first wildcard character or NUL */
+	length = strcspn(event->attr.name, "*");
+	if (event->attr.name[length] == '*')
+		length++;
+	if (length != strlen(_key))
+		goto no_match;
+	if (strncmp(event->attr.name, _key, length) != 0)
 		goto no_match;
-	}
 
 	/* Match */
+match:
 	return 1;
 
 no_match:
-- 
1.8.1.2
