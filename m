From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Add missing optional dependency
 to babeltrace in README
Date: Tue, 11 Feb 2014 16:17:18 -0500
Message-ID: <20140211211718.GB9564__47552.30949163$1392153602$gmane$org@thessa>
References: <1391795018-691-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1123866082=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WDKhr-0005YV-7x
	for lttng-dev@lists.lttng.org; Tue, 11 Feb 2014 16:17:33 -0500
In-Reply-To: <1391795018-691-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1123866082==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged

On 07 Feb (12:43:38), Christian Babeux wrote:
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  README | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/README b/README
> index 3b5ae2e..4d70318 100644
> --- a/README
> +++ b/README
> @@ -36,6 +36,11 @@ REQUIREMENTS:
> =20
>        * Debian/Ubuntu package: uuid-dev
> =20
> +    - Babeltrace (optional)
> +      Trace viewer. Enable the use of "lttng view" command
> +
> +      * Debian/Ubuntu package: babeltrace
> +
>      - Perl (optional)
>        Needed for make check and tests.
> =20
> --=20
> 1.8.5.2
>=20

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJS+pNeXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02GkEH+gNtv6mK8ytW1YL27XwSyZAt
B2WJMX5e/ro3RRfVirLKB0HgVc/HhmZgwITqsY1jxcLgowZf9k96mrBuId1X7h5l
p/G42vWCLtYSXcv5KwoH6XlJBCOlNEK3JHYJPCX76h6+CG93u2JMZr7wjQ8UzFrC
9n2pukVh/j7Ou9O5H8TPtaELrBsumAttGjhapHx119BhcRaeIwmFaf50bA9D59oT
XieBWX4/VCjRc8RZNMa5wDRPqJJwEaLBOIOCJ/nlZZZK2D17WnhSLhgjAFkVHVNW
O6CtOBRFbSi4rg+GbIe25PZt6j1S8LTbpK98Uev6rr6GJhprHrLkA2Nj3uqsfJk=
=qmsl
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--


--===============1123866082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1123866082==--
