From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix check
	in	lttng_strlen_user_inatomic
Date: Wed, 6 Feb 2013 11:29:40 -0500
Message-ID: <20130206162939.GA30271__34221.9441816725$1360168231$gmane$org@Krystal>
References: <1360162474-13940-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1U37sT-0005zX-86
	for lttng-dev@lists.lttng.org; Wed, 06 Feb 2013 11:29:41 -0500
Content-Disposition: inline
In-Reply-To: <1360162474-13940-1-git-send-email-simon.marchi@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Simon Marchi (simon.marchi@polymtl.ca) wrote:
> __copy_from_user_inatomic returns the number of bytes that could not be
> copied, not an error code. This fixes the test accordingly.

Merged with update (change ret type to unsigned long too) into master,
stable-2.1, stable-2.0.

Good catch !

Mathieu

> 
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> ---
>  probes/lttng-probe-user.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/probes/lttng-probe-user.c b/probes/lttng-probe-user.c
> index 94ecf2f..a2368b5 100644
> --- a/probes/lttng-probe-user.c
> +++ b/probes/lttng-probe-user.c
> @@ -41,7 +41,7 @@ long lttng_strlen_user_inatomic(const char *addr)
>  		ret = __copy_from_user_inatomic(&v,
>  			(__force const char __user *)(addr),
>  			sizeof(v));
> -		if (unlikely(ret == -EFAULT))
> +		if (unlikely(ret > 0))
>  			break;
>  		count++;
>  		if (unlikely(!v))
> -- 
> 1.7.1
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
