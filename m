From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: ignore error when loading
 optional kmod
Date: Fri, 19 Sep 2014 12:14:05 -0400
Message-ID: <20140919161405.GB21729__43279.2008891285$1411143396$gmane$org@dalia>
References: <1410803036-28529-1-git-send-email-eeppeliteloop@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1650962802=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XV0p1-0001QG-H2
 for lttng-dev@lists.lttng.org; Fri, 19 Sep 2014 12:14:17 -0400
In-Reply-To: <1410803036-28529-1-git-send-email-eeppeliteloop@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1650962802==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

On 15 Sep (13:43:56), Philippe Proulx wrote:
> This commit also improves the accuracy of debug messages:
> a module is not "successfully" loaded when it's optional
> and actually not loaded.
>=20
> Fixes: #837
>=20
> Signed-off-by: Philippe Proulx <eeppeliteloop@gmail.com>
> ---
>  src/bin/lttng-sessiond/modprobe.c | 35 +++++++++++++++++++++++++++++----=
--
>  1 file changed, 29 insertions(+), 6 deletions(-)
>=20
> diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/m=
odprobe.c
> index 968b265..5c2bb05 100644
> --- a/src/bin/lttng-sessiond/modprobe.c
> +++ b/src/bin/lttng-sessiond/modprobe.c
> @@ -205,8 +205,16 @@ static int modprobe_lttng(struct kern_modules_param =
*modules,
> =20
>  		ret =3D kmod_module_probe_insert_module(mod, KMOD_PROBE_IGNORE_LOADED,
>  				NULL, NULL, NULL, NULL);
> -		if (required && ret < 0) {
> -			ERR("Unable to load module %s", modules[i].name);
> +		if (ret < 0) {
> +			if (required) {
> +				ERR("Unable to load required module %s",
> +						modules[i].name);
> +				goto error;
> +			} else {
> +				DBG("Unable to load optional module %s; continuing",
> +						modules[i].name);
> +				ret =3D 0;
> +			}
>  		} else {
>  			DBG("Modprobe successfully %s", modules[i].name);
>  		}
> @@ -241,10 +249,25 @@ static int modprobe_lttng(struct kern_modules_param=
 *modules,
>  		modprobe[sizeof(modprobe) - 1] =3D '\0';
>  		ret =3D system(modprobe);
>  		if (ret =3D=3D -1) {
> -			ERR("Unable to launch modprobe for module %s",
> -					modules[i].name);
> -		} else if (required && WEXITSTATUS(ret) !=3D 0) {
> -			ERR("Unable to load module %s", modules[i].name);
> +			if (required) {
> +				ERR("Unable to launch modprobe for required module %s",
> +						modules[i].name);
> +				goto error;
> +			} else {
> +				DBG("Unable to launch modprobe for optional module %s; continuing",
> +						modules[i].name);
> +				ret =3D 0;
> +			}
> +		} else if (WEXITSTATUS(ret) !=3D 0) {
> +			if (required) {
> +				ERR("Unable to load required module %s",
> +						modules[i].name);
> +				goto error;
> +			} else {
> +				DBG("Unable to load optional module %s; continuing",
> +						modules[i].name);
> +				ret =3D 0;
> +			}
>  		} else {
>  			DBG("Modprobe successfully %s", modules[i].name);
>  		}
> --=20
> 2.1.0
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

iQF8BAEBAgBmBQJUHFZNXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I028ngH/AgpfjY+wK8afWGekeLBtSmp
Ay6JDwIJpTVXF14egmtQCTDlIvIU8avDq7FwCqlyD1RXojQ7XY27/Q9hZrdRncJb
lbZbwi+QRtIVValrdZ52Nkuasrt+YRnslxKQd6kHdk89SpnJf/vbu8SftKRc5JAE
PoKgsQdWjXjeXKhIdei50UjDnwiCG2tG6VxNxEydbfaStI+ypcY1BhrcZUaAzeSu
q+Gwmum6dkO41KOOXtaD8qG/gKwb0MlDITO9drawygwjC85w+E/z68p7GOWgZJf6
GlrGls0lfz8pg0ZS3RMSJHWBNpGnI3QuKDtpvLWrLUwNrOY+SZhavAf1mK98ONA=
=5rXJ
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--


--===============1650962802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1650962802==--
