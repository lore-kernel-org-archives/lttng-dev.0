From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH urcu] rculfhash: add assertions on node alignment
Date: Thu, 14 Feb 2013 11:19:33 -0500
Message-ID: <20130214161932.GA29790__23532.2500732311$1360858823$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1U61X4-0000Na-DI
	for lttng-dev@lists.lttng.org; Thu, 14 Feb 2013 11:19:34 -0500
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Stephen Hemminger <shemminger@vyatta.com>
Cc: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

I've had a report of someone running into issues with the RCU lock-free
hash table by embedding the struct cds_lfht_node into a packed structure
by mistake, thus not respecting alignment requirements stated in
urcu/rculfhash.h. Assertions on "replace" and "add" operations should
catch this, but I notice that we should add assertions on the
REMOVAL_OWNER_FLAG to cover all possible misalignments.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/rculfhash.c b/rculfhash.c
index 8c3d621..e0be7df 100644
--- a/rculfhash.c
+++ b/rculfhash.c
@@ -833,13 +833,16 @@ void _cds_lfht_gc_bucket(struct cds_lfht_node *bucket, struct cds_lfht_node *nod
 
 	assert(!is_bucket(bucket));
 	assert(!is_removed(bucket));
+	assert(!is_removal_owner(bucket));
 	assert(!is_bucket(node));
 	assert(!is_removed(node));
+	assert(!is_removal_owner(node));
 	for (;;) {
 		iter_prev = bucket;
 		/* We can always skip the bucket node initially */
 		iter = rcu_dereference(iter_prev->next);
 		assert(!is_removed(iter));
+		assert(!is_removal_owner(iter));
 		assert(iter_prev->reverse_hash <= node->reverse_hash);
 		/*
 		 * We should never be called with bucket (start of chain)
@@ -860,6 +863,7 @@ void _cds_lfht_gc_bucket(struct cds_lfht_node *bucket, struct cds_lfht_node *nod
 			iter = next;
 		}
 		assert(!is_removed(iter));
+		assert(!is_removal_owner(iter));
 		if (is_bucket(iter))
 			new_next = flag_bucket(clear_flag(next));
 		else
@@ -880,8 +884,10 @@ int _cds_lfht_replace(struct cds_lfht *ht, unsigned long size,
 		return -ENOENT;
 
 	assert(!is_removed(old_node));
+	assert(!is_removal_owner(old_node));
 	assert(!is_bucket(old_node));
 	assert(!is_removed(new_node));
+	assert(!is_removal_owner(new_node));
 	assert(!is_bucket(new_node));
 	assert(new_node != old_node);
 	for (;;) {
@@ -956,6 +962,7 @@ void _cds_lfht_add(struct cds_lfht *ht,
 
 	assert(!is_bucket(node));
 	assert(!is_removed(node));
+	assert(!is_removal_owner(node));
 	bucket = lookup_bucket(ht, size, hash);
 	for (;;) {
 		uint32_t chain_len = 0;
@@ -1016,7 +1023,9 @@ void _cds_lfht_add(struct cds_lfht *ht,
 	insert:
 		assert(node != clear_flag(iter));
 		assert(!is_removed(iter_prev));
+		assert(!is_removal_owner(iter_prev));
 		assert(!is_removed(iter));
+		assert(!is_removal_owner(iter));
 		assert(iter_prev != node);
 		if (!bucket_flag)
 			node->next = clear_flag(iter);
@@ -1036,6 +1045,7 @@ void _cds_lfht_add(struct cds_lfht *ht,
 
 	gc_node:
 		assert(!is_removed(iter));
+		assert(!is_removal_owner(iter));
 		if (is_bucket(iter))
 			new_next = flag_bucket(clear_flag(next));
 		else
@@ -1700,6 +1710,7 @@ int cds_lfht_delete_bucket(struct cds_lfht *ht)
 		if (!is_bucket(node))
 			return -EPERM;
 		assert(!is_removed(node));
+		assert(!is_removal_owner(node));
 	} while (!is_end(node));
 	/*
 	 * size accessed without rcu_dereference because hash table is

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
