From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH] API cleanup name get_timestamp and
	get_cycles
Date: Tue,  7 Aug 2012 11:15:49 -0400
Message-ID: <1344352549-32224-1-git-send-email-jdesfossez__30300.349641084$1344352597$gmane$org@efficios.com>
References: <20120805174635.GA22981@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1SylVv-0006G1-66
	for lttng-dev@lists.lttng.org; Tue, 07 Aug 2012 11:16:07 -0400
In-Reply-To: <20120805174635.GA22981@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com, yannick.brosseau@gmail.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Rename bt_ctf_get_cycles_timestamp to bt_ctf_get_cycles,
and bt_ctf_get_real_timestamp to bt_ctf_get_timestamp.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 formats/ctf/events.c            |    4 ++--
 include/babeltrace/ctf/events.h |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/formats/ctf/events.c b/formats/ctf/events.c
index 06419a1..9693413 100644
--- a/formats/ctf/events.c
+++ b/formats/ctf/events.c
@@ -281,7 +281,7 @@ int bt_ctf_event_get_handle_id(const struct bt_ctf_event *ctf_event)
 	return ret;
 }
 
-uint64_t bt_ctf_get_real_timestamp(const struct bt_ctf_event *ctf_event)
+uint64_t bt_ctf_get_timestamp(const struct bt_ctf_event *ctf_event)
 {
 	struct ctf_event_definition *event = ctf_event->parent;
 	if (event && event->stream->has_timestamp)
@@ -290,7 +290,7 @@ uint64_t bt_ctf_get_real_timestamp(const struct bt_ctf_event *ctf_event)
 		return -1ULL;
 }
 
-uint64_t bt_ctf_get_cycles_timestamp(const struct bt_ctf_event *ctf_event)
+uint64_t bt_ctf_get_cycles(const struct bt_ctf_event *ctf_event)
 {
 	struct ctf_event_definition *event = ctf_event->parent;
 	if (event && event->stream->has_timestamp)
diff --git a/include/babeltrace/ctf/events.h b/include/babeltrace/ctf/events.h
index 419c4c8..4232feb 100644
--- a/include/babeltrace/ctf/events.h
+++ b/include/babeltrace/ctf/events.h
@@ -90,16 +90,16 @@ const struct definition *bt_ctf_get_top_level_scope(const struct bt_ctf_event *e
 const char *bt_ctf_event_name(const struct bt_ctf_event *event);
 
 /*
- * bt_ctf_get_cycles_timestamp: returns the timestamp of the event as written
+ * bt_ctf_get_cycles: returns the timestamp of the event as written
  * in the packet (in cycles) or -1ULL on error.
  */
-uint64_t bt_ctf_get_cycles_timestamp(const struct bt_ctf_event *event);
+uint64_t bt_ctf_get_cycles(const struct bt_ctf_event *event);
 
 /*
- * bt_ctf_get_real_timestamp: returns the timestamp of the event offsetted
+ * bt_ctf_get_timestamp: returns the timestamp of the event offsetted
  * with the system clock source (in ns) or -1ULL on error
  */
-uint64_t bt_ctf_get_real_timestamp(const struct bt_ctf_event *event);
+uint64_t bt_ctf_get_timestamp(const struct bt_ctf_event *event);
 
 /*
  * bt_ctf_get_field_list: set list pointer to an array of definition
-- 
1.7.10.4
