Return-Path: <SRS0=YxZC=EX=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2503CC63697
	for <lttng-dev@archiver.kernel.org>; Tue, 17 Nov 2020 20:34:29 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12CBB2225E
	for <lttng-dev@archiver.kernel.org>; Tue, 17 Nov 2020 20:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="xsMNCNbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CBB2225E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CbHjb0fvZz1Jy7;
	Tue, 17 Nov 2020 15:34:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1605645267;
	bh=E+SqCdnYO2PNJRini2mMS4E3ZNQqxknrvhulzMAlhGA=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=xsMNCNbRl/U4f1zccRNaMWvEjMMGOgT/e24os+nP0NcNgjV78/bMk9yJvCHKZAa6G
	 46/Gbpo5bAm3jA3biyYwCOhPGplY5HFw68Ku4vCd+GQ5wbIeIyElqJVBc+/Osl/akn
	 UekQR1I0TQKvwa1OG7p9E8sSAEUHnSg8RFI4lAkilMKGBoHgVHkULFmTf80Llb69Oh
	 kFptEp9AbZ8Suhg+hP7nF74/GXnxayiBKCScOEFpQxfGTWHgzZBCOCqOzs3Sx4D9ms
	 XBa8uhodbc3ME9S0qkSPwEIYsNhK8SoqZj20lXQeAEXV0DidGBZcG1hizCbdGPgjPB
	 LPz/YAi4OeKHw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CbHjW1xkVz1K3Q
 for <lttng-dev@lists.lttng.org>; Tue, 17 Nov 2020 15:34:23 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 38CE42E3CDB;
 Tue, 17 Nov 2020 15:34:23 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id D_-4YAQCk8OP; Tue, 17 Nov 2020 15:34:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1C8DA2E408D;
 Tue, 17 Nov 2020 15:34:22 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1C8DA2E408D
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id BlGATeLSaabE; Tue, 17 Nov 2020 15:34:22 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 127362E3DD9;
 Tue, 17 Nov 2020 15:34:22 -0500 (EST)
Date: Tue, 17 Nov 2020 15:34:22 -0500 (EST)
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1527923278.48430.1605645262050.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201117202246.83849-1-mjeanson@efficios.com>
References: <20201117202246.83849-1-mjeanson@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3975 (ZimbraWebClient - FF82 (Linux)/8.8.15_GA_3975)
Thread-Topic: cleanup: Improve wording of CONFIG_RCU_DEBUG description
Thread-Index: Sp3U+4u9Ojddo+0APhyZ83cbdtn+mw==
Subject: Re: [lttng-dev] [PATCH urcu] cleanup: Improve wording of
 CONFIG_RCU_DEBUG description
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

Merged into master, stable-0.11, stable-0.12, thanks!

Mathieu

----- On Nov 17, 2020, at 3:22 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> configure.ac             | 4 ++--
> include/urcu/config.h.in | 2 +-
> 2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index b62f587..73ab19f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -28,7 +28,7 @@ AH_TEMPLATE([CONFIG_RCU_ARM_HAVE_DMB], [Use the dmb
> instruction if available for
> AH_TEMPLATE([CONFIG_RCU_TLS], [TLS provided by the compiler.])
> AH_TEMPLATE([CONFIG_RCU_HAVE_CLOCK_GETTIME], [clock_gettime() is detected.])
> AH_TEMPLATE([CONFIG_RCU_FORCE_SYS_MEMBARRIER], [Require the operating system to
> support the membarrier system call for default and bulletproof flavors.])
> -AH_TEMPLATE([CONFIG_RCU_DEBUG], [Enable internal debugging self-checks.
> Introduce performance penalty.])
> +AH_TEMPLATE([CONFIG_RCU_DEBUG], [Enable internal debugging self-checks.
> Introduces a performance penalty.])
> AH_TEMPLATE([CONFIG_CDS_LFHT_ITER_DEBUG], [Enable extra debugging checks for
> lock-free hash table iterator traversal. Alters the rculfhash ABI. Make sure to
> compile both library and application with matching configuration.])
> 
> # Allow requiring the operating system to support the membarrier system
> @@ -257,7 +257,7 @@ AS_IF([test "x$def_smp_support" = "xyes"],
> [AC_DEFINE([CONFIG_RCU_SMP], [1])])
> # RCU debugging option
> AC_ARG_ENABLE([rcu-debug],
>       AS_HELP_STRING([--enable-rcu-debug], [Enable internal debugging
> -		      self-checks. Introduce performance penalty.]))
> +		      self-checks. Introduces a performance penalty.]))
> AS_IF([test "x$enable_rcu_debug" = "xyes"], [
>        AC_DEFINE([CONFIG_RCU_DEBUG], [1])
> ])
> diff --git a/include/urcu/config.h.in b/include/urcu/config.h.in
> index 8c3e4da..7350631 100644
> --- a/include/urcu/config.h.in
> +++ b/include/urcu/config.h.in
> @@ -28,7 +28,7 @@
> #undef CONFIG_RCU_FORCE_SYS_MEMBARRIER
> 
> /* Enable internal debugging self-checks.
> -   Introduce performance penalty. */
> +   Introduces a performance penalty. */
> #undef CONFIG_RCU_DEBUG
> 
> /* Expose multi-flavor support */
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
