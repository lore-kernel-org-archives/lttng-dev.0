From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2] Fix: Connect timeout
 arithmetic in inet/inet6 (v2)
Date: Fri, 9 Nov 2018 18:43:06 -0500
Message-ID: <20181109234306.GC27438__41053.5149429508$1541806872$gmane$org@joraj-alpa>
References: <20181109224047.18750-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 42sGtN5zTwzqmt
 for <lttng-dev@lists.lttng.org>; Fri,  9 Nov 2018 18:43:08 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20181109224047.18750-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org


> diff --git a/src/common/utils.c b/src/common/utils.c
> index 3442bef8..5b4e1d3c 100644
> --- a/src/common/utils.c
> +++ b/src/common/utils.c
> @@ -31,6 +31,7 @@
>  #include <pwd.h>
>  #include <sys/file.h>
>  #include <unistd.h>
> +#include <stdint.h>
>  
>  #include <common/common.h>
>  #include <common/runas.h>
> @@ -41,6 +42,7 @@
>  
>  #include "utils.h"
>  #include "defaults.h"
> +#include "time.h"
>  
>  /*
>   * Return a partial realpath(3) of the path even if the full path does not
> @@ -1645,3 +1647,32 @@ int utils_show_help(int section, const char *page_name,
>  end:
>  	return ret;
>  }
> +
> +LTTNG_HIDDEN
> +int timespec_to_ms(struct timespec ts, unsigned long *ms)
> +{
> +	unsigned long res;
> +
> +	if (ts.tv_sec + 1 > ULONG_MAX / MSEC_PER_SEC) {
> +		return -1;
> +	}

This is not accurate. It return -1 for the all the following valid timespec:

   tv_sec = 4294967
   0 < tv_nsec < 295000000

You will need to check multiplication and addition separately.

> +	res = ts.tv_sec * MSEC_PER_SEC;
> +	res += ts.tv_nsec / NSEC_PER_MSEC;
> +	*ms = res;
> +	return 0;
> +}
> +
> +LTTNG_HIDDEN
> +struct timespec timespec_abs_diff(struct timespec t1, struct timespec t2)
> +{
> +	uint64_t ts1 = (uint64_t) t1.tv_sec * (uint64_t) NSEC_PER_SEC +
> +			(uint64_t) t1.tv_nsec;
> +	uint64_t ts2 = (uint64_t) t2.tv_sec * (uint64_t) NSEC_PER_SEC +
> +			(uint64_t) t2.tv_nsec;
> +	uint64_t diff = max(ts1, ts2) - min(ts1, ts2);
> +	struct timespec res;
> +
> +	res.tv_sec = diff / (uint64_t) NSEC_PER_SEC;
> +	res.tv_nsec = diff % (uint64_t) NSEC_PER_SEC;
> +	return res;
> +}
> -- 
> 2.11.0
> 

-- 
Jonathan Rajotte-Julien
EfficiOS
