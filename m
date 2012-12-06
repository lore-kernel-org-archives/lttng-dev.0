From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [URCU pull request review] urcu improvements
Date: Thu, 6 Dec 2012 05:39:13 -0500
Message-ID: <20121206103913.GA29563__39900.7656415508$1354790409$gmane$org@Krystal>
References: <1353440429-19223-1-git-send-email-mathieu.desnoyers@efficios.com>
	<50C01812.7060400@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TgYrQ-0005ig-2U
	for lttng-dev@lists.lttng.org; Thu, 06 Dec 2012 05:39:20 -0500
Content-Disposition: inline
In-Reply-To: <50C01812.7060400@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alan Stern <stern@rowland.harvard.edu>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

* Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> ACK for the whole patchset.

Thanks!

Unfortunately, the commits are already in the master branch, so I won't
be able to edit the changelogs to add the acked-by tag, but I really
appreciate your ack on the changeset.

Mathieu

> 
> Thanks,
> Lai
> 
> On 11/21/2012 03:40 AM, Mathieu Desnoyers wrote:
> > Here is a pull request to myself for my recent work on wfcqueue and urcu
> > flavors into the userspace RCU master branch.
> > 
> > Please let me know if you see any immediate show stoppers.
> > 
> > List of changes:
> > 
> > [PATCH 01/16] Fix: wfcqueue nonblocking dequeue
> > [PATCH 02/16] wfcqueue: enqueue and splice return queue state
> > [PATCH 03/16] test wfcqueue: add tests for queue state return value
> > [PATCH 04/16] urcu-call-rcu: use wait-free splice return value
> > [PATCH 05/16] wfcqueue: document empty criterion
> > [PATCH 06/16] wfcqueue: implement mutex-free splice
> > [PATCH 07/16] urcu-qsbr: improve 2-phase wait scheme
> > [PATCH 08/16] urcu-mb/signal/membarrier: improve 2-phase wait scheme
> > [PATCH 09/16] urcu-bp: improve 2-phase wait scheme
> > [PATCH 10/16] urcu-qsbr: move offline threads to separate list
> > [PATCH 11/16] urcu-mb/signal/membarrier: move quiescent threads to
> > [PATCH 12/16] urcu-bp: move quiescent threads to separate list
> > [PATCH 13/16] tests: use standard malloc/free for synchronize_rcu()
> > [PATCH 14/16] urcu-qsbr: batch concurrent synchronize_rcu()
> > [PATCH 15/16] urcu-wait: move wait code into separate file
> > [PATCH 16/16] urcu-wait: move queue management code into urcu-wait.h
> > 
> > diffstat:
> > 
> >  Makefile.am             |    2 
> >  tests/test_urcu.c       |   60 ++------------
> >  tests/test_urcu_bp.c    |   59 ++------------
> >  tests/test_urcu_qsbr.c  |   61 ++-------------
> >  tests/test_urcu_wfcq.c  |  131 +++++++++++++++++++++++++-------
> >  urcu-bp.c               |   88 ++++++++++++++-------
> >  urcu-call-rcu-impl.h    |    9 +-
> >  urcu-qsbr.c             |  193 ++++++++++++++++++++++++++++++++++++------------
> >  urcu-wait.h             |  184 +++++++++++++++++++++++++++++++++++++++++++++
> >  urcu.c                  |   95 +++++++++++++++--------
> >  urcu/static/urcu-bp.h   |   29 ++++---
> >  urcu/static/urcu-qsbr.h |   14 ++-
> >  urcu/static/urcu.h      |   15 ++-
> >  urcu/static/wfcqueue.h  |  133 +++++++++++++++++++++++++--------
> >  urcu/wfcqueue.h         |   62 +++++++++++----
> >  wfcqueue.c              |   16 +--
> >  16 files changed, 786 insertions(+), 365 deletions(-)
> > 
> > Thanks,
> > 
> > Mathieu
> > 
> > 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
