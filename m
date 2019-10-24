From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools stable-2.11] fix: check for
 lttng-ust >= 2.11 at configure
Date: Thu, 24 Oct 2019 16:07:36 -0400
Message-ID: <20191024200736.GA149332__23556.8134159379$1571947683$gmane$org@gmail.com>
References: <20191023150834.6885-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by lists.lttng.org (Postfix) with ESMTPS id 46zdZh4V8kz1Ql2
 for <lttng-dev@lists.lttng.org>; Thu, 24 Oct 2019 16:07:40 -0400 (EDT)
Received: by mail-qk1-f194.google.com with SMTP id f18so24048541qkm.1
 for <lttng-dev@lists.lttng.org>; Thu, 24 Oct 2019 13:07:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20191023150834.6885-1-mjeanson@efficios.com>
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

Merged in master and stable-2.11. Thanks!

J=E9r=E9mie

On Wed, Oct 23, 2019 at 11:08:34AM -0400, Michael Jeanson wrote:
> We don't support building lttng-tools against an older version of
> lttng-ust, make this check explicitly at configure.
> =

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
>  configure.ac | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> =

> diff --git a/configure.ac b/configure.ac
> index 5c4073ef8..357e2b888 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -562,14 +562,13 @@ AC_ARG_WITH([lttng-ust],
>  =

>  AS_IF([test "x$with_lttng_ust" =3D "xyes"],
>    [
> -    AC_CHECK_LIB([lttng-ust-ctl], [ustctl_recv_channel_from_consumer],
> +    AC_CHECK_LIB([lttng-ust-ctl], [lttng_ust_enum_get_from_desc],
>        [
>          AC_DEFINE([HAVE_LIBLTTNG_UST_CTL], [1])
>        ],
>        [
> -        AC_MSG_FAILURE([Cannot find LTTng-UST >=3D 2.2.x. Use [LDFLAGS]=
=3D-Ldir and [CPPFLAGS]=3D-Idir to specify its location, or specify --witho=
ut-lttng-ust to build lttng-tools without LTTng-UST support.])
> -      ],
> -      [-lurcu-common -lurcu-bp -lurcu-cds -lrt -ldl]
> +        AC_MSG_FAILURE([Cannot find LTTng-UST >=3D 2.11.x. Use [LDFLAGS]=
=3D-Ldir and [CPPFLAGS]=3D-Idir to specify its location, or specify --witho=
ut-lttng-ust to build lttng-tools without LTTng-UST support.])
> +      ]
>      )
>    ]
>  )
> -- =

> 2.17.1
> =
