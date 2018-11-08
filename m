From: Michael Jeanson <mjeanson@efficios.com>
Subject: [RFC PATCH lttng-modules v2 15/30] Drop support for
 kernels < 3.0 from ext4 instrumentation
Date: Thu,  8 Nov 2018 16:45:20 -0500
Message-ID: <20181108214535.12081-15-mjeanson__22601.8324181952$1541713649$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcKg4Gq0zqFG
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:59 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 9170624AE0E
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:45:59 -0500 (EST)
In-Reply-To: <20181108214535.12081-1-mjeanson@efficios.com>
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

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 instrumentation/events/lttng-module/ext4.h | 179 ++-------------------
 1 file changed, 15 insertions(+), 164 deletions(-)

diff --git a/instrumentation/events/lttng-module/ext4.h b/instrumentation/events/lttng-module/ext4.h
index 307021a..b2ca8a7 100644
--- a/instrumentation/events/lttng-module/ext4.h
+++ b/instrumentation/events/lttng-module/ext4.h
@@ -74,7 +74,6 @@ LTTNG_TRACEPOINT_EVENT(ext4_allocate_inode,
 	)
 )
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
 LTTNG_TRACEPOINT_EVENT(ext4_evict_inode,
 	TP_PROTO(struct inode *inode),
 
@@ -122,7 +121,6 @@ LTTNG_TRACEPOINT_EVENT(ext4_begin_ordered_truncate,
 		ctf_integer(loff_t, new_size, new_size)
 	)
 )
-#endif
 
 LTTNG_TRACEPOINT_EVENT_CLASS(ext4__write_begin,
 
@@ -203,20 +201,6 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(ext4__write_end, ext4_da_write_end,
 	TP_ARGS(inode, pos, len, copied)
 )
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,40))
-LTTNG_TRACEPOINT_EVENT(ext4_writepage,
-	TP_PROTO(struct inode *inode, struct page *page),
-
-	TP_ARGS(inode, page),
-
-	TP_FIELDS(
-		ctf_integer(dev_t, dev, inode->i_sb->s_dev)
-		ctf_integer(ino_t, ino, inode->i_ino)
-		ctf_integer(pgoff_t, index, page->index)
-	)
-)
-#endif
-
 LTTNG_TRACEPOINT_EVENT(ext4_da_writepages,
 	TP_PROTO(struct inode *inode, struct writeback_control *wbc),
 
@@ -230,16 +214,8 @@ LTTNG_TRACEPOINT_EVENT(ext4_da_writepages,
 		ctf_integer(loff_t, range_start, wbc->range_start)
 		ctf_integer(loff_t, range_end, wbc->range_end)
 		ctf_integer(pgoff_t, writeback_index, inode->i_mapping->writeback_index)
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
 		ctf_integer(int, sync_mode, wbc->sync_mode)
-#endif
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37))
-		ctf_integer(char, nonblocking, wbc->nonblocking)
-#endif
 		ctf_integer(char, for_kupdate, wbc->for_kupdate)
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39))
-		ctf_integer(char, for_reclaim, wbc->for_reclaim)
-#endif
 		ctf_integer(char, range_cyclic, wbc->range_cyclic)
 	)
 )
@@ -277,9 +253,7 @@ LTTNG_TRACEPOINT_EVENT(ext4_da_write_pages,
 		ctf_integer(unsigned long, first_page, mpd->first_page)
 		ctf_integer(int, io_done, mpd->io_done)
 		ctf_integer(int, pages_written, mpd->pages_written)
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
 		ctf_integer(int, sync_mode, mpd->wbc->sync_mode)
-#endif
 	)
 )
 
