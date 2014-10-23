From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Userspace RCU: workqueue with batching, cheap wakeup,
 and work stealing
Date: Thu, 23 Oct 2014 16:23:01 +0000 (UTC)
Message-ID: <1736995491.608.1414081381945.JavaMail.zimbra__23931.7434993156$1414081435$gmane$org@efficios.com>
References: <836028170.11148.1413630118955.JavaMail.zimbra@efficios.com>
 <1521253780.11371.1413666790992.JavaMail.zimbra@efficios.com>
 <54478D8E.1080608@cn.fujitsu.com>
 <1569300159.298.1413976834389.JavaMail.zimbra@efficios.com>
 <54488392.2030008@cn.fujitsu.com> <5448CA38.2010801@cn.fujitsu.com>
 <984401415.431.1414071012829.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XhLAO-0002ji-8d
 for lttng-dev@lists.lttng.org; Thu, 23 Oct 2014 12:23:14 -0400
In-Reply-To: <984401415.431.1414071012829.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ben Maurer <bmaurer@fb.com>, Yannick Brosseau <scientist@fb.com>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> To: "Lai Jiangshan" <laijs@cn.fujitsu.com>
> Cc: "lttng-dev" <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "Ben Maurer"
> <bmaurer@fb.com>, "Yannick Brosseau" <scientist@fb.com>
> Sent: Thursday, October 23, 2014 9:30:12 AM
> Subject: Re: [lttng-dev] Userspace RCU: workqueue with batching, cheap wakeup, and work stealing
> 
> ----- Original Message -----
> > From: "Lai Jiangshan" <laijs@cn.fujitsu.com>
> > To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "lttng-dev"
> > <lttng-dev@lists.lttng.org>, "Ben Maurer"
> > <bmaurer@fb.com>, "Yannick Brosseau" <scientist@fb.com>
> > Sent: Thursday, October 23, 2014 5:28:24 AM
> > Subject: Re: [lttng-dev] Userspace RCU: workqueue with batching, cheap
> > wakeup, and work stealing
> > 
> > Hi Mathieu:
> > 
> > what happen when the wait_node is still queued when
> > urcu_worker_unregister()
> > is called?
> 
> Hrm, I think this could indeed be an issue. I'm thinking to add a "shutdown"
> mode to the workqueue (similarly to folly lifosem). Perhaps this could help
> us handling this situation.
> 
> > 
> > On 10/23/2014 12:26 PM, Lai Jiangshan wrote:
> [...]
> > > 
> > > Hi, Mathieu
> > > 
> > > In the code, how this problem be solved?
> > > "All the tasks may continue stealing works without any progress."
> > 
> > Can __urcu_wakeup_siblings() be moved to the end of the
> > urcu_dequeue_work()?
> 
> It might help, but I don't think it would solve the theoretical
> lack-of-progress issue. If we are in a state where all workers threads
> are running, none need to be awakened to steal work, and they could fall
> into an endless cycle of work-stealing followed by facing an empty work
> queue due to another concurrent stealing. I think getting threads to keep
> one work item for themselves when they grab work from the global queue
> or steal work offers better forward progress guarantees in this case.
> 
> > 
> > > 
> > > Why ___urcu_steal_work() needs cds_wfcq_dequeue_lock()?
> > Sorry, it does need, it locks the source queue...
> > but we have cds_wfcq_splice_blocking() which wrap the locking and the
> > splicing.
> 
> Yes,
> 
> > 
> > > 
> > > It is not a good idea for a worker to call synchronize_rcu() (in
> > > urcu_accept_work()).
> > > A new work may be coming soon.
> > 
> > 
> > I suggest to add a new API:
> > __cds_lfs_pop_if(stack, expect) {
> > 	atomic {
> > 		if the top == expect {
> > 			pop it;
> > 		}
> > 	}
> > }
> > 
> > Then all the worker can only be woken up by urcu_adaptative_wake_up(),
> > rather than urcu_dequeue_wake_single().
> > 
> > workers dequeues itself when successfully urcu_accept_work() by using
> > __cds_lfs_pop_if().
> 
> There is something I don't like about this approach: what if, for some
> reason, a worker being awakened takes a lot of time to start running.
> It would therefore stall the entire waitqueue until it can be executed
> and pop itself from the waitqueue.

All the above comments should be taken care of by this string of commits:

commit a649215929e3af5a0dd26d9fc5bb9ed49e677773
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Thu Oct 23 12:19:31 2014 -0400

    workqueue: keep one work item from stealing co-workers
    
    Takes care of lack of progress issue that could theoretically occur due
    to a steady work-stealing circular loop amongst co-workers. Keeping a
    work item hidden from co-workers ensures forward progress.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit 6e17009c7e4276b3a90aada07e7c9835e9a788be
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Thu Oct 23 11:27:58 2014 -0400

    workqueue: ensure worker is removed from waitqueue upon unregister
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit 1b0a9891cd2f9100dc87745d77a4d0069a21adb7
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Thu Oct 23 11:13:24 2014 -0400

    workqueue: implement shutdown
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit 0695bd205e8aa88b3b032f483b7dc98c16450784
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Thu Oct 23 09:01:29 2014 -0400

    workqueue: use cds_wfcq_splice_blocking() rather than explicit locks
    
    cds_wfcq_splice_blocking() internally takes the locks.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Please let me know if I missed anything,

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
