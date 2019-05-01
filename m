From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: getenv can return null
Date: Wed, 1 May 2019 10:37:56 -0400
Message-ID: <20190501143755.GA2824__2144.19832206971$1556721496$gmane$org@gmail.com>
References: <20190430230924.23711-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 by lists.lttng.org (Postfix) with ESMTPS id 44vLbW6sP6z1KGt
 for <lttng-dev@lists.lttng.org>; Wed,  1 May 2019 10:37:59 -0400 (EDT)
Received: by mail-qt1-f196.google.com with SMTP id c35so20184999qtk.3
 for <lttng-dev@lists.lttng.org>; Wed, 01 May 2019 07:37:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190430230924.23711-1-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Merged in master and stable-2.11.

Thanks!
J=E9r=E9mie

On Tue, Apr 30, 2019 at 07:09:24PM -0400, Jonathan Rajotte wrote:
> On system with LANG not defined getenv will return null.
> =

> An example of such system is the lava runner used by ci.lttng.org.
> =

> https://ci.lttng.org/view/System%20Tests/
> =

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  src/common/time.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/src/common/time.c b/src/common/time.c
> index 5519e3ab4..a01c16df5 100644
> --- a/src/common/time.c
> +++ b/src/common/time.c
> @@ -76,7 +76,7 @@ void __attribute__((constructor)) init_locale_utf8_supp=
ort(void)
>  =

>  	if (program_locale && strstr(program_locale, "utf8")) {
>  		utf8_output_supported =3D true;
> -	} else if (strstr(lang, "utf8")) {
> +	} else if (lang && strstr(lang, "utf8")) {
>  		utf8_output_supported =3D true;
>  	}
>  }
> -- =

> 2.17.1
> =
