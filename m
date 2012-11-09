From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Add libc errno translation
	layer	to UST error code
Date: Fri, 9 Nov 2012 13:11:43 -0500
Message-ID: <20121109181143.GC19849__588.502901564603$1352484752$gmane$org@Krystal>
References: <1352482888-31077-1-git-send-email-dgoulet@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TWt3Q-0008HE-Ep
	for lttng-dev@lists.lttng.org; Fri, 09 Nov 2012 13:11:44 -0500
Content-Disposition: inline
In-Reply-To: <1352482888-31077-1-git-send-email-dgoulet@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* David Goulet (dgoulet@efficios.com) wrote:
> Also add four new possible code being EEXIST, EINVAL, ENOSYS and EPERM.
> 
> Signed-off-by: David Goulet <dgoulet@efficios.com>
> ---
>  include/lttng/ust-error.h     |    6 +++++-
>  liblttng-ust/lttng-ust-comm.c |   26 +++++++++++++++++++++++---
>  2 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/include/lttng/ust-error.h b/include/lttng/ust-error.h
> index 49890a9..241d554 100644
> --- a/include/lttng/ust-error.h
> +++ b/include/lttng/ust-error.h
> @@ -36,7 +36,11 @@
>  enum lttng_ust_error_code {
>  	LTTNG_UST_OK = 0,			/* Ok */
>  	LTTNG_UST_ERR = 1024,			/* Unknown Error */
> -	LTTNG_UST_ERR_NOENT,			/* No entry */
> +	LTTNG_UST_ERR_NOENT = 1025,		/* No entry */
> +	LTTNG_UST_ERR_EXIST = 1026,		/* Object exists */
> +	LTTNG_UST_ERR_INVAL = 1027,     /* Invalid argument */
> +	LTTNG_UST_ERR_PERM  = 1028,     /* Permission denied */
> +	LTTNG_UST_ERR_NOSYS = 1029,     /* Not implemented */

you forgot the liblttng-ust-comm/liblttng-ust-comm.c array (mapping from
values to strings).

Thanks,

Mathieu


>  
>  	/* MUST be last element */
>  	LTTNG_UST_ERR_NR,			/* Last element */
> diff --git a/liblttng-ust/lttng-ust-comm.c b/liblttng-ust/lttng-ust-comm.c
> index f11b7d0..6eec73c 100644
> --- a/liblttng-ust/lttng-ust-comm.c
> +++ b/liblttng-ust/lttng-ust-comm.c
> @@ -376,9 +376,29 @@ end:
>  		 * we already have a more precise error message to
>  		 * report.
>  		 */
> -		if (ret > -LTTNG_UST_ERR)
> -			lur.ret_code = -LTTNG_UST_ERR;
> -		else
> +		if (ret > -LTTNG_UST_ERR) {
> +			/* Translate code to UST error. */
> +			switch (ret) {
> +			case -EEXIST:
> +				lur.ret_code = -LTTNG_UST_ERR_EXIST;
> +				break;
> +			case -EINVAL:
> +				lur.ret_code = -LTTNG_UST_ERR_INVAL;
> +				break;
> +			case -ENOENT:
> +				lur.ret_code = -LTTNG_UST_ERR_NOENT;
> +				break;
> +			case -EPERM:
> +				lur.ret_code = -LTTNG_UST_ERR_PERM;
> +				break;
> +			case -ENOSYS:
> +				lur.ret_code = -LTTNG_UST_ERR_NOSYS;
> +				break;
> +			default:
> +				lur.ret_code = -LTTNG_UST_ERR;
> +				break;
> +			}
> +		} else
>  			lur.ret_code = ret;
>  	}
>  	if (ret >= 0) {
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
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
