From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH babeltrace-1.5 2/6] Fix: trace-collection: trace
 clock use after free
Date: Thu,  5 Dec 2019 01:58:05 -0500
Message-ID: <20191205065809.16728-3-mathieu.desnoyers__29936.840238382$1575529207$gmane$org@efficios.com>
References: <20191205065809.16728-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 47T64Q5v23z10hG
 for <lttng-dev@lists.lttng.org>; Thu,  5 Dec 2019 01:58:14 -0500 (EST)
In-Reply-To: <20191205065809.16728-1-mathieu.desnoyers@efficios.com>
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

The trace collection should copy the trace clock object rather
than take a reference to the first trace's trace clock, because
it may be freed when the trace is removed (e.g. application going
away in per-pid live tracing).

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 lib/trace-collection.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/lib/trace-collection.c b/lib/trace-collection.c
index 035d2dc2..8e4a1432 100644
--- a/lib/trace-collection.c
+++ b/lib/trace-collection.c
@@ -76,7 +76,7 @@ static void clock_add(gpointer key, gpointer value, gpointer user_data)
 {
 	struct clock_match *clock_match = user_data;
 	GHashTable *tc_clocks = clock_match->clocks;
-	struct ctf_clock *t_clock = value;
+	struct ctf_clock *t_clock = value, *clock_copy;
 	GQuark v;
 
 	if (t_clock->absolute)
@@ -104,9 +104,14 @@ static void clock_add(gpointer key, gpointer value, gpointer user_data)
 				clock_match->tc->single_clock_offset_avg =
 					clock_match->tc->offset_first;
 			}
+			clock_copy = g_new0(struct ctf_clock, 1);
+			*clock_copy = *t_clock;
+			if (t_clock->description) {
+				clock_copy->description = g_strdup(t_clock->description);
+			}
 			g_hash_table_insert(tc_clocks,
 				(gpointer) (unsigned long) v,
-				value);
+				clock_copy);
 		} else if (!t_clock->absolute) {
 			int64_t diff_ns;
 
@@ -209,11 +214,21 @@ int bt_trace_collection_remove(struct trace_collection *tc,
 
 }
 
+static
+void clock_free(gpointer data)
+{
+	struct ctf_clock *clock = data;
+
+	g_free(clock->description);
+	g_free(clock);
+}
+
 void bt_init_trace_collection(struct trace_collection *tc)
 {
 	assert(tc);
 	tc->array = g_ptr_array_new();
-	tc->clocks = g_hash_table_new(g_direct_hash, g_direct_equal);
+	tc->clocks = g_hash_table_new_full(g_direct_hash, g_direct_equal,
+			NULL, clock_free);
 	tc->single_clock_offset_avg = 0;
 	tc->offset_first = 0;
 	tc->delta_offset_first_sum = 0;
-- 
2.17.1
