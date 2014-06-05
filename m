From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] lttng-ust-tracef-provider.h: fix typo
Date: Thu, 5 Jun 2014 17:14:43 +0000 (UTC)
Message-ID: <1165479753.27264.1401988483888.JavaMail.zimbra__40991.363375406$1401988546$gmane$org@efficios.com>
References: <1401782518-32510-1-git-send-email-gerlando.falauto@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WsbFW-0002We-Ib
 for lttng-dev@lists.lttng.org; Thu, 05 Jun 2014 13:14:51 -0400
In-Reply-To: <1401782518-32510-1-git-send-email-gerlando.falauto@keymile.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Gerlando Falauto <gerlando.falauto@keymile.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged, thanks!

Mathieu

----- Original Message -----
> From: "Gerlando Falauto" <gerlando.falauto@keymile.com>
> To: lttng-dev@lists.lttng.org
> Cc: "Gerlando Falauto" <gerlando.falauto@keymile.com>
> Sent: Tuesday, June 3, 2014 4:01:58 AM
> Subject: [lttng-dev] [PATCH] lttng-ust-tracef-provider.h: fix typo
> 
> Fix typo potentially allowing for multiple inclusions.
> 
> Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
> ---
>  liblttng-ust/lttng-ust-tracef-provider.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/liblttng-ust/lttng-ust-tracef-provider.h
> b/liblttng-ust/lttng-ust-tracef-provider.h
> index b759191..1e32888 100644
> --- a/liblttng-ust/lttng-ust-tracef-provider.h
> +++ b/liblttng-ust/lttng-ust-tracef-provider.h
> @@ -2,7 +2,7 @@
>  #define TRACEPOINT_PROVIDER lttng_ust_tracef
>  
>  #if !defined(_TRACEPOINT_LTTNG_UST_TRACEF_PROVIDER_H) ||
>  defined(TRACEPOINT_HEADER_MULTI_READ)
> -#define _TRACEPOINT_LTTNG_UST_TRACEF_PROVIER_H
> +#define _TRACEPOINT_LTTNG_UST_TRACEF_PROVIDER_H
>  
>  /*
>   * Copyright (C) 2011-2014  Mathieu Desnoyers
>   <mathieu.desnoyers@efficios.com>
> --
> 1.8.0.1
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
