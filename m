From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 1/1] Fix: sessiond: handle NULL
 control output in session descriptor base path getter
Date: Fri, 6 Sep 2019 11:36:26 -0400
Message-ID: <20190906153626.GA4501__43795.517615375$1567784208$gmane$org@gmail.com>
References: <20190905191840.21430-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by lists.lttng.org (Postfix) with ESMTPS id 46Q1qy3KgYzsD9
 for <lttng-dev@lists.lttng.org>; Fri,  6 Sep 2019 11:36:30 -0400 (EDT)
Received: by mail-qt1-f195.google.com with SMTP id l22so7458370qtp.10
 for <lttng-dev@lists.lttng.org>; Fri, 06 Sep 2019 08:36:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190905191840.21430-1-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com, joraj@efficios.com
List-Id: lttng-dev@lists.lttng.org

Merged in master and stable-2.11. Thanks!

J=E9r=E9mie

On Thu, Sep 05, 2019 at 03:18:40PM -0400, Mathieu Desnoyers wrote:
> Creating a session with "lttng create --live" without specifying any
> URL triggers a NULL pointer exception because the output is not set

A NullPointerException, in C?! ;-)

> when getting the session descriptor base path.
> =

> Indeed, the destination output URL will only be set later in
> cmd_create_session_from_descriptor(), when setting the default output.
> =

> When the default output is used, no base path override is possible,
> therefore it is fine to assign the base_path to NULL in the base path
> getter.
> =

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  src/common/session-descriptor.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> =

> diff --git a/src/common/session-descriptor.c b/src/common/session-descrip=
tor.c
> index b5fdb067..208eb46f 100644
> --- a/src/common/session-descriptor.c
> +++ b/src/common/session-descriptor.c
> @@ -1186,8 +1186,12 @@ int lttng_session_descriptor_get_base_path(struct =
lttng_session_descriptor *dst,
>  	switch (dst->output_type) {
>  	case LTTNG_SESSION_DESCRIPTOR_OUTPUT_TYPE_NETWORK:
>  	{
> -		*_base_path =3D dst->output.network.control->subdir[0] ?
> -				dst->output.network.control->subdir : NULL;
> +		if (dst->output.network.control &&
> +				dst->output.network.control->subdir[0]) {
> +			*_base_path =3D dst->output.network.control->subdir;
> +		} else {
> +			*_base_path =3D NULL;
> +		}
>  		break;
>  	}
>  	case LTTNG_SESSION_DESCRIPTOR_OUTPUT_TYPE_LOCAL:
> -- =

> 2.11.0
> =
