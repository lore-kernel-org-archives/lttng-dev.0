From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: print dots while
	waiting	for data availability
Date: Fri, 19 Jul 2013 10:36:45 -0400
Message-ID: <20130719143645.GA24891__14153.6380783238$1374244663$gmane$org@Krystal>
References: <20130626171420.GA32374@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V0Bnb-0003pU-CS
	for lttng-dev@lists.lttng.org; Fri, 19 Jul 2013 10:36:51 -0400
Content-Disposition: inline
In-Reply-To: <20130626171420.GA32374@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This patch was lost, so I'm merging it.

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
> index 08c0554..8de1a23 100644
> --- a/src/lib/lttng-ctl/lttng-ctl.c
> +++ b/src/lib/lttng-ctl/lttng-ctl.c
> @@ -573,6 +573,7 @@ static int _lttng_stop_tracing(const char *session_name, int wait)
>  	}
>  
>  	_MSG("Waiting for data availability");
> +	fflush(stdout);
>  
>  	/* Check for data availability */
>  	do {
> @@ -590,6 +591,7 @@ static int _lttng_stop_tracing(const char *session_name, int wait)
>  		if (data_ret) {
>  			usleep(DEFAULT_DATA_AVAILABILITY_WAIT_TIME);
>  			_MSG(".");
> +			fflush(stdout);
>  		}
>  	} while (data_ret != 0);
>  
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