@@ -316,22 +290,10 @@ LTTNG_TRACEPOINT_EVENT(ext4_da_writepages_result,
 		ctf_integer(int, pages_written, pages_written)
 		ctf_integer(long, pages_skipped, wbc->pages_skipped)
 		ctf_integer(pgoff_t, writeback_index, inode->i_mapping->writeback_index)
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
 		ctf_integer(int, sync_mode, wbc->sync_mode)
-#endif
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33))
-		ctf_integer(char, encountered_congestion, wbc->encountered_congestion)
-#endif
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0))
-		ctf_integer(char, more_io, wbc->more_io)
-#endif
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35))
-		ctf_integer(char, no_nrwrite_index_update, wbc->no_nrwrite_index_update)
-#endif
 	)
 )
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
 LTTNG_TRACEPOINT_EVENT_CLASS(ext4__page_op,
 	TP_PROTO(struct page *page),
 
@@ -344,14 +306,12 @@ LTTNG_TRACEPOINT_EVENT_CLASS(ext4__page_op,
 	)
 )
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,40))
 LTTNG_TRACEPOINT_EVENT_INSTANCE(ext4__page_op, ext4_writepage,
 
 	TP_PROTO(struct page *page),
 
 	TP_ARGS(page)
 )
-#endif
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(ext4__page_op, ext4_readpage,
 
@@ -413,8 +373,6 @@ LTTNG_TRACEPOINT_EVENT(ext4_invalidatepage,
 
 #endif
 
-#endif
-
 LTTNG_TRACEPOINT_EVENT(ext4_discard_blocks,
 	TP_PROTO(struct super_block *sb, unsigned long long blk,
 			unsigned long long count),
@@ -461,91 +419,46 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(ext4__mb_new_pa, ext4_mb_new_group_pa,
 
 LTTNG_TRACEPOINT_EVENT(ext4_mb_release_inode_pa,
 	TP_PROTO(
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,40))
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
-		 struct super_block *sb,
-		 struct inode *inode,
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
-		 struct super_block *sb,
-		 struct ext4_allocation_context *ac,
-#else
-		 struct ext4_allocation_context *ac,
-#endif
-#endif
 		 struct ext4_prealloc_space *pa,
 		 unsigned long long block, unsigned int count),
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,40))
 	TP_ARGS(pa, block, count),
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
-	TP_ARGS(sb, inode, pa, block, count),
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
-	TP_ARGS(sb, ac, pa, block, count),
-#else
-	TP_ARGS(ac, pa, block, count),
-#endif
 
 	TP_FIELDS(
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,40))
 		ctf_integer(dev_t, dev, pa->pa_inode->i_sb->s_dev)
 		ctf_integer(ino_t, ino, pa->pa_inode->i_ino)
-#else
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
-		ctf_integer(dev_t, dev, sb->s_dev)
-#else
-		ctf_integer(dev_t, dev, ac->ac_sb->s_dev)
-#endif
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
-		ctf_integer(ino_t, ino, inode->i_ino)
-#else
-		ctf_integer(ino_t, ino,
-			(ac && ac->ac_inode) ? ac->ac_inode->i_ino : 0)
-#endif
-#endif
 		ctf_integer(__u64, block, block)
 		ctf_integer(__u32, count, count)
 	)
 )
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
 LTTNG_TRACEPOINT_EVENT(ext4_mb_release_group_pa,
 
-#if (LTTNG_KERNEL_RANGE(2,6,40, 3,3,0))
-	TP_PROTO(struct ext4_prealloc_space *pa),
-
-	TP_ARGS(pa),
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
 	TP_PROTO(struct super_block *sb, struct ext4_prealloc_space *pa),
 
 	TP_ARGS(sb, pa),
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
-	TP_PROTO(struct super_block *sb,
-		 struct ext4_allocation_context *ac,
-		 struct ext4_prealloc_space *pa),
 
-	TP_ARGS(sb, ac, pa),
+	TP_FIELDS(
+		ctf_integer(dev_t, dev, sb->s_dev)
+		ctf_integer(__u64, pa_pstart, pa->pa_pstart)
+		ctf_integer(__u32, pa_len, pa->pa_len)
+	)
+)
 #else
-	TP_PROTO(struct ext4_allocation_context *ac,
-		 struct ext4_prealloc_space *pa),
+LTTNG_TRACEPOINT_EVENT(ext4_mb_release_group_pa,
 
-	TP_ARGS(ac, pa),
-#endif
+	TP_PROTO(struct ext4_prealloc_space *pa),
+
+	TP_ARGS(pa),
 
 	TP_FIELDS(
-#if (LTTNG_KERNEL_RANGE(2,6,40, 3,3,0))
 		ctf_integer(dev_t, dev, pa->pa_inode->i_sb->s_dev)
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
-		ctf_integer(dev_t, dev, sb->s_dev)
-#else
-		ctf_integer(dev_t, dev, ac->ac_sb->s_dev)
-#endif
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37))
-		ctf_integer(ino_t, ino,
-			(ac && ac->ac_inode) ? ac->ac_inode->i_ino : 0)
-#endif
 		ctf_integer(__u64, pa_pstart, pa->pa_pstart)
 		ctf_integer(__u32, pa_len, pa->pa_len)
 	)
 )
