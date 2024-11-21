Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC47D711A9
	for <lttng-dev@archiver.kernel.org>; Thu, 21 Nov 2024 17:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1732210544;
	bh=e5flqDyxYYWm4Y7pnKkC6tQ/EU9gHQy83XZBeLFLfpI=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=g3HTGCb303+V0m3hWsyHkcO70zMVsH39fkpD0qNELudPLPyCRx+DyND6qLacMo3Lh
	 /o6mqiUtkx8JKh/HMC7UJcoByFz/j7N2gBB8K/alR0DbDiNHqFkuiZ/2gmpsV5Pf1i
	 hn2tqcjWY4i9LFJOkEHCS+/eEqYRl7Ci+YSWkNuu7dFMYzp0vTLHMntSJtYz/l4NnT
	 JPxB50sUGtPPGJWROxZWC5v1POk23r0UzhwuC8L7hATd3Z2JrVRC/PbUVKKjq0zYuT
	 XJ6gNnIFB2e8c4Fl2NrGRy+hwaVW9RWm3SwRYw8mA4SB3t79YTyRPjxXxiqbWNMHiN
	 prvVXxJ62dNLA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4XvQPD2FG9z24sm;
	Thu, 21 Nov 2024 12:35:44 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com
 [IPv6:2607:5300:203:b2ee::31e5])
 by lists.lttng.org (Postfix) with ESMTPS id 4XvQPB5ZkNz24br
 for <lttng-dev@lists.lttng.org>; Thu, 21 Nov 2024 12:35:42 -0500 (EST)
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net
 [96.127.217.162])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4XvQP34j1yz13B1;
 Thu, 21 Nov 2024 12:35:35 -0500 (EST)
Message-ID: <47507865-d3a7-494f-91a0-7a3ff2a6f8db@efficios.com>
Date: Thu, 21 Nov 2024 12:35:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Userspace RCU] - rcu_dereference() memory ordering
To: paulmck@kernel.org, Olivier Dion <odion@efficios.com>
Cc: lttng-dev@lists.lttng.org
References: <87y12hmdwf.fsf@laura>
 <a941f427-a401-426d-bfb5-7d89de374086@paulmck-laptop>
Content-Language: en-US
In-Reply-To: <a941f427-a401-426d-bfb5-7d89de374086@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2024-10-21 19:35, Paul E. McKenney wrote:
> On Mon, Oct 21, 2024 at 03:53:04PM -0400, Olivier Dion wrote:
>> Hi Paul,
>>
>> In liburcu, `rcu_dereference()' is either implemented with volatile
>> access with `CMM_LOAD_SHARED()' followed by a memory barrier depends, or
>> a atomic load with CONSUME memory ordering (configurable by users on a
>> compilation unit basis).
>>
>> However, it is my understanding that the CONSUME memory ordering
>> semantic has some deficiency [0] and will be promoted to a ACQUIRE
>> memory ordering.  This is somewhat inefficient (see benchmarks at the
>> end) for weakly-ordered architectures [1]:
>>
>>    rcu_dereference_consume:
>>            sub     sp, sp, #16
>>            add     x1, sp, 8
>>            str     x0, [sp, 8]
>>            ldar    x0, [x1]     ;; Load acquire
>>            add     sp, sp, 16
>>            ret
>>    rcu_dereference_relaxed:
>>            sub     sp, sp, #16
>>            add     x1, sp, 8
>>            str     x0, [sp, 8]
>>            ldr     x0, [x1]     ;; Load
>>            add     sp, sp, 16
>>            rer
> 
> Yes, CONSUME is always promoted to ACQUIRE, which costs extra,
> especially on weakly ordered architectures.  The cost on strongly
> ordered architectures such as x86 is less, but there are still compiler
> optimizations that are needlessly suppressed.
> 
>> I had a discussion with Mathieu on that, and using the RELAXED memory
>> ordering (on every architecture except Alpha) + a compiler barrier would
>> not prevent compiler value-speculative optimizations (e.g. VSS: Value
>> Speculation Scheduling).
>>
>> Consider the following code:
>>
>>    #define cmm_barrier() asm volatile ("" : : : "memory")
>>    #define rcu_dereference(p) __atomic_load_n(&(p), __ATOMIC_RELAXED)
>>
>>    // Assume QSBR flavor
>>    #define rcu_read_lock() do { } while (0)
>>    #define rcu_read_unlock() do { } while (0)
>>
>>    struct foo {
>>        long x;
>>    };
>>

