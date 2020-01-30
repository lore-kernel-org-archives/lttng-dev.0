From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v4] Use _umtx_op for futex on FreeBSD
Date: Thu, 30 Jan 2020 13:34:11 -0500 (EST)
Message-ID: <952931034.603878.1580409251933.JavaMail.zimbra@efficios.com>
References: <20200128011722.36025-1-alex_y_xu.ref@yahoo.ca>
 <20200128011722.36025-1-alex_y_xu@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 487psc2w7lz22LD
 for <lttng-dev@lists.lttng.org>; Thu, 30 Jan 2020 13:34:12 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 504F92520A5
 for <lttng-dev@lists.lttng.org>; Thu, 30 Jan 2020 13:34:12 -0500 (EST)
In-Reply-To: <20200128011722.36025-1-alex_y_xu@yahoo.ca>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Alex Xu <alex_y_xu@yahoo.ca>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>
List-Id: lttng-dev@lists.lttng.org

Merged with small cosmetic tweaks into liburcu master, thanks!

Mathieu

----- On Jan 27, 2020, at 8:17 PM, lttng-dev lttng-dev@lists.lttng.org wrote:

> Tested with "make check", "make regtest" and a knotd slave.
> ---
> include/urcu/futex.h | 45 ++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 45 insertions(+)
> 
> diff --git a/include/urcu/futex.h b/include/urcu/futex.h
> index c206c6f..0777d95 100644
> --- a/include/urcu/futex.h
> +++ b/include/urcu/futex.h
> @@ -24,6 +24,7 @@
>  */
> 
> #include <urcu/config.h>
> +#include <errno.h>
> #include <stdint.h>
> #include <time.h>
> 
> @@ -103,6 +104,50 @@ static inline int futex_async(int32_t *uaddr, int op,
> int32_t val,
> 	return ret;
> }
> 
> +#elif defined(__FreeBSD__)
> +
> +#include <sys/types.h>
> +#include <sys/umtx.h>
> +
> +static inline int futex_async(int32_t *uaddr, int op, int32_t val,
> +		const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
> +{
> +	int umtx_op;
> +	void *umtx_uaddr = NULL, *umtx_uaddr2 = NULL;
> +	struct _umtx_time umtx_timeout = {
> +		._flags = UMTX_ABSTIME,
> +		._clockid = CLOCK_MONOTONIC
> +	};
> +
> +	switch (op) {
> +		case FUTEX_WAIT:
> +			// on FreeBSD, a "u_int" is a 32-bit integer
> +			umtx_op = UMTX_OP_WAIT_UINT;
> +			if (timeout != NULL) {
> +				umtx_timeout._timeout = *timeout;
> +				umtx_uaddr = (void *)sizeof(umtx_timeout);
> +				umtx_uaddr2 = (void *)&umtx_timeout;
> +			}
> +			break;
> +
> +		case FUTEX_WAKE:
> +			umtx_op = UMTX_OP_WAKE;
> +			break;
> +
> +		default:
> +			errno = EINVAL;
> +			return -1;
> +	}
> +
> +	return _umtx_op(uaddr, umtx_op, (uint32_t)val, umtx_uaddr, umtx_uaddr2);
> +}
> +
> +static inline int futex_noasync(int32_t *uaddr, int op, int32_t val,
> +		const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
> +{
> +	return futex_async(uaddr, op, val, timeout, uaddr2, val3);
> +}
> +
> #elif defined(__CYGWIN__)
> 
> /*
> --
> 2.25.0
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
