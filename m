Return-Path: <SRS0=Ki2T=JN=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDD4C433ED
	for <lttng-dev@archiver.kernel.org>; Fri, 16 Apr 2021 15:32:35 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E6D611BF
	for <lttng-dev@archiver.kernel.org>; Fri, 16 Apr 2021 15:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E6D611BF
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FMKw0562jz1C14;
	Fri, 16 Apr 2021 11:32:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1618587153;
	bh=S4IgsDu77/jggkfHX07GeiYGjFnw5+gDDp2hmXwSqgA=;
	h=To:References:Date:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=00NKMaogaEw71YX1wIQtiDvarhsMfP2XVUCmF6xiN7ECtkX4ON7oqZde7qukEohwF
	 gAgIhlyCjwbbjhzJQ64fhwPMen1AgQE3TSBdz1oUPcGVQMTXy0xBc4T7cu2u8TGvtz
	 WguHY9+G5JvVgbqAUifjSu4eo+6UbDstMyfY9FlBowZqME7KfMmiVZgfB9Avqg6E2S
	 0x53PmXpb8sT1bHyLfSy3FF7eKG+TKRHIjNh5DXuwrDL8Mn24Jz0X74OCn5BZADFer
	 6QT8mnvDm77hxHvPz4xi/BzMx5d/xW39/uPZ3j2HFlxZJ/4ofyBk2+hwKXKG4Y9ZWr
	 2vzd9K63eThxg==
Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
 by lists.lttng.org (Postfix) with ESMTP id 4FMKvx1xWlz1C12
 for <lttng-dev@lists.lttng.org>; Fri, 16 Apr 2021 11:32:28 -0400 (EDT)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 by smtpfb2-g21.free.fr (Postfix) with ESMTP id 447194C7EC
 for <lttng-dev@lists.lttng.org>; Fri, 16 Apr 2021 17:22:36 +0200 (CEST)
Received: from [IPv6:2a01:e0a:255:1000:65f8:ccc2:5456:3ac3] (unknown
 [IPv6:2a01:e0a:255:1000:65f8:ccc2:5456:3ac3])
 (Authenticated sender: duncan.sands@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id 517785FFC1
 for <lttng-dev@lists.lttng.org>; Fri, 16 Apr 2021 17:22:21 +0200 (CEST)
To: lttng-dev@lists.lttng.org
References: <1680415903.81652.1618584736742.JavaMail.zimbra@efficios.com>
Message-ID: <0b613c40-24b4-6836-d47b-705ac0e46386@free.fr>
Date: Fri, 16 Apr 2021 17:22:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1680415903.81652.1618584736742.JavaMail.zimbra@efficios.com>
Content-Language: en-US
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
From: Duncan Sands via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Duncan Sands <baldrick@free.fr>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Mathieu,

On 4/16/21 4:52 PM, Mathieu Desnoyers via lttng-dev wrote:
> Hi Paul, Will, Peter,
> 
> I noticed in this discussion https://lkml.org/lkml/2021/4/16/118 that LTO
> is able to break rcu_dereference. This seems to be taken care of by
> arch/arm64/include/asm/rwonce.h on arm64 in the Linux kernel tree.
> 
> In the liburcu user-space library, we have this comment near rcu_dereference() in
> include/urcu/static/pointer.h:
> 
>   * The compiler memory barrier in CMM_LOAD_SHARED() ensures that value-speculative
>   * optimizations (e.g. VSS: Value Speculation Scheduling) does not perform the
>   * data read before the pointer read by speculating the value of the pointer.
>   * Correct ordering is ensured because the pointer is read as a volatile access.
>   * This acts as a global side-effect operation, which forbids reordering of
>   * dependent memory operations. Note that such concern about dependency-breaking
>   * optimizations will eventually be taken care of by the "memory_order_consume"
>   * addition to forthcoming C++ standard.
> 
> (note: CMM_LOAD_SHARED() is the equivalent of READ_ONCE(), but was introduced in
> liburcu as a public API before READ_ONCE() existed in the Linux kernel)

this is not directly on topic, but what do you think of porting userspace RCU to 
use the C++ memory model and GCC/LLVM atomic builtins (__atomic_store etc) 
rather than rolling your own?  Tools like thread sanitizer would then understand 
what userspace RCU is doing.  Not to mention the compiler.  More developers 
would understand it too!

 From a code organization viewpoint, going down this path would presumably mean 
directly using GCC/LLVM atomic support when available, and falling back on 
something like the current uatomic to emulate them for older compilers.

Some parts of uatomic have pretty clear equivalents (see below), but not all, so 
the conversion could be quite tricky.

> Peter tells me the "memory_order_consume" is not something which can be used today.

This is a pity, because it seems to have been invented with rcu_dereference in mind.

> Any information on its status at C/C++ standard levels and implementation-wise ?
> 
> Pragmatically speaking, what should we change in liburcu to ensure we don't generate
> broken code when LTO is enabled ? I suspect there are a few options here:
> 
> 1) Fail to build if LTO is enabled,
> 2) Generate slower code for rcu_dereference, either on all architectures or only
>     on weakly-ordered architectures,
> 3) Generate different code depending on whether LTO is enabled or not. AFAIU this would only
>     work if every compile unit is aware that it will end up being optimized with LTO. Not sure
>     how this could be done in the context of user-space.
> 4) [ Insert better idea here. ]
> 
> Thoughts ?

