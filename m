From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [rp] [URCU PATCH 0/3] wait-free concurrent queues
	(wfcqueue)
Date: Wed, 3 Oct 2012 11:28:46 -0700
Message-ID: <20121003182846.GN2527__22652.9529704296$1349290101$gmane$org@linux.vnet.ibm.com>
References: <20121002141307.GA4057@Krystal>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paulmck@linux.vnet.ibm.com>) id 1TJTyP-0008Cl-J2
	for lttng-dev@lists.lttng.org; Wed, 03 Oct 2012 14:47:09 -0400
Received: from /spool/local
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 3 Oct 2012 12:47:02 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 6DDAD1FF0042
	for <lttng-dev@lists.lttng.org>; Wed,  3 Oct 2012 12:46:52 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	q93IkOQs063164
	for <lttng-dev@lists.lttng.org>; Wed, 3 Oct 2012 12:46:36 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id q93IkEuj024396
	for <lttng-dev@lists.lttng.org>; Wed, 3 Oct 2012 12:46:14 -0600
Content-Disposition: inline
In-Reply-To: <20121002141307.GA4057@Krystal>
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

On Tue, Oct 02, 2012 at 10:13:07AM -0400, Mathieu Desnoyers wrote:
> Implement wait-free concurrent queues, with a new API different from
> wfqueue.h, which is already provided by Userspace RCU. The advantage of
> splitting the head and tail objects of the queue into different
> arguments is to allow these to sit on different cache-lines, thus
> eliminating false-sharing, leading to a 2.3x speed increase.
> 
> This API also introduces a "splice" operation, which moves all nodes
> from one queue into another, and postpones the synchronization to either
> dequeue or iteration on the list. The splice operation does not need to
> touch every single node of the queue it moves them from. Moreover, the
> splice operation only needs to ensure mutual exclusion with other
> dequeuers, iterations, and splice operations from the list it splices
> from, but acts as a simple enqueuer on the list it splices into (no
> mutual exclusion needed for that list).
> 
> Feedback is welcome,

These look sane to me, though I must confess that the tail pointer
referencing the node rather than the node's next pointer did throw
me for a bit.  ;-)

							Thanx, Paul
