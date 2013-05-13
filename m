From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [Babeltrace RFC PATCH 14/28] Add MinGW
 implementation of fpathconf
Date: Mon, 13 May 2013 16:20:47 -0400
Message-ID: <CA+jJMxtS+PyjD7oTyQ+OZ6E6LptT3YhH+L+EbhbeDx4QUcdBgw__34867.5488298342$1368476492$gmane$org@mail.gmail.com>
References: <009B25148989C6458484484699278506E537E90D@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UbzEr-0001Fw-EP
	for lttng-dev@lists.lttng.org; Mon, 13 May 2013 16:20:53 -0400
Received: by mail-wi0-f178.google.com with SMTP id ey16so1363391wid.11
	for <lttng-dev@lists.lttng.org>; Mon, 13 May 2013 13:20:47 -0700 (PDT)
In-Reply-To: <009B25148989C6458484484699278506E537E90D@EU-MBX-01.mgc.mentorg.com>
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

On Thu, May 2, 2013 at 7:55 AM, Ikaheimonen, JP
<jp_ikaheimonen@mentor.com> wrote:
> The MinGW implementation of fpathconf will always return MAX_PATH.
> ---
>  formats/ctf/ctf.c                  |  2 +-
>  include/babeltrace/compat/unistd.h | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>  create mode 100644 include/babeltrace/compat/unistd.h
>
> diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
> index 255a492..c29fcd7 100644
> --- a/formats/ctf/ctf.c
> +++ b/formats/ctf/ctf.c
> @@ -44,7 +44,7 @@
>  #include <fcntl.h>
>  #include <dirent.h>
>  #include <glib.h>
> -#include <unistd.h>
> +#include <babeltrace/compat/unistd.h>
>  #include <stdlib.h>
>
>  #include "metadata/ctf-scanner.h"
> diff --git a/include/babeltrace/compat/unistd.h b/include/babeltrace/comp=
at/unistd.h
> new file mode 100644
> index 0000000..f275b22
> --- /dev/null
> +++ b/include/babeltrace/compat/unistd.h
> @@ -0,0 +1,21 @@
> +#ifndef _BABELTRACE_INCLUDE_COMPAT_UNISTD_H
> +#define _BABELTRACE_INCLUDE_COMPAT_UNISTD_H
> +
> +#include <unistd.h>
> +
> +#ifndef _PC_NAME_MAX
> +#define _PC_NAME_MAX 0
> +#endif
> +
> +#ifdef __MINGW32__
> +
> +static inline
> +int fpathconf (int fd, int name)
> +{
> +       /* dummy function that always returns MAX_PATH */
> +       return MAX_PATH;
> +}
> +
> +#endif
> +
> +#endif
> \ No newline at end of file

^
This file is missing a new-line character at the end.

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
