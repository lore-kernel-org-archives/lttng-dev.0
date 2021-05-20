Return-Path: <SRS0=dYoO=KP=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A140CC433B4
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 14:19:23 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18E43610A8
	for <lttng-dev@archiver.kernel.org>; Thu, 20 May 2021 14:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E43610A8
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FmBgs5xwDz1rRq;
	Thu, 20 May 2021 10:19:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621520362;
	bh=YmzTdDSjM2u74IcgqurombXTO0OtOGL567j1XrpGOiw=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=aIoHeoF6WwZhOJupI9T51j6BQC0EJuDOOz9h90+BZGF6YUAZkNdJMtwXzbKW3lH62
	 S25y1CbaODPrzZg6N2F8ah5OUKJoRuhiHAPW5MVDAqeDmkwNHOCqsjjPTepUQLjLvt
	 2YKmDHfhe/ecwvFMAx8trJpM7WUk6PuZKy5Uey3Z+BY4UUC3xmqv/9/9JNvh+MY8Cp
	 Oj1q2lK2IMuVGWxovQl0tZGJG7AJSg0n6U0chl/Eyr1OFYU1fR53gB63oiUxF8bzCl
	 WS7gBwZqqlwgy/oxhg7WZ0pRswGr1YEThXWnfvnrn5iFTaRV5riXkUZjx3tINwt2R5
	 xYOk8egGfY7qw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4FmBgq6mc2z1rrR
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 10:19:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A12AD335D57
 for <lttng-dev@lists.lttng.org>; Thu, 20 May 2021 10:19:13 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 11Vj7u7w9Uhw; Thu, 20 May 2021 10:19:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 12256335D55;
 Thu, 20 May 2021 10:19:13 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 12256335D55
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 9elMuluS1Jww; Thu, 20 May 2021 10:19:13 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 06638336053;
 Thu, 20 May 2021 10:19:13 -0400 (EDT)
Date: Thu, 20 May 2021 10:19:12 -0400 (EDT)
To: Norbert Lange <nolange79@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1600729511.52338.1621520352970.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210520121807.55428-1-nolange79@gmail.com>
References: <20210520121807.55428-1-nolange79@gmail.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4007)
Thread-Topic: Improve tracelog handling, reduce exported functions
Thread-Index: 95s96LKVRCKfehbKM7OcjWxVc88aTQ==
Subject: Re: [lttng-dev] [PATCH lttng-ust] Improve tracelog handling,
 reduce exported functions
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
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

----- On May 20, 2021, at 8:18 AM, lttng-dev lttng-dev@lists.lttng.org wrote:

> Instead of creating functions for each loglevel, simply pass the
> callback as argument.
> 
> Further pack all preprocessor information into a struct that
> the compiler already can prepare.

This introduces an ABI break too late in the cycle.

Also, I'm not so keen on adding an indirect call on the fast-path
when it's not absolutely needed.

What is wrong with having one symbol per loglevel ?

Thanks,

Mathieu

