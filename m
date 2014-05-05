From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Out of tree build fails in
	libconfig
Date: Mon, 5 May 2014 10:53:32 -0400
Message-ID: <20140505145332.GB7606__34569.9916979813$1399398554$gmane$org@thessa>
References: <1399300906-14530-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1366648958=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WhKH3-0001vl-3S
 for lttng-dev@lists.lttng.org; Mon, 05 May 2014 10:53:50 -0400
In-Reply-To: <1399300906-14530-1-git-send-email-jeremie.galarneau@efficios.com>
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


--===============1366648958==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged

On 05 May (10:41:46), J=E9r=E9mie Galarneau wrote:
> libconfig_la_CPPFLAGS should also include the top-level AM_CPPFLAGS.
>=20
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  src/common/config/Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/common/config/Makefile.am b/src/common/config/Makefile.am
> index e8eaaca..0014dfd 100644
> --- a/src/common/config/Makefile.am
> +++ b/src/common/config/Makefile.am
> @@ -3,7 +3,7 @@ AM_CPPFLAGS =3D -I$(top_srcdir)/include -I$(top_srcdir)/s=
rc
>  noinst_LTLIBRARIES =3D libconfig.la
> =20
>  libconfig_la_SOURCES =3D ini.c ini.h config.c config.h
> -libconfig_la_CPPFLAGS =3D $(XML_CPPFLAGS)
> +libconfig_la_CPPFLAGS =3D $(XML_CPPFLAGS) $(AM_CPPFLAGS)
>  libconfig_la_LIBADD =3D $(XML_LIBS)
> =20
>  xmldir =3D $(datadir)/xml/lttng
> --=20
> 1.9.2
>=20

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTZ6XsXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02v2sIAJjkaxc7kSOO0gsY5aqhTCqM
bqMTlR6FlpLzcgtS3XkCU8nik1No9ZSsJN7ZAbikqmFPcTX+FUUmWPCn5hSm2pyS
AqpeKSvzW8ydHCb5eXDoTajKXml1qMuAl/F+ISlRMEA3pT9U148S3Pt4qDUDpK96
pf+ioICG8yrHWlGYPOymn5mehI+fco7S9SQl5BL1uKGrwF8bp7VrGcsbFkK3rHlN
ESobIc1Vm6QyX92FKoCJhN9Okjfw01eZojTSs6f0Mip3GtJE+mBjZzQozdG0jzkM
Po1jrvA5wxgtgfHzbuzmlljwepr6Xgj1Cyyw+sZH5J+ZWsHwV/thfELBmIOA5Bk=
=JgdY
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--


--===============1366648958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1366648958==--
