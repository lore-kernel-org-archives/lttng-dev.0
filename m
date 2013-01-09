From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Userspace RCU 0.6.9
Date: Wed, 9 Jan 2013 13:39:11 -0500
Message-ID: <20130109183911.GA14358@Krystal>
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

This is a bugfix release for the stable-0.6 series of the Userspace RCU
library. It fixes a hang in use-case where call_rcu is used in a parent
process that performs a fork(), without following exec(), and then
continues to use call_rcu or synchronize_rcu.

Changelog:
2013-01-09 Userspace RCU 0.6.9
        * API cleanup: use "uatomic_*" in cmm_smp_mb__ API
        * uatomic: add memory barrier API for and/or/add/sub/inc/sub
        * Fix uatomic sign cast
        * Discourage use of pthread_atfork() for call_rcu handlers
        * Fix call_rcu fork handling
        * test: fork handling

Project website: http://lttng.org/urcu
Download link: http://lttng.org/files/urcu/

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
