From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Tests should set the
 LTTNG_SESSION_CONFIG_XSD_PATH variable
Date: Wed, 14 May 2014 16:53:29 -0400
Message-ID: <20140514205329.GA6612__13432.4553459466$1400100921$gmane$org@dalia>
References: <1400100742-18018-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2120277903=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ns236805.ip-192-99-35.net ([192.99.35.19]
 helo=smtp.ini-tech.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WkgBH-0004JF-3w
 for lttng-dev@lists.lttng.org; Wed, 14 May 2014 16:53:44 -0400
In-Reply-To: <1400100742-18018-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============2120277903==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

On 14 May (16:52:22), J=E9r=E9mie Galarneau wrote:
> Tests should set the LTTNG_SESSION_CONFIG_XSD_PATH environment
> variable to use the in-tree session configuration schema.
>=20
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  tests/utils/utils.sh | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tests/utils/utils.sh b/tests/utils/utils.sh
> index a1a26d9..280cc40 100644
> --- a/tests/utils/utils.sh
> +++ b/tests/utils/utils.sh
> @@ -166,6 +166,8 @@ function start_lttng_sessiond()
>  	fi
> =20
>  	DIR=3D$(readlink -f $TESTDIR)
> +	: ${LTTNG_SESSION_CONFIG_XSD_PATH=3D${DIR}/../src/common/config/}
> +	export LTTNG_SESSION_CONFIG_XSD_PATH
> =20
>  	if [ -z $(pidof lt-$SESSIOND_BIN) ]; then
>  		$DIR/../src/bin/lttng-sessiond/$SESSIOND_BIN --background --consumerd3=
2-path=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd" --consumerd64-pa=
th=3D"$DIR/../src/bin/lttng-consumerd/lttng-consumerd"
> --=20
> 1.9.2
>=20

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTc9fJXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02IuIIAISO6zP6ITxhEbEBZcApZurO
tBpugcvo9zu5l7WdfqkmdGKdHyPwZzEmbAq6QJljHXW6JzvYHdJTnCfdtFqFKM+l
DDZmFbSq8pmRO4emAqxlPHit1IZk32KAWN6We+2Wi2qeivc9XoeTstLFrGDTp+a/
zZUj+urz6G40TrkAdgIzvuEQvRl+MeXc8l6iExZduyVL/uyq3ozBY05Aq1d95a/D
QqrO45e12wc4Ow2u2gkKOkv6hKaVFg7YM3TVfY9rsYy5bRIh3iGb0fiCE+scayXA
5vKMXxmr7mrXwAyQDlYf933xoqHyYSXrPXBIDyy8QvYU1HqAyuQtva8rI7yw0s0=
=CQW6
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--


--===============2120277903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2120277903==--
