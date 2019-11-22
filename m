From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Require automake >= 1.12
Date: Fri, 22 Nov 2019 18:06:23 -0500
Message-ID: <20191122230623.GB51696__43293.2131852553$1574464008$gmane$org@gmail.com>
References: <20191107190255.17406-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by lists.lttng.org (Postfix) with ESMTPS id 47KX9c0MzGz1R45
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 18:06:27 -0500 (EST)
Received: by mail-qk1-f194.google.com with SMTP id i3so7761173qkk.9
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 15:06:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20191107190255.17406-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Merged in master, stable-2.11, and stable-2.10.

Thanks!
J=E9r=E9mie

On Thu, Nov 07, 2019 at 02:02:55PM -0500, Michael Jeanson wrote:
> The test suite LOG_DRIVER statement requires that automake >=3D 1.12 be u=
sed
> during bootstrap.
> =

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/configure.ac b/configure.ac
> index d8ab1e0ac..10b338420 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -8,7 +8,7 @@ AC_CONFIG_MACRO_DIR([m4])
>  AC_CANONICAL_TARGET
>  AC_CANONICAL_HOST
>  =

> -AM_INIT_AUTOMAKE([foreign dist-bzip2 no-dist-gzip tar-pax nostdinc])
> +AM_INIT_AUTOMAKE([1.12 foreign dist-bzip2 no-dist-gzip tar-pax nostdinc])
>  AM_MAINTAINER_MODE([enable])
>  =

>  # Enable silent rules if available (Introduced in AM 1.11)
> -- =

> 2.17.1
> =
