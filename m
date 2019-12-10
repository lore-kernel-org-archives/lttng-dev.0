From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] fix: btrfs block group struct
 refactor (v5.5)
Date: Tue, 10 Dec 2019 11:41:13 -0500
Message-ID: <20191210164114.26954-4-mjeanson__47061.7996923224$1575996267$gmane$org@efficios.com>
References: <20191210164114.26954-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 47XQnR0WF5z156Z
 for <lttng-dev@lists.lttng.org>; Tue, 10 Dec 2019 11:41:47 -0500 (EST)
In-Reply-To: <20191210164114.26954-1-mjeanson@efficios.com>
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

See upstream commits:

  commit 32da5386d9a4fd5c1155cecf703df104d918954c
  Author: David Sterba <dsterba@suse.com>
  Date:   Tue Oct 29 19:20:18 2019 +0100

    btrfs: rename btrfs_block_group_cache

    The type name is misleading, a single entry is named 'cache' while this
    normally means a collection of objects. Rename that everywhere. Also the
    identifier was quite long, making function prototypes harder to format.

  commit b3470b5dbe1300dea94191ae4b7d070be9a5cdc9
  Author: David Sterba <dsterba@suse.com>
  Date:   Wed Oct 23 18:48:22 2019 +0200

    btrfs: add dedicated members for start and length of a block group

    The on-disk format of block group item makes use of the key that stores
    the offset and length. This is further used in the code, although this
    makes thing harder to understand. The key is also packed so the
    offset/length is not properly aligned as u64.

    Add start (key.objectid) and length (key.offset) members to block group
    and remove the embedded key.  When the item is searched or written, a
    local variable for key is used.

  commit bf38be65f3703d5ef3661c0a2802bc28e76b8f19
  Author: David Sterba <dsterba@suse.com>
  Date:   Wed Oct 23 18:48:11 2019 +0200

    btrfs: move block_group_item::used to block group

    For unknown reasons, the member 'used' in the block group struct is
    stored in the b-tree item and accessed everywhere using the special
    accessor helper. Let's unify it and make it a regular member and only
    update the item before writing it to the tree.

    The item is still being used for flags and chunk_objectid, there's some
    duplication until the item is removed in following patches.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 instrumentation/events/lttng-module/btrfs.h | 125 +++++++++++++++++++-
 1 file changed, 121 insertions(+), 4 deletions(-)

diff --git a/instrumentation/events/lttng-module/btrfs.h b/instrumentation/events/lttng-module/btrfs.h
index 59b668c..b4f2fe7 100644
--- a/instrumentation/events/lttng-module/btrfs.h
+++ b/instrumentation/events/lttng-module/btrfs.h
@@ -20,8 +20,12 @@ struct btrfs_delayed_ref_node;
 struct btrfs_delayed_tree_ref;
 struct btrfs_delayed_data_ref;
 struct btrfs_delayed_ref_head;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,5,0))
+struct btrfs_block_group;
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
 struct btrfs_block_group_cache;
+#endif
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
 struct btrfs_free_cluster;
 #endif
 struct map_lookup;
@@ -679,7 +683,25 @@ LTTNG_TRACEPOINT_EVENT(btrfs_sync_fs,
 )
 #endif
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0) || \
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,5,0))
+LTTNG_TRACEPOINT_EVENT(btrfs_add_block_group,
+
+	TP_PROTO(const struct btrfs_fs_info *fs_info,
+		 const struct btrfs_block_group *block_group, int create),
+
+	TP_ARGS(fs_info, block_group, create),
+
+	TP_FIELDS(
+		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
+		ctf_integer(u64, offset, block_group->start)
+		ctf_integer(u64, size, block_group->length)
+		ctf_integer(u64, flags, block_group->flags)
+		ctf_integer(u64, bytes_used, block_group->used)
+		ctf_integer(u64, bytes_super, block_group->bytes_super)
+		ctf_integer(int, create, create)
+	)
+)
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0) || \
 	LTTNG_SLE_KERNEL_RANGE(4,4,73,5,0,0, 4,4,73,6,0,0) || \
 	LTTNG_SLE_KERNEL_RANGE(4,4,82,6,0,0, 4,4,82,7,0,0) || \
 	LTTNG_SLE_KERNEL_RANGE(4,4,92,6,0,0, 4,4,92,7,0,0) || \
