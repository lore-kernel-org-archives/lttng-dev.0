From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 4/4] Fix: btrfs: Remove
 fsid/metadata_fsid fields from btrfs_info
Date: Wed,  9 Jan 2019 14:59:18 -0500
Message-ID: <20190109195918.31730-4-mjeanson__23208.0671391033$1547063900$gmane$org@efficios.com>
References: <20190109195918.31730-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43Zg2G1WL2z16pG
 for <lttng-dev@lists.lttng.org>; Wed,  9 Jan 2019 14:59:34 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 3D33CA2499
 for <lttng-dev@lists.lttng.org>; Wed,  9 Jan 2019 14:59:27 -0500 (EST)
In-Reply-To: <20190109195918.31730-1-mjeanson@efficios.com>
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

Introduced in v5.0.

See upstream commit :

  commit de37aa513105f864d3c21105bf5542d498f21ca2
  Author: Nikolay Borisov <nborisov@suse.com>
  Date:   Tue Oct 30 16:43:24 2018 +0200

    btrfs: Remove fsid/metadata_fsid fields from btrfs_info

    Currently btrfs_fs_info structure contains a copy of the
    fsid/metadata_uuid fields. Same values are also contained in the
    btrfs_fs_devices structure which fs_info has a reference to. Let's
    reduce duplication by removing the fields from fs_info and always refer
    to the ones in fs_devices. No functional changes.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 instrumentation/events/lttng-module/btrfs.h | 110 +++++++++++---------
 1 file changed, 58 insertions(+), 52 deletions(-)

diff --git a/instrumentation/events/lttng-module/btrfs.h b/instrumentation/events/lttng-module/btrfs.h
index 6d3d055..c548cf2 100644
--- a/instrumentation/events/lttng-module/btrfs.h
+++ b/instrumentation/events/lttng-module/btrfs.h
@@ -33,6 +33,12 @@ struct extent_state;
 
 #define BTRFS_UUID_SIZE 16
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,0,0))
+#define lttng_fs_info_fsid fs_info->fs_devices->fsid
+#else
+#define lttng_fs_info_fsid fs_info->fsid
+#endif
+
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0) || \
 	LTTNG_SLE_KERNEL_RANGE(4,4,73,5,0,0, 4,4,73,6,0,0) || \
 	LTTNG_SLE_KERNEL_RANGE(4,4,82,6,0,0, 4,4,82,7,0,0) || \
