From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH liburcu] urcu-bp: introduce
 urcu_bp_disable_sys_membarrier()
Date: Fri, 22 Nov 2019 12:02:58 -0500 (EST)
Message-ID: <173739689.937.1574442178071.JavaMail.zimbra__18101.0000103683$1574442193$gmane$org@efficios.com>
References: <20191122170040.23250-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 47KN6B6Vwkz1Rtx
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 12:02:58 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 993F93A640E
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 12:02:58 -0500 (EST)
In-Reply-To: <20191122170040.23250-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: paulmck <paulmck@kernel.org>, Norbert Lange <nolange79@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Nov 22, 2019, at 12:00 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Real-time applications with Xenomai threads wishing to use urcu-bp
> read-side within real-time threads require to disable use of the
> membarrier system call, relying on the fall-back based on regular
> memory barriers on the read-side instead. Allow disabling use of
> sys_membarrier before liburcu-bp's first use.

This last sentence should actually read:

Allow disabling use of sys_membarrier when there are no urcu-bp reader
threads present.

Thanks,

Mathieu

> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> include/urcu/urcu-bp.h | 12 ++++++++++++
> src/urcu-bp.c          | 38 +++++++++++++++++++++++++++++++++++---
> 2 files changed, 47 insertions(+), 3 deletions(-)
> 
> diff --git a/include/urcu/urcu-bp.h b/include/urcu/urcu-bp.h
> index 2ea17e6..bfab965 100644
> --- a/include/urcu/urcu-bp.h
> +++ b/include/urcu/urcu-bp.h
> @@ -157,6 +157,18 @@ extern void urcu_bp_after_fork_child(void);
> extern void urcu_bp_register_thread(void);
> 
> /*
> + * Require liburcu-bp to use the fallback (based on memory barriers on
> + * the read-side) rather than pairing the sys_membarrier system call in
> + * synchronize_rcu() with compiler barriers on the read-side. Should
> + * be invoked when there are no RCU reader threads present.
> + * Return 0 on success.
> + * Return -1, errno = EBUSY if there are RCU reader threads present.
> + * Return -1, errno = EINVAL if the library has been configured without
> + * the membarrier fallback support.
> + */
> +extern int urcu_bp_disable_sys_membarrier(void);
> +
> +/*
>  * In the bulletproof version, the following functions are no-ops.
>  */
> static inline void urcu_bp_unregister_thread(void)
> diff --git a/src/urcu-bp.c b/src/urcu-bp.c
> index 05efd97..4aaa3d6 100644
> --- a/src/urcu-bp.c
> +++ b/src/urcu-bp.c
> @@ -123,6 +123,8 @@ void __attribute__((destructor)) urcu_bp_exit(void);
> int urcu_bp_has_sys_membarrier;
> #endif
> 
> +static bool urcu_bp_sys_membarrier_is_disabled;
> +
> /*
>  * rcu_gp_lock ensures mutual exclusion between threads calling
>  * synchronize_rcu().
> @@ -607,6 +609,11 @@ void urcu_bp_thread_exit_notifier(void *rcu_key)
> 
> #ifdef CONFIG_RCU_FORCE_SYS_MEMBARRIER
> static
> +bool urcu_bp_force_sys_membarrier(void)
> +{
> +	return true;
> +}
> +static
> void urcu_bp_sys_membarrier_status(bool available)
> {
> 	if (!available)
> @@ -614,20 +621,45 @@ void urcu_bp_sys_membarrier_status(bool available)
> }
> #else
> static
> +bool urcu_bp_force_sys_membarrier(void)
> +{
> +	return false;
> +}
> +static
> void urcu_bp_sys_membarrier_status(bool available)
> {
> -	if (!available)
> -		return;
> -	urcu_bp_has_sys_membarrier = 1;
> +	urcu_bp_has_sys_membarrier = available;
> }
> #endif
> 
> +int urcu_bp_disable_sys_membarrier(void)
> +{
> +	mutex_lock(&rcu_registry_lock);
> +	if (!cds_list_empty(&registry)) {
> +		mutex_unlock(&rcu_registry_lock);
> +		errno = EBUSY;
> +		return -1;
> +	}
> +	mutex_unlock(&rcu_registry_lock);
> +	if (urcu_bp_force_sys_membarrier()) {
> +		errno = EINVAL;
> +		return -1;
> +	}
> +	mutex_lock(&init_lock);
> +	urcu_bp_sys_membarrier_is_disabled = true;
> +	urcu_bp_sys_membarrier_status(false);
> +	mutex_unlock(&init_lock);
> +	return 0;
> +}
> +
> static
> void urcu_bp_sys_membarrier_init(void)
> {
> 	bool available = false;
> 	int mask;
> 
> +	if (urcu_bp_sys_membarrier_is_disabled)
> +		return;
> 	mask = membarrier(MEMBARRIER_CMD_QUERY, 0);
> 	if (mask >= 0) {
> 		if (mask & MEMBARRIER_CMD_PRIVATE_EXPEDITED) {
> --
> 2.11.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
