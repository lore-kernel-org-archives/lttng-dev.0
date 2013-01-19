From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [lttng-dev] [PATCH] Add ACCESS_ONCE() to avoid compiler
	splitting assignments
Date: Sat, 19 Jan 2013 11:17:52 -0800
Message-ID: <20130119191752.GA3159@linux.vnet.ibm.com>
References: <20130115181936.GA30319@linux.vnet.ibm.com>
 <20130115235642.GA31367@Krystal>
 <20130116125054.GA9734@Krystal>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130116125054.GA9734@Krystal>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rp@svcs.cs.pdx.edu, linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, stern@rowland.harvard.edu, khlebnikov@openvz.org, shemminger@vyatta.com
List-Id: lttng-dev@lists.lttng.org

On Wed, Jan 16, 2013 at 07:50:54AM -0500, Mathieu Desnoyers wrote:
> * Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> > * Paul E. McKenney (paulmck@linux.vnet.ibm.com) wrote:
> > > As noted by Konstantin Khlebnikov, gcc can split assignment of
> > > constants to long variables (https://lkml.org/lkml/2013/1/15/141),
> > > though assignment of NULL (0) is OK.  Assuming that a gcc bug is
> > > fixed (http://gcc.gnu.org/bugzilla/attachment.cgi?id=29169&action=diff
> > > has a patch), making the store be volatile keeps gcc from splitting.
> > > 
> > > This commit therefore applies ACCESS_ONCE() to CMM_STORE_SHARED(),
> > > which is the underlying primitive used by rcu_assign_pointer().
> > 
> > Hi Paul,
> > 
> > I recognise that this is an issue in the Linux kernel, since a simple
> > store is used and expected to be performed atomically when aligned.
> > However, I think this does not affect liburcu, see below:
> 
> Side question: what gcc versions may issue non-atomic volatile stores ?
> I think we should at least document those. Bug
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=55981 seems to target gcc
> 4.7.2, but I wonder when this issue first appeared on x86 and x86-64
> (and if it affects other architectures as well).

I have no idea which versions are affected.  The bug is in the x86
backend, so is specific to x86, but there might well be similar bugs
in other architectures.

> Thanks,
> 
> Mathieu
> 
> > 
> > > 
> > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > 
> > > diff --git a/urcu/system.h b/urcu/system.h
> > > index 2a45f22..7a1887e 100644
> > > --- a/urcu/system.h
> > > +++ b/urcu/system.h
> > > @@ -49,7 +49,7 @@
> > >   */
> > >  #define CMM_STORE_SHARED(x, v)		\
> > >  	({				\
> > > -		__typeof__(x) _v = _CMM_STORE_SHARED(x, v);	\
> > > +		__typeof__(x) CMM_ACCESS_ONCE(_v) = _CMM_STORE_SHARED(x, v);	\
> > 
> > Here, the macro "_CMM_STORE_SHARED(x, v)" is doing the actual store.
> > It stores v into "x". So adding a CMM_ACCESS_ONCE(_v), as you propose
> > here, is really only making sure the return value (usually unused),
> > located on the stack, is accessed with a volatile access, which does not
> > make much sense.
> > 
> > What really matters is the _CMM_STORE_SHARED() macro:
> > 
> > #define _CMM_STORE_SHARED(x, v) ({ CMM_ACCESS_ONCE(x) = (v); })
> > 
> > which already uses a volatile access for the store. So this seems to be
> > a case where our preemptive use of volatile for stores in addition to
> > loads made us bug-free for a gcc behavior unexpected at the time we
> > implemented this macro. Just a touch of paranoia seems to be a good
> > thing sometimes. ;-)
> > 
> > Thoughts ?

Here is my thought:  You should ignore my "fix".  Please accept my
apologies for my confusion!

							Thanx, Paul

> > Thanks,
> > 
> > Mathieu
> > 
> > >  		cmm_smp_wmc();		\
> > >  		_v;			\
> > >  	})
> > > 
> > > 
> > > _______________________________________________
> > > lttng-dev mailing list
> > > lttng-dev@lists.lttng.org
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > 
> > -- 
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com
> > 
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