As a side-note which should clarify this example, we also suffer
from loss of address dependency due to pointer comparison if we
have:

struct foo {
   long x;
   long y;
};

>>    struct foo *foo;
>>
>>    extern void do_stuff(long);
>>
>>    // Assume that global pointer `foo' is never NULL for simplicity.
>>    void func(void)
>>    {
>>        struct foo *a, *b;
>>
>>        rcu_read_lock(); {
>>            a = rcu_dereference(foo);
>>            do_stuff(a->x);
>>        } rcu_read_unlock();
>>        cmm_barrier();
>>        rcu_read_lock(); {
>>            b = rcu_dereference(foo);
>>            if (a == b)
>>                do_stuff(b->x);

with:

   do_stuff(b->y)

>>        } rcu_read_unlock();
>>    }
>>
>> and the resulting assembler on ARM64 (GCC 14.2.0) [2]:
>>
>>    func:
>>            stp     x29, x30, [sp, -32]!
>>            mov     x29, sp
>>            stp     x19, x20, [sp, 16]
>>            adrp    x19, .LANCHOR0
>>            add     x19, x19, :lo12:.LANCHOR0
>>            ldr     x20, [x19] ;; a = rcu_dereference | <-- here ...
>>            ldr     x0, [x20]  ;; a->x
>>            bl      do_stuff
>>            ldr     x0, [x19]  ;; b = rcu_dereference
> 
> Why can the access to b->x be reordered past this point?

Because the b->x access is done using [x20] rather than [x19]
since the compiler knows those pointers are equal. Therefore
a weakly-ordered CPU is free to speculate the load across
control dependencies.

> 
> Unless the prior load is also reordered?

I'm unsure what you mean by "prior load" in this context ?

> 
>>            cmp     x20, x0
>>            beq     .L5
>>            ldp     x19, x20, [sp, 16]
>>            ldp     x29, x30, [sp], 32
>>            ret
>>    .L5:
>>            ldr     x0, [x20] ;; b->x | can be reordered up-to ...
>>            ldp     x19, x20, [sp, 16]
>>            ldp     x29, x30, [sp], 32
>>            b       do_stuff
>>    foo:
>>            .zero   8
>>
>> >From my understanding of the ARM memory ordering and its ISA, the
>> processor is within its right to reorder the `ldr x0, [x20]' in `.L5',
>> up to its dependency at `ldr x20, [x19]', which happen before the RCU
>> dereferencing of `b'.
> 
> The CPU could (in effect) merge/fuse the two loads from foo, if that is
> what you are getting at.

Even though merge/fuse of the two loads by the CPU is possible in this
specific scenario, this is not the problem we are getting at.

See my example with x and y fields in the structure: this is a
case where no load merge/fuse can be done, but the compiler still
uses the [x20] register populated within the first critical section
to load b->y within the second critical section, with an offset,
e.g.:

         ldr     x0, [x20, 8]

