From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH urcu] wfstack: implement nonblocking pop	and
	next
Date: Thu, 6 Dec 2012 16:06:20 -0500
Message-ID: <20121206210620.GA20971__16924.0255411298$1354828027$gmane$org@Krystal>
References: <20121205144431.GA1241@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TgieE-0002LX-2I
	for lttng-dev@lists.lttng.org; Thu, 06 Dec 2012 16:06:22 -0500
Content-Disposition: inline
In-Reply-To: <20121205144431.GA1241@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Lai Jiangshan <laijs@cn.fujitsu.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

I'll merge this patch into master, let me know if anything seems broken
and I'll do the appropriate follow-up.

Thanks,

Mathieu

> ---
> diff --git a/urcu/static/wfstack.h b/urcu/static/wfstack.h
> index 018a121..9bc9519 100644
> --- a/urcu/static/wfstack.h
> +++ b/urcu/static/wfstack.h
> @@ -137,7 +137,7 @@ int _cds_wfs_push(struct cds_wfs_stack *s, struct cds_wfs_node *node)
>   * Waiting for push to complete enqueue and return the next node.
>   */
>  static inline struct cds_wfs_node *
> -___cds_wfs_node_sync_next(struct cds_wfs_node *node)
> +___cds_wfs_node_sync_next(struct cds_wfs_node *node, int blocking)
>  {
>  	struct cds_wfs_node *next;
>  	int attempt = 0;
> @@ -146,6 +146,8 @@ ___cds_wfs_node_sync_next(struct cds_wfs_node *node)
>  	 * Adaptative busy-looping waiting for push to complete.
>  	 */
>  	while ((next = CMM_LOAD_SHARED(node->next)) == NULL) {
> +		if (!blocking)
> +			return CDS_WFS_WOULDBLOCK;
>  		if (++attempt >= CDS_WFS_ADAPT_ATTEMPTS) {
>  			poll(NULL, 0, CDS_WFS_WAIT);	/* Wait for 10ms */
>  			attempt = 0;
> @@ -157,6 +159,29 @@ ___cds_wfs_node_sync_next(struct cds_wfs_node *node)
>  	return next;
>  }
>  
> +static inline
> +struct cds_wfs_node *
> +___cds_wfs_pop(struct cds_wfs_stack *s, int blocking)
> +{
> +	struct cds_wfs_head *head, *new_head;
> +	struct cds_wfs_node *next;
> +
> +	for (;;) {
> +		head = CMM_LOAD_SHARED(s->head);
> +		if (___cds_wfs_end(head))
> +			return NULL;
> +		next = ___cds_wfs_node_sync_next(&head->node, blocking);
> +		if (!blocking && next == CDS_WFS_WOULDBLOCK)
> +			return CDS_WFS_WOULDBLOCK;
> +		new_head = caa_container_of(next, struct cds_wfs_head, node);
> +		if (uatomic_cmpxchg(&s->head, head, new_head) == head)
> +			return &head->node;
> +		if (!blocking)
> +			return CDS_WFS_WOULDBLOCK;
> +		/* busy-loop if head changed under us */
> +	}
> +}
> +
>  /*
>   * __cds_wfs_pop_blocking: pop a node from the stack.
>   *
> @@ -177,19 +202,20 @@ static inline
>  struct cds_wfs_node *
>  ___cds_wfs_pop_blocking(struct cds_wfs_stack *s)
>  {
> -	struct cds_wfs_head *head, *new_head;
> -	struct cds_wfs_node *next;
> +	return ___cds_wfs_pop(s, 1);
> +}
>  
> -	for (;;) {
> -		head = CMM_LOAD_SHARED(s->head);
> -		if (___cds_wfs_end(head))
> -			return NULL;
> -		next = ___cds_wfs_node_sync_next(&head->node);
> -		new_head = caa_container_of(next, struct cds_wfs_head, node);
> -		if (uatomic_cmpxchg(&s->head, head, new_head) == head)
> -			return &head->node;
> -		/* busy-loop if head changed under us */
> -	}
> +/*
> + * __cds_wfs_pop_nonblocking: pop a node from the stack.
> + *
> + * Same as __cds_wfs_pop_blocking, but returns CDS_WFS_WOULDBLOCK if
> + * it needs to block.
> + */
> +static inline
> +struct cds_wfs_node *
> +___cds_wfs_pop_nonblocking(struct cds_wfs_stack *s)
> +{
> +	return ___cds_wfs_pop(s, 0);
>  }
>  
>  /*
> @@ -303,6 +329,22 @@ _cds_wfs_first(struct cds_wfs_head *head)
>  	return &head->node;
>  }
>  
> +static inline struct cds_wfs_node *
> +___cds_wfs_next(struct cds_wfs_node *node, int blocking)
> +{
> +	struct cds_wfs_node *next;
> +
> +	next = ___cds_wfs_node_sync_next(node, blocking);
> +	/*
> +	 * CDS_WFS_WOULDBLOCK != CSD_WFS_END, so we can check for end
> +	 * even if ___cds_wfs_node_sync_next returns CDS_WFS_WOULDBLOCK,
> +	 * and still return CDS_WFS_WOULDBLOCK.
> +	 */
> +	if (___cds_wfs_end(next))
> +		return NULL;
> +	return next;
> +}
> +
>  /*
>   * cds_wfs_next_blocking: get next node of a popped stack.
>   *
> @@ -319,12 +361,20 @@ _cds_wfs_first(struct cds_wfs_head *head)
>  static inline struct cds_wfs_node *
>  _cds_wfs_next_blocking(struct cds_wfs_node *node)
>  {
> -	struct cds_wfs_node *next;
> +	return ___cds_wfs_next(node, 1);
> +}
>  
> -	next = ___cds_wfs_node_sync_next(node);
> -	if (___cds_wfs_end(next))
> -		return NULL;
> -	return next;
> +
> +/*
> + * cds_wfs_next_nonblocking: get next node of a popped stack.
> + *
> + * Same as cds_wfs_next_blocking, but returns CDS_WFS_WOULDBLOCK if it
> + * needs to block.
> + */
> +static inline struct cds_wfs_node *
> +_cds_wfs_next_nonblocking(struct cds_wfs_node *node)
> +{
> +	return ___cds_wfs_next(node, 0);
>  }
>  
>  #ifdef __cplusplus
> diff --git a/urcu/wfstack.h b/urcu/wfstack.h
> index 0e435ba..03fee8f 100644
> --- a/urcu/wfstack.h
> +++ b/urcu/wfstack.h
> @@ -58,6 +58,8 @@ extern "C" {
>   * synchronization.
>   */
>  
> +#define CDS_WFS_WOULDBLOCK	((void *) -1UL)
> +
>  /*
>   * struct cds_wfs_node is returned by __cds_wfs_pop, and also used as
>   * iterator on stack. It is not safe to dereference the node next
> @@ -184,6 +186,14 @@ extern struct cds_wfs_node *cds_wfs_first(struct cds_wfs_head *head);
>  extern struct cds_wfs_node *cds_wfs_next_blocking(struct cds_wfs_node *node);
>  
>  /*
> + * cds_wfs_next_nonblocking: get next node of a popped stack.
> + *
> + * Same as cds_wfs_next_blocking, but returns CDS_WFS_WOULDBLOCK if it
> + * needs to block.
> + */
> +extern struct cds_wfs_node *cds_wfs_next_nonblocking(struct cds_wfs_node *node);
> +
> +/*
>   * cds_wfs_pop_lock: lock stack pop-protection mutex.
>   */
>  extern void cds_wfs_pop_lock(struct cds_wfs_stack *s);
> @@ -212,6 +222,14 @@ extern void cds_wfs_pop_unlock(struct cds_wfs_stack *s);
>  extern struct cds_wfs_node *__cds_wfs_pop_blocking(struct cds_wfs_stack *s);
>  
>  /*
> + * __cds_wfs_pop_nonblocking: pop a node from the stack.
> + *
> + * Same as __cds_wfs_pop_blocking, but returns CDS_WFS_WOULDBLOCK if
> + * it needs to block.
> + */
> +extern struct cds_wfs_node *__cds_wfs_pop_nonblocking(struct cds_wfs_stack *s);
> +
> +/*
>   * __cds_wfs_pop_all: pop all nodes from a stack.
>   *
>   * __cds_wfs_pop_all does not require any synchronization with other
> diff --git a/wfstack.c b/wfstack.c
> index f0bae57..4ccb6b9 100644
> --- a/wfstack.c
> +++ b/wfstack.c
> @@ -68,6 +68,11 @@ struct cds_wfs_node *cds_wfs_next_blocking(struct cds_wfs_node *node)
>  	return _cds_wfs_next_blocking(node);
>  }
>  
> +struct cds_wfs_node *cds_wfs_next_nonblocking(struct cds_wfs_node *node)
> +{
> +	return _cds_wfs_next_nonblocking(node);
> +}
> +
>  void cds_wfs_pop_lock(struct cds_wfs_stack *s)
>  {
>  	_cds_wfs_pop_lock(s);
> @@ -83,6 +88,11 @@ struct cds_wfs_node *__cds_wfs_pop_blocking(struct cds_wfs_stack *s)
>  	return ___cds_wfs_pop_blocking(s);
>  }
>  
> +struct cds_wfs_node *__cds_wfs_pop_nonblocking(struct cds_wfs_stack *s)
> +{
> +	return ___cds_wfs_pop_nonblocking(s);
> +}
> +
>  struct cds_wfs_head *__cds_wfs_pop_all(struct cds_wfs_stack *s)
>  {
>  	return ___cds_wfs_pop_all(s);
> 
> -- 
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
