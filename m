Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E588EC00144
	for <lttng-dev@archiver.kernel.org>; Mon,  1 Aug 2022 15:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1659366771;
	bh=QMmqs+frwl3Lb+/kueyjI/HAOknQ0Slb1wMREE4ssrQ=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=g1sJYwnu8cidzbWFVpmyTr472HpHcHtYshOxcbLcxIdl/gfYgD+nXXSc302wP0jEQ
	 J20Md8R920U/t+tvADbeH/1VrBQbC5fafDJdRE62BD0gwy1x+iXLE+YIrpwp0IN2Z5
	 Z/T1kOl1BzQ3Tt8vV99n++YqCyTeZB0q7VHhAiBKy3mBZsG2xKc3/p7jHK4W37qQpX
	 F+lPEA5B3WXNAxDKFWaHDbS4beDG8tZbXsRKFre4Ci6ywQ9e317vkcDpkzjFfNOgPw
	 84nk4DqWerxzZ1THAKUU7oqIZ4egrN7V8Kw5byzIxXo9ZZbxbIhj13V8FFkWT/8+qc
	 iJVgnl4zLXtzA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LxM7Q4Bghz11Cm;
	Mon,  1 Aug 2022 11:12:50 -0400 (EDT)
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4LxM7N3G6vz10r5
 for <lttng-dev@lists.lttng.org>; Mon,  1 Aug 2022 11:12:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 34443354DD4
 for <lttng-dev@lists.lttng.org>; Mon,  1 Aug 2022 11:12:48 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Bo5k94nV5mgF; Mon,  1 Aug 2022 11:12:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9A35E3554D9;
 Mon,  1 Aug 2022 11:12:47 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9A35E3554D9
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id MNnpBC08y_xo; Mon,  1 Aug 2022 11:12:47 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 90BD0354F6E;
 Mon,  1 Aug 2022 11:12:47 -0400 (EDT)
Date: Mon, 1 Aug 2022 11:12:47 -0400 (EDT)
To: Norbert Lange <nolange79@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <834354218.93583.1659366767571.JavaMail.zimbra@efficios.com>
In-Reply-To: <20220801143524.160208-1-norbert.lange@andritz.com>
References: <20220801143524.160208-1-norbert.lange@andritz.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100
 (Linux)/8.8.15_GA_4304)
Thread-Topic: Improve tracef/tracelog to use the stack for small strings
Thread-Index: YZFJTxZdY73V69qpZysyKq4buXZ2yg==
Subject: Re: [lttng-dev] [PATCH v2] Improve tracef/tracelog to use the stack
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

----- On Aug 1, 2022, at 10:35 AM, Norbert Lange via lttng-dev lttng-dev@lists.lttng.org wrote:

> From: Norbert Lange <nolange79@gmail.com>
> 
> Support two common cases, one being that the resulting message is
> small enough to fit into a on-stack buffer.
> The seconds being the common 'printf("%s", "Message")' scheme.
> 
> Unfortunately, iterating a va_list is destructive,
> so it has to be copied before calling vprintf.
> 
> The implementation was moved to a separate file,
> used by both tracef.c and tracelog.c.
> 
> Signed-off-by: Norbert Lange <nolange79@gmail.com>

Merged, thanks!

Mathieu

