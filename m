From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC] Feedback on 2 development branches: wfstack and
	lfstack
Date: Sat, 13 Oct 2012 14:12:31 -0400
Message-ID: <20121013181231.GA32276__45647.2686645158$1350151988$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TN6CO-0007WY-Ts
	for lttng-dev@lists.lttng.org; Sat, 13 Oct 2012 14:12:32 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, lttng-dev@lists.lttng.org, Lai Jiangshan <eag0628@gmail.com>
List-Id: lttng-dev@lists.lttng.org

Hi!

I started modifying the stack APIs to reflect the changes we did for
wfcqueue, and also add pop_all() and iterators.

The volatile dev branches are available at:

http://git.dorsal.polymtl.ca/~compudj?p=userspace-rcu;a=shortlog;h=refs/heads/urcu/lfstack
or 
git://git.dorsal.polymtl.ca/~compudj/userspace-rcu
branch: urcu/lfstack

http://git.dorsal.polymtl.ca/~compudj?p=userspace-rcu;a=shortlog;h=refs/heads/urcu/wfstack
or
git://git.dorsal.polymtl.ca/~compudj/userspace-rcu
branch: urcu/wfstack

Sorry for not sending patches, I'm a bit time-constrained this weekend.
I am sending these links right away for review, because I think it might
be good to pull these commits into the master branch before we proceed
to other changes. And I want to minimize the amount of duplicated effort
between Lai and myself.

One of my next step will be to document the wfstack and lfstack APIs
more thoroughly (similarly to what we did for wfcqueue).

Then, my following step will be to see if I can implement a lfcqueue
API, derived from wfcqueue, but with lock-free enqueue semantic (a mix
of wfcqueue and rculfqueue).

Feedback is welcome!

Thanks,

Mathieu


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
