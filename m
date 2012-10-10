From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: [RFC] re-document rculfstack and even rename it
Date: Wed, 10 Oct 2012 15:52:08 +0800
Message-ID: <50752928.3050006__3821.36402554369$1349855426$gmane$org@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1TLr37-0000bF-0d
	for lttng-dev@lists.lttng.org; Wed, 10 Oct 2012 03:49:49 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

rculfstack is not really require RCU-only.

1) cds_lfs_push_rcu() don't need any lock, don't need RCU nor other locks.

2) cds_lfs_pop_rcu() don't only one of the following synchronization(not only RCU):
	A) use rcu_read_lock() to protect cds_lfs_pop_rcu() and use synchronize_rcu()
           or call_rcu() to free the popped node. (current comments said we need this
           synchronization, and thus we named this struct with rcu prefix. But actually,
	   the followings are OK, and are more popular/friendly)
	B) use mutexs/locks to protect cds_lfs_pop_rcu(), we can free to free/modify the
	   popped node any time, we don't need any synchronization when free them.
	C) only ONE thread can call cds_lfs_pop_rcu(). (multi-providers-single customer)
	D) others, like read-write locks.

I consider B) and C) are more popular. In linux kernel,
kernel/task_work.c uses a hybird ways of B) and C).

I suggest to rename it, Or document B) and C) at least.

Thanks,
Lai
