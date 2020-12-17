Return-Path: <SRS0=Ppkc=FV=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CB8C4361B
	for <lttng-dev@archiver.kernel.org>; Thu, 17 Dec 2020 13:29:38 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ABD722E02
	for <lttng-dev@archiver.kernel.org>; Thu, 17 Dec 2020 13:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ABD722E02
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CxXsW5lsgzFNk;
	Thu, 17 Dec 2020 08:29:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1608211776;
	bh=LGPa/gMqhpS6T0LHzt5kXie6qQp5R9JzIZvri7Uh3Gw=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=muGUbzxE3Xpxapqvc7ZbJF4Rl24petOgefhLL8Q6puFyiUgEJJZkuTmAghsDDDPWf
	 wsjDGDdaZPID5khJpaUOK9I8yNAnESOOsea7NxAfNMKuxBGYGP2jfdwVSDMmE5EAG7
	 czByj3ZmcXZE7vZTGBORjdPdUWFlCUeEvq5+MfWfJ7fG7Pux4tVjdAKoOCr7NjEDSe
	 rhGWJVCclPuogRZ1UYttHbei44X7HnpvOv7Y4th5sfyMOg7fIUEWn+G70azCmOu30O
	 FDf8knos3ntjSAbADNRrY1ecazb6ND3rTLZPblgUsooHd3HxpDPeizX5omvWFdaoEV
	 VpvKswveKYcXQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CxXsV0YXrzFLZ
 for <lttng-dev@lists.lttng.org>; Thu, 17 Dec 2020 08:29:34 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 0FA0A2A2672;
 Thu, 17 Dec 2020 08:29:34 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id KAslvNaoRn44; Thu, 17 Dec 2020 08:29:33 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D1E282A2671;
 Thu, 17 Dec 2020 08:29:33 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D1E282A2671
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id BZyiMggXNYzw; Thu, 17 Dec 2020 08:29:33 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id C8C0C2A2670;
 Thu, 17 Dec 2020 08:29:33 -0500 (EST)
Date: Thu, 17 Dec 2020 08:29:33 -0500 (EST)
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <447689624.6529.1608211773801.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201215162850.78638-2-mjeanson@efficios.com>
References: <20201215162850.78638-1-mjeanson@efficios.com>
 <20201215162850.78638-2-mjeanson@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3980 (ZimbraWebClient - FF83 (Linux)/8.8.15_GA_3980)
Thread-Topic: Blacklist GCC 4.4.0, 4.4.1 and 4.4.2 on ARM
Thread-Index: qiWO6zQ2SuK7lVarSM5yUl8tIt1aNQ==
Subject: Re: [lttng-dev] [PATCH urcu 2/4] Blacklist GCC 4.4.0,
 4.4.1 and 4.4.2 on ARM
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

> GCC added __sync_synchronize() in 4.4.0 but it was broken on ARM until
> 4.4.3, see the GCC bug report for more details :
> 
>  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=42263
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> Change-Id: I629e3c8b4baaccb34b2311e220f30d0ad8b69a19
> ---
> include/urcu/arch/arm.h | 9 +++++++++
> 1 file changed, 9 insertions(+)
> 
> diff --git a/include/urcu/arch/arm.h b/include/urcu/arch/arm.h
> index 5d1c608..e904b06 100644
> --- a/include/urcu/arch/arm.h
> +++ b/include/urcu/arch/arm.h
> @@ -70,6 +70,15 @@ extern "C" {
> # endif
> #endif
> 
> +/*
> + * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=42263
> + */
> +#ifdef URCU_GCC_VERSION
> +# if URCU_GCC_VERSION >= 40400 && URCU_GCC_VERSION <= 40402
> +#  error Your gcc version has a non-functional __sync_synchronize()
> +# endif
> +#endif
> +
> #ifdef __cplusplus
> }
> #endif
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