Best wishes, Duncan.

PS: We are experimentally running with the following patch, as it already makes 
thread sanitizer a lot happier:

--- a/External/UserspaceRCU/userspace-rcu/include/urcu/system.h

+++ b/External/UserspaceRCU/userspace-rcu/include/urcu/system.h

@@ -26,34 +26,45 @@

   * Identify a shared load. A cmm_smp_rmc() or cmm_smp_mc() should come

   * before the load.

   */

-#define _CMM_LOAD_SHARED(p)	       CMM_ACCESS_ONCE(p)

+#define _CMM_LOAD_SHARED(p)					\

+	__extension__						\

+	({							\

+		__typeof__(p) v;				\

+		__atomic_load(&p, &v, __ATOMIC_RELAXED);	\

+		v;						\

+	})



  /*

   * Load a data from shared memory, doing a cache flush if required.

   */

-#define CMM_LOAD_SHARED(p)			\

-	__extension__			\

-	({				\

-		cmm_smp_rmc();		\

-		_CMM_LOAD_SHARED(p);	\

+#define CMM_LOAD_SHARED(p)					\

+	__extension__						\

+	({							\

+		__typeof__(p) v;				\

+		__atomic_load(&p, &v, __ATOMIC_ACQUIRE);	\

+		v;						\

  	})



  /*

   * Identify a shared store. A cmm_smp_wmc() or cmm_smp_mc() should

   * follow the store.

   */

-#define _CMM_STORE_SHARED(x, v)	__extension__ ({ CMM_ACCESS_ONCE(x) = (v); })

+#define _CMM_STORE_SHARED(x, v)					\

+	__extension__						\

+	({							\

+		__typeof__(x) w = v;				\

+		__atomic_store(&x, &w, __ATOMIC_RELAXED);	\

+	})



  /*

   * Store v into x, where x is located in shared memory. Performs the

   * required cache flush after writing. Returns v.

   */

-#define CMM_STORE_SHARED(x, v)						\

-	__extension__							\

-	({								\

-		__typeof__(x) _v = _CMM_STORE_SHARED(x, v);		\

-		cmm_smp_wmc();						\

-		_v = _v;	/* Work around clang "unused result" */	\

+#define CMM_STORE_SHARED(x, v)					\

+	__extension__						\

+	({							\

+		__typeof__(x) w = v;				\

+		__atomic_store(&x, &w, __ATOMIC_RELEASE);	\

  	})



  #endif /* _URCU_SYSTEM_H */

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
