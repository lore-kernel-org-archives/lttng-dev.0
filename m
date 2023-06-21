Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F295BEB64D7
	for <lttng-dev@archiver.kernel.org>; Wed, 21 Jun 2023 23:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687389760;
	bh=usyvtNECgwJdlGz3QFsmZveq4rmhreMIKegleFJ71AY=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=JKK7Z56Brc+N4fzShHfDDtApEsBVYyyWrzACdv3Syyfk3Hp24nNQkeaFYdBAUbN8i
	 Mlrf6kcRbKqBZPJKRD6NkEt3C8G7WvPHukrRRutwrHTxxZ2FH2LlQrP6IaiaNpZ629
	 CRPDr1AsEiFmndgBtC4wat18GdO+4O34VKnV1gO6MiQAirQpNc/JnBPPRBV/FZSbXo
	 JhtGQ83ismwRZ+8z4GBW/FDX7B1ENAopmhzvo3NErAlMFPnM16tsoaP4NwydpGkIBc
	 XdAyPbRV+bSJpmZb0ZPNnHaO/lmsVn5Q0n0McEOwcRfIlZ8BQ4gqQ2SdTJr3xNdF0O
	 OlsJbqI/3s37A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Qmfg4107rz1yPG;
	Wed, 21 Jun 2023 19:22:40 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by lists.lttng.org (Postfix) with ESMTPS id 4Qmfg234vPz1ybD
 for <lttng-dev@lists.lttng.org>; Wed, 21 Jun 2023 19:22:38 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 888C6616F5;
 Wed, 21 Jun 2023 23:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF0AC433C8;
 Wed, 21 Jun 2023 23:22:36 +0000 (UTC)
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id 7C69DCE23B2; Wed, 21 Jun 2023 16:22:36 -0700 (PDT)
Date: Wed, 21 Jun 2023 16:22:36 -0700
To: Olivier Dion <odion@efficios.com>
Message-ID: <bc031f8e-8380-4a1d-bfe2-9e8204e06283@paulmck-laptop>
References: <20230515201718.9809-1-odion@efficios.com>
 <20230515201718.9809-5-odion@efficios.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230515201718.9809-5-odion@efficios.com>
Subject: Re: [lttng-dev] [PATCH 04/11] urcu/arch/generic: Use atomic
 builtins if configured
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
From: "Paul E. McKenney via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: paulmck@kernel.org
Cc: lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Mon, May 15, 2023 at 04:17:11PM -0400, Olivier Dion wrote:
> If configured to use atomic builtins, implement SMP memory barriers in
> term of atomic builtins if the architecture does not implement its own
> version.
> 
> Change-Id: Iddc4283606e0fce572e104d2d3f03b5c0d9926fb
> Co-authored-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Olivier Dion <odion@efficios.com>
> ---
>  include/urcu/arch/generic.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/urcu/arch/generic.h b/include/urcu/arch/generic.h
> index be6e41e..e292c70 100644
> --- a/include/urcu/arch/generic.h
> +++ b/include/urcu/arch/generic.h
> @@ -43,6 +43,14 @@ extern "C" {
>   * GCC builtins) as well as cmm_rmb and cmm_wmb (defaulting to cmm_mb).
>   */
>  
> +#ifdef CONFIG_RCU_USE_ATOMIC_BUILTINS
> +
> +# ifndef cmm_smp_mb
> +#  define cmm_smp_mb() __atomic_thread_fence(__ATOMIC_SEQ_CST)
> +# endif
> +
> +#endif	/* CONFIG_RCU_USE_ATOMIC_BUILTINS */
> +
>  #ifndef cmm_mb
>  #define cmm_mb()    __sync_synchronize()

Just out of curiosity, why not also implement cmm_mb() in terms of
__atomic_thread_fence(__ATOMIC_SEQ_CST)?  (Or is that a later patch?)

							Thanx, Paul

>  #endif
> -- 
> 2.39.2
> 
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
