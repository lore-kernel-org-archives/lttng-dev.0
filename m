From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] Fix: handle sys_futex() FUTEX_WAIT interrupted
	by signal
Date: Mon,  6 Jul 2015 16:51:57 -0400
Message-ID: <1436215917-17228-1-git-send-email-mathieu.desnoyers__14969.5588661872$1436216006$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1ZCDNN-0001N6-Lc
 for lttng-dev@lists.lttng.org; Mon, 06 Jul 2015 16:52:32 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Lai Jiangshan <laijs@cn.fujitsu.com>, rp@svcs.cs.pdx.edu, lttng-dev@lists.lttng.org, Alan Stern <stern@rowland.harvard.edu>, Stephen Hemminger <shemminger@vyatta.com>
List-Id: lttng-dev@lists.lttng.org

We need to handle EINTR returned by sys_futex() FUTEX_WAIT, otherwise a
signal interrupting this system call could make sys_futex return too
early, and therefore cause a synchronization issue.

Ensure that the futex compatibility layer returns meaningful errors and
errno when using poll() or pthread cond variables.

Reported-by: Gerd Gerats <geg@ngncc.de>
CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CC: Lai Jiangshan <laijs@cn.fujitsu.com>
CC: Stephen Hemminger <shemminger@vyatta.com>
CC: Alan Stern <stern@rowland.harvard.edu>
CC: lttng-dev@lists.lttng.org
CC: rp@svcs.cs.pdx.edu
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 compat_futex.c          | 36 +++++++++++++++++++++++++++---------
 urcu-call-rcu-impl.h    | 48 ++++++++++++++++++++++++++++++++++++++----------
 urcu-defer-impl.h       | 24 +++++++++++++++++++-----
 urcu-qsbr.c             | 19 ++++++++++++++++---
 urcu-wait.h             | 24 ++++++++++++++++++++----
 urcu.c                  | 19 ++++++++++++++++---
 urcu/futex.h            |  3 +++
 urcu/static/urcu-qsbr.h |  9 +++++++--
 urcu/static/urcu.h      |  9 +++++++--
 9 files changed, 153 insertions(+), 38 deletions(-)

diff --git a/compat_futex.c b/compat_futex.c
index 6ec0b39..a357134 100644
--- a/compat_futex.c
+++ b/compat_futex.c
@@ -54,7 +54,7 @@ pthread_cond_t __urcu_compat_futex_cond = PTHREAD_COND_INITIALIZER;
 int compat_futex_noasync(int32_t *uaddr, int op, int32_t val,
 	const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
 {
-	int ret, gret = 0;
+	int ret;
 
 	/*
 	 * Check if NULL. Don't let users expect that they are taken into
@@ -70,7 +70,11 @@ int compat_futex_noasync(int32_t *uaddr, int op, int32_t val,
 	cmm_smp_mb();
 
 	ret = pthread_mutex_lock(&__urcu_compat_futex_lock);
-	assert(!ret);
+	if (ret) {
+		errno = ret;
+		ret = -1;
+		goto end;
+	}
 	switch (op) {
 	case FUTEX_WAIT:
 		/*
@@ -91,11 +95,16 @@ int compat_futex_noasync(int32_t *uaddr, int op, int32_t val,
 		pthread_cond_broadcast(&__urcu_compat_futex_cond);
 		break;
 	default:
-		gret = -EINVAL;
+		errno = EINVAL;
+		ret = -1;
 	}
 	ret = pthread_mutex_unlock(&__urcu_compat_futex_lock);
-	assert(!ret);
-	return gret;
+	if (ret) {
+		errno = ret;
+		ret = -1;
+	}
+end:
+	return ret;
 }
 
 /*
@@ -107,6 +116,8 @@ int compat_futex_noasync(int32_t *uaddr, int op, int32_t val,
 int compat_futex_async(int32_t *uaddr, int op, int32_t val,
 	const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
 {
+	int ret = 0;
+
 	/*
 	 * Check if NULL. Don't let users expect that they are taken into
 	 * account. 
@@ -122,13 +133,20 @@ int compat_futex_async(int32_t *uaddr, int op, int32_t val,
 
 	switch (op) {
 	case FUTEX_WAIT:
-		while (CMM_LOAD_SHARED(*uaddr) == val)
-			poll(NULL, 0, 10);
+		while (CMM_LOAD_SHARED(*uaddr) == val) {
+			if (poll(NULL, 0, 10) < 0) {
+				ret = -1;
+				/* Keep poll errno. Caller handles EINTR. */
+				goto end;
+			}
+		}
 		break;
 	case FUTEX_WAKE:
 		break;
 	default:
