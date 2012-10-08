From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [rp] [URCU PATCH 0/3] wait-free concurrent
	queues	(wfcqueue)
Date: Mon, 8 Oct 2012 11:07:30 -0400
Message-ID: <20121008150729.GB29352__18371.9617118642$1349708888$gmane$org@Krystal>
References: <20121002141307.GA4057@Krystal>
	<20121003182846.GN2527@linux.vnet.ibm.com>
	<20121003210436.GB25090@Krystal> <5072499B.1050301@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TLEvc-0004yO-9s
	for lttng-dev@lists.lttng.org; Mon, 08 Oct 2012 11:07:32 -0400
Content-Disposition: inline
In-Reply-To: <5072499B.1050301@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: Lai Jiangshan <eag0628@gmail.com>, lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

* Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> On 10/04/2012 05:04 AM, Mathieu Desnoyers wrote:
> > * Paul E. McKenney (paulmck@linux.vnet.ibm.com) wrote:
> >> On Tue, Oct 02, 2012 at 10:13:07AM -0400, Mathieu Desnoyers wrote:
> >>> Implement wait-free concurrent queues, with a new API different from
> >>> wfqueue.h, which is already provided by Userspace RCU. The advantage of
> >>> splitting the head and tail objects of the queue into different
> >>> arguments is to allow these to sit on different cache-lines, thus
> >>> eliminating false-sharing, leading to a 2.3x speed increase.
> >>>
> >>> This API also introduces a "splice" operation, which moves all nodes
> >>> from one queue into another, and postpones the synchronization to either
> >>> dequeue or iteration on the list. The splice operation does not need to
> >>> touch every single node of the queue it moves them from. Moreover, the
> >>> splice operation only needs to ensure mutual exclusion with other
> >>> dequeuers, iterations, and splice operations from the list it splices
> >>> from, but acts as a simple enqueuer on the list it splices into (no
> >>> mutual exclusion needed for that list).
> >>>
> >>> Feedback is welcome,
> >>
> >> These look sane to me, though I must confess that the tail pointer
> >> referencing the node rather than the node's next pointer did throw
> >> me for a bit.  ;-)
> > 
> > Yes, this was originally introduced with Lai's original patch to
> > wfqueue, which I think is a nice simplification: it's pretty much the
> > same thing to use the last node address as tail rather than the address
> > of its first member (its next pointer address (_not_ value)). It ends up
> > being the same address in this case, but more interestingly, we don't
> > have to use a struct cds_wfcq_node ** type: a simple struct
> > cds_wfcq_node *  suffice.
> > 
> > Thanks Paul, I will therefore merge these 3 patches with your Acked-by.
> > 
> > Lai, you are welcome to provide improvements to this code against the
> > master branch. I will gladly consider any change you propose.
> > 
> 
> I did not remember that there is any improvement idea not included.
> The patchset is OK for me.

Great! Would you be OK if I commit the following patch ? Let me know if
you want me to put your signed-off-by on this (I can even put your email
as From if you like):


wfcqueue: update credits in patch documentation

Give credits to those responsible for the design and implementation of
commit 8ad4ce587f001ae026d5560ac509c2e48986130b, "wfcqueue: implement
concurrency-efficient queue", which happened through rounds of email and
patch exchanges.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/urcu/static/wfcqueue.h b/urcu/static/wfcqueue.h
index a989984..153143d 100644
--- a/urcu/static/wfcqueue.h
+++ b/urcu/static/wfcqueue.h
@@ -41,8 +41,10 @@ extern "C" {
 /*
  * Concurrent queue with wait-free enqueue/blocking dequeue.
  *
- * Inspired from half-wait-free/half-blocking queue implementation done by
- * Paul E. McKenney.
+ * This queue has been designed and implemented collaboratively by
+ * Mathieu Desnoyers and Lai Jiangshan. Inspired from
+ * half-wait-free/half-blocking queue implementation done by Paul E.
+ * McKenney.
  *
  * Mutual exclusion of __cds_wfcq_* API
  *
diff --git a/urcu/wfcqueue.h b/urcu/wfcqueue.h
index 5576cbf..940dc7d 100644
--- a/urcu/wfcqueue.h
+++ b/urcu/wfcqueue.h
@@ -37,8 +37,10 @@ extern "C" {
 /*
  * Concurrent queue with wait-free enqueue/blocking dequeue.
  *
- * Inspired from half-wait-free/half-blocking queue implementation done by
- * Paul E. McKenney.
+ * This queue has been designed and implemented collaboratively by
+ * Mathieu Desnoyers and Lai Jiangshan. Inspired from
+ * half-wait-free/half-blocking queue implementation done by Paul E.
+ * McKenney.
  */
 
 struct cds_wfcq_node {


> I think you can reimplement wfqueue via wfcqueue without cacheline opt.

Hrm, semantically this can indeed be done, but I fear that we might not
be strictly ABI-compatible with the old wfqueue. So I would be tempted
to leave the old wfqueue implementation as-is, and maybe deprecate it at
some point. Thoughts ?

Thanks!

Mathieu

> 
> Thanks,
> Lai

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
