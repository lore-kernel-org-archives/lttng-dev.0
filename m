From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Userspace RCU 0.12.1, 0.11.2, 0.10.3, 0.9.7
Date: Wed, 22 Apr 2020 09:13:19 -0400 (EDT)
Message-ID: <1277451188.63391.1587561199034.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Stephen Hemminger <stephen@networkplumber.org>, Alan Stern <stern@rowland.harvard.edu>, Lai Jiangshan <jiangshanlai@gmail.com>
List-Id: lttng-dev@lists.lttng.org

Hi,

This is a release announcement for the liburcu project. Those releases
are bugfix only releases within each of the currently supported
branches: 0.12.1, 0.11.2, 0.10.3, 0.9.7.

Note that the 0.9.7 and 0.10.3 releases mark the end of life of the
stable-0.9 and stable-0.10 branches. Users should upgrade to 0.11.x
or 0.12.x for an actively maintained liburcu.

* Noteworthy in these releases

One relevant fix included in all of those releases applies to tls-compat.h.
It fixes use-cases where liburcu is compiled with a compiler detecting that
_Thread_local should be used for TLS, but an application using tls-compat.h
uses an older compiler which does not support _Thread_local.

The 0.10.3 and 0.11.2 releases include a fix for a hang when using the
RCU lock-free hash table with the signal-based urcu flavor. (urcu-signal)


liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
data synchronization library provides read-side access which scales
linearly with the number of cores. It does so by allowing multiple
copies of a given data structure to live at the same time, and by
monitoring the data structure accesses to detect grace periods after
which memory reclamation is possible.

liburcu-cds provides efficient data structures based on RCU and
lock-free algorithms. Those structures include hash tables, queues,
stacks, and doubly-linked lists.

Project website: http://liburcu.org
Git repository: git://git.liburcu.org/urcu.git

Enjoy!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
