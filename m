From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules stable-2.10] Fix: btrfs:
 Remove fsid/metadata_fsid fields from btrfs_info
Date: Wed, 16 Jan 2019 15:38:37 -0500 (EST)
Message-ID: <1793806473.1824.1547671117359.JavaMail.zimbra__49375.3055263825$1547671000$gmane$org@efficios.com>
References: <20190110195615.27548-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43fzZ64VGDznml
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jan 2019 15:38:38 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 14316B3A91
 for <lttng-dev@lists.lttng.org>; Wed, 16 Jan 2019 15:38:38 -0500 (EST)
In-Reply-To: <20190110195615.27548-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged into stable-2.10, stable-2.9, thanks!

Mathieu

----- On Jan 10, 2019, at 2:56 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Introduced in v5.0.
> 
> See upstream commit :
> 
>  commit de37aa513105f864d3c21105bf5542d498f21ca2
>  Author: Nikolay Borisov <nborisov@suse.com>
>  Date:   Tue Oct 30 16:43:24 2018 +0200
> 
>    btrfs: Remove fsid/metadata_fsid fields from btrfs_info
> 
>    Currently btrfs_fs_info structure contains a copy of the
>    fsid/metadata_uuid fields. Same values are also contained in the
>    btrfs_fs_devices structure which fs_info has a reference to. Let's
>    reduce duplication by removing the fields from fs_info and always refer
>    to the ones in fs_devices. No functional changes.
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> instrumentation/events/lttng-module/btrfs.h | 100 +++++++++++---------
> 1 file changed, 53 insertions(+), 47 deletions(-)
> 
> diff --git a/instrumentation/events/lttng-module/btrfs.h
> b/instrumentation/events/lttng-module/btrfs.h
> index 4dfbf5b..ec45a1e 100644
> --- a/instrumentation/events/lttng-module/btrfs.h
> +++ b/instrumentation/events/lttng-module/btrfs.h
> @@ -32,6 +32,12 @@ struct extent_state;
> 
> #define BTRFS_UUID_SIZE 16
> 
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,0,0))
> +#define lttng_fs_info_fsid fs_info->fs_devices->fsid
> +#else
> +#define lttng_fs_info_fsid fs_info->fsid
> +#endif
> +
> #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0) || \
> 	LTTNG_SLE_KERNEL_RANGE(4,4,73,5,0,0, 4,4,73,6,0,0) || \
> 	LTTNG_SLE_KERNEL_RANGE(4,4,82,6,0,0, 4,4,82,7,0,0) || \
> @@ -629,7 +635,7 @@ LTTNG_TRACEPOINT_EVENT(btrfs_add_block_group,
> 	TP_ARGS(fs_info, block_group, create),
> 
> 	TP_FIELDS(
> -		ctf_array(u8, fsid, fs_info->fsid, BTRFS_UUID_SIZE)
> +		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
> 		ctf_integer(u64, offset, block_group->key.objectid)
> 		ctf_integer(u64, size, block_group->key.offset)
> 		ctf_integer(u64, flags, block_group->flags)
> @@ -647,7 +653,7 @@ LTTNG_TRACEPOINT_EVENT(btrfs_add_block_group,
> 	TP_ARGS(fs_info, block_group, create),
> 
> 	TP_FIELDS(
> -		ctf_array(u8, fsid, fs_info->fsid, BTRFS_UUID_SIZE)
> +		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
> 		ctf_integer(u64, offset, block_group->key.objectid)
> 		ctf_integer(u64, size, block_group->key.offset)
> 		ctf_integer(u64, flags, block_group->flags)
> @@ -1015,18 +1021,18 @@ LTTNG_TRACEPOINT_EVENT_CLASS(btrfs__chunk,
> 
> LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__chunk,  btrfs_chunk_alloc,
> 
> -	TP_PROTO(const struct btrfs_fs_info *info, const struct map_lookup *map,
> +	TP_PROTO(const struct btrfs_fs_info *fs_info, const struct map_lookup *map,
> 		 u64 offset, u64 size),
> 
> -	TP_ARGS(info, map, offset, size)
> +	TP_ARGS(fs_info, map, offset, size)
> )
> 
> LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__chunk,  btrfs_chunk_free,
> 
> -	TP_PROTO(const struct btrfs_fs_info *info, const struct map_lookup *map,
> +	TP_PROTO(const struct btrfs_fs_info *fs_info, const struct map_lookup *map,
> 		 u64 offset, u64 size),
> 
> -	TP_ARGS(info, map, offset, size)
> +	TP_ARGS(fs_info, map, offset, size)
> )
> 
> #elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4,10,0))
> @@ -1050,18 +1056,18 @@ LTTNG_TRACEPOINT_EVENT_CLASS(btrfs__chunk,
> 
> LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__chunk,  btrfs_chunk_alloc,
> 
> -	TP_PROTO(struct btrfs_fs_info *info, struct map_lookup *map,
> +	TP_PROTO(struct btrfs_fs_info *fs_info, struct map_lookup *map,
> 		 u64 offset, u64 size),
> 
> -	TP_ARGS(info, map, offset, size)
> +	TP_ARGS(fs_info, map, offset, size)
> )
> 
> LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__chunk,  btrfs_chunk_free,
> 
> -	TP_PROTO(struct btrfs_fs_info *info, struct map_lookup *map,
> +	TP_PROTO(struct btrfs_fs_info *fs_info, struct map_lookup *map,
> 		 u64 offset, u64 size),
> 
> -	TP_ARGS(info, map, offset, size)
> +	TP_ARGS(fs_info, map, offset, size)
> )
> 
> #elif (LTTNG_SLE_KERNEL_RANGE(4,4,73,5,0,0, 4,4,73,6,0,0) || \
> @@ -1192,7 +1198,7 @@ LTTNG_TRACEPOINT_EVENT(btrfs_space_reservation,
> 	TP_ARGS(fs_info, type, val, bytes, reserve),
> 
> 	TP_FIELDS(
> -		ctf_array(u8, fsid, fs_info->fsid, BTRFS_UUID_SIZE)
> +		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
> 		ctf_string(type, type)
> 		ctf_integer(u64, val, val)
> 		ctf_integer(u64, bytes, bytes)
> @@ -1208,7 +1214,7 @@ LTTNG_TRACEPOINT_EVENT(btrfs_space_reservation,
> 	TP_ARGS(fs_info, type, val, bytes, reserve),
> 
> 	TP_FIELDS(
> -		ctf_array(u8, fsid, fs_info->fsid, BTRFS_UUID_SIZE)
> +		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
> 		ctf_string(type, type)
> 		ctf_integer(u64, val, val)
> 		ctf_integer(u64, bytes, bytes)
> @@ -1221,9 +1227,9 @@ LTTNG_TRACEPOINT_EVENT(btrfs_space_reservation,
> 
> LTTNG_TRACEPOINT_EVENT_CLASS(btrfs__reserved_extent,
> 
> -	TP_PROTO(const struct btrfs_fs_info *info, u64 start, u64 len),
> +	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 start, u64 len),
> 
> -	TP_ARGS(info, start, len),
> +	TP_ARGS(fs_info, start, len),
> 
> 	TP_FIELDS(
> 		ctf_integer(u64, start, start)
> @@ -1233,25 +1239,25 @@ LTTNG_TRACEPOINT_EVENT_CLASS(btrfs__reserved_extent,
> 
> LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__reserved_extent,
> btrfs_reserved_extent_alloc,
> 
> -	TP_PROTO(const struct btrfs_fs_info *info, u64 start, u64 len),
> +	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 start, u64 len),
> 
> -	TP_ARGS(info, start, len)
> +	TP_ARGS(fs_info, start, len)
> )
> 
> LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__reserved_extent,
> btrfs_reserved_extent_free,
> 
> -	TP_PROTO(const struct btrfs_fs_info *info, u64 start, u64 len),
> +	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 start, u64 len),
> 
> -	TP_ARGS(info, start, len)
> +	TP_ARGS(fs_info, start, len)
> )
> 
> #elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4,10,0))
> 
> LTTNG_TRACEPOINT_EVENT_CLASS(btrfs__reserved_extent,
> 
> -	TP_PROTO(struct btrfs_fs_info *info, u64 start, u64 len),
> +	TP_PROTO(struct btrfs_fs_info *fs_info, u64 start, u64 len),
> 
> -	TP_ARGS(info, start, len),
> +	TP_ARGS(fs_info, start, len),
> 
> 	TP_FIELDS(
> 		ctf_integer(u64, start, start)
> @@ -1261,16 +1267,16 @@ LTTNG_TRACEPOINT_EVENT_CLASS(btrfs__reserved_extent,
> 
> LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__reserved_extent,
> btrfs_reserved_extent_alloc,
> 
> -	TP_PROTO(struct btrfs_fs_info *info, u64 start, u64 len),
> +	TP_PROTO(struct btrfs_fs_info *fs_info, u64 start, u64 len),
> 
> -	TP_ARGS(info, start, len)
> +	TP_ARGS(fs_info, start, len)
> )
> 
> LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__reserved_extent,
> btrfs_reserved_extent_free,
> 
> -	TP_PROTO(struct btrfs_fs_info *info, u64 start, u64 len),
> +	TP_PROTO(struct btrfs_fs_info *fs_info, u64 start, u64 len),
> 
> -	TP_ARGS(info, start, len)
> +	TP_ARGS(fs_info, start, len)
> )
> 
> #elif (LTTNG_SLE_KERNEL_RANGE(4,4,73,5,0,0, 4,4,73,6,0,0) || \
> @@ -1341,13 +1347,13 @@ LTTNG_TRACEPOINT_EVENT_MAP(find_free_extent,
> 
> 	btrfs_find_free_extent,
> 
> -	TP_PROTO(const struct btrfs_fs_info *info, u64 num_bytes, u64 empty_size,
> +	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 num_bytes, u64 empty_size,
> 		 u64 data),
> 
> -	TP_ARGS(info, num_bytes, empty_size, data),
> +	TP_ARGS(fs_info, num_bytes, empty_size, data),
> 
> 	TP_FIELDS(
> -		ctf_array(u8, fsid, info->fsid, BTRFS_UUID_SIZE)
> +		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
> 		ctf_integer(u64, num_bytes, num_bytes)
> 		ctf_integer(u64, empty_size, empty_size)
> 		ctf_integer(u64, data, data)
> @@ -1362,7 +1368,7 @@ LTTNG_TRACEPOINT_EVENT_CLASS(btrfs__reserve_extent,
> 	TP_ARGS(block_group, start, len),
> 
> 	TP_FIELDS(
> -		ctf_array(u8, fsid, block_group->fs_info->fsid, BTRFS_UUID_SIZE)
> +		ctf_array(u8, fsid, block_group->lttng_fs_info_fsid, BTRFS_UUID_SIZE)
> 		ctf_integer(u64, bg_objectid, block_group->key.objectid)
> 		ctf_integer(u64, flags, block_group->flags)
> 		ctf_integer(u64, start, start)
> @@ -1391,13 +1397,13 @@ LTTNG_TRACEPOINT_EVENT_MAP(find_free_extent,
> 
> 	btrfs_find_free_extent,
> 
> -	TP_PROTO(const struct btrfs_fs_info *info, u64 num_bytes, u64 empty_size,
> +	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 num_bytes, u64 empty_size,
> 		 u64 data),
> 
> -	TP_ARGS(info, num_bytes, empty_size, data),
> +	TP_ARGS(fs_info, num_bytes, empty_size, data),
> 
> 	TP_FIELDS(
> -		ctf_array(u8, fsid, info->fsid, BTRFS_UUID_SIZE)
> +		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
> 		ctf_integer(u64, num_bytes, num_bytes)
> 		ctf_integer(u64, empty_size, empty_size)
> 		ctf_integer(u64, data, data)
> @@ -1406,14 +1412,14 @@ LTTNG_TRACEPOINT_EVENT_MAP(find_free_extent,
> 
> LTTNG_TRACEPOINT_EVENT_CLASS(btrfs__reserve_extent,
> 
> -	TP_PROTO(const struct btrfs_fs_info *info,
> +	TP_PROTO(const struct btrfs_fs_info *fs_info,
> 		 const struct btrfs_block_group_cache *block_group, u64 start,
> 		 u64 len),
> 
> -	TP_ARGS(info, block_group, start, len),
> +	TP_ARGS(fs_info, block_group, start, len),
> 
> 	TP_FIELDS(
> -		ctf_array(u8, fsid, info->fsid, BTRFS_UUID_SIZE)
> +		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
> 		ctf_integer(u64, bg_objectid, block_group->key.objectid)
> 		ctf_integer(u64, flags, block_group->flags)
> 		ctf_integer(u64, start, start)
> @@ -1423,20 +1429,20 @@ LTTNG_TRACEPOINT_EVENT_CLASS(btrfs__reserve_extent,
> 
> LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__reserve_extent, btrfs_reserve_extent,
> 
> -	TP_PROTO(const struct btrfs_fs_info *info,
> +	TP_PROTO(const struct btrfs_fs_info *fs_info,
> 		 const struct btrfs_block_group_cache *block_group, u64 start,
> 		 u64 len),
> 
> -	TP_ARGS(info, block_group, start, len)
> +	TP_ARGS(fs_info, block_group, start, len)
> )
> 
> LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__reserve_extent,
> btrfs_reserve_extent_cluster,
> 
> -	TP_PROTO(const struct btrfs_fs_info *info,
> +	TP_PROTO(const struct btrfs_fs_info *fs_info,
> 		 const struct btrfs_block_group_cache *block_group, u64 start,
> 		 u64 len),
> 
> -	TP_ARGS(info, block_group, start, len)
> +	TP_ARGS(fs_info, block_group, start, len)
> )
> 
> #elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4,10,0))
> @@ -1445,13 +1451,13 @@ LTTNG_TRACEPOINT_EVENT_MAP(find_free_extent,
> 
> 	btrfs_find_free_extent,
> 
> -	TP_PROTO(struct btrfs_fs_info *info, u64 num_bytes, u64 empty_size,
> +	TP_PROTO(struct btrfs_fs_info *fs_info, u64 num_bytes, u64 empty_size,
> 		 u64 data),
> 
> -	TP_ARGS(info, num_bytes, empty_size, data),
> +	TP_ARGS(fs_info, num_bytes, empty_size, data),
> 
> 	TP_FIELDS(
> -		ctf_array(u8, fsid, info->fsid, BTRFS_UUID_SIZE)
> +		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
> 		ctf_integer(u64, num_bytes, num_bytes)
> 		ctf_integer(u64, empty_size, empty_size)
> 		ctf_integer(u64, data, data)
> @@ -1460,11 +1466,11 @@ LTTNG_TRACEPOINT_EVENT_MAP(find_free_extent,
> 
> LTTNG_TRACEPOINT_EVENT_CLASS(btrfs__reserve_extent,
> 
> -	TP_PROTO(struct btrfs_fs_info *info,
> +	TP_PROTO(struct btrfs_fs_info *fs_info,
> 		 struct btrfs_block_group_cache *block_group, u64 start,
> 		 u64 len),
> 
> -	TP_ARGS(info, block_group, start, len),
> +	TP_ARGS(fs_info, block_group, start, len),
> 
> 	TP_FIELDS(
> 		ctf_integer(u64, bg_objectid, block_group->key.objectid)
> @@ -1476,20 +1482,20 @@ LTTNG_TRACEPOINT_EVENT_CLASS(btrfs__reserve_extent,
> 
> LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__reserve_extent, btrfs_reserve_extent,
> 
> -	TP_PROTO(struct btrfs_fs_info *info,
> +	TP_PROTO(struct btrfs_fs_info *fs_info,
> 		 struct btrfs_block_group_cache *block_group, u64 start,
> 		 u64 len),
> 
> -	TP_ARGS(info, block_group, start, len)
> +	TP_ARGS(fs_info, block_group, start, len)
> )
> 
> LTTNG_TRACEPOINT_EVENT_INSTANCE(btrfs__reserve_extent,
> btrfs_reserve_extent_cluster,
> 
> -	TP_PROTO(struct btrfs_fs_info *info,
> +	TP_PROTO(struct btrfs_fs_info *fs_info,
> 		 struct btrfs_block_group_cache *block_group, u64 start,
> 		 u64 len),
> 
> -	TP_ARGS(info, block_group, start, len)
> +	TP_ARGS(fs_info, block_group, start, len)
> )
> #elif (LTTNG_SLE_KERNEL_RANGE(4,4,73,5,0,0, 4,4,73,6,0,0) || \
> 	LTTNG_SLE_KERNEL_RANGE(4,4,82,6,0,0, 4,4,82,7,0,0) || \
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
