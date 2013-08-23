From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC] adding into middle of RCU list
Date: Fri, 23 Aug 2013 11:07:10 -0400
Message-ID: <20130823150710.GA11162__17730.9041530409$1377272009$gmane$org@Krystal>
References: <20130822213318.49a57fa2@nehalam.linuxnetplumber.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VCtLe-0000ra-3Y
	for lttng-dev@lists.lttng.org; Fri, 23 Aug 2013 11:32:31 -0400
Content-Disposition: inline
In-Reply-To: <20130822213318.49a57fa2@nehalam.linuxnetplumber.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

Hi Stephen,

* Stephen Hemminger (stephen@networkplumber.org) wrote:
> I needed to add into the middle of an RCU list, does this make sense.
> 

Yes, it makes sense. I'm adding a couple of comments below,

> 
> 
> From a45892b0d49ac5fe449ba7e19c646cb17f7cee57 Mon Sep 17 00:00:00 2001
> From: Stephen Hemminger <stephen@networkplumber.org>
> Date: Thu, 22 Aug 2013 21:27:04 -0700
> Subject: [PATCH] Add list_splice_init_rcu to allow insertion into a RCU list
> 
> Simplified version of the version in kernel.
> ---
>  urcu/rculist.h |   32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/urcu/rculist.h b/urcu/rculist.h
> index 1fd2df3..2e8a5a0 100644
> --- a/urcu/rculist.h
> +++ b/urcu/rculist.h
> @@ -72,6 +72,38 @@ void cds_list_del_rcu(struct cds_list_head *elem)
>  	CMM_STORE_SHARED(elem->prev->next, elem->next);
>  }
>  
> +
> +/**
> + * Splice an RCU-protected list into an existing list.
> + *
> + * Note that this function blocks in synchronize_rcu()
> + *
> + * Important note: this function is not called concurrently

is not -> should not be

> + *       with other updates to the list.

We might also want to start documenting the parameters in the list
headers, since it's unclear to someone who want to use the API which of
list and head is the list we want to splice, and which is the target,
e.g.:

 * @list: RCU-protected list to splice into @head.
 * @head: existing and initialized list to splice into.

We might want to state more clearly that @head can be any node within a
target list, including the list head.

> + */
> +static inline void caa_list_splice_init_rcu(struct cds_list_head *list,
> +					    struct cds_list_head *head)
> +{
> +	struct cds_list_head *first = list->next;
> +	struct cds_list_head *last = list->prev;
> +	struct cds_list_head *at = head->next;
> +
> +	if (cds_list_empty(list))
> +		return;
> +
> +	/* "first" and "last" tracking list, so initialize it. */
> +	CDS_INIT_LIST_HEAD(list);
> +
> +	/* Wait for any readers to finish using the list before splicing */
> +	synchronize_rcu();
> +
> +	/* Readers are finished with the source list, so perform splice. */
> +	last->next = at;
> +	rcu_assign_pointer(head->next, first);
> +	first->prev = head;
> +	at->prev = last;
> +}

Comment about style for LGPL headers: we really want to keep the
functions at 10 lines or less, otherwise they will need to be moved into
a library call or split into two static inline functions. So here, I
recommend moving the comments into the comment above the function, and
split the part starting at "last->next = at;" (4 lines) into a helper
function. Along with merging the 3 lines of local variables declaration
into 2, and removing empty white spaces and comments, we should be able
to fit this in 10 lines for caa_list_splice_init_rcu().

Thoughts ?

Thanks,

Mathieu



> +
>  /*
>   * Iteration through all elements of the list must be done while rcu_read_lock()
>   * is held.
> -- 
> 1.7.10.4
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
