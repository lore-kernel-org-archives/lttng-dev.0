From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: [PATCH] urcu: avoid false sharing for rcu_gp_ctr
Date: Thu, 09 May 2013 15:17:35 +0800
Message-ID: <518B4D8F.20108__25293.6625890017$1368083749$gmane$org@cn.fujitsu.com>
References: <50C19575.2070802@cn.fujitsu.com>
	<20130506124433.GB12699@Krystal>	<518A144D.7090805@cn.fujitsu.com>
	<20130508135343.GA8230@Krystal>	<CACvQF521cSR0_5K+aC79A+s9APypQOS8POEoP2cDRguguw6P9A@mail.gmail.com>
	<20130508181936.GA9919@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
In-Reply-To: <20130508181936.GA9919@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Lai Jiangshan <eag0628@gmail.com>, "ltt-dev@lists.casi.polymtl.ca" <ltt-dev@lists.casi.polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

On 05/09/2013 02:19 AM, Mathieu Desnoyers wrote:
> * Lai Jiangshan (eag0628@gmail.com) wrote:
> [...] 
>> AB will use rcu_has_sys_membarrier, but LU don't have it.
>>
>> RCU_MEMBARRIER_MB still introduces different ABI.
> 
> Yes, you're right. How about the following then ?
> 
> ---
> diff --git a/urcu.c b/urcu.c
> index b3f94da..a7d9294 100644
> --- a/urcu.c
> +++ b/urcu.c
> @@ -63,13 +63,16 @@
>  #define RCU_QS_ACTIVE_ATTEMPTS 100
>  
>  #ifdef RCU_MEMBARRIER
> -static int init_done;
>  int rcu_has_sys_membarrier;
> +#endif
> +
> +#if defined(RCU_MEMBARRIER) && !defined(RCU_MEMBARRIER_MB)
> +static int init_done;
>  
>  void __attribute__((constructor)) rcu_init(void);
>  #endif
>  
> -#ifdef RCU_MB
> +#if defined(RCU_MB) || defined(RCU_MEMBARRIER_MB)
>  void rcu_init(void)
>  {
>  }
> @@ -135,7 +138,7 @@ static void mutex_unlock(pthread_mutex_t *mutex)
>  		urcu_die(ret);
>  }
>  
> -#ifdef RCU_MEMBARRIER
> +#if defined(RCU_MEMBARRIER) && !defined(RCU_MEMBARRIER_MB)
>  static void smp_mb_master(int group)
>  {
>  	if (caa_likely(rcu_has_sys_membarrier))
> @@ -145,7 +148,7 @@ static void smp_mb_master(int group)
>  }
>  #endif
>  
> -#ifdef RCU_MB
> +#if defined(RCU_MB) || defined(RCU_MEMBARRIER_MB)
>  static void smp_mb_master(int group)
>  {
>  	cmm_smp_mb();
> @@ -444,7 +447,7 @@ void rcu_unregister_thread(void)
>  	mutex_unlock(&rcu_gp_lock);
>  }
>  
> -#ifdef RCU_MEMBARRIER
> +#if defined(RCU_MEMBARRIER) && !defined(RCU_MEMBARRIER_MB)
>  void rcu_init(void)
>  {
>  	if (init_done)
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
> index bee97ee..633a46f 100644
> --- a/urcu/static/urcu.h
> +++ b/urcu/static/urcu.h
> @@ -52,15 +52,14 @@ extern "C" {
>  #endif
>  
>  /*
> - * RCU_MEMBARRIER is only possibly available on Linux. Fallback to RCU_MB
> - * otherwise.
> + * RCU_MEMBARRIER is only possibly available on Linux. Fallback to
> + * RCU_MEMBARRIER_MB otherwise.
>   */
>  #if !defined(__linux__) && defined(RCU_MEMBARRIER)
> -#undef RCU_MEMBARRIER
> -#define RCU_MB
> +#define RCU_MEMBARRIER_MB
>  #endif
>  
> -#ifdef RCU_MEMBARRIER
> +#if defined(RCU_MEMBARRIER) && !defined(RCU_MEMBARRIER_MB)
>  #include <syscall.h>
>  
>  /* If the headers do not support SYS_membarrier, statically use RCU_MB */
> @@ -70,8 +69,7 @@ extern "C" {
>  # define MEMBARRIER_QUERY		(1 << 16)
>  # define membarrier(...)		syscall(SYS_membarrier, __VA_ARGS__)
>  #else
> -# undef RCU_MEMBARRIER
> -# define RCU_MB
> +# define RCU_MEMBARRIER_MB
>  #endif
>  #endif
>  
> 


How about we also define membarrier(...) which just returns -ENOSYS
when the system don't have SYS_membarrier?
