From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH Userspace RCU] Discourage use of pthread_atfork() for
	call_rcu handlers
Date: Wed, 26 Dec 2012 12:33:18 -0500
Message-ID: <20121226173318.GA22298@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <libc-alpha-return-35525-glibc-alpha=m.gmane.org@sourceware.org>
Content-Disposition: inline
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Alan Stern <stern@rowland.harvard.edu>, Stephen Hemminger <shemminger@vyatta.com>
Cc: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu, libc-alpha@sourceware.org
List-Id: lttng-dev@lists.lttng.org

Discourage use of glibc pthread_atfork() for call_rcu handlers due to
its inappropriate assumptions about single-threadedness while pthread
atfork handlers are executing. This results in hangs within the glibc
memory allocator.
    
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/README b/README
index 83330ea..2d29c1d 100644
--- a/README
+++ b/README
@@ -273,7 +273,20 @@ Interaction with fork()
 	must invoke call_rcu_before_fork() before the fork() and
 	call_rcu_after_fork_parent() after the fork().  The child
 	process must invoke call_rcu_after_fork_child().
-	These three APIs are suitable for passing to pthread_atfork().
+	Even though these three APIs are suitable for passing to
+	pthread_atfork(), use of pthread_atfork() is *STRONGLY
+	DISCOURAGED* for programs calling the glibc memory allocator
+	(malloc(), calloc(), free(), ...) within call_rcu callbacks.
+	This is due to limitations in the way glibc memory allocator
+	handles calls to the memory allocator from concurrent threads
+	while the pthread_atfork() handlers are executing.
+	Combining e.g.:
+	* call to free() from callbacks executed within call_rcu worker
+	  threads,
+	* executing call_rcu atfork handlers within the glibc pthread
+	  atfork mechanism,
+	will sometimes trigger interesting process hangs. This usually
+	hangs on a memory allocator lock within glibc.
 
 Thread Local Storage (TLS)
 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
