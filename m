From: Samuel Martin <s.martin49@gmail.com>
Subject: Re: [PATCH lttng-tools] Build: fallback to
 AC_CHECK_LIBS when looking for popt and uuid
Date: Wed, 2 Dec 2015 21:27:56 +0100
Message-ID: <CAHXCMMKN=NBvFnSqMUzPzfabSgzJULZSL5W8_c856GRAf+Yr8A__46772.5294678987$1449088199$gmane$org@mail.gmail.com>
References: <CA+jJMxsz6+erSA2joBgH2+PrYZrnaA-89m54=Gg3HeHyCXOxoQ@mail.gmail.com>
 <1449001141-25393-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <s.martin49@gmail.com>) id 1a4E16-0005xF-7R
 for lttng-dev@lists.lttng.org; Wed, 02 Dec 2015 15:28:50 -0500
Received: by pabfh17 with SMTP id fh17so51880297pab.0
 for <lttng-dev@lists.lttng.org>; Wed, 02 Dec 2015 12:28:36 -0800 (PST)
In-Reply-To: <1449001141-25393-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Hi all,

On Tue, Dec 1, 2015 at 9:19 PM, Jonathan Rajotte
<jonathan.rajotte-julien@efficios.com> wrote:
> Not all distro ship .pc so fallback to basic libs searching if necessary.
>
> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Reviewed-by: Samuel Martin <s.martin49@gmail.com>

Regards,

> ---
>  configure.ac | 48 +++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 35 insertions(+), 13 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 978e3bc..5537c15 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -214,13 +214,23 @@ AC_DEFINE_DIR([CONFIG_LTTNG_SYSTEM_DATADIR],[datadir], [LTTng system data direct
>  #
>  # Check for pthread
>  AC_CHECK_LIB([pthread], [pthread_create], [],
> -       [AC_MSG_ERROR([Cannot find libpthread. Use [LDFLAGS]=-Ldir to specify its location.])]
> +       [AC_MSG_ERROR([Cannot find libpthread. Use LDFLAGS=-Ldir to specify its location.])]
>  )
>
>  # Check libpopt
>  PKG_CHECK_MODULES([POPT], [popt],
>         [LIBS="$LIBS $POPT_LIBS"],
> -       [AC_MSG_ERROR([Cannot find libpopt. Use [LDFLAGS]=-Ldir to specify its location.])]
> +       [
> +               AC_MSG_WARN([pkg-config was unable to find a valid .pc for libpopt. Set PKG_CONFIG_PATH to specify the pkgconfig configuration file location])
> +               AC_MSG_WARN([Finding libpopt without pkg-config.])
> +               AC_CHECK_LIB([popt],
> +                       [poptGetContext],
> +                       [],
> +                       [
> +                                AC_MSG_ERROR([Cannot find libpopt. Either set PKG_CONFIG_PATH to the configuration file location or use LDFLAGS=-Ldir to specify the library location])
> +                       ]
> +               )
> +       ]
>  )
>
>  AM_PATH_XML2(2.7.6, true, AC_MSG_ERROR(No supported version of libxml2 found.))
> @@ -233,17 +243,29 @@ PKG_CHECK_MODULES([UUID], [uuid],
>         have_libuuid=yes
>  ],
>  [
> -       # libuuid not found, check for uuid_create in libc.
> -       AC_CHECK_LIB([c], [uuid_create],
> -       [
> -               AC_DEFINE_UNQUOTED([LTTNG_HAVE_LIBC_UUID], 1, [Has libc uuid support.])
> -               have_libc_uuid=yes
> -       ],
> -       [
> -               AC_MSG_ERROR([Cannot find libuuid uuid_generate nor libc uuid_create. Use [LDFLAGS]=-Ldir to specify their location.])
> -       ])
> -]
> -)
> +       AC_MSG_WARN([pkg-config was unable to find a valid .pc for libuuid. Set PKG_CONFIG_PATH to specify the pkgconfig configuration file location])
> +       AC_MSG_WARN([Finding libuuid without pkg-config.])
> +       AC_CHECK_LIB([uuid],
> +               [uuid_generate],
> +               [
> +                       AC_DEFINE_UNQUOTED([LTTNG_HAVE_LIBUUID], 1, [Has libuuid support.])
> +                       have_libuuid=yes
> +               ],
> +               [
> +                       # libuuid not found, check for uuid_create in libc.
> +                       AC_CHECK_LIB([c],
> +                               [uuid_create],
> +                               [
> +                                       AC_DEFINE_UNQUOTED([LTTNG_HAVE_LIBC_UUID], 1, [Has libc uuid support.])
> +                                       have_libc_uuid=yes
> +                               ],
> +                               [
> +                                       AC_MSG_ERROR([Cannot find libuuid uuid_generate nor libc uuid_create. Either set PKG_CONFIG_PATH to the configuration file location or use LDFLAGS=-Ldir to specify the library location])
> +                               ]
> +                       )
> +               ]
> +       )
> +])
>  AM_CONDITIONAL([LTTNG_BUILD_WITH_LIBUUID], [test "x$have_libuuid" = "xyes"])
>  AM_CONDITIONAL([LTTNG_BUILD_WITH_LIBC_UUID], [test "x$have_libc_uuid" = "xyes"])
>
> --
> 2.5.0
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- 
Samuel
