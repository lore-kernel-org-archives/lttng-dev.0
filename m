From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [Babeltrace RFC PATCH 16/28] Add MinGW
 implementation of strtok_r
Date: Mon, 13 May 2013 16:20:41 -0400
Message-ID: <CA+jJMxuSz3vfudEn2QaP9eMScHTQMtoNk2A3Xub7HYPEasGMJw__23781.9962938831$1368476489$gmane$org@mail.gmail.com>
References: <009B25148989C6458484484699278506E537E92F@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UbzEl-0001F9-PM
	for lttng-dev@lists.lttng.org; Mon, 13 May 2013 16:20:47 -0400
Received: by mail-wi0-f172.google.com with SMTP id ey16so1341166wid.11
	for <lttng-dev@lists.lttng.org>; Mon, 13 May 2013 13:20:42 -0700 (PDT)
In-Reply-To: <009B25148989C6458484484699278506E537E92F@EU-MBX-01.mgc.mentorg.com>
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

On Thu, May 2, 2013 at 7:57 AM, Ikaheimonen, JP
<jp_ikaheimonen@mentor.com> wrote:
> ---
>  compat/compat_strlib.c             | 40 ++++++++++++++++++++++++++++++++=
++++++
>  converter/babeltrace.c             |  2 +-
>  include/babeltrace/compat/string.h |  4 ++++
>  3 files changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/compat/compat_strlib.c b/compat/compat_strlib.c
> index 7413e74..3cbd455 100644
> --- a/compat/compat_strlib.c
> +++ b/compat/compat_strlib.c
> @@ -1,6 +1,46 @@
>  #include <babeltrace/compat/string.h>
>
>  #ifdef __MINGW32__
> +
> +char* strtok_r(

Any reason you can't use strtok_s?

> +       char *str,
> +       const char *delim,
> +       char **nextp)
> +{
> +       char *ret;
> +
> +       /* if str is NULL, continue from nextp */
> +       if (str =3D=3D NULL) {
> +               str =3D *nextp;
> +       }
> +       /* skip the leading delimiter characters */
> +       str +=3D strspn(str, delim);
> +
> +       /* return NULL if all are delimiters */
> +       if (*str =3D=3D '\0') {
> +               return NULL;
> +       }
> +       /* return the pointer to the first character that is not delimite=
r */
> +       ret =3D str;
> +
> +       /* scan to the next delimiter */
> +       str +=3D strcspn(str, delim);
> +
> +       /* if we found a delimiter instead of a NUL */
> +       if (*str) {
> +               /* replace the delimiter with the NUL */
> +               *str =3D '\0';
> +               /* next time, scan from the character after NUL */
> +               *nextp =3D str + 1;
> +       }
> +       else {
> +               /* end of string: next time, scan at the end (NUL) again =
*/
> +               *nextp =3D str;
> +       }
> +
> +       return ret;
> +}
> +
>  int strerror_r(int errnum, char *buf, size_t buflen)
>  {
>         /* non-recursive implementation of strerror_r */
> diff --git a/converter/babeltrace.c b/converter/babeltrace.c
> index 7b3db49..f4a9217 100644
> --- a/converter/babeltrace.c
> +++ b/converter/babeltrace.c
> @@ -49,7 +49,7 @@
>  #include <unistd.h>
>  #include <inttypes.h>
>  #include <babeltrace/compat/ftw.h>
> -#include <string.h>
> +#include <babeltrace/compat/string.h>
>
>  #include <babeltrace/ctf-ir/metadata.h>        /* for clocks */
>
> diff --git a/include/babeltrace/compat/string.h b/include/babeltrace/comp=
at/string.h
> index 8591b7e..501d003 100644
> --- a/include/babeltrace/compat/string.h
> +++ b/include/babeltrace/compat/string.h
> @@ -3,6 +3,10 @@
>
>  #include <string.h>
>
> +#ifdef __MINGW32__
> +char *strtok_r(char *str, const char *delim, char **nextp);
> +#endif
> +
>  int compat_strerror_r(int errnum, char *buf, size_t buflen);
>
>  #endif
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
