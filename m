From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: [PATCH 14/16] urcu-qsbr: batch concurrent
	synchronize_rcu()
Date: Wed, 21 Nov 2012 16:22:46 +0800
Message-ID: <50AC8F56.6040109__5114.67245310104$1353486033$gmane$org@cn.fujitsu.com>
References: <1353440429-19223-1-git-send-email-mathieu.desnoyers@efficios.com>
	<1353440429-19223-15-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1Tb5XI-0007Uj-JY
	for lttng-dev@lists.lttng.org; Wed, 21 Nov 2012 03:19:58 -0500
In-Reply-To: <1353440429-19223-15-git-send-email-mathieu.desnoyers@efficios.com>
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

Could you delay 14~16 for 40 days if I don't implement it in 40 days?

On 11/21/2012 03:40 AM, Mathieu Desnoyers wrote:
> Here are benchmarks on batching of synchronize_rcu(), and it leads to
> very interesting scalability improvement and speedups, e.g., on a
> 24-core AMD, with a write-heavy scenario (4 readers threads, 20 updater
> threads, each updater using synchronize_rcu()):
> 
> * Serialized grace periods :
> 
> ./test_urcu_qsbr 4 20 20
> SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers   4
> rdur      0 wdur      0 nr_writers  20 wdelay      0
> nr_reads  20251412728 nr_writes      1826331 nr_ops  20253239059
> 
> * Batched grace periods :
> 
> ./test_urcu_qsbr 4 20 20
> SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers   4
> rdur      0 wdur      0 nr_writers  20 wdelay      0
> nr_reads  15141994746 nr_writes      9382515 nr_ops  15151377261
> 
> For a 9382515/1826331 = 5.13 speedup for 20 updaters.
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
> ./test_urcu_qsbr 4 1 20
> SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers   4
> rdur      0 wdur      0 nr_writers   1 wdelay      0
> nr_reads  19240784755 nr_writes      2130839 nr_ops  19242915594
> 
> * Batched grace periods :
> 
> ./test_urcu_qsbr 4 1 20
> SUMMARY ./test_urcu_qsbr          testdur   20 nr_readers   4
> rdur      0 wdur      0 nr_writers   1 wdelay      0
> nr_reads  19160162768 nr_writes      2253068 nr_ops  1916241583
> 
> 2253068 vs 2137036 -> a couple of runs show that this difference lost in
> the noise for single updater.
> 
> CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> CC: Lai Jiangshan <laijs@cn.fujitsu.com>
> CC: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  urcu-qsbr.c |  151 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 151 insertions(+)
> 
> diff --git a/urcu-qsbr.c b/urcu-qsbr.c
> index 5b341b5..7f747ed 100644
> --- a/urcu-qsbr.c
> +++ b/urcu-qsbr.c
> @@ -36,6 +36,7 @@
>  #include <poll.h>
>  
>  #include "urcu/wfcqueue.h"
> +#include "urcu/wfstack.h"
>  #include "urcu/map/urcu-qsbr.h"
>  #define BUILD_QSBR_LIB
>  #include "urcu/static/urcu-qsbr.h"
> @@ -78,6 +79,35 @@ DEFINE_URCU_TLS(unsigned int, rcu_rand_yield);
>  
>  static CDS_LIST_HEAD(registry);
>  
> +/*
> + * Number of busy-loop attempts before waiting on futex for grace period
> + * batching.
> + */
> +#define RCU_AWAKE_ATTEMPTS 1000
> +
> +enum adapt_wakeup_state {
> +	/* AWAKE_WAITING is compared directly (futex compares it). */
> +	AWAKE_WAITING =		0,
> +	/* non-zero are used as masks. */
> +	AWAKE_WAKEUP =		(1 << 0),
> +	AWAKE_AWAKENED =	(1 << 1),
> +	AWAKE_TEARDOWN =	(1 << 2),
> +};
> +
> +struct gp_waiters_thread {
> +	struct cds_wfs_node node;
> +	int32_t wait_futex;
> +};
> +
> +/*
> + * Stack keeping threads awaiting to wait for a grace period. Contains
> + * struct gp_waiters_thread objects.
> + */
> +static struct cds_wfs_stack gp_waiters = {
> +	.head = CDS_WFS_END,
> +	.lock = PTHREAD_MUTEX_INITIALIZER,
> +};
> +
>  static void mutex_lock(pthread_mutex_t *mutex)
>  {
>  	int ret;
> @@ -116,6 +146,58 @@ static void wait_gp(void)
>  		      NULL, NULL, 0);
>  }
>  
> +/*
> + * Note: urcu_adaptative_wake_up needs "value" to stay allocated
> + * throughout its execution. In this scheme, the waiter owns the futex
> + * memory, and we only allow it to free this memory when it receives the
> + * AWAKE_TEARDOWN flag.
> + */
> +static void urcu_adaptative_wake_up(int32_t *value)
> +{
> +	cmm_smp_mb();
> +	assert(uatomic_read(value) == AWAKE_WAITING);
> +	uatomic_set(value, AWAKE_WAKEUP);
> +	if (!(uatomic_read(value) & AWAKE_AWAKENED))
> +		futex_noasync(value, FUTEX_WAKE, 1, NULL, NULL, 0);
> +	/* Allow teardown of "value" memory. */
> +	uatomic_or(value, AWAKE_TEARDOWN);
> +}
> +
> +/*
> + * Caller must initialize "value" to AWAKE_WAITING before passing its
> + * memory to waker thread.
> + */
> +static void urcu_adaptative_busy_wait(int32_t *value)
> +{
> +	unsigned int i;
> +
> +	/* Load and test condition before read futex */
> +	cmm_smp_rmb();
> +	for (i = 0; i < RCU_AWAKE_ATTEMPTS; i++) {
> +		if (uatomic_read(value) != AWAKE_WAITING)
> +			goto skip_futex_wait;
> +		caa_cpu_relax();
> +	}
> +	futex_noasync(value, FUTEX_WAIT, AWAKE_WAITING, NULL, NULL, 0);
> +skip_futex_wait:
> +
> +	/* Tell waker thread than we are awakened. */
> +	uatomic_or(value, AWAKE_AWAKENED);
> +
> +	/*
> +	 * Wait until waker thread lets us know it's ok to tear down
> +	 * memory allocated for value.
> +	 */
> +	for (i = 0; i < RCU_AWAKE_ATTEMPTS; i++) {
> +		if (uatomic_read(value) & AWAKE_TEARDOWN)
> +			break;
> +		caa_cpu_relax();
> +	}
> +	while (!(uatomic_read(value) & AWAKE_TEARDOWN))
> +		poll(NULL, 0, 10);
> +	assert(uatomic_read(value) & AWAKE_TEARDOWN);
> +}
> +
>  static void wait_for_readers(struct cds_list_head *input_readers,
>  			struct cds_list_head *cur_snap_readers,
>  			struct cds_list_head *qsreaders)
> @@ -198,6 +280,9 @@ void synchronize_rcu(void)
>  	CDS_LIST_HEAD(cur_snap_readers);
>  	CDS_LIST_HEAD(qsreaders);
>  	unsigned long was_online;
> +	struct gp_waiters_thread gp_waiters_thread;
> +	struct cds_wfs_head *gp_waiters_head;
> +	struct cds_wfs_node *waiters_iter, *waiters_iter_n;
>  
>  	was_online = URCU_TLS(rcu_reader).ctr;
>  
> @@ -214,8 +299,26 @@ void synchronize_rcu(void)
>  	else
>  		cmm_smp_mb();
>  
> +	/*
> +	 * Add ourself to gp_waiters stack of threads awaiting to wait
> +	 * for a grace period. Proceed to perform the grace period only
> +	 * if we are the first thread added into the stack.
> +	 */
> +	cds_wfs_node_init(&gp_waiters_thread.node);
> +	gp_waiters_thread.wait_futex = AWAKE_WAITING;
> +	if (cds_wfs_push(&gp_waiters, &gp_waiters_node) != 0) {
> +		/* Not first in stack: will be awakened by another thread. */
> +		urcu_adaptative_busy_wait(&gp_waiters_thread.wait_futex);
> +		goto gp_end;
> +	}
> +
>  	mutex_lock(&rcu_gp_lock);
>  
> +	/*
> +	 * Pop all waiters into our local stack head.
> +	 */
> +	gp_waiters_head = __cds_wfs_pop_all(&gp_waiters);
> +
>  	if (cds_list_empty(&registry))
>  		goto out;
>  
> @@ -272,6 +375,19 @@ void synchronize_rcu(void)
>  out:
>  	mutex_unlock(&rcu_gp_lock);
>  
> +	/* Wake all waiters in our stack head, excluding ourself. */
> +	cds_wfs_for_each_blocking_safe(gp_waiters_head, waiters_iter,
> +				waiters_iter_n) {
> +		struct gp_waiters_thread *wt;
> +
> +		wt = caa_container_of(waiters_iter,
> +				struct gp_waiters_thread, node);
> +		if (wt == &gp_waiters_thread)
> +			continue;
> +		urcu_adaptative_wake_up(&wt->wait_futex);
> +	}
> +
> +gp_end:
>  	/*
>  	 * Finish waiting for reader threads before letting the old ptr being
>  	 * freed.
> @@ -286,6 +402,9 @@ void synchronize_rcu(void)
>  {
>  	CDS_LIST_HEAD(qsreaders);
>  	unsigned long was_online;
> +	struct gp_waiters_thread gp_waiters_thread;
> +	struct cds_wfs_head *gp_waiters_head;
> +	struct cds_wfs_node *waiters_iter, *waiters_iter_n;
>  
>  	was_online = URCU_TLS(rcu_reader).ctr;
>  
> @@ -299,7 +418,26 @@ void synchronize_rcu(void)
>  	else
>  		cmm_smp_mb();
>  
> +	/*
> +	 * Add ourself to gp_waiters stack of threads awaiting to wait
> +	 * for a grace period. Proceed to perform the grace period only
> +	 * if we are the first thread added into the stack.
> +	 */
> +	cds_wfs_node_init(&gp_waiters_thread.node);
> +	gp_waiters_thread.wait_futex = AWAKE_WAITING;
> +	if (cds_wfs_push(&gp_waiters, &gp_waiters_thread.node) != 0) {
> +		/* Not first in stack: will be awakened by another thread. */
> +		urcu_adaptative_busy_wait(&gp_waiters_thread.wait_futex);
> +		goto gp_end;
> +	}
> +
>  	mutex_lock(&rcu_gp_lock);
> +
> +	/*
> +	 * Pop all waiters into our local stack head.
> +	 */
> +	gp_waiters_head = __cds_wfs_pop_all(&gp_waiters);
> +
>  	if (cds_list_empty(&registry))
>  		goto out;
>  
> @@ -334,6 +472,19 @@ void synchronize_rcu(void)
>  out:
>  	mutex_unlock(&rcu_gp_lock);
>  
> +	/* Wake all waiters in our stack head, excluding ourself. */
> +	cds_wfs_for_each_blocking_safe(gp_waiters_head, waiters_iter,
> +				waiters_iter_n) {
> +		struct gp_waiters_thread *wt;
> +
> +		wt = caa_container_of(waiters_iter,
> +				struct gp_waiters_thread, node);
> +		if (wt == &gp_waiters_thread)
> +			continue;
> +		urcu_adaptative_wake_up(&wt->wait_futex);
> +	}
> +
> +gp_end:
>  	if (was_online)
>  		rcu_thread_online();
>  	else
