From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2] Fix: Connect timeout
 arithmetic in inet/inet6 (v4)
Date: Fri, 16 Nov 2018 18:21:34 -0500
Message-ID: <20181116232133.GB2851__36270.3493018218$1542410380$gmane$org@gmail.com>
References: <20181113171221.2634-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by lists.lttng.org (Postfix) with ESMTPS id 42xZ4L0465zsPx
 for <lttng-dev@lists.lttng.org>; Fri, 16 Nov 2018 18:21:37 -0500 (EST)
Received: by mail-qk1-f194.google.com with SMTP id a132so40228528qkg.1
 for <lttng-dev@lists.lttng.org>; Fri, 16 Nov 2018 15:21:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20181113171221.2634-1-mathieu.desnoyers@efficios.com>
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

Merged all the way back to 2.9.

Thanks!
J=E9r=E9mie


On Tue, Nov 13, 2018 at 12:12:20PM -0500, Mathieu Desnoyers wrote:
> The nanoseconds part of the timespec struct time_a is not always
> bigger than time_b since it wrap around each seconds.
> =

> Use 64-bit arithmetic to perform the difference.
> =

> Merge/move duplicated code into utils.c.
> =

> This function is really doing two things. Split it into timespec_to_ms()
> and timespec_abs_diff().
> =

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> Changes since v1:
> - Use NSEC_PER_SEC constant.
> =

> Changes since v2:
> - Move prototypes to time.h.
> - Adapt timespec_to_ms() range check to take into account tv_nsec beyond
>   1000000000-1.
> =

> Changes since v3:
> - Use remainer for detection of overflow.
> - set errno to EOVERFLOW in timespec_to_ms.
> ---
>  src/common/common.h              |  1 +
>  src/common/sessiond-comm/inet.c  | 27 +++++++--------------------
>  src/common/sessiond-comm/inet6.c | 27 +++++++--------------------
>  src/common/time.h                | 15 +++++++++++++++
>  src/common/utils.c               | 36 ++++++++++++++++++++++++++++++++++=
++
>  5 files changed, 66 insertions(+), 40 deletions(-)
> =

> diff --git a/src/common/common.h b/src/common/common.h
> index 41eb0361..9168a245 100644
> --- a/src/common/common.h
> +++ b/src/common/common.h
> @@ -23,5 +23,6 @@
>  #include "macros.h"
>  #include "runas.h"
>  #include "readwrite.h"
> +#include "time.h"
>  =

>  #endif /* _COMMON_H */
> diff --git a/src/common/sessiond-comm/inet.c b/src/common/sessiond-comm/i=
net.c
> index e0b3e7a9..ac450dbc 100644
> --- a/src/common/sessiond-comm/inet.c
> +++ b/src/common/sessiond-comm/inet.c
> @@ -112,31 +112,13 @@ int connect_no_timeout(struct lttcomm_sock *sock)
>  			sizeof(sock->sockaddr.addr.sin));
>  }
>  =

> -/*
> - * Return time_a - time_b  in milliseconds.
> - */
> -static
> -unsigned long time_diff_ms(struct timespec *time_a,
> -		struct timespec *time_b)
> -{
> -	time_t sec_diff;
> -	long nsec_diff;
> -	unsigned long result_ms;
> -
> -	sec_diff =3D time_a->tv_sec - time_b->tv_sec;
> -	nsec_diff =3D time_a->tv_nsec - time_b->tv_nsec;
> -
> -	result_ms =3D sec_diff * MSEC_PER_SEC;
> -	result_ms +=3D nsec_diff / NSEC_PER_MSEC;
> -	return result_ms;
> -}
> -
>  static
>  int connect_with_timeout(struct lttcomm_sock *sock)
>  {
>  	unsigned long timeout =3D lttcomm_get_network_timeout();
>  	int ret, flags, connect_ret;
>  	struct timespec orig_time, cur_time;
> +	unsigned long diff_ms;
>  =

>  	ret =3D fcntl(sock->fd, F_GETFL, 0);
>  	if (ret =3D=3D -1) {
> @@ -217,7 +199,12 @@ int connect_with_timeout(struct lttcomm_sock *sock)
>  			connect_ret =3D ret;
>  			goto error;
>  		}
> -	} while (time_diff_ms(&cur_time, &orig_time) < timeout);
> +		if (timespec_to_ms(timespec_abs_diff(cur_time, orig_time), &diff_ms) <=
 0) {
> +			ERR("timespec_to_ms input overflows milliseconds output");
> +			connect_ret =3D -1;
> +			goto error;
> +		}
> +	} while (diff_ms < timeout);
>  =

>  	/* Timeout */
>  	errno =3D ETIMEDOUT;
> diff --git a/src/common/sessiond-comm/inet6.c b/src/common/sessiond-comm/=
inet6.c
> index dfb5fc5d..03b6627d 100644
> --- a/src/common/sessiond-comm/inet6.c
> +++ b/src/common/sessiond-comm/inet6.c
> @@ -110,31 +110,13 @@ int connect_no_timeout(struct lttcomm_sock *sock)
>  			sizeof(sock->sockaddr.addr.sin6));
>  }
>  =

