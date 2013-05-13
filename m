From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [Babeltrace RFC PATCH 03/28] Move build-specific
 strerror_r to compat directory
Date: Mon, 13 May 2013 16:21:08 -0400
Message-ID: <CA+jJMxveqYEEqNeUJoqO50Te4k3hdF8_AHvuWFC=sRfJZjO=Zg__15684.2361706824$1368476519$gmane$org@mail.gmail.com>
References: <009B25148989C6458484484699278506E537E844@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UbzFD-0001JU-W7
	for lttng-dev@lists.lttng.org; Mon, 13 May 2013 16:21:16 -0400
Received: by mail-wg0-f47.google.com with SMTP id e11so6856530wgh.14
	for <lttng-dev@lists.lttng.org>; Mon, 13 May 2013 13:21:09 -0700 (PDT)
In-Reply-To: <009B25148989C6458484484699278506E537E844@EU-MBX-01.mgc.mentorg.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Thu, May 2, 2013 at 7:46 AM, Ikaheimonen, JP
<jp_ikaheimonen@mentor.com> wrote:
> Add a new source directory 'compat'.
> In that directory, add a new file 'strlib.c'.
> In that file, add a new function compat_strerror_r that encapsulates
> the build-specific differences of strerror_r.
> Where strerror_r is used, now use compat_strerror_r.
> ---
>  Makefile.am                              |  2 +-
>  compat/Makefile.am                       | 10 ++++++++++
>  compat/compat_strlib.c                   | 17 +++++++++++++++++
>  configure.ac                             |  1 +
>  include/babeltrace/babeltrace-internal.h | 32 +++-----------------------=
------
>  include/babeltrace/compat/string.h       |  9 +++++++++
>  lib/Makefile.am                          |  3 ++-
>  7 files changed, 43 insertions(+), 31 deletions(-)
>  create mode 100644 compat/Makefile.am
>  create mode 100644 compat/compat_strlib.c
>  create mode 100644 include/babeltrace/compat/string.h
>
> diff --git a/Makefile.am b/Makefile.am
> index b25b58f..cdfad5a 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -2,7 +2,7 @@ AM_CFLAGS =3D $(PACKAGE_CFLAGS) -I$(top_srcdir)/include
>
>  ACLOCAL_AMFLAGS =3D -I m4
>
> -SUBDIRS =3D include types lib formats converter tests doc extras
> +SUBDIRS =3D include types compat lib formats converter tests doc extras
>
>  dist_doc_DATA =3D ChangeLog LICENSE mit-license.txt gpl-2.0.txt \
>                 std-ext-lib.txt
> diff --git a/compat/Makefile.am b/compat/Makefile.am
> new file mode 100644
> index 0000000..d756aa7
> --- /dev/null
> +++ b/compat/Makefile.am
> @@ -0,0 +1,10 @@
> +AM_CFLAGS =3D $(PACKAGE_CFLAGS) -I$(top_srcdir)/include
> +
> +lib_LTLIBRARIES =3D libcompat.la
> +
> +libcompat_la_SOURCES =3D \
> +       compat_strlib.c
> +
> +libcompat_la_LDFLAGS =3D \
> +       -Wl,--no-as-needed
> +
> diff --git a/compat/compat_strlib.c b/compat/compat_strlib.c
> new file mode 100644
> index 0000000..9aabb07
> --- /dev/null
> +++ b/compat/compat_strlib.c
> @@ -0,0 +1,17 @@
> +#include <babeltrace/compat/string.h>
> +
> +int compat_strerror_r(int errnum, char *buf, size_t buflen)

Is there a specific reason why you can't redefine this as a macro
instead of changing the function's name?

