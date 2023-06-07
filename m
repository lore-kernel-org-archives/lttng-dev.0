Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8017C7EE23
	for <lttng-dev@archiver.kernel.org>; Wed,  7 Jun 2023 18:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1686164105;
	bh=hYn5JScZNQR3nkD+Et5S3H+3s6zKvsbQvaUFSDkNhB4=;
	h=To:Date:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=J5+IjEcdfk4cf70GXtKx7ZwJY08t09jwSEscEI928ZcMrqugLQl4evF3YnBt7I/l9
	 vZAkYVj23fIGg9/FT6sX3z2vIXV3kpReq7yIK7ghAR0PUeVREGDHYs8yld+PQx0dn/
	 YzpGJKTH1+0/4qOu0DZZoWRo7ZukU099Ivx641ZKylVU2eWMS9bcG/dhX4tPYK93NH
	 JJtbK741SGZ1GfjjW60YPIrYx4h1pUEPh9AIavOjE0uzktnXcOergWZ0C21l2XlRfD
	 Czi6BanIYItSjLqZVxhoG/EZQrSRRdSoft7LvvEGxdRtxrVvTjrwIW8OA2piY8u0pa
	 cEyE2AdBZPxqA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QbxNn4vVrz1XyX;
	Wed,  7 Jun 2023 14:55:05 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QbxNg411zz1Y3q
 for <lttng-dev@lists.lttng.org>; Wed,  7 Jun 2023 14:54:59 -0400 (EDT)
Received: from laura.hitronhub.home (modemcable094.169-200-24.mc.videotron.ca
 [24.200.169.94])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QbxNY32fTz179T;
 Wed,  7 Jun 2023 14:54:53 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Date: Wed,  7 Jun 2023 14:53:58 -0400
Message-Id: <20230607185359.8125-12-odion@efficios.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515201718.9809-1-odion@efficios.com>
References: <20230515201718.9809-1-odion@efficios.com>
MIME-Version: 1.0
Subject: [lttng-dev] [PATCH v2 11/12] Add cmm_emit_legacy_smp_mb()
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Cc: Olivier Dion <odion@efficios.com>, Tony Finch <dot@dotat.at>,
 "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Some public APIs stipulate implicit memory barriers on operations. These
were coherent with the memory model used at that time. However, with the
migration to a memory model closer to the C11 memory model, these memory
barriers are not strictly emitted by the atomic operations in the new
memory model.

Therefore, introducing the `--disable-legacy-mb' configuration
option. By default, liburcu is configured to emit these legacy memory
barriers, thus keeping backward compatibility at the expense of slower
performances. However, users can opt-out by disabling the legacy memory
barriers.

This options is publicly exported in the system configuration header
file and can be overrode manually on a compilation unit basis by
defining `CONFIG_RCU_EMIT_LEGACY_MB' before including any liburcu files.

The usage of this macro requires to re-write atomic operations in term
of the CMM memory model. This is done for the queue and stack APIs.

