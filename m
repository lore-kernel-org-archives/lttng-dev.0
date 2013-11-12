From: David Goulet <dgoulet@efficios.com>
Subject: Re: [lttng-tools PATCH 1/2] Introduce a new
 utils_resolve_relative function
Date: Tue, 12 Nov 2013 14:51:34 -0500
Message-ID: <20131112195134.GB12183__18519.8101833977$1384285970$gmane$org@thessa>
References: <1383885134-21397-1-git-send-email-raphael.beamonte@gmail.com>
	<1383885134-21397-2-git-send-email-raphael.beamonte@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1755478064=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VgK00-0004gW-Eu
	for lttng-dev@lists.lttng.org; Tue, 12 Nov 2013 14:51:50 -0500
In-Reply-To: <1383885134-21397-2-git-send-email-raphael.beamonte@gmail.com>
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


--===============1755478064==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07 Nov (23:32:13), Rapha=EBl Beamonte wrote:
> This functions allows to resolve relative path such as './'
> and '../' inside a path string. This allows to use paths such
> as '~/../test' that are received as '/home/x/../test' for
> instance.
>=20
> Signed-off-by: Rapha=EBl Beamonte <raphael.beamonte@gmail.com>
> ---
>  src/common/utils.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++=
++
>  src/common/utils.h |    1 +
>  2 files changed, 49 insertions(+)
>=20
> diff --git a/src/common/utils.c b/src/common/utils.c
> index da4c036..7b52760 100644
> --- a/src/common/utils.c
> +++ b/src/common/utils.c
> @@ -36,6 +36,54 @@
>  #include "defaults.h"
> =20
>  /*
> + * Resolve the './' and '../' strings inside a path using our
> + * very own way to do it, so that it works even if the directory
> + * does not exist
> + */
> +LTTNG_HIDDEN
> +int utils_resolve_relative(char *path)
> +{
> +	char *next, *previous, *slash, *start_path;
> +
> +	/* As long as we find '/./' in the path string */
> +	while ((next =3D strstr(path, "/./"))) {
> +
> +		/* We prepare the start_path not containing it */
> +		start_path =3D strndup(path, next - path);
> +
> +		/* And we concatenate it with the part after this string */
> +		snprintf(path, PATH_MAX, "%s%s", start_path, next + 2);
> +
> +		free(start_path);
> +	}
> +
> +	while ((next =3D strstr(path, "/../"))) {
> +		/* If the path starts with '/../', there's a problem */
> +		if (next =3D=3D path) {
> +			ERR("%s: Path cannot be resolved", path);
> +			return 1;
> +		}
> +
> +		/* We find the last level of directory */
> +		previous =3D path;
> +		while ((slash =3D strpbrk(previous + 1, "/")) && slash !=3D next) {
> +			previous =3D slash;
> +		}
> +
> +		/* Then we prepare the start_path not containing it */
> +		start_path =3D strndup(path, previous - path);
> +
> +		/* And we concatenate it with the part after the '/../' */
> +		snprintf(path, PATH_MAX, "%s%s", start_path, next + 3);

I'm not to keen with modifying directly the given path. I would really
prefer having this function return a newly allocated char * and taking a
const char *.  We could want to keep the path given for whatever reason
and also you have no idea if the path given is NULL terminated or not
nor its size.

Also, a small unit test testing this function and the other one in the
next patch would be awesome if you have 2 minutes for that. Those
functions are not that trivial to follow for a human :P, there is a lot
of string mangling and it's getting confusing after a while.

Thanks!
David

> +
> +		free(start_path);
> +	}
> +
> +	return 0;
> +}
> +
> +
> +/*
>   * Return the realpath(3) of the path even if the last directory token d=
oes not
>   * exist. For example, with /tmp/test1/test2, if test2/ does not exist b=
ut the
>   * /tmp/test1 does, the real path is returned. In normal time, realpath(=
3)
> diff --git a/src/common/utils.h b/src/common/utils.h
> index 52f2798..ced3584 100644
> --- a/src/common/utils.h
> +++ b/src/common/utils.h
> @@ -26,6 +26,7 @@
>  #define MEBI_LOG2 20
>  #define GIBI_LOG2 30
> =20
> +int utils_resolve_relative(char *path);
>  char *utils_expand_path(const char *path);
>  int utils_create_pipe(int *dst);
>  int utils_create_pipe_cloexec(int *dst);
> --=20
> 1.7.10.4
>=20

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJSgobGXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I026JkIAKnxp6TaJRcIHw+t9nhSTPwi
f7CiEnJxv5WHXi7jbeMtx/s/tpy6ITuQ/3ehpN2t0oaqgjKbI6cHe5oaUb5VFSYE
upn8/B40ot3UIK9Wr+lHT09p2SqNAG1GDtaWkWsdYvvdclW7WE2Xsiqg2jWjh1AR
BrO6vPE6mK7SXY4CRtU1emvUUY4XSRBcX3nfJeUbuN7m0DuVSaBpO6FJrCSaBXS9
eFUZJHJ4daauRxS9TuP05QnMnP79s6Fdtk4bY1r3+VdfyIJLZW5pTcbbHEvS0UIM
2QIiAvIbItEtipSwCaARvSrgqiy4XuZOQ2tZnSwGG4MOKrJrQILCbWJg/BJtIw4=
=CkFu
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--


--===============1755478064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1755478064==--
