From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Add --with-lttng-ust-prefix
	config option.
Date: Fri, 10 May 2013 12:14:18 -0400
Message-ID: <518D1CDA.1000400__39854.3675117709$1368202498$gmane$org@efficios.com>
References: <5176C890.6060607@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Uapxh-0007c2-S6
	for lttng-dev@lists.lttng.org; Fri, 10 May 2013 12:14:26 -0400
In-Reply-To: <5176C890.6060607@codesourcery.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stefan Seefeld <stefan@codesourcery.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Stefan,

This patch and "Add --version command-line option to lttng." where
probably wrapped to 80 character by your mail client or something else
making them "corrupted" for merging.

See below.

Stefan Seefeld:
> This patch adds a configure option to the lttng-tools build system to
> support lttng-ust being installed in a non-default location.
> While configure.ac indicated to use "LDFLAGS=-L<prefix>/lib" for this,
> in reality this doesn't work since the include search path needs to be
> adjusted as well. The patch sets both of these by means of a single new
> config option.
> 
> 
> Signed-off-by: Stefan Seefeld <stefan@codesourcery.com>
> ---
>  configure.ac | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 4f85fc1..5b37780 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -163,6 +163,15 @@ AC_CHECK_DECL([caa_likely], [],
>      [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])],
> [[#include <urcu.h>]]

For instance, here the include should be on the first line. More below.

Can you resend one without wrapping the lines?

Thanks!
David

>  )
>  
> +AC_ARG_WITH(lttng-ust-prefix,
> +  AS_HELP_STRING([--with-lttng-ust-prefix=PATH],
> +                 [Specify the installation prefix of the lttng-ust library.
> +              Headers must be in PATH/include; libraries in PATH/lib.]),
> +          [
> +            CPPFLAGS="$CPPFLAGS -I${withval}/include"
> +            LDFLAGS="$LDFLAGS -L${withval}/lib64 -L${withval}/lib"
> +          ])
> +
>  # Check liblttng-ust-ctl library
>  AC_ARG_ENABLE(lttng-ust,
>      AS_HELP_STRING([--disable-lttng-ust],[build without LTTng-UST
> (Userspace Tracing) support]),
> @@ -174,7 +183,7 @@ AS_IF([test "x$lttng_ust_support" = "xyes"], [
>              AC_DEFINE([HAVE_LIBLTTNG_UST_CTL], [1], [has LTTng-UST
> control support])
>              lttng_ust_ctl_found=yes
>          ],
> -        [AC_MSG_ERROR([Cannot find LTTng-UST 2.1.x. Use [LDFLAGS]=-Ldir
> to specify its location, or specify --disable-lttng-ust to build
> lttng-tools without LTTng-UST support.])],
> +        [AC_MSG_ERROR([Cannot find LTTng-UST >= 2.1.x. Use
> --with-lttng-ust-prefix=PREFIX to specify its location, or specify
> --disable-lttng-ust to build lttng-tools without LTTng-UST support.])],
>          [-lurcu-common -lurcu-bp -lurcu-cds -lrt]
>      )
>  ])