> +{
> +#if !defined(__linux__) || ((_POSIX_C_SOURCE >=3D 200112L || _XOPEN_SOUR=
CE >=3D 600) && !defined(_GNU_SOURCE))
> +/* XSI-compliant strerror_r */
> +       return strerror_r(errnum, buf, buflen);
> +#else
> +/* GNU-compliant strerror_r */
> +       char * retbuf;
> +       retbuf =3D strerror_r(errnum, buf, buflen);
> +       if (retbuf !=3D buf)
> +               strcpy(buf, retbuf);
> +       return 0;
> +#endif
> +}
> +
> diff --git a/configure.ac b/configure.ac
> index 83822d6..29366da 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -93,6 +93,7 @@ AC_SUBST(babeltracectfincludedir)
>  AC_CONFIG_FILES([
>         Makefile
>         types/Makefile
> +       compat/Makefile
>         formats/Makefile
>         formats/ctf/Makefile
>         formats/ctf/types/Makefile
> diff --git a/include/babeltrace/babeltrace-internal.h b/include/babeltrac=
e/babeltrace-internal.h
> index 22866bc..35382de 100644
> --- a/include/babeltrace/babeltrace-internal.h
> +++ b/include/babeltrace/babeltrace-internal.h
> @@ -27,7 +27,7 @@
>  #include <stdio.h>
>  #include <glib.h>
>  #include <stdint.h>
> -#include <string.h>
> +#include <babeltrace/compat/string.h>
>
>  #define PERROR_BUFLEN  200
>
> @@ -81,46 +81,20 @@ extern int babeltrace_verbose, babeltrace_debug;
>                 perrorstr,                                              \
>                 ## args)
>
> -#if !defined(__linux__) || ((_POSIX_C_SOURCE >=3D 200112L || _XOPEN_SOUR=
CE >=3D 600) && !defined(_GNU_SOURCE))
> -
>  #define _bt_printf_perror(fp, fmt, args...)                            \
>         ({                                                              \
>                 char buf[PERROR_BUFLEN] =3D "Error in strerror_r()";     =
 \
> -               strerror_r(errno, buf, sizeof(buf));                    \
> +               compat_strerror_r(errno, buf, sizeof(buf));              =
       \
>                 _bt_printfe(fp, "error", buf, fmt, ## args);            \
>         })
>
>  #define _bt_printfl_perror(fp, lineno, fmt, args...)                   \
>         ({                                                              \
>                 char buf[PERROR_BUFLEN] =3D "Error in strerror_r()";     =
 \
> -               strerror_r(errno, buf, sizeof(buf));                    \
> +               compat_strerror_r(errno, buf, sizeof(buf));              =
       \
>                 _bt_printfle(fp, "error", lineno, buf, fmt, ## args);   \
>         })
>
> -#else
> -
> -/*
> - * Version using GNU strerror_r, for linux with appropriate defines.
> - */
> -
> -#define _bt_printf_perror(fp, fmt, args...)                            \
> -       ({                                                              \
> -               char *buf;                                              \
> -               char tmp[PERROR_BUFLEN] =3D "Error in strerror_r()";     =
 \
> -               buf =3D strerror_r(errno, tmp, sizeof(tmp));             =
 \
> -               _bt_printfe(fp, "error", buf, fmt, ## args);            \
> -       })
> -
> -#define _bt_printfl_perror(fp, lineno, fmt, args...)                   \
> -       ({                                                              \
> -               char *buf;                                              \
> -               char tmp[PERROR_BUFLEN] =3D "Error in strerror_r()";     =
 \
> -               buf =3D strerror_r(errno, tmp, sizeof(tmp));             =
 \
> -               _bt_printfle(fp, "error", lineno, buf, fmt, ## args);   \
> -       })
> -
> -#endif
> -
>  /* printf without lineno information */
>  #define printf_fatal(fmt, args...)                                     \
>         _bt_printf(stderr, "fatal", fmt, ## args)
> diff --git a/include/babeltrace/compat/string.h b/include/babeltrace/comp=
at/string.h
> new file mode 100644
> index 0000000..8591b7e
> --- /dev/null
> +++ b/include/babeltrace/compat/string.h
> @@ -0,0 +1,9 @@
> +#ifndef _BABELTRACE_COMPAT_STRING_H
> +#define BABELTRACE_COMPAT_STRING_H
> +
> +#include <string.h>
> +
> +int compat_strerror_r(int errnum, char *buf, size_t buflen);
> +
> +#endif
> +
> diff --git a/lib/Makefile.am b/lib/Makefile.am
> index 7ffb164..fa470c0 100644
> --- a/lib/Makefile.am
> +++ b/lib/Makefile.am
> @@ -14,4 +14,5 @@ libbabeltrace_la_SOURCES =3D babeltrace.c \
>  libbabeltrace_la_LDFLAGS =3D \
>         -Wl,--no-as-needed \
>         prio_heap/libprio_heap.la \
> -       $(top_builddir)/types/libbabeltrace_types.la
> +       $(top_builddir)/types/libbabeltrace_types.la \
> +       $(top_builddir)/compat/libcompat.la
> --
> 1.8.1.msysgit.1
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
