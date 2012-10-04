From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [rp] [URCU PATCH 0/3] wait-free concurrent queues
	(wfcqueue)
Date: Thu, 4 Oct 2012 11:51:20 -0700
Message-ID: <20121004185120.GA23484__30945.3761940405$1349392274$gmane$org@linux.vnet.ibm.com>
References: <20121002141307.GA4057@Krystal>
	<20121003182846.GN2527@linux.vnet.ibm.com>
	<20121003210436.GB25090@Krystal>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paulmck@linux.vnet.ibm.com>) id 1TJqWH-0003Op-LA
	for lttng-dev@lists.lttng.org; Thu, 04 Oct 2012 14:51:37 -0400
Received: from /spool/local
	by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 4 Oct 2012 14:51:31 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	q94IpSrE180664
	for <lttng-dev@lists.lttng.org>; Thu, 4 Oct 2012 14:51:28 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id q94IpPou017045
	for <lttng-dev@lists.lttng.org>; Thu, 4 Oct 2012 12:51:28 -0600
Content-Disposition: inline
In-Reply-To: <20121003210436.GB25090@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, Lai Jiangshan <eag0628@gmail.com>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

On Wed, Oct 03, 2012 at 05:04:36PM -0400, Mathieu Desnoyers wrote:
> * Paul E. McKenney (paulmck@linux.vnet.ibm.com) wrote:
> > On Tue, Oct 02, 2012 at 10:13:07AM -0400, Mathieu Desnoyers wrote:
> > > Implement wait-free concurrent queues, with a new API different from
> > > wfqueue.h, which is already provided by Userspace RCU. The advantage of
> > > splitting the head and tail objects of the queue into different
> > > arguments is to allow these to sit on different cache-lines, thus
> > > eliminating false-sharing, leading to a 2.3x speed increase.
> > > 
> > > This API also introduces a "splice" operation, which moves all nodes
> > > from one queue into another, and postpones the synchronization to either
> > > dequeue or iteration on the list. The splice operation does not need to
> > > touch every single node of the queue it moves them from. Moreover, the
> > > splice operation only needs to ensure mutual exclusion with other
> > > dequeuers, iterations, and splice operations from the list it splices
> > > from, but acts as a simple enqueuer on the list it splices into (no
> > > mutual exclusion needed for that list).
> > > 
> > > Feedback is welcome,
> > 
> > These look sane to me, though I must confess that the tail pointer
> > referencing the node rather than the node's next pointer did throw
> > me for a bit.  ;-)
> 
> Yes, this was originally introduced with Lai's original patch to
> wfqueue, which I think is a nice simplification: it's pretty much the
> same thing to use the last node address as tail rather than the address
> of its first member (its next pointer address (_not_ value)). It ends up
> being the same address in this case, but more interestingly, we don't
> have to use a struct cds_wfcq_node ** type: a simple struct
> cds_wfcq_node *  suffice.
> 
> Thanks Paul, I will therefore merge these 3 patches with your Acked-by.

Good point -- just confirming:

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> Lai, you are welcome to provide improvements to this code against the
> master branch. I will gladly consider any change you propose.
> 
> Thanks!
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> rp mailing list
> rp@svcs.cs.pdx.edu
> http://svcs.cs.pdx.edu/mailman/listinfo/rp
> 
