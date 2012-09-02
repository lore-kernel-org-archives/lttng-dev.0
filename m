From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [rp] [PATCH] Ensure that read-side functions meet
 10-line LGPL criterion
Date: Sat, 1 Sep 2012 22:13:55 -0700
Message-ID: <20120902051355.GA7767__12776.6118887395$1346562882$gmane$org@leaf>
References: <20120902005911.GA26326@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <josh@joshtriplett.org>) id 1T82Va-0007gw-VM
	for lttng-dev@lists.lttng.org; Sun, 02 Sep 2012 01:14:07 -0400
Content-Disposition: inline
In-Reply-To: <20120902005911.GA26326@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: lttng-dev@lists.lttng.org, eag0628@gmail.com, mathieu.desnoyers@efficios.com, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

On Sat, Sep 01, 2012 at 05:59:11PM -0700, Paul E. McKenney wrote:
> This commit ensures that all read-side functions meet the 10-line LGPL
> criterion that permits them to be expanded directly into non-LGPL code,
> without function-call instructions.  It also documents this as the intent.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

s/directloy/directly/g in the comments.

Also, this seems inordinately silly. :)

Assuming you don't plan to copy other LGPLed code into this library (or
more specifically the header file), you might consider just adding an
explicit exception at the top, saying that the inline functions in this
file may be assumed to qualify for the relevant clause of the LGPL,
regardless of their length.  (You'd probably want to limit that
exception to only the code in the header, not any other code in the
library, so someone couldn't just copy the whole library into the
headers.)

