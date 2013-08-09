From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [MODULES PATCH 1/2] Prepare LTTng override of ring
	buffer fops
Date: Fri, 9 Aug 2013 11:43:10 -0400
Message-ID: <20130809154310.GB13969__8901.28324176676$1376063144$gmane$org@Krystal>
References: <1376061290-30116-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V7oqN-0006tl-LN
	for lttng-dev@lists.lttng.org; Fri, 09 Aug 2013 11:43:17 -0400
Content-Disposition: inline
In-Reply-To: <1376061290-30116-1-git-send-email-jdesfossez@efficios.com>
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
> This patch allows LTTng to override the file operations of the lib ring
> buffer.
> For now it does not provide any additional functions, but it prepares
> the work of adding LTTng-specific ioctls to the ring buffer.
> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>  lttng-abi.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/lttng-abi.c b/lttng-abi.c
> index ba8362b..9a25490 100644
> --- a/lttng-abi.c
> +++ b/lttng-abi.c
> @@ -64,6 +64,7 @@ static const struct file_operations lttng_session_fops;
>  static const struct file_operations lttng_channel_fops;
>  static const struct file_operations lttng_metadata_fops;
>  static const struct file_operations lttng_event_fops;
> +static struct file_operations lttng_stream_ring_buffer_file_operations;
>  
>  /*
>   * Teardown management: opened file descriptors keep a refcount on the module,
> @@ -781,7 +782,7 @@ int lttng_abi_open_stream(struct file *channel_file)
>  
>  	stream_priv = buf;
>  	ret = lttng_abi_create_stream_fd(channel_file, stream_priv,
> -			&lib_ring_buffer_file_operations);
> +			&lttng_stream_ring_buffer_file_operations);
>  	if (ret < 0)
>  		goto fd_error;
>  
> @@ -1293,6 +1294,51 @@ static const struct file_operations lttng_event_fops = {
>  #endif
>  };
>  
> +static long lttng_stream_ring_buffer_ioctl(struct file *filp,
> +		unsigned int cmd, unsigned long arg)
> +{
> +	switch (cmd) {
> +		default:
> +			return lib_ring_buffer_file_operations.unlocked_ioctl(filp,
> +					cmd, arg);
> +	}
> +}
> +
> +#ifdef CONFIG_COMPAT
> +static long lttng_stream_ring_buffer_compat_ioctl(struct file *filp,
> +		unsigned int cmd, unsigned long arg)
> +{
> +	switch (cmd) {
> +		default:
> +			return lib_ring_buffer_file_operations.compat_ioctl(filp,
> +					cmd, arg);
> +	}
> +}
> +#endif /* CONFIG_COMPAT */
> +
> +static void lttng_stream_override_ring_buffer_fops(void)
> +{
> +	lttng_stream_ring_buffer_file_operations.owner = THIS_MODULE;
> +	lttng_stream_ring_buffer_file_operations.open =
> +		lib_ring_buffer_file_operations.open;
> +	lttng_stream_ring_buffer_file_operations.release =
> +		lib_ring_buffer_file_operations.release;
> +	lttng_stream_ring_buffer_file_operations.poll =
> +		lib_ring_buffer_file_operations.poll;
> +	lttng_stream_ring_buffer_file_operations.splice_read =
> +		lib_ring_buffer_file_operations.splice_read;
> +	lttng_stream_ring_buffer_file_operations.mmap =
> +		lib_ring_buffer_file_operations.mmap;
> +	lttng_stream_ring_buffer_file_operations.unlocked_ioctl =
> +		lttng_stream_ring_buffer_ioctl;
> +	lttng_stream_ring_buffer_file_operations.llseek =
> +		lib_ring_buffer_file_operations.llseek;
> +#ifdef CONFIG_COMPAT
> +	lttng_stream_ring_buffer_file_operations.compat_ioctl =
> +		lttng_stream_ring_buffer_compat_ioctl;
> +#endif
> +}
> +
>  int __init lttng_abi_init(void)
>  {
>  	int ret = 0;
> @@ -1306,6 +1352,8 @@ int __init lttng_abi_init(void)
>  		ret = -ENOMEM;
>  		goto error;
>  	}
> +	lttng_stream_override_ring_buffer_fops();
> +
>  error:
>  	return ret;
>  }
> -- 
> 1.7.10.4
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
