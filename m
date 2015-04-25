From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] Fix: deadlock when thread join is issued in
 read-side C.S. (v2)
Date: Sat, 25 Apr 2015 09:31:30 -0700
Message-ID: <20150425163130.GP5561__15102.6650717997$1429979563$gmane$org@linux.vnet.ibm.com>
References: <1429977149-3219-1-git-send-email-mathieu.desnoyers@efficios.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e31.co.us.ibm.com ([32.97.110.149])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <paulmck@linux.vnet.ibm.com>) id 1Ym2zV-00067z-ID
 for lttng-dev@lists.lttng.org; Sat, 25 Apr 2015 12:31:44 -0400
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
 Sat, 25 Apr 2015 10:31:35 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 9510D1FF001E
 for <lttng-dev@lists.lttng.org>; Sat, 25 Apr 2015 10:22:44 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t3PGVC0C31064110
 for <lttng-dev@lists.lttng.org>; Sat, 25 Apr 2015 09:31:12 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3PGVXtE026506
 for <lttng-dev@lists.lttng.org>; Sat, 25 Apr 2015 10:31:33 -0600
Content-Disposition: inline
In-Reply-To: <1429977149-3219-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, Lai Jiangshan <laijs@cn.fujitsu.com>
List-Id: lttng-dev@lists.lttng.org

