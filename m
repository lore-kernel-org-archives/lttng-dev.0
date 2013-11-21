From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: current_thread_info() not respecting program order with gcc 4.8.x
Date: Fri, 22 Nov 2013 00:18:58 +0100
Message-ID: <528E94E2.3080102@ahsoftware.de>
References: <52803E5D.3050109@mentor.com>	<52851395.3010306@mentor.com>	<67652521.68027.1384482849638.JavaMail.zimbra@efficios.com>	<1691607547.70809.1384874952002.JavaMail.zimbra@efficios.com>	<CA+55aFw923sA0E1RQNxFF0OWFtAfcaG-dBUc-0YYZGDSAsaQyg@mail.gmail.com>	<528E2E8E.8080004@ahsoftware.de> <CA+55aFyNZun07BLoD2KQFT7cN1xsiQ2gE6hYwRvOGa3tCap4CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFyNZun07BLoD2KQFT7cN1xsiQ2gE6hYwRvOGa3tCap4CQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jakub Jelinek <jakub@redhat.com>, Richard Henderson <rth@twiddle.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Peter Zijlstra <peterz@infradead.org>, lttng-dev@lists.lttng.org, Nathan Lynch <Nathan_Lynch@mentor.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Luis Lozano <llozano@chromium.org>, Bhaskar Janakiraman <bjanakiraman@chromium.org>, Han Shen <shenhan@chromium.org>
List-Id: lttng-dev@lists.lttng.org


Am 21.11.2013 23:32, schrieb Linus Torvalds:
> On Thu, Nov 21, 2013 at 8:02 AM, Alexander Holler <holler@ahsoftware.de> wrote:

> The bug is not that gcc can re-order or combine the accesses to "sp".
> WE WANT THAT TO HAPPEN.

Sure, and I don't disagree on that.

>
> The bug is *outside* that "current_thread_info()" macro/inline
> function. It's the *dereference* of the pointer that gcc re-orders.
> AND THAT IS WRONG.
>
> Gcc seems to mess up the alias analysis, and decide that the
> deferences cannot alias. Which is wrong. They clearly *can* alias,
> exactly because the value of "sp & ~(THREAD_SIZE - 1)" ends up having
> the same value all the time.

Sorry, that I still disagree.

I try to describe it more clearly why I still think that the problem 
might be because of that const declaration.

(...)

foobar1 = current_thread_info() __attribute_const__ {
	return sp->somewhere_local;
}

(...)

foobar2 = current_thread_info() __attribute_const__ {
	return sp->somewhere_local;
}

So, even if sp is the same in both cases, that const states that 
wherever sp points to is local to current_thread_info(), so it can't be 
the same for both cases.

Regards,

Alexander Holler
