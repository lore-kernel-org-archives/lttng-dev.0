From: David Goulet <dgoulet@efficios.com>
Subject: Re: [RFC PATCH lttng-tools] Fix: Propagate socket
 timeouts on lttcomm_accept_inet_sock()
Date: Thu, 25 Sep 2014 11:34:08 -0400
Message-ID: <20140925153408.GC23466__29944.6842320778$1411659330$gmane$org@thessa>
References: <1411508792-32112-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0729496021=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XXB3e-0006bj-A6
 for lttng-dev@lists.lttng.org; Thu, 25 Sep 2014 11:34:16 -0400
In-Reply-To: <1411508792-32112-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0729496021==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

On 23 Sep (17:46:32), J=E9r=E9mie Galarneau wrote:
> Ensure that send/recv timeouts are applied to new sockets created
> from a lttcomm_accept_inet_sock().
>=20
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  src/common/sessiond-comm/inet.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/src/common/sessiond-comm/inet.c b/src/common/sessiond-comm/i=
net.c
> index 2c959c5..cf06ecb 100644
> --- a/src/common/sessiond-comm/inet.c
> +++ b/src/common/sessiond-comm/inet.c
> @@ -275,6 +275,7 @@ struct lttcomm_sock *lttcomm_accept_inet_sock(struct =
lttcomm_sock *sock)
>  	int new_fd;
>  	socklen_t len;
>  	struct lttcomm_sock *new_sock;
> +	unsigned long timeout;
> =20
>  	if (sock->proto =3D=3D LTTCOMM_SOCK_UDP) {
>  		/*
> @@ -298,6 +299,19 @@ struct lttcomm_sock *lttcomm_accept_inet_sock(struct=
 lttcomm_sock *sock)
>  		PERROR("accept inet");
>  		goto error;
>  	}
> +	timeout =3D lttcomm_get_network_timeout();
> +	if (timeout) {
> +		int ret;
> +
> +		ret =3D lttcomm_setsockopt_rcv_timeout(new_fd, timeout);
> +		if (ret) {
> +			goto error;
> +		}
> +		ret =3D lttcomm_setsockopt_snd_timeout(new_fd, timeout);
> +		if (ret) {
> +			goto error;
> +		}
> +	}
> =20
>  	new_sock->fd =3D new_fd;
>  	new_sock->ops =3D &inet_ops;
> --=20
> 2.1.0
>=20

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJUJDXwXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02ZbUIAKeB67x9OFe47ejw8hVDhub6
/gRW47Af91zn/glHVsMWi6OiUyQoQGAFnK9ghkMAZk57XytqFWrj7vPJWmAdPawN
zUql+I/kWrBa+9PosNnLVLb56K290twNDmEIejMCKXH0/S3KvB+V3SAaVZoVZ5d2
FZ8avdBz+ZbDm2aPFwV/XHmv2OzT+/hsAXjhwF3+YmL62Z7vhzi6ctwfmkuo85BQ
QFxAiG3pO0Us2dlX6t+VRRBBk5p2b60CBRM2maFpVJLr590DeFIUd4+J3mV811Oe
fJUptMazk0iuCic0gdQ8VbdxlI6tKBZ+ZngKYgfi6iAxAjE8eTb16xY48yYSq90=
=pLfH
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--


--===============0729496021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0729496021==--
