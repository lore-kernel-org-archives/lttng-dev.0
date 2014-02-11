From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools v2] Fix: Define
 __STDC_LIMIT_MACROS to fix C++ builds
Date: Tue, 11 Feb 2014 16:50:59 -0500
Message-ID: <20140211215059.GD9564__35618.9068560072$1392156348$gmane$org@thessa>
References: <2121067902.21017.1391874228506.JavaMail.zimbra@efficios.com>
	<1392048262-17049-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1299000642=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WDLES-000613-Cs
	for lttng-dev@lists.lttng.org; Tue, 11 Feb 2014 16:51:13 -0500
In-Reply-To: <1392048262-17049-1-git-send-email-jeremie.galarneau@efficios.com>
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


--===============1299000642==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Content-Disposition: inline


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

Backported to stable-2.4 and 2.3

On 10 Feb (11:04:22), J=E9r=E9mie Galarneau wrote:
> Necessary to include the fixed-width type limits on glibc versions
> older than 2.18 when building with a C++ compiler.
>=20
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  include/lttng/lttng.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/include/lttng/lttng.h b/include/lttng/lttng.h
> index 18dec2a..f0be224 100644
> --- a/include/lttng/lttng.h
> +++ b/include/lttng/lttng.h
> @@ -23,7 +23,17 @@
>  #define LTTNG_H
> =20
>  #include <limits.h>
> +/*
> + * Necessary to include the fixed width type limits on glibc versions ol=
der
> + * than 2.18 when building with a C++ compiler.
> + */
> +#ifndef __STDC_LIMIT_MACROS
> +#define __STDC_LIMIT_MACROS
> +#include <stdint.h>
> +#undef __STDC_LIMIT_MACROS
> +#else /* #ifndef __STDC_LIMIT_MACROS */
>  #include <stdint.h>
> +#endif /* #else #ifndef __STDC_LIMIT_MACROS */
>  #include <sys/types.h>
> =20
>  /* Error codes that can be returned by API calls */
> --=20
> 1.8.5.4
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJS+ptDXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02+xkH/3aQDvaoxat/MUG6+8sPZYnw
iDc3jjXIlnZ0eFpi+tz/QFTiPP2IWtBIB0P/EmAtUYKZ13pMU6KpH9GbN6Y77usE
M3wQ9/iScPQ5Ue5gkxJPtsxxIjIs6aUtcyWVBTe4rjt6HqYQJp8SQhCgpc+Xj1hE
elxDJIS8xYdlT8fqOoi9zdqhRf12yEN0dLqOW1MLjTFJyxrThy2Txi1UxCXgONjS
kmr5ABvs/hbYta5Q5UibhLpcAtqGxteBopbNP+kK7FCC0a2k/jFx2H16fOquZk8l
Cy/T/2RzCiKtCPUUuFhJMFoR4Hiv7eax9SRkWcDU9FkblaAHilTHjk/4lyNEAj4=
=DoZT
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--


--===============1299000642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1299000642==--
