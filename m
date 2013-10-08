From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Typo in urcu_qsbr.h ?
Date: Tue, 8 Oct 2013 13:26:33 +0000 (UTC)
Message-ID: <581636879.35810.1381238793937.JavaMail.zimbra__37450.6421074786$1381238865$gmane$org@efficios.com>
References: <5253BDC1.2000506@tbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VTXJA-00045Z-4F
	for lttng-dev@lists.lttng.org; Tue, 08 Oct 2013 09:26:45 -0400
In-Reply-To: <5253BDC1.2000506@tbricks.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Dmitri Shubin <sbn@tbricks.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Dmitri Shubin" <sbn@tbricks.com>
> To: lttng-dev@lists.lttng.org
> Sent: Tuesday, October 8, 2013 4:09:37 AM
> Subject: [lttng-dev] Typo in urcu_qsbr.h ?
> 
> Hi,
> 
> In urcu_qsbr.h I can see the following
> 
>      85  /*
>      86   * QSBR read lock/unlock are guaranteed to be no-ops.
> Therefore, we expose them
>      87   * in the LGPL header for any code to use. However, the debug
> version is not
>      88   * nops and may contain sanity checks. To activate it,
> applications must be
>      89   * recompiled with -DRCU_DEBUG (even non-LGPL/GPL
> applications). This is the
>      90   * best trade-off between license/performance/code triviality and
>      91   * library debugging & tracing features we could come up with.
>      92   */
>      93
>      94  #if (!defined(BUILD_QSBR_LIB) && defined(RCU_DEBUG))
>      95
>      96  static inline void rcu_read_lock(void)
>      97  {
>      98  }
>      99
>     100  static inline void rcu_read_unlock(void)
>     101  {
>     102  }
>     103
>     104  #else /* !RCU_DEBUG */
>     105
>     106  extern void rcu_read_lock(void);
>     107  extern void rcu_read_unlock(void);
>     108
>     109  #endif /* !RCU_DEBUG */
> 
> Shouldn't the condition in line 94 actually be
> 
>      94  #if (!defined(BUILD_QSBR_LIB) && !defined(RCU_DEBUG))
> 
> So when RCU_DEBUG is _not_ defined we get static inlines for
> rcu_read_{,un}lock() ?

Indeed! Commit pushed:

commit d47b05cb05b91bb9679d127c51bc4beac12b899d
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Tue Oct 8 09:23:10 2013 -0400

    Fix: urcu-qsbr: reversed logic on RCU_DEBUG
    
    * Dmitri Shubin <sbn@tbricks.com> wrote:
    > Shouldn't the condition in line 94 actually be
    >
    >      94  #if (!defined(BUILD_QSBR_LIB) && !defined(RCU_DEBUG))
    >
    > So when RCU_DEBUG is _not_ defined we get static inlines for
    > rcu_read_{,un}lock() ?
    
    Indeed!
    
    Reported-by: Dmitri Shubin <sbn@tbricks.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks for reporting!

Mathieu


> 
> Thanks!
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
