From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Don't include the binary
 in the live test's EXTRA_DIST
Date: Mon, 5 May 2014 15:40:28 -0400
Message-ID: <20140505194028.GI25287__8734.33520687303$1399396814$gmane$org@thessa>
References: <1399317678-28752-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0738193713=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WhOki-0003fS-MP
 for lttng-dev@lists.lttng.org; Mon, 05 May 2014 15:40:42 -0400
In-Reply-To: <1399317678-28752-1-git-send-email-jeremie.galarneau@efficios.com>
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


--===============0738193713==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GBuTPvBEOL0MYPgd"
Content-Disposition: inline


--GBuTPvBEOL0MYPgd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged

On 05 May (15:21:18), J=E9r=E9mie Galarneau wrote:
> Adding the binary in EXTRA_DIST causes the "dist" target to fail
> with a "No rule to make target libtap.la" error.
>=20
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  tests/regression/tools/live/Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/regression/tools/live/Makefile.am b/tests/regression/t=
ools/live/Makefile.am
> index fdf9d3a..167b9e6 100644
> --- a/tests/regression/tools/live/Makefile.am
> +++ b/tests/regression/tools/live/Makefile.am
> @@ -22,7 +22,7 @@ LIVE=3D$(top_builddir)/src/bin/lttng-sessiond/session.o=
 \
>  	 $(top_builddir)/src/bin/lttng-sessiond/snapshot.o
> =20
>  noinst_PROGRAMS =3D live_test
> -EXTRA_DIST =3D live_test test_kernel
> +EXTRA_DIST =3D test_kernel
> =20
>  if HAVE_LIBLTTNG_UST_CTL
>  EXTRA_DIST +=3D test_ust test_ust_tracefile_count
> --=20
> 1.9.2
>=20

--GBuTPvBEOL0MYPgd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTZ+ksXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02q4YIAKYnHCE0OXiL+hZHWzW1c1+9
ljh5TUWwb9TKKIT6Zog0+P9dvlibxSQJtrf9n3op2LqxJZxuUJAy5p/SVqpZ46Q3
/4VpEIfvQ6z/YZymHR9JG917rZzLmuLoMKgUB4cbqHf+LkLQ4sSF5al4voVSb1/L
+9AvikP2o8vOjHlaphuuSAj6/PDawi2viNNjKuAjKN8cu/VzJ2fyAy6DdnzeOb/o
D1D7lhOw1OYgxnOzP/VS8Na9YGvwVQ0748kKVoJOg/7GAhASwPW2NL26rc4gFNEp
6aQsSl69ePMShkeywBSLcAyKm6+Rx3Q3uqCWwCU2SHCL/fh0uk23qoa33Jl9gn8=
=Wqmx
-----END PGP SIGNATURE-----

--GBuTPvBEOL0MYPgd--


--===============0738193713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0738193713==--
