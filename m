From: David Goulet <dgoulet@ev0ke.net>
Subject: [PATCH lttng-modules] Fix: missing event's prefix in
	btrfs probe
Date: Fri, 25 Jan 2013 14:49:31 -0500
Message-ID: <1359143371-1953-1-git-send-email-dgoulet__45761.7260086865$1359143436$gmane$org@ev0ke.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@ev0ke.net>) id 1TypHS-0002jK-H9
	for lttng-dev@lists.lttng.org; Fri, 25 Jan 2013 14:49:42 -0500
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

From: David Goulet <dgoulet@efficios.com>

Signed-off-by: David Goulet <dgoulet@efficios.com>
---
 instrumentation/events/lttng-module/btrfs.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/instrumentation/events/lttng-module/btrfs.h b/instrumentation/events/lttng-module/btrfs.h
index c01a6e0..34ae480 100644
--- a/instrumentation/events/lttng-module/btrfs.h
+++ b/instrumentation/events/lttng-module/btrfs.h
@@ -390,7 +390,7 @@ DECLARE_EVENT_CLASS(btrfs__writepage,
 #endif
 )
 
-DEFINE_EVENT(btrfs__writepage, __extent_writepage,
+DEFINE_EVENT(btrfs__writepage, btrfs_extent_writepage,
 
 	TP_PROTO(struct page *page, struct inode *inode,
 		 struct writeback_control *wbc),
@@ -792,7 +792,7 @@ DEFINE_EVENT(btrfs__reserved_extent,  btrfs_reserved_extent_free,
 )
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
-TRACE_EVENT(find_free_extent,
+TRACE_EVENT(btrfs_find_free_extent,
 
 	TP_PROTO(struct btrfs_root *root, u64 num_bytes, u64 empty_size,
 		 u64 data),
@@ -956,7 +956,7 @@ TRACE_EVENT(btrfs_setup_cluster,
 #endif
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
-TRACE_EVENT(alloc_extent_state,
+TRACE_EVENT(btrfs_alloc_extent_state,
 
 	TP_PROTO(struct extent_state *state, gfp_t mask, unsigned long IP),
 
@@ -978,7 +978,7 @@ TRACE_EVENT(alloc_extent_state,
 		  show_gfp_flags(__entry->mask), (void *)__entry->ip)
 )
 
-TRACE_EVENT(free_extent_state,
+TRACE_EVENT(btrfs_free_extent_state,
 
 	TP_PROTO(struct extent_state *state, unsigned long IP),
 
-- 
1.7.10.4
