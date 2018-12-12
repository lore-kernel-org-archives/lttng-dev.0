From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH urcu 1/3] Port: no symbols aliases on MacOS
Date: Wed, 12 Dec 2018 15:01:37 -0500
Message-ID: <20181212200139.19046-1-mjeanson__31001.2262817056$1544644800$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43FSPw2fxvz175V
 for <lttng-dev@lists.lttng.org>; Wed, 12 Dec 2018 15:01:56 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 1E7FCA33FF
 for <lttng-dev@lists.lttng.org>; Wed, 12 Dec 2018 15:01:55 -0500 (EST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com
List-Id: lttng-dev@lists.lttng.org

There is no equivalent to symbols aliases on MacOS, this will
unfortunatly break the ABI for SONAME(6) and will require a rebuild of
client applications.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 include/urcu/flavor.h    |  4 ++++
 src/urcu-bp.c            | 29 +++++++++++++++--------------
 src/urcu-call-rcu-impl.h | 38 +++++++++++++++++++-------------------
 src/urcu-defer-impl.h    | 12 ++++++------
 src/urcu-qsbr.c          | 25 +++++++++++++------------
 src/urcu-utils.h         |  7 +++++++
 src/urcu.c               | 26 +++++++++++++-------------
 7 files changed, 77 insertions(+), 64 deletions(-)

diff --git a/include/urcu/flavor.h b/include/urcu/flavor.h
index d2d19f6..93da38f 100644
--- a/include/urcu/flavor.h
+++ b/include/urcu/flavor.h
@@ -79,9 +79,13 @@ const struct rcu_flavor_struct x = {			\
 }
 
 #define DEFINE_RCU_FLAVOR_ALIAS(x, y) _DEFINE_RCU_FLAVOR_ALIAS(x, y)
+#ifdef __APPLE__
+#define _DEFINE_RCU_FLAVOR_ALIAS(x, y)
+#else
 #define _DEFINE_RCU_FLAVOR_ALIAS(x, y)			\
 __attribute__((alias(#x)))				\
 extern const struct rcu_flavor_struct y;
+#endif
 
 extern const struct rcu_flavor_struct rcu_flavor;
 
diff --git a/src/urcu-bp.c b/src/urcu-bp.c
index 66c877a..0653f9d 100644
--- a/src/urcu-bp.c
+++ b/src/urcu-bp.c
@@ -44,6 +44,7 @@
 #include <urcu/tls-compat.h>
 
 #include "urcu-die.h"
+#include "urcu-utils.h"
 
 #define URCU_API_MAP
 /* Do not #define _LGPL_SOURCE to ensure we can emit the wrapper symbols */
@@ -143,14 +144,14 @@ static int initialized;
 static pthread_key_t urcu_bp_key;
 
 struct urcu_bp_gp urcu_bp_gp = { .ctr = URCU_BP_GP_COUNT };
-__attribute__((alias("urcu_bp_gp"))) extern struct urcu_bp_gp rcu_gp_bp;
+URCU_ATTR_ALIAS("urcu_bp_gp") extern struct urcu_bp_gp rcu_gp_bp;
 
 /*
  * Pointer to registry elements. Written to only by each individual reader. Read
  * by both the reader and the writers.
  */
 DEFINE_URCU_TLS(struct urcu_bp_reader *, urcu_bp_reader);
-__attribute__((alias("urcu_bp_reader")))
+URCU_ATTR_ALIAS("urcu_bp_reader")
 extern struct urcu_bp_reader *rcu_reader_bp;
 
 static CDS_LIST_HEAD(registry);
@@ -345,7 +346,7 @@ out:
 	ret = pthread_sigmask(SIG_SETMASK, &oldmask, NULL);
 	assert(!ret);
 }
-__attribute__((alias("urcu_bp_synchronize_rcu"))) void synchronize_rcu_bp();
+URCU_ATTR_ALIAS("urcu_bp_synchronize_rcu") void synchronize_rcu_bp();
 
 /*
  * library wrappers to be used by non-LGPL compatible source code.
@@ -355,19 +356,19 @@ void urcu_bp_read_lock(void)
 {
 	_urcu_bp_read_lock();
 }
-__attribute__((alias("urcu_bp_read_lock"))) void rcu_read_lock_bp();
+URCU_ATTR_ALIAS("urcu_bp_read_lock") void rcu_read_lock_bp();
 
 void urcu_bp_read_unlock(void)
 {
 	_urcu_bp_read_unlock();
 }
-__attribute__((alias("urcu_bp_read_unlock"))) void rcu_read_unlock_bp();
+URCU_ATTR_ALIAS("urcu_bp_read_unlock") void rcu_read_unlock_bp();
 
 int urcu_bp_read_ongoing(void)
 {
 	return _urcu_bp_read_ongoing();
 }
-__attribute__((alias("urcu_bp_read_ongoing"))) int rcu_read_ongoing_bp();
+URCU_ATTR_ALIAS("urcu_bp_read_ongoing") int rcu_read_ongoing_bp();
 
 /*
  * Only grow for now. If empty, allocate a ARENA_INIT_ALLOC sized chunk.
@@ -563,7 +564,7 @@ end:
 	if (ret)
 		abort();
 }
-__attribute__((alias("urcu_bp_register"))) void rcu_bp_register();
+URCU_ATTR_ALIAS("urcu_bp_register") void rcu_bp_register();
 
 /* Disable signals, take mutex, remove from registry */
 static
@@ -689,7 +690,7 @@ void urcu_bp_before_fork(void)
 	mutex_lock(&rcu_registry_lock);
 	saved_fork_signal_mask = oldmask;
 }
-__attribute__((alias("urcu_bp_before_fork"))) void rcu_bp_before_fork();
+URCU_ATTR_ALIAS("urcu_bp_before_fork") void rcu_bp_before_fork();
 
 void urcu_bp_after_fork_parent(void)
 {
@@ -702,7 +703,7 @@ void urcu_bp_after_fork_parent(void)
 	ret = pthread_sigmask(SIG_SETMASK, &oldmask, NULL);
 	assert(!ret);
 }
-__attribute__((alias("urcu_bp_after_fork_parent")))
+URCU_ATTR_ALIAS("urcu_bp_after_fork_parent")
 void rcu_bp_after_fork_parent(void);
 
 /*
@@ -740,14 +741,14 @@ void urcu_bp_after_fork_child(void)
 	ret = pthread_sigmask(SIG_SETMASK, &oldmask, NULL);
 	assert(!ret);
 }
-__attribute__((alias("urcu_bp_after_fork_child")))
+URCU_ATTR_ALIAS("urcu_bp_after_fork_child")
 void rcu_bp_after_fork_child(void);
 
 void *urcu_bp_dereference_sym(void *p)
 {
 	return _rcu_dereference(p);
 }
-__attribute__((alias("urcu_bp_dereference_sym")))
+URCU_ATTR_ALIAS("urcu_bp_dereference_sym")
 void *rcu_dereference_sym_bp();
 
 void *urcu_bp_set_pointer_sym(void **p, void *v)
@@ -756,7 +757,7 @@ void *urcu_bp_set_pointer_sym(void **p, void *v)
 	uatomic_set(p, v);
 	return v;
 }
-__attribute__((alias("urcu_bp_set_pointer_sym")))
+URCU_ATTR_ALIAS("urcu_bp_set_pointer_sym")
 void *rcu_set_pointer_sym_bp();
 
 void *urcu_bp_xchg_pointer_sym(void **p, void *v)
@@ -764,7 +765,7 @@ void *urcu_bp_xchg_pointer_sym(void **p, void *v)
 	cmm_wmb();
 	return uatomic_xchg(p, v);
 }
-__attribute__((alias("urcu_bp_xchg_pointer_sym")))
+URCU_ATTR_ALIAS("urcu_bp_xchg_pointer_sym")
 void *rcu_xchg_pointer_sym_bp();
 
 void *urcu_bp_cmpxchg_pointer_sym(void **p, void *old, void *_new)
@@ -772,7 +773,7 @@ void *urcu_bp_cmpxchg_pointer_sym(void **p, void *old, void *_new)
 	cmm_wmb();
 	return uatomic_cmpxchg(p, old, _new);
 }
-__attribute__((alias("urcu_bp_cmpxchg_pointer_sym")))
+URCU_ATTR_ALIAS("urcu_bp_cmpxchg_pointer_sym")
 void *rcu_cmpxchg_pointer_sym_bp();
 
 DEFINE_RCU_FLAVOR(rcu_flavor);
diff --git a/src/urcu-call-rcu-impl.h b/src/urcu-call-rcu-impl.h
index f7844cc..b6ec6ba 100644
--- a/src/urcu-call-rcu-impl.h
+++ b/src/urcu-call-rcu-impl.h
@@ -465,7 +465,7 @@ struct call_rcu_data *get_cpu_call_rcu_data(int cpu)
 		return NULL;
 	return rcu_dereference(pcpu_crdp[cpu]);
 }
-__attribute__((alias(urcu_stringify(get_cpu_call_rcu_data))))
+URCU_ATTR_ALIAS(urcu_stringify(get_cpu_call_rcu_data))
 struct call_rcu_data *alias_get_cpu_call_rcu_data();
 
 /*
@@ -477,7 +477,7 @@ pthread_t get_call_rcu_thread(struct call_rcu_data *crdp)
 {
 	return crdp->tid;
 }
-__attribute__((alias(urcu_stringify(get_call_rcu_thread))))
+URCU_ATTR_ALIAS(urcu_stringify(get_call_rcu_thread))
 pthread_t alias_get_call_rcu_thread();
 
 /*
@@ -493,7 +493,7 @@ static struct call_rcu_data *__create_call_rcu_data(unsigned long flags,
 	return crdp;
 }
 
-__attribute__((alias(urcu_stringify(create_call_rcu_data))))
+URCU_ATTR_ALIAS(urcu_stringify(create_call_rcu_data))
 struct call_rcu_data *alias_create_call_rcu_data();
 struct call_rcu_data *create_call_rcu_data(unsigned long flags,
 					   int cpu_affinity)
@@ -551,7 +551,7 @@ int set_cpu_call_rcu_data(int cpu, struct call_rcu_data *crdp)
 	call_rcu_unlock(&call_rcu_mutex);
 	return 0;
 }
-__attribute__((alias(urcu_stringify(set_cpu_call_rcu_data))))
+URCU_ATTR_ALIAS(urcu_stringify(set_cpu_call_rcu_data))
 int alias_set_cpu_call_rcu_data();
 
 /*
@@ -573,7 +573,7 @@ struct call_rcu_data *get_default_call_rcu_data(void)
 	call_rcu_unlock(&call_rcu_mutex);
 	return default_call_rcu_data;
 }
-__attribute__((alias(urcu_stringify(get_default_call_rcu_data))))
+URCU_ATTR_ALIAS(urcu_stringify(get_default_call_rcu_data))
 struct call_rcu_data *alias_get_default_call_rcu_data();
 
 /*
@@ -602,7 +602,7 @@ struct call_rcu_data *get_call_rcu_data(void)
 
 	return get_default_call_rcu_data();
 }
-__attribute__((alias(urcu_stringify(get_call_rcu_data))))
+URCU_ATTR_ALIAS(urcu_stringify(get_call_rcu_data))
 struct call_rcu_data *alias_get_call_rcu_data();
 
 /*
@@ -613,7 +613,7 @@ struct call_rcu_data *get_thread_call_rcu_data(void)
 {
 	return URCU_TLS(thread_call_rcu_data);
 }
-__attribute__((alias(urcu_stringify(get_thread_call_rcu_data))))
+URCU_ATTR_ALIAS(urcu_stringify(get_thread_call_rcu_data))
 struct call_rcu_data *alias_get_thread_call_rcu_data();
 
 /*
@@ -631,7 +631,7 @@ void set_thread_call_rcu_data(struct call_rcu_data *crdp)
 {
 	URCU_TLS(thread_call_rcu_data) = crdp;
 }
-__attribute__((alias(urcu_stringify(set_thread_call_rcu_data))))
+URCU_ATTR_ALIAS(urcu_stringify(set_thread_call_rcu_data))
 void alias_set_thread_call_rcu_data();
 
 /*
@@ -684,7 +684,7 @@ int create_all_cpu_call_rcu_data(unsigned long flags)
 	}
 	return 0;
 }
-__attribute__((alias(urcu_stringify(create_all_cpu_call_rcu_data))))
+URCU_ATTR_ALIAS(urcu_stringify(create_all_cpu_call_rcu_data))
 int alias_create_all_cpu_call_rcu_data();
 
 /*
@@ -733,7 +733,7 @@ void call_rcu(struct rcu_head *head,
 	_call_rcu(head, func, crdp);
 	_rcu_read_unlock();
 }
-__attribute__((alias(urcu_stringify(call_rcu)))) void alias_call_rcu();
+URCU_ATTR_ALIAS(urcu_stringify(call_rcu)) void alias_call_rcu();
 
 /*
  * Free up the specified call_rcu_data structure, terminating the
@@ -789,7 +789,7 @@ void call_rcu_data_free(struct call_rcu_data *crdp)
 
 	free(crdp);
 }
-__attribute__((alias(urcu_stringify(call_rcu_data_free))))
+URCU_ATTR_ALIAS(urcu_stringify(call_rcu_data_free))
 void alias_call_rcu_data_free();
 
 /*
@@ -834,11 +834,11 @@ void free_all_cpu_call_rcu_data(void)
 #ifdef RCU_QSBR
 /* ABI6 has a non-namespaced free_all_cpu_call_rcu_data for qsbr */
 #undef free_all_cpu_call_rcu_data
-__attribute__((alias("urcu_qsbr_free_all_cpu_call_rcu_data")))
+URCU_ATTR_ALIAS("urcu_qsbr_free_all_cpu_call_rcu_data")
 void free_all_cpu_call_rcu_data();
 #define free_all_cpu_call_rcu_data urcu_qsbr_free_all_cpu_call_rcu_data
 #else
-__attribute__((alias(urcu_stringify(free_all_cpu_call_rcu_data))))
+URCU_ATTR_ALIAS(urcu_stringify(free_all_cpu_call_rcu_data))
 void alias_free_all_cpu_call_rcu_data();
 #endif
 
@@ -932,7 +932,7 @@ online:
 	if (was_online)
 		rcu_thread_online();
 }
-__attribute__((alias(urcu_stringify(rcu_barrier))))
+URCU_ATTR_ALIAS(urcu_stringify(rcu_barrier))
 void alias_rcu_barrier();
 
 /*
@@ -962,7 +962,7 @@ void call_rcu_before_fork(void)
 			(void) poll(NULL, 0, 1);
 	}
 }
-__attribute__((alias(urcu_stringify(call_rcu_before_fork))))
+URCU_ATTR_ALIAS(urcu_stringify(call_rcu_before_fork))
 void alias_call_rcu_before_fork();
 
 /*
@@ -986,7 +986,7 @@ void call_rcu_after_fork_parent(void)
 		atfork->after_fork_parent(atfork->priv);
 	call_rcu_unlock(&call_rcu_mutex);
 }
-__attribute__((alias(urcu_stringify(call_rcu_after_fork_parent))))
+URCU_ATTR_ALIAS(urcu_stringify(call_rcu_after_fork_parent))
 void alias_call_rcu_after_fork_parent();
 
 /*
@@ -1035,7 +1035,7 @@ void call_rcu_after_fork_child(void)
 		call_rcu_data_free(crdp);
 	}
 }
-__attribute__((alias(urcu_stringify(call_rcu_after_fork_child))))
+URCU_ATTR_ALIAS(urcu_stringify(call_rcu_after_fork_child))
 void alias_call_rcu_after_fork_child();
 
 void urcu_register_rculfhash_atfork(struct urcu_atfork *atfork)
@@ -1047,7 +1047,7 @@ void urcu_register_rculfhash_atfork(struct urcu_atfork *atfork)
 end:
 	call_rcu_unlock(&call_rcu_mutex);
 }
-__attribute__((alias(urcu_stringify(urcu_register_rculfhash_atfork))))
+URCU_ATTR_ALIAS(urcu_stringify(urcu_register_rculfhash_atfork))
 void alias_urcu_register_rculfhash_atfork();
 
 void urcu_unregister_rculfhash_atfork(struct urcu_atfork *atfork)
@@ -1059,5 +1059,5 @@ void urcu_unregister_rculfhash_atfork(struct urcu_atfork *atfork)
 end:
 	call_rcu_unlock(&call_rcu_mutex);
 }
-__attribute__((alias(urcu_stringify(urcu_unregister_rculfhash_atfork))))
+URCU_ATTR_ALIAS(urcu_stringify(urcu_unregister_rculfhash_atfork))
 void alias_urcu_unregister_rculfhash_atfork();
diff --git a/src/urcu-defer-impl.h b/src/urcu-defer-impl.h
index 58ca1ab..b34a1a1 100644
--- a/src/urcu-defer-impl.h
+++ b/src/urcu-defer-impl.h
@@ -265,7 +265,7 @@ void rcu_defer_barrier_thread(void)
 	_rcu_defer_barrier_thread();
 	mutex_unlock(&rcu_defer_mutex);
 }
-__attribute__((alias(urcu_stringify(rcu_defer_barrier_thread))))
+URCU_ATTR_ALIAS(urcu_stringify(rcu_defer_barrier_thread))
 void alias_rcu_defer_barrier_thread();
 
 /*
@@ -307,7 +307,7 @@ void rcu_defer_barrier(void)
 end:
 	mutex_unlock(&rcu_defer_mutex);
 }
-__attribute__((alias(urcu_stringify(rcu_defer_barrier))))
+URCU_ATTR_ALIAS(urcu_stringify(rcu_defer_barrier))
 void alias_rcu_defer_barrier();
 
 /*
@@ -401,7 +401,7 @@ void defer_rcu(void (*fct)(void *p), void *p)
 {
 	_defer_rcu(fct, p);
 }
-__attribute__((alias(urcu_stringify(defer_rcu)))) void alias_defer_rcu();
+URCU_ATTR_ALIAS(urcu_stringify(defer_rcu)) void alias_defer_rcu();
 
 static void start_defer_thread(void)
 {
@@ -450,7 +450,7 @@ int rcu_defer_register_thread(void)
 	mutex_unlock(&defer_thread_mutex);
 	return 0;
 }
-__attribute__((alias(urcu_stringify(rcu_defer_register_thread))))
+URCU_ATTR_ALIAS(urcu_stringify(rcu_defer_register_thread))
 int alias_rcu_defer_register_thread();
 
 void rcu_defer_unregister_thread(void)
@@ -470,14 +470,14 @@ void rcu_defer_unregister_thread(void)
 		stop_defer_thread();
 	mutex_unlock(&defer_thread_mutex);
 }
-__attribute__((alias(urcu_stringify(rcu_defer_unregister_thread))))
+URCU_ATTR_ALIAS(urcu_stringify(rcu_defer_unregister_thread))
 void alias_rcu_defer_unregister_thread();
 
 void rcu_defer_exit(void)
 {
 	assert(cds_list_empty(&registry_defer));
 }
-__attribute__((alias(urcu_stringify(rcu_defer_exit))))
+URCU_ATTR_ALIAS(urcu_stringify(rcu_defer_exit))
 void alias_rcu_defer_exit();
 
 #endif /* _URCU_DEFER_IMPL_H */
diff --git a/src/urcu-qsbr.c b/src/urcu-qsbr.c
index 346748b..6ff933a 100644
--- a/src/urcu-qsbr.c
+++ b/src/urcu-qsbr.c
@@ -43,6 +43,7 @@
 
 #include "urcu-die.h"
 #include "urcu-wait.h"
+#include "urcu-utils.h"
 
 #define URCU_API_MAP
 /* Do not #define _LGPL_SOURCE to ensure we can emit the wrapper symbols */
@@ -68,7 +69,7 @@ static pthread_mutex_t rcu_gp_lock = PTHREAD_MUTEX_INITIALIZER;
  */
 static pthread_mutex_t rcu_registry_lock = PTHREAD_MUTEX_INITIALIZER;
 struct urcu_gp urcu_qsbr_gp = { .ctr = URCU_QSBR_GP_ONLINE };
-__attribute__((alias("urcu_qsbr_gp"))) extern struct urcu_gp rcu_gp_qsbr;
+URCU_ATTR_ALIAS("urcu_qsbr_gp") extern struct urcu_gp rcu_gp_qsbr;
 
 /*
  * Active attempts to check for reader Q.S. before calling futex().
@@ -80,7 +81,7 @@ __attribute__((alias("urcu_qsbr_gp"))) extern struct urcu_gp rcu_gp_qsbr;
  * writers.
  */
 DEFINE_URCU_TLS(struct urcu_qsbr_reader, urcu_qsbr_reader);
-__attribute__((alias("urcu_qsbr_reader")))
+URCU_ATTR_ALIAS("urcu_qsbr_reader")
 extern struct urcu_qsbr_reader rcu_reader_qsbr;
 
 static CDS_LIST_HEAD(registry);
@@ -430,7 +431,7 @@ gp_end:
 		cmm_smp_mb();
 }
 #endif  /* !(CAA_BITS_PER_LONG < 64) */