> 
> Signed-off-by: Norbert Lange <nolange79@gmail.com>
> ---
> include/lttng/tracelog.h     |  49 +++++--------
> src/lib/lttng-ust/tracelog.c | 130 +++++++++++++++--------------------
> 2 files changed, 75 insertions(+), 104 deletions(-)
> 
> diff --git a/include/lttng/tracelog.h b/include/lttng/tracelog.h
> index e97c8275..cd5032e3 100644
> --- a/include/lttng/tracelog.h
> +++ b/include/lttng/tracelog.h
> @@ -14,51 +14,40 @@
> extern "C" {
> #endif
> 
> -#define LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(level)					\
> -	extern void lttng_ust__tracelog_##level(const char *file,	\
> -		int line, const char *func, const char *fmt, ...)	\
> -		__attribute__ ((format(printf, 4, 5)));			\
> -									\
> -	extern void lttng_ust__vtracelog_##level(const char *file,	\
> -		int line, const char *func, const char *fmt,		\
> -		va_list ap)						\
> -		__attribute__ ((format(printf, 4, 0)));
> -
> -LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_EMERG);
> -LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_ALERT);
> -LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_CRIT);
> -LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_ERR);
> -LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_WARNING);
> -LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_NOTICE);
> -LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_INFO);
> -LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_SYSTEM);
> -LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_PROGRAM);
> -LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_PROCESS);
> -LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_MODULE);
> -LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_UNIT);
> -LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_FUNCTION);
> -LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_LINE);
> -LTTNG_UST_TP_TRACELOG_CB_TEMPLATE(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG);
> -
> -#undef LTTNG_UST_TP_TRACELOG_CB_TEMPLATE
> +struct lttng_ust__tracelog_sourceinfo {
> +	const char *file;
> +	const char *func;
> +	int line;
> +};
> +
> +extern void lttng_ust__tracelog_printf(
> +
> 	__typeof__(lttng_ust_tracepoint_cb_lttng_ust_tracelog___LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG)
> *callback,
> +	const struct lttng_ust__tracelog_sourceinfo *source, const char *fmt, ...)
> +	__attribute__ ((format(printf, 3, 4)));
> +
> +extern void lttng_ust__tracelog_vprintf(
> +
> 	__typeof__(lttng_ust_tracepoint_cb_lttng_ust_tracelog___LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG)
> *callback,
> +	const struct lttng_ust__tracelog_sourceinfo *source, const char *fmt, va_list
> ap)
> +	__attribute__ ((format(printf, 3, 0)));
> 
> #define lttng_ust_tracelog(level, fmt, ...)					\
> 	do {								\
> +		static const struct lttng_ust__tracelog_sourceinfo src = { __FILE__,
> __func__, __LINE__ }; \
> 		LTTNG_UST_STAP_PROBEV(tracepoint_lttng_ust_tracelog, level, ## __VA_ARGS__); \
> 		if (caa_unlikely(lttng_ust_tracepoint_lttng_ust_tracelog___##level.state)) \
> -			lttng_ust__tracelog_##level(__FILE__, __LINE__, __func__, \
> +
> 			lttng_ust__tracelog_printf(&lttng_ust_tracepoint_cb_lttng_ust_tracelog___##level,
> &src, \
> 				fmt, ## __VA_ARGS__);			\
> 	} while (0)
> 
> #define lttng_ust_vtracelog(level, fmt, ap)					\
> 	do {								\
> +		static const struct lttng_ust__tracelog_sourceinfo src = { __FILE__,
> __func__, __LINE__ }; \
> 		if (caa_unlikely(lttng_ust_tracepoint_lttng_ust_tracelog___##level.state)) \
> -			lttng_ust__vtracelog_##level(__FILE__, __LINE__, __func__, \
> +
> 			lttng_ust__tracelog_vprintf(&lttng_ust_tracepoint_cb_lttng_ust_tracelog___##level,
> &src, \
> 				fmt, ap);				\
> 	} while (0)
> 
> #if LTTNG_UST_COMPAT_API(0)
> -#define TP_TRACELOG_CB_TEMPLATE LTTNG_UST_TP_TRACELOG_CB_TEMPLATE
> #define tracelog	lttng_ust_tracelog
> #define vtracelog	lttng_ust_vtracelog
> #endif
> diff --git a/src/lib/lttng-ust/tracelog.c b/src/lib/lttng-ust/tracelog.c
> index 8147d7a3..b28c6c78 100644
> --- a/src/lib/lttng-ust/tracelog.c
> +++ b/src/lib/lttng-ust/tracelog.c
> @@ -15,78 +15,60 @@
> #define LTTNG_UST_TRACEPOINT_DEFINE
> #include "lttng-ust-tracelog-provider.h"
> 
> -#define LTTNG_UST_TRACELOG_CB(level) \
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
> -	void lttng_ust__vtracelog_##level(const char *file, \
> -			int line, const char *func, \
> -			const char *fmt, va_list ap) \
> -		__attribute__ ((format(printf, 4, 0))); \
> -	\
> -	void lttng_ust__vtracelog_##level(const char *file, \
> -			int line, const char *func, \
> -			const char *fmt, va_list ap); \
> -	void lttng_ust__vtracelog_##level(const char *file, \
> -			int line, const char *func, \
> -			const char *fmt, va_list ap) \
> -	{ \
> -		lttng_ust___vtracelog_##level(file, line, func, fmt, ap); \
> -	} \
> -	\
> -	void lttng_ust__tracelog_##level(const char *file, \
> -			int line, const char *func, \
> -			const char *fmt, ...) \
> -		__attribute__ ((format(printf, 4, 5))); \
> -	\
> -	void lttng_ust__tracelog_##level(const char *file, \
> -			int line, const char *func, \
> -			const char *fmt, ...); \
> -	void lttng_ust__tracelog_##level(const char *file, \
> -			int line, const char *func, \
> -			const char *fmt, ...) \
> -	{ \
> -		va_list ap; \
> -		\
> -		va_start(ap, fmt); \
> -		lttng_ust___vtracelog_##level(file, line, func, fmt, ap); \
> -		va_end(ap); \
> -	}
> +struct lttng_ust__tracelog_sourceinfo {
> +	const char *file;
> +	const char *func;
> +	int line;
> +};
> 
> -LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_EMERG)
> -LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_ALERT)
> -LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_CRIT)
> -LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_ERR)
> -LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_WARNING)
> -LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_NOTICE)
> -LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_INFO)
> -LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_SYSTEM)
> -LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_PROGRAM)
> -LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_PROCESS)
> -LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_MODULE)
> -LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_UNIT)
> -LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_FUNCTION)
> -LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG_LINE)
> -LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG)
> +typedef
> __typeof__(lttng_ust_tracepoint_cb_lttng_ust_tracelog___LTTNG_UST_TRACEPOINT_LOGLEVEL_DEBUG)
> tpcallback_t;
> +
> +extern void lttng_ust__tracelog_printf(tpcallback_t *callback,
> +	const struct lttng_ust__tracelog_sourceinfo *source, const char *fmt, ...)
> +	__attribute__ ((format(printf, 3, 4)));
> +
> +extern void lttng_ust__tracelog_vprintf(tpcallback_t *callback,
> +	const struct lttng_ust__tracelog_sourceinfo *source, const char *fmt, va_list
> ap)
> +	__attribute__ ((format(printf, 3, 0)));
> +
> +static inline
> +void lttng_ust___tracelog_vprintf(tpcallback_t *callback,
> +	const struct lttng_ust__tracelog_sourceinfo *source,
> +	const char *fmt, va_list ap)
> +	__attribute__((always_inline, format(printf, 3, 0)));
> +
> +
> +static inline
> +void lttng_ust___tracelog_vprintf(tpcallback_t *callback,
> +	const struct lttng_ust__tracelog_sourceinfo *source,
> +	const char *fmt, va_list ap)
> +{
> +	char *msg;
> +	const int len = vasprintf(&msg, fmt, ap);
> +
> +	/* len does not include the final \0 */
> +	if (len >= 0)
> +		goto end;
> +	(*callback)(source->file, source->line, source->func, msg, len,
> +		LTTNG_UST_CALLER_IP());
> +	free(msg);
> +end:
> +	return;
> +}
> +
> +
> +void lttng_ust__tracelog_printf(tpcallback_t *callback,
> +	const struct lttng_ust__tracelog_sourceinfo *source, const char *fmt, ...)
> +{
> +	va_list ap;
> +
> +	va_start(ap, fmt);
> +	lttng_ust___tracelog_vprintf(callback, source, fmt, ap);
> +	va_end(ap);
> +}
> +
> +void lttng_ust__tracelog_vprintf(tpcallback_t *callback,
> +	const struct lttng_ust__tracelog_sourceinfo *source, const char *fmt, va_list
> ap)
> +{
> +	lttng_ust___tracelog_vprintf(callback, source, fmt, ap);
> +}
> --
> 2.30.2
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