> -/*
> - * Return time_a - time_b  in milliseconds.
> - */
> -static
> -unsigned long time_diff_ms(struct timespec *time_a,
> -		struct timespec *time_b)
> -{
> -	time_t sec_diff;
> -	long nsec_diff;
> -	unsigned long result_ms;
> -
> -	sec_diff =3D time_a->tv_sec - time_b->tv_sec;
> -	nsec_diff =3D time_a->tv_nsec - time_b->tv_nsec;
> -
> -	result_ms =3D sec_diff * MSEC_PER_SEC;
> -	result_ms +=3D nsec_diff / NSEC_PER_MSEC;
> -	return result_ms;
> -}
> -
>  static
>  int connect_with_timeout(struct lttcomm_sock *sock)
>  {
>  	unsigned long timeout =3D lttcomm_get_network_timeout();
>  	int ret, flags, connect_ret;
>  	struct timespec orig_time, cur_time;
> +	unsigned long diff_ms;
>  =

>  	ret =3D fcntl(sock->fd, F_GETFL, 0);
>  	if (ret =3D=3D -1) {
> @@ -216,7 +198,12 @@ int connect_with_timeout(struct lttcomm_sock *sock)
>  			connect_ret =3D ret;
>  			goto error;
>  		}
> -	} while (time_diff_ms(&cur_time, &orig_time) < timeout);
> +		if (timespec_to_ms(timespec_abs_diff(cur_time, orig_time), &diff_ms) <=
 0) {
> +			ERR("timespec_to_ms input overflows milliseconds output");
> +			connect_ret =3D -1;
> +			goto error;
> +		}
> +	} while (diff_ms < timeout);
>  =

>  	/* Timeout */
>  	errno =3D ETIMEDOUT;
> diff --git a/src/common/time.h b/src/common/time.h
> index 81770779..8a7dd958 100644
> --- a/src/common/time.h
> +++ b/src/common/time.h
> @@ -19,9 +19,24 @@
>  #ifndef LTTNG_TIME_H
>  #define LTTNG_TIME_H
>  =

> +#include <time.h>
> +
>  #define MSEC_PER_SEC	1000ULL
>  #define NSEC_PER_SEC	1000000000ULL
>  #define NSEC_PER_MSEC	1000000ULL
>  #define NSEC_PER_USEC	1000ULL
>  =

> +/*
> + * timespec_to_ms: Convert timespec to milliseconds.
> + *
> + * Returns 0 on success, else -1 on error. errno is set to EOVERFLOW if
> + * input would overflow the output in milliseconds.
> + */
> +int timespec_to_ms(struct timespec ts, unsigned long *ms);
> +
> +/*
> + * timespec_abs_diff: Absolute difference between timespec.
> + */
> +struct timespec timespec_abs_diff(struct timespec ts_a, struct timespec =
ts_b);
> +
>  #endif /* LTTNG_TIME_H */
> diff --git a/src/common/utils.c b/src/common/utils.c
> index 3442bef8..08139e5e 100644
> --- a/src/common/utils.c
> +++ b/src/common/utils.c
> @@ -41,6 +41,7 @@
>  =

>  #include "utils.h"
>  #include "defaults.h"
> +#include "time.h"
>  =

>  /*
>   * Return a partial realpath(3) of the path even if the full path does n=
ot
> @@ -1645,3 +1646,38 @@ int utils_show_help(int section, const char *page_=
name,
>  end:
>  	return ret;
>  }
> +
> +LTTNG_HIDDEN
> +int timespec_to_ms(struct timespec ts, unsigned long *ms)
> +{
> +	unsigned long res, remain_ms;
> +
> +	if (ts.tv_sec > ULONG_MAX / MSEC_PER_SEC) {
> +		errno =3D EOVERFLOW;
> +		return -1;	/* multiplication overflow */
> +	}
> +	res =3D ts.tv_sec * MSEC_PER_SEC;
> +	remain_ms =3D ULONG_MAX - res;
> +	if (ts.tv_nsec / NSEC_PER_MSEC > remain_ms) {
> +		errno =3D EOVERFLOW;
> +		return -1;	/* addition overflow */
> +	}
> +	res +=3D ts.tv_nsec / NSEC_PER_MSEC;
> +	*ms =3D res;
> +	return 0;
> +}
> +
> +LTTNG_HIDDEN
> +struct timespec timespec_abs_diff(struct timespec t1, struct timespec t2)
> +{
> +	uint64_t ts1 =3D (uint64_t) t1.tv_sec * (uint64_t) NSEC_PER_SEC +
> +			(uint64_t) t1.tv_nsec;
> +	uint64_t ts2 =3D (uint64_t) t2.tv_sec * (uint64_t) NSEC_PER_SEC +
> +			(uint64_t) t2.tv_nsec;
> +	uint64_t diff =3D max(ts1, ts2) - min(ts1, ts2);
> +	struct timespec res;
> +
> +	res.tv_sec =3D diff / (uint64_t) NSEC_PER_SEC;
> +	res.tv_nsec =3D diff % (uint64_t) NSEC_PER_SEC;
> +	return res;
> +}
> -- =

> 2.11.0
> =
