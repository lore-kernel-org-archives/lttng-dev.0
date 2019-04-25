From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools 1/1] Fix: relayd: handling of
 lttng_read errors >= 0
Date: Thu, 25 Apr 2019 14:27:31 -0400
Message-ID: <20190425182730.GD4708__11496.3828864106$1556216867$gmane$org@gmail.com>
References: <20190403202645.29404-1-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 by lists.lttng.org (Postfix) with ESMTPS id 44qlzB3j08z1Knp
 for <lttng-dev@lists.lttng.org>; Thu, 25 Apr 2019 14:27:34 -0400 (EDT)
Received: by mail-qk1-f195.google.com with SMTP id f125so348174qke.6
 for <lttng-dev@lists.lttng.org>; Thu, 25 Apr 2019 11:27:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190403202645.29404-1-mathieu.desnoyers@efficios.com>
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
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Merged in master, stable-2.11, stable-2.10, and stable-2.9.

Thanks!
J=E9r=E9mie

On Wed, Apr 03, 2019 at 04:26:45PM -0400, Mathieu Desnoyers wrote:
> errno is only set when lttng_read returns a negative value. Else, we
> need to print a ERR() statement rather than use PERROR().
> =

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  src/common/index/index.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> =

> diff --git a/src/common/index/index.c b/src/common/index/index.c
> index 12d54e00..9bfb56fa 100644
> --- a/src/common/index/index.c
> +++ b/src/common/index/index.c
> @@ -171,10 +171,14 @@ int lttng_index_file_read(const struct lttng_index_=
file *index_file,
>  	}
>  =

>  	ret =3D lttng_read(fd, element, len);
> -	if (ret < len) {
> +	if (ret < 0) {
>  		PERROR("read index file");
>  		goto error;
>  	}
> +	if (ret < len) {
> +		ERR("lttng_read expected %zu, returned %zd", len, ret);
> +		goto error;
> +	}
>  	return 0;
>  =

>  error:
> -- =

> 2.17.1
> =
