From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTNG-TOOLS PATCH] Fix: close wait_fd on
	kernel	tracing
Date: Mon, 8 Jul 2013 10:47:54 -0400
Message-ID: <20130708144754.GC29362__47800.7413949401$1373294907$gmane$org@Krystal>
References: <1369340015-6895-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UwCjL-0005fX-Fx
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 10:47:55 -0400
Content-Disposition: inline
In-Reply-To: <1369340015-6895-1-git-send-email-jdesfossez@efficios.com>
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
> The wait_fd in the kernel consumer streams was not closed causing a leak
> of FDs in the consumer and never triggering the teardown mechanism in
> the kernel tracer.

Just for traceability on the ML: this patch had indeed been merged into
master and stable-2.2 of lttng-tools.

Mathieu

> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  src/common/consumer.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/src/common/consumer.c b/src/common/consumer.c
> index 044a504..84865d3 100644
> --- a/src/common/consumer.c
> +++ b/src/common/consumer.c
> @@ -463,6 +463,10 @@ void consumer_del_stream(struct lttng_consumer_stream *stream,
>  				PERROR("munmap");
>  			}
>  		}
> +		ret = close(stream->wait_fd);
> +		if (ret) {
> +			PERROR("close");
> +		}
>  		break;
>  	case LTTNG_CONSUMER32_UST:
>  	case LTTNG_CONSUMER64_UST:
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
