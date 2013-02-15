From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [rp] [PATCH urcu] rculfhash: add assertions on node
	alignment
Date: Thu, 14 Feb 2013 16:00:57 -0800
Message-ID: <20130215000057.GF2769__21070.1525481001$1360886529$gmane$org@linux.vnet.ibm.com>
References: <20130214161932.GA29790@Krystal>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paulmck@linux.vnet.ibm.com>) id 1U68jo-00042K-NY
	for lttng-dev@lists.lttng.org; Thu, 14 Feb 2013 19:01:12 -0500
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 14 Feb 2013 17:01:06 -0700
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 77CBD3E4004F
	for <lttng-dev@lists.lttng.org>; Thu, 14 Feb 2013 17:00:56 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	r1F013qm195294
	for <lttng-dev@lists.lttng.org>; Thu, 14 Feb 2013 17:01:04 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id r1F00wtp016284
	for <lttng-dev@lists.lttng.org>; Thu, 14 Feb 2013 17:01:02 -0700
Content-Disposition: inline
In-Reply-To: <20130214161932.GA29790@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, Stephen Hemminger <shemminger@vyatta.com>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

On Thu, Feb 14, 2013 at 11:19:33AM -0500, Mathieu Desnoyers wrote:
> I've had a report of someone running into issues with the RCU lock-free
> hash table by embedding the struct cds_lfht_node into a packed structure
> by mistake, thus not respecting alignment requirements stated in
> urcu/rculfhash.h. Assertions on "replace" and "add" operations should
> catch this, but I notice that we should add assertions on the
> REMOVAL_OWNER_FLAG to cover all possible misalignments.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Makes sense to me!

							Thanx, Paul

> ---
> diff --git a/rculfhash.c b/rculfhash.c
> index 8c3d621..e0be7df 100644
> --- a/rculfhash.c
> +++ b/rculfhash.c
> @@ -833,13 +833,16 @@ void _cds_lfht_gc_bucket(struct cds_lfht_node *bucket, struct cds_lfht_node *nod
> 
>  	assert(!is_bucket(bucket));
>  	assert(!is_removed(bucket));
> +	assert(!is_removal_owner(bucket));
>  	assert(!is_bucket(node));
>  	assert(!is_removed(node));
> +	assert(!is_removal_owner(node));
>  	for (;;) {
>  		iter_prev = bucket;
>  		/* We can always skip the bucket node initially */
>  		iter = rcu_dereference(iter_prev->next);
>  		assert(!is_removed(iter));
> +		assert(!is_removal_owner(iter));
>  		assert(iter_prev->reverse_hash <= node->reverse_hash);
>  		/*
>  		 * We should never be called with bucket (start of chain)
> @@ -860,6 +863,7 @@ void _cds_lfht_gc_bucket(struct cds_lfht_node *bucket, struct cds_lfht_node *nod
>  			iter = next;
>  		}
>  		assert(!is_removed(iter));
> +		assert(!is_removal_owner(iter));
>  		if (is_bucket(iter))
>  			new_next = flag_bucket(clear_flag(next));
>  		else
> @@ -880,8 +884,10 @@ int _cds_lfht_replace(struct cds_lfht *ht, unsigned long size,
>  		return -ENOENT;
> 
>  	assert(!is_removed(old_node));
> +	assert(!is_removal_owner(old_node));
>  	assert(!is_bucket(old_node));
>  	assert(!is_removed(new_node));
> +	assert(!is_removal_owner(new_node));
>  	assert(!is_bucket(new_node));
>  	assert(new_node != old_node);
>  	for (;;) {
> @@ -956,6 +962,7 @@ void _cds_lfht_add(struct cds_lfht *ht,
> 
>  	assert(!is_bucket(node));
>  	assert(!is_removed(node));
> +	assert(!is_removal_owner(node));
>  	bucket = lookup_bucket(ht, size, hash);
>  	for (;;) {
>  		uint32_t chain_len = 0;
> @@ -1016,7 +1023,9 @@ void _cds_lfht_add(struct cds_lfht *ht,
>  	insert:
>  		assert(node != clear_flag(iter));
>  		assert(!is_removed(iter_prev));
> +		assert(!is_removal_owner(iter_prev));
>  		assert(!is_removed(iter));
> +		assert(!is_removal_owner(iter));
>  		assert(iter_prev != node);
>  		if (!bucket_flag)
>  			node->next = clear_flag(iter);
> @@ -1036,6 +1045,7 @@ void _cds_lfht_add(struct cds_lfht *ht,
> 
>  	gc_node:
>  		assert(!is_removed(iter));
> +		assert(!is_removal_owner(iter));
>  		if (is_bucket(iter))
>  			new_next = flag_bucket(clear_flag(next));
>  		else
> @@ -1700,6 +1710,7 @@ int cds_lfht_delete_bucket(struct cds_lfht *ht)
>  		if (!is_bucket(node))
>  			return -EPERM;
>  		assert(!is_removed(node));
> +		assert(!is_removal_owner(node));
>  	} while (!is_end(node));
>  	/*
>  	 * size accessed without rcu_dereference because hash table is
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> rp mailing list
> rp@svcs.cs.pdx.edu
> http://svcs.cs.pdx.edu/mailman/listinfo/rp
> 
