From: Michael Jeanson <mjeanson@efficios.com>
Subject: [PATCH urcu v2] Add multiflavor compat identifiers
Date: Mon, 28 Jan 2019 11:56:02 -0500
Message-ID: <20190128165602.19995-1-mjeanson__41777.8729739197$1548694590$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 43pG3x4r63znDb
 for <lttng-dev@lists.lttng.org>; Mon, 28 Jan 2019 11:56:13 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 77F6EB7124
 for <lttng-dev@lists.lttng.org>; Mon, 28 Jan 2019 11:56:07 -0500 (EST)
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

This will maintain buildtime compatibility with softwares like lttng-ust
that used the prior undocumented multiflavor API.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 include/urcu/map/urcu-bp.h     | 63 ++++++++++++++++++++++++++++++++++
 include/urcu/map/urcu-mb.h     | 60 ++++++++++++++++++++++++++++++++
 include/urcu/map/urcu-memb.h   | 62 +++++++++++++++++++++++++++++++++
 include/urcu/map/urcu-qsbr.h   | 62 +++++++++++++++++++++++++++++++++
 include/urcu/map/urcu-signal.h | 62 +++++++++++++++++++++++++++++++++
 src/urcu-bp.c                  |  1 +
 src/urcu-qsbr.c                |  1 +
 src/urcu.c                     |  1 +
 8 files changed, 312 insertions(+)

diff --git a/include/urcu/map/urcu-bp.h b/include/urcu/map/urcu-bp.h
index ed73ab2..a80005f 100644
--- a/include/urcu/map/urcu-bp.h
+++ b/include/urcu/map/urcu-bp.h
@@ -120,3 +120,66 @@
 		urcu_register_rculfhash_atfork_bp
 #define alias_urcu_unregister_rculfhash_atfork	\
 		urcu_unregister_rculfhash_atfork_bp
+
+
+/* Compat identifiers for prior undocumented multiflavor usage */
+#ifndef URCU_NO_COMPAT_IDENTIFIERS
+
+#define rcu_dereference_bp		urcu_bp_dereference
+#define rcu_cmpxchg_pointer_bp		urcu_bp_cmpxchg_pointer
+#define rcu_xchg_pointer_bp		urcu_bp_xchg_pointer
+#define rcu_set_pointer_bp		urcu_bp_set_pointer
+
+#define rcu_bp_before_fork		urcu_bp_before_fork
+#define rcu_bp_after_fork_parent	urcu_bp_after_fork_parent
+#define rcu_bp_after_fork_child		urcu_bp_after_fork_child
+
+#define rcu_read_lock_bp		urcu_bp_read_lock
+#define _rcu_read_lock_bp		_urcu_bp_read_lock
+#define rcu_read_unlock_bp		urcu_bp_read_unlock
+#define _rcu_read_unlock_bp		_urcu_bp_read_unlock
+#define rcu_read_ongoing_bp		urcu_bp_read_ongoing
+#define _rcu_read_ongoing_bp		_urcu_bp_read_ongoing
+#define rcu_register_thread_bp		urcu_bp_register_thread
+#define rcu_unregister_thread_bp	urcu_bp_unregister_thread
+#define rcu_init_bp			urcu_bp_init
+#define rcu_exit_bp			urcu_bp_exit
+#define synchronize_rcu_bp		urcu_bp_synchronize_rcu
+#define rcu_reader_bp			urcu_bp_reader
+#define rcu_gp_bp			urcu_bp_gp
+
+#define get_cpu_call_rcu_data_bp	urcu_bp_get_cpu_call_rcu_data
+#define get_call_rcu_thread_bp		urcu_bp_get_call_rcu_thread
+#define create_call_rcu_data_bp		urcu_bp_create_call_rcu_data
+#define set_cpu_call_rcu_data_bp	urcu_bp_set_cpu_call_rcu_data
+#define get_default_call_rcu_data_bp	urcu_bp_get_default_call_rcu_data
+#define get_call_rcu_data_bp		urcu_bp_get_call_rcu_data
+#define get_thread_call_rcu_data_bp	urcu_bp_get_thread_call_rcu_data
+#define set_thread_call_rcu_data_bp	urcu_bp_set_thread_call_rcu_data
+#define create_all_cpu_call_rcu_data_bp	urcu_bp_create_all_cpu_call_rcu_data
+#define free_all_cpu_call_rcu_data_bp	urcu_bp_free_all_cpu_call_rcu_data
+#define call_rcu_bp			urcu_bp_call_rcu
+#define call_rcu_data_free_bp		urcu_bp_call_rcu_data_free
+#define call_rcu_before_fork_bp		urcu_bp_call_rcu_before_fork
+#define call_rcu_after_fork_parent_bp	urcu_bp_call_rcu_after_fork_parent
+#define call_rcu_after_fork_child_bp	urcu_bp_call_rcu_after_fork_child
+#define rcu_barrier_bp			urcu_bp_barrier
+
+#define defer_rcu_bp			urcu_bp_defer_rcu
+#define rcu_defer_register_thread_bp	urcu_bp_defer_register_thread
+#define rcu_defer_unregister_thread_bp	urcu_bp_defer_unregister_thread
+#define rcu_defer_barrier_bp		urcu_bp_defer_barrier
+#define rcu_defer_barrier_thread_bp	urcu_bp_defer_barrier_thread
+#define rcu_defer_exit_bp		urcu_bp_defer_exit
+
+#define rcu_flavor_bp			urcu_bp_flavor
+
+#define rcu_yield_active_bp		urcu_bp_yield_active
+#define rcu_rand_yield_bp		urcu_bp_rand_yield
+
+#define urcu_register_rculfhash_atfork_bp	\
+	urcu_bp_register_rculfhash_atfork
+#define urcu_unregister_rculfhash_atfork_bp	\
+	urcu_bp_unregister_rculfhash_atfork
+
+#endif /* URCU_NO_COMPAT_IDENTIFIERS */
diff --git a/include/urcu/map/urcu-mb.h b/include/urcu/map/urcu-mb.h
index fa77a1a..970513a 100644
--- a/include/urcu/map/urcu-mb.h
+++ b/include/urcu/map/urcu-mb.h
@@ -128,3 +128,63 @@
 #define alias_rcu_defer_barrier		rcu_defer_barrier_mb
 #define alias_rcu_defer_barrier_thread	rcu_defer_barrier_thread_mb
 #define alias_rcu_defer_exit		rcu_defer_exit_mb
