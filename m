From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] Fix: call_rcu_thread() affinity failure
Date: Mon, 29 Jun 2015 16:15:30 -0700
Message-ID: <20150629231530.GY3717__34040.9642587931$1435619799$gmane$org@linux.vnet.ibm.com>
References: <1435618594-16125-1-git-send-email-mathieu.desnoyers@efficios.com>
 <20150629230148.GW3717@linux.vnet.ibm.com>
 <1917360537.1139.1435619175624.JavaMail.zimbra@efficios.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e37.co.us.ibm.com ([32.97.110.158])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <paulmck@linux.vnet.ibm.com>) id 1Z9iH6-0001qD-3Z
 for lttng-dev@lists.lttng.org; Mon, 29 Jun 2015 19:15:44 -0400
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
 Mon, 29 Jun 2015 17:15:34 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 48A713E40041
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jun 2015 17:15:32 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5TNEn2a51839228
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jun 2015 16:14:49 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5TNFVhi004715
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jun 2015 17:15:32 -0600
Content-Disposition: inline
In-Reply-To: <1917360537.1139.1435619175624.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Mon, Jun 29, 2015 at 11:06:15PM +0000, Mathieu Desnoyers wrote:
> ----- On Jun 29, 2015, at 7:01 PM, Paul E. McKenney paulmck@linux.vnet.ibm.com wrote:
> 
> > On Mon, Jun 29, 2015 at 06:56:34PM -0400, Mathieu Desnoyers wrote:
> >> Make call_rcu_thread() affine itself more persistently
> >> 
> >> Currently, URCU simply fails if a call_rcu_thread() fails to affine
> >> itself. This is problematic when execution is constrained by cgroup
> >> and hotunplugged CPUs. This commit therefore makes call_rcu_thread()
> >> retry setting its affinity every 256 grace periods, but only if it
> >> detects that it migrated to a different CPU. Since sched_getcpu() is
> >> cheap on many architectures, this check is less costly than going
> >> through a system call.
> >> 
> >> Reported-by: Michael Jeanson <mjeanson@efficios.com>
> >> Suggested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > 
> > A couple of issues, but otherwise good.  (They might even be issues
> > with your code rather than my eyes, you never know!)
> 
> Your eyes are very good indeed. Fixing those 2 nits, and adding
> your Acked-by.

Very good!

That said, I would feel better about my eyes had they not inserted the
bug being fixed.  ;-)

							Thanx, Paul

> Thanks!
> 
> Mathieu
> 
> > 
> >							Thanx, Paul
> > 
> >> ---
> >>  urcu-call-rcu-impl.h | 36 +++++++++++++++++++++++++++++++-----
> >>  1 file changed, 31 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/urcu-call-rcu-impl.h b/urcu-call-rcu-impl.h
> >> index 5cc02d9..b82a59b 100644
> >> --- a/urcu-call-rcu-impl.h
> >> +++ b/urcu-call-rcu-impl.h
> >> @@ -45,6 +45,9 @@
> >>  #include "urcu/ref.h"
> >>  #include "urcu-die.h"
> >> 
> >> +#define SET_AFFINITY_CHECK_PERIOD		(1U << 8)	/* 256 */
> >> +#define SET_AFFINITY_CHECK_PERIOD_MASK		(SET_AFFINITY_CHECK_PERIOD - 1)
> >> +
> >>  /* Data structure that identifies a call_rcu thread. */
> >> 
> >>  struct call_rcu_data {
> >> @@ -62,6 +65,7 @@ struct call_rcu_data {
> >>  	unsigned long qlen; /* maintained for debugging. */
> >>  	pthread_t tid;
> >>  	int cpu_affinity;
> >> +	unsigned long gp_count;
> >>  	struct cds_list_head list;
> >>  } __attribute__((aligned(CAA_CACHE_LINE_SIZE)));
> >> 
> >> @@ -203,22 +207,42 @@ static void call_rcu_unlock(pthread_mutex_t *pmp)
> >>  		urcu_die(ret);
> >>  }
> >> 
> >> +/*
> >> + * Periodically retry setting CPU affinity if we migrate.
> >> + * Losing affinity can be caused by CPU hotunplug/hotplug, or by
> >> + * cpuset(7).
> >> + */
> >>  #if HAVE_SCHED_SETAFFINITY
> >>  static
> >>  int set_thread_cpu_affinity(struct call_rcu_data *crdp)
> >>  {
> >>  	cpu_set_t mask;
> >> +	int ret;
> >> 
> >>  	if (crdp->cpu_affinity < 0)
> >>  		return 0;
> >> +	if (++crdp->gp_count & SET_AFFINITY_CHECK_PERIOD_MASK)
> >> +		return 0;
> >> +	if (urcu_sched_getcpu() != crdp->cpu_affinity)
> > 
> > Don't we want "==" here instead of "!="?
> > 
> >> +		return 0;
> >> 
> >>  	CPU_ZERO(&mask);
> >>  	CPU_SET(crdp->cpu_affinity, &mask);
> >>  #if SCHED_SETAFFINITY_ARGS == 2
> >> -	return sched_setaffinity(0, &mask);
> >> +	ret = sched_setaffinity(0, &mask);
> >>  #else
> >> -	return sched_setaffinity(0, sizeof(mask), &mask);
> >> +	ret = sched_setaffinity(0, sizeof(mask), &mask);
> >>  #endif
> >> +	/*
> >> +	 * EINVAL is fine: can be caused by hotunplugged CPUs, or by
> >> +	 * cpuset(7). This is why we should always retry is we detect
> > 
> > s/is we detect/if we detect/
> > 
> >> +	 * migration.
> >> +	 */
> >> +	if (ret && errno == EINVAL) {
> >> +		ret = 0;
> >> +		errno = 0;
> >> +	}
> >> +	return ret;
> >>  }
> >>  #else
> >>  static
> >> @@ -275,10 +299,8 @@ static void *call_rcu_thread(void *arg)
> >>  	unsigned long cbcount;
> >>  	struct call_rcu_data *crdp = (struct call_rcu_data *) arg;
> >>  	int rt = !!(uatomic_read(&crdp->flags) & URCU_CALL_RCU_RT);
> >> -	int ret;
> >> 
> >> -	ret = set_thread_cpu_affinity(crdp);
> >> -	if (ret)
> >> +	if (set_thread_cpu_affinity(crdp))
> >>  		urcu_die(errno);
> >> 
> >>  	/*
> >> @@ -298,6 +320,9 @@ static void *call_rcu_thread(void *arg)
> >>  		struct cds_wfcq_node *cbs, *cbs_tmp_n;
> >>  		enum cds_wfcq_ret splice_ret;
> >> 
> >> +		if (set_thread_cpu_affinity(crdp))
> >> +			urcu_die(errno);
> >> +
> >>  		if (uatomic_read(&crdp->flags) & URCU_CALL_RCU_PAUSE) {
> >>  			/*
> >>  			 * Pause requested. Become quiescent: remove
> >> @@ -391,6 +416,7 @@ static void call_rcu_data_init(struct call_rcu_data **crdpp,
> >>  	crdp->flags = flags;
> >>  	cds_list_add(&crdp->list, &call_rcu_data_list);
> >>  	crdp->cpu_affinity = cpu_affinity;
> >> +	crdp->gp_count = 0;
> >>  	cmm_smp_mb();  /* Structure initialized before pointer is planted. */
> >>  	*crdpp = crdp;
> >>  	ret = pthread_create(&crdp->tid, NULL, call_rcu_thread, crdp);
> >> --
> >> 2.1.4
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
