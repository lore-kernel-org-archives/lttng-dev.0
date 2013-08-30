From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH urcu] Fix: hash table growth (for
	small	tables) should be limited
Date: Fri, 30 Aug 2013 14:24:50 -0400
Message-ID: <20130830182450.GB11864__36964.0080993578$1377887170$gmane$org@Krystal>
References: <20130827221850.GA14036@Krystal> <20130830175805.GA11508@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VFTNL-0002MV-CK
	for lttng-dev@lists.lttng.org; Fri, 30 Aug 2013 14:25:02 -0400
Content-Disposition: inline
In-Reply-To: <20130830175805.GA11508@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
Cc: Stephen Hemminger <shemminger@vyatta.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alan Stern <stern@rowland.harvard.edu>
List-Id: lttng-dev@lists.lttng.org

I'm merging this:

commit 0f9772a234678dd5c775fadab9048f3b9472fe29
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Tue Aug 27 17:58:22 2013 -0400

    Fix: hash table growth (for small tables) should be limited
    
    Buckets with many entries encountered in a hash table could cause it to
    grow to a large size, beyond the scope for which this mechanism is
    expected to play a role when node accounting is available. Indeed, when
    the hash table grows to larger size, split-counter node accounting is
    expected to deal with resize/shrink rather than relying on an heuristic
    based on the largest bucket size.
    
    This is fixing an issue where we see hash tables sometimes reaching 65k
    entries index (65536*8 = 524288 bytes) for a workload limited to adding
    1000 entries and then removing all of them, done in a loop (random
    keys).
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

diff --git a/rculfhash.c b/rculfhash.c
index 423609d..7d39388 100644
--- a/rculfhash.c
+++ b/rculfhash.c
@@ -563,6 +563,7 @@ void cds_lfht_resize_lazy_count(struct cds_lfht *ht, unsigned long size,
 
 static long nr_cpus_mask = -1;
 static long split_count_mask = -1;
+static int split_count_order = -1;
 
 #if defined(HAVE_SYSCONF)
 static void ht_init_nr_cpus_mask(void)
@@ -597,6 +598,8 @@ void alloc_split_items_count(struct cds_lfht *ht)
 			split_count_mask = DEFAULT_SPLIT_COUNT_MASK;
 		else
 			split_count_mask = nr_cpus_mask;
+		split_count_order =
+			cds_lfht_get_count_order_ulong(split_count_mask + 1);
 	}
 
 	assert(split_count_mask >= 0);
@@ -713,14 +716,39 @@ void check_resize(struct cds_lfht *ht, unsigned long size, uint32_t chain_len)
 	 * Use bucket-local length for small table expand and for
 	 * environments lacking per-cpu data support.
 	 */
-	if (count >= (1UL << COUNT_COMMIT_ORDER))
+	if (count >= (1UL << (COUNT_COMMIT_ORDER + split_count_order)))
 		return;
 	if (chain_len > 100)
 		dbg_printf("WARNING: large chain length: %u.\n",
 			   chain_len);
-	if (chain_len >= CHAIN_LEN_RESIZE_THRESHOLD)
-		cds_lfht_resize_lazy_grow(ht, size,
-			cds_lfht_get_count_order_u32(chain_len - (CHAIN_LEN_TARGET - 1)));
+	if (chain_len >= CHAIN_LEN_RESIZE_THRESHOLD) {
+		int growth;
+
+		/*
+		 * Ideal growth calculated based on chain length.
+		 */
+		growth = cds_lfht_get_count_order_u32(chain_len
+				- (CHAIN_LEN_TARGET - 1));
+		if ((ht->flags & CDS_LFHT_ACCOUNTING)
+				&& (size << growth)
+					>= (1UL << (COUNT_COMMIT_ORDER
+						+ split_count_order))) {
+			/*
+			 * If ideal growth expands the hash table size
+			 * beyond the "small hash table" sizes, use the
+			 * maximum small hash table size to attempt
+			 * expanding the hash table. This only applies
+			 * when node accounting is available, otherwise
+			 * the chain length is used to expand the hash
+			 * table in every case.
+			 */
+			growth = COUNT_COMMIT_ORDER + split_count_order
+				- cds_lfht_get_count_order_ulong(size);
+			if (growth <= 0)
+				return;
+		}
+		cds_lfht_resize_lazy_grow(ht, size, growth);
+	}
 }
 
 static

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
