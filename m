From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: [PATCH lttng-modules] Fix compilation of ext4 and btrfs
	tracepoints on 2.6.40 kernels
Date: Thu, 10 Jan 2013 17:24:08 -0500
Message-ID: <1357856648-32362-1-git-send-email-simon.marchi__38410.5988698595$1357856698$gmane$org@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simon.marchi@polymtl.ca>) id 1TtQXo-0000IS-GJ
	for lttng-dev@lists.lttng.org; Thu, 10 Jan 2013 17:24:16 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Simon Marchi <simon.marchi@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

See f95480cf62e9acb42b74fce162544694b76c9704.

The new btrfs and ext4 tracepoints used 3.0.0 in the compilation logic.

Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
---
 instrumentation/events/lttng-module/btrfs.h |    4 ++--
 instrumentation/events/lttng-module/ext4.h  |   14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/instrumentation/events/lttng-module/btrfs.h b/instrumentation/events/lttng-module/btrfs.h
index b0ff3c6..c01a6e0 100644
--- a/instrumentation/events/lttng-module/btrfs.h
+++ b/instrumentation/events/lttng-module/btrfs.h
@@ -39,7 +39,7 @@ struct extent_state;
 		{ BTRFS_SHARED_BLOCK_REF_KEY, 	"SHARED_BLOCK_REF" },	\
 		{ BTRFS_SHARED_DATA_REF_KEY, 	"SHARED_DATA_REF" })
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,40))
 #define __show_root_type(obj)						\
 	__print_symbolic_u64(obj,					\
 		{ BTRFS_ROOT_TREE_OBJECTID, 	"ROOT_TREE"	},	\
@@ -166,7 +166,7 @@ DEFINE_EVENT(btrfs__inode, btrfs_inode_evict,
 	TP_ARGS(inode)
 )
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,40))
 #define __show_map_type(type)						\
 	__print_symbolic_u64(type,					\
 		{ EXTENT_MAP_LAST_BYTE, "LAST_BYTE" 	},		\
diff --git a/instrumentation/events/lttng-module/ext4.h b/instrumentation/events/lttng-module/ext4.h
index 661a5a9..4bc4285 100644
--- a/instrumentation/events/lttng-module/ext4.h
+++ b/instrumentation/events/lttng-module/ext4.h
@@ -305,7 +305,7 @@ DEFINE_EVENT(ext4__write_end, ext4_da_write_end,
 	TP_ARGS(inode, pos, len, copied)
 )
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0))
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,40))
 TRACE_EVENT(ext4_writepage,
 	TP_PROTO(struct inode *inode, struct page *page),
 
@@ -581,7 +581,7 @@ DECLARE_EVENT_CLASS(ext4__page_op,
 		  (unsigned long) __entry->index)
 )
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,40))
 DEFINE_EVENT(ext4__page_op, ext4_writepage,
 
 	TP_PROTO(struct page *page),
@@ -702,7 +702,7 @@ DEFINE_EVENT(ext4__mb_new_pa, ext4_mb_new_group_pa,
 
 TRACE_EVENT(ext4_mb_release_inode_pa,
 	TP_PROTO(
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0))
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,40))
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
 		 struct super_block *sb,
 		 struct inode *inode,
@@ -716,7 +716,7 @@ TRACE_EVENT(ext4_mb_release_inode_pa,
 		 struct ext4_prealloc_space *pa,
 		 unsigned long long block, unsigned int count),
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,40))
 	TP_ARGS(pa, block, count),
 #elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
 	TP_ARGS(sb, inode, pa, block, count),
@@ -735,7 +735,7 @@ TRACE_EVENT(ext4_mb_release_inode_pa,
 	),
 
 	TP_fast_assign(
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,40))
 		tp_assign(dev, pa->pa_inode->i_sb->s_dev)
 		tp_assign(ino, pa->pa_inode->i_ino)
 #else
@@ -762,7 +762,7 @@ TRACE_EVENT(ext4_mb_release_inode_pa,
 
 TRACE_EVENT(ext4_mb_release_group_pa,
 
-#if (LTTNG_KERNEL_RANGE(3,0,0, 3,3,0))
+#if (LTTNG_KERNEL_RANGE(2,6,40, 3,3,0))
 	TP_PROTO(struct ext4_prealloc_space *pa),
 
 	TP_ARGS(pa),
@@ -794,7 +794,7 @@ TRACE_EVENT(ext4_mb_release_group_pa,
 	),
 
 	TP_fast_assign(
-#if (LTTNG_KERNEL_RANGE(3,0,0, 3,3,0))
+#if (LTTNG_KERNEL_RANGE(2,6,40, 3,3,0))
 		tp_assign(dev, pa->pa_inode->i_sb->s_dev)
 #elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
 		tp_assign(dev, sb->s_dev)
-- 
1.7.1