> diff --git a/urcu/static/urcu-bp.h b/urcu/static/urcu-bp.h
> index e7b2eda..881b4a4 100644
> --- a/urcu/static/urcu-bp.h
> +++ b/urcu/static/urcu-bp.h
> @@ -6,8 +6,8 @@
>   *
>   * Userspace RCU header.
>   *
> - * TO BE INCLUDED ONLY IN LGPL-COMPATIBLE CODE. See urcu.h for linking
> - * dynamically with the userspace rcu library.
> + * TO BE INCLUDED ONLY IN CODE THAT IS TO BE RECOMPILED ON EACH LIBURCU
> + * RELEASE. See urcu.h for linking dynamically with the userspace rcu library.
>   *
>   * Copyright (c) 2009 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (c) 2009 Paul E. McKenney, IBM Corporation.
> @@ -162,32 +162,48 @@ static inline int rcu_old_gp_ongoing(long *value)
>  		 ((v ^ rcu_gp_ctr) & RCU_GP_CTR_PHASE);
>  }
>  
> +/*
> + * Helper for _rcu_read_lock().  The format of rcu_gp_ctr (as well as
> + * the per-thread rcu_reader.ctr) has the upper bits containing a count of
> + * _rcu_read_lock() nesting, and a lower-order bit that contains either zero
> + * or RCU_GP_CTR_PHASE.  The smp_mb_slave() ensures that the accesses in
> + * _rcu_read_lock() happen before the subsequent read-side critical section.
> + */
> +static inline void _rcu_read_lock_help(unsigned long tmp)
> +{
> +	if (caa_likely(!(tmp & RCU_GP_CTR_NEST_MASK))) {
> +		_CMM_STORE_SHARED(URCU_TLS(rcu_reader)->ctr, _CMM_LOAD_SHARED(rcu_gp_ctr));
> +		cmm_smp_mb();
> +	} else
> +		_CMM_STORE_SHARED(URCU_TLS(rcu_reader)->ctr, tmp + RCU_GP_COUNT);
> +}
> +
> +/*
> + * Enter an RCU read-side critical section.
> + *
> + * The first cmm_barrier() call ensures that the compiler does not reorder
> + * the body of _rcu_read_lock() with a mutex.
> + *
> + * This function and its helper are both less than 10 lines long.  The
> + * intent is that this function meets the 10-line criterion in LGPL,
> + * allowing this function to be invoked directly from non-LGPL code.
> + */
>  static inline void _rcu_read_lock(void)
>  {
>  	long tmp;
>  
> -	/* Check if registered */
>  	if (caa_unlikely(!URCU_TLS(rcu_reader)))
> -		rcu_bp_register();
> -
> +		rcu_bp_register(); /* If not yet registered. */
>  	cmm_barrier();	/* Ensure the compiler does not reorder us with mutex */
>  	tmp = URCU_TLS(rcu_reader)->ctr;
> -	/*
> -	 * rcu_gp_ctr is
> -	 *   RCU_GP_COUNT | (~RCU_GP_CTR_PHASE or RCU_GP_CTR_PHASE)
> -	 */
> -	if (caa_likely(!(tmp & RCU_GP_CTR_NEST_MASK))) {
> -		_CMM_STORE_SHARED(URCU_TLS(rcu_reader)->ctr, _CMM_LOAD_SHARED(rcu_gp_ctr));
> -		/*
> -		 * Set active readers count for outermost nesting level before
> -		 * accessing the pointer.
> -		 */
> -		cmm_smp_mb();
> -	} else {
> -		_CMM_STORE_SHARED(URCU_TLS(rcu_reader)->ctr, tmp + RCU_GP_COUNT);
> -	}
> +	_rcu_read_lock_help(tmp);
>  }
>  
> +/*
> + * Exit an RCU read-side critical section.  This function is less than
> + * 10 lines of code, and is intended to be usable by non-LGPL code, as
> + * called out in LGPL.
> + */
>  static inline void _rcu_read_unlock(void)
>  {
>  	/*
> diff --git a/urcu/static/urcu-pointer.h b/urcu/static/urcu-pointer.h
> index 48dc5bf..0ddf6a1 100644
> --- a/urcu/static/urcu-pointer.h
> +++ b/urcu/static/urcu-pointer.h
> @@ -6,8 +6,8 @@
>   *
>   * Userspace RCU header. Operations on pointers.
>   *
> - * TO BE INCLUDED ONLY IN LGPL-COMPATIBLE CODE. See urcu-pointer.h for
> - * linking dynamically with the userspace rcu library.
> + * TO BE INCLUDED ONLY IN CODE THAT IS TO BE RECOMPILED ON EACH LIBURCU
> + * RELEASE. See urcu.h for linking dynamically with the userspace rcu library.
>   *
>   * Copyright (c) 2009 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (c) 2009 Paul E. McKenney, IBM Corporation.
> @@ -59,8 +59,11 @@ extern "C" {
>   * addition to forthcoming C++ standard.
>   *
>   * Should match rcu_assign_pointer() or rcu_xchg_pointer().
> + *
> + * This macro is less than 10 lines long.  The intent is that this macro
> + * meets the 10-line criterion in LGPL, allowing this function to be
> + * expanded directloy in non-LGPL code.
>   */
> -
>  #define _rcu_dereference(p)     ({					\
>  				__typeof__(p) _________p1 = CMM_LOAD_SHARED(p); \
>  				cmm_smp_read_barrier_depends();		\
> @@ -73,8 +76,11 @@ extern "C" {
>   * data structure, which can be safely freed after waiting for a quiescent state
>   * using synchronize_rcu(). If fails (unexpected value), returns old (which
>   * should not be freed !).
> + *
> + * This macro is less than 10 lines long.  The intent is that this macro
> + * meets the 10-line criterion in LGPL, allowing this function to be
> + * expanded directloy in non-LGPL code.
>   */
> -
>  #define _rcu_cmpxchg_pointer(p, old, _new)				\
>  	({								\
>  		__typeof__(*p) _________pold = (old);			\
> @@ -89,8 +95,11 @@ extern "C" {
>   * _rcu_xchg_pointer - same as rcu_assign_pointer, but returns the previous
>   * pointer to the data structure, which can be safely freed after waiting for a
>   * quiescent state using synchronize_rcu().
> + *
> + * This macro is less than 10 lines long.  The intent is that this macro
> + * meets the 10-line criterion in LGPL, allowing this function to be
> + * expanded directloy in non-LGPL code.
>   */
> -
>  #define _rcu_xchg_pointer(p, v)				\
>  	({						\
>  		__typeof__(*p) _________pv = (v);	\
> @@ -121,8 +130,11 @@ extern "C" {
>   * data structure before its publication.
>   *
>   * Should match rcu_dereference_pointer().
> + *
> + * This macro is less than 10 lines long.  The intent is that this macro
> + * meets the 10-line criterion in LGPL, allowing this function to be
> + * expanded directloy in non-LGPL code.
>   */
> -
>  #define _rcu_assign_pointer(p, v)	_rcu_set_pointer(&(p), v)
>  
>  #ifdef __cplusplus 
> diff --git a/urcu/static/urcu-qsbr.h b/urcu/static/urcu-qsbr.h
> index 22908a4..5580092 100644
> --- a/urcu/static/urcu-qsbr.h
> +++ b/urcu/static/urcu-qsbr.h
> @@ -6,8 +6,8 @@
>   *
>   * Userspace RCU QSBR header.
>   *
> - * TO BE INCLUDED ONLY IN LGPL-COMPATIBLE CODE. See urcu-qsbr.h for linking
> - * dynamically with the userspace rcu QSBR library.
> + * TO BE INCLUDED ONLY IN CODE THAT IS TO BE RECOMPILED ON EACH LIBURCU
> + * RELEASE. See urcu.h for linking dynamically with the userspace rcu library.
>   *
>   * Copyright (c) 2009 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (c) 2009 Paul E. McKenney, IBM Corporation.
> @@ -157,15 +157,36 @@ static inline int rcu_gp_ongoing(unsigned long *ctr)
>  	return v && (v != rcu_gp_ctr);
>  }
>  
> +/*
> + * Enter an RCU read-side critical section.
> + *
> + * This function is less than 10 lines long.  The intent is that this
> + * function meets the 10-line criterion for LGPL, allowing this function
> + * to be invoked directly from non-LGPL code.
> + */
>  static inline void _rcu_read_lock(void)
>  {
>  	rcu_assert(URCU_TLS(rcu_reader).ctr);
>  }
>  
> +/*
> + * Exit an RCU read-side critical section.
> + *
> + * This function is less than 10 lines long.  The intent is that this
> + * function meets the 10-line criterion for LGPL, allowing this function
> + * to be invoked directly from non-LGPL code.
> + */
>  static inline void _rcu_read_unlock(void)
>  {
>  }
>  
> +/*
> + * Inform RCU of a quiescent state.
> + *
> + * This function is less than 10 lines long.  The intent is that this
> + * function meets the 10-line criterion for LGPL, allowing this function
> + * to be invoked directly from non-LGPL code.
> + */
>  static inline void _rcu_quiescent_state(void)
>  {
>  	cmm_smp_mb();
> @@ -175,6 +196,14 @@ static inline void _rcu_quiescent_state(void)
>  	cmm_smp_mb();
>  }
>  
> +/*
> + * Take a thread offline, prohibiting it from entering further RCU
> + * read-side critical sections.
> + *
> + * This function is less than 10 lines long.  The intent is that this
> + * function meets the 10-line criterion for LGPL, allowing this function
> + * to be invoked directly from non-LGPL code.
> + */
>  static inline void _rcu_thread_offline(void)
>  {
>  	cmm_smp_mb();
> @@ -184,6 +213,14 @@ static inline void _rcu_thread_offline(void)
>  	cmm_barrier();	/* Ensure the compiler does not reorder us with mutex */
>  }
>  
> +/*
> + * Bring a thread online, allowing it to once again enter RCU
> + * read-side critical sections.
> + *
> + * This function is less than 10 lines long.  The intent is that this
> + * function meets the 10-line criterion for LGPL, allowing this function
> + * to be invoked directly from non-LGPL code.
> + */
>  static inline void _rcu_thread_online(void)
>  {
>  	cmm_barrier();	/* Ensure the compiler does not reorder us with mutex */
> diff --git a/urcu/static/urcu.h b/urcu/static/urcu.h
> index f27f8b6..fe3194f 100644
> --- a/urcu/static/urcu.h
> +++ b/urcu/static/urcu.h
> @@ -6,8 +6,8 @@
>   *
>   * Userspace RCU header.
>   *
> - * TO BE INCLUDED ONLY IN LGPL-COMPATIBLE CODE. See urcu.h for linking
> - * dynamically with the userspace rcu library.
> + * TO BE INCLUDED ONLY IN CODE THAT IS TO BE RECOMPILED ON EACH LIBURCU
> + * RELEASE. See urcu.h for linking dynamically with the userspace rcu library.
>   *
>   * Copyright (c) 2009 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   * Copyright (c) 2009 Paul E. McKenney, IBM Corporation.
> @@ -252,46 +252,71 @@ static inline int rcu_gp_ongoing(unsigned long *ctr)
>  		 ((v ^ rcu_gp_ctr) & RCU_GP_CTR_PHASE);
>  }
>  
> -static inline void _rcu_read_lock(void)
> +/*
> + * Helper for _rcu_read_lock().  The format of rcu_gp_ctr (as well as
> + * the per-thread rcu_reader.ctr) has the upper bits containing a count of
> + * _rcu_read_lock() nesting, and a lower-order bit that contains either zero
> + * or RCU_GP_CTR_PHASE.  The smp_mb_slave() ensures that the accesses in
> + * _rcu_read_lock() happen before the subsequent read-side critical section.
> + */
> +static inline void _rcu_read_lock_help(unsigned long tmp)
>  {
> -	unsigned long tmp;
> -
> -	cmm_barrier();	/* Ensure the compiler does not reorder us with mutex */
> -	tmp = URCU_TLS(rcu_reader).ctr;
> -	/*
> -	 * rcu_gp_ctr is
> -	 *   RCU_GP_COUNT | (~RCU_GP_CTR_PHASE or RCU_GP_CTR_PHASE)
> -	 */
>  	if (caa_likely(!(tmp & RCU_GP_CTR_NEST_MASK))) {
>  		_CMM_STORE_SHARED(URCU_TLS(rcu_reader).ctr, _CMM_LOAD_SHARED(rcu_gp_ctr));
> -		/*
> -		 * Set active readers count for outermost nesting level before
> -		 * accessing the pointer. See smp_mb_master().
> -		 */
>  		smp_mb_slave(RCU_MB_GROUP);
> -	} else {
> +	} else
>  		_CMM_STORE_SHARED(URCU_TLS(rcu_reader).ctr, tmp + RCU_GP_COUNT);
> -	}
>  }
>  
> -static inline void _rcu_read_unlock(void)
> +/*
> + * Enter an RCU read-side critical section.
> + *
> + * The first cmm_barrier() call ensures that the compiler does not reorder
> + * the body of _rcu_read_lock() with a mutex.
> + *
> + * This function and its helper are both less than 10 lines long.  The
> + * intent is that this function meets the 10-line criterion in LGPL,
> + * allowing this function to be invoked directly from non-LGPL code.
> + */
> +static inline void _rcu_read_lock(void)
>  {
>  	unsigned long tmp;
>  
> +	cmm_barrier();
>  	tmp = URCU_TLS(rcu_reader).ctr;
> -	/*
> -	 * Finish using rcu before decrementing the pointer.
> -	 * See smp_mb_master().
> -	 */
> +	_rcu_read_lock_help(tmp);
> +}
> +
> +/*
> + * This is a helper function for _rcu_read_unlock().
> + *
> + * The first smp_mb_slave() call ensures that the critical section is
> + * seen to preced the store to rcu_reader.ctr.
> + * The second smp_mb_slave() call ensures that we write to rcu_reader.ctr
> + * before reading the update-side futex.
> + */
> +static inline void _rcu_read_unlock_help(unsigned long tmp)
> +{
>  	if (caa_likely((tmp & RCU_GP_CTR_NEST_MASK) == RCU_GP_COUNT)) {
>  		smp_mb_slave(RCU_MB_GROUP);
>  		_CMM_STORE_SHARED(URCU_TLS(rcu_reader).ctr, URCU_TLS(rcu_reader).ctr - RCU_GP_COUNT);
> -		/* write URCU_TLS(rcu_reader).ctr before read futex */
>  		smp_mb_slave(RCU_MB_GROUP);
>  		wake_up_gp();
> -	} else {
> +	} else
>  		_CMM_STORE_SHARED(URCU_TLS(rcu_reader).ctr, URCU_TLS(rcu_reader).ctr - RCU_GP_COUNT);
> -	}
> +}
> +
> +/*
> + * Exit an RCU read-side crtical section.  Both this function and its
> + * helper are smaller than 10 lines of code, and are intended to be
> + * usable by non-LGPL code, as called out in LGPL.
> + */
> +static inline void _rcu_read_unlock(void)
> +{
> +	unsigned long tmp;
> +
> +	tmp = URCU_TLS(rcu_reader).ctr;
> +	_rcu_read_unlock_help(tmp);
>  	cmm_barrier();	/* Ensure the compiler does not reorder us with mutex */
>  }
>  
> 
> 
> _______________________________________________
> rp mailing list
> rp@svcs.cs.pdx.edu
> http://svcs.cs.pdx.edu/mailman/listinfo/rp
