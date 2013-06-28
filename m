From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTng-modules PATCH] The msg part of the
	printk:console event	was 1 character too long
Date: Fri, 28 Jun 2013 15:43:04 -0400
Message-ID: <20130628194304.GB24942__34840.5698467561$1372448617$gmane$org@Krystal>
References: <1372447954-4360-1-git-send-email-yannick.brosseau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UseZV-0007gk-Fi
	for lttng-dev@lists.lttng.org; Fri, 28 Jun 2013 15:43:05 -0400
Content-Disposition: inline
In-Reply-To: <1372447954-4360-1-git-send-email-yannick.brosseau@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
> Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
> ---
>  instrumentation/events/lttng-module/printk.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/instrumentation/events/lttng-module/printk.h b/instrumentation/events/lttng-module/printk.h
> index 4c744f9..f4b6028 100644
> --- a/instrumentation/events/lttng-module/printk.h
> +++ b/instrumentation/events/lttng-module/printk.h
> @@ -19,7 +19,7 @@ TRACE_EVENT_CONDITION(console,
>  
>  	TP_STRUCT__entry(
>  		__dynamic_array_text(char, msg,
> -			min_t(unsigned, end - start, MSG_TRACE_MAX_LEN) + 1)

this was taken from the Linux kernel mainline instrumentation, no ?

Has this been fixed upstream ? If so, can you cite the commit in the
changelog ?

Thanks,

Mathieu

> +			min_t(unsigned, end - start, MSG_TRACE_MAX_LEN))
>  	),
>  
>  	TP_fast_assign(
> -- 
> 1.7.10.4
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
