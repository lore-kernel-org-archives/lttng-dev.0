From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Coding blog: lockless queues
Date: Thu, 10 Jan 2013 11:59:42 -0500
Message-ID: <20130110165942.GA5133__16571.252703625$1357837231$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TtLTk-00063q-GR
	for lttng-dev@lists.lttng.org; Thu, 10 Jan 2013 11:59:44 -0500
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: rp@svcs.cs.pdx.edu, lttng-dev@lists.lttng.org, Alan Stern <stern@rowland.harvard.edu>, Stephen Hemminger <shemminger@vyatta.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

Hi Rusty!

I've stumbled on your blog post: http://rusty.ozlabs.org/?p=317

and I find that you looked at the RCU lock-free queue implementation in
the Userspace RCU project, but not at the wait-free concurrent queue
implementation we have (wait-free enqueue, blocking dequeue), which does
not require RCU at all and might be a much better fit for what you are
trying to achieve.

A quick pointer to the implementation:

git://git.lttng.org/userspace-rcu.git  master branch
files:

urcu/wfcqueue.h (public API)
urcu/static/wfcqueue.h (API implementation)
(https://git.lttng.org/?p=userspace-rcu.git;a=blob;f=urcu/static/wfcqueue.h;h=4b3535aaa83207a4f4eb801dc63150bef8f28bbc;hb=HEAD)

Some nice features of this wfcqueue is to allow this:

- enqueue is wait-free (uses xchg() and store),
- splice (a kind of dequeue_all) from queue is only needs mutual
  exclusion with other dequeue, but not with other splice. We call it
  "blocking" because it may have to busy-wait if enqueue is preempted
  between xchg and store,
- synchronization needed when iterating on the queue (so we wait for
  store to complete if we reach a node being enqueued) is performed
  at the very last moment where it is needed: this is why we provide
  "first" and "next" iterators.
- we also support "dequeue", to dequeue nodes one by one. The dequeue
  operation needs mutual exclusion against other dequeue acting on that
  queue (and against first/next iterators).

I'd be very interested to hear feedback from you on this implementation.

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
