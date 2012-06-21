From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH] Userspace RCU library internal error
	handling
Date: Thu, 21 Jun 2012 15:14:51 -0400
Message-ID: <20120621191451.GA25058__34439.1590253965$1340306135$gmane$org@Krystal>
References: <20120621164113.GA21197@Krystal> <20120621185941.GC26361@leaf>
	<20120621190306.GB24179@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1ShmqE-00013f-EE
	for lttng-dev@lists.lttng.org; Thu, 21 Jun 2012 15:14:54 -0400
Content-Disposition: inline
In-Reply-To: <20120621190306.GB24179@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> * Josh Triplett (josh@joshtriplett.org) wrote:
> > On Thu, Jun 21, 2012 at 12:41:13PM -0400, Mathieu Desnoyers wrote:
> > > Currently, liburcu calls "exit(-1)" upon internal consistency error.
> > > This is not pretty, and usually frowned upon in libraries.
> > 
> > Agreed.
> > 
> > > One example of failure path where we use this is if pthread_mutex_lock()
> > > would happen to fail within synchronize_rcu(). Clearly, this should
> > > _never_ happen: it would typically be triggered only by memory
> > > corruption (or other terrible things like that). That being said, we
> > > clearly don't want to make "synchronize_rcu()" return errors like that
> > > to the application, because it would complexify the application error
> > > handling needlessly.
> > 
> > I think you can safely ignore any error conditions you know you can't
> > trigger.  pthread_mutex_lock can only return an error under two
> > conditions: an uninitialized mutex, or an error-checking mutex already
> > locked by the current thread.  Neither of those can happen in this case.
> > Given that, I'd suggest either calling pthread_mutex_lock and ignoring
> > any possibility of error, or adding an assert.
> > 
> > > So instead of calling exit(-1), one possibility would be to do something
> > > like this:
> > > 
> > > #include <signal.h>
> > > #include <pthread.h>
> > > #include <stdio.h>
> > > 
> > > #define urcu_die(fmt, ...)                      \
> > >         do {    \
> > >                 fprintf(stderr, fmt, ##__VA_ARGS__);    \
> > >                 (void) pthread_kill(pthread_self(), SIGBUS);    \
> > >         } while (0)
> > > 
> > > and call urcu_die(); in those "unrecoverable error" cases, instead of
> > > calling exit(-1). Therefore, if an application chooses to trap those
> > > signals, it can, which is otherwise not possible with a direct call to
> > > exit().
> > 
> > It looks like you want to use signals as a kind of exception mechanism,
> > to allow the application to clean up (though not to recover).  assert
> > seems much clearer to me for "this can't happen" cases, and assert also
> > generates a signal that the application can catch and clean up.
> 
> Within discussions with other LTTng developers, we considered the the
> assert, but the thought that this case might be silently ignored on
> production systems (which compile with assertions disabled) makes me
> uncomfortable. This is why I would prefer a SIGBUS to an assertion.
> 
> Using assert() would be similar to turning the Linux kernel BUG_ON()
> mechanism into no-ops on production systems because "it should never
> happen" (tm) ;-)

Here is the patch for comments.

---
diff --git a/Makefile.am b/Makefile.am
index 933e538..2396fcf 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -22,6 +22,8 @@ nobase_dist_include_HEADERS = urcu/compiler.h urcu/hlist.h urcu/list.h \
 		urcu/tls-compat.h
 nobase_nodist_include_HEADERS = urcu/arch.h urcu/uatomic.h urcu/config.h
 
+dist_noinst_HEADERS = urcu-die.h
+
 EXTRA_DIST = $(top_srcdir)/urcu/arch/*.h $(top_srcdir)/urcu/uatomic/*.h \
 		gpl-2.0.txt lgpl-2.1.txt lgpl-relicensing.txt \
 		LICENSE compat_arch_x86.c \
diff --git a/urcu-bp.c b/urcu-bp.c
index 67eae07..b9c89d8 100644
--- a/urcu-bp.c
+++ b/urcu-bp.c
@@ -42,6 +42,8 @@
 #include "urcu-pointer.h"
 #include "urcu/tls-compat.h"
 
+#include "urcu-die.h"
+
 /* Do not #define _LGPL_SOURCE to ensure we can emit the wrapper symbols */
 #undef _LGPL_SOURCE
 #include "urcu-bp.h"
@@ -142,17 +144,12 @@ static void mutex_lock(pthread_mutex_t *mutex)
 
 #ifndef DISTRUST_SIGNALS_EXTREME
 	ret = pthread_mutex_lock(mutex);
-	if (ret) {
-		perror("Error in pthread mutex lock");
-		exit(-1);
-	}
+	if (ret)
+		urcu_die(ret);
 #else /* #ifndef DISTRUST_SIGNALS_EXTREME */
 	while ((ret = pthread_mutex_trylock(mutex)) != 0) {
-		if (ret != EBUSY && ret != EINTR) {
-			printf("ret = %d, errno = %d\n", ret, errno);
-			perror("Error in pthread mutex lock");
-			exit(-1);
-		}
+		if (ret != EBUSY && ret != EINTR)
+			urcu_die(ret);
 		poll(NULL,0,10);
 	}
 #endif /* #else #ifndef DISTRUST_SIGNALS_EXTREME */
@@ -163,10 +160,8 @@ static void mutex_unlock(pthread_mutex_t *mutex)
 	int ret;
 
 	ret = pthread_mutex_unlock(mutex);
-	if (ret) {
-		perror("Error in pthread mutex unlock");
-		exit(-1);
-	}
+	if (ret)
+		urcu_die(ret);
 }
 
 void update_counter_and_wait(void)
