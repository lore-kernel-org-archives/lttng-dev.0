From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: urcu stack and queues updates and documentation
Date: Tue, 23 Oct 2012 08:50:05 -0400
Message-ID: <20121023125005.GA21311__14346.0626750768$1350996643$gmane$org@Krystal>
References: <20121014175332.GA2947@Krystal>
	<20121016213727.GL2385@linux.vnet.ibm.com>
	<20121017151946.GA14514@Krystal>
	<20121022174410.GT2518@linux.vnet.ibm.com>
	<20121023021202.GB13737@Krystal> <20121023122926.GA20944@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TQdvq-0005n5-MU
	for lttng-dev@lists.lttng.org; Tue, 23 Oct 2012 08:50:06 -0400
Content-Disposition: inline
In-Reply-To: <20121023122926.GA20944@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> * Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> > * Paul E. McKenney (paulmck@linux.vnet.ibm.com) wrote:
> > > On Wed, Oct 17, 2012 at 11:19:46AM -0400, Mathieu Desnoyers wrote:
> > > > * Paul E. McKenney (paulmck@linux.vnet.ibm.com) wrote:
> > > > > On Sun, Oct 14, 2012 at 01:53:32PM -0400, Mathieu Desnoyers wrote:
> > > > > > Hi Paul!
> > > > > > 
> > > > > > I know you are currently looking at documentation of urcu data
> > > > > > structures. I did quite a bit of work in that area these past days. Here
> > > > > > is my plan:
> > > > > 
> > > > > Actually, I diverted to the atomic operations, given that the stack/queue
> > > > > API seems to be in flux.  ;-)
> > > > 
> > > > That sounds like a wise decision ;-)
> > > > 
> > > > > > 1) I would like to deprecate, at some point, rculfqueue, wfqueue, and
> > > > > >    rculfstack.
> > > > > > 
> > > > > > 2) For wfqueue, we replace it by wfcqueue, currently in the urcu master
> > > > > >    branch.
> > > > > > 
> > > > > > 3) For rculfstack, we replace it by lfstack available here (volatile
> > > > > >    branch):
> > > > > > 
> > > > > > git://git.dorsal.polymtl.ca/~compudj/userspace-rcu
> > > > > > branch: urcu/lfstack
> > > > > 
> > > > > I probably have to document them to have any chance of having an opinion,
> > > > > other than my usual advice to avoid disrupting users of the old interfaces.
> > > > 
> > > > My general plan is to leave the old interfaces in place, marking them as
> > > > "deprecated" by adding a __attribute__((deprecated("This interface is deprecated. Please refer to urcu/xxxqueue.h for its replacement."))).
> > > > Then we'll be able to drop the deprecated interfaces in a couple of
> > > > versions.
> > > 
> > > Fair enough.  Should enough users protest, we can of course leave them
> > > in place.
> > 
> > OK.

FYI, wfqueue and rculfstack are now deprecated:

commit 147485105cf7b5c8ea96d7f68df973b9c5a94e8e
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Tue Oct 23 08:43:33 2012 -0400

    Deprecate wfqueue
    
    Replaced by "wfcqueue", which has a semantic that allows placing head
    and tail on different cache lines, and does not allocate memory
    internally. wfqueue users can easily migrate to wfcqueue.
    
    We choose to deprecate wfqueue rather than reimplementing it on top of
    wfcqueue to ensure we keep strong ABI compatibility for existing wfqueue
    users.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit d89ec7629b8cafdc12e619cf5f07ceb5b0279275
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Tue Oct 23 08:36:42 2012 -0400

    Deprecate rculfstack
    
    Replaced by "lfstack", which has a less restrictive semantic, and covers
    rculfstack completely.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

wfstack is kept as-is (and has been recently extended with pop_all(),
iterators, and empty() APIs). rculfqueue needs more work. I'd be tempted
not to detail rculfqueue in the upcoming LWN article, but detailing
wfqueue, wfstack and lfstack should be fine.

Thanks!

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
