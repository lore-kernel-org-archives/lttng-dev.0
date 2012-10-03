From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [rp] [URCU PATCH 0/3] wait-free concurrent queues
	(wfcqueue)
Date: Wed, 3 Oct 2012 17:04:36 -0400
Message-ID: <20121003210436.GB25090__8233.75783297724$1349391860$gmane$org@Krystal>
References: <20121002141307.GA4057@Krystal>
	<20121003182846.GN2527@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TJW7R-0000wS-RZ
	for lttng-dev@lists.lttng.org; Wed, 03 Oct 2012 17:04:37 -0400
Content-Disposition: inline
In-Reply-To: <20121003182846.GN2527@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev@lists.lttng.org, Lai Jiangshan <eag0628@gmail.com>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

* Paul E. McKenney (paulmck@linux.vnet.ibm.com) wrote:
> On Tue, Oct 02, 2012 at 10:13:07AM -0400, Mathieu Desnoyers wrote:
> > Implement wait-free concurrent queues, with a new API different from
> > wfqueue.h, which is already provided by Userspace RCU. The advantage of
> > splitting the head and tail objects of the queue into different
> > arguments is to allow these to sit on different cache-lines, thus
> > eliminating false-sharing, leading to a 2.3x speed increase.
> > 
> > This API also introduces a "splice" operation, which moves all nodes
> > from one queue into another, and postpones the synchronization to either
> > dequeue or iteration on the list. The splice operation does not need to
> > touch every single node of the queue it moves them from. Moreover, the
> > splice operation only needs to ensure mutual exclusion with other
> > dequeuers, iterations, and splice operations from the list it splices
> > from, but acts as a simple enqueuer on the list it splices into (no
> > mutual exclusion needed for that list).
> > 
> > Feedback is welcome,
> 
> These look sane to me, though I must confess that the tail pointer
> referencing the node rather than the node's next pointer did throw
> me for a bit.  ;-)

Yes, this was originally introduced with Lai's original patch to
wfqueue, which I think is a nice simplification: it's pretty much the
same thing to use the last node address as tail rather than the address
of its first member (its next pointer address (_not_ value)). It ends up
being the same address in this case, but more interestingly, we don't
have to use a struct cds_wfcq_node ** type: a simple struct
cds_wfcq_node *  suffice.

Thanks Paul, I will therefore merge these 3 patches with your Acked-by.

Lai, you are welcome to provide improvements to this code against the
master branch. I will gladly consider any change you propose.

Thanks!

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
