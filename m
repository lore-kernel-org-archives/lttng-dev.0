From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Userspace RCU: workqueue with batching, cheap wakeup,
 and work stealing
Date: Sat, 18 Oct 2014 21:13:10 +0000 (UTC)
Message-ID: <1521253780.11371.1413666790992.JavaMail.zimbra__13952.9151646004$1413666872$gmane$org@efficios.com>
References: <836028170.11148.1413630118955.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XfbJT-0008MY-AB
 for lttng-dev@lists.lttng.org; Sat, 18 Oct 2014 17:13:29 -0400
In-Reply-To: <836028170.11148.1413630118955.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Ben Maurer <bmaurer@fb.com>, lttng-dev <lttng-dev@lists.lttng.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Yannick Brosseau <scientist@fb.com>
List-Id: lttng-dev@lists.lttng.org

Hi,

I have written an implementation of a workqueue based
on wfcqueue (fifo workqueue), wfstack (lifo wait queue)
including a work-stealing scheme. I think this could
scale very naturally to large workloads, and it skips
the overhead of sys_futex when wakees are already running.
Since the wakeup scheme is very lightweight when work
is ongoing, we use it extensively.

It also makes extensive use of wfcqueue "splice" operation
to move work batch in bulk amongst queue and worker
threads. It is a O(1) operation which does not need to
touch the content of the queue.

RCU is used to lookup the sibling worker threads for
work stealing and to wake the siblings of a thread
busy handling work.

It's at:

git://git.urcu.so/urcu.git
branch: urcu/workqueue-wakeup

or gitweb of the top commit:
http://git.lttng.org/?p=userspace-rcu.git;a=commit;h=2c6a5414ed2ab44be24211d15a5d9f1f40dbfc74

Note that this is work in progress, compile-tested only.
I also need to write extensive tests.

Feedback is welcome,

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
