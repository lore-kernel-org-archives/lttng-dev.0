From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH urcu] wfstack: implement mutex-free wfstack
 with transparent union
Date: Mon, 1 Sep 2014 14:00:56 +0000 (UTC)
Message-ID: <1769347096.14758.1409580056702.JavaMail.zimbra__1790.41991145841$1409579990$gmane$org@efficios.com>
References: <20140818050254.GA13470@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XOS7v-0006nu-8f
 for lttng-dev@lists.lttng.org; Mon, 01 Sep 2014 09:58:41 -0400
In-Reply-To: <20140818050254.GA13470@dcvr.yhbt.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Eric Wong <normalperson@yhbt.net>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

Hi Eric,

Good idea to do it also for wfstack.

A few comments below,

----- Original Message -----
> From: "Eric Wong" <normalperson@yhbt.net>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "Lai Jiangshan"
> <laijs@cn.fujitsu.com>
> Sent: Monday, August 18, 2014 1:02:54 AM
> Subject: [PATCH urcu] wfstack: implement mutex-free wfstack with transparent union
> 
> This saves space for users who use alternative synchronization
> mechanisms.
> 
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Lai Jiangshan <laijs@cn.fujitsu.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  urcu/static/wfstack.h | 18 +++++++++++++++---
>  urcu/wfstack.h        | 23 +++++++++++++++++++++--
>  wfstack.c             |  9 +++++++--
>  3 files changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/urcu/static/wfstack.h b/urcu/static/wfstack.h
> index db0d5b8..eb12f37 100644
> --- a/urcu/static/wfstack.h
> +++ b/urcu/static/wfstack.h
> @@ -77,6 +77,14 @@ void _cds_wfs_node_init(struct cds_wfs_node *node)
>  }
>  
>  /*
> + * __cds_wfs_init: initialize wait-free stack.
> + */
> +static inline void ___cds_wfs_init(struct __cds_wfs_stack *s)
> +{
> +	s->head = CDS_WFS_END;
> +}
> +
> +/*
>   * cds_wfs_init: initialize wait-free stack.
>   */
>  static inline
> @@ -99,8 +107,10 @@ static inline bool ___cds_wfs_end(void *node)
>   *
>   * No memory barrier is issued. No mutual exclusion is required.
>   */
> -static inline bool _cds_wfs_empty(struct cds_wfs_stack *s)
> +static inline bool _cds_wfs_empty(cds_wfs_stack_ptr_t u_stack)
>  {
> +	struct __cds_wfs_stack *s = u_stack._s;
> +
>  	return ___cds_wfs_end(CMM_LOAD_SHARED(s->head));
>  }
>  
> @@ -114,8 +124,9 @@ static inline bool _cds_wfs_empty(struct cds_wfs_stack
> *s)
>   * Returns non-zero otherwise.
>   */
>  static inline
> -int _cds_wfs_push(struct cds_wfs_stack *s, struct cds_wfs_node *node)
> +int _cds_wfs_push(cds_wfs_stack_ptr_t u_stack, struct cds_wfs_node *node)
>  {
> +	struct __cds_wfs_stack *s = u_stack._s;
>  	struct cds_wfs_head *old_head, *new_head;
>  
>  	assert(node->next == NULL);
> @@ -269,8 +280,9 @@ ___cds_wfs_pop_nonblocking(struct cds_wfs_stack *s)
>   */
>  static inline
>  struct cds_wfs_head *
> -___cds_wfs_pop_all(struct cds_wfs_stack *s)
> +___cds_wfs_pop_all(cds_wfs_stack_ptr_t u_stack)
>  {
> +	struct __cds_wfs_stack *s = u_stack._s;
>  	struct cds_wfs_head *head;
>  
>  	/*
> diff --git a/urcu/wfstack.h b/urcu/wfstack.h
> index fc0b44b..8d6f22c 100644
> --- a/urcu/wfstack.h
> +++ b/urcu/wfstack.h
> @@ -83,11 +83,25 @@ struct cds_wfs_head {
>  	struct cds_wfs_node node;
>  };
>  
> +struct __cds_wfs_stack {
> +	struct cds_wfs_head *head;
> +};
> +
>  struct cds_wfs_stack {
>  	struct cds_wfs_head *head;
>  	pthread_mutex_t lock;
>  };
>  
> +/*
> + * The transparent union allows calling functions that work on both
> + * struct cds_wfcq_head and struct __cds_wfcq_head on any of those two

should be:  struct cds_wfs_stack and struct __cds_wfs_stack

Other than that, looks good! Can you send an updated version ?

Thanks,

Mathieu

> + * types.
> + */
> +typedef union __attribute__((__transparent_union__)) {
> +	struct __cds_wfs_stack *_s;
> +	struct cds_wfs_stack *s;
> +} cds_wfs_stack_ptr_t;
> +
>  #ifdef _LGPL_SOURCE
>  
>  #include <urcu/static/wfstack.h>
> @@ -136,11 +150,16 @@ extern void cds_wfs_node_init(struct cds_wfs_node
> *node);
>  extern void cds_wfs_init(struct cds_wfs_stack *s);
>  
>  /*
> + * __cds_wfs_init: initialize wait-free stack.
> + */
> +extern void __cds_wfs_init(struct __cds_wfs_stack *s);
> +
> +/*
>   * cds_wfs_empty: return whether wait-free stack is empty.
>   *
>   * No memory barrier is issued. No mutual exclusion is required.
>   */
> -extern bool cds_wfs_empty(struct cds_wfs_stack *s);
> +extern bool cds_wfs_empty(cds_wfs_stack_ptr_t u_stack);
>  
>  /*
>   * cds_wfs_push: push a node into the stack.
> @@ -151,7 +170,7 @@ extern bool cds_wfs_empty(struct cds_wfs_stack *s);
>   * Returns 0 if the stack was empty prior to adding the node.
>   * Returns non-zero otherwise.
>   */
> -extern int cds_wfs_push(struct cds_wfs_stack *s, struct cds_wfs_node *node);
> +extern int cds_wfs_push(cds_wfs_stack_ptr_t u_stack, struct cds_wfs_node
> *node);
>  
>  /*
>   * cds_wfs_pop_blocking: pop a node from the stack.
> diff --git a/wfstack.c b/wfstack.c
> index c8bd7e6..fec9e47 100644
> --- a/wfstack.c
> +++ b/wfstack.c
> @@ -38,6 +38,11 @@ void cds_wfs_init(struct cds_wfs_stack *s)
>  	_cds_wfs_init(s);
>  }
>  
> +void __cds_wfs_init(struct __cds_wfs_stack *s)
> +{
> +	___cds_wfs_init(s);
> +}
> +
>  bool cds_wfs_empty(struct cds_wfs_stack *s)
>  {
>  	return _cds_wfs_empty(s);
> @@ -112,7 +117,7 @@ struct cds_wfs_node *
>  	return ___cds_wfs_pop_with_state_nonblocking(s, state);
>  }
>  
> -struct cds_wfs_head *__cds_wfs_pop_all(struct cds_wfs_stack *s)
> +struct cds_wfs_head *__cds_wfs_pop_all(cds_wfs_stack_ptr_t u_stack)
>  {
> -	return ___cds_wfs_pop_all(s);
> +	return ___cds_wfs_pop_all(u_stack);
>  }
> --
> EW
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
