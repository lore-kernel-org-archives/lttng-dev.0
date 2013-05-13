From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [Babeltrace RFC PATCH 25/28] Replace mkdir with
	compat_mkdir
Date: Mon, 13 May 2013 16:20:28 -0400
Message-ID: <CA+jJMxsWPJUu1Xy31YLsY_RaRin2NvcTeTiWGPX+bfhGvDWcfg__34532.4844973677$1368476469$gmane$org@mail.gmail.com>
References: <009B25148989C6458484484699278506E537E9CA@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UbzEY-0001DR-Kl
	for lttng-dev@lists.lttng.org; Mon, 13 May 2013 16:20:34 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so6856043wgh.30
	for <lttng-dev@lists.lttng.org>; Mon, 13 May 2013 13:20:28 -0700 (PDT)
In-Reply-To: <009B25148989C6458484484699278506E537E9CA@EU-MBX-01.mgc.mentorg.com>
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

On Thu, May 2, 2013 at 8:05 AM, Ikaheimonen, JP
<jp_ikaheimonen@mentor.com> wrote:
> The MinGW implementation of mkdir only accepts one parameter.
> Replace mkdir with compat_mkdir that in MinGW will ignore the
> parameters after the first one.
> ---
>  converter/babeltrace-log.c        |  2 +-
>  include/babeltrace/compat/fcntl.h | 27 +++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/converter/babeltrace-log.c b/converter/babeltrace-log.c
> index ac3bb3f..f997aad 100644
> --- a/converter/babeltrace-log.c
> +++ b/converter/babeltrace-log.c
> @@ -332,7 +332,7 @@ int main(int argc, char **argv)
>                 exit(EXIT_SUCCESS);
>         }
>
> -       ret =3D mkdir(s_outputname, S_IRWXU|S_IRWXG);
> +       ret =3D compat_mkdir(s_outputname, S_IRWXU|S_IRWXG);

Not sure about this... A mkdir macro dropping the second parameter
might be more appropriate.

>         if (ret) {
>                 perror("mkdir");
>                 goto error;
> diff --git a/include/babeltrace/compat/fcntl.h b/include/babeltrace/compa=
t/fcntl.h
> index f58a1bf..167353c 100644
> --- a/include/babeltrace/compat/fcntl.h
> +++ b/include/babeltrace/compat/fcntl.h
> @@ -6,6 +6,18 @@
>  #include <stdarg.h>
>  #include <stdio.h>
>
> +#ifndef S_IRGRP
> +#define S_IRGRP 0
> +#endif
> +
> +#ifndef S_IWGRP
> +#define S_IWGRP 0
> +#endif
> +
> +#ifndef S_IRWXG
> +#define S_IRWXG 0
> +#endif
> +
>  #ifdef __MINGW32__
>  static inline
>  int posix_fallocate(int fd, off_t offset, off_t len)
> @@ -68,4 +80,19 @@ int compat_closedirfd(int dirfd)
>  #endif
>  }
>
> +static inline
> +int compat_mkdir(const char *pathname, ...)
> +{
> +#ifdef __MINGW32__
> +       return mkdir(pathname);
> +#else
> +       mode_t mode =3D 0;
> +       va_list args;
> +       va_start (args, pathname);
> +       mode =3D (mode_t)va_arg(args, int);
> +       va_end(args);
> +       return mkdir(pathname, mode);
> +#endif
> +}
> +
>  #endif
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