+
+
+/* Compat identifiers for prior undocumented multiflavor usage */
+#ifndef URCU_NO_COMPAT_IDENTIFIERS
+
+#define rcu_dereference_mb		urcu_mb_dereference
+#define rcu_cmpxchg_pointer_mb		urcu_mb_cmpxchg_pointer
+#define rcu_xchg_pointer_mb		urcu_mb_xchg_pointer
+#define rcu_set_pointer_mb		urcu_mb_set_pointer
+
+#define rcu_mb_before_fork		urcu_mb_before_fork
+#define rcu_mb_after_fork_parent	urcu_mb_after_fork_parent
+#define rcu_mb_after_fork_child		urcu_mb_after_fork_child
+
+#define rcu_read_lock_mb		urcu_mb_read_lock
+#define _rcu_read_lock_mb		_urcu_mb_read_lock
+#define rcu_read_unlock_mb		urcu_mb_read_unlock
+#define _rcu_read_unlock_mb		_urcu_mb_read_unlock
+#define rcu_read_ongoing_mb		urcu_mb_read_ongoing
+#define _rcu_read_ongoing_mb		_urcu_mb_read_ongoing
+#define rcu_register_thread_mb		urcu_mb_register_thread
+#define rcu_unregister_thread_mb	urcu_mb_unregister_thread
+#define rcu_init_mb			urcu_mb_init
+#define rcu_exit_mb			urcu_mb_exit
+#define synchronize_rcu_mb		urcu_mb_synchronize_rcu
+#define rcu_reader_mb			urcu_mb_reader
+#define rcu_gp_mb			urcu_mb_gp
+
+#define get_cpu_call_rcu_data_mb	urcu_mb_get_cpu_call_rcu_data
+#define get_call_rcu_thread_mb		urcu_mb_get_call_rcu_thread
+#define create_call_rcu_data_mb		urcu_mb_create_call_rcu_data
+#define set_cpu_call_rcu_data_mb	urcu_mb_set_cpu_call_rcu_data
+#define get_default_call_rcu_data_mb	urcu_mb_get_default_call_rcu_data
+#define get_call_rcu_data_mb		urcu_mb_get_call_rcu_data
+#define get_thread_call_rcu_data_mb	urcu_mb_get_thread_call_rcu_data
+#define set_thread_call_rcu_data_mb	urcu_mb_set_thread_call_rcu_data
+#define create_all_cpu_call_rcu_data_mb	urcu_mb_create_all_cpu_call_rcu_data
+#define free_all_cpu_call_rcu_data_mb	urcu_mb_free_all_cpu_call_rcu_data
+#define call_rcu_mb			urcu_mb_call_rcu
+#define call_rcu_data_free_mb		urcu_mb_call_rcu_data_free
+#define call_rcu_before_fork_mb		urcu_mb_call_rcu_before_fork
+#define call_rcu_after_fork_parent_mb	urcu_mb_call_rcu_after_fork_parent
+#define call_rcu_after_fork_child_mb	urcu_mb_call_rcu_after_fork_child
+#define rcu_barrier_mb			urcu_mb_barrier
+
+#define defer_rcu_mb			urcu_mb_defer_rcu
+#define rcu_defer_register_thread_mb	urcu_mb_defer_register_thread
+#define rcu_defer_unregister_thread_mb	urcu_mb_defer_unregister_thread
+#define rcu_defer_barrier_mb		urcu_mb_defer_barrier
+#define rcu_defer_barrier_thread_mb	urcu_mb_defer_barrier_thread
+#define rcu_defer_exit_mb		urcu_mb_defer_exit
+
+#define rcu_flavor_mb			urcu_mb_flavor
+
+#define urcu_register_rculfhash_atfork_mb	\
+		urcu_mb_register_rculfhash_atfork
+#define urcu_unregister_rculfhash_atfork_mb	\
+		urcu_mb_unregister_rculfhash_atfork
+
+#endif /* URCU_NO_COMPAT_IDENTIFIERS */
diff --git a/include/urcu/map/urcu-memb.h b/include/urcu/map/urcu-memb.h
index 33f9a9b..902bb6f 100644
--- a/include/urcu/map/urcu-memb.h
+++ b/include/urcu/map/urcu-memb.h
@@ -128,3 +128,65 @@
 #define alias_rcu_defer_barrier		rcu_defer_barrier_memb
 #define alias_rcu_defer_barrier_thread	rcu_defer_barrier_thread_memb
 #define alias_rcu_defer_exit		rcu_defer_exit_memb
