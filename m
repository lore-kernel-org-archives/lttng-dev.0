From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Unchecked session pointer
 when destroying a connection in relayd
Date: Tue, 4 Mar 2014 14:02:33 -0500
Message-ID: <20140304190233.GC7471__5163.02739638395$1393959841$gmane$org@thessa>
References: <1393958717-27967-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0369817864=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WKucF-0002PP-DX
	for lttng-dev@lists.lttng.org; Tue, 04 Mar 2014 14:03:05 -0500
In-Reply-To: <1393958717-27967-1-git-send-email-jeremie.galarneau@efficios.com>
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


--===============0369817864==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Content-Disposition: inline


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged! Thanks

Master and backported to stable-2.4

On 04 Mar (13:45:17), J=E9r=E9mie Galarneau wrote:
> An unknown command currently crashes the relay daemon since
> destroy_connection calls destroy_session without checking whether
> or not a session is associated with the connection.
>=20
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  src/bin/lttng-relayd/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
> index 53eaca2..a93151a 100644
> --- a/src/bin/lttng-relayd/main.c
> +++ b/src/bin/lttng-relayd/main.c
> @@ -2389,7 +2389,7 @@ static void destroy_connection(struct lttng_ht *rel=
ay_connections_ht,
>  	connection_delete(relay_connections_ht, conn);
> =20
>  	/* For the control socket, we try to destroy the session. */
> -	if (conn->type =3D=3D RELAY_CONTROL) {
> +	if (conn->type =3D=3D RELAY_CONTROL && conn->session) {
>  		destroy_session(conn->session, conn->sessions_ht);
>  	}
> =20
> --=20
> 1.9.0
>=20

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTFiNJXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02IGkIAKnH7FoUlg9XMX7Lnx5QY5MC
crFb4g67Wnya7npt9QvLW1PvTKQFQe2z3Ss1si67c/xoKAFOfcNsQiNwjWFHminE
VxrGDdHeERvxY9DXjUFl0VKJYvDQrV7reCvlid/AzyvqOqF1XXUCZuiTEcMWIpUf
Vx40ZN4MxX0T5gj5uWmhI4mmp0oARSHXj0FUWPIi3vlD2mftvpLvIgsHTAlCE8Vl
K0nKXjFkfAzYrumkDTioNqX6/5r/tzpa6uVj9zIw09hZwyX+uFZ/uQY+479nDqoJ
mL0LEQJaOfRXQ5lwZO3aGiW9tqtEkJn+3+6x0c/e2qCXUAaNfOPqkc54zR2V304=
=Mx4U
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--


--===============0369817864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0369817864==--
