From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/2] Use _umtx_op for futex on FreeBSD
Date: Mon, 27 Jan 2020 13:48:24 -0500 (EST)
Message-ID: <1117636152.600695.1580150904852.JavaMail.zimbra@efficios.com>
References: <20200127182526.22881-1-alex_y_xu@yahoo.ca>
 <20200127182526.22881-2-alex_y_xu@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 485zKQ0TYfz1xkB
 for <lttng-dev@lists.lttng.org>; Mon, 27 Jan 2020 13:48:25 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5D0E226119F
 for <lttng-dev@lists.lttng.org>; Mon, 27 Jan 2020 13:48:25 -0500 (EST)
In-Reply-To: <20200127182526.22881-2-alex_y_xu@yahoo.ca>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Jan 27, 2020, at 1:25 PM, lttng-dev lttng-dev@lists.lttng.org wrote:

> ---
> include/urcu/futex.h | 23 +++++++++++++++++++++++
> 1 file changed, 23 insertions(+)
> 
> diff --git a/include/urcu/futex.h b/include/urcu/futex.h
> index c206c6f..33dc3db 100644
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
> @@ -103,6 +104,28 @@ static inline int futex_async(int32_t *uaddr, int op,
> int32_t val,
> 	return ret;
> }
> 
> +#elif defined(__FreeBSD__)
> +
> +#include <sys/umtx.h>
> +
> +static inline int futex_noasync(int32_t *uaddr, int op, int32_t val,
> +		const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
> +{
> +	return futex_async(uaddr, op, val, timeout, uaddr2, val3);
> +}

Please move the futex_noasync definition after futex_async, considering that
futex_noasync uses futex_async().

> +
> +static inline int futex_async(int32_t *uaddr, int op, int32_t val,
> +		const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
> +{

Please declare a separate variable for umtx, e.g.:

int umtx_op;

> +	switch (op) {
> +		case FUTEX_WAIT: op = UMTX_OP_WAIT_UINT; break;
> +		case FUTEX_WAKE: op = UMTX_OP_WAKE; break;
> +		default: errno = EINVAL; return -1;
> +	}

Please follow the liburcu coding style, based on the Linux kernel
coding style:

switch (op) {
case FUTEX_WAIT:
	umtx_op = UMTX_OP_WAIT_UINT;
	break;
case FUTEX_WAKE:
	umtx_op = UMTX_OP_WAKE;
	break;
default:
	errno = EINVAL;
	return -1;
}

Also, do you have a link to the API documentation of _umtx_op() ?
I would like to double-check that all its return values are
expected by the callers.


> +	return _umtx_op(uaddr, op, val,
> +                (void *)sizeof(*timeout), (void *)timeout);

return _umtx_op(uaddr, umtx_op, val,
		(void *)sizeof(*timeout), (void *)timeout);

Is it OK that uaddr is a int32_t ? Is it expected to be some
other layout ? (e.g. struct umutex ?) I guess UMTX_OP_WAIT_UINT
somehow specifies this, but it would be good to document it
with a comment.

Thanks,

Mathieu


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
