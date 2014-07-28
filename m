From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: unbalanced
 ustconsumer32_data.pid_mutex lock
Date: Mon, 28 Jul 2014 13:49:28 -0400
Message-ID: <20140728174928.GC5591__6516.30573343045$1406569861$gmane$org@thessa>
References: <1406507930-620-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0763683991=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XBp3J-0005I4-Nn
 for lttng-dev@lists.lttng.org; Mon, 28 Jul 2014 13:49:43 -0400
In-Reply-To: <1406507930-620-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0763683991==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged and backported!

Thanks!
David

On 27 Jul (20:38:50), Mathieu Desnoyers wrote:
> It is never locked in this function, but should be. This is triggering
> spurious runtime failures on my system, where it seems that sessiond was
> sometimes breaking the communication pipe with liblttng-ctl when the
> unbalanced unlock is reached.
>=20
> This should be backported to stable-2.4 and stable-2.5.
>=20
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  src/bin/lttng-sessiond/main.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
> index a8751c6..1ee6f4a 100644
> --- a/src/bin/lttng-sessiond/main.c
> +++ b/src/bin/lttng-sessiond/main.c
> @@ -3016,6 +3016,7 @@ static int process_client_msg(struct command_ctx *c=
md_ctx, int sock,
>  			}
> =20
>  			/* 32-bit */
> +			pthread_mutex_lock(&ustconsumer32_data.pid_mutex);
>  			if (consumerd32_bin[0] !=3D '\0' &&
>  					ustconsumer32_data.pid =3D=3D 0 &&
>  					cmd_ctx->lsm->cmd_type !=3D LTTNG_REGISTER_CONSUMER) {
> --=20
> 2.0.1
>=20

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJT1o0oXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02ubsH/AiAkTKPuwsZ3F97na6cpwiM
Kod5rqgqdZrRssC02+6dwlMONXye0uNRjGLJFdFigvCNgZYCWMSet2RQkBGsmU8U
I6eIWcWKoOv6z9xCgwmW8T9jOYqpnO/Ixrazu+60pmEsDNFHYntDk5lYUMtH1pyu
S/cmpgU225LVWY9QW4MxSPg4vD9jYVR0xB/gIuEm1EOWzDqBm/fGi7KI/9OTTrhI
m40Uv5C6F7FaGHAwPiil37btUQLojhWEpNFtTwRs7AsIUf8+2JxGSQVvEKDT2ZLC
g9XrUmKmhssbpD1+/vJJTMKcG5jMR/0kh4uuf5XHbCZ3odiJ1aTbHr92oiXuvCA=
=+kH1
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--


--===============0763683991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0763683991==--
