From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: hashtable: take
	split_count_order into	account
Date: Fri, 30 Aug 2013 14:31:48 -0400
Message-ID: <20130830183148.GA12014__13660.1561717272$1377887567$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VFTU5-00030B-SF
	for lttng-dev@lists.lttng.org; Fri, 30 Aug 2013 14:31:55 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This makes check_resize() handle split-counters more precisely.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/src/common/hashtable/rculfhash.c b/src/common/hashtable/rculfhash.c
index ebdc4ff..0ddd21a 100644
--- a/src/common/hashtable/rculfhash.c
+++ b/src/common/hashtable/rculfhash.c
@@ -570,6 +570,7 @@ void cds_lfht_resize_lazy_count(struct cds_lfht *ht, unsigned long size,
 
 static long nr_cpus_mask = -1;
 static long split_count_mask = -1;
+static int split_count_order = -1;
 
 #if defined(HAVE_SYSCONF)
 static void ht_init_nr_cpus_mask(void)
@@ -606,6 +607,8 @@ void alloc_split_items_count(struct cds_lfht *ht)
 			split_count_mask = DEFAULT_SPLIT_COUNT_MASK;
 		else
 			split_count_mask = nr_cpus_mask;
+		split_count_order =
+			cds_lfht_get_count_order_ulong(split_count_mask + 1);
 	}
 
 	assert(split_count_mask >= 0);
@@ -721,7 +724,7 @@ void check_resize(struct cds_lfht *ht, unsigned long size, uint32_t chain_len)
 	 * Use bucket-local length for small table expand and for
 	 * environments lacking per-cpu data support.
 	 */
-	if (count >= (1UL << COUNT_COMMIT_ORDER))
+	if (count >= (1UL << (COUNT_COMMIT_ORDER + split_count_order)))
 		return;
 	if (chain_len > 100)
 		dbg_printf("WARNING: large chain length: %u.\n",
@@ -735,7 +738,9 @@ void check_resize(struct cds_lfht *ht, unsigned long size, uint32_t chain_len)
 		growth = cds_lfht_get_count_order_u32(chain_len
 				- (CHAIN_LEN_TARGET - 1));
 		if ((ht->flags & CDS_LFHT_ACCOUNTING)
-				&& (size << growth) >= (1UL << COUNT_COMMIT_ORDER)) {
+				&& (size << growth)
+					>= (1UL << (COUNT_COMMIT_ORDER
+						+ split_count_order))) {
 			/*
 			 * If ideal growth expands the hash table size
 			 * beyond the "small hash table" sizes, use the
@@ -745,8 +750,8 @@ void check_resize(struct cds_lfht *ht, unsigned long size, uint32_t chain_len)
 			 * the chain length is used to expand the hash
 			 * table in every case.
 			 */
-			growth = COUNT_COMMIT_ORDER -
-				cds_lfht_get_count_order_u32(size);
+			growth = COUNT_COMMIT_ORDER + split_count_order
+				- cds_lfht_get_count_order_ulong(size);
 			if (growth <= 0)
 				return;
 		}

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