-		return -EINVAL;
+		errno = EINVAL;
+		ret = -1;
 	}
-	return 0;
+end:
+	return ret;
 }
diff --git a/urcu-call-rcu-impl.h b/urcu-call-rcu-impl.h
index f02405d..d33c731 100644
--- a/urcu-call-rcu-impl.h
+++ b/urcu-call-rcu-impl.h
@@ -256,9 +256,22 @@ static void call_rcu_wait(struct call_rcu_data *crdp)
 {
 	/* Read call_rcu list before read futex */
 	cmm_smp_mb();
-	if (uatomic_read(&crdp->futex) == -1)
-		futex_async(&crdp->futex, FUTEX_WAIT, -1,
-		      NULL, NULL, 0);
+	if (uatomic_read(&crdp->futex) != -1)
+		return;
+	while (futex_async(&crdp->futex, FUTEX_WAIT, -1,
+			NULL, NULL, 0)) {
+		switch (errno) {
+		case EWOULDBLOCK:
+			/* Value already changed. */
+			return;
+		case EINTR:
+			/* Retry if interrupted by signal. */
+			break;	/* Get out of switch. */
+		default:
+			/* Unexpected error. */
+			urcu_die(errno);
+		}
+	}
 }
 
 static void call_rcu_wake_up(struct call_rcu_data *crdp)
@@ -267,8 +280,9 @@ static void call_rcu_wake_up(struct call_rcu_data *crdp)
 	cmm_smp_mb();
 	if (caa_unlikely(uatomic_read(&crdp->futex) == -1)) {
 		uatomic_set(&crdp->futex, 0);
-		futex_async(&crdp->futex, FUTEX_WAKE, 1,
-		      NULL, NULL, 0);
+		if (futex_async(&crdp->futex, FUTEX_WAKE, 1,
+				NULL, NULL, 0) < 0)
+			urcu_die(errno);
 	}
 }
 
@@ -276,9 +290,22 @@ static void call_rcu_completion_wait(struct call_rcu_completion *completion)
 {
 	/* Read completion barrier count before read futex */
 	cmm_smp_mb();
-	if (uatomic_read(&completion->futex) == -1)
-		futex_async(&completion->futex, FUTEX_WAIT, -1,
-		      NULL, NULL, 0);
+	if (uatomic_read(&completion->futex) != -1)
+		return;
+	while (futex_async(&completion->futex, FUTEX_WAIT, -1,
+			NULL, NULL, 0)) {
+		switch (errno) {
+		case EWOULDBLOCK:
+			/* Value already changed. */
+			return;
+		case EINTR:
+			/* Retry if interrupted by signal. */
+			break;	/* Get out of switch. */
+		default:
+			/* Unexpected error. */
+			urcu_die(errno);
+		}
+	}
 }
 
 static void call_rcu_completion_wake_up(struct call_rcu_completion *completion)
@@ -287,8 +314,9 @@ static void call_rcu_completion_wake_up(struct call_rcu_completion *completion)
 	cmm_smp_mb();
 	if (caa_unlikely(uatomic_read(&completion->futex) == -1)) {
 		uatomic_set(&completion->futex, 0);
-		futex_async(&completion->futex, FUTEX_WAKE, 1,
-		      NULL, NULL, 0);
+		if (futex_async(&completion->futex, FUTEX_WAKE, 1,
+				NULL, NULL, 0) < 0)
+			urcu_die(errno);
 	}
 }
 