On Sat, Apr 25, 2015 at 11:52:29AM -0400, Mathieu Desnoyers wrote:
> The transitive dependency between:
> 
> RCU read-side C.S. -> synchronize_rcu -> rcu_gp_lock -> rcu_register_thread
> 
> and the dependency:
> 
> pthread_join -> awaiting for thread completion
> 
> Can block a thread on join, and thus have the side-effect of deadlocking
> a thread doing a pthread_join while within a RCU read-side critical
> section. This join would be awaiting for completion of register_thread or
> rcu_unregister_thread, which may never complete because the rcu_gp_lock
> is held by synchronize_rcu executed from another thread.
> 
> One solution to fix this is to add a new lock, rcu_registry_lock. This
> lock now protects the thread registry. It is released between iterations
> on the registry by synchronize_rcu, thus allowing thread
> registration/unregistration to complete even though synchronize_rcu is
> awaiting for RCU read-side critical sections to complete.
> 
> Changes since v1:
> - Hold both rcu_gp_lock and rcu_registry_lock across fork in urcu-bp.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> CC: Eugene Ivanov <Eugene.Ivanov@orc-group.com>
> CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> CC: Lai Jiangshan <laijs@cn.fujitsu.com>
> CC: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  urcu-bp.c   | 49 +++++++++++++++++++++++++++++++++++++++--------
>  urcu-qsbr.c | 38 +++++++++++++++++++++++++++++++++----
>  urcu.c      | 63 ++++++++++++++++++++++++++++++++++++++++++++++++-------------
>  3 files changed, 125 insertions(+), 25 deletions(-)
> 
> diff --git a/urcu-bp.c b/urcu-bp.c
> index 6b2875d..4dc4028 100644
> --- a/urcu-bp.c
> +++ b/urcu-bp.c
> @@ -99,7 +99,21 @@ void __attribute__((constructor)) rcu_bp_init(void);
>  static
>  void __attribute__((destructor)) rcu_bp_exit(void);
> 
> +/*
> + * rcu_gp_lock ensures mutual exclusion between threads calling
> + * synchronize_rcu().
> + */
>  static pthread_mutex_t rcu_gp_lock = PTHREAD_MUTEX_INITIALIZER;
> +/*
> + * rcu_registry_lock ensures mutual exclusion between threads
> + * registering and unregistering themselves to/from the registry, and
> + * with threads reading that registry from synchronize_rcu(). However,
> + * this lock is not held all the way through the completion of awaiting
> + * for the grace period. It is sporadically released between iterations
> + * on the registry.
> + * rcu_registry_lock may nest inside rcu_gp_lock.
> + */
> +static pthread_mutex_t rcu_registry_lock = PTHREAD_MUTEX_INITIALIZER;
> 
>  static pthread_mutex_t init_lock = PTHREAD_MUTEX_INITIALIZER;
>  static int initialized;
> @@ -160,6 +174,10 @@ static void mutex_unlock(pthread_mutex_t *mutex)
>  		urcu_die(ret);
>  }
> 
> +/*
> + * Always called with rcu_registry lock held. Releases this lock between
> + * iterations and grabs it again. Holds the lock when it returns.
> + */
>  static void wait_for_readers(struct cds_list_head *input_readers,
>  			struct cds_list_head *cur_snap_readers,
>  			struct cds_list_head *qsreaders)
> @@ -202,10 +220,14 @@ static void wait_for_readers(struct cds_list_head *input_readers,
>  		if (cds_list_empty(input_readers)) {
>  			break;
>  		} else {
> +			/* Temporarily unlock the registry lock. */
> +			mutex_unlock(&rcu_registry_lock);
>  			if (wait_loops >= RCU_QS_ACTIVE_ATTEMPTS)
>  				(void) poll(NULL, 0, RCU_SLEEP_DELAY_MS);
>  			else
>  				caa_cpu_relax();
> +			/* Re-lock the registry lock before the next loop. */
> +			mutex_lock(&rcu_registry_lock);
>  		}
>  	}
>  }
> @@ -224,6 +246,8 @@ void synchronize_rcu(void)
> 
>  	mutex_lock(&rcu_gp_lock);
> 
> +	mutex_lock(&rcu_registry_lock);
> +
>  	if (cds_list_empty(&registry))
>  		goto out;
> 
> @@ -234,6 +258,8 @@ void synchronize_rcu(void)
> 
>  	/*
>  	 * Wait for readers to observe original parity or be quiescent.
> +	 * wait_for_readers() can release and grab again rcu_registry_lock
> +	 * interally.
>  	 */
>  	wait_for_readers(&registry, &cur_snap_readers, &qsreaders);
> 
> @@ -263,6 +289,8 @@ void synchronize_rcu(void)
> 
>  	/*
>  	 * Wait for readers to observe new parity or be quiescent.
> +	 * wait_for_readers() can release and grab again rcu_registry_lock
> +	 * interally.
>  	 */
>  	wait_for_readers(&cur_snap_readers, NULL, &qsreaders);
> 
> @@ -277,6 +305,7 @@ void synchronize_rcu(void)
>  	 */
>  	cmm_smp_mb();
>  out:
> +	mutex_unlock(&rcu_registry_lock);
>  	mutex_unlock(&rcu_gp_lock);
>  	ret = pthread_sigmask(SIG_SETMASK, &oldmask, NULL);
>  	assert(!ret);
> @@ -485,9 +514,9 @@ void rcu_bp_register(void)
>  	 */
>  	rcu_bp_init();
> 
> -	mutex_lock(&rcu_gp_lock);
> +	mutex_lock(&rcu_registry_lock);
>  	add_thread();
> -	mutex_unlock(&rcu_gp_lock);
> +	mutex_unlock(&rcu_registry_lock);
>  end:
>  	ret = pthread_sigmask(SIG_SETMASK, &oldmask, NULL);
>  	if (ret)
> @@ -508,9 +537,9 @@ void rcu_bp_unregister(struct rcu_reader *rcu_reader_reg)
>  	if (ret)
>  		abort();
> 
> -	mutex_lock(&rcu_gp_lock);
> +	mutex_lock(&rcu_registry_lock);
>  	remove_thread(rcu_reader_reg);
> -	mutex_unlock(&rcu_gp_lock);
> +	mutex_unlock(&rcu_registry_lock);
>  	ret = pthread_sigmask(SIG_SETMASK, &oldmask, NULL);
>  	if (ret)
>  		abort();
> @@ -564,9 +593,10 @@ void rcu_bp_exit(void)
>  }
> 
>  /*
> - * Holding the rcu_gp_lock across fork will make sure we fork() don't race with
> - * a concurrent thread executing with this same lock held. This ensures that the
> - * registry is in a coherent state in the child.
> + * Holding the rcu_gp_lock and rcu_registry_lock across fork will make
> + * sure we fork() don't race with a concurrent thread executing with
> + * any of those locks held. This ensures that the registry and data
> + * protected by rcu_gp_lock are in a coherent state in the child.
>   */
>  void rcu_bp_before_fork(void)
>  {
> @@ -578,6 +608,7 @@ void rcu_bp_before_fork(void)
>  	ret = pthread_sigmask(SIG_BLOCK, &newmask, &oldmask);
>  	assert(!ret);
>  	mutex_lock(&rcu_gp_lock);
> +	mutex_lock(&rcu_registry_lock);
>  	saved_fork_signal_mask = oldmask;
>  }
> 
> @@ -587,6 +618,7 @@ void rcu_bp_after_fork_parent(void)
>  	int ret;
> 
>  	oldmask = saved_fork_signal_mask;
> +	mutex_unlock(&rcu_registry_lock);
>  	mutex_unlock(&rcu_gp_lock);
>  	ret = pthread_sigmask(SIG_SETMASK, &oldmask, NULL);
>  	assert(!ret);
> @@ -594,7 +626,7 @@ void rcu_bp_after_fork_parent(void)
> 
>  /*
>   * Prune all entries from registry except our own thread. Fits the Linux
> - * fork behavior. Called with rcu_gp_lock held.
> + * fork behavior. Called with rcu_gp_lock and rcu_registry_lock held.
>   */
>  static
>  void urcu_bp_prune_registry(void)
> @@ -622,6 +654,7 @@ void rcu_bp_after_fork_child(void)
> 
>  	urcu_bp_prune_registry();
>  	oldmask = saved_fork_signal_mask;
> +	mutex_unlock(&rcu_registry_lock);
>  	mutex_unlock(&rcu_gp_lock);
>  	ret = pthread_sigmask(SIG_SETMASK, &oldmask, NULL);
>  	assert(!ret);
> diff --git a/urcu-qsbr.c b/urcu-qsbr.c
> index a35dcfc..3e77f98 100644
> --- a/urcu-qsbr.c
> +++ b/urcu-qsbr.c
> @@ -52,7 +52,21 @@
> 
>  void __attribute__((destructor)) rcu_exit(void);
> 
> +/*
> + * rcu_gp_lock ensures mutual exclusion between threads calling
> + * synchronize_rcu().
> + */
>  static pthread_mutex_t rcu_gp_lock = PTHREAD_MUTEX_INITIALIZER;
> +/*
> + * rcu_registry_lock ensures mutual exclusion between threads
> + * registering and unregistering themselves to/from the registry, and
> + * with threads reading that registry from synchronize_rcu(). However,
> + * this lock is not held all the way through the completion of awaiting
> + * for the grace period. It is sporadically released between iterations
> + * on the registry.
> + * rcu_registry_lock may nest inside rcu_gp_lock.
> + */
> +static pthread_mutex_t rcu_registry_lock = PTHREAD_MUTEX_INITIALIZER;
>  struct rcu_gp rcu_gp = { .ctr = RCU_GP_ONLINE };
> 
>  /*
> @@ -171,6 +185,8 @@ static void wait_for_readers(struct cds_list_head *input_readers,
>  			}
>  			break;
>  		} else {
> +			/* Temporarily unlock the registry lock. */
> +			mutex_unlock(&rcu_registry_lock);
>  			if (wait_loops >= RCU_QS_ACTIVE_ATTEMPTS) {
>  				wait_gp();
>  			} else {
> @@ -180,6 +196,8 @@ static void wait_for_readers(struct cds_list_head *input_readers,
>  				cmm_smp_mb();
>  #endif /* #else #ifndef HAS_INCOHERENT_CACHES */
>  			}
> +			/* Re-lock the registry lock before the next loop. */
> +			mutex_lock(&rcu_registry_lock);
>  		}
>  	}
>  }
> @@ -233,11 +251,15 @@ void synchronize_rcu(void)
>  	 */
>  	urcu_move_waiters(&waiters, &gp_waiters);
> 
> +	mutex_lock(&rcu_registry_lock);
> +
>  	if (cds_list_empty(&registry))
>  		goto out;
> 
>  	/*
>  	 * Wait for readers to observe original parity or be quiescent.
> +	 * wait_for_readers() can release and grab again rcu_registry_lock
> +	 * interally.
>  	 */
>  	wait_for_readers(&registry, &cur_snap_readers, &qsreaders);
> 
> @@ -279,6 +301,8 @@ void synchronize_rcu(void)
> 
>  	/*
>  	 * Wait for readers to observe new parity or be quiescent.
> +	 * wait_for_readers() can release and grab again rcu_registry_lock
> +	 * interally.
>  	 */
>  	wait_for_readers(&cur_snap_readers, NULL, &qsreaders);
> 
> @@ -287,6 +311,7 @@ void synchronize_rcu(void)
>  	 */
>  	cds_list_splice(&qsreaders, &registry);
>  out:
> +	mutex_unlock(&rcu_registry_lock);
>  	mutex_unlock(&rcu_gp_lock);
>  	urcu_wake_all_waiters(&waiters);
>  gp_end:
> @@ -339,6 +364,8 @@ void synchronize_rcu(void)
>  	 */
>  	urcu_move_waiters(&waiters, &gp_waiters);
> 
> +	mutex_lock(&rcu_registry_lock);
> +
>  	if (cds_list_empty(&registry))
>  		goto out;
> 
> @@ -363,6 +390,8 @@ void synchronize_rcu(void)
> 
>  	/*
>  	 * Wait for readers to observe new count of be quiescent.
> +	 * wait_for_readers() can release and grab again rcu_registry_lock
> +	 * interally.
>  	 */
>  	wait_for_readers(&registry, NULL, &qsreaders);
> 
> @@ -371,6 +400,7 @@ void synchronize_rcu(void)
>  	 */
>  	cds_list_splice(&qsreaders, &registry);
>  out:
> +	mutex_unlock(&rcu_registry_lock);
>  	mutex_unlock(&rcu_gp_lock);
>  	urcu_wake_all_waiters(&waiters);
>  gp_end:
> @@ -420,9 +450,9 @@ void rcu_register_thread(void)
>  	URCU_TLS(rcu_reader).tid = pthread_self();
>  	assert(URCU_TLS(rcu_reader).ctr == 0);
> 
> -	mutex_lock(&rcu_gp_lock);
> +	mutex_lock(&rcu_registry_lock);
>  	cds_list_add(&URCU_TLS(rcu_reader).node, &registry);
> -	mutex_unlock(&rcu_gp_lock);
> +	mutex_unlock(&rcu_registry_lock);
>  	_rcu_thread_online();
>  }
> 
> @@ -433,9 +463,9 @@ void rcu_unregister_thread(void)
>  	 * with a waiting writer.
>  	 */
>  	_rcu_thread_offline();
> -	mutex_lock(&rcu_gp_lock);
> +	mutex_lock(&rcu_registry_lock);
>  	cds_list_del(&URCU_TLS(rcu_reader).node);
> -	mutex_unlock(&rcu_gp_lock);
> +	mutex_unlock(&rcu_registry_lock);
>  }
> 
>  void rcu_exit(void)
> diff --git a/urcu.c b/urcu.c
> index ae3490f..1429f6d 100644
> --- a/urcu.c
> +++ b/urcu.c
> @@ -100,7 +100,21 @@ void __attribute__((constructor)) rcu_init(void);
>  void __attribute__((destructor)) rcu_exit(void);
>  #endif
> 
> +/*
> + * rcu_gp_lock ensures mutual exclusion between threads calling
> + * synchronize_rcu().
> + */
>  static pthread_mutex_t rcu_gp_lock = PTHREAD_MUTEX_INITIALIZER;
> +/*
> + * rcu_registry_lock ensures mutual exclusion between threads
> + * registering and unregistering themselves to/from the registry, and
> + * with threads reading that registry from synchronize_rcu(). However,
> + * this lock is not held all the way through the completion of awaiting
> + * for the grace period. It is sporadically released between iterations
> + * on the registry.
> + * rcu_registry_lock may nest inside rcu_gp_lock.
> + */
> +static pthread_mutex_t rcu_registry_lock = PTHREAD_MUTEX_INITIALIZER;
>  struct rcu_gp rcu_gp = { .ctr = RCU_GP_COUNT };
> 
>  /*
> @@ -226,6 +240,10 @@ static void wait_gp(void)
>  		      NULL, NULL, 0);
>  }
> 
> +/*
> + * Always called with rcu_registry lock held. Releases this lock between
> + * iterations and grabs it again. Holds the lock when it returns.
> + */
>  static void wait_for_readers(struct cds_list_head *input_readers,
>  			struct cds_list_head *cur_snap_readers,
>  			struct cds_list_head *qsreaders)
> @@ -282,10 +300,14 @@ static void wait_for_readers(struct cds_list_head *input_readers,
>  			}
>  			break;
>  		} else {
> +			/* Temporarily unlock the registry lock. */
> +			mutex_unlock(&rcu_registry_lock);
>  			if (wait_loops >= RCU_QS_ACTIVE_ATTEMPTS)
>  				wait_gp();
>  			else
>  				caa_cpu_relax();
> +			/* Re-lock the registry lock before the next loop. */
> +			mutex_lock(&rcu_registry_lock);
>  		}
>  #else /* #ifndef HAS_INCOHERENT_CACHES */
>  		/*
> @@ -305,12 +327,16 @@ static void wait_for_readers(struct cds_list_head *input_readers,
>  				smp_mb_master(RCU_MB_GROUP);
>  				wait_gp_loops = 0;
>  			}
> +			/* Temporarily unlock the registry lock. */
> +			mutex_unlock(&rcu_registry_lock);
>  			if (wait_loops >= RCU_QS_ACTIVE_ATTEMPTS) {
>  				wait_gp();
>  				wait_gp_loops++;
>  			} else {
>  				caa_cpu_relax();
>  			}
> +			/* Re-lock the registry lock before the next loop. */
> +			mutex_lock(&rcu_registry_lock);
>  		}
>  #endif /* #else #ifndef HAS_INCOHERENT_CACHES */
>  	}
> @@ -348,17 +374,23 @@ void synchronize_rcu(void)
>  	 */
>  	urcu_move_waiters(&waiters, &gp_waiters);
> 
> +	mutex_lock(&rcu_registry_lock);
> +
>  	if (cds_list_empty(&registry))
>  		goto out;
> 
> -	/* All threads should read qparity before accessing data structure
> -	 * where new ptr points to. Must be done within rcu_gp_lock because it
> -	 * iterates on reader threads.*/
> +	/*
> +	 * All threads should read qparity before accessing data structure
> +	 * where new ptr points to. Must be done within rcu_registry_lock
> +	 * because it iterates on reader threads.
> +	 */
>  	/* Write new ptr before changing the qparity */
>  	smp_mb_master(RCU_MB_GROUP);
> 
>  	/*
>  	 * Wait for readers to observe original parity or be quiescent.
> +	 * wait_for_readers() can release and grab again rcu_registry_lock
> +	 * interally.
>  	 */
>  	wait_for_readers(&registry, &cur_snap_readers, &qsreaders);
> 
> @@ -399,6 +431,8 @@ void synchronize_rcu(void)
> 
>  	/*
>  	 * Wait for readers to observe new parity or be quiescent.
> +	 * wait_for_readers() can release and grab again rcu_registry_lock
> +	 * interally.
>  	 */
>  	wait_for_readers(&cur_snap_readers, NULL, &qsreaders);
> 
> @@ -407,11 +441,14 @@ void synchronize_rcu(void)
>  	 */
>  	cds_list_splice(&qsreaders, &registry);
> 
> -	/* Finish waiting for reader threads before letting the old ptr being
> -	 * freed. Must be done within rcu_gp_lock because it iterates on reader
> -	 * threads. */
> +	/*
> +	 * Finish waiting for reader threads before letting the old ptr
> +	 * being freed. Must be done within rcu_registry_lock because it
> +	 * iterates on reader threads.
> +	 */
>  	smp_mb_master(RCU_MB_GROUP);
>  out:
> +	mutex_unlock(&rcu_registry_lock);
>  	mutex_unlock(&rcu_gp_lock);
> 
>  	/*
> @@ -447,17 +484,17 @@ void rcu_register_thread(void)
>  	assert(URCU_TLS(rcu_reader).need_mb == 0);
>  	assert(!(URCU_TLS(rcu_reader).ctr & RCU_GP_CTR_NEST_MASK));
> 
> -	mutex_lock(&rcu_gp_lock);
> +	mutex_lock(&rcu_registry_lock);
>  	rcu_init();	/* In case gcc does not support constructor attribute */
>  	cds_list_add(&URCU_TLS(rcu_reader).node, &registry);
> -	mutex_unlock(&rcu_gp_lock);
> +	mutex_unlock(&rcu_registry_lock);
>  }
> 
>  void rcu_unregister_thread(void)
>  {
> -	mutex_lock(&rcu_gp_lock);
> +	mutex_lock(&rcu_registry_lock);
>  	cds_list_del(&URCU_TLS(rcu_reader).node);
> -	mutex_unlock(&rcu_gp_lock);
> +	mutex_unlock(&rcu_registry_lock);
>  }
> 
>  #ifdef RCU_MEMBARRIER
> @@ -488,9 +525,9 @@ static void sigrcu_handler(int signo, siginfo_t *siginfo, void *context)
>   * rcu_init constructor. Called when the library is linked, but also when
>   * reader threads are calling rcu_register_thread().
>   * Should only be called by a single thread at a given time. This is ensured by
> - * holing the rcu_gp_lock from rcu_register_thread() or by running at library
> - * load time, which should not be executed by multiple threads nor concurrently
> - * with rcu_register_thread() anyway.
> + * holing the rcu_registry_lock from rcu_register_thread() or by running
> + * at library load time, which should not be executed by multiple
> + * threads nor concurrently with rcu_register_thread() anyway.
>   */
>  void rcu_init(void)
>  {
> -- 
> 2.1.4
> 
