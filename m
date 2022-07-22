Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0BDC43334
	for <lttng-dev@archiver.kernel.org>; Fri, 22 Jul 2022 14:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1658501089;
	bh=KQXd9AzFHIqNfF9Lvapf1iQJCScSNKndQqTZruxN5d8=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=FIv+fUPNt5ubbmyzP+SBGAWXTYr94q8YHrJnTZt4fAo+XtU8L2qk6GLfzrxDgJX0I
	 FUWHamNDKN/DwDPnepnL2WSCxRSCDUZszVcDp8qd6OsvvsOybCaGFd7r300TJLXx4d
	 S+ddEE4XDvfCnU9wp6Th4Kr6krchTjp51Er1J0wqlwHozLbEQKrkPYyx5IgmVatZ5F
	 VS/B4hpDhiInf1p0bC4y7N1h9UCZPSSr8JjieApJ3BSeFjR8RGjnAaPbeXqQu+qgOC
	 dAl+b6Jqc31xBPaVq/5TYx/kMeU7emd2AQds2s3chjH7ur8kYoZEVvato0fyJrk8WJ
	 xQET5KtF/FXGg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LqBzh6qnKzRB8;
	Fri, 22 Jul 2022 10:44:48 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4LqBzf6mcjzQl6
 for <lttng-dev@lists.lttng.org>; Fri, 22 Jul 2022 10:44:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5A512430358
 for <lttng-dev@lists.lttng.org>; Fri, 22 Jul 2022 10:44:46 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id QntLsnnRXSi2; Fri, 22 Jul 2022 10:44:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A744C430537;
 Fri, 22 Jul 2022 10:44:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A744C430537
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id MgJhvhMKjfkU; Fri, 22 Jul 2022 10:44:45 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 9B788430536;
 Fri, 22 Jul 2022 10:44:45 -0400 (EDT)
Date: Fri, 22 Jul 2022 10:44:45 -0400 (EDT)
To: Norbert Lange <nolange79@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <439183197.78375.1658501085529.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220718214724.124127-1-nolange79@gmail.com>
References: <20220718214724.124127-1-nolange79@gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4304)
Thread-Topic: Improve tracef/tracelog to use the stack for small strings
Thread-Index: 4ouIpOG9VjDHwVRyWgBJ2/7pnURb5w==
Subject: Re: [lttng-dev] [PATCH] Improve tracef/tracelog to use the stack
 for small strings
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- On Jul 18, 2022, at 5:47 PM, Norbert Lange via lttng-dev lttng-dev@lists.lttng.org wrote:

> Support two common cases, one being that the resulting message is
> small enough to fit into a on-stack buffer.
> The seconds being the common 'printf("%s", "Message")' scheme.
> 
> Unfortunately, iterating a va_list is destructive,
> so it has to be copied before calling vprintf.
> 
> The implementation was moved to a separate file,
> used by both tracef.c and tracelog.c.

I agree with the overall approach. Some nits below,

