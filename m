From: David Goulet <dgoulet@efficios.com>
Subject: Re: [lttng-tools PATCH 0/5] utils_expand_path fix
Date: Mon, 25 Nov 2013 10:51:06 -0500
Message-ID: <20131125155106.GB8371__36218.9375483014$1385394785$gmane$org@thessa>
References: <20131115154539.GA6986@thessa>
	<1385245948-23011-1-git-send-email-raphael.beamonte@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0700706133=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VkyRO-0005Qy-AE
	for lttng-dev@lists.lttng.org; Mon, 25 Nov 2013 10:51:19 -0500
In-Reply-To: <1385245948-23011-1-git-send-email-raphael.beamonte@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?Rapha=EBl?= Beamonte <raphael.beamonte@gmail.com>, R@thessa.ini-tech.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0700706133==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fixes every use case I had that failed previously :).

Merged. Thanks!

David

On 23 Nov (17:32:23), Rapha=EBl Beamonte wrote:
> Hello David!
>=20
> Here is the fix needed to have the expected behavior for path that
> ends with '/.' or '/..'. I also profit to send patches for the unit
> test to allow to add tests using an existing tree and symlinks,
> adding the missing copyright in utils.c and correcting the indentation
> of one comment.
>=20
> Waiting for your comments!
>=20
> Thanks,
> Rapha=EBl
>=20
>=20
> Rapha=EBl Beamonte (5):
>   Add missing copyright to utils.c
>   Fix: comment indentation
>   Fix: utils_expand_path now works for paths that ends with '/.' or
>     '/..'
>   Tests: add symlink tests for test_utils_expand_path
>   Tests: add valid test cases to test_utils_expand_path
>=20
>  src/common/utils.c                  |   30 +++++-
>  tests/unit/test_utils_expand_path.c |  175 +++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 199 insertions(+), 6 deletions(-)
>=20
> --=20
> 1.7.10.4
>=20

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJSk3HqXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02+0wIAMg6iQOQdjPL/M3lftEyMp22
kmsWVz/7mhyAjUiGfpbiMAVT8ICG00HKbq4RJIl2mmuObuCz14A40Uaivk1ejnnL
b0w8Vj94mpKs6qzuBXLff3UbR/7F48bAq1BG1sLPEZcI/eib/5pevt6Za2vFvsdi
1CwoRJAF5OOSI1VAr17XFOMbxjpIZOW6x/HudDyRvJexmYt6Fgm3Btw1QUVvUzxq
nIkhKsMbJVZ87p/sKR/BMLI/HbcwgCpqOMASp5LKDoSgPo0Xhy6qbKzcHNiF6jDN
xKPcVBxuZmC3t4FgUQ7dgRy7/QgsZdrclUGbkleLh7vYjll6ko6lbj+U9Z66Hvw=
=SZuh
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--


--===============0700706133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0700706133==--
