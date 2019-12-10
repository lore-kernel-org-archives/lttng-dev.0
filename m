From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] fix: ext4: Reserve revoke credits
 for freed blocks (v5.5)
Date: Tue, 10 Dec 2019 11:41:14 -0500
Message-ID: <20191210164114.26954-5-mjeanson__18812.7513438062$1575996235$gmane$org@efficios.com>
References: <20191210164114.26954-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 47XQnR0WxJz15JZ
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

See upstream commit:

  commit 83448bdfb59731c2f54784ed3f4a93ff95be6e7e
  Author: Jan Kara <jack@suse.cz>
  Date:   Tue Nov 5 17:44:29 2019 +0100

    ext4: Reserve revoke credits for freed blocks

    So far we have reserved only relatively high fixed amount of revoke
    credits for each transaction. We over-reserved by large amount for most
    cases but when freeing large directories or files with data journalling,
    the fixed amount is not enough. In fact the worst case estimate is
    inconveniently large (maximum extent size) for freeing of one extent.

    We fix this by doing proper estimate of the amount of blocks that need
    to be revoked when removing blocks from the inode due to truncate or
    hole punching and otherwise reserve just a small amount of revoke
    credits for each transaction to accommodate freeing of xattrs block or
    so.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 instrumentation/events/lttng-module/ext4.h | 31 +++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/instrumentation/events/lttng-module/ext4.h b/instrumentation/events/lttng-module/ext4.h
index b2ca8a7..17809d2 100644
--- a/instrumentation/events/lttng-module/ext4.h
+++ b/instrumentation/events/lttng-module/ext4.h
@@ -1255,7 +1255,36 @@ LTTNG_TRACEPOINT_EVENT(ext4_load_inode,
 	)
 )
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,5,0))
+
+LTTNG_TRACEPOINT_EVENT(ext4_journal_start,
+	TP_PROTO(struct super_block *sb, int blocks, int rsv_blocks,
+		 int revoke_creds, unsigned long IP),
+
+	TP_ARGS(sb, blocks, rsv_blocks, revoke_creds, IP),
+
+	TP_FIELDS(
+		ctf_integer(dev_t, dev, sb->s_dev)
+		ctf_integer(unsigned long, ip, IP)
+		ctf_integer(int, blocks, blocks)
+		ctf_integer(int, rsv_blocks, rsv_blocks)
+		ctf_integer(int, revoke_creds, revoke_creds)
+	)
+)
+
+LTTNG_TRACEPOINT_EVENT(ext4_journal_start_reserved,
+	TP_PROTO(struct super_block *sb, int blocks, unsigned long IP),
+
+	TP_ARGS(sb, blocks, IP),
+
+	TP_FIELDS(
+		ctf_integer(dev_t, dev, sb->s_dev)
+		ctf_integer(unsigned long, ip, IP)
+		ctf_integer(int, blocks, blocks)
+	)
+)
+
+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
 
 LTTNG_TRACEPOINT_EVENT(ext4_journal_start,
 	TP_PROTO(struct super_block *sb, int blocks, int rsv_blocks,
-- 
2.17.1
