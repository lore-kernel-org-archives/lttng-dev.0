Return-Path: <SRS0=Ppkc=FV=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AAAC2BB48
	for <lttng-dev@archiver.kernel.org>; Thu, 17 Dec 2020 13:29:52 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6B2F22E02
	for <lttng-dev@archiver.kernel.org>; Thu, 17 Dec 2020 13:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B2F22E02
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CxXsp3TWXzFdL;
	Thu, 17 Dec 2020 08:29:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1608211790;
	bh=Q0yZRDYSzCainuITaduL73mYLUIpEYcp/WmjVMLwtJU=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=zDougGPIoStxakMDnZxZMRoeWgCg0T5VZoU90KInjpo6R6DJn7cW5pt5My5IDWp49
	 G+3osMGuj8V8+4u+4TJhFwGZmbvYCMpm+UfruWvQls22hzbzNZJxAj/GAsw4nw9g6S
	 JCyKo7QXKc1Ed+iLtsbSCUNFrGuB5Gsu9J4ofUvelhbEXhOBgLBvy/JA0I8rbS0yOR
	 k5W8lZ2XfZ6xE7+6tzwntWH6bpADSeX9Lk6v521vO5Jz1RHpzJBBtNyyBCCRJcFlmQ
	 Gl9gnF9fxcHlWqFuWMo2zV3yr/HYZsnveG3MDdmIjG18P/M/BjO/cK9v3hgoifvo8S
	 r2DUB+b+ECbVw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CxXsm53SWzFRf
 for <lttng-dev@lists.lttng.org>; Thu, 17 Dec 2020 08:29:48 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8A0AD2A2AA9;
 Thu, 17 Dec 2020 08:29:48 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id E_50zqGu8uzk; Thu, 17 Dec 2020 08:29:45 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2A1A42A2AA7;
 Thu, 17 Dec 2020 08:29:45 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2A1A42A2AA7
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id fFZvsCrzMeWJ; Thu, 17 Dec 2020 08:29:45 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 21E1C2A2D00;
 Thu, 17 Dec 2020 08:29:45 -0500 (EST)
Date: Thu, 17 Dec 2020 08:29:45 -0500 (EST)
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, 
 Jason Wessel <jason.wessel@windriver.com>
Message-ID: <1206171925.6533.1608211785123.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201215162850.78638-3-mjeanson@efficios.com>
References: <20201215162850.78638-1-mjeanson@efficios.com>
 <20201215162850.78638-3-mjeanson@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF83 (Linux)/8.8.15_GA_3980)
Thread-Topic: Use DMB only on ARMv7
Thread-Index: GJI9jDtwQ+St/JIF6kzj4dm6h6+gnQ==
Subject: Re: [lttng-dev] [PATCH urcu 3/4] Use DMB only on ARMv7
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
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

Merged in liburcu master, thanks!

Mathieu

----- On Dec 15, 2020, at 11:28 AM, Michael Jeanson mjeanson@efficios.com wrote:

