From: David Goulet <dgoulet@efficios.com>
Subject: Re: [lttng-tool] Fix: wrong casting of return value
Date: Thu, 12 Jun 2014 14:02:21 -0400
Message-ID: <20140612180221.GD8011__5987.34387099302$1402596264$gmane$org@thessa>
References: <1402328436-13404-1-git-send-email-jonathan.r.julien@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1698680876=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1Wv9KV-0001lQ-7Z
 for lttng-dev@lists.lttng.org; Thu, 12 Jun 2014 14:02:28 -0400
In-Reply-To: <1402328436-13404-1-git-send-email-jonathan.r.julien@gmail.com>
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


--===============1698680876==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Content-Disposition: inline


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

On 09 Jun (11:40:36), Jonathan Rajotte Julien wrote:
> The function uri_parse_str_urls return a ssize_t and the return was
> casted to a size_t. This caused the following error checking to fail as
> -1 was interpreted as 18446744073709551615.
>=20
> Fixes #803
>=20
> Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
> ---
>  src/lib/lttng-ctl/save.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/lib/lttng-ctl/save.c b/src/lib/lttng-ctl/save.c
> index d136b2d..d414a9d 100644
> --- a/src/lib/lttng-ctl/save.c
> +++ b/src/lib/lttng-ctl/save.c
> @@ -99,7 +99,8 @@ int lttng_save_session_attr_set_output_url(
>  	struct lttng_save_session_attr *attr, const char *url)
>  {
>  	int ret =3D 0;
> -	size_t len, size;
> +	size_t len;
> +	ssize_t size;
>  	struct lttng_uri *uris =3D NULL;
> =20
>  	if (!attr) {
> --=20
> 2.0.0
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTmestXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02ZW8H/3XQqI47j5giuCl10XthfvGL
M+LARFNZj+qKRc29PpItw/+CRD0Y2gNziSolZfjU4wL0TuTDxLrpIechUYDbA2yn
I/uZZOdSODi3oPOlGzwebJdgiafEjjbOMTZjupYeIv2+VgI1rlwEfwq7O5iFzf9k
u+cz1oyGVj+ME4Y8lwSRIZS3JVeKO5F/BGj8NE2TBzvXMmsHEcKHTwaAMl4f+9W2
2524/ICuwV3XTxnkCyMWraSVyvNlMpM/6FzhDoqhjWotcqf+5hP52fCEcsWnPVwp
F8zPMsXSg8ZbCOb8uW8XKJHUcp03mHDc1+bFKpRbwd80nqCcgXfEAOj5/4K8+YU=
=uXcX
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--


--===============1698680876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1698680876==--
