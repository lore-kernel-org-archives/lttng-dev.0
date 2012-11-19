From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: userspace rcu flavor improvements
Date: Mon, 19 Nov 2012 12:05:19 -0500
Message-ID: <20121119170519.GB17428__6532.66398371688$1353344757$gmane$org@Krystal>
References: <1353169007-31389-1-git-send-email-mathieu.desnoyers@efficios.com>
	<50A9E532.6000706@cn.fujitsu.com>
	<20121119162307.GE2829@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TaUmf-0005yT-Eu
	for lttng-dev@lists.lttng.org; Mon, 19 Nov 2012 12:05:21 -0500
Content-Disposition: inline
In-Reply-To: <20121119162307.GE2829@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu, Alan Stern <stern@rowland.harvard.edu>
List-Id: lttng-dev@lists.lttng.org

* Paul E. McKenney (paulmck@linux.vnet.ibm.com) wrote:
> On Mon, Nov 19, 2012 at 03:52:18PM +0800, Lai Jiangshan wrote:
> > On 11/18/2012 12:16 AM, Mathieu Desnoyers wrote:
> > > Here are a couple of improvements for all userspace RCU flavors. Many
> > > thanks to Alan Stern for his suggestions.
> > 
> > It makes urcu like SRCU. (sync_rcu = check zero + flip + check zero)
> > If I have time, I may port more SRCU code to urcu.
> 
> I am sure that this is obvious to everyone, but I cannot help restating
> it.  There is one important difference between user code and kernel code,
> though.  In the kernel, we track by CPU, so one of SRCU's big jobs is
> to track multiple tasks using the same CPU.  This opens the possibility
> of preemption, which is one of the things that complicates SRCU's design.
> 
> In contrast, user-mode RCU tracks tasks without multiplexing.  This
> allows simplifications that are similar to those that could be achieved
> in the kernel if we were willing to disable preemption across the entire
> SRCU read-side critical section.
> 
> So although I am all for user-mode RCU taking advantage of any technology
> we have at hand, we do need to be careful to avoid needless complexity.

Very good point! Indeed, when considering modifications to URCU, I will
be considering all of those elements:

- Added complexity (verification cost),
+ Speedup,
+ Lower latency,
+ Better scalability,
+ Lower power consumption,

So yes, I'm all for improving URCU synchronisation, but I might be
reluctant to pull modifications that increase complexity significantly
without very significant benefits.

> 
> > > Patch 8/8 is only done for qsbr so far, and proposed as RFC. I'd like to
> > > try and benchmark other approaches to concurrent grace periods too.
> 
> The concurrent grace periods are the big win, in my opinion.  ;-)

I've done some basic benchmarking on the approach taken by patch 8/8,
and it leads to very interesting scalability improvement and speedups,
e.g., on a 24-core AMD, with a write-heavy scenario (4 readers threads,
20 updater threads, each updater using synchronize_rcu()):

* Serialized grace periods :
./test_urcu_qsbr 4 20 20
SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers   4 rdur      0 wdur      0 nr_writers  20 wdelay      0 nr_reads  20251412728 nr_writes      1826331 nr_ops  20253239059

* Batched grace periods :
./test_urcu_qsbr 4 20 20
SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers   4 rdur      0 wdur      0 nr_writers  20 wdelay      0 nr_reads  15141994746 nr_writes      9382515 nr_ops  15151377261

For a 9382515/1826331 = 5.13 speedup

Of course, we can see that readers have slowed down, probably due to
increased update traffic, given there is no change to the read-side code
whatsoever.

Now let's see the penality of managing the stack for single-updater.
With 4 readers, single updater:

* Serialized grace periods :
./test_urcu_qsbr 4 1 20
SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers   4 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads  19240784755 nr_writes      2130839 nr_ops  19242915594

* Batched grace periods :
./test_urcu_qsbr 4 1 20
SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers   4 rdur      0 wdur      0 nr_writers   1 wdelay      0 nr_reads  19160162768 nr_writes      2253068 nr_ops  1916241583

2253068 vs 2137036 -> a couple of runs show that this difference is lost
in the noise for single updater.

So given that implementing a real "concurrent" approach for grace
periods would take a while and adds a lot of complexity, I am tempted to
merge the batching approach given it does not add complexity to the
synchronization algorithm, and already shows interesting speedup.
Moreover, we can easily remove batching if it appears not to be needed
in the future.

Thoughts ?

Thanks,

Mathieu


> 
> 							Thanx, Paul
> 
> > > Feedback is welcome,
> > > 
> > > Thanks,
> > > 
> > > Mathieu
> > > 
> > > 
> > 
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
