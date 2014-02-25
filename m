From: David Goulet <dgoulet@efficios.com>
Subject: Re: [lttng-tools][Patch] Fix format + PACKAGE_URL for
 dynamic printing
Date: Tue, 25 Feb 2014 16:40:24 -0500
Message-ID: <20140225214024.GC8206__24285.221056971$1393364494$gmane$org@thessa>
References: <20140225180414.GA29130@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0219748126=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WIPjt-0003kg-4V
	for lttng-dev@lists.lttng.org; Tue, 25 Feb 2014 16:40:38 -0500
In-Reply-To: <20140225180414.GA29130@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============0219748126==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged! Thanks

On 25 Feb (13:04:17), Jonathan Rajotte wrote:
> ---
>  src/bin/lttng/commands/version.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/src/bin/lttng/commands/version.c b/src/bin/lttng/commands/ve=
rsion.c
> index bd88659..2b41b05 100644
> --- a/src/bin/lttng/commands/version.c
> +++ b/src/bin/lttng/commands/version.c
> @@ -87,10 +87,10 @@ int cmd_version(int argc, const char **argv)
>  		}
>  	}
> =20
> -	MSG("lttng version " VERSION " - " VERSION_NAME);
> +	MSG("LTTng version " VERSION " - " VERSION_NAME);
>  	MSG("\n" VERSION_DESCRIPTION "\n");
> -	MSG("Web site: http://lttng.org");
> -	MSG("\nlttng is free software and under the GPL license and part LGPL");
> +	MSG("Web site: " PACKAGE_URL "\n");
> +	MSG("LTTng is free software and under the GPL license and part LGPL");
> =20
>  end:
>  	poptFreeContext(pc);
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

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTDQ3IXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02kuwH/R2gSbW0GybUwBNKeEFo6X2P
P6XM6oXYkCSP4NvhIJr5uNeo/OxPaHwQdfQE0civQ/LCXBfC4Auz80iBsck46+R+
daaFc9P/2L8lswWwMM1NqrXAAxTWsg1TTd6tRkKA3Zxp/1wfJ7AXcXSC9XJlWTQ+
4m3ixuNbra0OfpB5C9XWwo6IerD25xTn9iq8wyl3H0mYuUrZdQJlEGAFiv+zM84l
CAXwizCAckF43n9JkI84I7m4AF3iZJ7f7Jdf0w5HvtzUm5/waI8uVAPdiVQ5z3yV
iEb9rLON9jcHelSc5Yn9sh6be4A42GCjtljF7bW/Vtv9fWubuuTawXs7MVFSo1g=
=DCkI
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--


--===============0219748126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0219748126==--
