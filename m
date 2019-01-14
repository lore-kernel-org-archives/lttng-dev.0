From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Userspace RCU 0.9.6 and 0.10.2
Date: Mon, 14 Jan 2019 14:01:59 -0500 (EST)
Message-ID: <1383390417.474.1547492519675.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Stephen Hemminger <stephen@networkplumber.org>, Alan Stern <stern@rowland.harvard.edu>, Lai Jiangshan <jiangshanlai@gmail.com>
List-Id: lttng-dev@lists.lttng.org

Hi,

Those are bugfix releases of liburcu 0.9 and 0.10 stable branches.

liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
data synchronization library provides read-side access which scales
linearly with the number of cores. It does so by allowing multiple
copies of a given data structure to live at the same time, and by
monitoring the data structure accesses to detect grace periods after
which memory reclamation is possible.

liburcu-cds provides efficient data structures based on RCU and
lock-free algorithms. Those structures include hash tables, queues,
stacks, and doubly-linked lists.

Changelog:

2019-01-14 Userspace RCU 0.10.2
        * Fix: only wait if work queue is empty in real-time mode
        * Fix: don't wait after completion of a work queue job batch
        * Fix: don't wait after completion of job batch if work queue is empty
        * Fix: workqueue: struct urcu_work vs rcu_head mixup
        * Cleanup: workqueue: update comments referring to call-rcu
        * Fix: mixup between URCU_WORKQUEUE_RT and URCU_CALL_RCU_RT
        * test_rwlock: Add per-thread count to verbose output
        * Add *.exe to gitignore for Cygwin
        * Fix: pthread_rwlock initialization on Cygwin
        * Fix: compat_futex_noasync on Cygwin

2019-01-14 Userspace RCU 0.9.6
        * test_rwlock: Add per-thread count to verbose output
        * Add *.exe to gitignore for Cygwin
        * Fix: pthread_rwlock initialization on Cygwin
        * Fix: compat_futex_noasync on Cygwin

Project website: http://liburcu.org
Git repository: git://git.liburcu.org/urcu.git


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
