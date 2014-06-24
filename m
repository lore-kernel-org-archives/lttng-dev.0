From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/3] rculfhash: fall back to single-threaded
	resize on calloc failure
Date: Tue, 24 Jun 2014 01:20:30 +0000
Message-ID: <1403572832-9066-2-git-send-email-normalperson__36090.7617178329$1403572891$gmane$org@yhbt.net>
References: <1403572832-9066-1-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from dcvr.yhbt.net ([64.71.152.64] ident=normalperson)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <normalperson@yhbt.net>) id 1WzFPg-00025B-99
 for lttng-dev@lists.lttng.org; Mon, 23 Jun 2014 21:20:45 -0400
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

Having a calloc fail on my server should not be fatal.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 rculfhash.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/rculfhash.c b/rculfhash.c
index 7d39388..2a45045 100644
--- a/rculfhash.c
+++ b/rculfhash.c
@@ -1189,7 +1189,10 @@ void partition_resize_helper(struct cds_lfht *ht, unsigned long i,
 	}
 	partition_len = len >> cds_lfht_get_count_order_ulong(nr_threads);
 	work = calloc(nr_threads, sizeof(*work));
-	assert(work);
+	if (!work) {
+		dbg_printf("error allocating for resize, single-threading\n");
+		goto fallback;
+	}
 	for (thread = 0; thread < nr_threads; thread++) {
 		work[thread].ht = ht;
 		work[thread].i = i;
@@ -1205,6 +1208,11 @@ void partition_resize_helper(struct cds_lfht *ht, unsigned long i,
 		assert(!ret);
 	}
 	free(work);
+	return;
+fallback:
+	ht->flavor->thread_online();
+	fct(ht, i, 0, len);
+	ht->flavor->thread_offline();
 }
 
 /*
-- 
2.0.0.259.gbf1bc9c
