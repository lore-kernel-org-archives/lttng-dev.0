From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 01/16] Fix: wfcqueue nonblocking dequeue
Date: Wed, 21 Nov 2012 09:37:16 -0500
Message-ID: <20121121143716.GA21518__47519.4428152919$1353508682$gmane$org@Krystal>
References: <1353440429-19223-1-git-send-email-mathieu.desnoyers@efficios.com>
	<1353440429-19223-2-git-send-email-mathieu.desnoyers@efficios.com>
	<50AC8BDA.9080309@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TbBQW-0002GF-OX
	for lttng-dev@lists.lttng.org; Wed, 21 Nov 2012 09:37:20 -0500
Content-Disposition: inline
In-Reply-To: <50AC8BDA.9080309@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alan Stern <stern@rowland.harvard.edu>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

* Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> On 11/21/2012 03:40 AM, Mathieu Desnoyers wrote:
> > Failures were not handled in the nonblocking dequeue implementation.
> > 
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > ---
> >  urcu/static/wfcqueue.h |   11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/urcu/static/wfcqueue.h b/urcu/static/wfcqueue.h
> > index 8733771..a284b58 100644
> > --- a/urcu/static/wfcqueue.h
> > +++ b/urcu/static/wfcqueue.h
> > @@ -312,6 +312,8 @@ ___cds_wfcq_dequeue(struct cds_wfcq_head *head,
> >  		return NULL;
> >  
> >  	node = ___cds_wfcq_node_sync_next(&head->node, blocking);
> > +	if (!blocking && node == CDS_WFCQ_WOULDBLOCK)
> > +		return CDS_WFCQ_WOULDBLOCK;
> >  
> >  	if ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
> >  		/*
> > @@ -332,6 +334,15 @@ ___cds_wfcq_dequeue(struct cds_wfcq_head *head,
> >  		if (uatomic_cmpxchg(&tail->p, node, &head->node) == node)
> >  			return node;
> 
> Is it this simpler?
> we had just loaded node->next via "if ((next = CMM_LOAD_SHARED(node->next)) == NULL)"
> 
> 
> +		if (!blocking)
> +			return CDS_WFCQ_WOULDBLOCK
> 
> >  		next = ___cds_wfcq_node_sync_next(node, blocking);
> 
> and remove the following.

So let's see. We have met the condition
  "if ((next = CMM_LOAD_SHARED(node->next)) == NULL) {"

Therefore, it means that it appears, at that point, that the queue has
only one node. So usually, after this test succeeds, we'll have to set
the queue state to empty. There is only one case where this will not be
done: if a concurrent enqueue adds a node between this test and the
cmpxchg that follows. In that case, we'll notice this because cmpxchg
fails, and instead of setting the queue to "empty", we'll simply wait
for enqueue to complete adding the new node, and move head forward.

The approach you propose is to consider that if cmpxchg fails, we
will very likely have to block. Well, that would skip a call to
___cds_wfcq_node_sync_next, and semantically would be still right,
because the only way cmpxchg can fail is if the tail pointer is being
changed concurrently, which would typically make us block.

However, we'd still need to perform "head->node.next = node;" before we
return CDS_WFCQ_WOULDBLOCK, because _cds_wfcq_node_init() has already
set the head next pointer to NULL, and we need to undo that.

Thoughts ?

Thanks,

Mathieu

> 
> > +		/*
> > +		 * In nonblocking mode, if we would need to block to
> > +		 * get node's next, set the head next node pointer
> > +		 * (currently NULL) back to its original value.
> > +		 */
> > +		if (!blocking && next == CDS_WFCQ_WOULDBLOCK) {
> > +			head->node.next = node;
> > +			return CDS_WFCQ_WOULDBLOCK;
> > +		}
> >  	}
> >  
> >  	/*

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
