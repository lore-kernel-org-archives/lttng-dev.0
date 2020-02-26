From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3 lttng-ust 1/2] Introduce vtracef
Date: Wed, 26 Feb 2020 16:14:07 -0500 (EST)
Message-ID: <670365633.9079.1582751647247.JavaMail.zimbra@efficios.com>
References: <20200224173455.15900-1-maxime.roussinbelanger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 48ST7g4KmhzyS1
 for <lttng-dev@lists.lttng.org>; Wed, 26 Feb 2020 16:14:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 7A41326FC82
 for <lttng-dev@lists.lttng.org>; Wed, 26 Feb 2020 16:14:07 -0500 (EST)
In-Reply-To: <20200224173455.15900-1-maxime.roussinbelanger@gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Feb 24, 2020, at 12:34 PM, Maxime Roussin-Belanger maxime.roussinbelanger@gmail.com wrote:
[...]
> diff --git a/liblttng-ust/tracef.c b/liblttng-ust/tracef.c
> index ea98e43e..1311f0d5 100644
> --- a/liblttng-ust/tracef.c
> +++ b/liblttng-ust/tracef.c
> @@ -29,20 +29,26 @@
> #define TRACEPOINT_DEFINE
> #include "lttng-ust-tracef-provider.h"
> 
> -void _lttng_ust_tracef(const char *fmt, ...)
> +void _lttng_ust_vtracef(const char *fmt, va_list ap)
> {
> -	va_list ap;
> 	char *msg;
> -	int len;
> -
> -	va_start(ap, fmt);
> -	len = vasprintf(&msg, fmt, ap);
> +	const int len = vasprintf(&msg, fmt, ap);
> 	/* len does not include the final \0 */
> 	if (len < 0)
> 		goto end;
> 	__tracepoint_cb_lttng_ust_tracef___event(msg, len,
> 		LTTNG_UST_CALLER_IP());

I don't think LTTNG_UST_CALLER_IP() has the behavior we would expect
for _lttng_ust_tracef() anymore here. We want the callsite in the application
or library which has been instrumented, not an IP within lttng-ust.

Thanks,

Mathieu

> 	free(msg);
> end:
> +	return;
> +}
> +
> +void _lttng_ust_tracef(const char *fmt, ...)
> +{
> +	va_list ap;
> +
> +	va_start(ap, fmt);
> +	_lttng_ust_vtracef(fmt, ap);
> +
> 	va_end(ap);
> }
> --
> 2.20.1
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
