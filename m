From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix:
 consumer_add_relayd_socket() report errors to sessiond
Date: Thu, 04 Jul 2013 12:26:15 -0400
Message-ID: <51D5A227.6020408__30829.6651499861$1372955217$gmane$org@efficios.com>
References: <20130702191402.GB10887@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UumMQ-0003CZ-NT
	for lttng-dev@lists.lttng.org; Thu, 04 Jul 2013 12:26:22 -0400
In-Reply-To: <20130702191402.GB10887@Krystal>
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

Merged!

Mathieu Desnoyers:
> Wait until the side-effect to relayd is actually performed before
> replying that "all is fine" to sessiond.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> diff --git a/src/common/consumer.c b/src/common/consumer.c
> index 6830084..1f96fa9 100644
> --- a/src/common/consumer.c
> +++ b/src/common/consumer.c
> @@ -3017,8 +3017,9 @@ int consumer_add_relayd_socket(uint64_t net_seq_idx, int sock_type,
>  		/* Not found. Allocate one. */
>  		relayd = consumer_allocate_relayd_sock_pair(net_seq_idx);
>  		if (relayd == NULL) {
> -			ret_code = LTTCOMM_CONSUMERD_ENOMEM;
>  			ret = -ENOMEM;
> +			ret_code = LTTCOMM_CONSUMERD_ENOMEM;
> +			goto error;
>  		} else {
>  			relayd->sessiond_session_id = (uint64_t) sessiond_id;
>  			relayd_created = 1;
> @@ -3037,23 +3038,23 @@ int consumer_add_relayd_socket(uint64_t net_seq_idx, int sock_type,
>  	}
>  
>  	/* First send a status message before receiving the fds. */
> -	ret = consumer_send_status_msg(sock, ret_code);
> -	if (ret < 0 || ret_code != LTTNG_OK) {
> +	ret = consumer_send_status_msg(sock, LTTNG_OK);
> +	if (ret < 0) {
>  		/* Somehow, the session daemon is not responding anymore. */
> -		goto error;
> +		lttng_consumer_send_error(ctx, LTTCOMM_CONSUMERD_FATAL);
> +		goto error_nosignal;
>  	}
>  
>  	/* Poll on consumer socket. */
>  	if (lttng_consumer_poll_socket(consumer_sockpoll) < 0) {
>  		lttng_consumer_send_error(ctx, LTTCOMM_CONSUMERD_POLL_ERROR);
>  		ret = -EINTR;
> -		goto error;
> +		goto error_nosignal;
>  	}
>  
>  	/* Get relayd socket from session daemon */
>  	ret = lttcomm_recv_fds_unix_sock(sock, &fd, 1);
>  	if (ret != sizeof(fd)) {
> -		ret_code = LTTCOMM_CONSUMERD_ERROR_RECV_FD;
>  		ret = -1;
>  		fd = -1;	/* Just in case it gets set with an invalid value. */
>  
> @@ -3067,18 +3068,7 @@ int consumer_add_relayd_socket(uint64_t net_seq_idx, int sock_type,
>  		 * issue when reaching the fd limit.
>  		 */
>  		lttng_consumer_send_error(ctx, LTTCOMM_CONSUMERD_ERROR_RECV_FD);
> -
> -		/*
> -		 * This code path MUST continue to the consumer send status message so
> -		 * we can send the error to the thread expecting a reply. The above
> -		 * call will make everything stop.
> -		 */
> -	}
> -
> -	/* We have the fds without error. Send status back. */
> -	ret = consumer_send_status_msg(sock, ret_code);
> -	if (ret < 0 || ret_code != LTTNG_OK) {
> -		/* Somehow, the session daemon is not responding anymore. */
> +		ret_code = LTTCOMM_CONSUMERD_ERROR_RECV_FD;
>  		goto error;
>  	}
>  
> @@ -3090,6 +3080,7 @@ int consumer_add_relayd_socket(uint64_t net_seq_idx, int sock_type,
>  		ret = lttcomm_create_sock(&relayd->control_sock.sock);
>  		/* Handle create_sock error. */
>  		if (ret < 0) {
> +			ret_code = LTTCOMM_CONSUMERD_ENOMEM;
>  			goto error;
>  		}
>  		/*
> @@ -3128,6 +3119,7 @@ int consumer_add_relayd_socket(uint64_t net_seq_idx, int sock_type,
>  			 */
>  			(void) relayd_close(&relayd->control_sock);
>  			(void) relayd_close(&relayd->data_sock);
> +			ret_code = LTTCOMM_CONSUMERD_RELAYD_FAIL;
>  			goto error;
>  		}
>  
> @@ -3138,6 +3130,7 @@ int consumer_add_relayd_socket(uint64_t net_seq_idx, int sock_type,
>  		ret = lttcomm_create_sock(&relayd->data_sock.sock);
>  		/* Handle create_sock error. */
>  		if (ret < 0) {
> +			ret_code = LTTCOMM_CONSUMERD_ENOMEM;
>  			goto error;
>  		}
>  		/*
> @@ -3159,6 +3152,7 @@ int consumer_add_relayd_socket(uint64_t net_seq_idx, int sock_type,
>  	default:
>  		ERR("Unknown relayd socket type (%d)", sock_type);
>  		ret = -1;
> +		ret_code = LTTCOMM_CONSUMERD_FATAL;
>  		goto error;
>  	}
>  
> @@ -3166,6 +3160,14 @@ int consumer_add_relayd_socket(uint64_t net_seq_idx, int sock_type,
>  			sock_type == LTTNG_STREAM_CONTROL ? "control" : "data",
>  			relayd->net_seq_idx, fd);
>  
> +	/* We successfully added the socket. Send status back. */
> +	ret = consumer_send_status_msg(sock, ret_code);
> +	if (ret < 0) {
> +		/* Somehow, the session daemon is not responding anymore. */
> +		lttng_consumer_send_error(ctx, LTTCOMM_CONSUMERD_FATAL);
> +		goto error_nosignal;
> +	}
> +
>  	/*
>  	 * Add relayd socket pair to consumer data hashtable. If object already
>  	 * exists or on error, the function gracefully returns.
> @@ -3176,6 +3178,11 @@ int consumer_add_relayd_socket(uint64_t net_seq_idx, int sock_type,
>  	return 0;
>  
>  error:
> +	if (consumer_send_status_msg(sock, ret_code) < 0) {
> +		lttng_consumer_send_error(ctx, LTTCOMM_CONSUMERD_FATAL);
> +	}
> +
> +error_nosignal:
>  	/* Close received socket if valid. */
>  	if (fd >= 0) {
>  		if (close(fd)) {
> diff --git a/src/common/sessiond-comm/sessiond-comm.c b/src/common/sessiond-comm/sessiond-comm.c
> index 738362c..9a13f41 100644
> --- a/src/common/sessiond-comm/sessiond-comm.c
> +++ b/src/common/sessiond-comm/sessiond-comm.c
> @@ -64,6 +64,7 @@ static const char *lttcomm_readable_code[] = {
>  	[ LTTCOMM_ERR_INDEX(LTTCOMM_CONSUMERD_ENOMEM) ] = "Consumer is out of memory",
>  	[ LTTCOMM_ERR_INDEX(LTTCOMM_CONSUMERD_ERROR_METADATA) ] = "Error with metadata",
>  	[ LTTCOMM_ERR_INDEX(LTTCOMM_CONSUMERD_FATAL) ] = "Fatal error",
> +	[ LTTCOMM_ERR_INDEX(LTTCOMM_CONSUMERD_RELAYD_FAIL) ] = "Error on remote relayd",
>  
>  	/* Last element */
>  	[ LTTCOMM_ERR_INDEX(LTTCOMM_NR) ] = "Unknown error code"
> diff --git a/src/common/sessiond-comm/sessiond-comm.h b/src/common/sessiond-comm/sessiond-comm.h
> index e984cb1..b76135e 100644
> --- a/src/common/sessiond-comm/sessiond-comm.h
> +++ b/src/common/sessiond-comm/sessiond-comm.h
> @@ -124,6 +124,7 @@ enum lttcomm_return_code {
>  	LTTCOMM_CONSUMERD_ENOMEM,                   /* Consumer is out of memory */
>  	LTTCOMM_CONSUMERD_ERROR_METADATA,           /* Error with metadata. */
>  	LTTCOMM_CONSUMERD_FATAL,                    /* Fatal error. */
> +	LTTCOMM_CONSUMERD_RELAYD_FAIL,              /* Error on remote relayd */
>  
>  	/* MUST be last element */
>  	LTTCOMM_NR,						/* Last element */
> 
