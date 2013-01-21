From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH] Fix I/O-related error values in ustctl
Date: Mon, 21 Jan 2013 10:54:57 -0500
Message-ID: <50FD64D1.1080202__37609.0841521092$1358783744$gmane$org@efficios.com>
References: <20130121152156.GA1912@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TxJi7-0003LF-Qx
	for lttng-dev@lists.lttng.org; Mon, 21 Jan 2013 10:55:01 -0500
In-Reply-To: <20130121152156.GA1912@Krystal>
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

Acked-by: David Goulet <dgoulet@efficios.com>

Mathieu Desnoyers:
> These internal ustctl API members document >=0 as OK values. Make sure
> reply recv errors are returned as errors.
> 
> Clarify ustctl_create_stream() error values.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> diff --git a/include/lttng/ust-ctl.h b/include/lttng/ust-ctl.h
> index c2b255c..11beaba 100644
> --- a/include/lttng/ust-ctl.h
> +++ b/include/lttng/ust-ctl.h
> @@ -23,7 +23,7 @@
>  
>  /*
>   * Error values: all the following functions return:
> - * >= 0: Sucess (LTTNG_UST_OK)
> + * >= 0: Success (LTTNG_UST_OK)
>   * < 0: error code.
>   */
>  int ustctl_register_done(int sock);
> @@ -34,8 +34,6 @@ int ustctl_open_metadata(int sock, int session_handle,
>  int ustctl_create_channel(int sock, int session_handle,
>  		struct lttng_ust_channel_attr *chops,
>  		struct lttng_ust_object_data **channel_data);
> -int ustctl_create_stream(int sock, struct lttng_ust_object_data *channel_data,
> -		struct lttng_ust_object_data **stream_data);
>  int ustctl_create_event(int sock, struct lttng_ust_event *ev,
>  		struct lttng_ust_object_data *channel_data,
>  		struct lttng_ust_object_data **event_data);
> @@ -51,6 +49,15 @@ int ustctl_start_session(int sock, int handle);
>  int ustctl_stop_session(int sock, int handle);
>  
>  /*
> + * Return -ENOENT if no more stream is available for creation.
> + * Return 0 on success.
> + * Return negative error value on system error.
> + * Return positive error value on UST error.
> + */
> +int ustctl_create_stream(int sock, struct lttng_ust_object_data *channel_data,
> +		struct lttng_ust_object_data **stream_data);
> +
> +/*
>   * ustctl_tracepoint_list returns a tracepoint list handle, or negative
>   * error value.
>   */
> diff --git a/liblttng-ust-comm/lttng-ust-comm.c b/liblttng-ust-comm/lttng-ust-comm.c
> index 9a67ea1..db9910d 100644
> --- a/liblttng-ust-comm/lttng-ust-comm.c
> +++ b/liblttng-ust-comm/lttng-ust-comm.c
> @@ -435,7 +435,10 @@ int ustcomm_send_app_cmd(int sock,
>  	ret = ustcomm_send_app_msg(sock, lum);
>  	if (ret)
>  		return ret;
> -	return ustcomm_recv_app_reply(sock, lur, lum->handle, lum->cmd);
> +	ret = ustcomm_recv_app_reply(sock, lur, lum->handle, lum->cmd);
> +	if (ret > 0)
> +		return -EIO;
> +	return ret;
>  }
>  
>  /*
> 