Change-Id: Ia5ce3b3d8cd1955556ce96fa4408a63aa098a1a6
Signed-off-by: Olivier Dion <odion@efficios.com>
---
 configure.ac                     | 13 ++++++
 include/urcu/arch.h              |  6 +++
 include/urcu/config.h.in         |  3 ++
 include/urcu/static/lfstack.h    | 25 ++++++++----
 include/urcu/static/rculfqueue.h | 14 ++++---
 include/urcu/static/rculfstack.h |  8 +++-
 include/urcu/static/wfcqueue.h   | 68 +++++++++++++++++---------------
 include/urcu/static/wfqueue.h    |  9 +++--
 include/urcu/static/wfstack.h    | 24 +++++++----
 9 files changed, 114 insertions(+), 56 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4450a31..ca51b5b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -235,6 +235,11 @@ AE_FEATURE([cds-lfht-iter-debug], [Enable extra debugging checks for lock-free h
 AE_FEATURE_DEFAULT_ENABLE
 AE_FEATURE([atomic-builtins], [Disable the usage of toolchain atomic builtins.])
 
+# emit legacy memory barriers
+# Enable by default
+AE_FEATURE_DEFAULT_ENABLE
+AE_FEATURE([legacy-mb], [Disable legacy memory barriers.])
+
 # When given, add -Werror to WARN_CFLAGS and WARN_CXXFLAGS.
 # Disabled by default
 AE_FEATURE_DEFAULT_DISABLE
@@ -282,6 +287,10 @@ AE_IF_FEATURE_ENABLED([atomic-builtins], [
 	[AE_FEATURE_DISABLE(atomic-builtins)])
 ])
 
+AE_IF_FEATURE_ENABLED([legacy-mb], [
+  AC_DEFINE([CONFIG_RCU_EMIT_LEGACY_MB], [1], [Emit legacy memory barriers that were documented in the APIs.])
+])
+
 ##                                                                          ##
 ## Set automake variables for optional feature conditionnals in Makefile.am ##
 ##                                                                          ##
@@ -387,6 +396,10 @@ PPRINT_PROP_BOOL([Lock-free HT iterator debugging], $value)
 AE_IS_FEATURE_ENABLED([atomic-builtins]) && value=1 || value=0
 PPRINT_PROP_BOOL([Use toolchain atomic builtins], $value)
 
+# legacy memory barriers
+AE_IS_FEATURE_ENABLED([legacy-mb]) && value=1 || value=0
+PPRINT_PROP_BOOL([Emit legacy memory barriers], $value)
+
 PPRINT_PROP_BOOL([Multi-flavor support], 1)
 
 report_bindir="`eval eval echo $bindir`"
diff --git a/include/urcu/arch.h b/include/urcu/arch.h
index d3914da..377a0ec 100644
--- a/include/urcu/arch.h
+++ b/include/urcu/arch.h
@@ -171,5 +171,11 @@
 #error "Cannot build: unrecognized architecture, see <urcu/arch.h>."
 #endif
 
+#ifdef CONFIG_RCU_EMIT_LEGACY_MB
+# define cmm_emit_legacy_smp_mb() cmm_smp_mb()
+#else
+# define cmm_emit_legacy_smp_mb() do { } while (0)
+#endif
+
 
 #endif /* _URCU_ARCH_H */
diff --git a/include/urcu/config.h.in b/include/urcu/config.h.in
index 1daaa7e..d2f6c8c 100644
--- a/include/urcu/config.h.in
+++ b/include/urcu/config.h.in
@@ -22,6 +22,9 @@
 /* Uatomic API uses atomic builtins? */
 #undef CONFIG_RCU_USE_ATOMIC_BUILTINS
 
+/* Emit legacy memory barriers? */
+#undef CONFIG_RCU_EMIT_LEGACY_MB
+
 /* Expose multi-flavor support */
 #define CONFIG_RCU_HAVE_MULTIFLAVOR 1
 
diff --git a/include/urcu/static/lfstack.h b/include/urcu/static/lfstack.h
index a05acb4..07604db 100644
--- a/include/urcu/static/lfstack.h
+++ b/include/urcu/static/lfstack.h
@@ -114,7 +114,7 @@ bool ___cds_lfs_empty_head(struct cds_lfs_head *head)
 static inline
 bool _cds_lfs_empty(cds_lfs_stack_ptr_t s)
 {
-	return ___cds_lfs_empty_head(CMM_LOAD_SHARED(s._s->head));
+	return ___cds_lfs_empty_head(uatomic_load(&s._s->head, CMM_RELAXED));
 }
 
 /*
@@ -122,6 +122,8 @@ bool _cds_lfs_empty(cds_lfs_stack_ptr_t s)
  *
  * Does not require any synchronization with other push nor pop.
  *
+ * Operations before push are consistent when observed after associated pop.
+ *
  * Lock-free stack push is not subject to ABA problem, so no need to
  * take the RCU read-side lock. Even if "head" changes between two
  * uatomic_cmpxchg() invocations here (being popped, and then pushed
@@ -167,7 +169,9 @@ bool _cds_lfs_push(cds_lfs_stack_ptr_t u_s,
 		 * uatomic_cmpxchg() implicit memory barrier orders earlier
 		 * stores to node before publication.
 		 */
-		head = uatomic_cmpxchg(&s->head, old_head, new_head);
+		cmm_emit_legacy_smp_mb();
+		head = uatomic_cmpxchg_mo(&s->head, old_head, new_head,
+					CMM_SEQ_CST, CMM_SEQ_CST);
 		if (old_head == head)
 			break;
 	}
