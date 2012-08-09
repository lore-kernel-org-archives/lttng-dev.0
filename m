From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] urcu: fix compat_futex_noasync()
Date: Thu, 9 Aug 2012 10:20:48 -0400
Message-ID: <20120809142048.GA9211__28219.4363572218$1344522075$gmane$org@Krystal>
References: <5021BEE4.6090907@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SzTbV-0002ht-TS
	for lttng-dev@lists.lttng.org; Thu, 09 Aug 2012 10:20:50 -0400
Content-Disposition: inline
In-Reply-To: <5021BEE4.6090907@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

* Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> This patch fix two critical problems:
> 
> 1) compat_futex_cond is not bound to any @uaddr, it services all @uaddr,
>    if you wakeup only one thread(pthread_cond_signal), the @uaddr of
>    this waking thread and the @uaddr of the woken-up thread may be different.
>    the the woken-up thread will very probably go to sleep again
>    because his own condition is not true.
> 
>    *And* this waking thread(FUTEX_WAKE) wake up NOTHING.
> 
> 2) If the caller want to wake up all waiting threads, he will use INT_MAX for @val.
>    and 
> 		for (i = 0; i < INT_MAX; i++)
> 			pthread_cond_signal(&compat_futex_cond);
>    becomes almost infinity loop.
> 
> Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>

Good catch !

Merged, thanks!

Mathieu

> ---
> diff --git a/compat_futex.c b/compat_futex.c
> index 04de596..bb928e6 100644
> --- a/compat_futex.c
> +++ b/compat_futex.c
> @@ -43,7 +43,7 @@ static pthread_cond_t compat_futex_cond = PTHREAD_COND_INITIALIZER;
>  int compat_futex_noasync(int32_t *uaddr, int op, int32_t val,
>  	const struct timespec *timeout, int32_t *uaddr2, int32_t val3)
>  {
> -	int ret, i, gret = 0;
> +	int ret, gret = 0;
>  
>  	/*
>  	 * Check if NULL. Don't let users expect that they are taken into
> @@ -67,8 +67,7 @@ int compat_futex_noasync(int32_t *uaddr, int op, int32_t val,
>  		pthread_cond_wait(&compat_futex_cond, &compat_futex_lock);
>  		break;
>  	case FUTEX_WAKE:
> -		for (i = 0; i < val; i++)
> -			pthread_cond_signal(&compat_futex_cond);
> +		pthread_cond_broadcast(&compat_futex_cond);
>  		break;
>  	default:
>  		gret = -EINVAL;

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
