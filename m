From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: [RFC] Feedback on 2 development branches: wfstack
	and lfstack
Date: Mon, 15 Oct 2012 11:00:17 +0800
Message-ID: <507B7C41.60208__40549.9439606958$1350269903$gmane$org@cn.fujitsu.com>
References: <20121013181231.GA32276@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1TNasJ-0004qG-EX
	for lttng-dev@lists.lttng.org; Sun, 14 Oct 2012 22:57:51 -0400
In-Reply-To: <20121013181231.GA32276@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, lttng-dev@lists.lttng.org, Lai Jiangshan <eag0628@gmail.com>
List-Id: lttng-dev@lists.lttng.org

On 10/14/2012 02:12 AM, Mathieu Desnoyers wrote:
> Hi!
> 
> I started modifying the stack APIs to reflect the changes we did for
> wfcqueue, and also add pop_all() and iterators.
> 
> The volatile dev branches are available at:
> 
> http://git.dorsal.polymtl.ca/~compudj?p=userspace-rcu;a=shortlog;h=refs/heads/urcu/lfstack

I don't see the value of introducing struct cds_lfs_head.
It can force the users to use for_each() for the return value of pop_all().
Is it its purpose?

thr_dequeuer() of a8edcc02a25328647f91b4bbe8207e8cdfd317d3 is too complicated.
( I don't see the value of @counter)

do {
	...
	if (test_pop) {
		test_lfs_pop;
	}
	if (test_pop_all) {
		test_lfs_pop_all;
	}
	...
} while();





> or 
> git://git.dorsal.polymtl.ca/~compudj/userspace-rcu
> branch: urcu/lfstack
> 
> http://git.dorsal.polymtl.ca/~compudj?p=userspace-rcu;a=shortlog;h=refs/heads/urcu/wfstack
> or
> git://git.dorsal.polymtl.ca/~compudj/userspace-rcu
> branch: urcu/wfstack
> 
> Sorry for not sending patches, I'm a bit time-constrained this weekend.
> I am sending these links right away for review, because I think it might
> be good to pull these commits into the master branch before we proceed
> to other changes. And I want to minimize the amount of duplicated effort
> between Lai and myself.
> 
> One of my next step will be to document the wfstack and lfstack APIs
> more thoroughly (similarly to what we did for wfcqueue).
> 
> Then, my following step will be to see if I can implement a lfcqueue
> API, derived from wfcqueue, but with lock-free enqueue semantic (a mix
> of wfcqueue and rculfqueue).
> 
> Feedback is welcome!
> 
> Thanks,
> 
> Mathieu
> 
> 
