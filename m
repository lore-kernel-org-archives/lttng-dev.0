From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTNG-TOOLS PATCH] Fix: error handling in
	kernel	add_channel
Date: Mon, 8 Jul 2013 10:48:45 -0400
Message-ID: <20130708144845.GD29362__12820.0744082735$1373294955$gmane$org@Krystal>
References: <1369343228-11014-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UwCkB-0005go-5K
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 10:48:47 -0400
Content-Disposition: inline
In-Reply-To: <1369343228-11014-1-git-send-email-jdesfossez@efficios.com>
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
> consumer_add_channel can return an error, it needs to be handled.
> Also, init_kernel_tracing returns a positive lttng_error_code on error,
> so the check in start_kernel_session needs to be for ret != 0.

This patch was merged into stable-2.2 and master of lttng-tools.

> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  src/bin/lttng-sessiond/cmd.c                 |    2 +-
>  src/common/consumer.c                        |    2 +-
>  src/common/kernel-consumer/kernel-consumer.c |   19 +++++++++++++------
>  3 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
> index 4eacb3c..cbf2bce 100644
> --- a/src/bin/lttng-sessiond/cmd.c
> +++ b/src/bin/lttng-sessiond/cmd.c
> @@ -754,7 +754,7 @@ static int start_kernel_session(struct ltt_kernel_session *ksess, int wpipe)
>  
>  	/* Setup kernel consumer socket and send fds to it */
>  	ret = init_kernel_tracing(ksess);
> -	if (ret < 0) {
> +	if (ret != 0) {
>  		ret = LTTNG_ERR_KERN_START_FAIL;
>  		goto error;
>  	}
> diff --git a/src/common/consumer.c b/src/common/consumer.c
> index 84865d3..c9e4bae 100644
> --- a/src/common/consumer.c
> +++ b/src/common/consumer.c
> @@ -903,7 +903,7 @@ int consumer_add_channel(struct lttng_consumer_channel *channel,
>  		/* Channel already exist. Ignore the insertion */
>  		ERR("Consumer add channel key %" PRIu64 " already exists!",
>  			channel->key);
> -		ret = -1;
> +		ret = LTTNG_ERR_KERN_CHAN_EXIST;
>  		goto end;
>  	}
>  
> diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/kernel-consumer/kernel-consumer.c
> index d985014..f3a3a22 100644
> --- a/src/common/kernel-consumer/kernel-consumer.c
> +++ b/src/common/kernel-consumer/kernel-consumer.c
> @@ -122,6 +122,7 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
>  	case LTTNG_CONSUMER_ADD_CHANNEL:
>  	{
>  		struct lttng_consumer_channel *new_channel;
> +		int ret_recv;
>  
>  		/* First send a status message before receiving the fds. */
>  		ret = consumer_send_status_msg(sock, ret_code);
> @@ -129,7 +130,6 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
>  			/* Somehow, the session daemon is not responding anymore. */
>  			goto end_nosignal;
>  		}
> -
>  		DBG("consumer_add_channel %" PRIu64, msg.u.channel.channel_key);
>  		new_channel = consumer_allocate_channel(msg.u.channel.channel_key,
>  				msg.u.channel.session_id, msg.u.channel.pathname,
> @@ -155,15 +155,22 @@ int lttng_kconsumer_recv_cmd(struct lttng_consumer_local_data *ctx,
>  		};
>  
>  		if (ctx->on_recv_channel != NULL) {
> -			ret = ctx->on_recv_channel(new_channel);
> -			if (ret == 0) {
> -				consumer_add_channel(new_channel, ctx);
> -			} else if (ret < 0) {
> +			ret_recv = ctx->on_recv_channel(new_channel);
> +			if (ret_recv == 0) {
> +				ret = consumer_add_channel(new_channel, ctx);
> +			} else if (ret_recv < 0) {
>  				goto end_nosignal;
>  			}
>  		} else {
> -			consumer_add_channel(new_channel, ctx);
> +			ret = consumer_add_channel(new_channel, ctx);
> +		}
> +
> +		/* If we received an error in add_channel, we need to report it. */
> +		if (ret != 0) {
> +			consumer_send_status_msg(sock, ret);
> +			goto end_nosignal;
>  		}
> +
>  		goto end_nosignal;
>  	}
>  	case LTTNG_CONSUMER_ADD_STREAM:
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
