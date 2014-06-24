From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/3] rculfhash: remove duplicated code
Date: Tue, 24 Jun 2014 01:20:32 +0000
Message-ID: <1403572832-9066-4-git-send-email-normalperson__9358.60188114948$1403572933$gmane$org@yhbt.net>
References: <1403572832-9066-1-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from dcvr.yhbt.net ([64.71.152.64] ident=normalperson)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <normalperson@yhbt.net>) id 1WzFPm-00025q-RJ
 for lttng-dev@lists.lttng.org; Mon, 23 Jun 2014 21:20:51 -0400
In-Reply-To: <1403572832-9066-1-git-send-email-normalperson@yhbt.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: e@80x24.org
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 rculfhash.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/rculfhash.c b/rculfhash.c
index d534be2..61da37a 100644
--- a/rculfhash.c
+++ b/rculfhash.c
@@ -1177,6 +1177,10 @@ void partition_resize_helper(struct cds_lfht *ht, unsigned long i,
 	int thread, ret;
 	unsigned long nr_threads;
 
+	assert(nr_cpus_mask != -1);
+	if (nr_cpus_mask < 0 || len < 2 * MIN_PARTITION_PER_THREAD)
+		goto fallback;
+
 	/*
 	 * Note: nr_cpus_mask + 1 is always power of 2.
 	 * We spawn just the number of threads we need to satisfy the minimum
@@ -1270,13 +1274,6 @@ static
 void init_table_populate(struct cds_lfht *ht, unsigned long i,
 			 unsigned long len)
 {
-	assert(nr_cpus_mask != -1);
-	if (nr_cpus_mask < 0 || len < 2 * MIN_PARTITION_PER_THREAD) {
-		ht->flavor->thread_online();
-		init_table_populate_partition(ht, i, 0, len);
-		ht->flavor->thread_offline();
-		return;
-	}
 	partition_resize_helper(ht, i, len, init_table_populate_partition);
 }
 
@@ -1369,14 +1366,6 @@ void remove_table_partition(struct cds_lfht *ht, unsigned long i,
 static
 void remove_table(struct cds_lfht *ht, unsigned long i, unsigned long len)
 {
-
-	assert(nr_cpus_mask != -1);
-	if (nr_cpus_mask < 0 || len < 2 * MIN_PARTITION_PER_THREAD) {
-		ht->flavor->thread_online();
-		remove_table_partition(ht, i, 0, len);
-		ht->flavor->thread_offline();
-		return;
-	}
 	partition_resize_helper(ht, i, len, remove_table_partition);
 }
 
-- 
2.0.0.259.gbf1bc9c