@@ -1812,7 +1834,57 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__reserved_extent,  btrfs_reserved_extent_f
 
 #endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,10,0)) */
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,18,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,5,0))
+LTTNG_TRACEPOINT_EVENT_MAP(find_free_extent,
+
+	btrfs_find_free_extent,
+
+	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 num_bytes, u64 empty_size,
+		 u64 data),
+
+	TP_ARGS(fs_info, num_bytes, empty_size, data),
+
+	TP_FIELDS(
+		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
+		ctf_integer(u64, num_bytes, num_bytes)
+		ctf_integer(u64, empty_size, empty_size)
+		ctf_integer(u64, data, data)
+	)
+)
+
+LTTNG_TRACEPOINT_EVENT_CLASS(btrfs__reserve_extent,
+
+	TP_PROTO(const struct btrfs_block_group *block_group, u64 start,
+		 u64 len),
+
+	TP_ARGS(block_group, start, len),
+
+	TP_FIELDS(
+		ctf_array(u8, fsid, block_group->lttng_fs_info_fsid, BTRFS_UUID_SIZE)
+		ctf_integer(u64, bg_objectid, block_group->start)
+		ctf_integer(u64, flags, block_group->flags)
+		ctf_integer(u64, start, start)
+		ctf_integer(u64, len, len)
+	)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__reserve_extent, btrfs_reserve_extent,
+
+	TP_PROTO(const struct btrfs_block_group *block_group, u64 start,
+		 u64 len),
+
+	TP_ARGS(block_group, start, len)
+)
+
+LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__reserve_extent, btrfs_reserve_extent_cluster,
+
+	TP_PROTO(const struct btrfs_block_group *block_group, u64 start,
+		 u64 len),
+
+	TP_ARGS(block_group, start, len)
+)
+
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4,18,0))
 LTTNG_TRACEPOINT_EVENT_MAP(find_free_extent,
 
 	btrfs_find_free_extent,
@@ -2080,7 +2152,52 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__reserve_extent, btrfs_reserve_extent_clus
 
 #endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,10,0)) */
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0) || \
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,5,0))
+LTTNG_TRACEPOINT_EVENT(btrfs_find_cluster,
+
+	TP_PROTO(const struct btrfs_block_group *block_group, u64 start,
+		 u64 bytes, u64 empty_size, u64 min_bytes),
+
+	TP_ARGS(block_group, start, bytes, empty_size, min_bytes),
+
+	TP_FIELDS(
+		ctf_integer(u64, bg_objectid, block_group->start)
+		ctf_integer(u64, flags, block_group->flags)
+		ctf_integer(u64, start, start)
+		ctf_integer(u64, bytes, bytes)
+		ctf_integer(u64, empty_size, empty_size)
+		ctf_integer(u64, min_bytes, min_bytes)
+	)
+)
+
+LTTNG_TRACEPOINT_EVENT(btrfs_failed_cluster_setup,
+
+	TP_PROTO(const struct btrfs_block_group *block_group),
+
+	TP_ARGS(block_group),
+
+	TP_FIELDS(
+		ctf_integer(u64, bg_objectid, block_group->start)
+	)
+)
+
+LTTNG_TRACEPOINT_EVENT(btrfs_setup_cluster,
+
+	TP_PROTO(const struct btrfs_block_group *block_group,
+		 const struct btrfs_free_cluster *cluster, u64 size, int bitmap),
+
+	TP_ARGS(block_group, cluster, size, bitmap),
+
+	TP_FIELDS(
+		ctf_integer(u64, bg_objectid, block_group->start)
+		ctf_integer(u64, flags, block_group->flags)
+		ctf_integer(u64, start, cluster->window_start)
+		ctf_integer(u64, max_size, cluster->max_size)
+		ctf_integer(u64, size, size)
+		ctf_integer(int, bitmap, bitmap)
+	)
+)
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0) || \
 	LTTNG_SLE_KERNEL_RANGE(4,4,73,5,0,0, 4,4,73,6,0,0) || \
 	LTTNG_SLE_KERNEL_RANGE(4,4,82,6,0,0, 4,4,82,7,0,0) || \
 	LTTNG_SLE_KERNEL_RANGE(4,4,92,6,0,0, 4,4,92,7,0,0) || \
-- 
2.17.1
