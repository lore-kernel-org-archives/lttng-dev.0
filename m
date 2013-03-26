From: David Goulet <dgoulet@efficios.com>
Subject: Re: [lttng-tools PATCH] Fix: UST context activation
Date: Tue, 26 Mar 2013 09:39:44 -0400
Message-ID: <5151A520.9050601__49536.0804758549$1364305241$gmane$org@efficios.com>
References: <20130326023546.GA7176@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UKU6N-0001uy-UB
	for lttng-dev@lists.lttng.org; Tue, 26 Mar 2013 09:39:48 -0400
In-Reply-To: <20130326023546.GA7176@Krystal>
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

Davd

Mathieu Desnoyers:
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> diff --git a/src/bin/lttng-sessiond/context.c b/src/bin/lttng-sessiond/context.c
> index a83cb46..b55254b 100644
> --- a/src/bin/lttng-sessiond/context.c
> +++ b/src/bin/lttng-sessiond/context.c
> @@ -262,7 +262,7 @@ int context_ust_add(struct ltt_ust_session *usess, int domain,
>  	}
>  
>  	/* Get UST channel if defined */
> -	if (channel_name != '\0') {
> +	if (channel_name[0] != '\0') {
>  		uchan = trace_ust_find_channel_by_name(chan_ht, channel_name);
>  		if (uchan == NULL) {
>  			ret = LTTNG_ERR_UST_CHAN_NOT_FOUND;
> 
