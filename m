From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools stable-2.2] Fix: possible
 double-close on stream out_fd
Date: Fri, 05 Jul 2013 11:11:32 -0400
Message-ID: <51D6E224.5020307__673.655191394751$1373037132$gmane$org@efficios.com>
References: <20130704223735.GA10902@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0715832371=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Uv7fh-0005u9-2M
	for lttng-dev@lists.lttng.org; Fri, 05 Jul 2013 11:11:41 -0400
In-Reply-To: <20130704223735.GA10902@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============0715832371==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enig5CD99EA66B4C769E76BAEDE8"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5CD99EA66B4C769E76BAEDE8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Merged

Mathieu Desnoyers:
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
> diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/=
kernel-consumer/kernel-consumer.c
> index fc86965..06801b9 100644
> --- a/src/common/kernel-consumer/kernel-consumer.c
> +++ b/src/common/kernel-consumer/kernel-consumer.c
> @@ -582,11 +582,12 @@ int lttng_kconsumer_on_recv_stream(struct lttng_c=
onsumer_stream *stream)
>  	return 0;
> =20
>  error_close_fd:
> -	{
> +	if (stream->out_fd >=3D 0) {
>  		int err;
> =20
>  		err =3D close(stream->out_fd);
>  		assert(!err);
> +		stream->out_fd =3D -1;
>  	}
>  error:
>  	return ret;
>=20


--------------enig5CD99EA66B4C769E76BAEDE8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBCgAGBQJR1uIkAAoJEELoaioR9I02JW8H/jVSNT2ktYt9YZI1UjLbj+y8
eHJ0VzWyOCiDJyN3QryHJBBHhcQ32mnztHBiSEMgXePaM//V7Uytq1IJMDCyBsqp
5RTmiu5ug3G2k+xAHk4AsErSGEJ+NqsP21GI1OHb+KeLxcpbPPVuaE2vVou/GxkI
nj7BjGVcPrZC+7vPWiAOXp3L3jhI4mfccAqMjNN4ZwskxTiYzNmDj33ACJhBXcOJ
lW47PR79CKUxR0iE3kHCQmokZ6nmdbJoXMHeUc+8rRB030t717St99VBBqjWeNJ8
LaysBW4EhseVE+cLcFC7SUa2UUDVMotNPF5LDesKbSMXwCgEjXQn4Zz361OsMbk=
=Pul/
-----END PGP SIGNATURE-----

--------------enig5CD99EA66B4C769E76BAEDE8--


--===============0715832371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0715832371==--