-__attribute__((alias("urcu_qsbr_synchronize_rcu")))
+URCU_ATTR_ALIAS("urcu_qsbr_synchronize_rcu")
 void synchronize_rcu_qsbr();
 
 /*
@@ -441,40 +442,40 @@ void urcu_qsbr_read_lock(void)
 {
 	_urcu_qsbr_read_lock();
 }
-__attribute__((alias("urcu_qsbr_read_lock"))) void rcu_read_lock_qsbr();
+URCU_ATTR_ALIAS("urcu_qsbr_read_lock") void rcu_read_lock_qsbr();
 
 void urcu_qsbr_read_unlock(void)
 {
 	_urcu_qsbr_read_unlock();
 }
-__attribute__((alias("urcu_qsbr_read_unlock"))) void rcu_read_unlock_qsbr();
+URCU_ATTR_ALIAS("urcu_qsbr_read_unlock") void rcu_read_unlock_qsbr();
 
 int urcu_qsbr_read_ongoing(void)
 {
 	return _urcu_qsbr_read_ongoing();
 }
-__attribute__((alias("urcu_qsbr_read_ongoing")))
+URCU_ATTR_ALIAS("urcu_qsbr_read_ongoing")
 void rcu_read_ongoing_qsbr();
 
 void urcu_qsbr_quiescent_state(void)
 {
 	_urcu_qsbr_quiescent_state();
 }
-__attribute__((alias("urcu_qsbr_quiescent_state")))
+URCU_ATTR_ALIAS("urcu_qsbr_quiescent_state")
 void rcu_quiescent_state_qsbr();
 
 void urcu_qsbr_thread_offline(void)
 {
 	_urcu_qsbr_thread_offline();
 }
-__attribute__((alias("urcu_qsbr_thread_offline")))
+URCU_ATTR_ALIAS("urcu_qsbr_thread_offline")
 void rcu_thread_offline_qsbr();
 
 void urcu_qsbr_thread_online(void)
 {
 	_urcu_qsbr_thread_online();
 }
-__attribute__((alias("urcu_qsbr_thread_online")))
+URCU_ATTR_ALIAS("urcu_qsbr_thread_online")
 void rcu_thread_online_qsbr();
 
 void urcu_qsbr_register_thread(void)
@@ -489,7 +490,7 @@ void urcu_qsbr_register_thread(void)
 	mutex_unlock(&rcu_registry_lock);
 	_urcu_qsbr_thread_online();
 }
-__attribute__((alias("urcu_qsbr_register_thread")))
+URCU_ATTR_ALIAS("urcu_qsbr_register_thread")
 void rcu_register_thread_qsbr();
 
 void urcu_qsbr_unregister_thread(void)
@@ -505,7 +506,7 @@ void urcu_qsbr_unregister_thread(void)
 	cds_list_del(&URCU_TLS(urcu_qsbr_reader).node);
 	mutex_unlock(&rcu_registry_lock);
 }
-__attribute__((alias("urcu_qsbr_unregister_thread")))
+URCU_ATTR_ALIAS("urcu_qsbr_unregister_thread")
 void rcu_unregister_thread_qsbr();
 
 void urcu_qsbr_exit(void)
@@ -516,7 +517,7 @@ void urcu_qsbr_exit(void)
 	 * assert(cds_list_empty(&registry));
 	 */
 }
