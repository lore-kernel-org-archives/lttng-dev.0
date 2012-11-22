From: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: [PATCH 01/16] Fix: wfcqueue nonblocking dequeue
Date: Thu, 22 Nov 2012 16:37:23 +0800
Message-ID: <50ADE443.50904__23424.5719890625$1353573345$gmane$org@cn.fujitsu.com>
References: <1353440429-19223-1-git-send-email-mathieu.desnoyers@efficios.com>
	<1353440429-19223-2-git-send-email-mathieu.desnoyers@efficios.com>
	<50AC8BDA.9080309@cn.fujitsu.com> <20121121143716.GA21518@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <laijs@cn.fujitsu.com>) id 1TbSF2-0001vH-Hw
	for lttng-dev@lists.lttng.org; Thu, 22 Nov 2012 03:34:37 -0500
In-Reply-To: <20121121143716.GA21518@Krystal>
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

On 11/21/2012 10:37 PM, Mathieu Desnoyers wrote:
> * Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
>> On 11/21/2012 03:40 AM, Mathieu Desnoyers wrote:
>>> Failures were not handled in the nonblocking dequeue implementation.
>>>
>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> ---
>>>  urcu/static/wfcqueue.h |   11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/urcu/static/wfcqueue.h b/urcu/static/wfcqueue.h
>>> index 8733771..a284b58 100644
>>> --- a/urcu/static/wfcqueue.h
>>> +++ b/urcu/static/wfcqueue.h
>>> @@ -312,6 +312,8 @@ ___cds_wfcq_dequeue(struct cds_wfcq_head *head,
>>>  		return NULL;
>>>  
>>>  	node = ___cds_wfcq_node_sync_next(&head->node, blocking);
>>> +	if (!blocking && node == CDS_WFCQ_WOULDBLOCK)
>>> +		return CDS_WFCQ_WOULDBLOCK;
>>>  
>>>  	if ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
>>>  		/*
>>> @@ -332,6 +334,15 @@ ___cds_wfcq_dequeue(struct cds_wfcq_head *head,
>>>  		if (uatomic_cmpxchg(&tail->p, node, &head->node) == node)
>>>  			return node;
>>
>> Is it this simpler?
>> we had just loaded node->next via "if ((next = CMM_LOAD_SHARED(node->next)) == NULL)"
>>
>>
>> +		if (!blocking)
>> +			return CDS_WFCQ_WOULDBLOCK
>>
>>>  		next = ___cds_wfcq_node_sync_next(node, blocking);
>>
>> and remove the following.
> 
> So let's see. We have met the condition
>   "if ((next = CMM_LOAD_SHARED(node->next)) == NULL) {"
> 
> Therefore, it means that it appears, at that point, that the queue has
> only one node. So usually, after this test succeeds, we'll have to set
> the queue state to empty. There is only one case where this will not be
> done: if a concurrent enqueue adds a node between this test and the
> cmpxchg that follows. In that case, we'll notice this because cmpxchg
> fails, and instead of setting the queue to "empty", we'll simply wait
> for enqueue to complete adding the new node, and move head forward.
> 
> The approach you propose is to consider that if cmpxchg fails, we
> will very likely have to block. Well, that would skip a call to
> ___cds_wfcq_node_sync_next, and semantically would be still right,
> because the only way cmpxchg can fail is if the tail pointer is being
> changed concurrently, which would typically make us block.
> 
> However, we'd still need to perform "head->node.next = node;" before we
> return CDS_WFCQ_WOULDBLOCK, because _cds_wfcq_node_init() has already
> set the head next pointer to NULL, and we need to undo that.
> 

You are right,
I just proposed some noise which is not simple as I claimed.
sorry.

Thanks,
Lai

> 
>>
>>> +		/*
>>> +		 * In nonblocking mode, if we would need to block to
>>> +		 * get node's next, set the head next node pointer
>>> +		 * (currently NULL) back to its original value.
>>> +		 */
>>> +		if (!blocking && next == CDS_WFCQ_WOULDBLOCK) {
>>> +			head->node.next = node;
>>> +			return CDS_WFCQ_WOULDBLOCK;
>>> +		}
>>>  	}
>>>  
>>>  	/*
> 
