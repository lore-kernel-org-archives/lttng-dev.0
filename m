From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Duplicate lttng-sessiond
 thread creation comments
Date: Mon, 11 Nov 2013 15:56:23 -0500
Message-ID: <20131111205623.GC25744__2961.93202161721$1384203451$gmane$org@thessa>
References: <1384203204-30368-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2137848640=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VfyX9-0001TD-4G
	for lttng-dev@lists.lttng.org; Mon, 11 Nov 2013 15:56:36 -0500
In-Reply-To: <1384203204-30368-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============2137848640==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged

On 11 Nov (15:53:24), J=E9r=E9mie Galarneau wrote:
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  src/bin/lttng-sessiond/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
> index 3bf91b0..71291f7 100644
> --- a/src/bin/lttng-sessiond/main.c
> +++ b/src/bin/lttng-sessiond/main.c
> @@ -4787,7 +4787,7 @@ int main(int argc, char **argv)
>  		goto exit_health_sessiond_cleanup;
>  	}
> =20
> -	/* Create thread to manage the client socket */
> +	/* Create thread to clean up RCU hash tables */
>  	ret =3D pthread_create(&ht_cleanup_thread, NULL,
>  			thread_ht_cleanup, (void *) NULL);
>  	if (ret !=3D 0) {
> @@ -4795,7 +4795,7 @@ int main(int argc, char **argv)
>  		goto exit_ht_cleanup;
>  	}
> =20
> -	/* Create thread to manage the client socket */
> +	/* Create health-check thread */
>  	ret =3D pthread_create(&health_thread, NULL,
>  			thread_manage_health, (void *) NULL);
>  	if (ret !=3D 0) {
> --=20
> 1.8.4.2
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJSgUR3XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02uCEH/3ZRwgPtt0aOpZaZp4EkiHiD
wjPeSHq2wBuTGda3PEOqyNi6nLfhqbo8BvTZLk7UxaXOPb1T7uSVwHlClB8bQ5Ml
RKEzf7PO865FBYy6EcHDKvSw2rCSoZ9/3pkUWxEIymQwesCQsuO+duF581f6Azmr
wOo+HjL3BnlCZYTFhZQTpqXa3+kWkOOhrE2vl/UyjNWTq+bAdXyrVKUIpWtGp0mT
5OliG6gAyklyvEtA+g6HCXWNQVZXWM91QZlZg2fg20NnLqBReLLOEvayaHCI9LDc
mudBkbFv1Qw1ZBtLybtcFvbrfCgwSkpBk+hfoBPHtPevof3s19JzrHDL+S9nL+0=
=gq2V
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--


--===============2137848640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2137848640==--
