From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: current_thread_info() not respecting program order with gcc 4.8.x
Date: Tue, 19 Nov 2013 18:33:12 +0100
Message-ID: <20131119173312.GP16796@laptop.programming.kicks-ass.net>
References: <52803E5D.3050109@mentor.com>
 <52851395.3010306@mentor.com>
 <67652521.68027.1384482849638.JavaMail.zimbra@efficios.com>
 <1691607547.70809.1384874952002.JavaMail.zimbra@efficios.com>
 <20131119160502.GG11778@mudshark.cambridge.arm.com>
 <1656507422.70913.1384880540574.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1656507422.70913.1384880540574.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Catalin Marinas <Catalin.Marinas@arm.com>, lttng-dev@lists.lttng.org, Nathan Lynch <Nathan_Lynch@mentor.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Jakub Jelinek <jakub@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: lttng-dev@lists.lttng.org

On Tue, Nov 19, 2013 at 05:02:20PM +0000, Mathieu Desnoyers wrote:
> Unfortunately I don't have a ARM cross-compiler setup ready. Nathan could test
> it for us though.
> 
> It might shuffle things around enough to work around the issue, but with the
> approach you propose, I would be concerned about the compiler being within
> its rights to reorder the code into the following sequence:
> 
> struct thread_info *ptra, *ptrb;
> 
> ptra = current_thread_info();
> /*
>  * each current_thread_info() would have a clobber on *sp, which orders
>  * those two wrt each other.
>   */
> ptrb = current_thread_info();
> 
> load from ptra->preempt_count;
> /*
>  * however, the following accesses that depend on ptra and ptrb could be
>  * reordered if the compiler has no way to know that ptra and ptrb are
>  * aliased.
>  */
> store to ptrb->preempt_count;
> 
> One question that might be worth asking: with the local register variable
> extension (http://gcc.gnu.org/onlinedocs/gcc-4.8.2/gcc/Local-Reg-Vars.html#Local-Reg-Vars)
> (thanks to Jakub for the pointer), should the compiler consider two variables
> bound to the same register as being aliased or not ? AFAIU, local reg vars appear
> to be architecture-specific, so maybe there is something fishy on ARM ?

Might help if you ask where the GCC people are on CC ;-)
