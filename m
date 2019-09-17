From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH urcu] Fix: rculfhash worker needs to unblock
 to SIGRCU
Date: Tue, 17 Sep 2019 11:34:03 -0400
Message-ID: <20190917153403.9143-1-mathieu.desnoyers__10995.9039183863$1568734564$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 46XnJ053ctzq7n
 for <lttng-dev@lists.lttng.org>; Tue, 17 Sep 2019 11:35:44 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: hewenliang <hewenliang4@huawei.com>
Cc: lttng-dev@lists.lttng.org, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

In urcu-signal flavor, call_rcu_thread calls synchronize_rcu which
will send SIGRCU signal to all registed threads, and then loops to
wait need_mb to be cleared. However, the registed workqueue_thread
does not process the SIGRCU signal, and never clear the need_mb.
Based on above, call_rcu_thread and workqueue_thread will wait
forever for completion of the grace period: call_rcu_thread which holds
the rcu_registry_lock, waits for workqueue_thread to do cmm_smp_mb.
While workqueue thread never does cmm_smp_mb because of signal blocking,
and it will eventually wait to get rcu_registry_lock in do_resize_cb.

The phenomenon is as follows, which is easy to be triggered:

(gdb) t 2
[Switching to thread 2 (Thread 0xffff83c3b080 (LWP 27116))]
0  0x0000ffff845296c4 in poll () from /lib64/libc.so.6
(gdb) bt
0 0x0000ffff845296c4 in poll () from /lib64/libc.so.6
1 0x0000ffff8461b93c in force_mb_all_readers () at urcu.c:241
2 0x0000ffff8461c748 in smp_mb_master () at urcu.c:249
3 urcu_signal_synchronize_rcu () at urcu.c:445
4 0x0000ffff8461d004 in call_rcu_thread  at urcu-call-rcu-impl.h:364
5 0x0000ffff845eb8bc in start_thread () from /lib64/libpthread.so.0
6 0x0000ffff845335cc in thread_start () from /lib64/libc.so.6
(gdb) t 3
[Switching to thread 3 (Thread 0xffff8443c080 (LWP 27191))]
0 0x0000ffff845f51c4 in __lll_lock_wait () from /lib64/libpthread.so.0
(gdb) bt
0 0x0000ffff845f51c4 in __lll_lock_wait () from /lib64/libpthread.so.0
1 0x0000ffff845ee048 in pthread_mutex_lock () from /lib64/libpthread.so.0
2 0x0000ffff8461b814 in mutex_lock ( <rcu_registry_lock>) at urcu.c:157
3 0x0000ffff8461b9e4 in urcu_signal_unregister_thread () at urcu.c:564
4 0x0000ffff8463e62c in do_resize_cb (work=0x11e2e790) at rculfhash.c:2042
5 0x0000ffff8463c940 in workqueue_thread (arg=0x11e1d260) at workqueue.c:228
6 0x0000ffff845eb8bc in start_thread () from /lib64/libpthread.so.0
7 0x0000ffff845335cc in thread_start () from /lib64/libc.so.6

So we should not block SIGRCU in workqueue thread to avoid blocking
forever in the grace period awaiting on the worker thread when using
urcu-signal flavor.

Reported-by: hewenliang <hewenliang4@huawei.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: hewenliang <hewenliang4@huawei.com>
---
 include/Makefile.am                  |  3 ++-
 include/urcu/static/urcu-signal-nr.h | 42 ++++++++++++++++++++++++++++++++++++
 include/urcu/static/urcu-signal.h    | 14 +-----------
 src/rculfhash.c                      | 13 ++++++++---
 4 files changed, 55 insertions(+), 17 deletions(-)
 create mode 100644 include/urcu/static/urcu-signal-nr.h

diff --git a/include/Makefile.am b/include/Makefile.am
index 34812d4..8f83641 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -14,7 +14,8 @@ nobase_dist_include_HEADERS = urcu/compiler.h urcu/hlist.h urcu/list.h \
 		urcu/static/urcu-qsbr.h urcu/static/wfcqueue.h \
 		urcu/static/wfqueue.h urcu/static/wfstack.h \
 		urcu/static/urcu-mb.h urcu/static/urcu-memb.h \
