From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust RFC] tracef: move
 _lttng_ust_tracef()	definition to tracef.h
Date: Thu, 5 Jun 2014 17:21:30 +0000 (UTC)
Message-ID: <931085984.27276.1401988890434.JavaMail.zimbra__39926.2726925828$1401988937$gmane$org@efficios.com>
References: <1401782635-32638-1-git-send-email-gerlando.falauto@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WsbM6-0002aP-VJ
 for lttng-dev@lists.lttng.org; Thu, 05 Jun 2014 13:21:36 -0400
In-Reply-To: <1401782635-32638-1-git-send-email-gerlando.falauto@keymile.com>
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

The idea is good, but a few comments:

- there is a newline at the end of tracef.c that should be removed,
- we need to add includes for headers that tracef.h now requires,
- I don't know how to handle the fact that tracef.h would now require
  a #define _GNU_SOURCE. Usually we don't do those define within header
  files. (see man vasprintf),
- we'd have to remove unneeded includes and defines from tracef.c.

Thoughts ?

Thanks,

Mathieu

----- Original Message -----
> From: "Gerlando Falauto" <gerlando.falauto@keymile.com>
> To: lttng-dev@lists.lttng.org
> Cc: "Gerlando Falauto" <gerlando.falauto@keymile.com>
> Sent: Tuesday, June 3, 2014 4:03:55 AM
> Subject: [lttng-dev] [PATCH lttng-ust RFC] tracef: move _lttng_ust_tracef()	definition to tracef.h
> 
> With the current implementation, in order to use tracef() within your
> application, you have to link it against liblttng-ust, because
> _lttng_ust_tracef() is part of it.
> 
> So move _lttng_ust_tracef() to the header file in order to drop this
> static awareness, allowing the application to be compiled with
> -DTRACEPOINT_DEFINE and -DTRACEPOINT_PROBE_DYNAMIC_LINKAGE
> without any static dependency to liblttng-ust.so
> (you will need to LD_PRELOAD it in order for tracing to work though).
> 
> Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
> ---
>  include/lttng/tracef.h | 18 ++++++++++++++++--
>  liblttng-ust/tracef.c  | 16 ----------------
>  2 files changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/include/lttng/tracef.h b/include/lttng/tracef.h
> index 7e8b59e..612c56a 100644
> --- a/include/lttng/tracef.h
> +++ b/include/lttng/tracef.h
> @@ -29,8 +29,22 @@
>  extern "C" {
>  #endif
>  
> -extern
> -void _lttng_ust_tracef(const char *fmt, ...);
> +static inline void _lttng_ust_tracef(const char *fmt, ...)
> +{
> +	va_list ap;
> +	char *msg;
> +	int len;
> +
> +	va_start(ap, fmt);
> +	len = vasprintf(&msg, fmt, ap);
> +	/* len does not include the final \0 */
> +	if (len < 0)
> +		goto end;
> +	__tracepoint_cb_lttng_ust_tracef___event(msg, len);
> +	free(msg);
> +end:
> +	va_end(ap);
> +}
>  
>  #define tracef(fmt, ...)						\
>  	do {								\
> diff --git a/liblttng-ust/tracef.c b/liblttng-ust/tracef.c
> index 9ef063c..0c7ab17 100644
> --- a/liblttng-ust/tracef.c
> +++ b/liblttng-ust/tracef.c
> @@ -28,19 +28,3 @@
>  #define TRACEPOINT_DEFINE
>  #include "lttng-ust-tracef-provider.h"
>  
> -void _lttng_ust_tracef(const char *fmt, ...)
> -{
> -	va_list ap;
> -	char *msg;
> -	int len;
> -
> -	va_start(ap, fmt);
> -	len = vasprintf(&msg, fmt, ap);
> -	/* len does not include the final \0 */
> -	if (len < 0)
> -		goto end;
> -	__tracepoint_cb_lttng_ust_tracef___event(msg, len);
> -	free(msg);
> -end:
> -	va_end(ap);
> -}
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
