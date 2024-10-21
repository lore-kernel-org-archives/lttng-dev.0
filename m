Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E9CD1712B
	for <lttng-dev@archiver.kernel.org>; Mon, 21 Oct 2024 19:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1729540389;
	bh=vgaN3snJI9VfidQ/B9/f4PgSe/gfQVtrR43q3vDhqqA=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=IuvoPSp7yRYc5E1bYTY9bEqSo9FKTePH9wnFHACBmbIIqlOZHrOk90mj60Z3JQfmJ
	 nnD1QsPMbzD+14owh9FYPPSogrx4A53syCM8GMkV3hRbqdwoJtTXRiINX7iNAH8tHb
	 qcL3dPY3wbDsaw0ghtnK/Xw3NAaFfj2phDS3m3nU4mTvA1gfLvvhr963IZ5BI2cxPP
	 bS/+dUmvFh1hNf7eClJMD88bj4xah7ZZDjDoSmgS7ZgyV09hBHPWdw7ZFWtUK9xilo
	 +QSYcybd7fBGf2yWb7JG7SiT2Xze+KW79vPC276ofXaZIb1n7k9aEvDZhZVWrvnIRo
	 w4PGR+xuZD+Cg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4XXQw41pNqz2LbT;
	Mon, 21 Oct 2024 15:53:08 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com
 [IPv6:2607:5300:203:b2ee::31e5])
 by lists.lttng.org (Postfix) with ESMTPS id 4XXQw20Qb9z2LbR
 for <lttng-dev@lists.lttng.org>; Mon, 21 Oct 2024 15:53:05 -0400 (EDT)
Received: from localhost (157-208-8-209.mc.derytele.com [157.208.8.209])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4XXQw06b7Gz1SGp;
 Mon, 21 Oct 2024 15:53:04 -0400 (EDT)
To: "Paul E. McKenney" <paulmck@kernel.org>
Organization: EfficiOS
Date: Mon, 21 Oct 2024 15:53:04 -0400
Message-ID: <87y12hmdwf.fsf@laura>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Subject: [lttng-dev] [Userspace RCU] - rcu_dereference() memory ordering
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
From: Olivier Dion via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Olivier Dion <odion@efficios.com>
Cc: lttng-dev@lists.lttng.org
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--=-=-=
Content-Type: text/plain

Hi Paul,

In liburcu, `rcu_dereference()' is either implemented with volatile
access with `CMM_LOAD_SHARED()' followed by a memory barrier depends, or
a atomic load with CONSUME memory ordering (configurable by users on a
compilation unit basis).

However, it is my understanding that the CONSUME memory ordering
semantic has some deficiency [0] and will be promoted to a ACQUIRE
memory ordering.  This is somewhat inefficient (see benchmarks at the
end) for weakly-ordered architectures [1]:

  rcu_dereference_consume:
          sub     sp, sp, #16
          add     x1, sp, 8
          str     x0, [sp, 8]
          ldar    x0, [x1]     ;; Load acquire
          add     sp, sp, 16
          ret     
  rcu_dereference_relaxed:
          sub     sp, sp, #16
          add     x1, sp, 8
          str     x0, [sp, 8]
          ldr     x0, [x1]     ;; Load
          add     sp, sp, 16
          rer

I had a discussion with Mathieu on that, and using the RELAXED memory
ordering (on every architecture except Alpha) + a compiler barrier would
not prevent compiler value-speculative optimizations (e.g. VSS: Value
Speculation Scheduling).

Consider the following code:

  #define cmm_barrier() asm volatile ("" : : : "memory")
  #define rcu_dereference(p) __atomic_load_n(&(p), __ATOMIC_RELAXED)

  // Assume QSBR flavor
  #define rcu_read_lock() do { } while (0)
  #define rcu_read_unlock() do { } while (0)

  struct foo {
      long x;
  };

  struct foo *foo;

  extern void do_stuff(long);

  // Assume that global pointer `foo' is never NULL for simplicity.
  void func(void)
  {
      struct foo *a, *b;

      rcu_read_lock(); {
          a = rcu_dereference(foo);
          do_stuff(a->x);
      } rcu_read_unlock();
      cmm_barrier();
      rcu_read_lock(); {
          b = rcu_dereference(foo);
          if (a == b)
              do_stuff(b->x);
      } rcu_read_unlock();
  }

