From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules 3/3] Fix: ext4: adjust reserved
 cluster count when removing extents (v4.20)
Date: Mon,  5 Nov 2018 11:35:54 -0500
Message-ID: <20181105163554.32095-3-mjeanson__11910.4069345214$1541435682$gmane$org@efficios.com>
References: <20181105163554.32095-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42pdbN6qhZzqmk
 for <lttng-dev@lists.lttng.org>; Mon,  5 Nov 2018 11:36:00 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id E9215248E23
 for <lttng-dev@lists.lttng.org>; Mon,  5 Nov 2018 11:36:00 -0500 (EST)
In-Reply-To: <20181105163554.32095-1-mjeanson@efficios.com>
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

See upstream commit :

  commit 9fe671496b6c286f9033aedfc1718d67721da0ae
  Author: Eric Whitney <enwlinux@gmail.com>
  Date:   Mon Oct 1 14:25:08 2018 -0400

    ext4: adjust reserved cluster count when removing extents

    Modify ext4_ext_remove_space() and the code it calls to correct the
    reserved cluster count for pending reservations (delayed allocated
    clusters shared with allocated blocks) when a block range is removed
    from the extent tree.  Pending reservations may be found for the clusters
    at the ends of written or unwritten extents when a block range is removed.
    If a physical cluster at the end of an extent is freed, it's necessary
    to increment the reserved cluster count to maintain correct accounting
    if the corresponding logical cluster is shared with at least one
    delayed and unwritten extent as found in the extents status tree.

    Add a new function, ext4_rereserve_cluster(), to reapply a reservation
    on a delayed allocated cluster sharing blocks with a freed allocated
    cluster.  To avoid ENOSPC on reservation, a flag is applied to
    ext4_free_blocks() to briefly defer updating the freeclusters counter
    when an allocated cluster is freed.  This prevents another thread
    from allocating the freed block before the reservation can be reapplied.

    Redefine the partial cluster object as a struct to carry more state
    information and to clarify the code using it.

    Adjust the conditional code structure in ext4_ext_remove_space to
    reduce the indentation level in the main body of the code to improve
    readability.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 instrumentation/events/lttng-module/ext4.h | 72 +++++++++++++++++++++-
 1 file changed, 69 insertions(+), 3 deletions(-)

diff --git a/instrumentation/events/lttng-module/ext4.h b/instrumentation/events/lttng-module/ext4.h
index 740f288..307021a 100644
--- a/instrumentation/events/lttng-module/ext4.h
+++ b/instrumentation/events/lttng-module/ext4.h
@@ -1603,7 +1603,30 @@ LTTNG_TRACEPOINT_EVENT(ext4_ext_show_extent,
 	)
 )
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,20,0))
+
+LTTNG_TRACEPOINT_EVENT(ext4_remove_blocks,
+	TP_PROTO(struct inode *inode, struct ext4_extent *ex,
+		 ext4_lblk_t from, ext4_fsblk_t to,
+		 struct partial_cluster *pc),
+
+	TP_ARGS(inode, ex, from, to, pc),
+
+	TP_FIELDS(
+		ctf_integer(dev_t, dev, inode->i_sb->s_dev)
+		ctf_integer(ino_t, ino, inode->i_ino)
+		ctf_integer(ext4_lblk_t, from, from)
+		ctf_integer(ext4_lblk_t, to, to)
+		ctf_integer(ext4_fsblk_t, ee_pblk, ext4_ext_pblock(ex))
+		ctf_integer(ext4_lblk_t, ee_lblk, le32_to_cpu(ex->ee_block))
+		ctf_integer(unsigned short, ee_len, ext4_ext_get_actual_len(ex))
+		ctf_integer(ext4_fsblk_t, pc_pclu, pc->pclu)
+		ctf_integer(ext4_lblk_t, pc_lblk, pc->lblk)
+		ctf_integer(int, pc_state, pc->state)
+	)
+)
+
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
 
 LTTNG_TRACEPOINT_EVENT(ext4_remove_blocks,
 	    TP_PROTO(struct inode *inode, struct ext4_extent *ex,
@@ -1647,7 +1670,29 @@ LTTNG_TRACEPOINT_EVENT(ext4_remove_blocks,
 
 #endif
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,20,0))
+
+LTTNG_TRACEPOINT_EVENT(ext4_ext_rm_leaf,
+	TP_PROTO(struct inode *inode, ext4_lblk_t start,
+		 struct ext4_extent *ex,
+		 struct partial_cluster *pc),
+
+	TP_ARGS(inode, start, ex, pc),
+
+	TP_FIELDS(
+		ctf_integer(dev_t, dev, inode->i_sb->s_dev)
+		ctf_integer(ino_t, ino, inode->i_ino)
+		ctf_integer(ext4_lblk_t, start, start)
+		ctf_integer(ext4_lblk_t, ee_lblk, le32_to_cpu(ex->ee_block))
+		ctf_integer(ext4_fsblk_t, ee_pblk, ext4_ext_pblock(ex))
+		ctf_integer(short, ee_len, ext4_ext_get_actual_len(ex))
+		ctf_integer(ext4_fsblk_t, pc_pclu, pc->pclu)
+		ctf_integer(ext4_lblk_t, pc_lblk, pc->lblk)
+		ctf_integer(int, pc_state, pc->state)
+	)
+)
+
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
 
 LTTNG_TRACEPOINT_EVENT(ext4_ext_rm_leaf,
 	TP_PROTO(struct inode *inode, ext4_lblk_t start,
@@ -1734,7 +1779,28 @@ LTTNG_TRACEPOINT_EVENT(ext4_ext_remove_space,
 
 #endif
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,20,0))
+
+LTTNG_TRACEPOINT_EVENT(ext4_ext_remove_space_done,
+	TP_PROTO(struct inode *inode, ext4_lblk_t start, ext4_lblk_t end,
+		 int depth, struct partial_cluster *pc, __le16 eh_entries),
+
+	TP_ARGS(inode, start, end, depth, pc, eh_entries),
+
+	TP_FIELDS(
+		ctf_integer(dev_t, dev, inode->i_sb->s_dev)
+		ctf_integer(ino_t, ino, inode->i_ino)
+		ctf_integer(ext4_lblk_t, start, start)
+		ctf_integer(ext4_lblk_t, end, end)
+		ctf_integer(int, depth, depth)
+		ctf_integer(unsigned short, eh_entries, le16_to_cpu(eh_entries))
+		ctf_integer(ext4_fsblk_t, pc_pclu, pc->pclu)
+		ctf_integer(ext4_lblk_t, pc_lblk, pc->lblk)
+		ctf_integer(int, pc_state, pc->state)
+	)
+)
+
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
 
 LTTNG_TRACEPOINT_EVENT(ext4_ext_remove_space_done,
 	TP_PROTO(struct inode *inode, ext4_lblk_t start, ext4_lblk_t end,
-- 
2.17.1
