From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: [PATCH] urcu-mb/signal/membarrier: batch
	concurrent	synchronize_rcu()
Date: Mon, 26 Nov 2012 11:47:06 +0800
Message-ID: <50B2E63A.3020000__45863.7484153316$1353901491$gmane$org@cn.fujitsu.com>
References: <20121126032220.GA19034@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1TcpcF-0000CT-Sj
	for lttng-dev@lists.lttng.org; Sun, 25 Nov 2012 22:44:16 -0500
In-Reply-To: <20121126032220.GA19034@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alan Stern <stern@rowland.harvard.edu>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

I'm also interesting in the result of:
./test_urcu 12 12 20
./test_urcu 16 8 20
./test_urcu 20 4 20


On 11/26/2012 11:22 AM, Mathieu Desnoyers wrote:
> Here are benchmarks on batching of synchronize_rcu(), and it leads to
> very interesting scalability improvement and speedups, e.g., on a
> 24-core AMD, with a write-heavy scenario (4 readers threads, 20 updater
> threads, each updater using synchronize_rcu()):
> 
> * Serialized grace periods:
> ./test_urcu 4 20 20
> SUMMARY ./test_urcu               testdur   20 nr_readers   4
> rdur       0 wdur      0 nr_writers  20 wdelay      0
> nr_reads    714598368 nr_writes      5032889 nr_ops    719631257
> 
> * Batched grace periods:
> 
> ./test_urcu 4 20 20
> SUMMARY ./test_urcu               testdur   20 nr_readers   4
> rdur       0 wdur      0 nr_writers  20 wdelay      0
> nr_reads    611848168 nr_writes      9877965 nr_ops    621726133
> 
> For a 9877965/5032889 = 1.96 speedup for 20 updaters.
> 
> Of course, we can see that readers have slowed down, probably due to
> increased update traffic, given there is no change to the read-side code
> whatsoever.
> 
> Now let's see the penality of managing the stack for single-updater.
> With 4 readers, single updater:
> 
> * Serialized grace periods :
> 
> ./test_urcu 4 1 20
> SUMMARY ./test_urcu               testdur   20 nr_readers   4
> rdur       0 wdur      0 nr_writers   1 wdelay      0
> nr_reads    241959144 nr_writes     11146189 nr_ops    253105333
> SUMMARY ./test_urcu               testdur   20 nr_readers   4
> rdur       0 wdur      0 nr_writers   1 wdelay      0
> nr_reads    257131080 nr_writes     12310537 nr_ops    269441617
> SUMMARY ./test_urcu               testdur   20 nr_readers   4
> rdur       0 wdur      0 nr_writers   1 wdelay      0
> nr_reads    259973359 nr_writes     12203025 nr_ops    272176384
> 
> * Batched grace periods :
> 
> SUMMARY ./test_urcu               testdur   20 nr_readers   4
> rdur       0 wdur      0 nr_writers   1 wdelay      0
> nr_reads    298926555 nr_writes     14018748 nr_ops    312945303
> SUMMARY ./test_urcu               testdur   20 nr_readers   4
> rdur       0 wdur      0 nr_writers   1 wdelay      0
> nr_reads    272411290 nr_writes     12832166 nr_ops    285243456
> SUMMARY ./test_urcu               testdur   20 nr_readers   4
> rdur       0 wdur      0 nr_writers   1 wdelay      0
> nr_reads    267511858 nr_writes     12822026 nr_ops    280333884
> 
> Serialized vs batched seems to similar, batched possibly even slightly
> faster, but this is probably caused by NUMA affinity.
> 
> CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> CC: Lai Jiangshan <laijs@cn.fujitsu.com>
> CC: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> diff --git a/urcu.c b/urcu.c
> index e6ff0f3..836bad9 100644
> --- a/urcu.c
> +++ b/urcu.c
> @@ -43,6 +43,7 @@
>  #include "urcu/tls-compat.h"
>  
>  #include "urcu-die.h"
> +#include "urcu-wait.h"
>  
>  /* Do not #define _LGPL_SOURCE to ensure we can emit the wrapper symbols */
>  #undef _LGPL_SOURCE
> @@ -106,6 +107,12 @@ DEFINE_URCU_TLS(unsigned int, rcu_rand_yield);
>  
>  static CDS_LIST_HEAD(registry);
>  
> +/*
> + * Queue keeping threads awaiting to wait for a grace period. Contains
> + * struct gp_waiters_thread objects.
> + */
> +static DEFINE_URCU_WAIT_QUEUE(gp_waiters);
> +
>  static void mutex_lock(pthread_mutex_t *mutex)
>  {
>  	int ret;
> @@ -306,9 +313,31 @@ void synchronize_rcu(void)
>  {
>  	CDS_LIST_HEAD(cur_snap_readers);
>  	CDS_LIST_HEAD(qsreaders);
> +	DEFINE_URCU_WAIT_NODE(wait, URCU_WAIT_WAITING);
> +	struct urcu_waiters waiters;
> +
> +	/*
> +	 * Add ourself to gp_waiters queue of threads awaiting to wait
> +	 * for a grace period. Proceed to perform the grace period only
> +	 * if we are the first thread added into the queue.
> +	 */
> +	if (urcu_wait_add(&gp_waiters, &wait) != 0) {
> +		/* Not first in queue: will be awakened by another thread. */
> +		urcu_adaptative_busy_wait(&wait);
> +		/* Order following memory accesses after grace period. */
> +		cmm_smp_mb();
> +		return;
> +	}
> +	/* We won't need to wake ourself up */
> +	urcu_wait_set_state(&wait, URCU_WAIT_RUNNING);
>  
>  	mutex_lock(&rcu_gp_lock);
>  
> +	/*
> +	 * Move all waiters into our local queue.
> +	 */
> +	urcu_move_waiters(&waiters, &gp_waiters);
> +
>  	if (cds_list_empty(&registry))
>  		goto out;
>  
> @@ -374,6 +403,13 @@ void synchronize_rcu(void)
>  	smp_mb_master(RCU_MB_GROUP);
>  out:
>  	mutex_unlock(&rcu_gp_lock);
> +
> +	/*
> +	 * Wakeup waiters only after we have completed the grace period
> +	 * and have ensured the memory barriers at the end of the grace
> +	 * period have been issued.
> +	 */
> +	urcu_wake_all_waiters(&waiters);
>  }
>  
>  /*
> 
