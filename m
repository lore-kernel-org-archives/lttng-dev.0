Return-Path: <SRS0=Ki2T=JN=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845D1C433B4
	for <lttng-dev@archiver.kernel.org>; Fri, 16 Apr 2021 20:39:50 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CBE060FEA
	for <lttng-dev@archiver.kernel.org>; Fri, 16 Apr 2021 20:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBE060FEA
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FMSkW5mg2z1BbC;
	Fri, 16 Apr 2021 16:39:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1618605588;
	bh=2WBGF8AfLkfF6sSAyjaxzY2uKHi/gxNozeGZ1KqvUw0=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=SXwA1w9vN8CiaSRY0s1eWVl/u73K5AlkGWhXYblObjzPiIWZOKmVR13czZSY7aGLd
	 qQ9TpCXxkc9GCUgJ5Y6LV3S41JUCYp9g82FtDEwYA7sR8hZ9bc2B46SDVRSj5aMnU3
	 RhBCkBd/st6ZY0NHJdSSOKT1EPDr0+sMkLSfMZJhl1ZX0Y/et85LD4gg6OkQLezPSl
	 A+urlZNs2l9nxWY2gSGNqV+RHM1x/yf0wayh/VFMRpJblEm0Hgjb/KNrBOLdi8olkr
	 nqzAM3R69NhdkX33d7AJgOghncEmg0gNYA9nWeCitVar4BC3LpAj7H242luWXve+dF
	 lOBFiWGvI7Odw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FMSkT6yfSz1C4b
 for <lttng-dev@lists.lttng.org>; Fri, 16 Apr 2021 16:39:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A4C3B33B4CE
 for <lttng-dev@lists.lttng.org>; Fri, 16 Apr 2021 16:39:39 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id nMU0Z8wxiBEB; Fri, 16 Apr 2021 16:39:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id EA4AF33B241;
 Fri, 16 Apr 2021 16:39:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com EA4AF33B241
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id GOgrIN5oqKtH; Fri, 16 Apr 2021 16:39:38 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id DD6D333B240;
 Fri, 16 Apr 2021 16:39:38 -0400 (EDT)
Date: Fri, 16 Apr 2021 16:39:38 -0400 (EDT)
To: Duncan Sands <baldrick@free.fr>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>
Message-ID: <612661965.84539.1618605578871.JavaMail.zimbra@efficios.com>
In-Reply-To: <0b613c40-24b4-6836-d47b-705ac0e46386@free.fr>
References: <1680415903.81652.1618584736742.JavaMail.zimbra@efficios.com>
 <0b613c40-24b4-6836-d47b-705ac0e46386@free.fr>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: liburcu: LTO breaking rcu_dereference on arm64 and possibly
 other architectures ?
Thread-Index: QccVRwBH2VqiEDkQ9IO3vKjcpafXpA==
Subject: Re: [lttng-dev] liburcu: LTO breaking rcu_dereference on arm64 and
 possibly other architectures ?
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- On Apr 16, 2021, at 11:22 AM, lttng-dev lttng-dev@lists.lttng.org wrote:

> Hi Mathieu,
> 

Hi Duncan,

> On 4/16/21 4:52 PM, Mathieu Desnoyers via lttng-dev wrote:
>> Hi Paul, Will, Peter,
>> 
>> I noticed in this discussion https://lkml.org/lkml/2021/4/16/118 that LTO
>> is able to break rcu_dereference. This seems to be taken care of by
>> arch/arm64/include/asm/rwonce.h on arm64 in the Linux kernel tree.
>> 
>> In the liburcu user-space library, we have this comment near rcu_dereference()
>> in
>> include/urcu/static/pointer.h:
>> 
>>   * The compiler memory barrier in CMM_LOAD_SHARED() ensures that
>>   value-speculative
>>   * optimizations (e.g. VSS: Value Speculation Scheduling) does not perform the
>>   * data read before the pointer read by speculating the value of the pointer.
>>   * Correct ordering is ensured because the pointer is read as a volatile access.
>>   * This acts as a global side-effect operation, which forbids reordering of
>>   * dependent memory operations. Note that such concern about dependency-breaking
>>   * optimizations will eventually be taken care of by the "memory_order_consume"
>>   * addition to forthcoming C++ standard.
>> 
>> (note: CMM_LOAD_SHARED() is the equivalent of READ_ONCE(), but was introduced in
>> liburcu as a public API before READ_ONCE() existed in the Linux kernel)
> 
> this is not directly on topic, but what do you think of porting userspace RCU to
> use the C++ memory model and GCC/LLVM atomic builtins (__atomic_store etc)
> rather than rolling your own?  Tools like thread sanitizer would then understand
> what userspace RCU is doing.  Not to mention the compiler.  More developers
> would understand it too!

Yes, that sounds like a clear win.

> From a code organization viewpoint, going down this path would presumably mean
> directly using GCC/LLVM atomic support when available, and falling back on
> something like the current uatomic to emulate them for older compilers.