> 
> Signed-off-by: Norbert Lange <nolange79@gmail.com>
> ---
> v2:
> -   move define into src/common/tracer.h
>    see https://lists.lttng.org/pipermail/lttng-dev/2021-May/029977.html
> -   moved macro magic into common tracelog-internal.h header
> -   rebased onto master
> ---
> src/common/tracer.h                   |  2 +
> src/lib/lttng-ust/tracef.c            | 32 +++--------
> src/lib/lttng-ust/tracelog-internal.h | 83 +++++++++++++++++++++++++++
> src/lib/lttng-ust/tracelog.c          | 40 +++----------
> 4 files changed, 102 insertions(+), 55 deletions(-)
> create mode 100644 src/lib/lttng-ust/tracelog-internal.h
> 
> diff --git a/src/common/tracer.h b/src/common/tracer.h
> index 2affd6ab..8e18c9b5 100644
> --- a/src/common/tracer.h
> +++ b/src/common/tracer.h
> @@ -26,6 +26,8 @@
> #define LTTNG_RFLAG_EXTENDED		RING_BUFFER_RFLAG_END
> #define LTTNG_RFLAG_END			(LTTNG_RFLAG_EXTENDED << 1)
> 
> +#define LTTNG_TRACE_PRINTF_BUFSIZE	512
> +
> /*
>  * LTTng client type enumeration. Used by the consumer to map the
>  * callbacks from its own address space.
> diff --git a/src/lib/lttng-ust/tracef.c b/src/lib/lttng-ust/tracef.c
> index c05c7811..92911e1d 100644
> --- a/src/lib/lttng-ust/tracef.c
> +++ b/src/lib/lttng-ust/tracef.c
> @@ -7,6 +7,7 @@
> #define _LGPL_SOURCE
> #include <stdio.h>
> #include "common/macros.h"
> +#include "common/tracer.h"
> 
> /* The tracepoint definition is public, but the provider definition is hidden.
> */
> #define LTTNG_UST_TRACEPOINT_PROVIDER_HIDDEN_DEFINITION
> @@ -15,39 +16,22 @@
> #define LTTNG_UST_TRACEPOINT_DEFINE
> #include "lttng-ust-tracef-provider.h"
> 
> -static inline
> -void lttng_ust___vtracef(const char *fmt, va_list ap)
> -	__attribute__((always_inline, format(printf, 1, 0)));
> -static inline
> -void lttng_ust___vtracef(const char *fmt, va_list ap)
> -{
> -	char *msg;
> -	const int len = vasprintf(&msg, fmt, ap);
> -
> -	/* len does not include the final \0 */
> -	if (len < 0)
> -		goto end;
> -	lttng_ust_tracepoint_cb_lttng_ust_tracef___event(msg, len,
> -		LTTNG_UST_CALLER_IP());
> -	free(msg);
> -end:
> -	return;
> -}
> +#include "tracelog-internal.h"
> 
> void lttng_ust__vtracef(const char *fmt, va_list ap)
> 	__attribute__((format(printf, 1, 0)));
> void lttng_ust__vtracef(const char *fmt, va_list ap)
> {
> -	lttng_ust___vtracef(fmt, ap);
> +	LTTNG_UST_TRACELOG_VALIST(fmt, ap,
> +		lttng_ust_tracepoint_cb_lttng_ust_tracef___event,
> +		msg, len, LTTNG_UST_CALLER_IP());
> }
> 
> void lttng_ust__tracef(const char *fmt, ...)
> 	__attribute__((format(printf, 1, 2)));
> void lttng_ust__tracef(const char *fmt, ...)
> {
> -	va_list ap;
> -
> -	va_start(ap, fmt);
> -	lttng_ust___vtracef(fmt, ap);
> -	va_end(ap);
> +	LTTNG_UST_TRACELOG_VARARG(fmt,
> +		lttng_ust_tracepoint_cb_lttng_ust_tracef___event,
> +		msg, len, LTTNG_UST_CALLER_IP());
> }
> diff --git a/src/lib/lttng-ust/tracelog-internal.h
> b/src/lib/lttng-ust/tracelog-internal.h
> new file mode 100644
> index 00000000..291ff27c
> --- /dev/null
> +++ b/src/lib/lttng-ust/tracelog-internal.h
> @@ -0,0 +1,83 @@
> +/*
> + * SPDX-License-Identifier: MIT
> + *
> + * Copyright (C) 2013-2014 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + * Copyright (C) 2021 Norbert Lange <nolange79@gmail.com>
> + *
> + * Shared helper macro for tracelog and tracef

Add "." at end of comment.

> + */
> +

As a coding style requirement, in case we ever use a macro in a conditional,
we always use the do { ... } while (0) wrapping to ensure we don't end up
with surprises with unexpected semicolons:

> +#define LTTNG_UST_TRACELOG_VARARG(fmt, callback, ...) \