diff --git a/urcu-die.h b/urcu-die.h
new file mode 100644
index 0000000..e925d74
--- /dev/null
+++ b/urcu-die.h
@@ -0,0 +1,38 @@
+#ifndef _URCU_DIE_H
+#define _URCU_DIE_H
+
+/*
+ * urcu-die.h
+ *
+ * Userspace RCU library unrecoverable error handling
+ *
+ * Copyright (c) 2012 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
+ */
+
+#include <signal.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <string.h>
+
+#define urcu_die(cause)								\
+do {										\
+	fprintf(stderr, "(" __FILE__ ":%s@%u) Unrecoverable error: %s\n",	\
+		__func__, __LINE__, strerror(cause));				\
+	(void) pthread_kill(pthread_self(), SIGBUS);				\
+} while (0)
+
+#endif /* _URCU_DIE_H */
diff --git a/urcu-qsbr.c b/urcu-qsbr.c
index b20d564..d3a6849 100644
--- a/urcu-qsbr.c
+++ b/urcu-qsbr.c
@@ -42,6 +42,8 @@
 #include "urcu-pointer.h"
 #include "urcu/tls-compat.h"
 
+#include "urcu-die.h"
+
 /* Do not #define _LGPL_SOURCE to ensure we can emit the wrapper symbols */
 #undef _LGPL_SOURCE
 #include "urcu-qsbr.h"
@@ -82,17 +84,12 @@ static void mutex_lock(pthread_mutex_t *mutex)
 
 #ifndef DISTRUST_SIGNALS_EXTREME
 	ret = pthread_mutex_lock(mutex);
-	if (ret) {
-		perror("Error in pthread mutex lock");
-		exit(-1);
-	}
+	if (ret)
+		urcu_die(ret);
 #else /* #ifndef DISTRUST_SIGNALS_EXTREME */
 	while ((ret = pthread_mutex_trylock(mutex)) != 0) {
-		if (ret != EBUSY && ret != EINTR) {
-			printf("ret = %d, errno = %d\n", ret, errno);
-			perror("Error in pthread mutex lock");
-			exit(-1);
-		}
+		if (ret != EBUSY && ret != EINTR)
+			urcu_die(ret);
 		poll(NULL,0,10);
 	}
 #endif /* #else #ifndef DISTRUST_SIGNALS_EXTREME */
@@ -103,10 +100,8 @@ static void mutex_unlock(pthread_mutex_t *mutex)
 	int ret;
 
 	ret = pthread_mutex_unlock(mutex);
-	if (ret) {
-		perror("Error in pthread mutex unlock");
-		exit(-1);
-	}
+	if (ret)
+		urcu_die(ret);
 }
 
 /*
diff --git a/urcu.c b/urcu.c
index 5fb4db8..a5178c0 100644
--- a/urcu.c
+++ b/urcu.c
@@ -42,6 +42,8 @@
 #include "urcu-pointer.h"
 #include "urcu/tls-compat.h"
 
+#include "urcu-die.h"
+
 /* Do not #define _LGPL_SOURCE to ensure we can emit the wrapper symbols */
 #undef _LGPL_SOURCE
 #include "urcu.h"
@@ -110,17 +112,12 @@ static void mutex_lock(pthread_mutex_t *mutex)
 
 #ifndef DISTRUST_SIGNALS_EXTREME
 	ret = pthread_mutex_lock(mutex);
-	if (ret) {
-		perror("Error in pthread mutex lock");
-		exit(-1);
-	}
+	if (ret)
+		urcu_die(ret);
 #else /* #ifndef DISTRUST_SIGNALS_EXTREME */
 	while ((ret = pthread_mutex_trylock(mutex)) != 0) {
-		if (ret != EBUSY && ret != EINTR) {
-			printf("ret = %d, errno = %d\n", ret, errno);
-			perror("Error in pthread mutex lock");
-			exit(-1);
-		}
+		if (ret != EBUSY && ret != EINTR)
+			urcu_die(ret);
 		if (CMM_LOAD_SHARED(URCU_TLS(rcu_reader).need_mb)) {
 			cmm_smp_mb();
 			_CMM_STORE_SHARED(URCU_TLS(rcu_reader).need_mb, 0);
@@ -136,10 +133,8 @@ static void mutex_unlock(pthread_mutex_t *mutex)
 	int ret;
 
 	ret = pthread_mutex_unlock(mutex);
-	if (ret) {
-		perror("Error in pthread mutex unlock");
-		exit(-1);
-	}
+	if (ret)
+		urcu_die(ret);
 }
 
 #ifdef RCU_MEMBARRIER
@@ -432,10 +427,8 @@ void rcu_init(void)
 	act.sa_flags = SA_SIGINFO | SA_RESTART;
 	sigemptyset(&act.sa_mask);
 	ret = sigaction(SIGRCU, &act, NULL);
-	if (ret) {
-		perror("Error in sigaction");
-		exit(-1);
-	}
+	if (ret)
+		urcu_die(errno);
 }
 
 void rcu_exit(void)
@@ -444,10 +437,8 @@ void rcu_exit(void)
 	int ret;
 
 	ret = sigaction(SIGRCU, NULL, &act);
-	if (ret) {
-		perror("Error in sigaction");
-		exit(-1);
-	}
+	if (ret)
+		urcu_die(errno);
 	assert(act.sa_sigaction == sigrcu_handler);
 	assert(cds_list_empty(&registry));
 }

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
