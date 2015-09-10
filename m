From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools 1/3] Bring back
	event_ust_disable_all_tracepoints
Date: Thu, 10 Sep 2015 16:10:55 -0400
Message-ID: <1441915857-1544-1-git-send-email-jonathan.rajotte-julien__3798.00849264047$1441915943$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.rajotte-julien@efficios.com>)
 id 1Za8Bo-0006zm-Gs
 for lttng-dev@lists.lttng.org; Thu, 10 Sep 2015 16:11:27 -0400
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

Revert part of be42c96885c522f857f146fa6f7ae53856e3bed2

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng-sessiond/event.c | 54 ++++++++++++++++++++++++++++++++++++++++++
 src/bin/lttng-sessiond/event.h |  3 +++
 2 files changed, 57 insertions(+)

diff --git a/src/bin/lttng-sessiond/event.c b/src/bin/lttng-sessiond/event.c
index 8cca213..b5087a2 100644
--- a/src/bin/lttng-sessiond/event.c
+++ b/src/bin/lttng-sessiond/event.c
@@ -354,6 +354,60 @@ error:
 }
 
 /*
+ * Disable all UST tracepoints for a channel from a UST session.
+ */
+int event_ust_disable_all_tracepoints(struct ltt_ust_session *usess,
+		struct ltt_ust_channel *uchan)
+{
+	int ret, i, size;
+	struct lttng_ht_iter iter;
+	struct ltt_ust_event *uevent = NULL;
+	struct lttng_event *events = NULL;
+
+	assert(usess);
+	assert(uchan);
+
+	rcu_read_lock();
+
+	/* Disabling existing events */
+	cds_lfht_for_each_entry(uchan->events->ht, &iter.iter, uevent,
+			node.node) {
+		if (uevent->enabled == 1) {
+			ret = event_ust_disable_tracepoint(usess, uchan,
+					uevent->attr.name);
+			if (ret < 0) {
+				continue;
+			}
+		}
+	}
+
+	/* Get all UST available events */
+	size = ust_app_list_events(&events);
+	if (size < 0) {
+		ret = LTTNG_ERR_UST_LIST_FAIL;
+		goto error;
+	}
+
+	for (i = 0; i < size; i++) {
+		ret = event_ust_disable_tracepoint(usess, uchan,
+				events[i].name);
+		if (ret != LTTNG_OK) {
+			/* Continue to disable the rest... */
+			continue;
+		}
+	}
+	free(events);
+
+	rcu_read_unlock();
+	return LTTNG_OK;
+
+error:
+	free(events);
+	rcu_read_unlock();
+	return ret;
+}
+
+/*
  * Enable all agent event for a given UST session.
  *
  * Return LTTNG_OK on success or else a LTTNG_ERR* code.
diff --git a/src/bin/lttng-sessiond/event.h b/src/bin/lttng-sessiond/event.h
index 2cf0d5e..7c5231d 100644
--- a/src/bin/lttng-sessiond/event.h
+++ b/src/bin/lttng-sessiond/event.h
@@ -41,6 +41,9 @@ int event_ust_enable_tracepoint(struct ltt_ust_session *usess,
 int event_ust_disable_tracepoint(struct ltt_ust_session *usess,
 		struct ltt_ust_channel *uchan, char *event_name);
 
+int event_ust_disable_all_tracepoints(struct ltt_ust_session *usess,
+		struct ltt_ust_channel *uchan);
+
 int event_agent_enable(struct ltt_ust_session *usess, struct agent *agt,
 		struct lttng_event *event, struct lttng_filter_bytecode *filter,
 		char *filter_expression);
-- 
2.1.4
