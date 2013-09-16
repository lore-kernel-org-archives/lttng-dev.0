From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [MODULES PATCH 4/4] Metadata flush writes data from
	the cache
Date: Mon, 16 Sep 2013 12:36:32 -0400
Message-ID: <20130916163632.GD25275__7376.66919962994$1379349723$gmane$org@Krystal>
References: <1379344713-9185-1-git-send-email-jdesfossez@efficios.com>
	<1379344713-9185-4-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VLbmr-0007In-SQ
	for lttng-dev@lists.lttng.org; Mon, 16 Sep 2013 12:36:39 -0400
Content-Disposition: inline
In-Reply-To: <1379344713-9185-4-git-send-email-jdesfossez@efficios.com>
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
> When doing a flush on a metadata stream we first check if we can fill
> the current subbuffer with data from the cache before doing the actual
> flush.

Comments below,

> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  lttng-abi.c    | 56 +++++++++++++++++++++++++++++++++-----------------------
>  lttng-events.c |  2 ++
>  2 files changed, 35 insertions(+), 23 deletions(-)
> 
> diff --git a/lttng-abi.c b/lttng-abi.c
> index 224b352..a373504 100644
> --- a/lttng-abi.c
> +++ b/lttng-abi.c
> @@ -549,23 +549,6 @@ unsigned int lttng_metadata_ring_buffer_poll(struct file *filp,
>  }
>  
>  static
> -int lttng_metadata_ring_buffer_ioctl_get_next_subbuf(struct file *filp,
> -		unsigned int cmd, unsigned long arg)
> -{
> -	struct lttng_metadata_stream *stream = filp->private_data;
> -	struct lib_ring_buffer *buf = stream->priv;
> -	struct channel *chan = buf->backend.chan;
> -	int ret;
> -
> -	ret = lttng_metadata_output_channel(stream, chan);
> -	if (ret > 0) {
> -		lib_ring_buffer_switch_slow(buf, SWITCH_ACTIVE);
> -		ret = 0;
> -	}
> -	return ret;
> -}
> -
> -static
>  void lttng_metadata_ring_buffer_ioctl_put_next_subbuf(struct file *filp,
>  		unsigned int cmd, unsigned long arg)
>  {
> @@ -585,9 +568,15 @@ long lttng_metadata_ring_buffer_ioctl(struct file *filp,
>  	switch (cmd) {
>  	case RING_BUFFER_GET_NEXT_SUBBUF:
>  	{
> -		ret = lttng_metadata_ring_buffer_ioctl_get_next_subbuf(filp,
> -				cmd, arg);
> -		if (ret < 0)
> +		struct lttng_metadata_stream *stream = filp->private_data;
> +		struct lib_ring_buffer *buf = stream->priv;
> +		struct channel *chan = buf->backend.chan;
> +
> +		ret = lttng_metadata_output_channel(stream, chan);
> +		if (ret > 0) {
> +			lib_ring_buffer_switch_slow(buf, SWITCH_ACTIVE);
> +			ret = 0;
> +		} else if (ret < 0)
>  			goto err;
>  		break;
>  	}
> @@ -598,6 +587,21 @@ long lttng_metadata_ring_buffer_ioctl(struct file *filp,
>  		 */
>  		return -ENOSYS;
>  	}
> +	case RING_BUFFER_FLUSH:
> +	{
> +		struct lttng_metadata_stream *stream = filp->private_data;
> +		struct lib_ring_buffer *buf = stream->priv;
> +		struct channel *chan = buf->backend.chan;
> +
> +		/*
> +		 * Before doing the actual ring buffer flush, write up to one
> +		 * packet of metadata in the ring buffer.

This comment says "Before doing the actual rb flush". But where is it
done ? Do we need it at all, or is it done by the following get_subbuf ?
I think the code might be right, but the comment does not match the
implementation.

Thanks,

Mathieu

> +		 */
> +		ret = lttng_metadata_output_channel(stream, chan);
> +		if (ret < 0)
> +			goto err;
> +		break;
> +	}
>  	default:
>  		break;
>  	}
> @@ -634,9 +638,15 @@ long lttng_metadata_ring_buffer_compat_ioctl(struct file *filp,
>  	switch (cmd) {
>  	case RING_BUFFER_GET_NEXT_SUBBUF:
>  	{
> -		ret = lttng_metadata_ring_buffer_ioctl_get_next_subbuf(filp,
> -				cmd, arg);
> -		if (ret < 0)
> +		struct lttng_metadata_stream *stream = filp->private_data;
> +		struct lib_ring_buffer *buf = stream->priv;
> +		struct channel *chan = buf->backend.chan;
> +
> +		ret = lttng_metadata_output_channel(stream, chan);
> +		if (ret > 0) {
> +			lib_ring_buffer_switch_slow(buf, SWITCH_ACTIVE);
> +			ret = 0;
> +		} else if (ret < 0)
>  			goto err;
>  		break;
>  	}
> diff --git a/lttng-events.c b/lttng-events.c
> index 879097b..b7e4422 100644
> --- a/lttng-events.c
> +++ b/lttng-events.c
> @@ -553,6 +553,8 @@ void _lttng_event_destroy(struct lttng_event *event)
>   * sessions_mutex), so we can do racy operations such as looking for
>   * remaining space left in packet and write, since mutual exclusion
>   * protects us from concurrent writes.
> + * Returns the number of bytes written in the channel, 0 if no data
> + * was written and a negative value on error.
>   */
>  int lttng_metadata_output_channel(struct lttng_metadata_stream *stream,
>  		struct channel *chan)
> -- 
> 1.8.3.2
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
