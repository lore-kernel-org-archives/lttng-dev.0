From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Userspace RCU 0.7.9
Date: Tue, 12 Nov 2013 17:24:19 +0000 (UTC)
Message-ID: <1977064126.65236.1384277059506.JavaMail.zimbra@efficios.com>
References: <119843495.65234.1384277039175.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <119843495.65234.1384277039175.JavaMail.zimbra@efficios.com>
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

Changelog:
2013-11-12 Userspace RCU 0.7.9
        * tls-compat: fix comment typo
        * Keep ABI compatible with already compiled LGPL applications
        * Fix: tls-compat multi-lib conflict
        * gcc warning fixes: -Wsign-compare and -Wextra
        * Fix: urcu-qsbr: reversed logic on RCU_DEBUG
        * Fix: urcu-bp segfault in glibc pthread_kill()
        * Fix urcu-bp: don't move registry
        * Fix: compat futex duplicated lock and completion
        * Fix: i386 compat code duplicated mutex instances
        * Fix: urcu-bp: Bulletproof RCU arena resize bug
        * Fix: test_mutex.c uninitialized mutex

Project website: http://urcu.so
Download link: http://urcu.so/files/
Git repository: git://git.urcu.so/urcu.git

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
