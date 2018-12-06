From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Fix: timer instrumentation for RHEL 7.6
Date: Thu, 6 Dec 2018 11:45:10 -0500 (EST)
Message-ID: <1961228901.20547.1544114710821.JavaMail.zimbra__41719.4907124669$1544114597$gmane$org@efficios.com>
References: <20181206163151.10518-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 439hKh35XMzvyL
 for <lttng-dev@lists.lttng.org>; Thu,  6 Dec 2018 11:45:12 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 9BDA4A0C82
 for <lttng-dev@lists.lttng.org>; Thu,  6 Dec 2018 11:45:11 -0500 (EST)
In-Reply-To: <20181206163151.10518-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

My dear Michael,

Your patch has been merged into lttng-modules master, 2.10, 2.9,

I wish you a wonderful day!

Thanks,

Mathieu

----- On Dec 6, 2018, at 11:31 AM, Michael Jeanson mjeanson@efficios.com wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> instrumentation/events/lttng-module/timer.h | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/instrumentation/events/lttng-module/timer.h
> b/instrumentation/events/lttng-module/timer.h
> index a007fd2..8703ea0 100644
> --- a/instrumentation/events/lttng-module/timer.h
> +++ b/instrumentation/events/lttng-module/timer.h
> @@ -45,7 +45,8 @@ LTTNG_TRACEPOINT_EVENT_INSTANCE(timer_class, timer_init,
> 	TP_ARGS(timer)
> )
> 
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,2,0))
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(4,2,0) || \
> +	LTTNG_RHEL_KERNEL_RANGE(3,10,0,957,0,0, 3,11,0,0,0,0))
> /**
>  * timer_start - called when the timer is started
>  * @timer:	pointer to struct timer_list
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