> ---
> v2 -> v3:
> 
> *   Wrap macro in do/while
> *   drop loop
> *   other changes in response to feedback
> 
> v2:
> -   move define into src/common/tracer.h
>    see https://lists.lttng.org/pipermail/lttng-dev/2021-May/029977.html
> -   moved macro magic into common tracelog-internal.h header
> -   rebased onto master
> ---
> src/common/tracer.h                   |  2 +
> src/lib/lttng-ust/tracef.c            | 32 +++------
> src/lib/lttng-ust/tracelog-internal.h | 95 +++++++++++++++++++++++++++
> src/lib/lttng-ust/tracelog.c          | 40 +++--------
> 4 files changed, 114 insertions(+), 55 deletions(-)
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
> index 00000000..34537023
> --- /dev/null
> +++ b/src/lib/lttng-ust/tracelog-internal.h
> @@ -0,0 +1,95 @@
> +/*
> + * SPDX-License-Identifier: MIT
> + *
> + * Copyright (C) 2013-2014 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + * Copyright (C) 2021 Norbert Lange <nolange79@gmail.com>
> + *
> + * Shared helper macro for tracelog and tracef.
> + */
> +
> +#define LTTNG_UST_TRACELOG_VARARG(fmt, callback, ...) \
> +	do { \
> +		va_list ap; \
> +		char local_buf[LTTNG_TRACE_PRINTF_BUFSIZE]; \
> +		size_t len = 0; \
> +		char *msg = local_buf; \
> +		char *alloc_buff = NULL; \
> +\
> +		if (caa_unlikely(fmt[0] == '%' && fmt[1] == 's' && fmt[2] == '\0')) { \
> +			va_start(ap, fmt); \
> +			msg = va_arg(ap, char *); \
> +			va_end(ap); \
> +			len = strlen(msg); \
> +		} else { \
> +			int ret; \
> +			size_t buflen = sizeof(local_buf); \
> +\
> +			/* On-stack buffer attempt */ \
> +			va_start(ap, fmt); \
> +			ret = vsnprintf(msg, buflen, fmt, ap); \
> +			va_end(ap); \
> +			if (caa_unlikely(ret < 0)) \
> +				break; \
> +			len = (size_t)ret; \
> +\
> +			if (caa_unlikely(len >= sizeof(local_buf))) { \
> +				buflen = len + 1; \
> +				alloc_buff = (char *)malloc(buflen); \
> +				if (!alloc_buff) \
> +					goto end; \
> +				msg = alloc_buff; \
> +				va_start(ap, fmt); \
> +				ret = vsnprintf(msg, buflen, fmt, ap); \
> +				va_end(ap); \
> +				lttng_ust_runtime_bug_on(ret < 0 || (size_t)ret != buflen - 1); \
> +				len = (size_t)ret; \
> +			} \
> +		} \
> +\
> +		callback(__VA_ARGS__); \
> +end: \
> +		/* Don't call a potentially instrumented forbidden free needlessly. */ \
> +		if (caa_unlikely(alloc_buff)) \
> +			free(alloc_buff); \
> +	} while(0)
> +
> +#define LTTNG_UST_TRACELOG_VALIST(fmt, ap, callback, ...) \
> +	do { \
> +		char local_buf[LTTNG_TRACE_PRINTF_BUFSIZE]; \
> +		size_t len = 0; \
> +		char *msg = local_buf; \
> +		char *alloc_buff = NULL; \
> +\
> +		if (caa_unlikely(fmt[0] == '%' && fmt[1] == 's' && fmt[2] == '\0')) { \
> +			msg = va_arg(ap, char *); \
> +			len = strlen(msg); \
> +		} else { \
> +			va_list ap2; \
> +			int ret; \
> +			size_t buflen = sizeof(local_buf); \
> +\
> +			va_copy(ap2, ap); \
> +			ret = vsnprintf(msg, buflen, fmt, ap2); \
> +			va_end(ap2); \
> +			if (caa_unlikely(ret < 0)) \
> +				break; \
> +			len = (size_t)ret; \
> +\
> +			if (caa_unlikely(len >= sizeof(local_buf))) { \
> +				buflen = len + 1; \
> +				alloc_buff = (char *)malloc(buflen); \
> +				if (!alloc_buff) \
> +					goto end; \
> +				msg = alloc_buff; \
> +				ret = vsnprintf(msg, buflen, fmt, ap); \
> +				lttng_ust_runtime_bug_on(ret < 0 || (size_t)ret != buflen - 1); \
> +				len = (size_t)ret; \
> +			} \
> +		} \
> +\
> +		callback(__VA_ARGS__); \
> +end: \
> +		/* Don't call a potentially instrumented forbidden free needlessly. */ \
> +		if (caa_unlikely(alloc_buff)) \
> +			free(alloc_buff); \
> +	} while (0)
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