-__attribute__((alias("urcu_qsbr_exit"))) void rcu_exit_qsbr();
+URCU_ATTR_ALIAS("urcu_qsbr_exit") void rcu_exit_qsbr();
 
 DEFINE_RCU_FLAVOR(rcu_flavor);
 DEFINE_RCU_FLAVOR_ALIAS(rcu_flavor, alias_rcu_flavor);
diff --git a/src/urcu-utils.h b/src/urcu-utils.h
index 1d91bc9..3c3c7a1 100644
--- a/src/urcu-utils.h
+++ b/src/urcu-utils.h
@@ -26,4 +26,11 @@
 #define urcu_stringify(a) _urcu_stringify(a)
 #define _urcu_stringify(a) #a
 
+/* There is no concept of symbol aliases on MacOS */
+#ifdef __APPLE__
+#define URCU_ATTR_ALIAS(x)
+#else
+#define URCU_ATTR_ALIAS(x) __attribute__((alias(x)))
+#endif
+
 #endif /* _URCU_UTILS_H */
diff --git a/src/urcu.c b/src/urcu.c
index c36119a..c4e2dde 100644
--- a/src/urcu.c
+++ b/src/urcu.c
@@ -92,7 +92,7 @@ static int urcu_memb_has_sys_membarrier_private_expedited;
  * uninitialized variable.
  */
 int urcu_memb_has_sys_membarrier = 0;
