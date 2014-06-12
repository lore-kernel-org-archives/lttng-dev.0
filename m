From: David Goulet <dgoulet@efficios.com>
Subject: Re: [lttng-tools PATCH] version control
Date: Thu, 12 Jun 2014 14:02:00 -0400
Message-ID: <20140612180200.GB8011__19123.0600387373$1402596178$gmane$org@thessa>
References: <538E1204.6080304@voxpopuli.im>
 <cover.1401819810.git.raphael.beamonte@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0298182588=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1Wv9KB-0001kn-SD
 for lttng-dev@lists.lttng.org; Thu, 12 Jun 2014 14:02:10 -0400
In-Reply-To: <cover.1401819810.git.raphael.beamonte@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?Rapha=EBl?= Beamonte <raphael.beamonte@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0298182588==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

On 03 Jun (14:30:08), Rapha=EBl Beamonte wrote:
> Hello folks,
>=20
> Like Alexandre explained, using different version control disallow the
> use of the git describe command that gives us the git commit id to know
> our running version of LTTng-tools. This patch aims to keep a version
> number, even if it's not the most updated, even if we're outside a
> git or bzr repository.
>=20
> By default, it will just use the principal VERSION define. This behavior
> was already in the source code, but wasn't working due to the default
> blank GIT_VERSION define. Removing it does the trick.
>=20
> Rapha=EBl
>=20
>=20
> Rapha=EBl Beamonte (1):
>   Fix: remove the default GIT_VERSION define to allow different version
>     control
>=20
>  include/version.h.tmpl | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> --=20
> 2.0.0.rc2
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTmesYXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02gasH/RQJUEDQ1UQMTYsguLvLxafF
sBQB08AwxHCPhWY4jz99n/PyIWmC3UHpIae+nRLHL4esLD+f+1hntu83Y/YwraHS
rV020xaMg0dLTJ6G4a9a3w1kRsID8I/R8X1BgLhuKy+tOxw8KAexB5SUK8PPgddS
POu+eEabme8MOeym3qxLfOxHuJ+29pUcPiXxQ3kSAJM42K74rzKMAuOYWNXsfuHA
94d8f+JoK6tMRhij153WZ+tl7XJLt5tk/isznomKM+86NCcaXNAz5rj+rbwTQtlm
wQz9ee5tDxmkJqzXlOlQuBRwJTGI5TvV6dNPhS3i9AhXJ4n7PLeGr2vh+oO5qGA=
=15w3
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--


--===============0298182588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0298182588==--
