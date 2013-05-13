From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [Babeltrace RFC PATCH 19/28] Add MinGW
 implementation of posix_fallocate
Date: Mon, 13 May 2013 16:20:32 -0400
Message-ID: <CA+jJMxuojA2Lb65v1MGf-MZ7HN0dTn6otXKGjx+LiBe5JNg8Zg__25325.2107454047$1368476479$gmane$org@mail.gmail.com>
References: <009B25148989C6458484484699278506E537E962@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UbzEc-0001Dg-Kr
	for lttng-dev@lists.lttng.org; Mon, 13 May 2013 16:20:38 -0400
Received: by mail-wg0-f54.google.com with SMTP id x12so6541511wgg.21
	for <lttng-dev@lists.lttng.org>; Mon, 13 May 2013 13:20:32 -0700 (PDT)
In-Reply-To: <009B25148989C6458484484699278506E537E962@EU-MBX-01.mgc.mentorg.com>
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
> Add dummy MinGW implementation of posix_fallocate.
> The implementation does not do anything, and always returns zero.
> ---
>  formats/ctf/ctf.c                 |  2 +-
>  include/babeltrace/compat/fcntl.h | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>  create mode 100644 include/babeltrace/compat/fcntl.h
>
> diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
> index c29fcd7..431b2d4 100644
> --- a/formats/ctf/ctf.c
> +++ b/formats/ctf/ctf.c
> @@ -41,7 +41,7 @@
>  #include <errno.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> -#include <fcntl.h>
> +#include <babeltrace/compat/fcntl.h>
>  #include <dirent.h>
>  #include <glib.h>
>  #include <babeltrace/compat/unistd.h>
> diff --git a/include/babeltrace/compat/fcntl.h b/include/babeltrace/compa=
t/fcntl.h
> new file mode 100644
> index 0000000..0707c28
> --- /dev/null
> +++ b/include/babeltrace/compat/fcntl.h
> @@ -0,0 +1,13 @@
> +#ifndef _BABELTRACE_INCLUDE_COMPAT_FCNTL_H
> +#define _BABELTRACE_INCLUDE_COMPAT_FCNTL_H
> +
> +#include <fcntl.h>
> +#ifdef __MINGW32__
> +static inline
> +int posix_fallocate(int fd, off_t offset, off_t len)
> +{

This functionality can be achieved using SetFilePointerEx/SetEndOfFile
on Windows.

> +       return 0;
> +}
> +#endif
> +
> +#endif
> \ No newline at end of file
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
