From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH urcu 2/2] wfcqueue: add C++
	compatibility API
Date: Tue, 8 Mar 2016 09:11:23 -0800
Message-ID: <20160308171123.GS3577__35823.5921863981$1457457166$gmane$org@linux.vnet.ibm.com>
References: <1457397224-10952-1-git-send-email-mathieu.desnoyers@efficios.com>
 <1457397224-10952-2-git-send-email-mathieu.desnoyers@efficios.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e17.ny.us.ibm.com ([129.33.205.207])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <paulmck@linux.vnet.ibm.com>) id 1adLAM-0001Rz-OT
 for lttng-dev@lists.lttng.org; Tue, 08 Mar 2016 12:11:28 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
 Tue, 8 Mar 2016 12:11:21 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 7721FC90057
 for <lttng-dev@lists.lttng.org>; Tue,  8 Mar 2016 12:11:14 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u28HBHmo15859738
 for <lttng-dev@lists.lttng.org>; Tue, 8 Mar 2016 17:11:17 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u28HBGQS017331
 for <lttng-dev@lists.lttng.org>; Tue, 8 Mar 2016 12:11:17 -0500
Content-Disposition: inline
In-Reply-To: <1457397224-10952-2-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu, Lai Jiangshan <jiangshanlai@gmail.com>
List-Id: lttng-dev@lists.lttng.org

