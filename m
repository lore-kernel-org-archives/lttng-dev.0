From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Add libuuid as dependency in
	README
Date: Mon, 25 Nov 2013 10:50:15 -0500
Message-ID: <20131125155015.GA8371__21682.1424234242$1385394682$gmane$org@thessa>
References: <1385383241-19484-1-git-send-email-soariez@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0293055180=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VkyQa-000519-0r
	for lttng-dev@lists.lttng.org; Mon, 25 Nov 2013 10:50:29 -0500
In-Reply-To: <1385383241-19484-1-git-send-email-soariez@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Zifei Tong <soariez@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0293055180==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged! Thanks

On 25 Nov (20:40:41), Zifei Tong wrote:
> Signed-off-by: Zifei Tong <soariez@gmail.com>
> ---
>  README | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/README b/README
> index e38602d..3b5ae2e 100644
> --- a/README
> +++ b/README
> @@ -31,6 +31,11 @@ REQUIREMENTS:
> =20
>        * Debian/Ubuntu package: libpopt-dev
> =20
> +    - libuuid
> +      Universally unique id library
> +
> +      * Debian/Ubuntu package: uuid-dev
> +
>      - Perl (optional)
>        Needed for make check and tests.
> =20
> --=20
> 1.8.4.2
>=20

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJSk3G3XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02t70H/RALAyUwIeOEWhHRtCinQ/of
m5c8f/qXTw7hcJGfhrgju5grKDbSuLAeyW7ZqTkarbwOTdSK43yXSSMnbxiz0aEq
ezaeRhbNmri+TQj9b2Vz2bNJqclafi+fdZZgn6dgeUla1fK8sEohOyJ7KQsEEKdi
UgJc/31nty67JIMVAEbDypjv7yJGHJ/9oWk/aP32VO1g0uda/Nyxm1uClrhChDgK
2o6gwW4fhBHRyTUd4O2lxrzTLycF2Is78YMBQ114gLX26lFpeJSejqBRoe2pOPWI
TNXIqZRnVt98Ir5PprM75IifxfCr0Pjwfjb1OGBS0MdSPhQRK6XqCgqhkA7FB4Y=
=5cms
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--


--===============0293055180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0293055180==--
