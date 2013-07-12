From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: Unchecked	asprintf/vasprintf
	return values
Date: Fri, 12 Jul 2013 13:11:20 -0400
Message-ID: <20130712171120.GC18819__6448.85726874254$1373649113$gmane$org@Krystal>
References: <1373647048-5640-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UxgsL-0003K8-RB
	for lttng-dev@lists.lttng.org; Fri, 12 Jul 2013 13:11:21 -0400
Content-Disposition: inline
In-Reply-To: <1373647048-5640-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

merged

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> strp=B7may=B7be=B7modified=B7even=B7in=B7case=B7of=B7failure=B7according=
=B7to=B7the ASPRINTF(3) man
> page.
> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  tests/tap.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> =

> diff --git a/tests/tap.c b/tests/tap.c
> index 86c89a2..8bf72f6 100644
> --- a/tests/tap.c
> +++ b/tests/tap.c
> @@ -83,7 +83,9 @@ _gen_result(int ok, const char *func, char *file, unsig=
ned int line,
>  	   expansions on it */
>  	if(test_name !=3D NULL) {
>  		va_start(ap, test_name);
> -		vasprintf(&local_test_name, test_name, ap);
> +		if (vasprintf(&local_test_name, test_name, ap) =3D=3D -1) {
> +			local_test_name =3D NULL;
> +		}
>  		va_end(ap);
>  =

>  		/* Make sure the test name contains more than digits
> @@ -299,7 +301,9 @@ skip(unsigned int n, char *fmt, ...)
>  	LOCK;
>  =

>  	va_start(ap, fmt);
> -	asprintf(&skip_msg, fmt, ap);
> +	if (asprintf(&skip_msg, fmt, ap) =3D=3D -1) {
> +		skip_msg =3D NULL;
> +	}
>  	va_end(ap);
>  =

>  	while(n-- > 0) {
> @@ -324,7 +328,9 @@ todo_start(char *fmt, ...)
>  	LOCK;
>  =

>  	va_start(ap, fmt);
> -	vasprintf(&todo_msg, fmt, ap);
> +	if (vasprintf(&todo_msg, fmt, ap) =3D=3D -1) {
> +		todo_msg =3D NULL;
> +	}
>  	va_end(ap);
>  =

>  	todo =3D 1;
> -- =

> 1.8.3.2
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