> 
>> This looks similar to what Mathieu described here [3].
>>
>> Our proposed solution is to keep using the CONSUME memory ordering by
>> default, therefore guaranteeing correctness above all for all cases.
>> However, to allow for better performance, users can opt-in to use
>> "traditional" volatile access instead of atomic builtins for
>> `rcu_dereference()', as long as pointer comparisons are avoided or as
>> long as the `ptr_eq' wrapper proposed by Mathieu [3] is used for them.
>>
>> Thus, `rcu_dereference()' would be defined as something like:
>>
>>    #ifdef URCU_DEREFERENCE_USE_VOLATILE
>>    #  define rcu_dereference(p) do { CMM_LOAD_SHARED(p); cmm_smp_rmc(); } while(0)
>>    #else
>>    #  define rcu_dereference(p)  uatomic_load(&(p), CMM_CONSUME)
>>    #endif
>>
>> and would yield, if using `cmm_ptr_eq' (ARM64 (GCC 14.2.0)) [4]:
>>
>>    func:
>>            stp     x29, x30, [sp, -32]!
>>            mov     x29, sp
>>            stp     x19, x20, [sp, 16]
>>            adrp    x20, .LANCHOR0
>>            ldr     x19, [x20, #:lo12:.LANCHOR0] ;; a = rcu_dereference
>>            ldr     x0, [x19] ;; a->x
>>            bl      do_stuff
>>            ldr     x2, [x20, #:lo12:.LANCHOR0] ;; b = rcu_dereference | <-- here ...
>>            mov     x0, x19 ;; side effect of cmm_ptr_eq, force to use more registers
>>            mov     x1, x2  ;; and more registers
>>            cmp     x0, x1
>>            beq     .L5
>>            ldp     x19, x20, [sp, 16]
>>            ldp     x29, x30, [sp], 32
>>            ret
>>    .L5:
>>            ldp     x19, x20, [sp, 16]
>>            ldp     x29, x30, [sp], 32
>>            ldr     x0, [x2] ;; b->x | can be re-ordered up-to ...
>>            b       do_stuff
>>    foo:
>>            .zero   8
>>
>> The Pro & Cons overall for selecting the volatile for rcu_dereference:
>>
>>    Pro:
>>
>>      - Yield better performance on weakly-ordered architectures for all
>>        `rcu_dereference'.
>>
>>    Cons:
>>
>>      - Users would need to use the `cmm_ptr_eq' for pointer comparisons,
>>        even on strongly ordered architectures.
>>
>>      - `cmm_ptr_eq' can increase register pressure, resulting in possible
>>        register spilling.
> 
> It would be nice to have a solution that avoids chewing up that extra
> register.  However, I recall the thread having many more proposed
> solutions than solutions that actually worked.
> 
> On the other hand, doesn't hardware register renaming cover most of this?

The downsides of this extra register use is, AFAIU, adding useless register
movement instructions (CPU time and code size overhead).

> 
> Maybe I should look ahead to the performance results.  ;-)
> 
>> Here is a benchmark summary.  You can find more details in the attached
>> file.
>>
>>    CPU: Aarch64 Cortex-A57
>>
>>    Program ran with perf.  Thight loop of the above example 1 000 000 000
>>    times.
>>
>>    Variants are:
>>
>>      - Baseline v0.14.1:: rcu_dereference() implemented with
>>        CMM_ACCESS_ONCE().  Pointers comparisons with `==' operator.
>>
>>      - Volatile access:: rcu_dereference() implemented with
>>        CMM_ACCESS_ONCE().  Pointers comparisons with cmm_ptr_eq.
>>
>>      - Atomic builtins:: rcu_dereference() implementd with
>>        __atomic_load_n CONSUME.  Pointers comparisons with cmm_ptr_eq.
>>
>>    All variants were compiled with _LGPL_SOURCE.
>>
>>    | Variant         | Time [s]    | Cycles        | Instructions   | Branch misses |
>>    |-----------------+-------------+---------------+----------------+---------------|
>>    | Baseline        | 4.217609351 | 8 015 627 017 | 15 008 330 513 | 26 607        |
>>    |-----------------+-------------+---------------+----------------+---------------|
>>    | Volatile access | +10.95 %    | +11.14 %      | +6.25 %        | +10.81 %      |
>>    | Atomic builtins | +423.18 %   | +425.94 %     | +6.87 %        | +188.37 %     |
>>
>> Any thoughts on that?
> 
> I am not surprised by the cost, though much depends on the exact CPU in use.
> 
> They tell me that the performance degradation is worst on mid-range CPUs.
> The low-end CPUs don't do much reordering, and thus don't notice the
> acquire loads so much, and the high-end CPUs speculate their way over
> the acquire loads.
> 
> Or so the story goes.
> 
> How much of the added "Volatile access" overhead is due to the volatile
> load and how much to the cmm_ptr_eq?  Many use cases do not need to
> compare pointers, except maybe against NULL.  Or against a sentinel.
> In both cases, an equality comparison means no dereferncing, so no
> problems.

Olivier will prepare benchmarks without the cmm_ptr_eq() so we can isolate
the overhead contribution of volatile vs atomic builtins more specifically.

Thanks,

Mathieu

> 
> 							Thanx, Paul
> 
>> Thanks,
>> Olivier
>>
>>   [0] https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html
>>   [1] https://godbolt.org/z/xxqGPjaxK
>>   [2] https://godbolt.org/z/cPzxq7PKb
>>   [3] https://lore.kernel.org/lkml/20241008135034.1982519-2-mathieu.desnoyers@efficios.com/
>>   [4] https://godbolt.org/z/979jnccc9
>>
> 
>> #+title:      Benchmarks URCU
>> #+date:       [2024-10-18 Fri 12:18]
>> #+filetags:   :urcu:
>> #+identifier: 20241018T121818
>>
>> * Program
>>
>>    #+begin_src c
>>      #define _LGPL_SOURCE
>>      #define URCU_DEREFERENCE_USE_VOLATILE
>>
>>      #include <assert.h>
>>      #include <stdlib.h>
>>
>>      #include <urcu/pointer.h>
>>
>>      struct foo {
>>      	long x;
>>      };
>>
>>      volatile long flag;
>>
>>      static void do_stuff(long x)
>>      {
>>      	flag = x;
>>      }
>>
>>      struct foo *foo;
>>
>>      __attribute__((noinline))
>>      static void func()
>>      {
>>      	struct foo *a, *b;
>>
>>      	a = rcu_dereference(foo);
>>
>>      	do_stuff(a->x);
>>
>>      	b = rcu_dereference(foo);
>>
>>      	if (cmm_ptr_eq(a, b)) {
>>      		do_stuff(b->x);
>>      	}
>>      }
>>
>>      int main(int argc, char *argv[])
>>      {
>>      	struct foo fuz;
>>
>>      	foo = &fuz;
>>
>>      	cmm_barrier();
>>
>>      	assert(2 == argc);
>>
>>      	long loop = atoll(argv[1]);
>>
>>      	for (long k = 0; k < loop; ++k) {
>>      		func();
>>      	}
>>
>>      	return 0;
>>      }
>>    #+end_src
>>
>> * v0.14.1
>>
>>    #+begin_src asm
>>      0000000000000860 <func>:
>>       860:   90000100        adrp    x0, 20000 <__libc_start_main@GLIBC_2.34>
>>       864:   91012002        add     x2, x0, #0x48
>>       868:   f9402401        ldr     x1, [x0, #72]
>>       86c:   f9400023        ldr     x3, [x1]
>>       870:   f9000443        str     x3, [x2, #8]
>>       874:   f9402400        ldr     x0, [x0, #72]
>>       878:   eb00003f        cmp     x1, x0
>>       87c:   54000040        b.eq    884 <func+0x24>  // b.none
>>       880:   d65f03c0        ret
>>       884:   f9400020        ldr     x0, [x1]
>>       888:   f9000440        str     x0, [x2, #8]
>>       88c:   d65f03c0        ret
>>    #+end_src
>>
>>     Performance counter stats for './a.out 1000000000':
>>
>>            4,214.47 msec task-clock                       #    0.999 CPUs utilized
>>                  14      context-switches                 #    3.322 /sec
>>                   0      cpu-migrations                   #    0.000 /sec
>>                  44      page-faults                      #   10.440 /sec
>>       8,015,627,017      cycles                           #    1.902 GHz
>>      15,008,330,513      instructions                     #    1.87  insn per cycle
>>     <not supported>      branches
>>              26,607      branch-misses
>>
>>         4.217609351 seconds time elapsed
>>
>>         4.213169000 seconds user
>>         0.004001000 seconds sys
>>
>> * Proposal
>>
>> ** Volatile access
>>
>>     #+begin_src asm
>>       0000000000000860 <func>:
>>        860:   90000101        adrp    x1, 20000 <__libc_start_main@GLIBC_2.34>
>>        864:   91012022        add     x2, x1, #0x48
>>        868:   f9402420        ldr     x0, [x1, #72]
>>        86c:   f9400003        ldr     x3, [x0]
>>        870:   f9000443        str     x3, [x2, #8]
>>        874:   f9402423        ldr     x3, [x1, #72]
>>        878:   aa0303e1        mov     x1, x3
>>        87c:   eb01001f        cmp     x0, x1
>>        880:   54000040        b.eq    888 <func+0x28>  // b.none
>>        884:   d65f03c0        ret
>>        888:   f9400060        ldr     x0, [x3]
>>        88c:   f9000440        str     x0, [x2, #8]
>>        890:   d65f03c0        ret
>>     #+end_src
>>
>>      Performance counter stats for './a.out 1000000000':
>>
>>            4,733.47 msec task-clock                       #    0.999 CPUs utilized
>>                  18      context-switches                 #    3.803 /sec
>>                   0      cpu-migrations                   #    0.000 /sec
>>                  42      page-faults                      #    8.873 /sec
>>       9,020,349,576      cycles                           #    1.906 GHz
>>      16,009,538,541      instructions                     #    1.77  insn per cycle
>>     <not supported>      branches
>>              29,834      branch-misses
>>
>>         4.736255910 seconds time elapsed
>>
>>         4.731968000 seconds user
>>         0.003999000 seconds sys
>>
>> ** Atomic builtins
>>
>>    #+begin_src asm
>>      0000000000000860 <func>:
>>       860:   90000101        adrp    x1, 20000 <__libc_start_main@GLIBC_2.34>
>>       864:   91012021        add     x1, x1, #0x48
>>       868:   c8dffc20        ldar    x0, [x1]
>>       86c:   f9400002        ldr     x2, [x0]
>>       870:   f9000422        str     x2, [x1, #8]
>>       874:   c8dffc23        ldar    x3, [x1]
>>       878:   aa0303e2        mov     x2, x3
>>       87c:   eb00005f        cmp     x2, x0
>>       880:   54000040        b.eq    888 <func+0x28>  // b.none
>>       884:   d65f03c0        ret
>>       888:   f9400060        ldr     x0, [x3]
>>       88c:   f9000420        str     x0, [x1, #8]
>>       890:   d65f03c0        ret
>>    #+end_src
>>
>>     Performance counter stats for './a.out 1000000000':
>>
>>           22,062.47 msec task-clock                       #    1.000 CPUs utilized
>>                  17      context-switches                 #    0.771 /sec
>>                   0      cpu-migrations                   #    0.000 /sec
>>                  43      page-faults                      #    1.949 /sec
>>      42,157,489,783      cycles                           #    1.911 GHz
>>      16,039,077,935      instructions                     #    0.38  insn per cycle
>>     <not supported>      branches
>>              76,727      branch-misses
>>
>>        22.065725405 seconds time elapsed
>>
>>        22.061101000 seconds user
>>         0.004000000 seconds sys
>>
>> * Summary
>>
>>    Aarch64 Cortex-A57
>>    
>>    | Variant         | Time [s]    | Cycles        | Instructions   | Branch misses |
>>    |-----------------+-------------+---------------+----------------+---------------|
>>    | Baseline        | 4.217609351 | 8 015 627 017 | 15 008 330 513 | 26 607        |
>>    |-----------------+-------------+---------------+----------------+---------------|
>>    | Volatile access | +10.95 %    | +11.14 %      | +6.25 %        | +10.81 %      |
>>    | Atomic builtins | +423.18 %   | +425.94 %     | +6.87 %        | +188.37 %     |
>>
> 
>> -- 
>> Olivier Dion
>> EfficiOS Inc.
>> https://www.efficios.com
>>
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

