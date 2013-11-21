From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: current_thread_info() not respecting program order with gcc 4.8.x
Date: Thu, 21 Nov 2013 17:02:22 +0100
Message-ID: <528E2E8E.8080004@ahsoftware.de>
References: <52803E5D.3050109@mentor.com>	<52851395.3010306@mentor.com>	<67652521.68027.1384482849638.JavaMail.zimbra@efficios.com>	<1691607547.70809.1384874952002.JavaMail.zimbra@efficios.com> <CA+55aFw923sA0E1RQNxFF0OWFtAfcaG-dBUc-0YYZGDSAsaQyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFw923sA0E1RQNxFF0OWFtAfcaG-dBUc-0YYZGDSAsaQyg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jakub Jelinek <jakub@redhat.com>, Richard Henderson <rth@twiddle.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Peter Zijlstra <peterz@infradead.org>, lttng-dev@lists.lttng.org, Nathan Lynch <Nathan_Lynch@mentor.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Luis Lozano <llozano@chromium.org>, Bhaskar Janakiraman <bjanakiraman@chromium.org>, Han Shen <shenhan@chromium.org>
List-Id: lttng-dev@lists.lttng.org

Am 20.11.2013 01:41, schrieb Linus Torvalds:

> It seems that some gcc alias analysis completely incorrectly thinks
> that they are not the same memory location, and do not alias. My guess
> would be that gcc sees that that they are based on the stack pointer
> with "different" offsets, and decides that the memory locations must
> be different - without noticing that the "& ~(THREAD_SIZE - 1)" will
> end up generating the same address for both of them.

Luis Lozano just noted (see https://lkml.org/lkml/2013/11/20/625) that 
current_thread_info() has the prototype

static inline struct thread_info *current_thread_info(void) 
__attribute_const__;

on arm (and arm64 and unicore32, something the paste from Mathieu missed 
so most people here might have missed that detail too). It's a very good 
finding from Luis.

I'm writing this message because his mail doesn't have an in-reply-to 
header, so it might be missed in this thread.

As Luis said, declaring current_thread_info() as a const function is 
wrong. The gcc manual says:

----
const

Many functions do not examine any values except their arguments, and 
have no effects except the return value. Basically this is just slightly 
more strict class than the pure attribute below, since function is not 
allowed to read global memory.

Note that a function that has pointer arguments and examines the data 
pointed to must not be declared const. Likewise, a function that calls a 
non-const function usually must not be const. It does not make sense for 
a const function to return void.
----

So current_thread_info() clearly violates the constrain to not read 
global memory. Or in other words, that __attribute_const__ tells gcc 
explicitly that the two reads are pointing to different locations 
because they are assumed to be local (through the const).

So This might be the reason why gcc misses that different calls to 
current_thread_info() might point to the same memory location.


As I've an arm gcc 4.8.1 ready too, I'm joining Luis question where the 
reordering can be found. If someone would point me to the source/object 
where this happens, I could have a look if removing the 
__attribute_const__ makes a difference.

Regards,

Alexander Holler
