From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Alternative to signals/sys_membarrier() in liburcu
Date: Thu, 12 Mar 2015 14:47:05 -0700
Message-ID: <CA+55aFzq75Da-VLMeLWVUbvz_KoLLnftTyVynL1s2rgBK75-Og@mail.gmail.com>
References: <CANW5cDmTCM9ZmhN7-2eWUEYvD+Y=sGt2i7mecdPTTLHMcT8fPg@mail.gmail.com>
	<867044376.285926.1426172227750.JavaMail.zimbra@efficios.com>
	<CANW5cDkiZoysNM3rqb4v6Tj996ocsaSh=OZoBLfp4h7ZGb4bxg@mail.gmail.com>
	<666590480.287502.1426193588471.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <666590480.287502.1426193588471.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Michael Sullivan <sully@msully.net>, lttng-dev@lists.lttng.org, LKML <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>
List-Id: lttng-dev@lists.lttng.org

On Thu, Mar 12, 2015 at 1:53 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> So the question as it stands appears to be: would you be comfortable
> having users abuse mprotect(), relying on its side-effect of issuing
> a smp_mb() on each targeted CPU for the TLB shootdown, as
> an effective implementation of process-wide memory barrier ?

Be *very* careful.

Just yesterday, in another thread (discussing the auto-numa TLB
performance regression), we were discussing skipping the TLB
invalidates entirely if the mprotect relaxes the protections.

Because if you *used* to be read-only, and them mprotect() something
so that it is read-write, there really is no need to send a TLB
invalidate, at least on x86. You can just change the page tables, and
*if* any entries are stale in the TLB they'll take a microfault on
access and then just reload the TLB.

So mprotect() to a more permissive mode is not necessarily serializing.

Also, you need to make sure that your page is actually in memory,
because otherwise the kernel may end up seeing "oh, it's not even
present", and never flush the TLB at all.

So now you need to mlock that page. Which can be problematic for non-root.

In other words, I'd be a bit leery about it. There may be other
gotcha's about it.

                      Linus
