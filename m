From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Userspace RCU 0.7.8
Date: Fri, 6 Sep 2013 08:05:54 -0400
Message-ID: <20130906120554.GA28647@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
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

This is a bugfix-only release.

Changelog:

2013-09-06 Userspace RCU 0.7.8
        * Fix: hash table growth (for small tables) should be limited
        * Document build work-around on MacOS X
        * Fix tests: use of uninitialized variables
        * tests: add missing unsigned long casts to pthread_self()

Project website: http://lttng.org/urcu
Download link: http://lttng.org/files/urcu/

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