+
+
+/* Compat identifiers for prior undocumented multiflavor usage */
+#ifndef URCU_NO_COMPAT_IDENTIFIERS
+
+#define rcu_dereference_memb		urcu_memb_dereference
+#define rcu_cmpxchg_pointer_memb	urcu_memb_cmpxchg_pointer
+#define rcu_xchg_pointer_memb		urcu_memb_xchg_pointer
+#define rcu_set_pointer_memb		urcu_memb_set_pointer
+
+#define rcu_memb_before_fork		urcu_memb_before_fork
+#define rcu_memb_after_fork_parent	urcu_memb_after_fork_parent
+#define rcu_memb_after_fork_child	urcu_memb_after_fork_child
+
+#define rcu_read_lock_memb		urcu_memb_read_lock
+#define _rcu_read_lock_memb		_urcu_memb_read_lock
+#define rcu_read_unlock_memb		urcu_memb_read_unlock
+#define _rcu_read_unlock_memb		_urcu_memb_read_unlock
+#define rcu_read_ongoing_memb		urcu_memb_read_ongoing
+#define _rcu_read_ongoing_memb		_urcu_memb_read_ongoing
+#define rcu_register_thread_memb	urcu_memb_register_thread
+#define rcu_unregister_thread_memb	urcu_memb_unregister_thread
+#define rcu_init_memb			urcu_memb_init
+#define rcu_exit_memb			urcu_memb_exit
+#define synchronize_rcu_memb		urcu_memb_synchronize_rcu
+#define rcu_reader_memb			urcu_memb_reader
+#define rcu_gp_memb			urcu_memb_gp
+
+#define get_cpu_call_rcu_data_memb	urcu_memb_get_cpu_call_rcu_data
+#define get_call_rcu_thread_memb	urcu_memb_get_call_rcu_thread
+#define create_call_rcu_data_memb	urcu_memb_create_call_rcu_data
+#define set_cpu_call_rcu_data_memb	urcu_memb_set_cpu_call_rcu_data
+#define get_default_call_rcu_data_memb	urcu_memb_get_default_call_rcu_data
+#define get_call_rcu_data_memb		urcu_memb_get_call_rcu_data
+#define get_thread_call_rcu_data_memb	urcu_memb_get_thread_call_rcu_data
+#define set_thread_call_rcu_data_memb	urcu_memb_set_thread_call_rcu_data
+#define create_all_cpu_call_rcu_data_memb	\
+		urcu_memb_create_all_cpu_call_rcu_data
+#define free_all_cpu_call_rcu_data_memb	urcu_memb_free_all_cpu_call_rcu_data
+#define call_rcu_memb			urcu_memb_call_rcu
+#define call_rcu_data_free_memb		urcu_memb_call_rcu_data_free
+#define call_rcu_before_fork_memb	urcu_memb_call_rcu_before_fork
+#define call_rcu_after_fork_parent_memb	urcu_memb_call_rcu_after_fork_parent
+#define call_rcu_after_fork_child_memb	urcu_memb_call_rcu_after_fork_child
+#define rcu_barrier_memb		urcu_memb_barrier
+
+#define defer_rcu_memb			urcu_memb_defer_rcu
+#define rcu_defer_register_thread_memb	urcu_memb_defer_register_thread
+#define rcu_defer_unregister_thread_memb	\
+		urcu_memb_defer_unregister_thread
+#define rcu_defer_barrier_memb		urcu_memb_defer_barrier
+#define rcu_defer_barrier_thread_memb	urcu_memb_defer_barrier_thread
+#define rcu_defer_exit_memb		urcu_memb_defer_exit
+
+#define rcu_flavor_memb			urcu_memb_flavor
+
+#define urcu_register_rculfhash_atfork_memb	\
+		urcu_memb_register_rculfhash_atfork
+#define urcu_unregister_rculfhash_atfork_memb	\
+		urcu_memb_unregister_rculfhash_atfork
+
+#endif /* URCU_NO_COMPAT_IDENTIFIERS */
diff --git a/include/urcu/map/urcu-qsbr.h b/include/urcu/map/urcu-qsbr.h
index 2b4d861..6486da0 100644
--- a/include/urcu/map/urcu-qsbr.h
+++ b/include/urcu/map/urcu-qsbr.h
@@ -126,3 +126,65 @@
 #define alias_rcu_defer_barrier		rcu_defer_barrier_qsbr
 #define alias_rcu_defer_barrier_thread	rcu_defer_barrier_thread_qsbr
 #define alias_rcu_defer_exit		rcu_defer_exit_qsbr
