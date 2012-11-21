From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: [PATCH 01/16] Fix: wfcqueue nonblocking dequeue
Date: Wed, 21 Nov 2012 16:07:54 +0800
Message-ID: <50AC8BDA.9080309__43286.335891071$1353485150$gmane$org@cn.fujitsu.com>
References: <1353440429-19223-1-git-send-email-mathieu.desnoyers@efficios.com>
	<1353440429-19223-2-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1Tb5J1-0007NI-TI
	for lttng-dev@lists.lttng.org; Wed, 21 Nov 2012 03:05:12 -0500
In-Reply-To: <1353440429-19223-2-git-send-email-mathieu.desnoyers@efficios.com>
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

On 11/21/2012 03:40 AM, Mathieu Desnoyers wrote:
> Failures were not handled in the nonblocking dequeue implementation.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  urcu/static/wfcqueue.h |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/urcu/static/wfcqueue.h b/urcu/static/wfcqueue.h
> index 8733771..a284b58 100644
> --- a/urcu/static/wfcqueue.h
> +++ b/urcu/static/wfcqueue.h
> @@ -312,6 +312,8 @@ ___cds_wfcq_dequeue(struct cds_wfcq_head *head,
>  		return NULL;
>  
>  	node = ___cds_wfcq_node_sync_next(&head->node, blocking);
> +	if (!blocking && node == CDS_WFCQ_WOULDBLOCK)
> +		return CDS_WFCQ_WOULDBLOCK;
>  
>  	if ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
>  		/*
> @@ -332,6 +334,15 @@ ___cds_wfcq_dequeue(struct cds_wfcq_head *head,
>  		if (uatomic_cmpxchg(&tail->p, node, &head->node) == node)
>  			return node;

Is it this simpler?
we had just loaded node->next via "if ((next = CMM_LOAD_SHARED(node->next)) == NULL)"


+		if (!blocking)
+			return CDS_WFCQ_WOULDBLOCK

>  		next = ___cds_wfcq_node_sync_next(node, blocking);

and remove the following.

> +		/*
> +		 * In nonblocking mode, if we would need to block to
> +		 * get node's next, set the head next node pointer
> +		 * (currently NULL) back to its original value.
> +		 */
> +		if (!blocking && next == CDS_WFCQ_WOULDBLOCK) {
> +			head->node.next = node;
> +			return CDS_WFCQ_WOULDBLOCK;
> +		}
>  	}
>  
>  	/*
