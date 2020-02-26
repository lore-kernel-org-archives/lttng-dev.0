From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3 lttng-ust 2/2] Introduce vtracelog
Date: Wed, 26 Feb 2020 16:15:37 -0500 (EST)
Message-ID: <1936531617.9105.1582751737662.JavaMail.zimbra@efficios.com>
References: <20200224173455.15900-1-maxime.roussinbelanger@gmail.com>
 <20200224173455.15900-2-maxime.roussinbelanger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 48ST9P6cdpz107F
 for <lttng-dev@lists.lttng.org>; Wed, 26 Feb 2020 16:15:37 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id DE72B26FD81
 for <lttng-dev@lists.lttng.org>; Wed, 26 Feb 2020 16:15:37 -0500 (EST)
In-Reply-To: <20200224173455.15900-2-maxime.roussinbelanger@gmail.com>
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

> +int main(int argc, char **argv)
> +{
> +	int i;
> +	int delay = 0;
> +
> +	if (argc == 2)

Check for argc > 2 as well here.

[...]

> diff --git a/liblttng-ust/tracelog.c b/liblttng-ust/tracelog.c
> index 65fc87ed..17546605 100644
> --- a/liblttng-ust/tracelog.c
> +++ b/liblttng-ust/tracelog.c
> @@ -29,27 +29,35 @@
> #define TRACEPOINT_DEFINE
> #include "lttng-ust-tracelog-provider.h"
> 
> +
> #define TRACELOG_CB(level) \
> -	void _lttng_ust_tracelog_##level(const char *file, \
> +	void _lttng_ust_vtracelog_##level(const char *file, \
> 			int line, const char *func, \
> -			const char *fmt, ...) \
> +			const char *fmt, va_list ap) \
> 	{ \
> -		va_list ap; \
> -		char *msg; \
> -		int len; \
> + 		char *msg; \
> +		const int len = vasprintf(&msg, fmt, ap); \
> 		\
> -		va_start(ap, fmt); \
> -		len = vasprintf(&msg, fmt, ap); \
> 		/* len does not include the final \0 */ \
> 		if (len < 0) \
> 			goto end; \
> 		__tracepoint_cb_lttng_ust_tracelog___##level(file, \
> 			line, func, msg, len, \
> 			LTTNG_UST_CALLER_IP()); \

Same as tracef: LTTNG_UST_CALLER_IP() does not have the expected behavior
for _lttng_ust_tracelog_##level anymore. And I would want to ensure we don't
add an additional call indirection in the generated text.

> 		free(msg); \
> 	end: \
> +		return; \
> +	} \
> +	\
> +	void _lttng_ust_tracelog_##level(const char *file, \
> +			int line, const char *func, \
> +			const char *fmt, ...) \
> +	{ \
> +		va_list ap; \
> +		va_start(ap, fmt); \
> +		_lttng_ust_vtracelog_##level(file, line, func, fmt, ap); \
> 		va_end(ap); \
> -	}
> +	} \

I suspect you will want to remove the "\" on the last line here.

Thanks,

Mathieu

> 
> TRACELOG_CB(TRACE_EMERG)
> TRACELOG_CB(TRACE_ALERT)
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