Yes, I think this approach would be good. One caveat though: the GCC atomic
operations were known to be broken with some older compilers for specific architectures,
so we may have to keep track of a list of known buggy compilers to use our own
implementation instead in those situations. It's been a while since I've looked at
this though, so we may not even be supporting those old compilers in liburcu anymore.

> 
> Some parts of uatomic have pretty clear equivalents (see below), but not all, so
> the conversion could be quite tricky.

We'd have to see on a case by case basis, but it cannot hurt to start the effort
by integrating the easy ones.

> 
>> Peter tells me the "memory_order_consume" is not something which can be used
>> today.
> 
> This is a pity, because it seems to have been invented with rcu_dereference in
> mind.

Actually, (see other leg of this email thread) memory_order_consume works for
rcu_dereference, but it appears to be implemented as a slightly heavier than
required memory_order_acquire on weakly-ordered architectures. So we're just
moving the issue into compiler-land. Oh well.

> 
>> Any information on its status at C/C++ standard levels and implementation-wise ?
>> 
>> Pragmatically speaking, what should we change in liburcu to ensure we don't
>> generate
>> broken code when LTO is enabled ? I suspect there are a few options here:
>> 
>> 1) Fail to build if LTO is enabled,
>> 2) Generate slower code for rcu_dereference, either on all architectures or only
>>     on weakly-ordered architectures,
>> 3) Generate different code depending on whether LTO is enabled or not. AFAIU
>> this would only
>>     work if every compile unit is aware that it will end up being optimized with
>>     LTO. Not sure
>>     how this could be done in the context of user-space.
>> 4) [ Insert better idea here. ]
>> 
>> Thoughts ?
> 
> Best wishes, Duncan.
> 
> PS: We are experimentally running with the following patch, as it already makes
> thread sanitizer a lot happier:

Quick question: should we use __atomic_load() or atomic_load_explicit() (C) and
(std::atomic<__typeof__(x)>)(x)).load() (C++) ?

We'd have to make this dependent on C11/C++11 though, and keep volatile for older
compilers.

Last thing: I have limited time to work on this, so if you have well-tested patches
you wish to submit, I'll do my best to review them!

Thanks,

Mathieu

> 
> --- a/External/UserspaceRCU/userspace-rcu/include/urcu/system.h
> 
> +++ b/External/UserspaceRCU/userspace-rcu/include/urcu/system.h
> 
> @@ -26,34 +26,45 @@
> 
>   * Identify a shared load. A cmm_smp_rmc() or cmm_smp_mc() should come
> 
>   * before the load.
> 
>   */
> 
> -#define _CMM_LOAD_SHARED(p)	       CMM_ACCESS_ONCE(p)
> 
> +#define _CMM_LOAD_SHARED(p)					\
> 
> +	__extension__						\
> 
> +	({							\
> 
> +		__typeof__(p) v;				\
> 
> +		__atomic_load(&p, &v, __ATOMIC_RELAXED);	\
> 
> +		v;						\
> 
> +	})
> 
> 
> 
>  /*
> 
>   * Load a data from shared memory, doing a cache flush if required.
> 
>   */
> 
> -#define CMM_LOAD_SHARED(p)			\
> 
> -	__extension__			\
> 
> -	({				\
> 
> -		cmm_smp_rmc();		\
> 
> -		_CMM_LOAD_SHARED(p);	\
> 
> +#define CMM_LOAD_SHARED(p)					\
> 
> +	__extension__						\
> 
> +	({							\
> 
> +		__typeof__(p) v;				\
> 
> +		__atomic_load(&p, &v, __ATOMIC_ACQUIRE);	\
> 
> +		v;						\
> 
>  	})
> 
> 
> 
>  /*
> 
>   * Identify a shared store. A cmm_smp_wmc() or cmm_smp_mc() should
> 
>   * follow the store.
> 
>   */
> 
> -#define _CMM_STORE_SHARED(x, v)	__extension__ ({ CMM_ACCESS_ONCE(x) = (v); })
> 
> +#define _CMM_STORE_SHARED(x, v)					\
> 
> +	__extension__						\
> 
> +	({							\
> 
> +		__typeof__(x) w = v;				\
> 
> +		__atomic_store(&x, &w, __ATOMIC_RELAXED);	\
> 
> +	})
> 
> 
> 
>  /*
> 
>   * Store v into x, where x is located in shared memory. Performs the
> 
>   * required cache flush after writing. Returns v.
> 
>   */
> 
> -#define CMM_STORE_SHARED(x, v)						\
> 
> -	__extension__							\
> 
> -	({								\
> 
> -		__typeof__(x) _v = _CMM_STORE_SHARED(x, v);		\
> 
> -		cmm_smp_wmc();						\
> 
> -		_v = _v;	/* Work around clang "unused result" */	\
> 
> +#define CMM_STORE_SHARED(x, v)					\
> 
> +	__extension__						\
> 
> +	({							\
> 
> +		__typeof__(x) w = v;				\
> 
> +		__atomic_store(&x, &w, __ATOMIC_RELEASE);	\
> 
>  	})
> 
> 
> 
>  #endif /* _URCU_SYSTEM_H */
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
