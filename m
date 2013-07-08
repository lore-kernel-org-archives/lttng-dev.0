From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTNG-TOOLS PATCH] Fix: increment channel	refcount
	on add_stream
Date: Mon, 8 Jul 2013 10:49:18 -0400
Message-ID: <20130708144918.GE29362__5004.05036514184$1373294988$gmane$org@Krystal>
References: <1369345431-15885-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UwCkh-0005hk-Qy
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 10:49:19 -0400
Content-Disposition: inline
In-Reply-To: <1369345431-15885-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Julien Desfossez (jdesfossez@efficios.com) wrote:
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>

This patch was merged into master and stable-2.2 of lttng-tools.

> ---
>  src/common/consumer.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/src/common/consumer.c b/src/common/consumer.c
> index c9e4bae..bfb809a 100644
> --- a/src/common/consumer.c
> +++ b/src/common/consumer.c
> @@ -663,6 +663,9 @@ static int add_stream(struct lttng_consumer_stream *stream,
>  		uatomic_inc(&relayd->refcount);
>  	}
>  
> +	/* Update channel refcount once added without error(s). */
> +	uatomic_inc(&stream->chan->refcount);
> +
>  	/*
>  	 * When nb_init_stream_left reaches 0, we don't need to trigger any action
>  	 * in terms of destroying the associated channel, because the action that
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