@@ -290,7 +296,7 @@ LTTNG_TRACEPOINT_EVENT(btrfs_handle_em_exist,
 	TP_ARGS(fs_info, existing, map, start, len),
 
 	TP_FIELDS(
-		ctf_array(u8, fsid, fs_info->fsid, BTRFS_UUID_SIZE)
+		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
 		ctf_integer(u64, e_start, existing->start)
 		ctf_integer(u64, e_len, existing->len)
 		ctf_integer(u64, map_start, map->start)
@@ -667,7 +673,7 @@ LTTNG_TRACEPOINT_EVENT(btrfs_add_block_group,
 	TP_ARGS(fs_info, block_group, create),
 
 	TP_FIELDS(
-		ctf_array(u8, fsid, fs_info->fsid, BTRFS_UUID_SIZE)
+		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
 		ctf_integer(u64, offset, block_group->key.objectid)
 		ctf_integer(u64, size, block_group->key.offset)
 		ctf_integer(u64, flags, block_group->flags)
@@ -685,7 +691,7 @@ LTTNG_TRACEPOINT_EVENT(btrfs_add_block_group,
 	TP_ARGS(fs_info, block_group, create),
 
 	TP_FIELDS(
-		ctf_array(u8, fsid, fs_info->fsid, BTRFS_UUID_SIZE)
+		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
 		ctf_integer(u64, offset, block_group->key.objectid)
 		ctf_integer(u64, size, block_group->key.offset)
 		ctf_integer(u64, flags, block_group->flags)
@@ -714,7 +720,7 @@ LTTNG_TRACEPOINT_EVENT_CLASS(btrfs_delayed_tree_ref,
 	TP_ARGS(fs_info, ref, full_ref, action),
 
 	TP_FIELDS(
-		ctf_array(u8, fsid, fs_info->fsid, BTRFS_UUID_SIZE)
+		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
 		ctf_integer(u64, bytenr, ref->bytenr)
 		ctf_integer(u64, num_bytes, ref->num_bytes)
 		ctf_integer(int, action, action)
@@ -764,7 +770,7 @@ LTTNG_TRACEPOINT_EVENT_CLASS(btrfs_delayed_tree_ref,
 	TP_ARGS(fs_info, ref, full_ref, action),
 
 	TP_FIELDS(
-		ctf_array(u8, fsid, fs_info->fsid, BTRFS_UUID_SIZE)
+		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
 		ctf_integer(u64, bytenr, ref->bytenr)
 		ctf_integer(u64, num_bytes, ref->num_bytes)
 		ctf_integer(int, action, action)
@@ -954,7 +960,7 @@ LTTNG_TRACEPOINT_EVENT_CLASS(btrfs_delayed_data_ref,
 	TP_ARGS(fs_info, ref, full_ref, action),
 
 	TP_FIELDS(
-		ctf_array(u8, fsid, fs_info->fsid, BTRFS_UUID_SIZE)
+		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
 		ctf_integer(u64, bytenr, ref->bytenr)
 		ctf_integer(u64, num_bytes, ref->num_bytes)
 		ctf_integer(int, action, action)
@@ -1005,7 +1011,7 @@ LTTNG_TRACEPOINT_EVENT_CLASS(btrfs_delayed_data_ref,
 	TP_ARGS(fs_info, ref, full_ref, action),
 
 	TP_FIELDS(
-		ctf_array(u8, fsid, fs_info->fsid, BTRFS_UUID_SIZE)
+		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
 		ctf_integer(u64, bytenr, ref->bytenr)
 		ctf_integer(u64, num_bytes, ref->num_bytes)
 		ctf_integer(int, action, action)
@@ -1450,18 +1456,18 @@ LTTNG_TRACEPOINT_EVENT_CLASS(btrfs__chunk,
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__chunk,  btrfs_chunk_alloc,
 
-	TP_PROTO(const struct btrfs_fs_info *info, const struct map_lookup *map,
+	TP_PROTO(const struct btrfs_fs_info *fs_info, const struct map_lookup *map,
 		 u64 offset, u64 size),
 
-	TP_ARGS(info, map, offset, size)
+	TP_ARGS(fs_info, map, offset, size)
 )
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__chunk,  btrfs_chunk_free,
 
-	TP_PROTO(const struct btrfs_fs_info *info, const struct map_lookup *map,
+	TP_PROTO(const struct btrfs_fs_info *fs_info, const struct map_lookup *map,
 		 u64 offset, u64 size),
 
-	TP_ARGS(info, map, offset, size)
+	TP_ARGS(fs_info, map, offset, size)
 )
 
 #elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4,10,0))
@@ -1485,18 +1491,18 @@ LTTNG_TRACEPOINT_EVENT_CLASS(btrfs__chunk,
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__chunk,  btrfs_chunk_alloc,
 
-	TP_PROTO(struct btrfs_fs_info *info, struct map_lookup *map,
+	TP_PROTO(struct btrfs_fs_info *fs_info, struct map_lookup *map,
 		 u64 offset, u64 size),
 
-	TP_ARGS(info, map, offset, size)
+	TP_ARGS(fs_info, map, offset, size)
 )
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__chunk,  btrfs_chunk_free,
 
-	TP_PROTO(struct btrfs_fs_info *info, struct map_lookup *map,
+	TP_PROTO(struct btrfs_fs_info *fs_info, struct map_lookup *map,
 		 u64 offset, u64 size),
 
-	TP_ARGS(info, map, offset, size)
+	TP_ARGS(fs_info, map, offset, size)
 )
 
 #elif (LTTNG_SLE_KERNEL_RANGE(4,4,73,5,0,0, 4,4,73,6,0,0) || \
@@ -1627,7 +1633,7 @@ LTTNG_TRACEPOINT_EVENT(btrfs_space_reservation,
 	TP_ARGS(fs_info, type, val, bytes, reserve),
 
 	TP_FIELDS(
-		ctf_array(u8, fsid, fs_info->fsid, BTRFS_UUID_SIZE)
+		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
 		ctf_string(type, type)
 		ctf_integer(u64, val, val)
 		ctf_integer(u64, bytes, bytes)
@@ -1643,7 +1649,7 @@ LTTNG_TRACEPOINT_EVENT(btrfs_space_reservation,
 	TP_ARGS(fs_info, type, val, bytes, reserve),
 
 	TP_FIELDS(
-		ctf_array(u8, fsid, fs_info->fsid, BTRFS_UUID_SIZE)
+		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
 		ctf_string(type, type)
 		ctf_integer(u64, val, val)
 		ctf_integer(u64, bytes, bytes)
@@ -1656,9 +1662,9 @@ LTTNG_TRACEPOINT_EVENT(btrfs_space_reservation,
 
 LTTNG_TRACEPOINT_EVENT_CLASS(btrfs__reserved_extent,
 
-	TP_PROTO(const struct btrfs_fs_info *info, u64 start, u64 len),
+	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 start, u64 len),
 
-	TP_ARGS(info, start, len),
+	TP_ARGS(fs_info, start, len),
 
 	TP_FIELDS(
 		ctf_integer(u64, start, start)
@@ -1668,25 +1674,25 @@ LTTNG_TRACEPOINT_EVENT_CLASS(btrfs__reserved_extent,
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__reserved_extent,  btrfs_reserved_extent_alloc,
 
-	TP_PROTO(const struct btrfs_fs_info *info, u64 start, u64 len),
+	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 start, u64 len),
 
-	TP_ARGS(info, start, len)
+	TP_ARGS(fs_info, start, len)
 )
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__reserved_extent,  btrfs_reserved_extent_free,
 
-	TP_PROTO(const struct btrfs_fs_info *info, u64 start, u64 len),
+	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 start, u64 len),
 
-	TP_ARGS(info, start, len)
+	TP_ARGS(fs_info, start, len)
 )
 
 #elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4,10,0))
 
 LTTNG_TRACEPOINT_EVENT_CLASS(btrfs__reserved_extent,
 
-	TP_PROTO(struct btrfs_fs_info *info, u64 start, u64 len),
+	TP_PROTO(struct btrfs_fs_info *fs_info, u64 start, u64 len),
 
-	TP_ARGS(info, start, len),
+	TP_ARGS(fs_info, start, len),
 
 	TP_FIELDS(
 		ctf_integer(u64, start, start)
@@ -1696,16 +1702,16 @@ LTTNG_TRACEPOINT_EVENT_CLASS(btrfs__reserved_extent,
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__reserved_extent,  btrfs_reserved_extent_alloc,
 
-	TP_PROTO(struct btrfs_fs_info *info, u64 start, u64 len),
+	TP_PROTO(struct btrfs_fs_info *fs_info, u64 start, u64 len),
 
-	TP_ARGS(info, start, len)
+	TP_ARGS(fs_info, start, len)
 )
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__reserved_extent,  btrfs_reserved_extent_free,
 
-	TP_PROTO(struct btrfs_fs_info *info, u64 start, u64 len),
+	TP_PROTO(struct btrfs_fs_info *fs_info, u64 start, u64 len),
 
-	TP_ARGS(info, start, len)
+	TP_ARGS(fs_info, start, len)
 )
 
 #elif (LTTNG_SLE_KERNEL_RANGE(4,4,73,5,0,0, 4,4,73,6,0,0) || \
@@ -1776,13 +1782,13 @@ LTTNG_TRACEPOINT_EVENT_MAP(find_free_extent,
 
 	btrfs_find_free_extent,
 
-	TP_PROTO(const struct btrfs_fs_info *info, u64 num_bytes, u64 empty_size,
+	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 num_bytes, u64 empty_size,
 		 u64 data),
 
-	TP_ARGS(info, num_bytes, empty_size, data),
+	TP_ARGS(fs_info, num_bytes, empty_size, data),
 
 	TP_FIELDS(
-		ctf_array(u8, fsid, info->fsid, BTRFS_UUID_SIZE)
+		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
 		ctf_integer(u64, num_bytes, num_bytes)
 		ctf_integer(u64, empty_size, empty_size)
 		ctf_integer(u64, data, data)
@@ -1797,7 +1803,7 @@ LTTNG_TRACEPOINT_EVENT_CLASS(btrfs__reserve_extent,
 	TP_ARGS(block_group, start, len),
 
 	TP_FIELDS(
-		ctf_array(u8, fsid, block_group->fs_info->fsid, BTRFS_UUID_SIZE)
+		ctf_array(u8, fsid, block_group->lttng_fs_info_fsid, BTRFS_UUID_SIZE)
 		ctf_integer(u64, bg_objectid, block_group->key.objectid)
 		ctf_integer(u64, flags, block_group->flags)
 		ctf_integer(u64, start, start)
@@ -1826,13 +1832,13 @@ LTTNG_TRACEPOINT_EVENT_MAP(find_free_extent,
 
 	btrfs_find_free_extent,
 
-	TP_PROTO(const struct btrfs_fs_info *info, u64 num_bytes, u64 empty_size,
+	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 num_bytes, u64 empty_size,
 		 u64 data),
 
-	TP_ARGS(info, num_bytes, empty_size, data),
+	TP_ARGS(fs_info, num_bytes, empty_size, data),
 
 	TP_FIELDS(
-		ctf_array(u8, fsid, info->fsid, BTRFS_UUID_SIZE)
+		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
 		ctf_integer(u64, num_bytes, num_bytes)
 		ctf_integer(u64, empty_size, empty_size)
 		ctf_integer(u64, data, data)
@@ -1841,14 +1847,14 @@ LTTNG_TRACEPOINT_EVENT_MAP(find_free_extent,
 
 LTTNG_TRACEPOINT_EVENT_CLASS(btrfs__reserve_extent,
 
-	TP_PROTO(const struct btrfs_fs_info *info,
+	TP_PROTO(const struct btrfs_fs_info *fs_info,
 		 const struct btrfs_block_group_cache *block_group, u64 start,
 		 u64 len),
 
-	TP_ARGS(info, block_group, start, len),
+	TP_ARGS(fs_info, block_group, start, len),
 
 	TP_FIELDS(
-		ctf_array(u8, fsid, info->fsid, BTRFS_UUID_SIZE)
+		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
 		ctf_integer(u64, bg_objectid, block_group->key.objectid)
 		ctf_integer(u64, flags, block_group->flags)
 		ctf_integer(u64, start, start)
@@ -1858,20 +1864,20 @@ LTTNG_TRACEPOINT_EVENT_CLASS(btrfs__reserve_extent,
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__reserve_extent, btrfs_reserve_extent,
 
-	TP_PROTO(const struct btrfs_fs_info *info,
+	TP_PROTO(const struct btrfs_fs_info *fs_info,
 		 const struct btrfs_block_group_cache *block_group, u64 start,
 		 u64 len),
 
-	TP_ARGS(info, block_group, start, len)
+	TP_ARGS(fs_info, block_group, start, len)
 )
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__reserve_extent, btrfs_reserve_extent_cluster,
 
-	TP_PROTO(const struct btrfs_fs_info *info,
+	TP_PROTO(const struct btrfs_fs_info *fs_info,
 		 const struct btrfs_block_group_cache *block_group, u64 start,
 		 u64 len),
 
-	TP_ARGS(info, block_group, start, len)
+	TP_ARGS(fs_info, block_group, start, len)
 )
 
 #elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4,10,0))
@@ -1880,13 +1886,13 @@ LTTNG_TRACEPOINT_EVENT_MAP(find_free_extent,
 
 	btrfs_find_free_extent,
 
-	TP_PROTO(struct btrfs_fs_info *info, u64 num_bytes, u64 empty_size,
+	TP_PROTO(struct btrfs_fs_info *fs_info, u64 num_bytes, u64 empty_size,
 		 u64 data),
 
-	TP_ARGS(info, num_bytes, empty_size, data),
+	TP_ARGS(fs_info, num_bytes, empty_size, data),
 
 	TP_FIELDS(
-		ctf_array(u8, fsid, info->fsid, BTRFS_UUID_SIZE)
+		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
 		ctf_integer(u64, num_bytes, num_bytes)
 		ctf_integer(u64, empty_size, empty_size)
 		ctf_integer(u64, data, data)
@@ -1895,11 +1901,11 @@ LTTNG_TRACEPOINT_EVENT_MAP(find_free_extent,
 
 LTTNG_TRACEPOINT_EVENT_CLASS(btrfs__reserve_extent,
 
-	TP_PROTO(struct btrfs_fs_info *info,
+	TP_PROTO(struct btrfs_fs_info *fs_info,
 		 struct btrfs_block_group_cache *block_group, u64 start,
 		 u64 len),
 
-	TP_ARGS(info, block_group, start, len),
+	TP_ARGS(fs_info, block_group, start, len),
 
 	TP_FIELDS(
 		ctf_integer(u64, bg_objectid, block_group->key.objectid)
@@ -1911,20 +1917,20 @@ LTTNG_TRACEPOINT_EVENT_CLASS(btrfs__reserve_extent,
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__reserve_extent, btrfs_reserve_extent,
 
-	TP_PROTO(struct btrfs_fs_info *info,
+	TP_PROTO(struct btrfs_fs_info *fs_info,
 		 struct btrfs_block_group_cache *block_group, u64 start,
 		 u64 len),
 
-	TP_ARGS(info, block_group, start, len)
+	TP_ARGS(fs_info, block_group, start, len)
 )
 
 LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__reserve_extent, btrfs_reserve_extent_cluster,
 
-	TP_PROTO(struct btrfs_fs_info *info,
+	TP_PROTO(struct btrfs_fs_info *fs_info,
 		 struct btrfs_block_group_cache *block_group, u64 start,
 		 u64 len),
 
-	TP_ARGS(info, block_group, start, len)
+	TP_ARGS(fs_info, block_group, start, len)
 )
 #elif (LTTNG_SLE_KERNEL_RANGE(4,4,73,5,0,0, 4,4,73,6,0,0) || \
 	LTTNG_SLE_KERNEL_RANGE(4,4,82,6,0,0, 4,4,82,7,0,0) || \
-- 
2.17.1
