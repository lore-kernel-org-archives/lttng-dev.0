From: David Goulet <dgoulet@efficios.com>
Subject: Re: [lttng-tools PATCH 0/5] Follow up to the
 realpath(3) for unexistent paths
Date: Fri, 15 Nov 2013 10:45:39 -0500
Message-ID: <20131115154539.GA6986__19104.8487708487$1384530405$gmane$org@thessa>
References: <1517784416.67313.1384445660213.JavaMail.zimbra@efficios.com>
	<1384477115-18809-1-git-send-email-raphael.beamonte@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1247315909=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VhLae-00068P-8j
	for lttng-dev@lists.lttng.org; Fri, 15 Nov 2013 10:45:54 -0500
In-Reply-To: <1384477115-18809-1-git-send-email-raphael.beamonte@gmail.com>
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


--===============1247315909==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14 Nov (19:58:30), Rapha=C3=ABl Beamonte wrote:
> David,
>=20
> Following the discussions we had on IRC with Mathieu and the last
> mail exchange, here is a series of patch that should answer to our
> enquiries.
>=20
> The first two patches are linked to the utils_expand_path unit test
> and correct its behavior and the expected results (some input was
> at first considered invalid, but during our discussions it was
> mentionned that it should be considered valid).
>=20
> The next three ones introduce a new utils_partial_realpath that,
> as its name says it, allows to partially resolve a real path for
> a given path. This function is then used in utils_expand_path to
> resolve the paths, and the utils_resolve_relative function is
> removed as it is not necessary anymore in this new "setup".
>=20
> Waiting for your comments,

Hey Raph,

I've created a symlink directory maze here to test theses patches and
everything seems to work fine but I got one wrong use case. I'll print my m=
aze
here so you can recreate:

/tmp/test $
=2E
=E2=94=94=E2=94=80=E2=94=80 a
    =E2=94=9C=E2=94=80=E2=94=80 b
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 c
    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80=
 g -> ../../../
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 f -> ../e/
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 h -> ../g/
    =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 k -> c/g/
    =E2=94=9C=E2=94=80=E2=94=80 d -> b/c/
    =E2=94=9C=E2=94=80=E2=94=80 e
    =E2=94=94=E2=94=80=E2=94=80 g -> d/

10 directories, 0 files

$ lttng create -o /tmp/test/a/g/../l/..
Session auto-20131115-103416 created.
Traces will be written in /tmp/test/a/b/l/..

Note the "/.." at the end. Relative or not, same output. Seems like "./" and
"../" *after* an unexisting path fails to parse. In this case, I would thro=
w in
an error since there is simply no way of knowing that "l/" is going to point
to.

What I'm going to do here is to merge those 5 patches and wait for fix(es) =
that
we'll merge in the RC cycle. The feature is there just not perfect :). 2.4-=
rc1
is coming up this morning btw.

Thanks!
David

> Rapha=C3=ABl
>=20
> Rapha=C3=ABl Beamonte (5):
>   Tests: add a check in test_utils_expand_path to avoid segfault if
>     result is NULL
>   Tests: move invalid tests in test_utils_expand_path that should be
>     valid
>   Introduce a new utils_partial_realpath function
>   Change the utils_expand_path function to use utils_partial_realpath
>   Remove the utils_resolve_relative function that is not useful anymore
>=20
>  .gitignore                               |    1 -
>  src/common/utils.c                       |  256 ++++++++++++++++++------=
------
>  src/common/utils.h                       |    3 +-
>  tests/unit/Makefile.am                   |    7 +-
>  tests/unit/test_utils_expand_path.c      |    7 +-
>  tests/unit/test_utils_resolve_relative.c |   98 ------------
>  tests/unit_tests                         |    1 -
>  7 files changed, 158 insertions(+), 215 deletions(-)
>  delete mode 100644 tests/unit/test_utils_resolve_relative.c
>=20
> --=20
> 1.7.10.4
>=20

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJShkGjXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I021c8H/iMbWceJv131DpNJbNy6UvWt
UmHtD5Wo4EH4n82rxxSjke4htOqr6FYaXoWbX0or4g5f0nmsjiFveGfI9i7fX8XL
AKJB8rSCVJPWDo9sJDmQ54kXmnqycbo+IYTnz8Har1MzYHN9Im3ZX32pJmczkzfD
l1f0bEcfJWoq6q6RgDkNx2GHBCuT2Zk0aTj+scsXaamwrDDgbqDlSkw6FROPfg1o
44fw8vmjJGQYjqDJ7Q0L6XEzUAxqWrO688kpvuOl7z5vymZiozb3qQ1UE8EX7DJ5
4I83rldGnTg4nlhebxe0QEj/7jRREfWMhp6xsFrEX3XhBHSXdzGpqFajUPdKz4g=
=lXAf
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--


--===============1247315909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1247315909==--