do { \

> +	va_list ap; \
> +	char local_buf[LTTNG_TRACE_PRINTF_BUFSIZE]; \
> +	int len; \

int ret;
size_t len = 0;

> +	char *msg = local_buf; \
> +	size_t buflen = sizeof(local_buf); \
> +	char *alloc_buff = NULL; \
> +\
> +	if (caa_unlikely(fmt[0] == '%' && fmt[1] == 's' && fmt[2] == '\0')) { \
> +		va_start(ap, fmt); \
> +		msg = va_arg(ap, char *); \
> +		va_end(ap); \
> +		len = strlen(msg); \
> +	} else \
> +		for(;;) { \
> +			va_start(ap, fmt); \
> +			len = vsnprintf(msg, buflen, fmt, ap); \
> +			va_end(ap); \
> +\
> +			if (caa_unlikely(len >= (int)sizeof(local_buf) && !alloc_buff)) { \
> +				buflen = (size_t)len + 1U; \
> +				len = -1; \
> +				alloc_buff = (char *)malloc(buflen); \
> +				msg = alloc_buff; \
> +				if (!alloc_buff) \
> +					break; \
> +			} else \
> +				break; \
> +		} \

It's odd to have an infinite for (;;) loop for something that really has at
most two iterations, and never ever more: the first is an attempt with the
local buffer, and the second is using malloc'd memory. I would prefer that
we open-code the two iterations, even if it is a small repetition of code,
to make it crystal clear that we are not adding a never-ending loop in the
instrumentation code, even by mistake. I'd rather have, in the else leg:

		/* On-stack buffer attempt */
		va_start(ap, fmt);
		ret = vsnprintf(msg, buflen, fmt, ap);
		va_end(ap);
		if (caa_unlikely(ret < 0))
			goto end;
		len = ret;

		if (caa_unlikely(len >= sizeof(local_buf)) {
			/* On-heap buffer */
			buflen = len + 1;
			alloc_buff = (char *)malloc(buflen);
			if (!alloc_buff) {
				goto end;
			msg = alloc_buff;
			va_start(ap, fmt);
			ret = vsnprintf(msg, buflen, fmt, ap);
			va_end(ap);
			lttng_ust_runtime_bug_on(ret < 0 || (size_t)ret != buflen - 1);
			len = ret;
		}

> +\
> +	/* len does not include the final \0 */ \

This conditional goes away because len is a size_t. Breaking from the
while (0) is what skips over tracing and freeing the buffer.

> +	if (caa_likely(len >= 0)) { \
> +		callback(__VA_ARGS__); \
> +	} \
> +	/* Dont call a potentially instrumented forbidden free needlessly. */ \

Dont -> Don't

end:  (add end label to skip tracing but keep freeing the buffer. I prefer this
to a break of the while (0) to make sure we don't introduce memory leaks by
error in the future if the implementation is modified)

> +	if (caa_unlikely(alloc_buff)) \
> +		free(alloc_buff);

} while (0)

Same changes proposed above for the macro below.

Thanks,

Mathieu

> +
> +#define LTTNG_UST_TRACELOG_VALIST(fmt, ap, callback, ...) \
> +	char local_buf[LTTNG_TRACE_PRINTF_BUFSIZE]; \
> +	int len; \
> +	char *msg = local_buf; \
> +	size_t buflen = sizeof(local_buf); \
> +	char *alloc_buff = NULL; \
> +\
> +	if (caa_unlikely(fmt[0] == '%' && fmt[1] == 's' && fmt[2] == '\0')) { \
> +		msg = va_arg(ap, char *); \
> +		len = strlen(msg); \
> +	} else \
> +		for(;;) { \
> +			va_list ap2; \
> +\
> +			va_copy(ap2, ap); \
> +			len = vsnprintf(msg, buflen, fmt, ap2); \
> +			va_end(ap2); \
> +\
> +			if (caa_unlikely(len >= (int)sizeof(local_buf) && !alloc_buff)) { \
> +				buflen = (size_t)len + 1U; \
> +				len = -1; \
> +				alloc_buff = (char *)malloc(buflen); \
> +				msg = alloc_buff; \
> +				if (!alloc_buff) \
> +					break; \
> +			} else \
> +				break; \
> +		} \
> +\
> +	/* len does not include the final \0 */ \
> +	if (caa_likely(len >= 0)) { \
> +		callback(__VA_ARGS__); \
> +	} \
> +	/* Dont call a potentially instrumented forbidden free needlessly. */ \
> +	if (caa_unlikely(alloc_buff)) \
> +		free(alloc_buff);
> diff --git a/src/lib/lttng-ust/tracelog.c b/src/lib/lttng-ust/tracelog.c
> index 8147d7a3..bd38032c 100644
> --- a/src/lib/lttng-ust/tracelog.c
> +++ b/src/lib/lttng-ust/tracelog.c
> @@ -7,6 +7,7 @@
> #define _LGPL_SOURCE
> #include <stdio.h>
> #include "common/macros.h"
> +#include "common/tracer.h"
> 
> /* The tracepoint definition is public, but the provider definition is hidden.
> */
> #define LTTNG_UST_TRACEPOINT_PROVIDER_HIDDEN_DEFINITION
> @@ -15,32 +16,9 @@
> #define LTTNG_UST_TRACEPOINT_DEFINE
> #include "lttng-ust-tracelog-provider.h"
> 
> +#include "tracelog-internal.h"
> +
> #define LTTNG_UST_TRACELOG_CB(level) \
> -	static inline \
> -	void lttng_ust___vtracelog_##level(const char *file, \
> -			int line, const char *func, \
> -			const char *fmt, va_list ap) \
> -		__attribute__((always_inline, format(printf, 4, 0))); \
> -	\
> -	static inline \
> -	void lttng_ust___vtracelog_##level(const char *file, \
> -			int line, const char *func, \
> -			const char *fmt, va_list ap) \
> -	{ \
> -		char *msg; \
> -		const int len = vasprintf(&msg, fmt, ap); \
> -		\
> -		/* len does not include the final \0 */ \
> -		if (len < 0) \
> -			goto end; \
> -		lttng_ust_tracepoint_cb_lttng_ust_tracelog___##level(file, \
> -			line, func, msg, len, \
> -			LTTNG_UST_CALLER_IP()); \
> -		free(msg); \
> -	end: \
> -		return; \
> -	} \
> -	\
> 	void lttng_ust__vtracelog_##level(const char *file, \
> 			int line, const char *func, \
> 			const char *fmt, va_list ap) \
> @@ -53,7 +31,9 @@
> 			int line, const char *func, \
> 			const char *fmt, va_list ap) \
> 	{ \
> -		lttng_ust___vtracelog_##level(file, line, func, fmt, ap); \
> +		LTTNG_UST_TRACELOG_VALIST(fmt, ap, \
> +			lttng_ust_tracepoint_cb_lttng_ust_tracelog___##level, \
> +			file, line, func, msg, len, LTTNG_UST_CALLER_IP()); \
> 	} \
> 	\
> 	void lttng_ust__tracelog_##level(const char *file, \
> @@ -68,11 +48,9 @@
> 			int line, const char *func, \
> 			const char *fmt, ...) \
> 	{ \
> -		va_list ap; \
> -		\
> -		va_start(ap, fmt); \
> -		lttng_ust___vtracelog_##level(file, line, func, fmt, ap); \
> -		va_end(ap); \
> +		LTTNG_UST_TRACELOG_VARARG(fmt, \
> +			lttng_ust_tracepoint_cb_lttng_ust_tracelog___##level, \
> +			file, line, func, msg, len, LTTNG_UST_CALLER_IP()); \
> 	}
> 
> LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_EMERG)
> --
> 2.35.1
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
