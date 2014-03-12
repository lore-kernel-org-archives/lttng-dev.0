From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Use autoconf AM_MAINTAINER_MODE.
Date: Wed, 12 Mar 2014 11:13:21 -0400
Message-ID: <20140312151321.GB10776__41738.7659931139$1394637320$gmane$org@thessa>
References: <1394616160-12744-1-git-send-email-larper@axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2082819512=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WNkqY-0000LC-Ix
	for lttng-dev@lists.lttng.org; Wed, 12 Mar 2014 11:13:36 -0400
In-Reply-To: <1394616160-12744-1-git-send-email-larper@axis.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lars Persson <lars.persson@axis.com>
Cc: lttng-dev@lists.lttng.org, Lars Persson <larper@axis.com>
List-Id: lttng-dev@lists.lttng.org


--===============2082819512==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged! Thanks

David

On 12 Mar (10:22:40), Lars Persson wrote:
> Give distribution maintainers the option to skip rebuilding
> autoconf and automake generated files. The default behaviour
> is still to have the rebuild rules enabled.
>=20
> Signed-off-by: Lars Persson <larper@axis.com>
> ---
>  configure.ac |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index 614c8d1..26f286b 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -4,6 +4,7 @@ AC_CANONICAL_TARGET
>  AC_CANONICAL_HOST
>  AC_CONFIG_MACRO_DIR([config])
>  AM_INIT_AUTOMAKE([foreign dist-bzip2 no-dist-gzip])
> +AM_MAINTAINER_MODE([enable])
>  m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
> =20
>  # Compute minor/major/patchlevel version numbers
> --=20
> 1.7.2.5
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTIHmRXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02rT0H/iO2AgsM5oH46RJFK6Wgr5vU
PAr9rrltV6q842g9T33ZuV+GQz48RzlmAwD1IGZJtK2+dFUw5l/CvSN5RvXCcoWi
PNf4m9PlTir17IFsPbHZDoyxS5r1fTmEm3+fxYhWprgrRAzwu+dYWsB3dnyuAr7t
mzLciTtVfcuEsEvIVZ7M6b39VJUVUKk//1oyFzfYEAp7Wdyov3avtLBLkQrTianv
jAb/QN+9GBVJ9YZzye4/3462RX7xP+QBTPzPkmdVDvpyxsWz8GkUZjI2GPTyKcgX
pY+FEvXHhNVndY9S/V86Xaj3uodmxBWe4/gsctuSKC37FzAmF6jYpKj9Abb/Mls=
=fpwo
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--


--===============2082819512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2082819512==--
