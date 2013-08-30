From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH urcu] Fix: hash table growth (for
	small	tables) should be limited
Date: Fri, 30 Aug 2013 13:58:05 -0400
Message-ID: <20130830175805.GA11508__14294.0782513053$1377885555$gmane$org@Krystal>
References: <20130827221850.GA14036@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VFSxT-0008M4-V6
	for lttng-dev@lists.lttng.org; Fri, 30 Aug 2013 13:58:13 -0400
Content-Disposition: inline
In-Reply-To: <20130827221850.GA14036@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, rp@svcs.cs.pdx.edu
Cc: Stephen Hemminger <shemminger@vyatta.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alan Stern <stern@rowland.harvard.edu>
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> Buckets with many entries encountered in a hash table could cause it to
> grow to a large size, beyond the scope for which this mechanism is
> expected to play a role when node accounting is available. Indeed, when
> the hash table grows to larger size, split-counter node accounting is
> expected to deal with resize/shrink rather than relying on an heuristic
> based on the largest bucket size.
> 
> This is fixing an issue where we see hash tables sometimes reaching 65k
> entries index (65536*8 = 524288 bytes) for a workload limited to adding
> 1000 entries and then removing all of them, done in a loop (random
> keys).
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> diff --git a/rculfhash.c b/rculfhash.c
> index 423609d..283cd2d 100644
> --- a/rculfhash.c
> +++ b/rculfhash.c
> @@ -718,9 +718,32 @@ void check_resize(struct cds_lfht *ht, unsigned long size, uint32_t chain_len)
>  	if (chain_len > 100)
>  		dbg_printf("WARNING: large chain length: %u.\n",
>  			   chain_len);
> -	if (chain_len >= CHAIN_LEN_RESIZE_THRESHOLD)
> -		cds_lfht_resize_lazy_grow(ht, size,
> -			cds_lfht_get_count_order_u32(chain_len - (CHAIN_LEN_TARGET - 1)));
> +	if (chain_len >= CHAIN_LEN_RESIZE_THRESHOLD) {
> +		int growth;
> +
> +		/*
> +		 * Ideal growth calculated based on chain length.
> +		 */
> +		growth = cds_lfht_get_count_order_u32(chain_len
> +				- (CHAIN_LEN_TARGET - 1));
> +		if ((ht->flags & CDS_LFHT_ACCOUNTING)
> +				&& (size << growth) >= (1UL << COUNT_COMMIT_ORDER)) {

Actually, I think it would be cleaner to use the chain_len based
mechanism up to

  (1UL << COUNT_COMMIT_ORDER) * (split_count_mask + 1)

so we end up taking into account that the split-counters are only
committed into the global counter every COUNT_COMMIT_ORDER
increment/decrement.

It's not bad if we just use (1UL << COUNT_COMMIT_ORDER): we just end up
with larger chains in some cases (usually bounded by the log2(number of
CPUs)).

Thoughts ?

Thanks,

Mathieu

> +			/*
> +			 * If ideal growth expands the hash table size
> +			 * beyond the "small hash table" sizes, use the
> +			 * maximum small hash table size to attempt
> +			 * expanding the hash table. This only applies
> +			 * when node accounting is available, otherwise
> +			 * the chain length is used to expand the hash
> +			 * table in every case.
> +			 */
> +			growth = COUNT_COMMIT_ORDER -
> +				cds_lfht_get_count_order_u32(size);
> +			if (growth <= 0)
> +				return;
> +		}
> +		cds_lfht_resize_lazy_grow(ht, size, growth);
> +	}
>  }
>  
>  static
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
