From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools v2] Fix: Don't dispatch
 uninitialized hash tables to the ht_cleanup thread
Date: Mon, 11 Nov 2013 15:45:08 -0500
Message-ID: <20131111204508.GA25744__32060.2387808778$1384202779$gmane$org@thessa>
References: <1384198996-29028-1-git-send-email-jeremie.galarneau@efficios.com>
	<1384201808-29812-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0177456625=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VfyMG-0006wH-Kz
	for lttng-dev@lists.lttng.org; Mon, 11 Nov 2013 15:45:22 -0500
In-Reply-To: <1384201808-29812-1-git-send-email-jeremie.galarneau@efficios.com>
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


--===============0177456625==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

On 11 Nov (15:30:08), J=E9r=E9mie Galarneau wrote:
> Some error-handling code paths may call ht_cleanup_push() with NULL hash
> tables which will crash the clean-up thread.
>=20
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  src/bin/lttng-sessiond/utils.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/src/bin/lttng-sessiond/utils.c b/src/bin/lttng-sessiond/util=
s.c
> index 2ff57cd..c9c51ed 100644
> --- a/src/bin/lttng-sessiond/utils.c
> +++ b/src/bin/lttng-sessiond/utils.c
> @@ -52,6 +52,9 @@ void ht_cleanup_push(struct lttng_ht *ht)
>  	ssize_t ret;
>  	int fd =3D ht_cleanup_pipe[1];
> =20
> +	if (!ht) {
> +		return;
> +	}
>  	if (fd < 0)
>  		return;
>  	ret =3D lttng_write(fd, &ht, sizeof(ht));
> --=20
> 1.8.4.2
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJSgUHUXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I027AoH/0Dl8uRXSNjY2yAOP39nHLH0
ZLtscZWKjrFuInExnRISIFMaTXJQeSKyqDC/BSH/6quxJldt83dgUVkFkcJrC7t4
JIXYOvq7NxIHx3pyoCCSHwg78sx2YwYvGZxXYecv4VdRCWFP+P5TKOQMIs4Leerp
XkhcOoCL26GkQF4XHSEob+uJjQVNYJHSSduWBvkys6wgXJwVeXH2pBm3OR9hhrHT
P84pqA4nRHT7CiOiVZK5wpeTAuLqijVRxNXZjyozPIfzbNSU8A9WqlZVGRziCxHX
w/W/bUofElm/akr3UMbSel4CthGxiONf7FkcG+WG7nF4LHtkavusW3rLthWveyY=
=S01B
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--


--===============0177456625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0177456625==--
