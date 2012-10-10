From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC] re-document rculfstack and even rename it
Date: Wed, 10 Oct 2012 07:59:59 -0700
Message-ID: <20121010145959.GA2495__35025.6773912863$1349883931$gmane$org@linux.vnet.ibm.com>
References: <50752928.3050006@cn.fujitsu.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paulmck@linux.vnet.ibm.com>) id 1TLySy-0004qz-Kw
	for lttng-dev@lists.lttng.org; Wed, 10 Oct 2012 11:45:00 -0400
Received: from /spool/local
	by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 10 Oct 2012 11:44:53 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	q9AFGDlJ6225986
	for <lttng-dev@lists.lttng.org>; Wed, 10 Oct 2012 11:42:09 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id q9AF7NbH019334
	for <lttng-dev@lists.lttng.org>; Wed, 10 Oct 2012 09:07:23 -0600
Content-Disposition: inline
In-Reply-To: <50752928.3050006@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

On Wed, Oct 10, 2012 at 03:52:08PM +0800, Lai Jiangshan wrote:
> rculfstack is not really require RCU-only.
> 
> 1) cds_lfs_push_rcu() don't need any lock, don't need RCU nor other locks.
> 
> 2) cds_lfs_pop_rcu() don't only one of the following synchronization(not only RCU):
> 	A) use rcu_read_lock() to protect cds_lfs_pop_rcu() and use synchronize_rcu()
>            or call_rcu() to free the popped node. (current comments said we need this
>            synchronization, and thus we named this struct with rcu prefix. But actually,
> 	   the followings are OK, and are more popular/friendly)
> 	B) use mutexs/locks to protect cds_lfs_pop_rcu(), we can free to free/modify the
> 	   popped node any time, we don't need any synchronization when free them.
> 	C) only ONE thread can call cds_lfs_pop_rcu(). (multi-providers-single customer)
> 	D) others, like read-write locks.
> 
> I consider B) and C) are more popular. In linux kernel,
> kernel/task_work.c uses a hybird ways of B) and C).
> 
> I suggest to rename it, Or document B) and C) at least.

Good timing -- stacks and queues are next on my list for documentation.  ;-)

							Thanx, Paul
