From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [Babeltrace RFC PATCH 11/28] Add MinGW
 implementation of gmtime_r
Date: Mon, 13 May 2013 16:20:56 -0400
Message-ID: <CA+jJMxvAtfUuaMLEphuu1Q5-na=iZFjGUj4kFp0A2DELHQajZw__22839.6017606885$1368476505$gmane$org@mail.gmail.com>
References: <009B25148989C6458484484699278506E537E8D8@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UbzF0-0001H6-9D
	for lttng-dev@lists.lttng.org; Mon, 13 May 2013 16:21:02 -0400
Received: by mail-wg0-f42.google.com with SMTP id j13so3350183wgh.5
	for <lttng-dev@lists.lttng.org>; Mon, 13 May 2013 13:20:56 -0700 (PDT)
In-Reply-To: <009B25148989C6458484484699278506E537E8D8@EU-MBX-01.mgc.mentorg.com>
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

On Thu, May 2, 2013 at 7:52 AM, Ikaheimonen, JP
<jp_ikaheimonen@mentor.com> wrote:
> Add a (non-recursive) implementation of gmtime_r as it is
> missing in the MinGW standard library.
> Implementation is written in file include/babeltrace/compat/time.h
> which must be included in the source files that call gmtime_r.
> ---
>  formats/ctf/ctf.c                |  1 +
>  include/babeltrace/compat/time.h | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
>  create mode 100644 include/babeltrace/compat/time.h
>
> diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
> index 0cfad44..255a492 100644
> --- a/formats/ctf/ctf.c
> +++ b/formats/ctf/ctf.c
> @@ -52,6 +52,7 @@
>  #include "metadata/ctf-ast.h"
>  #include "events-private.h"
>  #include "babeltrace/compat/memstream.h"
> +#include <babeltrace/compat/time.h>
>
>  #define LOG2_CHAR_BIT  3
>
> diff --git a/include/babeltrace/compat/time.h b/include/babeltrace/compat=
/time.h
> new file mode 100644
> index 0000000..ccfc860
> --- /dev/null
> +++ b/include/babeltrace/compat/time.h
> @@ -0,0 +1,19 @@
> +#ifndef _BABELTRACE_INCLUDE_COMPAT_TIME_H
> +#define _BABELTRACE_INCLUDE_COMPAT_TIME_H
> +
> +#include <time.h>
> +#include <stdlib.h>
> +
> +#ifdef __MINGW32__
> +
> +static inline
> +struct tm *gmtime_r(const time_t *timep, struct tm *result)
> +{
> +       struct tm * r;
> +       r =3D gmtime(timep);
> +       memcpy(result, r, sizeof (struct tm));
> +       return result;
> +}

Why not use gmtime_s? Inverting the arguments should do the trick.

> +
> +#endif
> +#endif
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