@@ -179,6 +183,8 @@ bool _cds_lfs_push(cds_lfs_stack_ptr_t u_s,
  *
  * Returns NULL if stack is empty.
  *
+ * Operations after pop are consistent when observed before associated push.
+ *
  * __cds_lfs_pop needs to be synchronized using one of the following
  * techniques:
  *
@@ -203,7 +209,7 @@ struct cds_lfs_node *___cds_lfs_pop(cds_lfs_stack_ptr_t u_s)
 		struct cds_lfs_head *head, *next_head;
 		struct cds_lfs_node *next;
 
-		head = _CMM_LOAD_SHARED(s->head);
+		head = uatomic_load(&s->head, CMM_CONSUME);
 		if (___cds_lfs_empty_head(head))
 			return NULL;	/* Empty stack */
 
@@ -212,12 +218,14 @@ struct cds_lfs_node *___cds_lfs_pop(cds_lfs_stack_ptr_t u_s)
 		 * memory barrier before uatomic_cmpxchg() in
 		 * cds_lfs_push.
 		 */
-		cmm_smp_read_barrier_depends();
-		next = _CMM_LOAD_SHARED(head->node.next);
+		next = uatomic_load(&head->node.next, CMM_RELAXED);
 		next_head = caa_container_of(next,
 				struct cds_lfs_head, node);
-		if (uatomic_cmpxchg(&s->head, head, next_head) == head)
+		if (uatomic_cmpxchg_mo(&s->head, head, next_head,
+					CMM_SEQ_CST, CMM_SEQ_CST) == head){
+			cmm_emit_legacy_smp_mb();
 			return &head->node;
+		}
 		/* busy-loop if head changed under us */
 	}
 }
@@ -245,6 +253,7 @@ static inline
 struct cds_lfs_head *___cds_lfs_pop_all(cds_lfs_stack_ptr_t u_s)
 {
 	struct __cds_lfs_stack *s = u_s._s;
+	struct cds_lfs_head *head;
 
 	/*
 	 * Implicit memory barrier after uatomic_xchg() matches implicit
@@ -256,7 +265,9 @@ struct cds_lfs_head *___cds_lfs_pop_all(cds_lfs_stack_ptr_t u_s)
 	 * taking care to order writes to each node prior to the full
 	 * memory barrier after this uatomic_xchg().
 	 */
-	return uatomic_xchg(&s->head, NULL);
+	head = uatomic_xchg_mo(&s->head, NULL, CMM_SEQ_CST);
+	cmm_emit_legacy_smp_mb();
+	return head;
 }
 
 /*
diff --git a/include/urcu/static/rculfqueue.h b/include/urcu/static/rculfqueue.h
index ad73454..25a4ec8 100644
--- a/include/urcu/static/rculfqueue.h
+++ b/include/urcu/static/rculfqueue.h
@@ -148,26 +148,29 @@ void _cds_lfq_enqueue_rcu(struct cds_lfq_queue_rcu *q,
 	 * uatomic_cmpxchg() implicit memory barrier orders earlier stores to
 	 * node before publication.
 	 */
