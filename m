From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] urcu: add notice to URCU_TLS() for
	it	is not async-signal-safe
Date: Fri, 10 Aug 2012 11:23:05 -0700
Message-ID: <20120810182305.GH2371__16598.1517792263$1344623051$gmane$org@linux.vnet.ibm.com>
References: <1344414673-14714-1-git-send-email-laijs@cn.fujitsu.com>
	<1344414673-14714-2-git-send-email-laijs@cn.fujitsu.com>
	<20120809141417.GC9064@Krystal>
	<CACvQF53CY6UuoZzDzT-VE25wAyaNa_r=0vsOdTVzVF6dmScH1g@mail.gmail.com>
	<20120809200211.GA14409@Krystal> <50247E96.9080909@cn.fujitsu.com>
	<20120810141615.GA27969@Krystal>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paulmck@linux.vnet.ibm.com>) id 1Sztrp-0007CH-Fl
	for lttng-dev@lists.lttng.org; Fri, 10 Aug 2012 14:23:25 -0400
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 10 Aug 2012 12:23:19 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 1EBAD19D803E
	for <lttng-dev@lists.lttng.org>; Fri, 10 Aug 2012 18:23:10 +0000 (WET)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	q7AIN7q5114846
	for <lttng-dev@lists.lttng.org>; Fri, 10 Aug 2012 12:23:12 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id q7AIN6Lh028000
	for <lttng-dev@lists.lttng.org>; Fri, 10 Aug 2012 12:23:07 -0600
Content-Disposition: inline
In-Reply-To: <20120810141615.GA27969@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <eag0628@gmail.com>, Roland McGrath <roland@hack.frob.com>, iant@google.com, lttng-dev@lists.lttng.org, Stephen Hemminger <shemminger@vyatta.com>
List-Id: lttng-dev@lists.lttng.org

On Fri, Aug 10, 2012 at 10:16:15AM -0400, Mathieu Desnoyers wrote:
> (for the records: this discussion is about userspace RCU tls-compat.h,
> which uses TLS on systems supporting it, and fall back to
> pthread_key_create/getspecific/setspecific if not. The culprit of the
> issue is that we want to allow reading the tls-compat variable from
> signal handlers, and thus async-signal-safety of pthread_key_* and TLS.
> 
> The code we refer to is:
> http://git.lttng.org/?p=userspace-rcu.git;a=blob;f=urcu/tls-compat.h;h=192a53609fb5f6bc445f98fdd6bc26918126687e;hb=HEAD)
> 
> * Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> > On 08/10/2012 04:02 AM, Mathieu Desnoyers wrote:
> > > Looking at the result of a quick google search:
> > > 
> > > http://curl.haxx.se/mail/lib-2006-09/0224.html
> > > http://www.slamb.org/projects/sigsafe/api/patternref.html
> > > 
> > > "Additionally, it makes the same assumption as all other methods for
> > > handling thread-directed signals (with the exception of kevent(2)
> > > handling), that pthread_getspecific(2) is async signal-safe. This is not
> > > guaranteed by SUSv3."
> > > 
> > > and
> > > 
> > > https://groups.google.com/forum/?fromgroups#!topic/comp.os.linux.development/nZfmndKbzJw[1-25]
> > > 
> > > it looks like using pthread_getspecific from a signal handler is not
> > > always safe, mainly due to possible use of sigaltstack. So disabling
> > > signals works for the "pthread_key_create" part, but we still have an
> > > issue with pthread_getspecific.
> > > 
> > > Ideas are welcome on how to best deal with this issue.
> > 
> > What's the problem with disabling signals + pthread_getspecific()?
> > Waht's the problem with disabling signals + __tls_access_ ## name()?
> 
> * pthread_key_* fallback
> 
> Disabling signals would allow us to be reentrant with respect to
> signals, which actually solves part of the problem (reentrancy) for the
> pthread_key_create part (protected by lock).
> 
> Disabling signals, AFAIU, (and if we disregard the SUSv3 standard for a
> minute) should not be strictly required around the pthread_getspecific
> call on most architectures (no lock taken). We should carefully review
> the implementations for each architecture we support if we want to
> assume this though. If the getspecific returns NULL. we should disable
> signals and call pthread_getspecific again with signals disabled, and
> then call pthread_setspecific if necessary, before re-enabling signals.
> The benefit of not _always_ disabling signals around
> pthread_getspecific() is significant gain in performance in the common
> case: the entire hot path of rcu_read_lock/unlock all happens in
> userspace, without any system call, and uses tls-compat variables.
> 
> The other part of the problem with pthread_getspecific and signal
> handlers is that it does not seem to be SUSv3-compliant to use
> pthread_getspecific() from within a signal handler. One example that can
> lead to problems is if the signal handler is setup with sigaltstack(2).
> 
> We might want to simply document this limitation:
> 
> "RCU read-side critical sections can be used in signals handlers, except
> those setup with sigaltstack(2)."

Seems to me to be a reasonable limitation.  Easier to relax limitations
than to add new ones!

> * TLS
> 
> Userspace RCU always touch the TLS variables from thread context (from
> within rcu_register_thread()) before they are allowed to be touched by
> signal handlers nested over threads. This ensures that issues with lazy
> binding and dynamic linker lock are not encountered

s/ensures that/avoids/
s/and dynamic/and the dynamic/
s/ are not encountered//

> (ref. http://sourceware.org/ml/libc-alpha/2012-06/msg00372.html).

And stop here.

>                                                                   I did
> the same within my LTTng-UST use of TLS variables: they are touched by a
> constructor once so we don't run into deadlocks between UST lock and the
> libc lock protecting dynamic linking (recursive mutex also taken around
> the constructor calls, within which we needed to take the UST lock, thus
> causing deadlocks).
> 
> 
> Feedback is welcome,

Looks good!

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
> 
