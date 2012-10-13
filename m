From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/4] test: remove
	rcu_defer_register_thread() from	test_urcu_lfs
Date: Sat, 13 Oct 2012 12:46:43 -0400
Message-ID: <20121013164643.GF29985__16253.0198380866$1350146833$gmane$org@Krystal>
References: <1350144514-4132-1-git-send-email-laijs@cn.fujitsu.com>
	<1350144514-4132-2-git-send-email-laijs@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TN4rM-0006sC-HQ
	for lttng-dev@lists.lttng.org; Sat, 13 Oct 2012 12:46:44 -0400
Content-Disposition: inline
In-Reply-To: <1350144514-4132-2-git-send-email-laijs@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: Lai Jiangshan <eag0628@gmail.com>, lttng-dev@lists.lttng.org, Paul McKenney <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

* Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> test_urcu_lfs has already switch to call_rcu(), rcu_defer_register_thread()
> is unneeded.

Merged, thanks!

Mathieu

> 
> Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
> ---
>  tests/test_urcu_lfs.c |    8 --------
>  1 files changed, 0 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/test_urcu_lfs.c b/tests/test_urcu_lfs.c
> index 681b654..f5d7d4b 100644
> --- a/tests/test_urcu_lfs.c
> +++ b/tests/test_urcu_lfs.c
> @@ -67,7 +67,6 @@ static inline pid_t gettid(void)
>  #endif
>  #include <urcu.h>
>  #include <urcu/cds.h>
> -#include <urcu-defer.h>
>  
>  static volatile int test_go, test_stop;
>  
> @@ -221,18 +220,12 @@ void free_node_cb(struct rcu_head *head)
>  void *thr_dequeuer(void *_count)
>  {
>  	unsigned long long *count = _count;
> -	int ret;
>  
>  	printf_verbose("thread_begin %s, thread id : %lx, tid %lu\n",
>  			"dequeuer", pthread_self(), (unsigned long)gettid());
>  
>  	set_affinity();
>  
> -	ret = rcu_defer_register_thread();
> -	if (ret) {
> -		printf("Error in rcu_defer_register_thread\n");
> -		exit(-1);
> -	}
>  	rcu_register_thread();
>  
>  	while (!test_go)
> @@ -261,7 +254,6 @@ void *thr_dequeuer(void *_count)
>  	}
>  
>  	rcu_unregister_thread();
> -	rcu_defer_unregister_thread();
>  
>  	printf_verbose("dequeuer thread_end, thread id : %lx, tid %lu, "
>  		       "dequeues %llu, successful_dequeues %llu\n",
> -- 
> 1.7.7.6
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