-
 	for (;;) {
 		struct cds_lfq_node_rcu *tail, *next;
 
 		tail = rcu_dereference(q->tail);
-		next = uatomic_cmpxchg(&tail->next, NULL, node);
+		cmm_emit_legacy_smp_mb();
+		next = uatomic_cmpxchg_mo(&tail->next, NULL, node,
+					CMM_SEQ_CST, CMM_SEQ_CST);
 		if (next == NULL) {
 			/*
 			 * Tail was at the end of queue, we successfully
 			 * appended to it. Now move tail (another
 			 * enqueue might beat us to it, that's fine).
 			 */
-			(void) uatomic_cmpxchg(&q->tail, tail, node);
+			(void) uatomic_cmpxchg_mo(&q->tail, tail, node,
+						CMM_SEQ_CST, CMM_SEQ_CST);
 			return;
 		} else {
 			/*
 			 * Failure to append to current tail.
 			 * Help moving tail further and retry.
 			 */
-			(void) uatomic_cmpxchg(&q->tail, tail, next);
+			(void) uatomic_cmpxchg_mo(&q->tail, tail, next,
+						CMM_SEQ_CST, CMM_SEQ_CST);
 			continue;
 		}
 	}
@@ -211,7 +214,8 @@ struct cds_lfq_node_rcu *_cds_lfq_dequeue_rcu(struct cds_lfq_queue_rcu *q)
 			enqueue_dummy(q);
 			next = rcu_dereference(head->next);
 		}