diff --git a/urcu-defer-impl.h b/urcu-defer-impl.h
index 2cff807..f1dca8f 100644
--- a/urcu-defer-impl.h
+++ b/urcu-defer-impl.h
@@ -160,8 +160,9 @@ static void wake_up_defer(void)
 {
 	if (caa_unlikely(uatomic_read(&defer_thread_futex) == -1)) {
 		uatomic_set(&defer_thread_futex, 0);
-		futex_noasync(&defer_thread_futex, FUTEX_WAKE, 1,
-		      NULL, NULL, 0);
+		if (futex_noasync(&defer_thread_futex, FUTEX_WAKE, 1,
+				NULL, NULL, 0) < 0)
+			urcu_die(errno);
 	}
 }
 
@@ -198,9 +199,22 @@ static void wait_defer(void)
 		uatomic_set(&defer_thread_futex, 0);
 	} else {
 		cmm_smp_rmb();	/* Read queue before read futex */
-		if (uatomic_read(&defer_thread_futex) == -1)
-			futex_noasync(&defer_thread_futex, FUTEX_WAIT, -1,
-			      NULL, NULL, 0);
+		if (uatomic_read(&defer_thread_futex) != -1)
+			return;
+		while (futex_noasync(&defer_thread_futex, FUTEX_WAIT, -1,
+				NULL, NULL, 0)) {
+			switch (errno) {
+			case EWOULDBLOCK:
+				/* Value already changed. */
+				return;
+			case EINTR:
+				/* Retry if interrupted by signal. */
+				break;	/* Get out of switch. */
+			default:
+				/* Unexpected error. */
+				urcu_die(errno);
+			}
+		}
 	}
 }
 
diff --git a/urcu-qsbr.c b/urcu-qsbr.c
index 685efb5..619df60 100644
--- a/urcu-qsbr.c
+++ b/urcu-qsbr.c
@@ -121,9 +121,22 @@ static void wait_gp(void)
 {
 	/* Read reader_gp before read futex */
 	cmm_smp_rmb();
-	if (uatomic_read(&rcu_gp.futex) == -1)
-		futex_noasync(&rcu_gp.futex, FUTEX_WAIT, -1,
-		      NULL, NULL, 0);
+	if (uatomic_read(&rcu_gp.futex) != -1)
+		return;
+	while (futex_noasync(&rcu_gp.futex, FUTEX_WAIT, -1,
+			NULL, NULL, 0)) {
+		switch (errno) {
+		case EWOULDBLOCK:
+			/* Value already changed. */
+			return;
+		case EINTR:
+			/* Retry if interrupted by signal. */
+			break;	/* Get out of switch. */
+		default:
+			/* Unexpected error. */
+			urcu_die(errno);
+		}
+	}
 }
 
 /*
diff --git a/urcu-wait.h b/urcu-wait.h
index d00842a..94f3e35 100644
--- a/urcu-wait.h
+++ b/urcu-wait.h
@@ -25,6 +25,7 @@
 
 #include <urcu/uatomic.h>
 #include <urcu/wfstack.h>
+#include "urcu-die.h"
 
 /*
  * Number of busy-loop attempts before waiting on futex for grace period
@@ -122,8 +123,11 @@ void urcu_adaptative_wake_up(struct urcu_wait_node *wait)
 	cmm_smp_mb();
 	assert(uatomic_read(&wait->state) == URCU_WAIT_WAITING);
 	uatomic_set(&wait->state, URCU_WAIT_WAKEUP);
-	if (!(uatomic_read(&wait->state) & URCU_WAIT_RUNNING))
-		futex_noasync(&wait->state, FUTEX_WAKE, 1, NULL, NULL, 0);
+	if (!(uatomic_read(&wait->state) & URCU_WAIT_RUNNING)) {
+		if (futex_noasync(&wait->state, FUTEX_WAKE, 1,
+				NULL, NULL, 0) < 0)
+			urcu_die(errno);
+	}
 	/* Allow teardown of struct urcu_wait memory. */
 	uatomic_or(&wait->state, URCU_WAIT_TEARDOWN);
 }
@@ -144,8 +148,20 @@ void urcu_adaptative_busy_wait(struct urcu_wait_node *wait)
 			goto skip_futex_wait;
 		caa_cpu_relax();
 	}
