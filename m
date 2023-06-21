Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20BDEB64D7
	for <lttng-dev@archiver.kernel.org>; Wed, 21 Jun 2023 23:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1687389841;
	bh=HZFUkS3UkRQTgiwFMHDziFHkYSOzvE9BBKx5ciE5pDs=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ffmSkarmBqjb77/Z6NnHoF1Ugnne1kn+5Ps8txaJ1re5wUCfhny1245myXzUcfVEX
	 WB4uqjwzNZRAi8YTr7Q7tpyRJvRIUiZiay/IB6OOuZ6rPX2LUyit5tDUjS2N7gyoD7
	 +SI8yiK2ZeUmp698JiNBYRRemfqwefLxGOs9WOiWyo30vZRqPnxO3aUQ6lPj08HQtH
	 90knwuvxX7xk572y69UrNsCI25IgxfvdOVpfZ0iLUkI7qJVxgmnzT9Yryt2HqqFK9N
	 CZmvaiY5f9QTl6opctmCJc67H+evKOChiE9TFleXiy3NhLlrE/CXk4i2oXS4ZVw5tT
	 cCXIhZ8P1Vz9w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Qmfhc48D0z203n;
	Wed, 21 Jun 2023 19:24:00 -0400 (EDT)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by lists.lttng.org (Postfix) with ESMTPS id 4Qmfhb5ptxz203l
 for <lttng-dev@lists.lttng.org>; Wed, 21 Jun 2023 19:23:59 -0400 (EDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3D359616F5;
 Wed, 21 Jun 2023 23:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F454C433C0;
 Wed, 21 Jun 2023 23:23:58 +0000 (UTC)
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
 id 52BBDCE23B2; Wed, 21 Jun 2023 16:23:58 -0700 (PDT)
Date: Wed, 21 Jun 2023 16:23:58 -0700
To: Olivier Dion <odion@efficios.com>
Message-ID: <81bdddb0-0a8e-4ce7-a40d-789bba0a74e2@paulmck-laptop>
References: <20230515201718.9809-1-odion@efficios.com>
 <20230607185359.8125-5-odion@efficios.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230607185359.8125-5-odion@efficios.com>
Subject: Re: [lttng-dev] [PATCH v2 04/12] urcu/system: Use atomic builtins
 if configured
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
Cc: Tony Finch <dot@dotat.at>, lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Wed, Jun 07, 2023 at 02:53:51PM -0400, Olivier Dion wrote:
> If configured to use atomic builtins, use them for implementing the
> CMM_LOAD_SHARED and CMM_STORE_SHARED macros.
> 
> Change-Id: I3eaaaaf0d26c47aced6e94b40fd59c7b8baa6272
> Co-authored-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Olivier Dion <odion@efficios.com>
> ---
>  include/urcu/system.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/include/urcu/system.h b/include/urcu/system.h
> index faae390..f184aad 100644
> --- a/include/urcu/system.h
> +++ b/include/urcu/system.h
> @@ -19,9 +19,28 @@
>   * all copies or substantial portions of the Software.
>   */
>  
> +#include <urcu/config.h>
>  #include <urcu/compiler.h>
>  #include <urcu/arch.h>
>  
> +#ifdef CONFIG_RCU_USE_ATOMIC_BUILTINS
> +
> +#define CMM_LOAD_SHARED(x)			\
> +	__atomic_load_n(&(x), __ATOMIC_RELAXED)
> +
> +#define _CMM_LOAD_SHARED(x) CMM_LOAD_SHARED(x)
> +
> +#define CMM_STORE_SHARED(x, v)					\
> +	__extension__						\
> +	({							\
> +		__typeof__(v) _v = (v);				\
> +		__atomic_store_n(&(x), _v, __ATOMIC_RELAXED);	\
> +		_v;						\
> +	})
> +
> +#define _CMM_STORE_SHARED(x, v) CMM_STORE_SHARED(x, v)

Same question here on loss of volatile semantics.

							Thanx, Paul

> +
> +#else
>  /*
>   * Identify a shared load. A cmm_smp_rmc() or cmm_smp_mc() should come
>   * before the load.
> @@ -56,4 +75,6 @@
>  		_v = _v;	/* Work around clang "unused result" */	\
>  	})
>  
> +#endif	/* CONFIG_RCU_USE_ATOMIC_BUILTINS */
> +
>  #endif /* _URCU_SYSTEM_H */
> -- 
> 2.40.1
> 
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
