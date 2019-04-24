From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools v4 4/8] Adapt poll layer
 behaviour to match the epoll layer
Date: Wed, 24 Apr 2019 17:02:18 -0400
Message-ID: <20190424210217.GA4486__41593.4004400455$1556139761$gmane$org@gmail.com>
References: <20190401175925.8512-1-ylamarre@efficios.com>
 <20190401175925.8512-5-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 by lists.lttng.org (Postfix) with ESMTPS id 44qCSG3JhQz1Jx4
 for <lttng-dev@lists.lttng.org>; Wed, 24 Apr 2019 17:02:22 -0400 (EDT)
Received: by mail-qt1-f194.google.com with SMTP id j6so2793428qtq.1
 for <lttng-dev@lists.lttng.org>; Wed, 24 Apr 2019 14:02:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190401175925.8512-5-ylamarre@efficios.com>
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

On Mon, Apr 01, 2019 at 01:59:21PM -0400, Yannick Lamarre wrote:
> Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
> ---
>  src/common/compat/compat-poll.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> =

> diff --git a/src/common/compat/compat-poll.c b/src/common/compat/compat-p=
oll.c
> index b45b39dc..be655728 100644
> --- a/src/common/compat/compat-poll.c
> +++ b/src/common/compat/compat-poll.c
> @@ -1,5 +1,6 @@
>  /*
>   * Copyright (C)  2011 - David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C)  2019 - Yannick Lamarre <ylamarre@efficios.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License, version 2 only,
> @@ -204,10 +205,10 @@ int compat_poll_mod(struct lttng_poll_event *events=
, int fd,
>  		uint32_t req_events)
>  {
>  	int i;
> -	bool fd_found =3D false;
>  	struct compat_poll_event_array *current;
>  =

> -	if (events =3D=3D NULL || events->current.events =3D=3D NULL || fd < 0)=
 {
> +	if (events =3D=3D NULL || events->current.nb_fd =3D=3D 0 ||
> +			events->current.events =3D=3D NULL || fd < 0) {
>  		ERR("Bad compat poll mod arguments");
>  		goto error;
>  	}
> @@ -216,16 +217,16 @@ int compat_poll_mod(struct lttng_poll_event *events=
, int fd,
>  =

>  	for (i =3D 0; i < current->nb_fd; i++) {
>  		if (current->events[i].fd =3D=3D fd) {
> -			fd_found =3D true;
>  			current->events[i].events =3D req_events;
>  			events->need_update =3D 1;
>  			break;
>  		}
>  	}
>  =

> -	if (!fd_found) {
> -		goto error;
> -	}
> +	/*

Remove space after '/*'

Thanks!
J=E9r=E9mie

> +	 * The epoll flavor doesn't flag modifying a non-included FD as an
> +	 * error.
> +	 */
>  =

>  	return 0;
>  =

> @@ -238,11 +239,12 @@ error:
>   */
>  int compat_poll_del(struct lttng_poll_event *events, int fd)
>  {
> -	int new_size, i, count =3D 0, ret;
> +	int i, count =3D 0, ret;
> +	uint32_t new_size;
>  	struct compat_poll_event_array *current;
>  =

> -	if (events =3D=3D NULL || events->current.events =3D=3D NULL || fd < 0)=
 {
> -		ERR("Wrong arguments for poll del");
> +	if (events =3D=3D NULL || events->current.nb_fd =3D=3D 0 ||
> +			events->current.events =3D=3D NULL || fd < 0) {
>  		goto error;
>  	}
>  =

> @@ -257,13 +259,20 @@ int compat_poll_del(struct lttng_poll_event *events=
, int fd)
>  			count++;
>  		}
>  	}
> +
> +	/* The fd was not in our set, return no error as with epoll. */
> +	if (current->nb_fd =3D=3D count) {
> +		goto end;
> +	}
> +
>  	/* No fd duplicate should be ever added into array. */
>  	assert(current->nb_fd - 1 =3D=3D count);
>  	current->nb_fd =3D count;
>  =

>  	/* Resize array if needed. */
>  	new_size =3D 1U << utils_get_count_order_u32(current->nb_fd);
> -	if (new_size !=3D current->alloc_size && new_size >=3D current->init_si=
ze) {
> +	if (new_size !=3D current->alloc_size && new_size >=3D current->init_si=
ze
> +			&& current->nb_fd !=3D 0) {
>  		ret =3D resize_poll_event(current, new_size);
>  		if (ret < 0) {
>  			goto error;
> @@ -272,6 +281,7 @@ int compat_poll_del(struct lttng_poll_event *events, =
int fd)
>  =

>  	events->need_update =3D 1;
>  =

> +end:
>  	return 0;
>  =

>  error:
> -- =

> 2.11.0
> =