+#endif
 
 LTTNG_TRACEPOINT_EVENT(ext4_discard_preallocations,
 	TP_PROTO(struct inode *inode),
@@ -609,62 +522,34 @@ LTTNG_TRACEPOINT_EVENT(ext4_allocate_blocks,
 )
 
 LTTNG_TRACEPOINT_EVENT(ext4_free_blocks,
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
 	TP_PROTO(struct inode *inode, __u64 block, unsigned long count,
 		 int flags),
 
 	TP_ARGS(inode, block, count, flags),
-#else
-	TP_PROTO(struct inode *inode, __u64 block, unsigned long count,
-		 int metadata),
-
-	TP_ARGS(inode, block, count, metadata),
-#endif
 
 	TP_FIELDS(
 		ctf_integer(dev_t, dev, inode->i_sb->s_dev)
 		ctf_integer(ino_t, ino, inode->i_ino)
 		ctf_integer(__u64, block, block)
 		ctf_integer(unsigned long, count, count)
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
 		ctf_integer(int, flags, flags)
 		ctf_integer(TP_MODE_T, mode, inode->i_mode)
-#else
-		ctf_integer(int, metadata, metadata)
-#endif
 	)
 )
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
 LTTNG_TRACEPOINT_EVENT(ext4_sync_file_enter,
-#else
-LTTNG_TRACEPOINT_EVENT(ext4_sync_file,
-#endif
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
 	TP_PROTO(struct file *file, int datasync),
 
 	TP_ARGS(file, datasync),
-#else
-	TP_PROTO(struct file *file, struct dentry *dentry, int datasync),
-
-	TP_ARGS(file, dentry, datasync),
-#endif
 
 	TP_FIELDS(
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
 		ctf_integer(dev_t, dev, file->f_path.dentry->d_inode->i_sb->s_dev)
 		ctf_integer(ino_t, ino, file->f_path.dentry->d_inode->i_ino)
 		ctf_integer(ino_t, parent, file->f_path.dentry->d_parent->d_inode->i_ino)
-#else
-		ctf_integer(dev_t, dev, dentry->d_inode->i_sb->s_dev)
-		ctf_integer(ino_t, ino, dentry->d_inode->i_ino)
-		ctf_integer(ino_t, parent, dentry->d_parent->d_inode->i_ino)
-#endif
 		ctf_integer(int, datasync, datasync)
 	)
 )
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
 LTTNG_TRACEPOINT_EVENT(ext4_sync_file_exit,
 	TP_PROTO(struct inode *inode, int ret),
 
@@ -676,7 +561,6 @@ LTTNG_TRACEPOINT_EVENT(ext4_sync_file_exit,
 		ctf_integer(int, ret, ret)
 	)
 )
-#endif
 
 LTTNG_TRACEPOINT_EVENT(ext4_sync_fs,
 	TP_PROTO(struct super_block *sb, int wait),
@@ -766,7 +650,6 @@ LTTNG_TRACEPOINT_EVENT(ext4_mballoc_prealloc,
 )
 
 LTTNG_TRACEPOINT_EVENT_CLASS(ext4__mballoc,
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
 	TP_PROTO(struct super_block *sb,
 		 struct inode *inode,
 		 ext4_group_t group,
@@ -774,33 +657,18 @@ LTTNG_TRACEPOINT_EVENT_CLASS(ext4__mballoc,
 		 ext4_grpblk_t len),
 
 	TP_ARGS(sb, inode, group, start, len),
-#else
-	TP_PROTO(struct ext4_allocation_context *ac),
-
-	TP_ARGS(ac),
-#endif
 
 	TP_FIELDS(
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
 		ctf_integer(dev_t, dev, sb->s_dev)
 		ctf_integer(ino_t, ino, inode ? inode->i_ino : 0)
 		ctf_integer(int, result_start, start)
 		ctf_integer(__u32, result_group, group)
 		ctf_integer(int, result_len, len)
-#else
-		ctf_integer(dev_t, dev, ac->ac_sb->s_dev)
-		ctf_integer(ino_t, ino, ac->ac_inode ? ac->ac_inode->i_ino : 0)
-		ctf_integer(__u32, result_logical, ac->ac_b_ex.fe_logical)
-		ctf_integer(int, result_start, ac->ac_b_ex.fe_start)
-		ctf_integer(__u32, result_group, ac->ac_b_ex.fe_group)
-		ctf_integer(int, result_len, ac->ac_b_ex.fe_len)
-#endif
 	)
 )
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(ext4__mballoc, ext4_mballoc_discard,
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
 	TP_PROTO(struct super_block *sb,
 		 struct inode *inode,
 		 ext4_group_t group,
@@ -808,16 +676,10 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(ext4__mballoc, ext4_mballoc_discard,
 		 ext4_grpblk_t len),
 
 	TP_ARGS(sb, inode, group, start, len)
-#else
-	TP_PROTO(struct ext4_allocation_context *ac),
-
-	TP_ARGS(ac)
-#endif
 )
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(ext4__mballoc, ext4_mballoc_free,
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
 	TP_PROTO(struct super_block *sb,
 		 struct inode *inode,
 		 ext4_group_t group,
@@ -825,14 +687,8 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(ext4__mballoc, ext4_mballoc_free,
 		 ext4_grpblk_t len),
 
 	TP_ARGS(sb, inode, group, start, len)
-#else
-	TP_PROTO(struct ext4_allocation_context *ac),
-
-	TP_ARGS(ac)
-#endif
 )
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
 LTTNG_TRACEPOINT_EVENT(ext4_forget,
 	TP_PROTO(struct inode *inode, int is_metadata, __u64 block),
 
@@ -846,7 +702,6 @@ LTTNG_TRACEPOINT_EVENT(ext4_forget,
 		ctf_integer(TP_MODE_T, mode, inode->i_mode)
 	)
 )
-#endif
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,13,0))
 LTTNG_TRACEPOINT_EVENT(ext4_da_update_reserve_space,
@@ -886,7 +741,7 @@ LTTNG_TRACEPOINT_EVENT(ext4_da_update_reserve_space,
 		ctf_integer(TP_MODE_T, mode, inode->i_mode)
 	)
 )
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
+#else
 LTTNG_TRACEPOINT_EVENT(ext4_da_update_reserve_space,
 	TP_PROTO(struct inode *inode, int used_blocks),
 
@@ -940,7 +795,7 @@ LTTNG_TRACEPOINT_EVENT(ext4_da_reserve_space,
 		ctf_integer(TP_MODE_T, mode, inode->i_mode)
 	)
 )
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
+#else
 LTTNG_TRACEPOINT_EVENT(ext4_da_reserve_space,
 	TP_PROTO(struct inode *inode, int md_needed),
 
@@ -976,7 +831,7 @@ LTTNG_TRACEPOINT_EVENT(ext4_da_release_space,
 		ctf_integer(TP_MODE_T, mode, inode->i_mode)
 	)
 )
-#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
+#else
 LTTNG_TRACEPOINT_EVENT(ext4_da_release_space,
 	TP_PROTO(struct inode *inode, int freed_blocks),
 
@@ -998,7 +853,6 @@ LTTNG_TRACEPOINT_EVENT(ext4_da_release_space,
 )
 #endif
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
 LTTNG_TRACEPOINT_EVENT_CLASS(ext4__bitmap_load,
 	TP_PROTO(struct super_block *sb, unsigned long group),
 
@@ -1023,9 +877,7 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(ext4__bitmap_load, ext4_mb_buddy_bitmap_load,
 
 	TP_ARGS(sb, group)
 )
-#endif
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
 LTTNG_TRACEPOINT_EVENT_INSTANCE(ext4__bitmap_load, ext4_read_block_bitmap_load,
 
 	TP_PROTO(struct super_block *sb, unsigned long group),
@@ -1402,7 +1254,6 @@ LTTNG_TRACEPOINT_EVENT(ext4_load_inode,
 		ctf_integer(ino_t, ino, inode->i_ino)
 	)
 )
-#endif
 
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
 
-- 
2.17.1
