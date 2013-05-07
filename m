From: Richard Braun <rbraun@sceen.net>
Subject: Re: Quick questions about liburcu and RCU in general
Date: Tue, 7 May 2013 16:59:58 +0200
Message-ID: <20130507145958.GA29958__8299.33990394256$1367938837$gmane$org@mail.sceen.net>
References: <20130507094636.GA6151@mail.sceen.net>
	<20130507115914.GB3875@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from shattrath.sceen.net ([94.23.252.191] helo=mail.sceen.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <rbraun@sceen.net>) id 1UZjN4-0002dB-Qc
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 11:00:02 -0400
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
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

On Tue, May 07, 2013 at 07:59:14AM -0400, Mathieu Desnoyers wrote:
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

Right, I see. But then, poll enforces a minimum delay whatever happens
(which may be increased up to the scheduler time slice depending on the
kernel). I guess this isn't something we want either.

On the other hand, AIUI, poll is called only after all signals were
already sent, and if a receiving thread didn't update its need_mb yet,
so I expect it's a rare worst case that doesn't require more care.

-- 
Richard Braun
