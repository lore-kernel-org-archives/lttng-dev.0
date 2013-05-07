From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Quick questions about liburcu and RCU in general
Date: Tue, 7 May 2013 07:59:14 -0400
Message-ID: <20130507115914.GB3875__43610.8198286549$1367927991$gmane$org@Krystal>
References: <20130507094636.GA6151@mail.sceen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UZgY7-0000vw-Th
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 07:59:15 -0400
Content-Disposition: inline
In-Reply-To: <20130507094636.GA6151@mail.sceen.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Richard Braun <rbraun@sceen.net>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

Hi Richard,

* Richard Braun (rbraun@sceen.net) wrote:
> Hello,
> 
> I'm currently studying RCU/URCU, and I have a few questions that I wasn't
> sure where to ask.
> 
> 1/ Why use poll instead of sched_yield in e.g. force_mb_all_readers ?
> (I guess it's about portability and the effect is expected to be the same,
> but is there another reason ?)

poll() allow us to do a millisecond-level wait (timer-based).
sched_yield() is pretty much a scheduler hack that just says "be nice to
other scheduled processes here". Quoting sched_yield(2):

       If the calling thread is the only thread in the highest  priority list
       at that time, it will continue to run after a call to sched_yield().

This is a kind of behavior we don't want.

> 2/ What was the conclusion of the discussion regarding sys_membarrier ?
> (I couldn't find it in the main mail thread, and it looks quite interesting,
> even though I expect most carefully written applications not to exceed
> one thread per processor too much)

The conclusion so far was that:

- the implementation was fine,
- we had to show there were enough users of this new ABI to justify its
  inclusion and maintenance cost. Currently, it's pretty much just
  liburcu that uses it. As the number of liburcu users grows, this
  helps, but what would help even more would be to have other libraries
  and applications using sys_membarrier() (other people interested and
  weighting in).

> 
> 3/ Do you know if IBM allows the use of patented RCU techniques in GPLv3+
> code as well ? ("GPL" is mentioned in the Linux documentation, and
> apparently liburcu is covered by LGPLv2+ so I expect that to be the case,
> just looking for a confirmation)

AFAIK, LGPLv2+ code can migrate into GPLv3+, it's the other way around
that is not permitted. Therefore, I would expect it is allowed, but I
will let Paul answer to this one on behalf of IBM.

Thanks,

Mathieu


> 
> Thanks for your answers.
> 
> -- 
> Richard Braun

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
