From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Fix: measure UST clock offset with a median
	of samples
Date: Mon, 27 Jan 2014 18:58:13 +0000 (UTC)
Message-ID: <340239160.13583.1390849093909.JavaMail.zimbra__31677.7688953609$1390849165$gmane$org@efficios.com>
References: <1390844872-25095-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1W7rNy-00029n-NH
	for lttng-dev@lists.lttng.org; Mon, 27 Jan 2014 13:58:24 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 939053401B7
	for <lttng-dev@lists.lttng.org>; Mon, 27 Jan 2014 18:58:16 +0000 (UTC)
In-Reply-To: <1390844872-25095-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Please disregard this patch, I'm preparing a new one that will use the
min time delta between the 2 trace clock reads to find the best correlation.

----- Original Message -----
> From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> To: dgoulet@efficios.com
> Cc: lttng-dev@lists.lttng.org, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Sent: Monday, January 27, 2014 12:47:52 PM
> Subject: [PATCH] Fix: measure UST clock offset with a median of samples
> 
> Fixes #729
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  src/bin/lttng-sessiond/ust-metadata.c |   52
>  +++++++++++++++++++++++++++------
>  1 file changed, 43 insertions(+), 9 deletions(-)
> 
> diff --git a/src/bin/lttng-sessiond/ust-metadata.c
> b/src/bin/lttng-sessiond/ust-metadata.c
> index b0f83d2..f511253 100644
> --- a/src/bin/lttng-sessiond/ust-metadata.c
> +++ b/src/bin/lttng-sessiond/ust-metadata.c
> @@ -24,6 +24,7 @@
>  #include <string.h>
>  #include <stdarg.h>
>  #include <stdio.h>
> +#include <stdlib.h>
>  #include <limits.h>
>  #include <unistd.h>
>  #include <inttypes.h>
> @@ -37,6 +38,8 @@
>  #define max_t(type, a, b)	((type) ((a) > (b) ? (a) : (b)))
>  #endif
>  
> +#define NR_CLOCK_OFFSET_SAMPLES		20
> +
>  static inline
>  int fls(unsigned int x)
>  {
> @@ -490,14 +493,21 @@ int _lttng_event_header_declare(struct
> ust_registry_session *session)
>  	);
>  }
>  
> -/*
> - * Approximation of NTP time of day to clock monotonic correlation,
> - * taken at start of trace.
> - * Yes, this is only an approximation. Yes, we can (and will) do better
> - * in future versions.
> - */
>  static
> -uint64_t measure_clock_offset(void)
> +int sort_uint64(const void *_a, const void *_b)
> +{
> +	const uint64_t *a = _a, *b = _b;
> +
> +	if (a < b)
> +		return -1;
> +	else if (a > b)
> +		return 1;
> +	else
> +		return 0;
> +}
> +
> +static
> +int measure_single_clock_offset(uint64_t *offset_sample)
>  {
>  	uint64_t offset, monotonic[2], realtime;
>  	struct timespec rts = { 0, 0 };
> @@ -506,15 +516,39 @@ uint64_t measure_clock_offset(void)
>  	monotonic[0] = trace_clock_read64();
>  	ret = clock_gettime(CLOCK_REALTIME, &rts);
>  	if (ret < 0)
> -		return 0;
> +		return ret;
>  	monotonic[1] = trace_clock_read64();
>  	offset = (monotonic[0] + monotonic[1]) >> 1;
>  	realtime = (uint64_t) rts.tv_sec * 1000000000ULL;
>  	realtime += rts.tv_nsec;
>  	offset = realtime - offset;
> -	return offset;
> +	*offset_sample = offset;
> +	return 0;
>  }
>  
> +/*
> + * Approximation of NTP time of day to clock monotonic correlation,
> + * taken at start of trace.
> + * Take the median of many measurements to remove uncertainty caused by
> + * preemption.
> + */
> +static
> +uint64_t measure_clock_offset(void)
> +{
> +	uint64_t offset_samples[NR_CLOCK_OFFSET_SAMPLES];
> +	int i;
> +
> +	for (i = 0; i < NR_CLOCK_OFFSET_SAMPLES; i++) {
> +		if (measure_single_clock_offset(&offset_samples[i])) {
> +			return 0;
> +		}
> +	}
> +
> +	/* Find median (using qsort() which is already implemented) */
> +	qsort(offset_samples, NR_CLOCK_OFFSET_SAMPLES,
> +		sizeof(*offset_samples), sort_uint64);
> +	return offset_samples[NR_CLOCK_OFFSET_SAMPLES >> 1];
> +}
>  
>  /*
>   * Should be called with session registry mutex held.
> --
> 1.7.10.4
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
