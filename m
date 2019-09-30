From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH lttng-modules] fix: btrfs: move basic
 block_group definitions to their own header (v5.4)
Date: Mon, 30 Sep 2019 15:15:34 -0400
Message-ID: <20190930191534.11561-1-mjeanson__13821.2695995875$1569870972$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 46hsZ200KQz1P3k
 for <lttng-dev@lists.lttng.org>; Mon, 30 Sep 2019 15:15:53 -0400 (EDT)
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

  commit aac0023c2106952538414254960c51dcf0dc39e9
  Author: Josef Bacik <josef@toxicpanda.com>
  Date:   Thu Jun 20 15:37:44 2019 -0400

    btrfs: move basic block_group definitions to their own header

    This is prep work for moving all of the block group cache code into its
    own file.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 probes/lttng-probe-btrfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/probes/lttng-probe-btrfs.c b/probes/lttng-probe-btrfs.c
index b531197..69e69aa 100644
--- a/probes/lttng-probe-btrfs.c
+++ b/probes/lttng-probe-btrfs.c
@@ -10,9 +10,13 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/version.h>
 #include <../fs/btrfs/ctree.h>
 #include <../fs/btrfs/transaction.h>
 #include <../fs/btrfs/volumes.h>
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(5,4,0))
+#include <../fs/btrfs/block-group.h>
+#endif
 #include <linux/dcache.h>
 #include <lttng-tracer.h>
 
-- 
2.17.1