and the resulting assembler on ARM64 (GCC 14.2.0) [2]:

  func:
          stp     x29, x30, [sp, -32]!
          mov     x29, sp
          stp     x19, x20, [sp, 16]
          adrp    x19, .LANCHOR0
          add     x19, x19, :lo12:.LANCHOR0
          ldr     x20, [x19] ;; a = rcu_dereference | <-- here ...
          ldr     x0, [x20]  ;; a->x
          bl      do_stuff
          ldr     x0, [x19]  ;; b = rcu_dereference
          cmp     x20, x0
          beq     .L5
          ldp     x19, x20, [sp, 16]
          ldp     x29, x30, [sp], 32
          ret
  .L5:
          ldr     x0, [x20] ;; b->x | can be reordered up-to ...
          ldp     x19, x20, [sp, 16]
          ldp     x29, x30, [sp], 32
          b       do_stuff
  foo:
          .zero   8

From my understanding of the ARM memory ordering and its ISA, the
processor is within its right to reorder the `ldr x0, [x20]' in `.L5',
up to its dependency at `ldr x20, [x19]', which happen before the RCU
dereferencing of `b'.

This looks similar to what Mathieu described here [3].

Our proposed solution is to keep using the CONSUME memory ordering by
default, therefore guaranteeing correctness above all for all cases.
However, to allow for better performance, users can opt-in to use
"traditional" volatile access instead of atomic builtins for
`rcu_dereference()', as long as pointer comparisons are avoided or as
long as the `ptr_eq' wrapper proposed by Mathieu [3] is used for them.

