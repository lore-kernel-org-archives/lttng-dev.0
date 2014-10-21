From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Userspace RCU 0.8.5
Date: Tue, 21 Oct 2014 19:07:26 +0000 (UTC)
Message-ID: <800134692.13121.1413918446140.JavaMail.zimbra@efficios.com>
References: <1559520247.13120.1413918433728.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1559520247.13120.1413918433728.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Stephen Hemminger <shemminger@vyatta.com>, Alan Stern <stern@rowland.harvard.edu>
List-Id: lttng-dev@lists.lttng.org

liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
data synchronization library provides read-side access which scales
linearly with the number of cores. It does so by allowing multiples
copies of a given data structure to live at the same time, and by
monitoring the data structure accesses to detect grace periods after
which memory reclamation is possible.

liburcu-cds provides efficient data structures based on RCU and
lock-free algorithms. Those structures include hash tables, queues,
stacks, and doubly-linked lists.

This is a bugfix release.

Changelog:
2014-10-21 Userspace RCU 0.8.5
        * Fix: preserve example files' timestamps when copying
        * rculfhash: remove duplicated code
        * rculfhash: handle pthread_create failures
        * rculfhash: fall back to single-threaded resize on calloc failure
        * x86: drop extra semi-colon in caa_cpu_relax
        * Fix: Use after free in rcu_barrier()
        * Fix: rcu_barrier(): uninitialized futex field
        * call_rcu threads should clear their PAUSED flag when they unpause
        * Fix: bring back dummy rcu_bp_exit symbol

Project website: http://urcu.so
Git repository: git://git.urcu.so/urcu.git

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
