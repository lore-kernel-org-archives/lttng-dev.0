From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] Userspace RCU 0.12.0
Date: Thu, 9 Apr 2020 14:59:55 -0400 (EDT)
Message-ID: <605758779.29080.1586458795931.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Stephen Hemminger <stephen@networkplumber.org>, Alan Stern <stern@rowland.harvard.edu>, Lai Jiangshan <jiangshanlai@gmail.com>, lwn@lwn.net, Alex Xu <alex_y_xu@yahoo.ca>
List-Id: lttng-dev@lists.lttng.org

Hi,

This announcement introduces the 0.12 version of liburcu.

liburcu is a LGPLv2.1 userspace RCU (read-copy-update) library. This
data synchronization library provides read-side access which scales
linearly with the number of cores. It does so by allowing multiple
copies of a given data structure to live at the same time, and by
monitoring the data structure accesses to detect grace periods after
which memory reclamation is possible.

liburcu-cds provides efficient data structures based on RCU and
lock-free algorithms. Those structures include hash tables, queues,
stacks, and doubly-linked lists.

* New in this release:

This 0.12 liburcu release is mainly done to add a DEFINE_URCU_TLS_INIT
macro to the urcu/tls-compat.h API. There is a very recent unfortunate
situation where a major user of liburcu (lttng-ust 2.12) added a use
of DEFINE_URCU_TLS such as:

  DEFINE_URCU_TLS(ino_t, cached_net_ns) = NS_INO_UNINITIALIZED;

Which builds and runs fine for CONFIG_RCU_TLS, but fails to build for
!CONFIG_RCU_TLS. Fixing this required to extend the API and add a new
DEFINE_URCU_TLS_INIT() which could then be used in this way:

  DEFINE_URCU_TLS_INIT(ino_t, cached_net_ns, NS_INO_UNINITIALIZED);

Support for FreeBSD and DragonFlyBSD is also added in this release,
contributed by Alex Xu. It uses _mutx_op() to implement the liburcu
futex APIs on FreeBSD.

Finally, a noteworthy change has been done to the urcu-bp flavor:
urcu_bp_register_thread() now performs the underlying lazy registration
of the caller thread rather than being a pure no-op. This is useful
for some real-time use-cases (e.g. Xenomai) which require to perform
urcu-bp thread registration early in the thread life-time before it
starts performing real-time tasks.

Thanks,

Mathieu

Project website: http://liburcu.org
Git repository: git://git.liburcu.org/urcu.git

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
