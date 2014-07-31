From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/3] rculfhash: handle pthread_create
 failures
Date: Thu, 31 Jul 2014 20:57:31 +0000 (UTC)
Message-ID: <973177847.24112.1406840251313.JavaMail.zimbra__36158.5870771252$1406840321$gmane$org@efficios.com>
References: <1403572832-9066-1-git-send-email-normalperson@yhbt.net>
 <1403572832-9066-3-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XCxPp-0006Ba-6u
 for lttng-dev@lists.lttng.org; Thu, 31 Jul 2014 16:57:39 -0400
In-Reply-To: <1403572832-9066-3-git-send-email-normalperson@yhbt.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Eric Wong <normalperson@yhbt.net>
Cc: e@80x24.org, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged with minor style edits into master, stable-0.8 and stable-0.7,
thanks!

Mathieu

----- Original Message -----
> From: "Eric Wong" <normalperson@yhbt.net>
> To: lttng-dev@lists.lttng.org
> Cc: e@80x24.org
> Sent: Monday, June 23, 2014 9:20:31 PM
> Subject: [lttng-dev] [PATCH 2/3] rculfhash: handle pthread_create failures
> 
> Like calloc, pthread_create may fail with EAGAIN due to a lack
> of resources.  Account for that and gracefully continue.
> 
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>  rculfhash.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/rculfhash.c b/rculfhash.c
> index 2a45045..d534be2 100644
> --- a/rculfhash.c
> +++ b/rculfhash.c
> @@ -1171,6 +1171,7 @@ void partition_resize_helper(struct cds_lfht *ht,
> unsigned long i,
>  		void (*fct)(struct cds_lfht *ht, unsigned long i,
>  			unsigned long start, unsigned long len))
>  {
> +	unsigned long start = 0;
>  	unsigned long partition_len;
>  	struct partition_resize_work *work;
>  	int thread, ret;
> @@ -1201,6 +1202,18 @@ void partition_resize_helper(struct cds_lfht *ht,
> unsigned long i,
>  		work[thread].fct = fct;
>  		ret = pthread_create(&(work[thread].thread_id), ht->resize_attr,
>  			partition_resize_thread, &work[thread]);
> +		if (ret == EAGAIN) {
> +			/*
> +			 * out of resources: wait and join the threads
> +			 * we've created, then handle leftovers
> +			 */
> +			dbg_printf(
> +			      "error spawning for resize, single-threading\n");
> +			start = work[thread].start;
> +			len -= start;
> +			nr_threads = thread;
> +			break;
> +		}
>  		assert(!ret);
>  	}
>  	for (thread = 0; thread < nr_threads; thread++) {
> @@ -1208,10 +1221,17 @@ void partition_resize_helper(struct cds_lfht *ht,
> unsigned long i,
>  		assert(!ret);
>  	}
>  	free(work);
> -	return;
> +
> +	/*
> +	 * a pthread_create failure above will either lead in us having
> +	 * no threads to join or starting at a non-zero offset,
> +	 * fallback to single thread processing of leftovers
> +	 */
> +	if (start == 0 && nr_threads > 0)
> +		return;
>  fallback:
>  	ht->flavor->thread_online();
> -	fct(ht, i, 0, len);
> +	fct(ht, i, start, len);
>  	ht->flavor->thread_offline();
>  }
>  
> --
> 2.0.0.259.gbf1bc9c
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
