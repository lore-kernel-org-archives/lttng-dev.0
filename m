From: Dmitri Shubin <sbn@tbricks.com>
Subject: Typo in urcu_qsbr.h ?
Date: Tue, 08 Oct 2013 12:09:37 +0400
Message-ID: <5253BDC1.2000506__10868.8745917336$1381236523$gmane$org@tbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx.tbricks.com ([212.247.19.44])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <sbn@tbricks.com>) id 1VTSMR-00056r-Ur
	for lttng-dev@lists.lttng.org; Tue, 08 Oct 2013 04:09:46 -0400
Received: from [10.200.144.43] (HELO mx2.tbricks.com)
	by mx.tbricks.com (CommuniGate Pro SMTP 5.2.20)
	with ESMTP id 4772989 for lttng-dev@lists.lttng.org;
	Tue, 08 Oct 2013 10:09:37 +0200
Received: from sbn.spb.tbricks.com (account sbn@tbricks.com [10.200.145.79]
	verified) by mx2.tbricks.com (CommuniGate Pro SMTP 5.2.20)
	with ESMTPSA id 6204463 for lttng-dev@lists.lttng.org;
	Tue, 08 Oct 2013 12:09:37 +0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

In urcu_qsbr.h I can see the following

     85  /*
     86   * QSBR read lock/unlock are guaranteed to be no-ops. 
Therefore, we expose them
     87   * in the LGPL header for any code to use. However, the debug 
version is not
     88   * nops and may contain sanity checks. To activate it, 
applications must be
     89   * recompiled with -DRCU_DEBUG (even non-LGPL/GPL 
applications). This is the
     90   * best trade-off between license/performance/code triviality and
     91   * library debugging & tracing features we could come up with.
     92   */
     93
     94  #if (!defined(BUILD_QSBR_LIB) && defined(RCU_DEBUG))
     95
     96  static inline void rcu_read_lock(void)
     97  {
     98  }
     99
    100  static inline void rcu_read_unlock(void)
    101  {
    102  }
    103
    104  #else /* !RCU_DEBUG */
    105
    106  extern void rcu_read_lock(void);
    107  extern void rcu_read_unlock(void);
    108
    109  #endif /* !RCU_DEBUG */

Shouldn't the condition in line 94 actually be

     94  #if (!defined(BUILD_QSBR_LIB) && !defined(RCU_DEBUG))

So when RCU_DEBUG is _not_ defined we get static inlines for 
rcu_read_{,un}lock() ?

Thanks!
