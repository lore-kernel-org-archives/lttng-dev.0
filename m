From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [Babeltrace RFC PATCH 18/28] Add MinGW
 implementation of strnlen
Date: Mon, 13 May 2013 16:20:37 -0400
Message-ID: <CA+jJMxsnW7hep8TwRa7pBxxXwKLMFQ75dGQARyqPMdjxUgwqqA__36143.3187187233$1368476481$gmane$org@mail.gmail.com>
References: <009B25148989C6458484484699278506E537E951@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UbzEh-0001EW-Gk
	for lttng-dev@lists.lttng.org; Mon, 13 May 2013 16:20:43 -0400
Received: by mail-wi0-f179.google.com with SMTP id hq7so1621159wib.12
	for <lttng-dev@lists.lttng.org>; Mon, 13 May 2013 13:20:37 -0700 (PDT)
In-Reply-To: <009B25148989C6458484484699278506E537E951@EU-MBX-01.mgc.mentorg.com>
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

On Thu, May 2, 2013 at 8:00 AM, Ikaheimonen, JP
<jp_ikaheimonen@mentor.com> wrote:
> ---
>  compat/compat_strlib.c             | 23 +++++++++++++++++++++++
>  formats/ctf/types/string.c         |  2 +-
>  include/babeltrace/compat/string.h |  1 +
>  3 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/compat/compat_strlib.c b/compat/compat_strlib.c
> index 3cbd455..980a8f5 100644
> --- a/compat/compat_strlib.c
> +++ b/compat/compat_strlib.c
> @@ -50,6 +50,29 @@ int strerror_r(int errnum, char *buf, size_t buflen)
>         buf[buflen - 1] =3D '\0';
>         return 0;
>  }
> +
> +size_t strnlen(const char *str, size_t maxlen)
> +{

Any reason you are not using the native strnlen? I'm fairly sure it is
available on Windows.
I know MinGW does not provide some standard function prototypes (may
or may not be the case here)... I think finding the function's address
explicitly would be more appropriate here (using GetProcAddress on
msvcrt.dll).

> +       char * ptr;
> +       size_t len;
> +       ptr =3D (char *)str;
> +       len =3D 0;
> +
> +       /* while there still are characters in the string */
> +       while(*ptr !=3D '\0') {
> +               /* increment counter */
> +               len++;
> +               /* check that we do not exceed the given maximum */
> +               if (len =3D=3D maxlen) {
> +                       return len;
> +               }
> +               /* next character */
> +               ptr++;
> +
> +       }
> +       return len;
> +}
> +
>  #endif
>
>  int compat_strerror_r(int errnum, char *buf, size_t buflen)
> diff --git a/formats/ctf/types/string.c b/formats/ctf/types/string.c
> index a2433bf..a2f513d 100644
> --- a/formats/ctf/types/string.c
> +++ b/formats/ctf/types/string.c
> @@ -29,7 +29,7 @@
>  #include <babeltrace/babeltrace-internal.h>
>  #include <babeltrace/ctf/types.h>
>  #include <limits.h>            /* C99 limits */
> -#include <string.h>
> +#include <babeltrace/compat/string.h>
>
>  int ctf_string_read(struct bt_stream_pos *ppos, struct bt_definition *de=
finition)
>  {
> diff --git a/include/babeltrace/compat/string.h b/include/babeltrace/comp=
at/string.h
> index 501d003..82f411e 100644
> --- a/include/babeltrace/compat/string.h
> +++ b/include/babeltrace/compat/string.h
> @@ -5,6 +5,7 @@
>
>  #ifdef __MINGW32__
>  char *strtok_r(char *str, const char *delim, char **nextp);
> +size_t strnlen(const char *str, size_t maxlen);
>  #endif
>
>  int compat_strerror_r(int errnum, char *buf, size_t buflen);
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
