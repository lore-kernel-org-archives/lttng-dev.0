From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: hash table growth (for
 small tables) should be limited (v2)
Date: Thu, 29 Aug 2013 12:54:51 -0400
Message-ID: <521F7CDB.7050504__5922.00995092771$1377795426$gmane$org@efficios.com>
References: <20130827220142.GA13424@Krystal> <20130827221104.GA13930@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VF5Ut-00010Y-Vp
	for lttng-dev@lists.lttng.org; Thu, 29 Aug 2013 12:55:09 -0400
In-Reply-To: <20130827221104.GA13930@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged!

Mathieu Desnoyers:
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
> diff --git a/src/common/hashtable/rculfhash.c b/src/common/hashtable/rculfhash.c
> index b430a3d..ebdc4ff 100644
> --- a/src/common/hashtable/rculfhash.c
> +++ b/src/common/hashtable/rculfhash.c
> @@ -726,9 +726,32 @@ void check_resize(struct cds_lfht *ht, unsigned long size, uint32_t chain_len)
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
