From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 4/5] fix: mm: move recent_rotated
 pages calculation to shrink_inactive_list() (v5.2)
Date: Tue, 21 May 2019 16:33:13 -0400
Message-ID: <20190521203314.8577-4-mjeanson__10172.9211093456$1558470929$gmane$org@efficios.com>
References: <20190521203314.8577-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 457nXZ38txz10Wx
 for <lttng-dev@lists.lttng.org>; Tue, 21 May 2019 16:33:34 -0400 (EDT)
In-Reply-To: <20190521203314.8577-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

See upstream commit:

  commit 886cf1901db962cee5f8b82b9b260079a5e8a4eb
  Author: Kirill Tkhai <ktkhai@virtuozzo.com>
  Date:   Mon May 13 17:16:51 2019 -0700

    mm: move recent_rotated pages calculation to shrink_inactive_list()

    Patch series "mm: Generalize putback functions"]

    putback_inactive_pages() and move_active_pages_to_lru() are almost
    similar, so this patchset merges them ina single function.

    This patch (of 4):

    The patch moves the calculation from putback_inactive_pages() to
    shrink_inactive_list().  This makes putback_inactive_pages() looking more
    similar to move_active_pages_to_lru().

    To do that, we account activated pages in reclaim_stat::nr_activate.
    Since a page may change its LRU type from anon to file cache inside
    shrink_page_list() (see ClearPageSwapBacked()), we have to account pages
    for the both types.  So, nr_activate becomes an array.

    Previously we used nr_activate to account PGACTIVATE events, but now we
    account them into pgactivate variable (since they are about number of
    pages in general, not about sum of hpage_nr_pages).

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 instrumentation/events/lttng-module/mm_vmscan.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/instrumentation/events/lttng-module/mm_vmscan.h b/instrumentation/events/lttng-module/mm_vmscan.h
index 417472c..3f9ffde 100644
--- a/instrumentation/events/lttng-module/mm_vmscan.h
+++ b/instrumentation/events/lttng-module/mm_vmscan.h
@@ -625,7 +625,8 @@ LTTNG_TRACEPOINT_EVENT(mm_vmscan_lru_shrink_inactive,
 		ctf_integer(unsigned long, nr_writeback, stat->nr_writeback)
 		ctf_integer(unsigned long, nr_congested, stat->nr_congested)
 		ctf_integer(unsigned long, nr_immediate, stat->nr_immediate)
-		ctf_integer(unsigned long, nr_activate, stat->nr_activate)
+		ctf_integer(unsigned long, nr_activate0, stat->nr_activate[0])
+		ctf_integer(unsigned long, nr_activate1, stat->nr_activate[1])
 		ctf_integer(unsigned long, nr_ref_keep, stat->nr_ref_keep)
 		ctf_integer(unsigned long, nr_unmap_fail, stat->nr_unmap_fail)
 		ctf_integer(int, priority, priority)
-- 
2.17.1
