From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: 'call_rcu' unstable?
Date: Mon, 17 Dec 2012 23:22:14 -0500
Message-ID: <20121218042214.GA16410__38069.635249167$1355804578$gmane$org@Krystal>
References: <tencent_23D20B3D4C566CFC60D89D83@qq.com>
	<20121212145848.GA29236@Krystal> <20121213103537.GB8637@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Tkoh7-0005SN-Mm
	for lttng-dev@lists.lttng.org; Mon, 17 Dec 2012 23:22:17 -0500
Content-Disposition: inline
In-Reply-To: <20121213103537.GB8637@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: zs <84500316@qq.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
[...]
> 
> One more question about the nature of your application: is it using a
> "fork()" (or clone()) not followed by exec() ?
> 
> This design pattern is quite common in daemons using multi-process
> worker threads, and it's very likely in your case since you are using
> shared memory between processes. This has important impacts on the way
> threads are handled (see the pthread_atfork(3) manpage). Given that URCU
> keeps track of all reader threads, if any of those vanish at fork(), due
> to Linux implementation limitations, they need to be cleared from the
> urcu registry before a fork() not followed by exec().
> 
> For more info, please refer to the Userspace RCU README file, under
> section "Interaction with fork()".
> 
> Especially the part:
> 
> "Most liburcu implementations require that all registrations (as reader,
> defer_rcu and call_rcu threads) should be released before a fork() is
> performed, except for the rather common scenario where fork() is
> immediately followed by exec() in the child process."
> 
> So one possible explanation for the scenario you are observing is that
> the parent process still has RCU readers registered while performing
> fork(), and that the child process is unable to complete grace periods
> due to this stale list entry.
> 
> One thing to keep in mind is that this commit:
> 
> commit 765f3eadad5647e6fa853414fc652670f9e00966
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Sat Sep 10 22:02:58 2011 -0700
> 
>     call_rcu: register work threads as rcu readers
> 
> makes all call_rcu worker threads register as RCU readers. Since the
> default call_rcu thread is never cleaned up, it becomes hard for the
> application to ensure fork() correctness.
> 
> Am I on the right track ?

I created a small patch that reproduces your faulty behavior by simply
using fork() in a program (without following exec()). The child process
gets stucked in wait_for_readers() eating 100% of one CPU. More to come
soon.

Comments are welcome,

Thanks,

Mathieu

---
diff --git a/tests/Makefile.am b/tests/Makefile.am
index f8b4c67..0e15a4c 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -20,7 +20,8 @@ noinst_PROGRAMS = test_urcu test_urcu_dynamic_link test_urcu_timing \
 	test_urcu_wfcq_dynlink \
 	test_urcu_lfq_dynlink test_urcu_lfs_dynlink test_urcu_hash \
 	test_urcu_lfs_rcu_dynlink \
-	test_urcu_multiflavor test_urcu_multiflavor_dynlink
+	test_urcu_multiflavor test_urcu_multiflavor_dynlink \
+	test_urcu_fork
 noinst_HEADERS = rcutorture.h test_urcu_multiflavor.h
 
 if COMPAT_ARCH
@@ -85,6 +86,7 @@ test_urcu_signal_timing_CFLAGS= -DRCU_SIGNAL $(AM_CFLAGS)
 test_urcu_signal_yield_SOURCES = test_urcu.c $(URCU_SIGNAL)
 test_urcu_signal_yield_CFLAGS = -DRCU_SIGNAL -DDEBUG_YIELD $(AM_CFLAGS)
 
+test_urcu_fork_SOURCES = test_urcu_fork.c $(URCU)
 
 test_rwlock_timing_SOURCES = test_rwlock_timing.c $(URCU_SIGNAL)
 
diff --git a/tests/test_urcu_fork.c b/tests/test_urcu_fork.c
new file mode 100644
index 0000000..07c521a
--- /dev/null
+++ b/tests/test_urcu_fork.c
@@ -0,0 +1,141 @@
+/*
+ * test_urcu_fork.c
+ *
+ * Userspace RCU library - test program (fork)
+ *
+ * Copyright February 2012 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#define _GNU_SOURCE
+#include "../config.h"
+#include <stdio.h>
+#include <pthread.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <assert.h>
+#include <sched.h>
+#include <errno.h>
+
+#include <urcu/arch.h>
+#include <urcu/tls-compat.h>
+
+#ifndef DYNAMIC_LINK_TEST
+#define _LGPL_SOURCE
+#else
+#define rcu_debug_yield_read()
+#endif
+#include <urcu.h>
+
+struct test_node {
+	int somedata;
+	struct rcu_head head;
+};
+
+static void cb(struct rcu_head *head)
+{
+	struct test_node *node;
+
+	fprintf(stderr, "rcu callback invoked in pid: %d\n",
+		(int) getpid());
+	node = caa_container_of(head, struct test_node, head);
+	free(node);
+}
+
+static void test_rcu(void)
+{
+	struct test_node *node;
+
+	rcu_register_thread();
+
+	synchronize_rcu();
+
+	rcu_read_lock();
+	rcu_read_unlock();
+
+	node = malloc(sizeof(*node));
+	assert(node);
+
+	call_rcu(&node->head, cb);
+
+	synchronize_rcu();
+
+	rcu_unregister_thread();
+}
+
+int main(int argc, char **argv)
+{
+	pid_t pid;
+	int ret;
+
+	ret = pthread_atfork(call_rcu_before_fork,
+		call_rcu_after_fork_parent,
+		call_rcu_after_fork_child);
+	if (ret) {
+		errno = ret;
+		perror("pthread_atfork");
+		exit(EXIT_FAILURE);
+	}
+
+	test_rcu();
+
+	synchronize_rcu();
+
+	fprintf(stderr, "%s parent pid: %d, before fork\n",
+		argv[0], (int) getpid());
+
+	pid = fork();
+
+	if (pid == 0) {
+		/* child */
+		fprintf(stderr, "%s child pid: %d, after fork\n",
+			argv[0], (int) getpid());
+		test_rcu();
+		fprintf(stderr, "%s child pid: %d, after rcu test\n",
+			argv[0], (int) getpid());
+	} else if (pid > 0) {
+		int status;
+
+		/* parent */
+		fprintf(stderr, "%s parent pid: %d, after fork\n",
+			argv[0], (int) getpid());
+		test_rcu();
+		fprintf(stderr, "%s parent pid: %d, after rcu test\n",
+			argv[0], (int) getpid());
+		for (;;) {
+			pid = wait(&status);
+			if (WIFEXITED(status)) {
+				fprintf(stderr, "child %u exited normally with status %u\n",
+					pid, WEXITSTATUS(status));
+				break;
+			} else if (WIFSIGNALED(status)) {
+				fprintf(stderr, "child %u was terminated by signal %u\n",
+					pid, WTERMSIG(status));
+				break;
+			} else {
+				continue;
+			}
+		}
+	} else {
+		perror("fork");
+		exit(EXIT_FAILURE);
+	}
+	exit(EXIT_SUCCESS);
+}


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