Thus, `rcu_dereference()' would be defined as something like:

  #ifdef URCU_DEREFERENCE_USE_VOLATILE
  #  define rcu_dereference(p) do { CMM_LOAD_SHARED(p); cmm_smp_rmc(); } while(0)
  #else
  #  define rcu_dereference(p)  uatomic_load(&(p), CMM_CONSUME)
  #endif

and would yield, if using `cmm_ptr_eq' (ARM64 (GCC 14.2.0)) [4]:

  func:
          stp     x29, x30, [sp, -32]!
          mov     x29, sp
          stp     x19, x20, [sp, 16]
          adrp    x20, .LANCHOR0
          ldr     x19, [x20, #:lo12:.LANCHOR0] ;; a = rcu_dereference
          ldr     x0, [x19] ;; a->x
          bl      do_stuff
          ldr     x2, [x20, #:lo12:.LANCHOR0] ;; b = rcu_dereference | <-- here ...
          mov     x0, x19 ;; side effect of cmm_ptr_eq, force to use more registers
          mov     x1, x2  ;; and more registers
          cmp     x0, x1
          beq     .L5
          ldp     x19, x20, [sp, 16]
          ldp     x29, x30, [sp], 32
          ret
  .L5:
          ldp     x19, x20, [sp, 16]
          ldp     x29, x30, [sp], 32
          ldr     x0, [x2] ;; b->x | can be re-ordered up-to ...
          b       do_stuff
  foo:
          .zero   8

The Pro & Cons overall for selecting the volatile for rcu_dereference:

  Pro:

    - Yield better performance on weakly-ordered architectures for all
      `rcu_dereference'.

  Cons:

    - Users would need to use the `cmm_ptr_eq' for pointer comparisons,
      even on strongly ordered architectures.

    - `cmm_ptr_eq' can increase register pressure, resulting in possible
      register spilling.

Here is a benchmark summary.  You can find more details in the attached
file.

  CPU: Aarch64 Cortex-A57

  Program ran with perf.  Thight loop of the above example 1 000 000 000
  times.

  Variants are:

    - Baseline v0.14.1:: rcu_dereference() implemented with
      CMM_ACCESS_ONCE().  Pointers comparisons with `==' operator.

    - Volatile access:: rcu_dereference() implemented with
      CMM_ACCESS_ONCE().  Pointers comparisons with cmm_ptr_eq.

    - Atomic builtins:: rcu_dereference() implementd with
      __atomic_load_n CONSUME.  Pointers comparisons with cmm_ptr_eq.

  All variants were compiled with _LGPL_SOURCE.  

  | Variant         | Time [s]    | Cycles        | Instructions   | Branch misses |
  |-----------------+-------------+---------------+----------------+---------------|
  | Baseline        | 4.217609351 | 8 015 627 017 | 15 008 330 513 | 26 607        |
  |-----------------+-------------+---------------+----------------+---------------|
  | Volatile access | +10.95 %    | +11.14 %      | +6.25 %        | +10.81 %      |
  | Atomic builtins | +423.18 %   | +425.94 %     | +6.87 %        | +188.37 %     |

Any thoughts on that?

Thanks,
Olivier

 [0] https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html
 [1] https://godbolt.org/z/xxqGPjaxK
 [2] https://godbolt.org/z/cPzxq7PKb
 [3] https://lore.kernel.org/lkml/20241008135034.1982519-2-mathieu.desnoyers@efficios.com/
 [4] https://godbolt.org/z/979jnccc9


--=-=-=
Content-Type: text/x-org
Content-Disposition: attachment;
 filename=20241018T121818--benchmarks-urcu__urcu.org

#+title:      Benchmarks URCU 
#+date:       [2024-10-18 Fri 12:18]
#+filetags:   :urcu:
#+identifier: 20241018T121818

* Program

  #+begin_src c
    #define _LGPL_SOURCE
    #define URCU_DEREFERENCE_USE_VOLATILE

    #include <assert.h>
    #include <stdlib.h>

    #include <urcu/pointer.h>

    struct foo {
    	long x;
    };

    volatile long flag;

    static void do_stuff(long x)
    {
    	flag = x;
    }

    struct foo *foo;

    __attribute__((noinline))
    static void func()
    {
    	struct foo *a, *b;

    	a = rcu_dereference(foo);

    	do_stuff(a->x);

    	b = rcu_dereference(foo);

    	if (cmm_ptr_eq(a, b)) {
    		do_stuff(b->x);
    	}
    }

    int main(int argc, char *argv[])
    {
    	struct foo fuz;

    	foo = &fuz;

    	cmm_barrier();

    	assert(2 == argc);

    	long loop = atoll(argv[1]);

    	for (long k = 0; k < loop; ++k) {
    		func();
    	}

    	return 0;
    }
  #+end_src

* v0.14.1

  #+begin_src asm
    0000000000000860 <func>:
     860:   90000100        adrp    x0, 20000 <__libc_start_main@GLIBC_2.34>
     864:   91012002        add     x2, x0, #0x48
     868:   f9402401        ldr     x1, [x0, #72]
     86c:   f9400023        ldr     x3, [x1]
     870:   f9000443        str     x3, [x2, #8]
     874:   f9402400        ldr     x0, [x0, #72]
     878:   eb00003f        cmp     x1, x0
     87c:   54000040        b.eq    884 <func+0x24>  // b.none
     880:   d65f03c0        ret
     884:   f9400020        ldr     x0, [x1]
     888:   f9000440        str     x0, [x2, #8]
     88c:   d65f03c0        ret
  #+end_src

   Performance counter stats for './a.out 1000000000':

          4,214.47 msec task-clock                       #    0.999 CPUs utilized          
                14      context-switches                 #    3.322 /sec                   
                 0      cpu-migrations                   #    0.000 /sec                   
                44      page-faults                      #   10.440 /sec                   
     8,015,627,017      cycles                           #    1.902 GHz                    
    15,008,330,513      instructions                     #    1.87  insn per cycle         
   <not supported>      branches                                                    
            26,607      branch-misses                                                      

       4.217609351 seconds time elapsed

       4.213169000 seconds user
       0.004001000 seconds sys

* Proposal

** Volatile access

   #+begin_src asm
     0000000000000860 <func>:
      860:   90000101        adrp    x1, 20000 <__libc_start_main@GLIBC_2.34>
      864:   91012022        add     x2, x1, #0x48
      868:   f9402420        ldr     x0, [x1, #72]
      86c:   f9400003        ldr     x3, [x0]
      870:   f9000443        str     x3, [x2, #8]
      874:   f9402423        ldr     x3, [x1, #72]
      878:   aa0303e1        mov     x1, x3
      87c:   eb01001f        cmp     x0, x1
      880:   54000040        b.eq    888 <func+0x28>  // b.none
      884:   d65f03c0        ret
      888:   f9400060        ldr     x0, [x3]
      88c:   f9000440        str     x0, [x2, #8]
      890:   d65f03c0        ret
   #+end_src

    Performance counter stats for './a.out 1000000000':

          4,733.47 msec task-clock                       #    0.999 CPUs utilized
                18      context-switches                 #    3.803 /sec
                 0      cpu-migrations                   #    0.000 /sec
                42      page-faults                      #    8.873 /sec
     9,020,349,576      cycles                           #    1.906 GHz
    16,009,538,541      instructions                     #    1.77  insn per cycle
   <not supported>      branches
            29,834      branch-misses

       4.736255910 seconds time elapsed

       4.731968000 seconds user
       0.003999000 seconds sys

** Atomic builtins   

  #+begin_src asm
    0000000000000860 <func>:
     860:   90000101        adrp    x1, 20000 <__libc_start_main@GLIBC_2.34>
     864:   91012021        add     x1, x1, #0x48
     868:   c8dffc20        ldar    x0, [x1]
     86c:   f9400002        ldr     x2, [x0]
     870:   f9000422        str     x2, [x1, #8]
     874:   c8dffc23        ldar    x3, [x1]
     878:   aa0303e2        mov     x2, x3
     87c:   eb00005f        cmp     x2, x0
     880:   54000040        b.eq    888 <func+0x28>  // b.none
     884:   d65f03c0        ret
     888:   f9400060        ldr     x0, [x3]
     88c:   f9000420        str     x0, [x1, #8]
     890:   d65f03c0        ret
  #+end_src

   Performance counter stats for './a.out 1000000000':

         22,062.47 msec task-clock                       #    1.000 CPUs utilized
                17      context-switches                 #    0.771 /sec
                 0      cpu-migrations                   #    0.000 /sec
                43      page-faults                      #    1.949 /sec
    42,157,489,783      cycles                           #    1.911 GHz
    16,039,077,935      instructions                     #    0.38  insn per cycle
   <not supported>      branches
            76,727      branch-misses

      22.065725405 seconds time elapsed

      22.061101000 seconds user
       0.004000000 seconds sys

* Summary

  Aarch64 Cortex-A57
  
  | Variant         | Time [s]    | Cycles        | Instructions   | Branch misses |
  |-----------------+-------------+---------------+----------------+---------------|
  | Baseline        | 4.217609351 | 8 015 627 017 | 15 008 330 513 | 26 607        |
  |-----------------+-------------+---------------+----------------+---------------|
  | Volatile access | +10.95 %    | +11.14 %      | +6.25 %        | +10.81 %      |
  | Atomic builtins | +423.18 %   | +425.94 %     | +6.87 %        | +188.37 %     |


--=-=-=
Content-Type: text/plain

-- 
Olivier Dion
EfficiOS Inc.
https://www.efficios.com


--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=-=-=--
