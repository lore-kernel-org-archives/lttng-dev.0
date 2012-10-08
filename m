From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [URCU PATCH 3/3] call_rcu: use wfcqueue,
	eliminate	false-sharing
Date: Mon, 8 Oct 2012 10:49:16 -0400
Message-ID: <20121008144916.GA29352__47235.0095319145$1349707826$gmane$org@Krystal>
References: <20121002141307.GA4057@Krystal> <20121002141638.GD4057@Krystal>
	<507243E9.8010604@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TLEdy-0004mb-Om
	for lttng-dev@lists.lttng.org; Mon, 08 Oct 2012 10:49:18 -0400
Content-Disposition: inline
In-Reply-To: <507243E9.8010604@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: Lai Jiangshan <eag0628@gmail.com>, lttng-dev@lists.lttng.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

* Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> On 10/02/2012 10:16 PM, Mathieu Desnoyers wrote:
> > Eliminate false-sharing between call_rcu (enqueuer) and worker threads
> > on the queue head and tail.
> > 
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > ---
> > diff --git a/tests/Makefile.am b/tests/Makefile.am
> > index 81718bb..c92bbe6 100644
> > --- a/tests/Makefile.am
> > +++ b/tests/Makefile.am
> > @@ -30,14 +30,14 @@ if COMPAT_FUTEX
> >  COMPAT+=$(top_srcdir)/compat_futex.c
> >  endif
> >  
> > -URCU=$(top_srcdir)/urcu.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfqueue.c $(COMPAT)
> > -URCU_QSBR=$(top_srcdir)/urcu-qsbr.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfqueue.c $(COMPAT)
> > +URCU=$(top_srcdir)/urcu.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfcqueue.c $(COMPAT)
> > +URCU_QSBR=$(top_srcdir)/urcu-qsbr.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfcqueue.c $(COMPAT)
> >  # URCU_MB uses urcu.c but -DRCU_MB must be defined
> > -URCU_MB=$(top_srcdir)/urcu.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfqueue.c $(COMPAT)
> > +URCU_MB=$(top_srcdir)/urcu.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfcqueue.c $(COMPAT)
> >  # URCU_SIGNAL uses urcu.c but -DRCU_SIGNAL must be defined
> > -URCU_SIGNAL=$(top_srcdir)/urcu.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfqueue.c $(COMPAT)
> > -URCU_BP=$(top_srcdir)/urcu-bp.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfqueue.c $(COMPAT)
> > -URCU_DEFER=$(top_srcdir)/urcu.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfqueue.c $(COMPAT)
> > +URCU_SIGNAL=$(top_srcdir)/urcu.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfcqueue.c $(COMPAT)
> > +URCU_BP=$(top_srcdir)/urcu-bp.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfcqueue.c $(COMPAT)
> > +URCU_DEFER=$(top_srcdir)/urcu.c $(top_srcdir)/urcu-pointer.c $(top_srcdir)/wfcqueue.c $(COMPAT)
> >  
> >  URCU_COMMON_LIB=$(top_builddir)/liburcu-common.la
> >  URCU_LIB=$(top_builddir)/liburcu.la
> > diff --git a/urcu-call-rcu-impl.h b/urcu-call-rcu-impl.h
> > index 13b24ff..cf65992 100644
> > --- a/urcu-call-rcu-impl.h
> > +++ b/urcu-call-rcu-impl.h
> > @@ -21,6 +21,7 @@
> >   */
> >  
> >  #define _GNU_SOURCE
> > +#define _LGPL_SOURCE
> >  #include <stdio.h>
> >  #include <pthread.h>
> >  #include <signal.h>
> > @@ -35,7 +36,7 @@
> >  #include <sched.h>
> >  
> >  #include "config.h"
> > -#include "urcu/wfqueue.h"
> > +#include "urcu/wfcqueue.h"
> >  #include "urcu-call-rcu.h"
> >  #include "urcu-pointer.h"
> >  #include "urcu/list.h"
> > @@ -46,7 +47,14 @@
> >  /* Data structure that identifies a call_rcu thread. */
> >  
> >  struct call_rcu_data {
> > -	struct cds_wfq_queue cbs;
> > +	/*
> > +	 * Align the tail on cache line size to eliminate false-sharing
> > +	 * with head.
> > +	 */
> > +	struct cds_wfcq_tail __attribute__((aligned(CAA_CACHE_LINE_SIZE))) cbs_tail;
> > +	/* Alignment on cache line size will add padding here */
> > +
> > +	struct cds_wfcq_head cbs_head;
> 
> 
> wrong here. In this code, cbs_tail and cbs_head are in the same cache line.
> 
> ---
> 
> struct call_rcu_data {
> 	struct cds_wfcq_tail cbs_tail;
> 	struct cds_wfcq_head __attribute__((aligned(CAA_CACHE_LINE_SIZE))) cbs_head;
> 	/* other fields, can move some fields up to use the room between tail and head */
> };
> 
> # cat test.c
> 
> struct a {
> 	int __attribute__((aligned(64))) i;
> 	int j;
> };
> struct b {
> 	int i;
> 	int __attribute__((aligned(64))) j;
> };
> 
> void main(void)
> {
> 	printf("%d,%d\n", sizeof(struct a), sizeof(struct b));
> }
> 
> # ./a.out
> 64,128
> 

Good point! While we are there, I notice that the "qlen" count, kept for
debugging, is causing false-sharing too. I wonder if we should split
this counter in two counters: nr_enqueue and nr_dequeue, which would sit
in two different cache lines ? It's mainly Paul who cares about this
counter. Thoughts ?

Here is the fix to the problem you noticed above:

commit b9f893b69fbc31baea418794938f4eb74cc4923a
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Oct 8 10:44:38 2012 -0400

    Fix urcu-call-rcu-impl.h: false-sharing
    
    > >  struct call_rcu_data {
    > > -   struct cds_wfq_queue cbs;
    > > +   /*
    > > +    * Align the tail on cache line size to eliminate false-sharing
    > > +    * with head.
    > > +    */
    > > +   struct cds_wfcq_tail __attribute__((aligned(CAA_CACHE_LINE_SIZE))) cbs_tail;
    > > +   /* Alignment on cache line size will add padding here */
    > > +
    > > +   struct cds_wfcq_head cbs_head;
    >
    >
    > wrong here. In this code, cbs_tail and cbs_head are in the same cache line.
    
    Reported-by: Lai Jiangshan <laijs@cn.fujitsu.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks!

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
