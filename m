From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 17/28] Add exclusion data to
	find_ust_app_event
Date: Thu,  7 Nov 2013 12:21:41 +0200
Message-ID: <1383819703-6793-8-git-send-email-jp_ikaheimonen__11316.3218055435$1383819914$gmane$org@mentor.com>
References: <1383819703-6793-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMiz-0007WU-PY
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:06 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1VeMiu-0006Dy-Aq from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:22:00 -0800
In-Reply-To: <1383819703-6793-1-git-send-email-jp_ikaheimonen@mentor.com>
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

Add exclusion data to the prototype of find_ust_app_event
and to wherever it is called.

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 src/bin/lttng-sessiond/ust-app.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
index 9f9919e..adb31e8 100644
--- a/src/bin/lttng-sessiond/ust-app.c
+++ b/src/bin/lttng-sessiond/ust-app.c
@@ -1022,7 +1022,8 @@ error:
  * Return an ust_app_event object or NULL on error.
  */
 static struct ust_app_event *find_ust_app_event(struct lttng_ht *ht,
-		char *name, struct lttng_ust_filter_bytecode *filter, int loglevel)
+		char *name, struct lttng_ust_filter_bytecode *filter, int loglevel,
+		const struct lttng_event_exclusion *exclusion)
 {
 	struct lttng_ht_iter iter;
 	struct lttng_ht_node_str *node;
@@ -1036,6 +1037,8 @@ static struct ust_app_event *find_ust_app_event(struct lttng_ht *ht,
 	key.name = name;
 	key.filter = filter;
 	key.loglevel = loglevel;
+	/* lttng_event_exclusion and lttng_ust_event_exclusion structures are similar */
+	key.exclusion = (struct lttng_ust_event_exclusion *)exclusion;
 
 	/* Lookup using the event name as hash and a custom match fct. */
 	cds_lfht_lookup(ht->ht, ht->hash_fct((void *) name, lttng_ht_seed),
@@ -1471,7 +1474,7 @@ static void shadow_copy_channel(struct ust_app_channel *ua_chan,
 	/* Copy all events from ltt ust channel to ust app channel */
 	cds_lfht_for_each_entry(uchan->events->ht, &iter.iter, uevent, node.node) {
 		ua_event = find_ust_app_event(ua_chan->events, uevent->attr.name,
-				uevent->filter, uevent->attr.loglevel);
+				uevent->filter, uevent->attr.loglevel, uevent->exclusion);
 		if (ua_event == NULL) {
 			DBG2("UST event %s not found on shadow copy channel",
 					uevent->attr.name);
@@ -2584,7 +2587,7 @@ int create_ust_app_event(struct ust_app_session *ua_sess,
 
 	/* Get event node */
 	ua_event = find_ust_app_event(ua_chan->events, uevent->attr.name,
-			uevent->filter, uevent->attr.loglevel);
+			uevent->filter, uevent->attr.loglevel, uevent->exclusion);
 	if (ua_event != NULL) {
 		ret = -EEXIST;
 		goto end;
@@ -3642,7 +3645,7 @@ int ust_app_enable_event_glb(struct ltt_ust_session *usess,
 
 		/* Get event node */
 		ua_event = find_ust_app_event(ua_chan->events, uevent->attr.name,
-				uevent->filter, uevent->attr.loglevel);
+				uevent->filter, uevent->attr.loglevel, uevent->exclusion);
 		if (ua_event == NULL) {
 			DBG3("UST app enable event %s not found for app PID %d."
 					"Skipping app", uevent->attr.name, app->pid);
@@ -4368,7 +4371,7 @@ int ust_app_enable_event_pid(struct ltt_ust_session *usess,
 	ua_chan = caa_container_of(ua_chan_node, struct ust_app_channel, node);
 
 	ua_event = find_ust_app_event(ua_chan->events, uevent->attr.name,
-			uevent->filter, uevent->attr.loglevel);
+			uevent->filter, uevent->attr.loglevel, uevent->exclusion);
 	if (ua_event == NULL) {
 		ret = create_ust_app_event(ua_sess, ua_chan, uevent, app);
 		if (ret < 0) {
-- 
1.8.1.2
