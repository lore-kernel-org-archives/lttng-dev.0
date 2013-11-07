From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 07/28] Add exclusion data to
	trace_ust_create_event
Date: Thu,  7 Nov 2013 12:20:09 +0200
Message-ID: <1383819609-6673-1-git-send-email-jp_ikaheimonen__2852.7585244321$1383819688$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMhL-00076y-Po
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:20:24 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1VeMhG-00061i-8g from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:20:18 -0800
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

Add exclusion data to the prototype of trace_ust_create_event
Copy exclusion data to the newly created ltt_ust_event structure
Call trace_ust_create_event with exclusion data, wherever possible

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 src/bin/lttng-sessiond/event.c     | 4 ++--
 src/bin/lttng-sessiond/trace-ust.c | 4 +++-
 src/bin/lttng-sessiond/trace-ust.h | 6 ++++--
 tests/unit/test_ust_data.c         | 2 +-
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/src/bin/lttng-sessiond/event.c b/src/bin/lttng-sessiond/event.c
index 791251e..8be9fc6 100644
--- a/src/bin/lttng-sessiond/event.c
+++ b/src/bin/lttng-sessiond/event.c
@@ -364,7 +364,7 @@ int event_ust_enable_all_tracepoints(struct ltt_ust_session *usess,
 		}
 
 		/* Create ust event */
-		uevent = trace_ust_create_event(&events[i], filter);
+		uevent = trace_ust_create_event(&events[i], filter, NULL);
 		if (uevent == NULL) {
 			ret = LTTNG_ERR_FATAL;
 			goto error_destroy;
@@ -423,7 +423,7 @@ int event_ust_enable_tracepoint(struct ltt_ust_session *usess,
 	uevent = trace_ust_find_event(uchan->events, event->name, filter,
 			event->loglevel);
 	if (uevent == NULL) {
-		uevent = trace_ust_create_event(event, filter);
+		uevent = trace_ust_create_event(event, filter, exclusion);
 		if (uevent == NULL) {
 			ret = LTTNG_ERR_UST_ENABLE_FAIL;
 			goto error;
diff --git a/src/bin/lttng-sessiond/trace-ust.c b/src/bin/lttng-sessiond/trace-ust.c
index c0fc3a0..2119717 100644
--- a/src/bin/lttng-sessiond/trace-ust.c
+++ b/src/bin/lttng-sessiond/trace-ust.c
@@ -330,7 +330,8 @@ error:
  * Return pointer to structure or NULL.
  */
 struct ltt_ust_event *trace_ust_create_event(struct lttng_event *ev,
-		struct lttng_filter_bytecode *filter)
+		struct lttng_filter_bytecode *filter,
+		struct lttng_event_exclusion *exclusion)
 {
 	struct ltt_ust_event *lue;
 
@@ -384,6 +385,7 @@ struct ltt_ust_event *trace_ust_create_event(struct lttng_event *ev,
 
 	/* Same layout. */
 	lue->filter = (struct lttng_ust_filter_bytecode *) filter;
+	lue->exclusion = (struct lttng_event_exclusion *) exclusion;
 
 	/* Init node */
 	lttng_ht_node_init_str(&lue->node, lue->attr.name);
diff --git a/src/bin/lttng-sessiond/trace-ust.h b/src/bin/lttng-sessiond/trace-ust.h
index 06d0202..9d2b457 100644
--- a/src/bin/lttng-sessiond/trace-ust.h
+++ b/src/bin/lttng-sessiond/trace-ust.h
@@ -167,7 +167,8 @@ struct ltt_ust_channel *trace_ust_find_channel_by_name(struct lttng_ht *ht,
 struct ltt_ust_session *trace_ust_create_session(uint64_t session_id);
 struct ltt_ust_channel *trace_ust_create_channel(struct lttng_channel *attr);
 struct ltt_ust_event *trace_ust_create_event(struct lttng_event *ev,
-		struct lttng_filter_bytecode *filter);
+		struct lttng_filter_bytecode *filter,
+		struct lttng_event_exclusion *exclusion);
 struct ltt_ust_metadata *trace_ust_create_metadata(char *path);
 struct ltt_ust_context *trace_ust_create_context(
 		struct lttng_event_context *ctx);
@@ -214,7 +215,8 @@ struct ltt_ust_channel *trace_ust_create_channel(struct lttng_channel *attr)
 }
 static inline
 struct ltt_ust_event *trace_ust_create_event(struct lttng_event *ev,
-		struct lttng_filter_bytecode *filter)
+		struct lttng_filter_bytecode *filter,
+		struct lttng_event_exclusion *exclusion)
 {
 	return NULL;
 }
diff --git a/tests/unit/test_ust_data.c b/tests/unit/test_ust_data.c
index ae8b123..7c48c5c 100644
--- a/tests/unit/test_ust_data.c
+++ b/tests/unit/test_ust_data.c
@@ -151,7 +151,7 @@ static void test_create_ust_event(void)
 	ev.type = LTTNG_EVENT_TRACEPOINT;
 	ev.loglevel_type = LTTNG_EVENT_LOGLEVEL_ALL;
 
-	event = trace_ust_create_event(&ev, NULL);
+	event = trace_ust_create_event(&ev, NULL, NULL);
 
 	ok(event != NULL, "Create UST event");
 
-- 
1.8.1.2
