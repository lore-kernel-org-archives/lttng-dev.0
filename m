From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tool] Fix: list without a name is not
 an error
Date: Wed, 3 Sep 2014 14:50:38 -0400
Message-ID: <20140903185038.GB1549__16325.6632550203$1409770305$gmane$org@dalia>
References: <1408739147-5871-1-git-send-email-jonathan.r.julien@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1178519759=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XPFdm-00080p-MH
 for lttng-dev@lists.lttng.org; Wed, 03 Sep 2014 14:50:51 -0400
In-Reply-To: <1408739147-5871-1-git-send-email-jonathan.r.julien@gmail.com>
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


--===============1178519759==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

On 22 Aug (16:25:47), Jonathan Rajotte Julien wrote:
> Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
> ---
>  src/bin/lttng/commands/list.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c
> index ccffdc7..bd96f88 100644
> --- a/src/bin/lttng/commands/list.c
> +++ b/src/bin/lttng/commands/list.c
> @@ -1251,7 +1251,6 @@ static int list_sessions(const char *session_name)
>  		/* Pretty print */
>  		if (count =3D=3D 0) {
>  			MSG("Currently no available tracing session");
> -			ret =3D CMD_ERROR;
>  			goto end;
>  		}
> =20
> --=20
> 2.0.4
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJUB2L+XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02MPMIAK79NFb4fTgf6TGp7buZELPw
2NgOrbkYak/JqH7O+zzfO0F2Ns5FkCTbDA1VQff62ix0gTN/tSTZ3RGCT/dGl90x
7KIq48ElgKqqJHLywEazbyONLgZIMjIoglaiGeaVSOGLs2beKSdD2zuWCmxTt/LU
0J7O5pcGoEBMAhI95jMpeNbdS0dQVcz+Cen21i9PYplcpUu03CKtNqFajPpowSDw
B/7yd8tq1UpQZy3RgnN1T2bucmsXMwJZoSPcK6Nk1OGNaWjXvO/5X7D+egLBAh+w
itbOXycQoAEL4iQMhJT6gnMxo0x7/UAk0DvrT0hyeUB1Mzi1vowR9bLog0tUN8U=
=9pQl
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--


--===============1178519759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1178519759==--
