From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tool] Comments fix: lttngerr.h ->
 error.h (./Changelog:754)
Date: Mon, 24 Feb 2014 13:05:55 -0500
Message-ID: <20140224180555.GE8848__23186.9773510427$1393265235$gmane$org@thessa>
References: <20140224005050.GA27035@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1132871689=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WHzum-0007Tj-Hv
	for lttng-dev@lists.lttng.org; Mon, 24 Feb 2014 13:06:13 -0500
In-Reply-To: <20140224005050.GA27035@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1132871689==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XuV1QlJbYrcVoo+x"
Content-Disposition: inline


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

Thanks

On 23 Feb (19:50:52), Jonathan Rajotte wrote:
>=20
> Signed-off-by: Jonathan Rajotte <jonathan.r.julien@gmail.com>
> ---
>  tests/unit/test_kernel_data.c             |    2 +-
>  tests/unit/test_session.c                 |    2 +-
>  tests/unit/test_uri.c                     |    2 +-
>  tests/unit/test_ust_data.c                |    2 +-
>  tests/unit/test_utils_expand_path.c       |    2 +-
>  tests/unit/test_utils_parse_size_suffix.c |    2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/unit/test_kernel_data.c b/tests/unit/test_kernel_data.c
> index 16d4f7b..e2182e9 100644
> --- a/tests/unit/test_kernel_data.c
> +++ b/tests/unit/test_kernel_data.c
> @@ -35,7 +35,7 @@
>  /* Number of TAP tests in this file */
>  #define NUM_TESTS 10
> =20
> -/* For lttngerr.h */
> +/* For error.h */
>  int lttng_opt_quiet =3D 1;
>  int lttng_opt_verbose;
> =20
> diff --git a/tests/unit/test_session.c b/tests/unit/test_session.c
> index 7242edd..a0e84e9 100644
> --- a/tests/unit/test_session.c
> +++ b/tests/unit/test_session.c
> @@ -43,7 +43,7 @@
> =20
>  static struct ltt_session_list *session_list;
> =20
> -/* For lttngerr.h */
> +/* For error.h */
>  int lttng_opt_quiet =3D 1;
>  int lttng_opt_verbose =3D 0;
> =20
> diff --git a/tests/unit/test_uri.c b/tests/unit/test_uri.c
> index ef852c0..7cac95d 100644
> --- a/tests/unit/test_uri.c
> +++ b/tests/unit/test_uri.c
> @@ -22,7 +22,7 @@
> =20
>  #include <common/uri.h>
> =20
> -/* For lttngerr.h */
> +/* For error.h */
>  int lttng_opt_quiet =3D 1;
>  int lttng_opt_verbose =3D 3;
> =20
> diff --git a/tests/unit/test_ust_data.c b/tests/unit/test_ust_data.c
> index c52a71b..bc3154c 100644
> --- a/tests/unit/test_ust_data.c
> +++ b/tests/unit/test_ust_data.c
> @@ -41,7 +41,7 @@
>  /* Number of TAP tests in this file */
>  #define NUM_TESTS 10
> =20
> -/* For lttngerr.h */
> +/* For error.h */
>  int lttng_opt_quiet =3D 1;
>  int lttng_opt_verbose;
> =20
> diff --git a/tests/unit/test_utils_expand_path.c b/tests/unit/test_utils_=
expand_path.c
> index 1e0863f..fe709ac 100644
> --- a/tests/unit/test_utils_expand_path.c
> +++ b/tests/unit/test_utils_expand_path.c
> @@ -28,7 +28,7 @@
> =20
>  #include <src/common/utils.h>
> =20
> -/* For lttngerr.h */
> +/* For error.h */
>  int lttng_opt_quiet =3D 1;
>  int lttng_opt_verbose =3D 3;
> =20
> diff --git a/tests/unit/test_utils_parse_size_suffix.c b/tests/unit/test_=
utils_parse_size_suffix.c
> index 3b9c68c..990aa1b 100644
> --- a/tests/unit/test_utils_parse_size_suffix.c
> +++ b/tests/unit/test_utils_parse_size_suffix.c
> @@ -23,7 +23,7 @@
> =20
>  #include <src/common/utils.h>
> =20
> -/* For lttngerr.h */
> +/* For error.h */
>  int lttng_opt_quiet =3D 1;
>  int lttng_opt_verbose =3D 3;
> =20
> --=20
> 1.7.9.5
>=20
>=20
> --=20
> Jonathan Rajotte Julien
> Charg=E9 de laboratoire INF1995
> Membre MD6
> Polytechnique Montr=E9al
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--XuV1QlJbYrcVoo+x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTC4oDXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02CpsIAKjvDv4QCWxG7yUj5YRmyHod
RVWf/A1ub2cc0PiuQrl06E80FAlFJHZx43/xn1xjzEonk/ZBbNB0WfjmznODhQcL
rR30FWCfBOBgAz69qghpUq3oETHECJNb4qJiQjbNZFaib01VlaXOOa+n+d2gYEHW
YcjZe2KhsdslCZE4QM3gVLkaiqPk7VRg8pQlWQ/PRTMlNLKraXoMDGYHY8PE0A8j
iYrGJLWkDobXZVr6HuDpGO1iA/FRmrgSy+yUBFFx9B52igeaAhB9LjP9Om0/Mrm9
qNBdP21Gz3sWtYjsBcJRm7scTx/krFml49MtPRrLcxoR+C4I43/rOK49OXLFBSU=
=VIN4
-----END PGP SIGNATURE-----

--XuV1QlJbYrcVoo+x--


--===============1132871689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1132871689==--
