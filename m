From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Clean-up: Remove double buffer
 initialisation
Date: Thu, 25 Apr 2019 14:23:34 -0400
Message-ID: <20190425182333.GA4708__19943.0755966873$1556216632$gmane$org@gmail.com>
References: <20190328190743.4146-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 by lists.lttng.org (Postfix) with ESMTPS id 44qltd4K8yz1KlT
 for <lttng-dev@lists.lttng.org>; Thu, 25 Apr 2019 14:23:37 -0400 (EDT)
Received: by mail-qt1-f194.google.com with SMTP id g4so1172738qtq.10
 for <lttng-dev@lists.lttng.org>; Thu, 25 Apr 2019 11:23:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190328190743.4146-1-ylamarre@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yannick Lamarre <ylamarre@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Merged in master and stable-2.11.

Thanks!
J=E9r=E9mie

On Thu, Mar 28, 2019 at 03:07:43PM -0400, Yannick Lamarre wrote:
> Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
> ---
>  src/lib/lttng-ctl/lttng-ctl.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> =

> diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
> index 165fef4d..92634c00 100644
> --- a/src/lib/lttng-ctl/lttng-ctl.c
> +++ b/src/lib/lttng-ctl/lttng-ctl.c
> @@ -1078,7 +1078,11 @@ int lttng_enable_event_with_exclusions(struct lttn=
g_handle *handle,
>  	unsigned int free_filter_expression =3D 0;
>  	struct filter_parser_ctx *ctx =3D NULL;
>  =

> -	memset(&send_buffer, 0, sizeof(send_buffer));
> +	/*
> +	 * We have either a filter or some exclusions, so we need to set up
> +	 * a variable-length memory block from where to send the data.
> +	 */
> +	lttng_dynamic_buffer_init(&send_buffer);
>  =

>  	/*
>  	 * Cast as non-const since we may replace the filter expression
> @@ -1128,12 +1132,6 @@ int lttng_enable_event_with_exclusions(struct lttn=
g_handle *handle,
>  	lsm.u.enable.exclusion_count =3D exclusion_count;
>  	lsm.u.enable.bytecode_len =3D 0;
>  =

> -	/*
> -	 * We have either a filter or some exclusions, so we need to set up
> -	 * a variable-length memory block from where to send the data.
> -	 */
> -	lttng_dynamic_buffer_init(&send_buffer);
> -
>  	/* Parse filter expression. */
>  	if (filter_expression !=3D NULL || handle->domain.type =3D=3D LTTNG_DOM=
AIN_JUL
>  			|| handle->domain.type =3D=3D LTTNG_DOMAIN_LOG4J
> -- =

> 2.11.0
> =
