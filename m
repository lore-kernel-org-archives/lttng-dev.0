From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Userspace RCU 0.7.15 and 0.8.8
Date: Wed, 9 Sep 2015 18:10:26 +0000 (UTC)
Message-ID: <886050080.2087.1441822226486.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Stephen Hemminger <shemminger@vyatta.com>, Alan Stern <stern@rowland.harvard.edu>
List-Id: lttng-dev@lists.lttng.org

Hi,

liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
data synchronization library provides read-side access which scales
linearly with the number of cores. It does so by allowing multiple
copies of a given data structure to live at the same time, and by
monitoring the data structure accesses to detect grace periods after
which memory reclamation is possible.

liburcu-cds provides efficient data structures based on RCU and
lock-free algorithms. Those structures include hash tables, queues,
stacks, and doubly-linked lists.

Those are bugfix releases for stable-0.7 and stable-0.8 branches.
Small fixes to the tests (volatile in assert() and out of tree test
fix) were not backported to stable-0.7 due to important changes
to the test tree layout between 0.7 and 0.8.

Changelog:
2015-09-09 Userspace RCU 0.7.15
        * Disable sys_membarrier
        * uatomic: Specify complete types for atomic function calls
        * Fix: handle sys_futex() FUTEX_WAIT interrupted by signal
        * Fix: compat_futex.c: *uaddr should be read as volatile
        * Fix: call_rcu_thread() affinity failure
        * urcu: fix deprecation warning with new glibc

2015-09-09 Userspace RCU 0.8.8
        * Disable sys_membarrier
        * Fix: volatile in assert()
        * uatomic: Specify complete types for atomic function calls
        * Fix: handle sys_futex() FUTEX_WAIT interrupted by signal
        * Fix: compat_futex.c: *uaddr should be read as volatile
        * Fix: make benchmark test run in oot build
        * Fix: call_rcu_thread() affinity failure
        * urcu: fix deprecation warning with new glibc

Project website: http://liburcu.org
Git repository: git://git.liburcu.org/urcu.git

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
