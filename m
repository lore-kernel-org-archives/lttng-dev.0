Return-Path: <SRS0=Ppkc=FV=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C08FC4361B
	for <lttng-dev@archiver.kernel.org>; Thu, 17 Dec 2020 13:29:21 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3669F22E02
	for <lttng-dev@archiver.kernel.org>; Thu, 17 Dec 2020 13:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3669F22E02
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CxXs93xMSzFV6;
	Thu, 17 Dec 2020 08:29:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1608211758;
	bh=Pco+zXgarzym2d8vj8zu4oD1hL4TNPiRZ4xJWboNvPc=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=nq5Do5rXacb+BOpRQR3nPuoYmKjkrRGMB8okcceY9EhmKyoksFpsnZCNxqqsWH1zR
	 D76ztdyX7pS3R2wi9q2fcJsnZU1J5BJZHFf5Kd6PyqObJJhSB2GMKF+yE/dHM7exks
	 boF8zMTOxqcFPwBf5+e5eKcEVul94k8ivzNGXMMVRlvZ0SfMzPUpXtNh2/b1r/cXFF
	 zSYm7/d6OWwGsnRQoFplzLyDWZnYKL5Wv5mMLMyxNpLCALQ0q9RFyfHL0lo1tZPvHT
	 Zqhkf7WJevn9PS/ppCPBzaRy0Q8UJd+R/ACfhzyUxVKAKKvYLzzQnmJqL1HHXYKbRl
	 XewrT4qoEGoQQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CxXs76GGYzFCp
 for <lttng-dev@lists.lttng.org>; Thu, 17 Dec 2020 08:29:14 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6FFF02A2A28;
 Thu, 17 Dec 2020 08:29:08 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id efdYhkPEyC0X; Thu, 17 Dec 2020 08:29:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 2557A2A2A27;
 Thu, 17 Dec 2020 08:29:08 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2557A2A2A27
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id qB_uOnNK-ukp; Thu, 17 Dec 2020 08:29:08 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 182932A2A26;
 Thu, 17 Dec 2020 08:29:08 -0500 (EST)
Date: Thu, 17 Dec 2020 08:29:08 -0500 (EST)
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1559988579.6528.1608211748013.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201215162850.78638-1-mjeanson@efficios.com>
References: <20201215162850.78638-1-mjeanson@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF83 (Linux)/8.8.15_GA_3980)
Thread-Topic: Cleanup: Move ARM specific code to urcu/arch/arm.h
Thread-Index: OnzKp7jYdxketxr3PZjqEui/vO2sow==
Subject: Re: [lttng-dev] [PATCH urcu 1/4] Cleanup: Move ARM specific code to
 urcu/arch/arm.h
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

> Change-Id: I3e17308c5ae985789a2ac8361e9c9e958ff7d656
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> include/urcu/arch/arm.h | 13 +++++++++++++
> include/urcu/compiler.h | 13 -------------
> 2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/include/urcu/arch/arm.h b/include/urcu/arch/arm.h
> index cb8f28d..5d1c608 100644
> --- a/include/urcu/arch/arm.h
> +++ b/include/urcu/arch/arm.h
> @@ -57,6 +57,19 @@ extern "C" {
> #define __NR_membarrier		389
> #endif
> 
> +/*
> + * Error out for compilers with known bugs.
> + */
> +
> +/*
> + * http://gcc.gnu.org/bugzilla/show_bug.cgi?id=58854
> + */
> +#ifdef URCU_GCC_VERSION
> +# if URCU_GCC_VERSION >= 40800 && URCU_GCC_VERSION <= 40802
> +#  error Your gcc version produces clobbered frame accesses
> +# endif
> +#endif
> +
> #ifdef __cplusplus
> }
> #endif
> diff --git a/include/urcu/compiler.h b/include/urcu/compiler.h
> index 511dbdf..4806ee3 100644
> --- a/include/urcu/compiler.h
> +++ b/include/urcu/compiler.h
> @@ -108,23 +108,10 @@
> 
> #define CAA_ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
> 
> -/*
> - * Don't allow compiling with buggy compiler.
> - */
> -
> #ifdef __GNUC__
> # define URCU_GCC_VERSION	(__GNUC__ * 10000 \
> 				+ __GNUC_MINOR__ * 100 \
> 				+ __GNUC_PATCHLEVEL__)
> -
> -/*
> - * http://gcc.gnu.org/bugzilla/show_bug.cgi?id=58854
> - */
> -# ifdef __ARMEL__
> -#  if URCU_GCC_VERSION >= 40800 && URCU_GCC_VERSION <= 40802
> -#   error Your gcc version produces clobbered frame accesses
> -#  endif
> -# endif
> #endif
> 
> #endif /* _URCU_COMPILER_H */
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
