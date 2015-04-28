From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Userspace RCU 0.7.14 and 0.8.7
Date: Tue, 28 Apr 2015 19:03:32 +0000 (UTC)
Message-ID: <494761687.39781.1430247812360.JavaMail.zimbra@efficios.com>
References: <1682718787.39775.1430247648847.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1682718787.39775.1430247648847.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Stephen Hemminger <shemminger@vyatta.com>, Alan Stern <stern@rowland.harvard.edu>
List-Id: lttng-dev@lists.lttng.org

Here are two new releases of userspace RCU for the 0.7 and 0.8
stable branches currently maintained. Those are bugfix releases.

liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
data synchronization library provides read-side access which scales
linearly with the number of cores. It does so by allowing multiples
copies of a given data structure to live at the same time, and by
monitoring the data structure accesses to detect grace periods after
which memory reclamation is possible.

liburcu-cds provides efficient data structures based on RCU and
lock-free algorithms. Those structures include hash tables, queues,
stacks, and doubly-linked lists.

Changelog for Userspace RCU 0.7.14:
2015-04-28 Userspace RCU 0.7.14
        * Fix: call rcu should call internal RCU API
        * Fix: deadlock when thread join is issued in read-side C.S.
        * Fix: rename RCU_DEBUG to DEBUG_RCU in urcu-qsbr.h
        * Mark braced-groups within expressions with __extension__
        * Fix: compat_futex_noasync race condition
        * Fix: documentation: urcu-pointer.h: s/rcu_dereference_pointer/rcu_dereference/
        * Fix: silence gcc -Wextra warning

Changelog for Userspace RCU 0.8.7:
2015-04-28 Userspace RCU 0.8.7
        * Fix: deadlock when thread join is issued in read-side C.S.
        * Fix: rename RCU_DEBUG to DEBUG_RCU in urcu-qsbr.h
        * Mark braced-groups within expressions with __extension__
        * Fix: compat_futex_noasync race condition
        * Fix: documentation: urcu-pointer.h: s/rcu_dereference_pointer/rcu_dereference/
        * Fix: call rcu should call internal RCU API

Project website: http://urcu.so
Git repository: git://git.urcu.so/urcu.git

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
