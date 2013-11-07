From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 08/28] Add exclusion data to
	trace_ust_find_event
Date: Thu,  7 Nov 2013 12:21:12 +0200
Message-ID: <1383819672-6713-1-git-send-email-jp_ikaheimonen__22690.5117430308$1383819727$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMiK-0007NP-W6
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:21:25 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1VeMiF-0006Ab-I6 from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:21:19 -0800
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Add exclusion data to prototype of trace_ust_find_event()
Add exclusion data to the key structure in trace_ust_find_event()
Call trace_ust_find_event with exclusion data wherever possible

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 src/bin/lttng-sessiond/event.c     | 4 ++--
 src/bin/lttng-sessiond/trace-ust.c | 4 +++-
 src/bin/lttng-sessiond/trace-ust.h | 6 ++++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/src/bin/lttng-sessiond/event.c b/src/bin/lttng-sessiond/event.c
index 8be9fc6..fedd18c 100644
--- a/src/bin/lttng-sessiond/event.c
+++ b/src/bin/lttng-sessiond/event.c
@@ -350,7 +350,7 @@ int event_ust_enable_all_tracepoints(struct ltt_ust_session *usess,
 		 * previously.
 		 */
 		uevent = trace_ust_find_event(uchan->events, events[i].name, filter,
-				events[i].loglevel);
+				events[i].loglevel, NULL);
 		if (uevent != NULL) {
 			ret = ust_app_enable_event_pid(usess, uchan, uevent,
 					events[i].pid);
@@ -421,7 +421,7 @@ int event_ust_enable_tracepoint(struct ltt_ust_session *usess,
 	rcu_read_lock();
 
 	uevent = trace_ust_find_event(uchan->events, event->name, filter,
-			event->loglevel);
+			event->loglevel, exclusion);
 	if (uevent == NULL) {
 		uevent = trace_ust_create_event(event, filter, exclusion);
 		if (uevent == NULL) {
diff --git a/src/bin/lttng-sessiond/trace-ust.c b/src/bin/lttng-sessiond/trace-ust.c
index 2119717..657d6e5 100644
--- a/src/bin/lttng-sessiond/trace-ust.c
+++ b/src/bin/lttng-sessiond/trace-ust.c
@@ -168,7 +168,8 @@ error:
  * MUST be acquired before calling this.
  */
 struct ltt_ust_event *trace_ust_find_event(struct lttng_ht *ht,
-		char *name, struct lttng_filter_bytecode *filter, int loglevel)
+		char *name, struct lttng_filter_bytecode *filter, int loglevel,
+		struct lttng_event_exclusion *exclusion)
 {
 	struct lttng_ht_node_str *node;
 	struct lttng_ht_iter iter;
@@ -180,6 +181,7 @@ struct ltt_ust_event *trace_ust_find_event(struct lttng_ht *ht,
 	key.name = name;
 	key.filter = filter;
 	key.loglevel = loglevel;
+	key.exclusion = exclusion;
 
 	cds_lfht_lookup(ht->ht, ht->hash_fct((void *) name, lttng_ht_seed),
 			trace_ust_ht_match_event, &key, &iter.iter);
diff --git a/src/bin/lttng-sessiond/trace-ust.h b/src/bin/lttng-sessiond/trace-ust.h
index 9d2b457..9f8d182 100644
--- a/src/bin/lttng-sessiond/trace-ust.h
+++ b/src/bin/lttng-sessiond/trace-ust.h
@@ -157,7 +157,8 @@ int trace_ust_ht_match_event_by_name(struct cds_lfht_node *node,
  * Lookup functions. NULL is returned if not found.
  */
 struct ltt_ust_event *trace_ust_find_event(struct lttng_ht *ht,
-		char *name, struct lttng_filter_bytecode *filter, int loglevel);
+		char *name, struct lttng_filter_bytecode *filter, int loglevel,
+		struct lttng_event_exclusion *exclusion);
 struct ltt_ust_channel *trace_ust_find_channel_by_name(struct lttng_ht *ht,
 		char *name);
 
@@ -252,7 +253,8 @@ struct ltt_ust_context *trace_ust_create_context(
 	return NULL;
 }
 static inline struct ltt_ust_event *trace_ust_find_event(struct lttng_ht *ht,
-		char *name, struct lttng_filter_bytecode *filter, int loglevel)
+		char *name, struct lttng_filter_bytecode *filter, int loglevel,
+		struct lttng_event_exclusion *exclusion)
 {
 	return NULL;
 }
-- 
1.8.1.2