+
+
+/* Compat identifiers for prior undocumented multiflavor usage */
+#ifndef URCU_NO_COMPAT_IDENTIFIERS
+
+#define rcu_dereference_qsbr		urcu_qsbr_dereference
+#define rcu_cmpxchg_pointer_qsbr	urcu_qsbr_cmpxchg_pointer
+#define rcu_xchg_pointer_qsbr		urcu_qsbr_xchg_pointer
+#define rcu_set_pointer_qsbr		urcu_qsbr_set_pointer
+
+#define rcu_qsbr_before_fork		urcu_qsbr_before_fork
+#define rcu_qsbr_after_fork_parent	urcu_qsbr_after_fork_parent
+#define rcu_qsbr_after_fork_child	urcu_qsbr_after_fork_child
+
+#define rcu_read_lock_qsbr		urcu_qsbr_read_lock
+#define _rcu_read_lock_qsbr		_urcu_qsbr_read_lock
+#define rcu_read_unlock_qsbr		urcu_qsbr_read_unlock
+#define _rcu_read_unlock_qsbr		_urcu_qsbr_read_unlock
+#define rcu_read_ongoing_qsbr		urcu_qsbr_read_ongoing
+#define _rcu_read_ongoing_qsbr		_urcu_qsbr_read_ongoing
+#define rcu_register_thread_qsbr	urcu_qsbr_register_thread
+#define rcu_unregister_thread_qsbr	urcu_qsbr_unregister_thread
+#define rcu_init_qsbr			urcu_qsbr_init
+#define rcu_exit_qsbr			urcu_qsbr_exit
+#define synchronize_rcu_qsbr		urcu_qsbr_synchronize_rcu
+#define rcu_reader_qsbr			urcu_qsbr_reader
+#define rcu_gp_qsbr			urcu_qsbr_gp
+
+#define get_cpu_call_rcu_data_qsbr	urcu_qsbr_get_cpu_call_rcu_data
+#define get_call_rcu_thread_qsbr	urcu_qsbr_get_call_rcu_thread
+#define create_call_rcu_data_qsbr	urcu_qsbr_create_call_rcu_data
+#define set_cpu_call_rcu_data_qsbr	urcu_qsbr_set_cpu_call_rcu_data
+#define get_default_call_rcu_data_qsbr	urcu_qsbr_get_default_call_rcu_data
+#define get_call_rcu_data_qsbr		urcu_qsbr_get_call_rcu_data
+#define get_thread_call_rcu_data_qsbr	urcu_qsbr_get_thread_call_rcu_data
+#define set_thread_call_rcu_data_qsbr	urcu_qsbr_set_thread_call_rcu_data
+#define create_all_cpu_call_rcu_data_qsbr	\
+		urcu_qsbr_create_all_cpu_call_rcu_data
+#define free_all_cpu_call_rcu_data_qsbr	urcu_qsbr_free_all_cpu_call_rcu_data
+#define call_rcu_qsbr			urcu_qsbr_call_rcu
+#define call_rcu_data_free_qsbr		urcu_qsbr_call_rcu_data_free
+#define call_rcu_before_fork_qsbr	urcu_qsbr_call_rcu_before_fork
+#define call_rcu_after_fork_parent_qsbr	urcu_qsbr_call_rcu_after_fork_parent
+#define call_rcu_after_fork_child_qsbr	urcu_qsbr_call_rcu_after_fork_child
+#define rcu_barrier_qsbr		urcu_qsbr_barrier
+
+#define defer_rcu_qsbr			urcu_qsbr_defer_rcu
+#define rcu_defer_register_thread_qsbr	urcu_qsbr_defer_register_thread
+#define rcu_defer_unregister_thread_qsbr	\
+		urcu_qsbr_defer_unregister_thread
+#define rcu_defer_barrier_qsbr		urcu_qsbr_defer_barrier
+#define rcu_defer_barrier_thread_qsbr	urcu_qsbr_defer_barrier_thread
+#define rcu_defer_exit_qsbr		urcu_qsbr_defer_exit
+
+#define rcu_flavor_qsbr			urcu_qsbr_flavor
+
+#define urcu_register_rculfhash_atfork_qsbr	\
+		urcu_qsbr_register_rculfhash_atfork
+#define urcu_unregister_rculfhash_atfork_qsbr	\
+		urcu_qsbr_unregister_rculfhash_atfork
+
+#endif /* URCU_NO_COMPAT_IDENTIFIERS */
diff --git a/include/urcu/map/urcu-signal.h b/include/urcu/map/urcu-signal.h
index 842a14f..3665541 100644
--- a/include/urcu/map/urcu-signal.h
+++ b/include/urcu/map/urcu-signal.h
@@ -129,3 +129,65 @@
 #define alias_rcu_defer_barrier		rcu_defer_barrier_sig
 #define alias_rcu_defer_barrier_thread	rcu_defer_barrier_thread_sig
 #define alias_rcu_defer_exit		rcu_defer_exit_sig