On Mon, Mar 07, 2016 at 07:33:44PM -0500, Mathieu Desnoyers wrote:
> Introduce __cds_wfcq_head_cast and cds_wfcq_head_cast for compability
> of wfcqueue with c++. Those are effect-less in C, where transparent
> unions are supported. However, in C++, those transform struct
> cds_wfcq_head and struct __cds_wfcq_head pointers to
> cds_wfcq_head_ptr_t.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Good stuff!!!

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> ---
>  urcu/static/wfcqueue.h | 16 +++++++++-------
>  urcu/wfcqueue.h        | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 7 deletions(-)
> 
> diff --git a/urcu/static/wfcqueue.h b/urcu/static/wfcqueue.h
> index 7c9d548..4ababbf 100644
> --- a/urcu/static/wfcqueue.h
> +++ b/urcu/static/wfcqueue.h
> @@ -257,7 +257,7 @@ ___cds_wfcq_first(cds_wfcq_head_ptr_t u_head,
>  	struct __cds_wfcq_head *head = u_head._h;
>  	struct cds_wfcq_node *node;
> 
> -	if (_cds_wfcq_empty(head, tail))
> +	if (_cds_wfcq_empty(__cds_wfcq_head_cast(head), tail))
>  		return NULL;
>  	node = ___cds_wfcq_node_sync_next(&head->node, blocking);
>  	/* Load head->node.next before loading node's content */
> @@ -375,7 +375,7 @@ ___cds_wfcq_dequeue_with_state(cds_wfcq_head_ptr_t u_head,
>  	if (state)
>  		*state = 0;
> 
> -	if (_cds_wfcq_empty(head, tail)) {
> +	if (_cds_wfcq_empty(__cds_wfcq_head_cast(head), tail)) {
>  		return NULL;
>  	}
> 
> @@ -509,7 +509,7 @@ ___cds_wfcq_splice(
>  	 * Initial emptiness check to speed up cases where queue is
>  	 * empty: only require loads to check if queue is empty.
>  	 */
> -	if (_cds_wfcq_empty(src_q_head, src_q_tail))
> +	if (_cds_wfcq_empty(__cds_wfcq_head_cast(src_q_head), src_q_tail))
>  		return CDS_WFCQ_RET_SRC_EMPTY;
> 
>  	for (;;) {
> @@ -539,7 +539,8 @@ ___cds_wfcq_splice(
>  	 * Append the spliced content of src_q into dest_q. Does not
>  	 * require mutual exclusion on dest_q (wait-free).
>  	 */
> -	if (___cds_wfcq_append(dest_q_head, dest_q_tail, head, tail))
> +	if (___cds_wfcq_append(__cds_wfcq_head_cast(dest_q_head), dest_q_tail,
> +			head, tail))
>  		return CDS_WFCQ_RET_DEST_NON_EMPTY;
>  	else
>  		return CDS_WFCQ_RET_DEST_EMPTY;
> @@ -599,7 +600,8 @@ _cds_wfcq_dequeue_with_state_blocking(struct cds_wfcq_head *head,
>  	struct cds_wfcq_node *retval;
> 
>  	_cds_wfcq_dequeue_lock(head, tail);
> -	retval = ___cds_wfcq_dequeue_with_state_blocking(head, tail, state);
> +	retval = ___cds_wfcq_dequeue_with_state_blocking(cds_wfcq_head_cast(head),
> +			tail, state);
>  	_cds_wfcq_dequeue_unlock(head, tail);
>  	return retval;
>  }
> @@ -638,8 +640,8 @@ _cds_wfcq_splice_blocking(
>  	enum cds_wfcq_ret ret;
> 
>  	_cds_wfcq_dequeue_lock(src_q_head, src_q_tail);
> -	ret = ___cds_wfcq_splice_blocking(dest_q_head, dest_q_tail,
> -			src_q_head, src_q_tail);
> +	ret = ___cds_wfcq_splice_blocking(cds_wfcq_head_cast(dest_q_head), dest_q_tail,
> +			cds_wfcq_head_cast(src_q_head), src_q_tail);
>  	_cds_wfcq_dequeue_unlock(src_q_head, src_q_tail);
>  	return ret;
>  }
> diff --git a/urcu/wfcqueue.h b/urcu/wfcqueue.h
> index c0bb289..ec86032 100644
> --- a/urcu/wfcqueue.h
> +++ b/urcu/wfcqueue.h
> @@ -74,6 +74,7 @@ struct cds_wfcq_head {
>  	pthread_mutex_t lock;
>  };
> 
> +#ifndef __cplusplus
>  /*
>   * The transparent union allows calling functions that work on both
>   * struct cds_wfcq_head and struct __cds_wfcq_head on any of those two
> @@ -84,6 +85,45 @@ typedef union {
>  	struct cds_wfcq_head *h;
>  } __attribute__((__transparent_union__)) cds_wfcq_head_ptr_t;
> 
> +/*
> + * This static inline is only present for compatibility with C++. It is
> + * effect-less in C.
> + */
> +static inline struct __cds_wfcq_head *__cds_wfcq_head_cast(struct __cds_wfcq_head *head)
> +{
> +	return head;
> +}
> +
> +/*
> + * This static inline is only present for compatibility with C++. It is
> + * effect-less in C.
> + */
> +static inline struct cds_wfcq_head *cds_wfcq_head_cast(struct cds_wfcq_head *head)
> +{
> +	return head;
> +}
> +#else /* #ifndef __cplusplus */
> +
> +/* C++ ignores transparent union. */
> +typedef union {
> +	struct __cds_wfcq_head *_h;
> +	struct cds_wfcq_head *h;
> +} cds_wfcq_head_ptr_t;
> +
> +/* C++ ignores transparent union. Requires an explicit conversion. */
> +static inline cds_wfcq_head_ptr_t __cds_wfcq_head_cast(struct __cds_wfcq_head *head)
> +{
> +	cds_wfcq_head_ptr_t ret = { ._h = head };
> +	return ret;
> +}
> +/* C++ ignores transparent union. Requires an explicit conversion. */
> +static inline cds_wfcq_head_ptr_t cds_wfcq_head_cast(struct cds_wfcq_head *head)
> +{
> +	cds_wfcq_head_ptr_t ret = { .h = head };
> +	return ret;
> +}
> +#endif /* #else #ifndef __cplusplus */
> +
>  struct cds_wfcq_tail {
>  	struct cds_wfcq_node *p;
>  };
> -- 
> 2.1.4
> 
