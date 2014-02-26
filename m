From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Tests fix: Missing waitpid in
 fork test
Date: Wed, 26 Feb 2014 13:38:36 -0500
Message-ID: <20140226183836.GC7356__28001.1648349047$1393439996$gmane$org@thessa>
References: <1393430217-12953-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1226697575=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WIjNU-0005YV-Vl
	for lttng-dev@lists.lttng.org; Wed, 26 Feb 2014 13:38:50 -0500
In-Reply-To: <1393430217-12953-1-git-send-email-jeremie.galarneau@efficios.com>
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


--===============1226697575==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Content-Disposition: inline


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

On 26 Feb (10:56:57), J=E9r=E9mie Galarneau wrote:
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  tests/regression/ust/fork/fork.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/regression/ust/fork/fork.c b/tests/regression/ust/fork=
/fork.c
> index 744e920..7df982b 100644
> --- a/tests/regression/ust/fork/fork.c
> +++ b/tests/regression/ust/fork/fork.c
> @@ -20,6 +20,7 @@
>  #include <stdio.h>
>  #include <unistd.h>
>  #include <sys/types.h>
> +#include <sys/wait.h>
>  #include <stdlib.h>
> =20
>  #define TRACEPOINT_DEFINE
> @@ -51,12 +52,19 @@ int main(int argc, char **argv, char *env[])
>  		result =3D execve(argv[1], args, env);
>  		if (result =3D=3D -1) {
>  			perror("execve");
> -			return 1;
> +			result =3D 1;
> +			goto end;
>  		}
>  	} else {
>  		printf("child_pid %d\n", result);
>  		tracepoint(ust_tests_fork, after_fork_parent, getpid());
> +		if (waitpid(result, NULL, 0) < 0) {
> +			perror("waitpid");
> +			result =3D 1;
> +			goto end;
> +		}
>  	}
> -
> -	return 0;
> +	result =3D 0;
> +end:
> +	return result;
>  }
> --=20
> 1.9.0
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTDjSsXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02FnwIALujPMkcWLjYVRaScNU/I0Wz
Xsms6fVgOa+4aAc3t0ghI4jUHyAXHyXU4R53ARUCLdtAxiRkyFfLhY6wsXpaDQdn
FyLEKNnnUnEuLk26OeS7mw9137jKExGqsd7qT0iQ9iGjMmAkXThLSXoyDCoybxUc
sxoNvta4RqDLAhfuKaWe1Wd4U42R3uQtvqTsrNVZagCxE4qUtFT9Fe7098b8Jtd8
WBpayMbsl8kV1vcIirCqsTE5PlYsPqSXzn8Zd2dwqM8eviy7H9kVtUKr4G2pVhV8
J69kZJoe5yYIoTyW+qKdjbrq35Y/TH7QuqCwksW0uNUu3b1tGdS8MZLWbpx/HJY=
=GHYS
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--


--===============1226697575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1226697575==--
