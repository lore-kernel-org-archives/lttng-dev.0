From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Userspace RCU 0.8.6
Date: Tue, 4 Nov 2014 16:10:35 +0000 (UTC)
Message-ID: <2125074956.7393.1415117435081.JavaMail.zimbra@efficios.com>
References: <2018499994.7387.1415117259378.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2018499994.7387.1415117259378.JavaMail.zimbra@efficios.com>
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

This is a bugfix release. There is one noteworthy fix that has an
impact on the lfstack API: the return value of cds_lfs_push(), which
indicates whether the stack content was empty prior to the push,
was logically reversed compared to the API documentation (and compared
to its queue counterpart). This bug was introduced in the Userspace RCU
0.8.0 release.

Changelog:
2014-11-04 Userspace RCU 0.8.6
        * Fix: silence gcc -Wextra warning
        * compiler: use __GNUC__ instead of the undefined __GNUC_MAJOR__
        * Fix: lfstack reversed empty/non-empty return value
        * lfstack: fix: add missing __cds_lfs_init

Project website: http://urcu.so
Git repository: git://git.urcu.so/urcu.git

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
