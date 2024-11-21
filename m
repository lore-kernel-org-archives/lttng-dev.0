Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95CBE64000
	for <lttng-dev@archiver.kernel.org>; Thu, 21 Nov 2024 18:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1732212811;
	bh=AamIVFmnPjq5QD7cdpl6y76zDVCsIiq9iY0Agz442PM=;
	h=To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=MgV+Zv+5bGORVRsQvv8CLqJuzktdX5A4WyOJepEzpPwkdmIlkOjl3BYAHqG4HlPpS
	 W06Pi0Mntdj8Sz1KIpi9MDsHFBLYKPAJq2Wm1Ha2yv3pOzWT5Qg7mDd0l5+7q5F7Yc
	 DDqCzl9jRibdN6XZ4n9VZSq30DrN5rbed8zBce9H6Q8MEQ/uDrNJXckRAvBRe8XQU4
	 mTkZiUda/+TqmkWR3shXbg/RViCMfMo5MYTrJzCYrV68aoF1exIgH3PXh/aRPg/v16
	 2b5gw8qz2ATyHlXVJVFNvYB5kyAlm9/wjRBLEB+9/dZQlcZTujoiw9d740hxm9K9G5
	 ro5bJMniK1uxg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4XvRDq3SR3z24xd;
	Thu, 21 Nov 2024 13:13:31 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com
 [IPv6:2607:5300:203:b2ee::31e5])
 by lists.lttng.org (Postfix) with ESMTPS id 4XvRDp0whkz24jF
 for <lttng-dev@lists.lttng.org>; Thu, 21 Nov 2024 13:13:30 -0500 (EST)
Received: from localhost (157-208-8-209.mc.derytele.com [157.208.8.209])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4XvRDn4GD2z13P2;
 Thu, 21 Nov 2024 13:13:29 -0500 (EST)
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, paulmck@kernel.org
Cc: lttng-dev@lists.lttng.org
Subject: Re: [Userspace RCU] - rcu_dereference() memory ordering
In-Reply-To: <47507865-d3a7-494f-91a0-7a3ff2a6f8db@efficios.com>
Organization: EfficiOS
References: <87y12hmdwf.fsf@laura>
 <a941f427-a401-426d-bfb5-7d89de374086@paulmck-laptop>
 <47507865-d3a7-494f-91a0-7a3ff2a6f8db@efficios.com>
Date: Thu, 21 Nov 2024 13:13:29 -0500
Message-ID: <87serkcv5i.fsf@laura>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Thu, 21 Nov 2024, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wro=
te:
> On 2024-10-21 19:35, Paul E. McKenney wrote:
>> On Mon, Oct 21, 2024 at 03:53:04PM -0400, Olivier Dion wrote:
[...]=20
>> How much of the added "Volatile access" overhead is due to the volatile
>> load and how much to the cmm_ptr_eq?  Many use cases do not need to
>> compare pointers, except maybe against NULL.  Or against a sentinel.
>> In both cases, an equality comparison means no dereferncing, so no
>> problems.
>
> Olivier will prepare benchmarks without the cmm_ptr_eq() so we can isolate
> the overhead contribution of volatile vs atomic builtins more
> specifically.

Here is the micro-benchmark without pointers comparison.  Tight loop of
rcu_derefenrece() ran 1 000 000 000 times:

Hardware:

  ARM Cortex-A57

Overview:

 | Implementation | Instructions   | Cycles         | Branch misses | Task =
clock (ms) | Insn/cycle |
 |----------------+----------------+----------------+---------------+------=
-----------+------------|
 | Volatile (V)   | 10 006 366 281 | 6 011 214 706  | 21 168        | 3 159=
.60        |       1.66 |
 | Atomic (A)     | 10 020 098 136 | 21 081 007 289 | 46 091        | 11 03=
9.38       |       0.48 |
 |----------------+----------------+----------------+---------------+------=
-----------+------------|
 | =CE=94 (A / V - 1)  | 0.14 %         | 250.69 %       | 117.74 %      | =
249.39 %        |   -71.08 % |

Volatile:

         0000000000000860 <func>:
          860:   90000100        adrp    x0, 20000 <__libc_start_main@GLIBC=
_2.34>
          864:   91012001        add     x1, x0, #0x48
          868:   f9402400        ldr     x0, [x0, #72]   ;; rcu_dereference=
()
          86c:   f9400000        ldr     x0, [x0]
          870:   f9000420        str     x0, [x1, #8]
          874:   d65f03c0        ret

          3,159.60 msec task-clock                       #    0.999 CPUs ut=
ilized
                 3      context-switches                 #    0.949 /sec
                 0      cpu-migrations                   #    0.000 /sec
                42      page-faults                      #   13.293 /sec
     6,011,214,706      cycles                           #    1.903 GHz
    10,006,366,281      instructions                     #    1.66  insn pe=
r cycle
   <not supported>      branches
            21,168      branch-misses

       3.161819264 seconds time elapsed

       3.161902000 seconds user
       0.000000000 seconds sys

Atomic:

        0000000000000860 <func>:
         860:   90000100        adrp    x0, 20000 <__libc_start_main@GLIBC_=
2.34>
         864:   91012000        add     x0, x0, #0x48
         868:   c8dffc01        ldar    x1, [x0]        ;; rcu_dereference()
         86c:   f9400021        ldr     x1, [x1]
         870:   f9000401        str     x1, [x0, #8]
         874:   d65f03c0        ret

         11,039.38 msec task-clock                       #    1.000 CPUs ut=
ilized
                20      context-switches                 #    1.812 /sec
                 0      cpu-migrations                   #    0.000 /sec
                43      page-faults                      #    3.895 /sec
    21,081,007,289      cycles                           #    1.910 GHz
    10,020,098,136      instructions                     #    0.48  insn pe=
r cycle
   <not supported>      branches
            46,091      branch-misses

      11.042103521 seconds time elapsed

      11.041847000 seconds user
       0.000000000 seconds sys

[...]
--=20
Olivier Dion
EfficiOS Inc.
https://www.efficios.com
