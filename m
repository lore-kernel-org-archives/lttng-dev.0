From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: add missing enum
 lttcomm_return_code entries
Date: Thu, 04 Jul 2013 12:26:19 -0400
Message-ID: <51D5A22B.9050009__16372.4590595395$1372955220$gmane$org@efficios.com>
References: <20130702191242.GA10887@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UumMU-0003D2-OM
	for lttng-dev@lists.lttng.org; Thu, 04 Jul 2013 12:26:26 -0400
In-Reply-To: <20130702191242.GA10887@Krystal>
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
> Those should not appear as unknown.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> diff --git a/src/common/sessiond-comm/sessiond-comm.c b/src/common/sessiond-comm/sessiond-comm.c
> index 64223df..738362c 100644
> --- a/src/common/sessiond-comm/sessiond-comm.c
> +++ b/src/common/sessiond-comm/sessiond-comm.c
> @@ -61,6 +61,9 @@ static const char *lttcomm_readable_code[] = {
>  	[ LTTCOMM_ERR_INDEX(LTTCOMM_CONSUMERD_SPLICE_EINVAL) ] = "consumerd splice EINVAL",
>  	[ LTTCOMM_ERR_INDEX(LTTCOMM_CONSUMERD_SPLICE_ENOMEM) ] = "consumerd splice ENOMEM",
>  	[ LTTCOMM_ERR_INDEX(LTTCOMM_CONSUMERD_SPLICE_ESPIPE) ] = "consumerd splice ESPIPE",
> +	[ LTTCOMM_ERR_INDEX(LTTCOMM_CONSUMERD_ENOMEM) ] = "Consumer is out of memory",
> +	[ LTTCOMM_ERR_INDEX(LTTCOMM_CONSUMERD_ERROR_METADATA) ] = "Error with metadata",
> +	[ LTTCOMM_ERR_INDEX(LTTCOMM_CONSUMERD_FATAL) ] = "Fatal error",
>  
>  	/* Last element */
>  	[ LTTCOMM_ERR_INDEX(LTTCOMM_NR) ] = "Unknown error code"
> 
