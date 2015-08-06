From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: take RCU read-side lock within
	hash table functions
Date: Thu,  6 Aug 2015 18:02:21 -0400
Message-ID: <1438898541-26089-1-git-send-email-mathieu.desnoyers__10123.805239755$1438898633$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZNTFe-0007N1-IH
 for lttng-dev@lists.lttng.org; Thu, 06 Aug 2015 18:03:05 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

After review, a great deal of caller sites miss the RCU read-side lock
when using the hash table modification functions. This is a case where
having a slight performance degradation might be worthwhile if we can be
a bit more stability. So instead of playing whack-a-mole, add the RCU
read-side lock in the hash table modification functions to ensure
protection from ABA.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/common/hashtable/hashtable.c | 45 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/src/common/hashtable/hashtable.c b/src/common/hashtable/hashtable.c
index 3a38cbf..d1049d1 100644
--- a/src/common/hashtable/hashtable.c
+++ b/src/common/hashtable/hashtable.c
@@ -34,6 +34,13 @@ static unsigned long min_hash_alloc_size = 1;
 static unsigned long max_hash_buckets_size = 0;
 
 /*
+ * Getter/lookup functions need to be called with RCU read-side lock
+ * held. However, modification functions (add, add_unique, replace, del)
+ * take the RCU lock internally, so it does not matter whether the
+ * caller hold the RCU lock or not.
+ */
+
+/*
  * Match function for string node.
  */
 static int match_str(struct cds_lfht_node *node, const void *key)
@@ -253,8 +260,11 @@ void lttng_ht_add_unique_str(struct lttng_ht *ht,
 	assert(ht->ht);
 	assert(node);
 
+	/* RCU read lock protects from ABA. */
+	rcu_read_lock();
 	node_ptr = cds_lfht_add_unique(ht->ht, ht->hash_fct(node->key, lttng_ht_seed),
 			ht->match_fct, node->key, &node->node);
+	rcu_read_unlock();
 	assert(node_ptr == &node->node);
 }
 
@@ -268,8 +278,11 @@ void lttng_ht_add_str(struct lttng_ht *ht,
 	assert(ht->ht);
 	assert(node);
 
+	/* RCU read lock protects from ABA. */
+	rcu_read_lock();
 	cds_lfht_add(ht->ht, ht->hash_fct(node->key, lttng_ht_seed),
 			&node->node);
+	rcu_read_unlock();
 }
 
 /*
@@ -281,8 +294,11 @@ void lttng_ht_add_ulong(struct lttng_ht *ht, struct lttng_ht_node_ulong *node)
 	assert(ht->ht);
 	assert(node);
 
+	/* RCU read lock protects from ABA. */
+	rcu_read_lock();
 	cds_lfht_add(ht->ht, ht->hash_fct((void *) node->key, lttng_ht_seed),
 			&node->node);
+	rcu_read_unlock();
 }
 
 /*
@@ -295,8 +311,11 @@ void lttng_ht_add_u64(struct lttng_ht *ht, struct lttng_ht_node_u64 *node)
 	assert(ht->ht);
 	assert(node);
 
+	/* RCU read lock protects from ABA. */
+	rcu_read_lock();
 	cds_lfht_add(ht->ht, ht->hash_fct(&node->key, lttng_ht_seed),
 			&node->node);
+	rcu_read_unlock();
 }
 
 /*
@@ -310,9 +329,12 @@ void lttng_ht_add_unique_ulong(struct lttng_ht *ht,
 	assert(ht->ht);
 	assert(node);
 
+	/* RCU read lock protects from ABA. */
+	rcu_read_lock();
 	node_ptr = cds_lfht_add_unique(ht->ht,
 			ht->hash_fct((void *) node->key, lttng_ht_seed), ht->match_fct,
 			(void *) node->key, &node->node);
+	rcu_read_unlock();
 	assert(node_ptr == &node->node);
 }
 
@@ -327,9 +349,12 @@ void lttng_ht_add_unique_u64(struct lttng_ht *ht,
 	assert(ht->ht);
 	assert(node);
 
+	/* RCU read lock protects from ABA. */
+	rcu_read_lock();
 	node_ptr = cds_lfht_add_unique(ht->ht,
 			ht->hash_fct(&node->key, lttng_ht_seed), ht->match_fct,
 			&node->key, &node->node);
+	rcu_read_unlock();
 	assert(node_ptr == &node->node);
 }
 
@@ -344,9 +369,12 @@ void lttng_ht_add_unique_two_u64(struct lttng_ht *ht,
 	assert(ht->ht);
 	assert(node);
 
+	/* RCU read lock protects from ABA. */
+	rcu_read_lock();
 	node_ptr = cds_lfht_add_unique(ht->ht,
 			ht->hash_fct((void *) &node->key, lttng_ht_seed), ht->match_fct,
 			(void *) &node->key, &node->node);
+	rcu_read_unlock();
 	assert(node_ptr == &node->node);
 }
 
@@ -361,9 +389,12 @@ struct lttng_ht_node_ulong *lttng_ht_add_replace_ulong(struct lttng_ht *ht,
 	assert(ht->ht);
 	assert(node);
 
+	/* RCU read lock protects from ABA. */
+	rcu_read_lock();
 	node_ptr = cds_lfht_add_replace(ht->ht,
 			ht->hash_fct((void *) node->key, lttng_ht_seed), ht->match_fct,
 			(void *) node->key, &node->node);
+	rcu_read_unlock();
 	if (!node_ptr) {
 		return NULL;
 	} else {
@@ -383,9 +414,12 @@ struct lttng_ht_node_u64 *lttng_ht_add_replace_u64(struct lttng_ht *ht,
 	assert(ht->ht);
 	assert(node);
 
+	/* RCU read lock protects from ABA. */
+	rcu_read_lock();
 	node_ptr = cds_lfht_add_replace(ht->ht,
 			ht->hash_fct(&node->key, lttng_ht_seed), ht->match_fct,
 			&node->key, &node->node);
+	rcu_read_unlock();
 	if (!node_ptr) {
 		return NULL;
 	} else {
@@ -399,11 +433,17 @@ struct lttng_ht_node_u64 *lttng_ht_add_replace_u64(struct lttng_ht *ht,
  */
 int lttng_ht_del(struct lttng_ht *ht, struct lttng_ht_iter *iter)
 {
+	int ret;
+
 	assert(ht);
 	assert(ht->ht);
 	assert(iter);
 
-	return cds_lfht_del(ht->ht, iter->iter.node);
+	/* RCU read lock protects from ABA. */
+	rcu_read_lock();
+	ret = cds_lfht_del(ht->ht, iter->iter.node);
+	rcu_read_unlock();
+	return ret;
 }
 
 /*
@@ -441,7 +481,10 @@ unsigned long lttng_ht_get_count(struct lttng_ht *ht)
 	assert(ht);
 	assert(ht->ht);
 
+	/* RCU read lock protects from ABA and allows RCU traversal. */
+	rcu_read_lock();
 	cds_lfht_count_nodes(ht->ht, &scb, &count, &sca);
+	rcu_read_unlock();
 
 	return count;
 }
-- 
2.1.4
