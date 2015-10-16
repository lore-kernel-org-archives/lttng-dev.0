From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Userspace RCU 0.7.16 (end of life)
Date: Fri, 16 Oct 2015 20:07:28 +0000 (UTC)
Message-ID: <507501229.63349.1445026048287.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Stephen Hemminger <shemminger@vyatta.com>, Alan Stern <stern@rowland.harvard.edu>
List-Id: lttng-dev@lists.lttng.org

liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
data synchronization library provides read-side access which scales
linearly with the number of cores. It does so by allowing multiple
copies of a given data structure to live at the same time, and by
monitoring the data structure accesses to detect grace periods after
which memory reclamation is possible.

liburcu-cds provides efficient data structures based on RCU and
lock-free algorithms. Those structures include hash tables, queues,
stacks, and doubly-linked lists.

This is a bugfix-only release.

With the new release of Userspace RCU 0.9.0, this means the stable-0.7
liburcu branch has reached end of life, and 0.7.16 will therefore be
the last release of that branch. You are encouraged to upgrade to the
latest 0.8.x or 0.9.x versions of liburcu.

Changelog:
2015-10-16 Userspace RCU 0.7.16
        * Fix: format string signedness
        * Use gcc atomics on aarch64/powerpc64le
        * Fix: compat_futex: uninitialized ret variable
        * Fix: compat_futex_noasync: don't override return value
        * Fix: stable-0.7 branch does not have syscall-compat.h
        * Fix: dynamic fallback to compat futex on sys_futex ENOSYS

Project website: http://liburcu.org
Git repository: git://git.liburcu.org/urcu.git

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
