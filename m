From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Userspace RCU 0.8.11, 0.9.5, 0.10.1
Date: Tue, 23 Jan 2018 20:34:10 +0000 (UTC)
Message-ID: <2066090908.8090.1516739650023.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Stephen Hemminger <stephen@networkplumber.org>, Alan Stern <stern@rowland.harvard.edu>, Lai Jiangshan <jiangshanlai@gmail.com>
List-Id: lttng-dev@lists.lttng.org

Hi,

This is a set of releases for the stable branches of the Userspace
RCU library.

liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
data synchronization library provides read-side access which scales
linearly with the number of cores. It does so by allowing multiple
copies of a given data structure to live at the same time, and by
monitoring the data structure accesses to detect grace periods after
which memory reclamation is possible.

liburcu-cds provides efficient data structures based on RCU and
lock-free algorithms. Those structures include hash tables, queues,
stacks, and doubly-linked lists.

On versions 0.8 and 0.9, the fixes introduced target pretty much only
the Cygwin port.

On 0.10, the use of SHARED membarrier by liburcu-bp is removed,
because this kernel system call sometimes takes between 10-100ms
to execute, which is not acceptable for some workloads. Note:
a new PRIVATE_EXPEDITED membarrier is introduced in kernel 4.14,
and the next version of liburcu will use it when available [1].

Changelog:

2018-01-23 Userspace RCU 0.8.11
        * Fix: don't use overlapping mmap mappings on Cygwin
        * Tests fix: add missing Cygwin thread id
        * Fix: assignment from incompatible pointer type warnings
        * Tests fix: unused variable warnings

2018-01-23 Userspace RCU 0.9.5
        * Fix: don't use overlapping mmap mappings on Cygwin
        * Fix: don't use membarrier SHARED syscall command in liburcu-bp
        * Tests fix: add missing Cygwin thread id
        * Fix: assignment from incompatible pointer type warnings
        * Tests fix: unused variable warnings

2018-01-23 Userspace RCU 0.10.1
        * Fix: don't use overlapping mmap mappings on Cygwin
        * Fix: don't use membarrier SHARED syscall command in liburcu-bp
        * Tests fix: add missing Cygwin thread id
        * Fix: assignment from incompatible pointer type warnings
        * Tests fix: unused variable warnings
        * Fix: add missing m68k headers to dist

[1] http://lttng.org/blog/2018/01/15/membarrier-system-call-performance-and-userspace-rcu/

Project website: http://liburcu.org
Git repository: git://git.liburcu.org/urcu.git

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
