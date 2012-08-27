From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Userspace RCU 0.7.4
Date: Mon, 27 Aug 2012 08:21:11 -0400
Message-ID: <20120827122111.GA1935@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
Cc: Ralf Baechle <ralf@linux-mips.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Stephen Hemminger <shemminger@vyatta.com>
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

The main change in this version is the added support for MIPS,
contributed by Ralf Baechle.

Changelog:
2012-08-27 Userspace RCU 0.7.4
        * rculfhash API documentation: document destroy RCU read-lock constraint
        * Fix: rculfhash should be offline while waiting for resize to complete
        * Add missing entry to gitignore
        * urcu: move busy-wait code and name it ___cds_wfq_node_sync_next()
        * urcu: fix compat_futex_noasync()
        * urcu: add hint to DEFINE_URCU_TLS() for compound types
        * Fix: CAA_BUILD_BUG_ON should refer to CAA_BUILD_BUG_ON_ZERO
        * Add MIPS support
        * Compatibility: remove bash-ismsm from test scripts
        * Fix inappropriate lib behavior: don't call exit()
        * Fix: re-enable compatibility with autoconf < 2.64
        * Fix c99 compatibility: use __asm__ and __volatile__ in public headers
        * Fix c99 compatibility: use __typeof__ instead of typeof in public headers
        * warning fix: tests urcutorture for NetBSD 5

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
