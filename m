From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Alternative to signals/sys_membarrier() in liburcu
Date: Fri, 13 Mar 2015 00:43:58 +0000 (UTC)
Message-ID: <1510717200.289089.1426207438871.JavaMail.zimbra@efficios.com>
References: <666590480.287502.1426193588471.JavaMail.zimbra@efficios.com> <1243872207.287578.1426193760572.JavaMail.zimbra@efficios.com> <20150312235938.3f7b3245@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150312235938.3f7b3245@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Michael Sullivan <sully@msully.net>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, lttng-dev@lists.lttng.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "One Thousand Gnomes" <gnomes@lxorguk.ukuu.org.uk>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: "Michael Sullivan" <sully@msully.net>, "Peter Zijlstra" <peterz@infradead.org>, "LKML"
> <linux-kernel@vger.kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, lttng-dev@lists.lttng.org, "Thomas Gleixner"
> <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "Linus Torvalds"
> <torvalds@linux-foundation.org>, "Ingo Molnar" <mingo@kernel.org>
> Sent: Thursday, March 12, 2015 7:59:38 PM
> Subject: Re: Alternative to signals/sys_membarrier() in liburcu
> 
> On Thu, 12 Mar 2015 20:56:00 +0000 (UTC)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > (sorry for re-send, my mail client tricked me into posting HTML
> > to lkml)
> > 
> > Hi,
> > 
> > Michael Sullivan proposed a clever hack abusing mprotect() to
> > perform the same effect as sys_membarrier() I submitted a few
> > years ago ( https://lkml.org/lkml/2010/4/18/15 ).
> > 
> > At that time, the sys_membarrier implementation was deemed
> > technically sound, but there were not enough users of the system call
> > to justify its inclusion.
> > 
> > So far, the number of users of liburcu has increased, but liburcu
> > still appears to be the only direct user of sys_membarrier. On this
> > front, we could argue that many other system calls have only
> > one user: glibc. In that respect, liburcu is quite similar to glibc.
> > 
> > So the question as it stands appears to be: would you be comfortable
> > having users abuse mprotect(), relying on its side-effect of issuing
> > a smp_mb() on each targeted CPU for the TLB shootdown, as
> > an effective implementation of process-wide memory barrier ?
> 
> What are you going to do if some future ARM or x86 CPU update with
> hardware TLB shootdown appears ? All your code will start to fail on new
> kernels using that property, and in nasty insidious ways.

I'd claim that removing the IPIs breaks userspace, of course. :-P

If we start relying on mprotect() implying memory barriers issued
on all CPUs associated with the memory mapping in core user-space
libraries, then whenever those shiny new CPUs show up, we might be
stuck with the IPIs, otherwise we could claim that removing them
breaks userspace. I would really hate to tie in an assumption like
that on mprotect, because that would really be painting ourselves in
a corner.

> 
> Also doesn't sun4d have hardware shootdown for 16 processors or less ?

That's possible. I'm no sun expert though.

> 
> I would have thought a membarrier was a lot safer and it can be made to
> do whatever horrible things are needed on different processors (indeed it
> could even be a pure libc hotpath if some future cpu grows this ability)

I'd really prefer a well-documented system call for that purpose too.

Thanks,

Mathieu

> 
> Alan
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
