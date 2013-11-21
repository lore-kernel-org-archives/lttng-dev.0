From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: current_thread_info() not respecting program order with gcc 4.8.x
Date: Thu, 21 Nov 2013 14:32:34 -0800
Message-ID: <CA+55aFyNZun07BLoD2KQFT7cN1xsiQ2gE6hYwRvOGa3tCap4CQ@mail.gmail.com>
References: <52803E5D.3050109@mentor.com>
	<52851395.3010306@mentor.com>
	<67652521.68027.1384482849638.JavaMail.zimbra@efficios.com>
	<1691607547.70809.1384874952002.JavaMail.zimbra@efficios.com>
	<CA+55aFw923sA0E1RQNxFF0OWFtAfcaG-dBUc-0YYZGDSAsaQyg@mail.gmail.com>
	<528E2E8E.8080004@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <528E2E8E.8080004@ahsoftware.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Holler <holler@ahsoftware.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jakub Jelinek <jakub@redhat.com>, Richard Henderson <rth@twiddle.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Peter Zijlstra <peterz@infradead.org>, lttng-dev@lists.lttng.org, Nathan Lynch <Nathan_Lynch@mentor.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Luis Lozano <llozano@chromium.org>, Bhaskar Janakiraman <bjanakiraman@chromium.org>, Han Shen <shenhan@chromium.org>
List-Id: lttng-dev@lists.lttng.org

On Thu, Nov 21, 2013 at 8:02 AM, Alexander Holler <holler@ahsoftware.de> wrote:
>
> Luis Lozano just noted (see https://lkml.org/lkml/2013/11/20/625) that
> current_thread_info() has the prototype
>
> static inline struct thread_info *current_thread_info(void)
> __attribute_const__;
>
> on arm (and arm64 and unicore32, something the paste from Mathieu missed so
> most people here might have missed that detail too). It's a very good
> finding from Luis.

No, because it is immaterial.

We *want* gcc to optimize away multiple accesses to "sp". Because it
doesn't *matter* whether "sp" changes or not, the *result* is always
the same. That's what the "const" means.

The "& ~(THREAD_SIZE - 1)" part will remove all the bits that can
change. Really. So the result *is* constant (within one thread).
Marking it constant and telling gcc that it can combine these things
is correct.

Guys, read my email again.

The bug is not that gcc can re-order or combine the accesses to "sp".
WE WANT THAT TO HAPPEN.

The bug is *outside* that "current_thread_info()" macro/inline
function. It's the *dereference* of the pointer that gcc re-orders.
AND THAT IS WRONG.

Gcc seems to mess up the alias analysis, and decide that the
deferences cannot alias. Which is wrong. They clearly *can* alias,
exactly because the value of "sp & ~(THREAD_SIZE - 1)" ends up having
the same value all the time.

                 Linus
