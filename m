From: Lai Jiangshan <eag0628@gmail.com>
Subject: Re: [PATCH] urcu: avoid false sharing for rcu_gp_ctr
Date: Wed, 8 May 2013 23:45:50 +0800
Message-ID: <CACvQF521cSR0_5K+aC79A+s9APypQOS8POEoP2cDRguguw6P9A__47612.0058134713$1368027998$gmane$org@mail.gmail.com>
References: <50C19575.2070802@cn.fujitsu.com> <20130506124433.GB12699@Krystal>
	<518A144D.7090805@cn.fujitsu.com> <20130508135343.GA8230@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
In-Reply-To: <20130508135343.GA8230@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "ltt-dev@lists.casi.polymtl.ca" <ltt-dev@lists.casi.polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

On Wed, May 8, 2013 at 9:53 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> * Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
>> Hi, Mathieu,
>>
>> There is a big compatible problem in URCU which should be fix in next round.
>>
>> LB: liburcu built on the system which has sys_membarrier().
>> LU: liburcu built on the system which does NOT have sys_membarrier().
>>
>> LBM: liburcu-mb ....
>> LUM: liburcu-mb ...
>>
>> AB: application(-lliburcu) built on the system which has sys_membarrier().
>> AU: application(-lliburcu) built on the system which does NOT have sys_membarrier().
>>
>> ABM application(-lliburcu-mb) ...
>> AUM application(-lliburcu-mb) ...
>>
>> AB/AU + LB/LU: 4 combinations
>> ABM/AUM + LBM/LUM: 4 combinations
>>
>> I remember some of the 8 combinations can't works due to symbols are miss match.
>> only LU+AB and LB+AU ?
>>
>> could you check it?
>>
>> How to fix it: In LU and AU, keep all the symbol name/ABI as LA and AB, but only
>> the behaviors falls back to URCU_MB.
>
> Hi Lai,
>
> Good catch !
>
> Would the following patch work for you ? It introduces RCU_MEMBARRIER_MB
> for implementation fallback, but keeps RCU_MEMBARRIER defined and used
> for the RCU flavor mapping file.
>
> Thoughts ?
>
> Thanks,
>
> Mathieu
>
> ---
> diff --git a/urcu.c b/urcu.c
> index b3f94da..352d63f 100644
> --- a/urcu.c
> +++ b/urcu.c
> @@ -62,14 +62,14 @@
>   */
>  #define RCU_QS_ACTIVE_ATTEMPTS 100
>
> -#ifdef RCU_MEMBARRIER
> +#if defined(RCU_MEMBARRIER) && !defined(RCU_MEMBARRIER_MB)
>  static int init_done;
>  int rcu_has_sys_membarrier;

AB will use rcu_has_sys_membarrier, but LU don't have it.

RCU_MEMBARRIER_MB still introduces different ABI.



>
>  void __attribute__((constructor)) rcu_init(void);
>  #endif
>
> -#ifdef RCU_MB
> +#if defined(RCU_MB) || defined(RCU_MEMBARRIER_MB)
>  void rcu_init(void)
>  {
>  }
> @@ -135,7 +135,7 @@ static void mutex_unlock(pthread_mutex_t *mutex)
>                 urcu_die(ret);
>  }
>
> -#ifdef RCU_MEMBARRIER
> +#if defined(RCU_MEMBARRIER) && !defined(RCU_MEMBARRIER_MB)
>  static void smp_mb_master(int group)
>  {
>         if (caa_likely(rcu_has_sys_membarrier))
> @@ -145,7 +145,7 @@ static void smp_mb_master(int group)
>  }
>  #endif
>
> -#ifdef RCU_MB
> +#if defined(RCU_MB) || defined(RCU_MEMBARRIER_MB)
>  static void smp_mb_master(int group)
>  {
>         cmm_smp_mb();
> @@ -444,7 +444,7 @@ void rcu_unregister_thread(void)
>         mutex_unlock(&rcu_gp_lock);
>  }
>
> -#ifdef RCU_MEMBARRIER
> +#if defined(RCU_MEMBARRIER) && !defined(RCU_MEMBARRIER_MB)
>  void rcu_init(void)
>  {
>         if (init_done)
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
> -# define MEMBARRIER_EXPEDITED          (1 << 0)
> -# define MEMBARRIER_DELAYED            (1 << 1)
> -# define MEMBARRIER_QUERY              (1 << 16)
> -# define membarrier(...)               syscall(SYS_membarrier, __VA_ARGS__)
> -#else
> -# undef RCU_MEMBARRIER
> -# define RCU_MB
> -#endif
> -#endif
> -
>  #ifdef RCU_MEMBARRIER
>
>  #define rcu_read_lock                  rcu_read_lock_memb
> diff --git a/urcu/static/urcu.h b/urcu/static/urcu.h
> index bee97ee..be3d20c 100644
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
>  # define MEMBARRIER_QUERY              (1 << 16)
>  # define membarrier(...)               syscall(SYS_membarrier, __VA_ARGS__)
>  #else
> -# undef RCU_MEMBARRIER
> -# define RCU_MB
> +# define RCU_MEMBARRIER_MB
>  #endif
>  #endif
>
> @@ -178,7 +176,7 @@ static inline void rcu_debug_yield_init(void)
>  #define MB_GROUP_ALL           0
>  #define RCU_MB_GROUP           MB_GROUP_ALL
>
> -#ifdef RCU_MEMBARRIER
> +#if defined(RCU_MEMBARRIER) && !defined(RCU_MEMBARRIER_MB)
>  extern int rcu_has_sys_membarrier;
>
>  static inline void smp_mb_slave(int group)
> @@ -190,7 +188,7 @@ static inline void smp_mb_slave(int group)
>  }
>  #endif
>
> -#ifdef RCU_MB
> +#if defined(RCU_MB) || defined(RCU_MEMBARRIER_MB)
>  static inline void smp_mb_slave(int group)
>  {
>         cmm_smp_mb();
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
