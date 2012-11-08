From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Check if interrupt action name is not
	null	in statedump.
Date: Thu, 8 Nov 2012 15:18:47 -0500
Message-ID: <20121108201847.GA21370__41926.7542231411$1352405958$gmane$org@Krystal>
References: <1352405838-5687-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TWYYq-0006i9-9c
	for lttng-dev@lists.lttng.org; Thu, 08 Nov 2012 15:18:48 -0500
Content-Disposition: inline
In-Reply-To: <1352405838-5687-1-git-send-email-simon.marchi@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Simon Marchi (simon.marchi@polymtl.ca) wrote:
> Protection against poorly written drivers who give a null name to their
> irq handlers.
> 
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>

merged, thanks!

Mathieu

> ---
>  .../events/lttng-module/lttng-statedump.h          |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/instrumentation/events/lttng-module/lttng-statedump.h b/instrumentation/events/lttng-module/lttng-statedump.h
> index d350cad..e4c86d6 100644
> --- a/instrumentation/events/lttng-module/lttng-statedump.h
> +++ b/instrumentation/events/lttng-module/lttng-statedump.h
> @@ -150,12 +150,12 @@ TRACE_EVENT(lttng_statedump_interrupt,
>  	TP_STRUCT__entry(
>  		__field(unsigned int, irq)
>  		__string(name, chip_name)
> -		__string(action, action->name)
> +		__string(action, action->name ? : "")
>  	),
>  	TP_fast_assign(
>  		tp_assign(irq, irq)
>  		tp_strcpy(name, chip_name)
> -		tp_strcpy(action, action->name)
> +		tp_strcpy(action, action->name ? : "")
>  	),
>  	TP_printk("")
>  )
> -- 
> 1.7.1
> 
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
