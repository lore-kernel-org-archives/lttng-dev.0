From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [Babeltrace RFC PATCH 09/28] Add MinGW
 implementation of strerror_r
Date: Mon, 13 May 2013 16:21:04 -0400
Message-ID: <CA+jJMxueNKCrtUumPtJu-vUsP00o+_4CBBEPW_Zv=HJVCntEbw__2862.73843744329$1368476515$gmane$org@mail.gmail.com>
References: <009B25148989C6458484484699278506E537E8B6@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UbzFA-0001Ix-SE
	for lttng-dev@lists.lttng.org; Mon, 13 May 2013 16:21:13 -0400
Received: by mail-wg0-f44.google.com with SMTP id z12so6530399wgg.23
	for <lttng-dev@lists.lttng.org>; Mon, 13 May 2013 13:21:07 -0700 (PDT)
In-Reply-To: <009B25148989C6458484484699278506E537E8B6@EU-MBX-01.mgc.mentorg.com>
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

On Thu, May 2, 2013 at 7:50 AM, Ikaheimonen, JP
<jp_ikaheimonen@mentor.com> wrote:
> ---
>  compat/compat_strlib.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/compat/compat_strlib.c b/compat/compat_strlib.c
> index 9aabb07..7413e74 100644
> --- a/compat/compat_strlib.c
> +++ b/compat/compat_strlib.c
> @@ -1,5 +1,17 @@
>  #include <babeltrace/compat/string.h>
>
> +#ifdef __MINGW32__
> +int strerror_r(int errnum, char *buf, size_t buflen)
> +{
> +       /* non-recursive implementation of strerror_r */

Is there a reason you are not using Windows' strerror_s()?

> +       char * retbuf;
> +       retbuf =3D strerror(errnum);
> +       strncpy(buf, retbuf, buflen);
> +       buf[buflen - 1] =3D '\0';
> +       return 0;
> +}
> +#endif
> +
>  int compat_strerror_r(int errnum, char *buf, size_t buflen)
>  {
>  #if !defined(__linux__) || ((_POSIX_C_SOURCE >=3D 200112L || _XOPEN_SOUR=
CE >=3D 600) && !defined(_GNU_SOURCE))
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