-		if (uatomic_cmpxchg(&q->head, head, next) != head)
+		if (uatomic_cmpxchg_mo(&q->head, head, next,
+					CMM_SEQ_CST, CMM_SEQ_CST) != head)
 			continue;	/* Concurrently pushed. */
 		if (head->dummy) {
 			/* Free dummy after grace period. */
diff --git a/include/urcu/static/rculfstack.h b/include/urcu/static/rculfstack.h
index 54ff377..2befb2a 100644
--- a/include/urcu/static/rculfstack.h
+++ b/include/urcu/static/rculfstack.h
@@ -83,7 +83,9 @@ int _cds_lfs_push_rcu(struct cds_lfs_stack_rcu *s,
 		 * uatomic_cmpxchg() implicit memory barrier orders earlier
 		 * stores to node before publication.
 		 */
-		head = uatomic_cmpxchg(&s->head, old_head, node);
+		cmm_emit_legacy_smp_mb();
+		head = uatomic_cmpxchg_mo(&s->head, old_head, node,
+					CMM_SEQ_CST, CMM_SEQ_CST);
 		if (old_head == head)
 			break;
 	}
@@ -108,7 +110,9 @@ _cds_lfs_pop_rcu(struct cds_lfs_stack_rcu *s)
 		if (head) {
 			struct cds_lfs_node_rcu *next = rcu_dereference(head->next);
 
-			if (uatomic_cmpxchg(&s->head, head, next) == head) {
+			if (uatomic_cmpxchg_mo(&s->head, head, next,
+						CMM_SEQ_CST, CMM_SEQ_CST) == head) {
+				cmm_emit_legacy_smp_mb();
 				return head;
 			} else {
 				/* Concurrent modification. Retry. */
diff --git a/include/urcu/static/wfcqueue.h b/include/urcu/static/wfcqueue.h
index 478e859..043b18a 100644
--- a/include/urcu/static/wfcqueue.h
+++ b/include/urcu/static/wfcqueue.h
@@ -91,6 +91,11 @@ static inline void _cds_wfcq_node_init(struct cds_wfcq_node *node)
 	node->next = NULL;
 }
 
+static inline void _cds_wfcq_node_init_atomic(struct cds_wfcq_node *node)
+{
+	uatomic_store(&node->next, NULL, CMM_RELAXED);
+}
+
 /*
  * cds_wfcq_init: initialize wait-free queue (with lock). Pair with
  * cds_wfcq_destroy().
@@ -153,8 +158,8 @@ static inline bool _cds_wfcq_empty(cds_wfcq_head_ptr_t u_head,
 	 * common case to ensure that dequeuers do not frequently access
 	 * enqueuer's tail->p cache line.
 	 */
-	return CMM_LOAD_SHARED(head->node.next) == NULL
-		&& CMM_LOAD_SHARED(tail->p) == &head->node;
+	return uatomic_load(&head->node.next, CMM_CONSUME) == NULL
+		&& uatomic_load(&tail->p, CMM_CONSUME) == &head->node;
 }
 
 static inline void _cds_wfcq_dequeue_lock(struct cds_wfcq_head *head,
@@ -188,7 +193,7 @@ static inline bool ___cds_wfcq_append(cds_wfcq_head_ptr_t u_head,
 	 * stores to data structure containing node and setting
 	 * node->next to NULL before publication.
 	 */
-	old_tail = uatomic_xchg(&tail->p, new_tail);
+	old_tail = uatomic_xchg_mo(&tail->p, new_tail, CMM_SEQ_CST);
 
 	/*
 	 * Implicit memory barrier after uatomic_xchg() orders store to
@@ -199,7 +204,8 @@ static inline bool ___cds_wfcq_append(cds_wfcq_head_ptr_t u_head,
 	 * store will append "node" to the queue from a dequeuer
 	 * perspective.
 	 */
-	CMM_STORE_SHARED(old_tail->next, new_head);
+	uatomic_store(&old_tail->next, new_head, CMM_RELEASE);
+
 	/*
 	 * Return false if queue was empty prior to adding the node,
 	 * else return true.
@@ -210,8 +216,8 @@ static inline bool ___cds_wfcq_append(cds_wfcq_head_ptr_t u_head,
 /*
  * cds_wfcq_enqueue: enqueue a node into a wait-free queue.
  *
- * Issues a full memory barrier before enqueue. No mutual exclusion is
- * required.
+ * Operations prior to enqueue are consistant with respect to dequeuing or
+ * splicing and iterating.
  *
  * Returns false if the queue was empty prior to adding the node.
  * Returns true otherwise.
@@ -220,6 +226,8 @@ static inline bool _cds_wfcq_enqueue(cds_wfcq_head_ptr_t head,
 		struct cds_wfcq_tail *tail,
 		struct cds_wfcq_node *new_tail)
 {
+	cmm_emit_legacy_smp_mb();
+
 	return ___cds_wfcq_append(head, tail, new_tail, new_tail);
 }
 
@@ -270,8 +278,10 @@ ___cds_wfcq_node_sync_next(struct cds_wfcq_node *node, int blocking)
 
 	/*
 	 * Adaptative busy-looping waiting for enqueuer to complete enqueue.
+	 *
+	 * Load node.next before loading node's content
 	 */
-	while ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
+	while ((next = uatomic_load(&node->next, CMM_CONSUME)) == NULL) {
 		if (___cds_wfcq_busy_wait(&attempt, blocking))
 			return CDS_WFCQ_WOULDBLOCK;
 	}
@@ -290,8 +300,7 @@ ___cds_wfcq_first(cds_wfcq_head_ptr_t u_head,
 	if (_cds_wfcq_empty(__cds_wfcq_head_cast(head), tail))
 		return NULL;
 	node = ___cds_wfcq_node_sync_next(&head->node, blocking);
-	/* Load head->node.next before loading node's content */
-	cmm_smp_read_barrier_depends();
+
 	return node;
 }
 
@@ -343,16 +352,15 @@ ___cds_wfcq_next(cds_wfcq_head_ptr_t head __attribute__((unused)),
 	 * out if we reached the end of the queue, we first check
 	 * node->next as a common case to ensure that iteration on nodes
 	 * do not frequently access enqueuer's tail->p cache line.
+	 *
+	 * Load node->next before loading next's content
 	 */
-	if ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
-		/* Load node->next before tail->p */
-		cmm_smp_rmb();
-		if (CMM_LOAD_SHARED(tail->p) == node)
+	if ((next = uatomic_load(&node->next, CMM_CONSUME)) == NULL) {
+		if (uatomic_load(&tail->p, CMM_RELAXED) == node)
 			return NULL;
 		next = ___cds_wfcq_node_sync_next(node, blocking);
 	}
-	/* Load node->next before loading next's content */
-	cmm_smp_read_barrier_depends();
+
 	return next;
 }
 
@@ -414,7 +422,7 @@ ___cds_wfcq_dequeue_with_state(cds_wfcq_head_ptr_t u_head,
 		return CDS_WFCQ_WOULDBLOCK;
 	}
 
-	if ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
+	if ((next = uatomic_load(&node->next, CMM_CONSUME)) == NULL) {
 		/*
 		 * @node is probably the only node in the queue.
 		 * Try to move the tail to &q->head.
@@ -422,17 +430,13 @@ ___cds_wfcq_dequeue_with_state(cds_wfcq_head_ptr_t u_head,
 		 * NULL if the cmpxchg succeeds. Should the
 		 * cmpxchg fail due to a concurrent enqueue, the
 		 * q->head.next will be set to the next node.
-		 * The implicit memory barrier before
-		 * uatomic_cmpxchg() orders load node->next
-		 * before loading q->tail.
-		 * The implicit memory barrier before uatomic_cmpxchg
-		 * orders load q->head.next before loading node's
-		 * content.
 		 */
-		_cds_wfcq_node_init(&head->node);
-		if (uatomic_cmpxchg(&tail->p, node, &head->node) == node) {
+		_cds_wfcq_node_init_atomic(&head->node);
+		if (uatomic_cmpxchg_mo(&tail->p, node, &head->node,
+					CMM_SEQ_CST, CMM_SEQ_CST) == node) {
 			if (state)
 				*state |= CDS_WFCQ_STATE_LAST;
+			cmm_emit_legacy_smp_mb();
 			return node;
 		}
 		next = ___cds_wfcq_node_sync_next(node, blocking);
@@ -442,7 +446,7 @@ ___cds_wfcq_dequeue_with_state(cds_wfcq_head_ptr_t u_head,
 		 * (currently NULL) back to its original value.
 		 */
 		if (!blocking && next == CDS_WFCQ_WOULDBLOCK) {
-			head->node.next = node;
+			uatomic_store(&head->node.next, node, CMM_RELAXED);
 			return CDS_WFCQ_WOULDBLOCK;
 		}
 	}
@@ -450,10 +454,9 @@ ___cds_wfcq_dequeue_with_state(cds_wfcq_head_ptr_t u_head,
 	/*
 	 * Move queue head forward.
 	 */
-	head->node.next = next;
+	uatomic_store(&head->node.next, next, CMM_RELAXED);
+	cmm_emit_legacy_smp_mb();
 
-	/* Load q->head.next before loading node's content */
-	cmm_smp_read_barrier_depends();
 	return node;
 }
 
@@ -515,6 +518,8 @@ ___cds_wfcq_dequeue_nonblocking(cds_wfcq_head_ptr_t head,
 /*
  * __cds_wfcq_splice: enqueue all src_q nodes at the end of dest_q.
  *
+ * Operations after splice are consistant with respect to enqueue.
+ *
  * Dequeue all nodes from src_q.
  * dest_q must be already initialized.
  * Mutual exclusion for src_q should be ensured by the caller as
@@ -548,10 +553,10 @@ ___cds_wfcq_splice(
 		 * uatomic_xchg, as well as tail pointer vs head node
 		 * address.
 		 */
-		head = uatomic_xchg(&src_q_head->node.next, NULL);
+		head = uatomic_xchg_mo(&src_q_head->node.next, NULL, CMM_SEQ_CST);
 		if (head)
 			break;	/* non-empty */
-		if (CMM_LOAD_SHARED(src_q_tail->p) == &src_q_head->node)
+		if (uatomic_load(&src_q_tail->p, CMM_CONSUME) == &src_q_head->node)
 			return CDS_WFCQ_RET_SRC_EMPTY;
 		if (___cds_wfcq_busy_wait(&attempt, blocking))
 			return CDS_WFCQ_RET_WOULDBLOCK;
@@ -563,7 +568,8 @@ ___cds_wfcq_splice(
 	 * concurrent enqueue on src_q, which exchanges the tail before
 	 * updating the previous tail's next pointer.
 	 */
-	tail = uatomic_xchg(&src_q_tail->p, &src_q_head->node);
+	cmm_emit_legacy_smp_mb();
+	tail = uatomic_xchg_mo(&src_q_tail->p, &src_q_head->node, CMM_SEQ_CST);
 
 	/*
 	 * Append the spliced content of src_q into dest_q. Does not
diff --git a/include/urcu/static/wfqueue.h b/include/urcu/static/wfqueue.h
index d04f66f..290fe0a 100644
--- a/include/urcu/static/wfqueue.h
+++ b/include/urcu/static/wfqueue.h
@@ -81,13 +81,14 @@ static inline void _cds_wfq_enqueue(struct cds_wfq_queue *q,
 	 * structure containing node and setting node->next to NULL before
 	 * publication.
 	 */
-	old_tail = uatomic_xchg(&q->tail, &node->next);
+	cmm_emit_legacy_smp_mb();
+	old_tail = uatomic_xchg_mo(&q->tail, &node->next, CMM_SEQ_CST);
 	/*
 	 * At this point, dequeuers see a NULL old_tail->next, which indicates
 	 * that the queue is being appended to. The following store will append
 	 * "node" to the queue from a dequeuer perspective.
 	 */
-	CMM_STORE_SHARED(*old_tail, node);
+	uatomic_store(old_tail, node, CMM_RELEASE);
 }
 
 /*
@@ -102,7 +103,7 @@ ___cds_wfq_node_sync_next(struct cds_wfq_node *node)
 	/*
 	 * Adaptative busy-looping waiting for enqueuer to complete enqueue.
 	 */
-	while ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
+	while ((next = uatomic_load(&node->next, CMM_CONSUME)) == NULL) {
 		if (++attempt >= WFQ_ADAPT_ATTEMPTS) {
 			(void) poll(NULL, 0, WFQ_WAIT);	/* Wait for 10ms */
 			attempt = 0;
@@ -129,7 +130,7 @@ ___cds_wfq_dequeue_blocking(struct cds_wfq_queue *q)
 	/*
 	 * Queue is empty if it only contains the dummy node.
 	 */
-	if (q->head == &q->dummy && CMM_LOAD_SHARED(q->tail) == &q->dummy.next)
+	if (q->head == &q->dummy && uatomic_load(&q->tail, CMM_CONSUME) == &q->dummy.next)
 		return NULL;
 	node = q->head;
 
diff --git a/include/urcu/static/wfstack.h b/include/urcu/static/wfstack.h
index 088e6e3..cfaf675 100644
--- a/include/urcu/static/wfstack.h
+++ b/include/urcu/static/wfstack.h
@@ -124,7 +124,7 @@ static inline bool _cds_wfs_empty(cds_wfs_stack_ptr_t u_stack)
 {
 	struct __cds_wfs_stack *s = u_stack._s;
 
-	return ___cds_wfs_end(CMM_LOAD_SHARED(s->head));
+	return ___cds_wfs_end(uatomic_load(&s->head, CMM_RELAXED));
 }
 
 /*
@@ -133,6 +133,8 @@ static inline bool _cds_wfs_empty(cds_wfs_stack_ptr_t u_stack)
  * Issues a full memory barrier before push. No mutual exclusion is
  * required.
  *
+ * Operations before push are consistent when observed after associated pop.
+ *
  * Returns 0 if the stack was empty prior to adding the node.
  * Returns non-zero otherwise.
  */
@@ -148,12 +150,13 @@ int _cds_wfs_push(cds_wfs_stack_ptr_t u_stack, struct cds_wfs_node *node)
 	 * uatomic_xchg() implicit memory barrier orders earlier stores
 	 * to node (setting it to NULL) before publication.
 	 */
-	old_head = uatomic_xchg(&s->head, new_head);
+	cmm_emit_legacy_smp_mb();
+	old_head = uatomic_xchg_mo(&s->head, new_head, CMM_SEQ_CST);
 	/*
 	 * At this point, dequeuers see a NULL node->next, they should
 	 * busy-wait until node->next is set to old_head.
 	 */
-	CMM_STORE_SHARED(node->next, &old_head->node);
+	uatomic_store(&node->next, &old_head->node, CMM_RELEASE);
 	return !___cds_wfs_end(old_head);
 }
 
@@ -169,7 +172,7 @@ ___cds_wfs_node_sync_next(struct cds_wfs_node *node, int blocking)
 	/*
 	 * Adaptative busy-looping waiting for push to complete.
 	 */
-	while ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
+	while ((next = uatomic_load(&node->next, CMM_CONSUME)) == NULL) {
 		if (!blocking)
 			return CDS_WFS_WOULDBLOCK;
 		if (++attempt >= CDS_WFS_ADAPT_ATTEMPTS) {
@@ -194,7 +197,7 @@ ___cds_wfs_pop(cds_wfs_stack_ptr_t u_stack, int *state, int blocking)
 	if (state)
 		*state = 0;
 	for (;;) {
-		head = CMM_LOAD_SHARED(s->head);
+		head = uatomic_load(&s->head, CMM_CONSUME);
 		if (___cds_wfs_end(head)) {
 			return NULL;
 		}
@@ -203,9 +206,11 @@ ___cds_wfs_pop(cds_wfs_stack_ptr_t u_stack, int *state, int blocking)
 			return CDS_WFS_WOULDBLOCK;
 		}
 		new_head = caa_container_of(next, struct cds_wfs_head, node);
-		if (uatomic_cmpxchg(&s->head, head, new_head) == head) {
+		if (uatomic_cmpxchg_mo(&s->head, head, new_head,
+					CMM_SEQ_CST, CMM_SEQ_CST) == head) {
 			if (state && ___cds_wfs_end(new_head))
 				*state |= CDS_WFS_STATE_LAST;
+			cmm_emit_legacy_smp_mb();
 			return &head->node;
 		}
 		if (!blocking) {
@@ -220,6 +225,8 @@ ___cds_wfs_pop(cds_wfs_stack_ptr_t u_stack, int *state, int blocking)
  *
  * Returns NULL if stack is empty.
  *
+ * Operations after pop push are consistent when observed before associated push.
+ *
  * __cds_wfs_pop_blocking needs to be synchronized using one of the
  * following techniques:
  *
@@ -278,6 +285,8 @@ ___cds_wfs_pop_nonblocking(cds_wfs_stack_ptr_t u_stack)
 /*
  * __cds_wfs_pop_all: pop all nodes from a stack.
  *
+ * Operations after pop push are consistent when observed before associated push.
+ *
  * __cds_wfs_pop_all does not require any synchronization with other
  * push, nor with other __cds_wfs_pop_all, but requires synchronization
  * matching the technique used to synchronize __cds_wfs_pop_blocking:
@@ -309,7 +318,8 @@ ___cds_wfs_pop_all(cds_wfs_stack_ptr_t u_stack)
 	 * taking care to order writes to each node prior to the full
 	 * memory barrier after this uatomic_xchg().
 	 */
-	head = uatomic_xchg(&s->head, CDS_WFS_END);
+	head = uatomic_xchg_mo(&s->head, CDS_WFS_END, CMM_SEQ_CST);
+	cmm_emit_legacy_smp_mb();
 	if (___cds_wfs_end(head))
 		return NULL;
 	return head;
-- 
2.40.1

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
