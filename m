From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [babeltrace RFC PATCH 06/28] Add MinGW
 implementation of UUID
Date: Mon, 13 May 2013 16:21:15 -0400
Message-ID: <CA+jJMxtgSOtb4eLTywoxyKuy19S1igCZQFaTTk7rAyYd6ZbFaA__32860.334419138$1368480386$gmane$org@mail.gmail.com>
References: <009B25148989C6458484484699278506E537E866@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f173.google.com ([74.125.82.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UbzFO-0001Kt-VJ
	for lttng-dev@lists.lttng.org; Mon, 13 May 2013 16:21:27 -0400
Received: by mail-we0-f173.google.com with SMTP id q54so6589369wes.32
	for <lttng-dev@lists.lttng.org>; Mon, 13 May 2013 13:21:21 -0700 (PDT)
In-Reply-To: <009B25148989C6458484484699278506E537E866@EU-MBX-01.mgc.mentorg.com>
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

On Thu, May 2, 2013 at 7:47 AM, Ikaheimonen, JP
<jp_ikaheimonen@mentor.com> wrote:
> Implementation of UUID functions for MinGW32, using Windows API.
> ---
>  compat/Makefile.am               |  3 ++
>  compat/compat_uuid.c             | 75 ++++++++++++++++++++++++++++++++++=
++++++
>  configure.ac                     |  5 ++-
>  include/babeltrace/compat/uuid.h | 32 ++++++++++++++++-
>  4 files changed, 113 insertions(+), 2 deletions(-)
>  create mode 100644 compat/compat_uuid.c
>
> diff --git a/compat/Makefile.am b/compat/Makefile.am
> index d756aa7..e624a79 100644
> --- a/compat/Makefile.am
> +++ b/compat/Makefile.am
> @@ -8,3 +8,6 @@ libcompat_la_SOURCES =3D \
>  libcompat_la_LDFLAGS =3D \
>         -Wl,--no-as-needed
>
> +if BABELTRACE_BUILD_WITH_MINGW
> +libcompat_la_SOURCES +=3D compat_uuid.c
> +endif
> \ No newline at end of file
> diff --git a/compat/compat_uuid.c b/compat/compat_uuid.c
> new file mode 100644
> index 0000000..0e67f73
> --- /dev/null
> +++ b/compat/compat_uuid.c
> @@ -0,0 +1,75 @@
> +/* This file is only built under MINGW32 */
> +
> +#include <windows.h>
> +#include <stdlib.h>
> +#include <babeltrace/compat/uuid.h>
> +
> +static void fix_uuid_endian(struct UUID * uuid)
> +{
> +       unsigned char * ptr;
> +       unsigned char tmp;
> +       #define SWAP(p, i, j) tmp=3D*(p+i);*(p+i)=3D*(p+j);*(p+j)=3Dtmp;
> +       ptr =3D (unsigned char *)uuid;
> +       SWAP(ptr, 0, 3)
> +       SWAP(ptr, 1, 2)
> +       SWAP(ptr, 4, 5)
> +       SWAP(ptr, 6, 7)
> +
> +}
> +
> +int compat_uuid_generate(unsigned char *uuid_out)
> +{
> +       RPC_STATUS status;
> +       status =3D UuidCreate((struct UUID *)uuid_out);
> +       if (status =3D=3D RPC_S_OK)
> +               return 0;
> +       else
> +               return -1;
> +}
> +
> +int compat_uuid_unparse(const unsigned char *uuid_in, char *str_out)
> +{
> +       RPC_STATUS status;
> +       unsigned char *alloc_str;
> +       int ret;
> +       fix_uuid_endian(uuid_in);
> +       status =3D UuidToString((struct UUID *)uuid_in, &alloc_str);
> +       fix_uuid_endian(uuid_in);
> +       if (status =3D=3D RPC_S_OK) {
> +               strcpy(str_out, alloc_str);
> +               ret =3D 0;
> +       } else {
> +               ret =3D -1;
> +       }
> +       RpcStringFree(alloc_str);
> +       return ret;
> +}
> +
> +int compat_uuid_parse(const char *str_in, unsigned char *uuid_out)
> +{
> +       RPC_STATUS status;
> +
> +       status =3D UuidFromString(str_in, (struct UUID *)uuid_out);
> +       fix_uuid_endian(uuid_out);
> +
> +       if (status =3D=3D RPC_S_OK)
> +               return 0;
> +       else
> +               return -1;
> +}
> +
> +int compat_uuid_compare(const unsigned char *uuid_a,
> +               const unsigned char *uuid_b)
> +{
> +       RPC_STATUS status;
> +       int ret;
> +
> +       if (UuidCompare((struct UUID *)uuid_a, (struct UUID *)uuid_b, &st=
atus) =3D=3D 0)
> +               ret =3D 0;
> +       else
> +       {
> +               ret =3D -1;
> +       }
> +       return ret;
> +
> +}
> diff --git a/configure.ac b/configure.ac
> index 65e867c..5f9e38d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -60,7 +60,10 @@ AC_CHECK_LIB([uuid], [uuid_generate],
>                 have_libc_uuid=3Dyes
>         ],
>         [
> -               AC_MSG_ERROR([Cannot find libuuid uuid_generate nor libc =
uuid_create. Use [LDFLAGS]=3D-Ldir to specify their location.])
> +               # for MinGW32 we have our own internal implemenation of u=
uid using Windows functions.
> +               if test "x$MINGW32" =3D xno; then
> +                       AC_MSG_ERROR([Cannot find libuuid uuid_generate n=
or libc uuid_create. Use [LDFLAGS]=3D-Ldir to specify their location.])
> +               fi
>         ])
>  ]
>  )
> diff --git a/include/babeltrace/compat/uuid.h b/include/babeltrace/compat=
/uuid.h
> index 2ce7467..a916a49 100644
> --- a/include/babeltrace/compat/uuid.h
> +++ b/include/babeltrace/compat/uuid.h
> @@ -122,8 +122,38 @@ int babeltrace_uuid_compare(const unsigned char *uui=
d_a,
>                 return -1;
>  }
>
> +#elif defined(__MINGW32__)
> +static inline
> +int babeltrace_uuid_generate(unsigned char *uuid_out)
> +{
> +       extern int compat_uuid_generate(unsigned char *uuid_out);
> +       return compat_uuid_generate(uuid_out);
> +}
> +
> +static inline
> +int babeltrace_uuid_unparse(const unsigned char *uuid_in, char *str_out)
> +{
> +       extern int compat_uuid_unparse(const unsigned char *uuid_in, char=
 *str_out);
> +       return compat_uuid_unparse(uuid_in, str_out);
> +}
> +
> +static inline
> +int babeltrace_uuid_parse(const char *str_in, unsigned char *uuid_out)
> +{
> +       extern int compat_uuid_parse(const char *str_in, unsigned char *u=
uid_out);
> +       return compat_uuid_parse(str_in, uuid_out);
> +}
> +
> +static inline
> +int babeltrace_uuid_compare(const unsigned char *uuid_a,
> +               const unsigned char *uuid_b)
> +{
> +       extern int compat_uuid_compare(const unsigned char *uuid_a,
> +               const unsigned char *uuid_b);
> +       return compat_uuid_compare(uuid_a, uuid_b);
> +}
>  #else
>  #error "Babeltrace needs to have a UUID generator configured."
>  #endif
>
> -#endif /* _BABELTRACE_UUID_H */
> +#endif /* _BABELTRACE_INCLUDE_COMPAT_UUID_H */

Please change this at the beginning of the file too.

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
