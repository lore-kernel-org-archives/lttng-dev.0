From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tool] Fix: mi: missing files on make
 dist
Date: Tue, 29 Jul 2014 16:05:57 -0400
Message-ID: <20140729200557.GD6805__36558.3436251201$1406664433$gmane$org@thessa>
References: <1406661856-20600-1-git-send-email-jonathan.r.julien@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1997509428=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XCDew-0006Bo-4A
 for lttng-dev@lists.lttng.org; Tue, 29 Jul 2014 16:06:12 -0400
In-Reply-To: <1406661856-20600-1-git-send-email-jonathan.r.julien@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1997509428==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged

On 29 Jul (15:24:16), Jonathan Rajotte Julien wrote:
> Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
> ---
>  src/common/Makefile.am                | 1 +
>  tests/regression/tools/mi/Makefile.am | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/common/Makefile.am b/src/common/Makefile.am
> index 4b623c8..7011d97 100644
> --- a/src/common/Makefile.am
> +++ b/src/common/Makefile.am
> @@ -12,6 +12,7 @@ noinst_HEADERS =3D lttng-kernel.h defaults.h macros.h e=
rror.h futex.h \
> =20
>  # Common library
>  noinst_LTLIBRARIES =3D libcommon.la
> +EXTRA_DIST =3D mi_lttng.xsd
> =20
>  libcommon_la_SOURCES =3D error.h error.c utils.c utils.h runas.c runas.h=
 \
>                         common.h futex.c futex.h uri.c uri.h defaults.c \
> diff --git a/tests/regression/tools/mi/Makefile.am b/tests/regression/too=
ls/mi/Makefile.am
> index 5586461..4c77f56 100644
> --- a/tests/regression/tools/mi/Makefile.am
> +++ b/tests/regression/tools/mi/Makefile.am
> @@ -10,7 +10,7 @@ extract_xml_CPPFLAGS =3D $(XML_CPPFLAGS) $(AM_CPPFLAGS)
>  extract_xml_LDADD =3D $(XML_LIBS)
> =20
>  noinst_SCRIPTS =3D test_mi
> -EXTRA_DIST =3D
> +EXTRA_DIST =3D test_mi
> =20
>  all-local:
>  	@if [ x"$(srcdir)" !=3D x"$(builddir)" ]; then \
> --=20
> 2.0.0
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJT1/6lXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02avgIAIi+ObixubF0VJHJyRI7v+zU
Zfb3KYJjski/jqr909opW9g21NHGb3XxexL372Y4zdpN9Zz3aH/Zj/tFIt7UhQzn
kBRZWrhF8tjgLUywZB5HWYz51euKLCKVZ90rAqDs1yjJw6cWT/2o60Anp4hLf/ms
NbKbPL2yL6Pug2TlxPWQxcoII1WQJ3PmsVY/couVIYHEs/a4aYMH0G4UqOdk4nwz
m63ZjlwDwO5T6gsngp2ltVU2Or34yR+ladWiZzxxmsDKhXVjwUe71c36DGYPf1i2
agHoJW0WyCAKON5yvGw+jU4ViG2f3XkH0O/HzPX70Sjg8pG+w8sCa+LST5pA4/8=
=s10t
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--


--===============1997509428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1997509428==--