> Remove the configure time CONFIG_RCU_ARM_HAVE_DMB option and replace it
> by compile time detection based on the ARM ISA version. This makes sure
> we unconditionnaly use the DMB instruction only on ARMv7 where it's part
> of the baseline ISA.
> 
> This will change the behavior on ARMv6 platform that possibly have this
> instruction but it was probably already broken since we use the 'ISH'
> option which doesn't seem to be valid on this ISA.
> 
> This will also allow sharing headers in a multi-arch environment and
> reduce the build system complexity.
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Change-Id: I8e56ada55148d8e0f198c3d2e741ea414de5fef2
> ---
> configure.ac             | 19 -------------------
> include/urcu/arch.h      |  7 +++++++
> include/urcu/arch/arm.h  | 13 +++++++++++--
> include/urcu/config.h.in |  3 ---
> 4 files changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index d1d43e6..daa967a 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -21,7 +21,6 @@ m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
> AC_REQUIRE_AUX_FILE([tap-driver.sh])
> 
> AH_TEMPLATE([CONFIG_RCU_SMP], [Enable SMP support. With SMP support enabled,
> uniprocessors are also supported. With SMP support disabled, UP systems work
> fine, but the behavior of SMP systems is undefined.])
> -AH_TEMPLATE([CONFIG_RCU_ARM_HAVE_DMB], [Use the dmb instruction if available
> for use on ARM.])
> AH_TEMPLATE([CONFIG_RCU_TLS], [TLS provided by the compiler.])
> AH_TEMPLATE([CONFIG_RCU_HAVE_CLOCK_GETTIME], [clock_gettime() is detected.])
> AH_TEMPLATE([CONFIG_RCU_FORCE_SYS_MEMBARRIER], [Require the operating system to
> support the membarrier system call for default and bulletproof flavors.])
> @@ -124,24 +123,6 @@ AS_IF([test "$host_cpu" = "armv7l"],[
> 	AM_CFLAGS="$AM_CFLAGS -mcpu=cortex-a9 -mtune=cortex-a9 -O1"
> ])
> 
> -# ARM-specific checks
> -AS_CASE([$host_cpu], [arm*], [
> -	AC_MSG_CHECKING([for dmb instruction])
> -	AC_COMPILE_IFELSE([AC_LANG_SOURCE([[
> -				int main()
> -				{
> -					asm volatile("dmb":::"memory");
> -					return 0;
> -				}
> -		]])
> -	],[
> -		AC_MSG_RESULT([yes])
> -		AC_DEFINE([CONFIG_RCU_ARM_HAVE_DMB], [1])
> -	],[
> -		AC_MSG_RESULT([no])
> -	])
> -])
> -
> # Search for clock_gettime
> AC_SEARCH_LIBS([clock_gettime], [rt], [
> 	AC_DEFINE([CONFIG_RCU_HAVE_CLOCK_GETTIME], [1])
> diff --git a/include/urcu/arch.h b/include/urcu/arch.h
> index c4b8bc2..620743c 100644
> --- a/include/urcu/arch.h
> +++ b/include/urcu/arch.h
> @@ -41,6 +41,7 @@
>  * URCU_ARCH_ALPHA : All DEC Alpha variants
>  * URCU_ARCH_IA64 : All Intel Itanium variants
>  * URCU_ARCH_ARM : All ARM 32 bits variants
> + *   URCU_ARCH_ARMV7 : All ARMv7 ISA variants
>  * URCU_ARCH_AARCH64 : All ARM 64 bits variants
>  * URCU_ARCH_MIPS : All MIPS variants
>  * URCU_ARCH_NIOS2 : All Intel / Altera NIOS II variants
> @@ -105,6 +106,12 @@
> #define URCU_ARCH_IA64 1
> #include <urcu/arch/ia64.h>
> 
> +#elif (defined(__ARM_ARCH_7A__) || defined(__ARM_ARCH_7__))
> +
> +#define URCU_ARCH_ARMV7 1
> +#define URCU_ARCH_ARM 1
> +#include <urcu/arch/arm.h>
> +
> #elif (defined(__arm__) || defined(__arm))
> 
> #define URCU_ARCH_ARM 1
> diff --git a/include/urcu/arch/arm.h b/include/urcu/arch/arm.h
> index e904b06..54ca4fa 100644
> --- a/include/urcu/arch/arm.h
> +++ b/include/urcu/arch/arm.h
> @@ -30,7 +30,15 @@
> extern "C" {
> #endif
> 
> -#ifdef CONFIG_RCU_ARM_HAVE_DMB
> +/*
> + * Using DMB is faster than the builtin __sync_synchronize and this instruction
> is
> + * part of the baseline ARMv7 ISA.
> + */
> +#ifdef URCU_ARCH_ARMV7
> +
> +/* For backwards compat. */
> +#define CONFIG_RCU_ARM_HAVE_DMB 1
> +
> /*
>  * Issues full system DMB operation.
>  */
> @@ -44,7 +52,8 @@ extern "C" {
> #define cmm_smp_mb()	__asm__ __volatile__ ("dmb ish":::"memory")
> #define cmm_smp_rmb()	__asm__ __volatile__ ("dmb ish":::"memory")
> #define cmm_smp_wmb()	__asm__ __volatile__ ("dmb ish":::"memory")
> -#endif /* CONFIG_RCU_ARM_HAVE_DMB */
> +
> +#endif /* URCU_ARCH_ARMV7 */
> 
> #include <stdlib.h>
> #include <sys/time.h>
> diff --git a/include/urcu/config.h.in b/include/urcu/config.h.in
> index faf7817..99d763a 100644
> --- a/include/urcu/config.h.in
> +++ b/include/urcu/config.h.in
> @@ -5,9 +5,6 @@
>    behavior of SMP systems is undefined. */
> #undef CONFIG_RCU_SMP
> 
> -/* Use the dmb instruction is available for use on ARM. */
> -#undef CONFIG_RCU_ARM_HAVE_DMB
> -
> /* TLS provided by the compiler. */
> #undef CONFIG_RCU_TLS
> 
> --
> 2.29.2

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
