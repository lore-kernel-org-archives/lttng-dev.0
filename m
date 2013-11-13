From: David Goulet <dgoulet@efficios.com>
Subject: Re: [lttng-tools PATCH 0/4] Update to utils_expand_path
 as realpath(3) for non-existing directories
Date: Wed, 13 Nov 2013 16:28:35 -0500
Message-ID: <20131113212835.GD7694__1938.08572735197$1384378180$gmane$org@dalia>
References: <20131112195134.GB12183@thessa>
	<1384320878-28808-1-git-send-email-raphael.beamonte@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0337509539=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VghzP-0003ce-JM
	for lttng-dev@lists.lttng.org; Wed, 13 Nov 2013 16:28:49 -0500
In-Reply-To: <1384320878-28808-1-git-send-email-raphael.beamonte@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?Rapha=EBl?= Beamonte <raphael.beamonte@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0337509539==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Content-Disposition: inline


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged! Big thanks Rapha=EBl especially for the two unit tests!

David

On 13 Nov (00:34:34), Rapha=EBl Beamonte wrote:
> David,
>=20
> Please find here an updated series of patches following your
> previous comments. These patches introduce updated versions of the
> utils_resolve_relative and utils_expand_path functions, as well as
> unit tests to verify their behavior.
>=20
> Thanks,
> Rapha=EBl
>=20
>=20
> Rapha=EBl Beamonte (4):
>   Introduce a new utils_resolve_relative function
>   Tests: Add test_utils_resolve_relative to unit tests
>   Correct the behavior of the utils_expand_path function
>   Tests: Add test_utils_expand_path to unit tests
>=20
>  .gitignore                               |    2 +
>  src/common/utils.c                       |  154 +++++++++++++++++++++++-=
---
>  src/common/utils.h                       |    1 +
>  tests/unit/Makefile.am                   |   20 +++-
>  tests/unit/test_utils_expand_path.c      |  170 ++++++++++++++++++++++++=
++++++
>  tests/unit/test_utils_resolve_relative.c |   98 +++++++++++++++++
>  tests/unit_tests                         |    2 +
>  7 files changed, 421 insertions(+), 26 deletions(-)
>  create mode 100644 tests/unit/test_utils_expand_path.c
>  create mode 100644 tests/unit/test_utils_resolve_relative.c
>=20
> --=20
> 1.7.10.4
>=20

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJSg+8DXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02IRcH/2vDUuTba54uESPnoJJqPz7g
5voxCaUuWOTSSj3SpeaXXfMLhDitvn+meBClGRNneKfU6eV546Dsrb1LoOY6nmlZ
HbPW7+OOjKDf/f1y315Wm00JkSC74CMfoi0sRlojN7SothMCMU4QHChOFZ7+uT+P
Lj9206z8/SyvL5AFGOUTixNYELvmMZeiPg0+ZuiAlFtzSp5P3eeAFvGUEPSCrhfL
gaQN+tSrSEO8KSXVes96lWF4pyFf0jSyOHG8aRDzODNCDgIr3LXb8eYaWIXtAX/L
RoEEIQ1EmjqiMyveGMwFFu2+WFFCsopfIW0WecrYftyMev+ROhaW2h+Sq9hwXcY=
=+1Ly
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--


--===============0337509539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0337509539==--
