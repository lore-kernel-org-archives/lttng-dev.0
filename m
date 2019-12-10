From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] fix: btrfs: tracepoints: constify
 all pointers (v5.5)
Date: Tue, 10 Dec 2019 11:41:12 -0500
Message-ID: <20191210164114.26954-3-mjeanson__20013.7030262098$1575996203$gmane$org@efficios.com>
References: <20191210164114.26954-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 47XQnQ0Wnlz15JT
 for <lttng-dev@lists.lttng.org>; Tue, 10 Dec 2019 11:41:46 -0500 (EST)
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

See upstream commit:

  commit 1d2e7c7c3ed73cc510a4dc093df2a935092ff5ad
  Author: David Sterba <dsterba@suse.com>
  Date:   Thu Oct 17 13:28:57 2019 +0200

    btrfs: tracepoints: constify all pointers

    We don't modify the data passed to tracepoints, some of the declarations
    are already const, add it to the rest.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 instrumentation/events/lttng-module/btrfs.h | 39 +++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/instrumentation/events/lttng-module/btrfs.h b/instrumentation/events/lttng-module/btrfs.h
index c548cf2..59b668c 100644
--- a/instrumentation/events/lttng-module/btrfs.h
+++ b/instrumentation/events/lttng-module/btrfs.h
@@ -286,7 +286,26 @@ LTTNG_TRACEPOINT_EVENT(btrfs_get_extent,
 
 #endif /* #else #if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,10,0)) */
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,18,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,5,0))
+LTTNG_TRACEPOINT_EVENT(btrfs_handle_em_exist,
+
+	TP_PROTO(const struct btrfs_fs_info *fs_info,
+		const struct extent_map *existing, const struct extent_map *map,
+		u64 start, u64 len),
+
+	TP_ARGS(fs_info, existing, map, start, len),
+
+	TP_FIELDS(
+		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
+		ctf_integer(u64, e_start, existing->start)
+		ctf_integer(u64, e_len, existing->len)
+		ctf_integer(u64, map_start, map->start)
+		ctf_integer(u64, map_len, map->len)
+		ctf_integer(u64, start, start)
+		ctf_integer(u64, len, len)
+	)
+)
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4,18,0))
 LTTNG_TRACEPOINT_EVENT(btrfs_handle_em_exist,
 
 	TP_PROTO(struct btrfs_fs_info *fs_info,
@@ -1620,7 +1639,23 @@ LTTNG_TRACEPOINT_EVENT(btrfs_cow_block,
 )
 #endif
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0) || \
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,5,0))
+LTTNG_TRACEPOINT_EVENT(btrfs_space_reservation,
+
+	TP_PROTO(const struct btrfs_fs_info *fs_info, const char *type, u64 val,
+		 u64 bytes, int reserve),
+
+	TP_ARGS(fs_info, type, val, bytes, reserve),
+
+	TP_FIELDS(
+		ctf_array(u8, fsid, lttng_fs_info_fsid, BTRFS_UUID_SIZE)
+		ctf_string(type, type)
+		ctf_integer(u64, val, val)
+		ctf_integer(u64, bytes, bytes)
+		ctf_integer(int, reserve, reserve)
+	)
+)
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0) || \
 	LTTNG_SLE_KERNEL_RANGE(4,4,73,5,0,0, 4,4,73,6,0,0) || \
 	LTTNG_SLE_KERNEL_RANGE(4,4,82,6,0,0, 4,4,82,7,0,0) || \
 	LTTNG_SLE_KERNEL_RANGE(4,4,92,6,0,0, 4,4,92,7,0,0) || \
-- 
2.17.1
