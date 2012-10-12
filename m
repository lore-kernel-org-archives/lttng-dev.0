From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Userspace RCU 0.7.5
Date: Fri, 12 Oct 2012 07:18:35 -0400
Message-ID: <20121012111835.GA15280@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
Cc: Stephen Hemminger <shemminger@vyatta.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
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

This is the start of a stable-0.7 branch to push important fixes. The
master branch development will continue and eventually result in a 0.8.0
release.

Please note that the bug "call_rcu list corruption on teardown" occurs
very rarely, only when invoking call_rcu_data_free() for per-cpu or
per-thread callback-invocation threads (typically before application
exit). The fix for this corruption bug is the same as the fix used in
the stable-0.6 branch. This fix is not needed in the master branch,
because the issue had been already fixed by moving call_rcu to the new
wfcqueue API.

Changelog:
2012-10-12 Userspace RCU 0.7.5
        * Fix: call_rcu list corruption on teardown
        * Ensure that read-side functions meet 10-line LGPL criterion
        * tls-compat.h: document sigaltstack(2) limitation
        * urcu: add notice to URCU_TLS() for it is not strictly async-signal-safe
        * Document sigaltstack(2) limitation
        * Documentation: update LICENSE file

Project website: http://lttng.org/urcu
Download link: http://lttng.org/files/urcu/

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
