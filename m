From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [lttng-tools PATCH] Move metset in	channel_set_attr
	after the null check
Date: Wed, 6 Jun 2012 15:40:09 -0400
Message-ID: <20120606194009.GA5882__32678.2008320608$1339011633$gmane$org@Krystal>
References: <1339008870-4891-1-git-send-email-serres@live.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1ScM5T-00068Z-5D
	for lttng-dev@lists.lttng.org; Wed, 06 Jun 2012 15:40:11 -0400
Content-Disposition: inline
In-Reply-To: <1339008870-4891-1-git-send-email-serres@live.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Danny Serres <serres@live.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Danny Serres (serres@live.ca) wrote:
> Signed-off-by: Danny Serres <serres@live.ca>

Hi Danny,

Your patch looks good ! Just one detail: I forgot to create a
efficios.com email for you. So I will create
"danny.serres@efficios.com", and you can sign-off your patch with this
email. It will be forwarded to your @live.ca email.

Thanks !

Mathieu

> ---
>  src/lib/lttng-ctl/lttng-ctl.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
> index 36069ef..356fb34 100644
> --- a/src/lib/lttng-ctl/lttng-ctl.c
> +++ b/src/lib/lttng-ctl/lttng-ctl.c
> @@ -885,13 +885,13 @@ int lttng_calibrate(struct lttng_handle *handle,
>  void lttng_channel_set_default_attr(struct lttng_domain *domain,
>  		struct lttng_channel_attr *attr)
>  {
> -	memset(attr, 0, sizeof(struct lttng_channel_attr));
> -
>  	/* Safety check */
>  	if (attr == NULL || domain == NULL) {
>  		return;
>  	}
>  
> +	memset(attr, 0, sizeof(struct lttng_channel_attr));
> +
>  	switch (domain->type) {
>  	case LTTNG_DOMAIN_KERNEL:
>  		attr->overwrite = DEFAULT_CHANNEL_OVERWRITE;
> -- 
> 1.7.9.5
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
