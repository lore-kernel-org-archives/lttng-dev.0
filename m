From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: UST per-UID channels
 persist across application teardown
Date: Thu, 04 Jul 2013 12:26:09 -0400
Message-ID: <51D5A221.4090302__42072.1876006157$1372955218$gmane$org@efficios.com>
References: <20130702202033.GA11433@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UumML-0003CY-Um
	for lttng-dev@lists.lttng.org; Thu, 04 Jul 2013 12:26:18 -0400
In-Reply-To: <20130702202033.GA11433@Krystal>
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
> Fixes #582
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/ust-app.c
> index 2d7a81f..c329650 100644
> --- a/src/bin/lttng-sessiond/ust-app.c
> +++ b/src/bin/lttng-sessiond/ust-app.c
> @@ -377,10 +377,12 @@ void delete_ust_app_channel(int sock, struct ust_app_channel *ua_chan,
>  		delete_ust_app_event(sock, ua_event);
>  	}
>  
> -	/* Wipe and free registry from session registry. */
> -	registry = get_session_registry(ua_chan->session);
> -	if (registry) {
> -		ust_registry_channel_del_free(registry, ua_chan->key);
> +	if (ua_chan->session->buffer_type == LTTNG_BUFFER_PER_PID) {
> +		/* Wipe and free registry from session registry. */
> +		registry = get_session_registry(ua_chan->session);
> +		if (registry) {
> +			ust_registry_channel_del_free(registry, ua_chan->key);
> +		}
>  	}
>  
>  	if (ua_chan->obj != NULL) {