-__attribute__((alias("urcu_memb_has_sys_membarrier")))
+URCU_ATTR_ALIAS("urcu_memb_has_sys_membarrier")
 extern int rcu_has_sys_membarrier_memb;
 #endif
 
@@ -103,7 +103,7 @@ void __attribute__((constructor)) rcu_init(void);
 void rcu_init(void)
 {
 }
-__attribute__((alias(urcu_stringify(rcu_init))))
+URCU_ATTR_ALIAS(urcu_stringify(rcu_init))
 void alias_rcu_init(void);
 #endif
 
@@ -130,7 +130,7 @@ static pthread_mutex_t rcu_gp_lock = PTHREAD_MUTEX_INITIALIZER;
  */
 static pthread_mutex_t rcu_registry_lock = PTHREAD_MUTEX_INITIALIZER;
 struct urcu_gp rcu_gp = { .ctr = URCU_GP_COUNT };
-__attribute__((alias(urcu_stringify(rcu_gp))))
+URCU_ATTR_ALIAS(urcu_stringify(rcu_gp))
 extern struct urcu_gp alias_rcu_gp;
 
 /*
@@ -138,7 +138,7 @@ extern struct urcu_gp alias_rcu_gp;
  * writers.
  */
 DEFINE_URCU_TLS(struct urcu_reader, rcu_reader);
