From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Alternative to signals/sys_membarrier() in liburcu
Date: Fri, 13 Mar 2015 07:18:53 -0700
Message-ID: <20150313141853.GE5412@linux.vnet.ibm.com>
References: <CANW5cDmTCM9ZmhN7-2eWUEYvD+Y=sGt2i7mecdPTTLHMcT8fPg@mail.gmail.com>
 <867044376.285926.1426172227750.JavaMail.zimbra@efficios.com>
 <CANW5cDkiZoysNM3rqb4v6Tj996ocsaSh=OZoBLfp4h7ZGb4bxg@mail.gmail.com>
 <666590480.287502.1426193588471.JavaMail.zimbra@efficios.com>
 <CA+55aFzq75Da-VLMeLWVUbvz_KoLLnftTyVynL1s2rgBK75-Og@mail.gmail.com>
 <1601505044.287659.1426199435904.JavaMail.zimbra@efficios.com>
 <20150313080743.GA21156@gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150313080743.GA21156@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds <torvalds@linux-foundation.org>, Michael Sullivan <sully@msully.net>, lttng-dev@lists.lttng.org, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>
List-Id: lttng-dev@lists.lttng.org

On Fri, Mar 13, 2015 at 09:07:43AM +0100, Ingo Molnar wrote:
> 
> * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > ----- Original Message -----
> > > From: "Linus Torvalds" <torvalds@linux-foundation.org>
> > > To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> > > Cc: "Michael Sullivan" <sully@msully.net>, lttng-dev@lists.lttng.org, "LKML" <linux-kernel@vger.kernel.org>, "Paul E.
> > > McKenney" <paulmck@linux.vnet.ibm.com>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar" <mingo@kernel.org>,
> > > "Thomas Gleixner" <tglx@linutronix.de>, "Steven Rostedt" <rostedt@goodmis.org>
> > > Sent: Thursday, March 12, 2015 5:47:05 PM
> > > Subject: Re: Alternative to signals/sys_membarrier() in liburcu
> > > 
> > > On Thu, Mar 12, 2015 at 1:53 PM, Mathieu Desnoyers
> > > <mathieu.desnoyers@efficios.com> wrote:
> > > >
> > > > So the question as it stands appears to be: would you be comfortable
> > > > having users abuse mprotect(), relying on its side-effect of issuing
> > > > a smp_mb() on each targeted CPU for the TLB shootdown, as
> > > > an effective implementation of process-wide memory barrier ?
> > > 
> > > Be *very* careful.
> > > 
> > > Just yesterday, in another thread (discussing the auto-numa TLB 
> > > performance regression), we were discussing skipping the TLB 
> > > invalidates entirely if the mprotect relaxes the protections.
> 
> We have such code already in mm/mprotect.c, introduced in:
> 
>   10c1045f28e8 mm: numa: avoid unnecessary TLB flushes when setting NUMA hinting entries
> 
> which does:
> 
>                                 /* Avoid TLB flush if possible */
>                                 if (pte_protnone(oldpte))
>                                         continue;
> 
> > > Because if you *used* to be read-only, and them mprotect() 
> > > something so that it is read-write, there really is no need to 
> > > send a TLB invalidate, at least on x86. You can just change the 
> > > page tables, and *if* any entries are stale in the TLB they'll 
> > > take a microfault on access and then just reload the TLB.
> > > 
> > > So mprotect() to a more permissive mode is not necessarily 
> > > serializing.
> > 
> > The idea here is to always mprotect() to a more restrictive mode, 
> > which should trigger the TLB shootdown.
> 
> So what happens if a CPU comes around that integrates TLB shootdown 
> management into its cache coherency protocol? In such a case IPI 
> traffic can be skipped: the memory bus messages take care of TLB 
> flushes in most cases.
> 
> It's a natural optimization IMHO, because TLB flushes are conceptually 
> pretty close to the synchronization mechanisms inherent in data cache 
> coherency protocols:
> 
> This could be implemented for example by a CPU that knows about ptes 
> and handles their modification differently: when a pte is modified it 
> will broadcast a MESI invalidation message not just for the cacheline 
> belonging to the pte's physical address, but also an 'invalidate TLB' 
> MESI message for the pte value's page.
> 
> The TLB shootdown would either be guaranteed within the MESI 
> transaction, or there would either be a deterministic timing 
> guarantee, or some explicit synchronization mechanism (new 
> instruction) to make sure the remote TLB(s) got shot down.
> 
> Every form of this would be way faster than sending interrupts. New 
> OSs could support this by the hardware telling them in which cases the 
> TLBs are 'auto-flushed', while old OSs would still be compatible by 
> sending (now pointless) TLB shootdown IPIs.
> 
> So it's a relatively straightforward hardware optimization IMHO: 
> assuming TLB flushes are considered important enough to complicate the 
> cacheline state machine (which I think they currently aren't).
> 
> So in this case there's no interrupt and no other interruption of the 
> remote CPU's flow of execution in any fashion that could advance the 
> RCU state machine.
> 
> What do you think?

I agree -- there really have been systems able to flush remote TLBs
without interrupting the remote CPU.

So, given the fact that the userspace RCU library does now see
some real-world use, is it now time for Mathieu to resubmit his
sys_membarrier() patch?

							Thanx, Paul
