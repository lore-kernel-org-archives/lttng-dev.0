From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: [PATCH] urcu: avoid false sharing for rcu_gp_ctr
Date: Thu, 16 May 2013 09:58:34 +0800
Message-ID: <51943D4A.20907__47773.2301726521$1368669412$gmane$org@cn.fujitsu.com>
References: <50C19575.2070802@cn.fujitsu.com>
	<20130506124433.GB12699@Krystal>	<518A144D.7090805@cn.fujitsu.com>
	<20130508135343.GA8230@Krystal>	<CACvQF521cSR0_5K+aC79A+s9APypQOS8POEoP2cDRguguw6P9A@mail.gmail.com>	<20130508181936.GA9919@Krystal>
	<518B4D8F.20108@cn.fujitsu.com>	<20130509122748.GA23531@Krystal>	<CACvQF53K3Qwj4JO3y82yhxGqrBfPdkgH2fXcj5SbYO0OTD+uSg@mail.gmail.com>
	<20130509151018.GC27168@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
In-Reply-To: <20130509151018.GC27168@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "ltt-dev@lists.casi.polymtl.ca" <ltt-dev@lists.casi.polymtl.ca>, Lai Jiangshan <eag0628@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

On 05/09/2013 11:10 PM, Mathieu Desnoyers wrote:
> * Lai Jiangshan (eag0628@gmail.com) wrote:
> [...]
>> I think this code can be moved into urcu.c
> 
> good point! How about this ?

Hi, I don't see any obvious bad thing, but I can't carefully check it
currently, It seems OK for me.

Could you make it some progress.

Thanks,
Lai

> 
> ---
> diff --git a/urcu.c b/urcu.c
> index b3f94da..1d5c06f 100644
> --- a/urcu.c
> +++ b/urcu.c
> @@ -62,6 +62,24 @@
>   */
>  #define RCU_QS_ACTIVE_ATTEMPTS 100
>  
> +/*
> + * RCU_MEMBARRIER is only possibly available on Linux.
> + */
> +#if defined(RCU_MEMBARRIER) && defined(__linux__)
> +#include <syscall.h>
> +#endif
> +
> +/* If the headers do not support SYS_membarrier, fall back on RCU_MB */
> +#ifdef SYS_membarrier
> +# define membarrier(...)		syscall(SYS_membarrier, __VA_ARGS__)
> +#else
> +# define membarrier(...)		-ENOSYS
> +#endif
> +
> +#define MEMBARRIER_EXPEDITED		(1 << 0)
> +#define MEMBARRIER_DELAYED		(1 << 1)
> +#define MEMBARRIER_QUERY		(1 << 16)
> +
>  #ifdef RCU_MEMBARRIER
>  static int init_done;
>  int rcu_has_sys_membarrier;
> @@ -139,7 +157,7 @@ static void mutex_unlock(pthread_mutex_t *mutex)
>  static void smp_mb_master(int group)
>  {
>  	if (caa_likely(rcu_has_sys_membarrier))
> -		membarrier(MEMBARRIER_EXPEDITED);
> +		(void) membarrier(MEMBARRIER_EXPEDITED);
>  	else
>  		cmm_smp_mb();
>  }
> diff --git a/urcu/map/urcu.h b/urcu/map/urcu.h
> index 217bff5..77b3721 100644
> --- a/urcu/map/urcu.h
> +++ b/urcu/map/urcu.h
> @@ -38,31 +38,6 @@
>  #define RCU_MEMBARRIER
>  #endif
>  
> -/*
> - * RCU_MEMBARRIER is only possibly available on Linux. Fallback to
> - * RCU_MB
> - * otherwise.
> - */
> -#if !defined(__linux__) && defined(RCU_MEMBARRIER)
> -#undef RCU_MEMBARRIER
> -#define RCU_MB
> -#endif
> -
> -#ifdef RCU_MEMBARRIER
> -#include <syscall.h>
> -
> -/* If the headers do not support SYS_membarrier, statically use RCU_MB */
> -#ifdef SYS_membarrier
> -# define MEMBARRIER_EXPEDITED		(1 << 0)
> -# define MEMBARRIER_DELAYED		(1 << 1)
> -# define MEMBARRIER_QUERY		(1 << 16)
> -# define membarrier(...)		syscall(SYS_membarrier, __VA_ARGS__)
> -#else
> -# undef RCU_MEMBARRIER
> -# define RCU_MB
> -#endif
> -#endif
> -
>  #ifdef RCU_MEMBARRIER
>  
>  #define rcu_read_lock			rcu_read_lock_memb
> diff --git a/urcu/static/urcu.h b/urcu/static/urcu.h
> index bee97ee..53d2610 100644
> --- a/urcu/static/urcu.h
> +++ b/urcu/static/urcu.h
> @@ -52,30 +52,6 @@ extern "C" {
>  #endif
>  
>  /*
> - * RCU_MEMBARRIER is only possibly available on Linux. Fallback to RCU_MB
> - * otherwise.
> - */
> -#if !defined(__linux__) && defined(RCU_MEMBARRIER)
> -#undef RCU_MEMBARRIER
> -#define RCU_MB
> -#endif
> -
> -#ifdef RCU_MEMBARRIER
> -#include <syscall.h>
> -
> -/* If the headers do not support SYS_membarrier, statically use RCU_MB */
> -#ifdef SYS_membarrier
> -# define MEMBARRIER_EXPEDITED		(1 << 0)
> -# define MEMBARRIER_DELAYED		(1 << 1)
> -# define MEMBARRIER_QUERY		(1 << 16)
> -# define membarrier(...)		syscall(SYS_membarrier, __VA_ARGS__)
> -#else
> -# undef RCU_MEMBARRIER
> -# define RCU_MB
> -#endif
> -#endif
> -
> -/*
>   * This code section can only be included in LGPL 2.1 compatible source code.
>   * See below for the function call wrappers which can be used in code meant to
>   * be only linked with the Userspace RCU library. This comes with a small
> 