-		urcu/static/urcu-signal.h urcu/static/urcu-common.h \
+		urcu/static/urcu-signal.h urcu/static/urcu-signal-nr.h \
+		urcu/static/urcu-common.h \
 		urcu/tls-compat.h urcu/debug.h urcu/urcu.h urcu/urcu-bp.h \
 		urcu/call-rcu.h urcu/defer.h \
 		urcu/pointer.h urcu/urcu-qsbr.h urcu/flavor.h \
diff --git a/include/urcu/static/urcu-signal-nr.h b/include/urcu/static/urcu-signal-nr.h
new file mode 100644
index 0000000..a488f3a
--- /dev/null
+++ b/include/urcu/static/urcu-signal-nr.h
@@ -0,0 +1,42 @@
+#ifndef _STATIC_URCU_SIGNAL_NR_H
+#define _STATIC_URCU_SIGNAL_NR_H
+
+/*
+ * static/urcu-signal-nr.h
+ *
+ * Userspace RCU header.
+ *
+ * Copyright (c) 2009 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * Copyright (c) 2009 Paul E. McKenney, IBM Corporation.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ * IBM's contributions to this file may be relicensed under LGPLv2 or later.
+ */
+
+/*
+ * The signal number used by the RCU library can be overridden with
+ * -DSIGRCU= when compiling the library.
+ * Provide backward compatibility for liburcu 0.3.x SIGURCU.
+ */
+#ifdef SIGURCU
+#define SIGRCU SIGURCU
+#endif
+
+#ifndef SIGRCU
+#define SIGRCU SIGUSR1
+#endif
+
+#endif /* _STATIC_URCU_SIGNAL_NR_H */
diff --git a/include/urcu/static/urcu-signal.h b/include/urcu/static/urcu-signal.h
index 385e6f5..f0faf3a 100644
--- a/include/urcu/static/urcu-signal.h
+++ b/include/urcu/static/urcu-signal.h
@@ -44,6 +44,7 @@
 #include <urcu/tls-compat.h>
 #include <urcu/debug.h>
 #include <urcu/static/urcu-common.h>
+#include <urcu/static/urcu-signal-nr.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -57,19 +58,6 @@ extern "C" {
  * This is required to permit relinking with newer versions of the library.
  */
 
-/*
- * The signal number used by the RCU library can be overridden with
- * -DSIGRCU= when compiling the library.
- * Provide backward compatibility for liburcu 0.3.x SIGURCU.
- */
-#ifdef SIGURCU
-#define SIGRCU SIGURCU
-#endif
-
-#ifndef SIGRCU
-#define SIGRCU SIGUSR1
-#endif
-
 extern struct urcu_gp urcu_signal_gp;
 
 extern DECLARE_URCU_TLS(struct urcu_reader, urcu_signal_reader);
diff --git a/src/rculfhash.c b/src/rculfhash.c
index ff42df0..5b3c06b 100644
--- a/src/rculfhash.c
+++ b/src/rculfhash.c
@@ -273,6 +273,7 @@
 #include <urcu/uatomic.h>
 #include <urcu/compiler.h>
 #include <urcu/rculfhash.h>
+#include <urcu/static/urcu-signal-nr.h>
 #include <rculfhash-internal.h>
 #include <stdio.h>
 #include <pthread.h>
@@ -2151,18 +2152,24 @@ static struct urcu_atfork cds_lfht_atfork = {
 	.after_fork_child = cds_lfht_after_fork_child,
 };
 
-/* Block all signals to ensure we don't disturb the application. */
+/*
+ * Block all signals for the workqueue worker thread to ensure we don't
+ * disturb the application. The SIGRCU signal needs to be unblocked for
+ * the urcu-signal flavor.
+ */
 static void cds_lfht_worker_init(struct urcu_workqueue *workqueue,
 		void *priv)
 {
 	int ret;
 	sigset_t mask;
 
-	/* Block signal for entire process, so only our thread processes it. */
 	ret = sigfillset(&mask);
 	if (ret)
 		urcu_die(errno);
-	ret = pthread_sigmask(SIG_BLOCK, &mask, NULL);
+	ret = sigdelset(&mask, SIGRCU);
+	if (ret)
+		urcu_die(ret);
+	ret = pthread_sigmask(SIG_SETMASK, &mask, NULL);
 	if (ret)
 		urcu_die(ret);
 }
-- 
2.11.0