+
+
+/* Compat identifiers for prior undocumented multiflavor usage */
+#ifndef URCU_NO_COMPAT_IDENTIFIERS
+
+#define rcu_dereference_sig		urcu_signal_dereference
+#define rcu_cmpxchg_pointer_sig		urcu_signal_cmpxchg_pointer
+#define rcu_xchg_pointer_sig		urcu_signal_xchg_pointer
+#define rcu_set_pointer_sig		urcu_signal_set_pointer
+
+#define rcu_sig_before_fork		urcu_signal_before_fork
+#define rcu_sig_after_fork_parent	urcu_signal_after_fork_parent
+#define rcu_sig_after_fork_child	urcu_signal_after_fork_child
+
+#define rcu_read_lock_sig		urcu_signal_read_lock
+#define _rcu_read_lock_sig		_urcu_signal_read_lock
+#define rcu_read_unlock_sig		urcu_signal_read_unlock
+#define _rcu_read_unlock_sig		_urcu_signal_read_unlock
+#define rcu_read_ongoing_sig		urcu_signal_read_ongoing
+#define _rcu_read_ongoing_sig		_urcu_signal_read_ongoing
+#define rcu_register_thread_sig		urcu_signal_register_thread
+#define rcu_unregister_thread_sig	urcu_signal_unregister_thread
+#define rcu_init_sig			urcu_signal_init
+#define rcu_exit_sig			urcu_signal_exit
+#define synchronize_rcu_sig		urcu_signal_synchronize_rcu
+#define rcu_reader_sig			urcu_signal_reader
+#define rcu_gp_sig			urcu_signal_gp
+
+#define get_cpu_call_rcu_data_sig	urcu_signal_get_cpu_call_rcu_data
+#define get_call_rcu_thread_sig		urcu_signal_get_call_rcu_thread
+#define create_call_rcu_data_sig	urcu_signal_create_call_rcu_data
+#define set_cpu_call_rcu_data_sig	urcu_signal_set_cpu_call_rcu_data
+#define get_default_call_rcu_data_sig	urcu_signal_get_default_call_rcu_data
+#define get_call_rcu_data_sig		urcu_signal_get_call_rcu_data
+#define get_thread_call_rcu_data_sig	urcu_signal_get_thread_call_rcu_data
+#define set_thread_call_rcu_data_sig	urcu_signal_set_thread_call_rcu_data
+#define create_all_cpu_call_rcu_data_sig	\
+		urcu_signal_create_all_cpu_call_rcu_data
+#define free_all_cpu_call_rcu_data_sig	urcu_signal_free_all_cpu_call_rcu_data
+#define call_rcu_sig			urcu_signal_call_rcu
+#define call_rcu_data_free_sig		urcu_signal_call_rcu_data_free
+#define call_rcu_before_fork_sig		\
+		urcu_signal_call_rcu_before_fork
+#define call_rcu_after_fork_parent_sig	urcu_signal_call_rcu_after_fork_parent
+#define call_rcu_after_fork_child_sig	urcu_signal_call_rcu_after_fork_child
+#define rcu_barrier_sig			urcu_signal_barrier
+
+#define defer_rcu_sig			urcu_signal_defer_rcu
+#define rcu_defer_register_thread_sig	urcu_signal_defer_register_thread
+#define rcu_defer_unregister_thread_sig	urcu_signal_defer_unregister_thread
+#define rcu_defer_barrier_sig		urcu_signal_defer_barrier
+#define rcu_defer_barrier_thread_sig	urcu_signal_defer_barrier_thread
+#define rcu_defer_exit_sig		urcu_signal_defer_exit
+
+#define rcu_flavor_sig			urcu_signal_flavor
+
+#define urcu_register_rculfhash_atfork_sig	\
+		urcu_signal_register_rculfhash_atfork
+#define urcu_unregister_rculfhash_atfork_sig	\
+		urcu_signal_unregister_rculfhash_atfork
+
+#endif /* URCU_NO_COMPAT_IDENTIFIERS */
diff --git a/src/urcu-bp.c b/src/urcu-bp.c
index 54fda16..33f2807 100644
--- a/src/urcu-bp.c
+++ b/src/urcu-bp.c
@@ -23,6 +23,7 @@
  * IBM's contributions to this file may be relicensed under LGPLv2 or later.
  */
 
+#define URCU_NO_COMPAT_IDENTIFIERS
 #define _LGPL_SOURCE
 #include <stdio.h>
 #include <pthread.h>
diff --git a/src/urcu-qsbr.c b/src/urcu-qsbr.c
index ab20ebe..3709412 100644
--- a/src/urcu-qsbr.c
+++ b/src/urcu-qsbr.c
@@ -23,6 +23,7 @@
  * IBM's contributions to this file may be relicensed under LGPLv2 or later.
  */
 
+#define URCU_NO_COMPAT_IDENTIFIERS
 #define _LGPL_SOURCE
 #include <stdio.h>
 #include <pthread.h>
diff --git a/src/urcu.c b/src/urcu.c
index 2cac0b6..f6ca5f8 100644
--- a/src/urcu.c
+++ b/src/urcu.c
@@ -23,6 +23,7 @@
  * IBM's contributions to this file may be relicensed under LGPLv2 or later.
  */
 
+#define URCU_NO_COMPAT_IDENTIFIERS
 #define _BSD_SOURCE
 #define _LGPL_SOURCE
 #define _DEFAULT_SOURCE
-- 
2.17.1
