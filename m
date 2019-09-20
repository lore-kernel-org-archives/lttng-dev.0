From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Refactor: remove logically dead
 code
Date: Fri, 20 Sep 2019 17:22:38 -0400
Message-ID: <20190920212238.GA20024__32266.5368252032$1569014579$gmane$org@gmail.com>
References: <20190920154037.74966-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 by lists.lttng.org (Postfix) with ESMTPS id 46Zmry5v1KzqrD
 for <lttng-dev@lists.lttng.org>; Fri, 20 Sep 2019 17:22:42 -0400 (EDT)
Received: by mail-qt1-f193.google.com with SMTP id c3so10287416qtv.10
 for <lttng-dev@lists.lttng.org>; Fri, 20 Sep 2019 14:22:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190920154037.74966-1-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Merged in master and stable-2.11. Thanks!

J=E9r=E9mie

On Fri, Sep 20, 2019 at 11:40:37AM -0400, Jonathan Rajotte wrote:
> Fixes coverity #1400681
> =

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  src/common/session-descriptor.c | 6 ------
>  1 file changed, 6 deletions(-)
> =

> diff --git a/src/common/session-descriptor.c b/src/common/session-descrip=
tor.c
> index 208eb46ff..713731c3e 100644
> --- a/src/common/session-descriptor.c
> +++ b/src/common/session-descriptor.c
> @@ -550,14 +550,8 @@ lttng_session_descriptor_live_create(
>  	struct lttng_session_descriptor_live *descriptor;
>  =

>  	descriptor =3D _lttng_session_descriptor_live_create(name, live_timer_u=
s);
> -	if (!descriptor) {
> -		goto error;
> -	}
>  =

>  	return descriptor ? &descriptor->base : NULL;
> -error:
> -	lttng_session_descriptor_destroy(descriptor ? &descriptor->base : NULL);
> -	return NULL;
>  }
>  =

>  struct lttng_session_descriptor *
> -- =

> 2.17.1
> =
