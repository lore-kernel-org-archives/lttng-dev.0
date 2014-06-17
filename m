From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tool] Fix: wrong behavior of save
 command when no session name is provided
Date: Tue, 17 Jun 2014 16:11:42 -0400
Message-ID: <20140617201142.GC12098__2481.66104215688$1403035972$gmane$org@dalia>
References: <1403035181-12315-1-git-send-email-jonathan.r.julien@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0475461331=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WwzjS-0002PY-DT
 for lttng-dev@lists.lttng.org; Tue, 17 Jun 2014 16:11:56 -0400
In-Reply-To: <1403035181-12315-1-git-send-email-jonathan.r.julien@gmail.com>
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


--===============0475461331==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Content-Disposition: inline


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged! Thanks

David

On 17 Jun (15:59:41), Jonathan Rajotte Julien wrote:
> No session name and no option --all should default to --all.
>=20
> Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
> ---
>  src/bin/lttng/commands/save.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/src/bin/lttng/commands/save.c b/src/bin/lttng/commands/save.c
> index e8a4565..9be7103 100644
> --- a/src/bin/lttng/commands/save.c
> +++ b/src/bin/lttng/commands/save.c
> @@ -93,12 +93,9 @@ int cmd_save(int argc, const char **argv)
> =20
>  	if (!opt_save_all) {
>  		session_name =3D poptGetArg(pc);
> -		if (!session_name) {
> -			ERR("A session name must be provided if the \"all\" option is not use=
d.");
> -			ret =3D CMD_ERROR;
> -			goto end;
> +		if (session_name) {
> +			DBG2("Session name: %s", session_name);
>  		}
> -		DBG2("Session name: %s", session_name);
>  	}
> =20
>  	attr =3D lttng_save_session_attr_create();
> --=20
> 2.0.0
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJToKD+XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02qNoIAJbd1+5ia5Z36tSgEn5Nees0
FUdY8kfojTW+yVOThkGbM1CfqZJoeGmF9snW+kvxgKx1R2b4Z/OcOMO8z/N2nn+d
WFAnbg000d2KVlxytA38h4dNXlxvXwS/GYFFkI3z34G+k2ZJy+sbIvanIoegMD9f
YdOJgE3All1Hb98jMw2xWdw33nz3+AV1qOrG+ZvNvzzAB4sGw/avELRE6tMD08Bx
BduYJCVkTdbT2B/1OVmGPiNzAqwjIiCRP7wYqo3rICEvwF2nreX3myXdeLA8IYOk
gm/q6rLBBbPjwDVoWXJ3hl5tLtsQp5zjrfBVnEEh/zBFyvZ65rcfOq4j3eThv68=
=n0yp
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--


--===============0475461331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0475461331==--
