From: Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: [PATCH v3] mm: Rename mm_vmscan_lru_shrink_inactive trace event
 variables
Date: Thu, 23 May 2019 19:13:10 +0300
Message-ID: <8d4cd39d-6bca-4161-7134-ac05ffa590b3@virtuozzo.com>
References: <155851455676.7870.1951762540769724271.stgit@localhost.localdomain>
 <9b9a8da4-556a-8972-cf87-071ce5099ad0@virtuozzo.com>
 <a187c72c-9ca2-7668-fc60-e9c310c30d5c@gydle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a187c72c-9ca2-7668-fc60-e9c310c30d5c@gydle.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastien Boisvert <sboisvert@gydle.com>, akpm@linux-foundation.org, mjeanson@efficios.com, rostedt@goodmis.org, lttng-dev@lists.lttng.org, linux-kernel@vger.kernel.org
List-Id: lttng-dev@lists.lttng.org

Rename nr_activate{0,1} into nr_activate_{anon,file} since this
is exported into userspace, e.g., it's shown here:

/sys/kernel/debug/tracing/events/vmscan/mm_vmscan_lru_shrink_inactive/format

v3: Fix comment
v2: Changed suggested person

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/trace/events/vmscan.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index a5ab2973e8dc..c316279715f4 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -348,8 +348,8 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		__field(unsigned long, nr_writeback)
 		__field(unsigned long, nr_congested)
 		__field(unsigned long, nr_immediate)
-		__field(unsigned int, nr_activate0)
-		__field(unsigned int, nr_activate1)
+		__field(unsigned int, nr_activate_anon)
+		__field(unsigned int, nr_activate_file)
 		__field(unsigned long, nr_ref_keep)
 		__field(unsigned long, nr_unmap_fail)
 		__field(int, priority)
@@ -364,8 +364,8 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		__entry->nr_writeback = stat->nr_writeback;
 		__entry->nr_congested = stat->nr_congested;
 		__entry->nr_immediate = stat->nr_immediate;
-		__entry->nr_activate0 = stat->nr_activate[0];
-		__entry->nr_activate1 = stat->nr_activate[1];
+		__entry->nr_activate_anon = stat->nr_activate[0];
+		__entry->nr_activate_file = stat->nr_activate[1];
 		__entry->nr_ref_keep = stat->nr_ref_keep;
 		__entry->nr_unmap_fail = stat->nr_unmap_fail;
 		__entry->priority = priority;
@@ -377,7 +377,7 @@ TRACE_EVENT(mm_vmscan_lru_shrink_inactive,
 		__entry->nr_scanned, __entry->nr_reclaimed,
 		__entry->nr_dirty, __entry->nr_writeback,
 		__entry->nr_congested, __entry->nr_immediate,
-		__entry->nr_activate0, __entry->nr_activate1,
+		__entry->nr_activate_anon, __entry->nr_activate_file,
 		__entry->nr_ref_keep, __entry->nr_unmap_fail,
 		__entry->priority,
 		show_reclaim_flags(__entry->reclaim_flags))
