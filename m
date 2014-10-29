From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH] lttng-tools: remove bogus argument from
 prove invocation
Date: Wed, 29 Oct 2014 14:28:34 -0400
Message-ID: <20141029182834.GC8595__21142.0299871408$1414607355$gmane$org@thessa>
References: <1414461606-24103-1-git-send-email-nathan_lynch@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1354825417=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XjXz7-0005uA-9w
 for lttng-dev@lists.lttng.org; Wed, 29 Oct 2014 14:28:42 -0400
In-Reply-To: <1414461606-24103-1-git-send-email-nathan_lynch@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Nathan Lynch <nathan_lynch@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1354825417==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UFHRwCdBEJvubb2X"
Content-Disposition: inline


--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged thanks!

David

On 27 Oct (21:00:06), Nathan Lynch wrote:
> An argument of "$2" was added to the prove command line in
> tests/run.sh by 68270f0f604e "Mi test: Basic test structure".  This is
> harmless since run.sh is never called with more than one argument, but
> it is confusing, and it breaks patches in OE that add support for
> running tests on the target.
>=20
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
> ---
>  tests/run.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/run.sh b/tests/run.sh
> index ce51639f7626..c6c50fd9cff9 100755
> --- a/tests/run.sh
> +++ b/tests/run.sh
> @@ -19,4 +19,4 @@
> =20
>  [ -z "$1" ] && echo "Error: No testlist. Please specify a testlist to ru=
n." && exit 1
> =20
> -prove $2 --merge --exec '' - < $1
> +prove --merge --exec '' - < $1
> --=20
> 1.9.3
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--UFHRwCdBEJvubb2X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBCABmBQJUUTHSXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02omwIAIJLTEtDb41fA1zA7AU0MAxV
PNtCZm+wic36953BNn9bQTa75aUABDrqML0473tGEQPAb7oAUMXghy/YdydJx9Xk
BHA+Ce7SDTa9ErOBC5nNO1UXZpJl/flUVo6hNwhvScG5HTRWAQu5BT1o++cz/vUP
VlfHxB9pyxo5CHMIv2b3iF+4JWl9XtTRdqV0KT41dpDA1aKchuzXcCMLs4GvoEEV
4Yghxaghf+FTgag7GuV6OmwNClNJpkpOrjx4GgyH+ZcJYoEgEpsbXSSKE4WPAYXm
FAI/ZYl9H9I0jqgl7xZ7R0QBWcT2vTrprYdC38Xf4hhApk722vn+wi7p92t7zaI=
=ODKt
-----END PGP SIGNATURE-----

--UFHRwCdBEJvubb2X--


--===============1354825417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1354825417==--