-	futex_noasync(&wait->state, FUTEX_WAIT,
-		URCU_WAIT_WAITING, NULL, NULL, 0);
+	while (futex_noasync(&wait->state, FUTEX_WAIT, URCU_WAIT_WAITING,
+			NULL, NULL, 0)) {
+		switch (errno) {
+		case EWOULDBLOCK:
+			/* Value already changed. */
+			goto skip_futex_wait;
+		case EINTR:
+			/* Retry if interrupted by signal. */
+			break;	/* Get out of switch. */
+		default:
+			/* Unexpected error. */
+			urcu_die(errno);
+		}
+	}
 skip_futex_wait:
 
 	/* Tell waker thread than we are running. */
diff --git a/urcu.c b/urcu.c
index 94d1131..e773065 100644
--- a/urcu.c
+++ b/urcu.c
@@ -236,9 +236,22 @@ static void wait_gp(void)
 {
 	/* Read reader_gp before read futex */
 	smp_mb_master(RCU_MB_GROUP);
-	if (uatomic_read(&rcu_gp.futex) == -1)
-		futex_async(&rcu_gp.futex, FUTEX_WAIT, -1,
-		      NULL, NULL, 0);
+	if (uatomic_read(&rcu_gp.futex) != -1)
+		return;
+	while (futex_async(&rcu_gp.futex, FUTEX_WAIT, -1,
+			NULL, NULL, 0)) {
+		switch (errno) {
+		case EWOULDBLOCK:
+			/* Value already changed. */
+			return;
+		case EINTR:
+			/* Retry if interrupted by signal. */
+			break;	/* Get out of switch. */
+		default:
+			/* Unexpected error. */
+			urcu_die(errno);
+		}
+	}
 }
 
 /*
diff --git a/urcu/futex.h b/urcu/futex.h
index bb270c2..2be3bb6 100644
--- a/urcu/futex.h
+++ b/urcu/futex.h
@@ -42,6 +42,9 @@ extern "C" {
  *
  * futex_async is signal-handler safe for the wakeup. It uses polling
  * on the wait-side in compatibility mode.
+ *
+ * BEWARE: sys_futex() FUTEX_WAIT may return early if interrupted
+ * (returns EINTR).
  */
 
 #ifdef CONFIG_RCU_HAVE_FUTEX
diff --git a/urcu/static/urcu-qsbr.h b/urcu/static/urcu-qsbr.h
index 8f2ca32..143d75a 100644
--- a/urcu/static/urcu-qsbr.h
+++ b/urcu/static/urcu-qsbr.h
@@ -106,8 +106,13 @@ static inline void wake_up_gp(void)
 		if (uatomic_read(&rcu_gp.futex) != -1)
 			return;
 		uatomic_set(&rcu_gp.futex, 0);
-		futex_noasync(&rcu_gp.futex, FUTEX_WAKE, 1,
-		      NULL, NULL, 0);
+		/*
+		 * Ignoring return value until we can make this function
+		 * return something (because urcu_die() is not publicly
+		 * exposed).
+		 */
+		(void) futex_noasync(&rcu_gp.futex, FUTEX_WAKE, 1,
+				NULL, NULL, 0);
 	}
 }
 
diff --git a/urcu/static/urcu.h b/urcu/static/urcu.h
index b5fc09f..af8eee4 100644
--- a/urcu/static/urcu.h
+++ b/urcu/static/urcu.h
@@ -168,8 +168,13 @@ static inline void wake_up_gp(void)
 {
 	if (caa_unlikely(uatomic_read(&rcu_gp.futex) == -1)) {
 		uatomic_set(&rcu_gp.futex, 0);
-		futex_async(&rcu_gp.futex, FUTEX_WAKE, 1,
-		      NULL, NULL, 0);
+		/*
+		 * Ignoring return value until we can make this function
+		 * return something (because urcu_die() is not publicly
+		 * exposed).
+		 */
+		(void) futex_async(&rcu_gp.futex, FUTEX_WAKE, 1,
+				NULL, NULL, 0);
 	}
 }
 
-- 
2.1.4
