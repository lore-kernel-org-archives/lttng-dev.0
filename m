From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: [PATCH] urcu: fix compat_futex_noasync()
Date: Wed, 08 Aug 2012 09:20:36 +0800
Message-ID: <5021BEE4.6090907__8884.5562692315$1344388864$gmane$org@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1Syuvx-0002Sl-Rm
	for lttng-dev@lists.lttng.org; Tue, 07 Aug 2012 21:19:38 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

This patch fix two critical problems:

1) compat_futex_cond is not bound to any @uaddr, it services all @uaddr,
   if you wakeup only one thread(pthread_cond_signal), the @uaddr of
   this waking thread and the @uaddr of the woken-up thread may be different.
   the the woken-up thread will very probably go to sleep again
   because his own condition is not true.

   *And* this waking thread(FUTEX_WAKE) wake up NOTHING.

2) If the caller want to wake up all waiting threads, he will use INT_MAX for @val.
   and 
		for (i = 0; i < INT_MAX; i++)
			pthread_cond_signal(&compat_futex_cond);
   becomes almost infinity loop.

Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
---
diff --git a/compat_futex.c b/compat_futex.c
index 04de596..bb928e6 100644
--- a/compat_futex.c
+++ b/compat_futex.c
@@ -43,7 +43,7 @@ static pthread_cond_t compat_futex_cond = PTHREAD_COND_INITIALIZER;
 int compat_futex_noasync(int32_t *uaddr, int op, int32_t val,
 	const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
 {
-	int ret, i, gret = 0;
+	int ret, gret = 0;
 
 	/*
 	 * Check if NULL. Don't let users expect that they are taken into
@@ -67,8 +67,7 @@ int compat_futex_noasync(int32_t *uaddr, int op, int32_t val,
 		pthread_cond_wait(&compat_futex_cond, &compat_futex_lock);
 		break;
 	case FUTEX_WAKE:
-		for (i = 0; i < val; i++)
-			pthread_cond_signal(&compat_futex_cond);
+		pthread_cond_broadcast(&compat_futex_cond);
 		break;
 	default:
 		gret = -EINVAL;
