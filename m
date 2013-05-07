From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Quick questions about liburcu and RCU in general
Date: Tue, 7 May 2013 07:23:52 -0700
Message-ID: <20130507142352.GA3648__48694.9739432477$1367936689$gmane$org@linux.vnet.ibm.com>
References: <20130507094636.GA6151@mail.sceen.net>
	<20130507115914.GB3875@Krystal>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paulmck@linux.vnet.ibm.com>) id 1UZioK-0002Ga-Mi
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 10:24:08 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 7 May 2013 08:24:02 -0600
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3220638C8045
	for <lttng-dev@lists.lttng.org>; Tue,  7 May 2013 10:23:58 -0400 (EDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	r47ENuKG346562
	for <lttng-dev@lists.lttng.org>; Tue, 7 May 2013 10:23:58 -0400
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id r47EQoaw022701
	for <lttng-dev@lists.lttng.org>; Tue, 7 May 2013 08:26:50 -0600
Content-Disposition: inline
In-Reply-To: <20130507115914.GB3875@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, Richard Braun <rbraun@sceen.net>
List-Id: lttng-dev@lists.lttng.org

On Tue, May 07, 2013 at 07:59:14AM -0400, Mathieu Desnoyers wrote:
> Hi Richard,
> 
> * Richard Braun (rbraun@sceen.net) wrote:
> > Hello,
> > 
> > I'm currently studying RCU/URCU, and I have a few questions that I wasn't
> > sure where to ask.
> > 
> > 1/ Why use poll instead of sched_yield in e.g. force_mb_all_readers ?
> > (I guess it's about portability and the effect is expected to be the same,
> > but is there another reason ?)
> 
> poll() allow us to do a millisecond-level wait (timer-based).
> sched_yield() is pretty much a scheduler hack that just says "be nice to
> other scheduled processes here". Quoting sched_yield(2):
> 
>        If the calling thread is the only thread in the highest  priority list
>        at that time, it will continue to run after a call to sched_yield().
> 
> This is a kind of behavior we don't want.
> 
> > 2/ What was the conclusion of the discussion regarding sys_membarrier ?
> > (I couldn't find it in the main mail thread, and it looks quite interesting,
> > even though I expect most carefully written applications not to exceed
> > one thread per processor too much)
> 
> The conclusion so far was that:
> 
> - the implementation was fine,
> - we had to show there were enough users of this new ABI to justify its
>   inclusion and maintenance cost. Currently, it's pretty much just
>   liburcu that uses it. As the number of liburcu users grows, this
>   helps, but what would help even more would be to have other libraries
>   and applications using sys_membarrier() (other people interested and
>   weighting in).
> 
> > 
> > 3/ Do you know if IBM allows the use of patented RCU techniques in GPLv3+
> > code as well ? ("GPL" is mentioned in the Linux documentation, and
> > apparently liburcu is covered by LGPLv2+ so I expect that to be the case,
> > just looking for a confirmation)
> 
> AFAIK, LGPLv2+ code can migrate into GPLv3+, it's the other way around
> that is not permitted. Therefore, I would expect it is allowed, but I
> will let Paul answer to this one on behalf of IBM.

Yes, LGPLv2+ allows you to migrate to LGPLv3+, which is compatible with
GPLv3+.  So as long as you derive the code from lttng's userspace-rcu
library, you are set.

That said, you could also just link userspace-rcu into your GPLv3+
application.

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> 
> > 
> > Thanks for your answers.
> > 
> > -- 
> > Richard Braun
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