-__attribute__((alias(urcu_stringify(rcu_reader))))
+URCU_ATTR_ALIAS(urcu_stringify(rcu_reader))
 extern struct urcu_reader alias_rcu_reader;
 
 static CDS_LIST_HEAD(registry);
@@ -515,7 +515,7 @@ out:
 	 */
 	urcu_wake_all_waiters(&waiters);
 }
-__attribute__((alias(urcu_stringify(synchronize_rcu))))
+URCU_ATTR_ALIAS(urcu_stringify(synchronize_rcu))
 void alias_synchronize_rcu();
 
 /*
@@ -526,21 +526,21 @@ void rcu_read_lock(void)
 {
 	_rcu_read_lock();
 }
-__attribute__((alias(urcu_stringify(rcu_read_lock))))
+URCU_ATTR_ALIAS(urcu_stringify(rcu_read_lock))
 void alias_rcu_read_lock();
 
 void rcu_read_unlock(void)
 {
 	_rcu_read_unlock();
 }
-__attribute__((alias(urcu_stringify(rcu_read_unlock))))
+URCU_ATTR_ALIAS(urcu_stringify(rcu_read_unlock))
 void alias_rcu_read_unlock();
 
 int rcu_read_ongoing(void)
 {
 	return _rcu_read_ongoing();
 }
-__attribute__((alias(urcu_stringify(rcu_read_ongoing))))
+URCU_ATTR_ALIAS(urcu_stringify(rcu_read_ongoing))
 void alias_rcu_read_ongoing();
 
 void rcu_register_thread(void)
@@ -556,7 +556,7 @@ void rcu_register_thread(void)
 	cds_list_add(&URCU_TLS(rcu_reader).node, &registry);
 	mutex_unlock(&rcu_registry_lock);
 }
-__attribute__((alias(urcu_stringify(rcu_register_thread))))
+URCU_ATTR_ALIAS(urcu_stringify(rcu_register_thread))
 void alias_rcu_register_thread();
 
 void rcu_unregister_thread(void)
@@ -567,7 +567,7 @@ void rcu_unregister_thread(void)
 	cds_list_del(&URCU_TLS(rcu_reader).node);
 	mutex_unlock(&rcu_registry_lock);
 }
-__attribute__((alias(urcu_stringify(rcu_unregister_thread))))
+URCU_ATTR_ALIAS(urcu_stringify(rcu_unregister_thread))
 void alias_rcu_unregister_thread();
 
 #ifdef RCU_MEMBARRIER
@@ -616,7 +616,7 @@ void rcu_init(void)
 	init_done = 1;
 	rcu_sys_membarrier_init();
 }
-__attribute__((alias(urcu_stringify(rcu_init))))
+URCU_ATTR_ALIAS(urcu_stringify(rcu_init))
 void alias_rcu_init(void);
 #endif
 
@@ -657,7 +657,7 @@ void rcu_init(void)
 	if (ret)
 		urcu_die(errno);
 }
-__attribute__((alias(urcu_stringify(rcu_init))))
+URCU_ATTR_ALIAS(urcu_stringify(rcu_init))
 void alias_rcu_init(void);
 
 void rcu_exit(void)
@@ -671,7 +671,7 @@ void rcu_exit(void)
 	 * assert(cds_list_empty(&registry));
 	 */
 }
-__attribute__((alias(urcu_stringify(rcu_exit))))
+URCU_ATTR_ALIAS(urcu_stringify(rcu_exit))
 void alias_rcu_exit(void);
 
 #endif /* #ifdef RCU_SIGNAL */
-- 
2.17.1
