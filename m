From: David Goulet <dgoulet@efficios.com>
Subject: Re: lttng-tools compilation error v2.5.0 rc1
Date: Wed, 9 Jul 2014 16:48:24 -0400
Message-ID: <20140709204824.GF31685__8774.17419474131$1404938983$gmane$org@dalia>
References: <53AD6327.3080501@xsilon.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1043246407=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1X4yn1-0001Fc-QL
 for lttng-dev@lists.lttng.org; Wed, 09 Jul 2014 16:48:37 -0400
In-Reply-To: <53AD6327.3080501@xsilon.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1043246407==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TmwHKJoIRFM7Mu/A"
Content-Disposition: inline


--TmwHKJoIRFM7Mu/A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

Sorry for the delay, AFK from work :).

Cheers!
David

On 27 Jun (13:27:19), Martin Townsend wrote:
> Hi,
>=20
> I updated to version 2.5.0 rc1 today and found that I couldn't build
> lttng-tools for my Microblaze based system.
>=20
> | error.c: In function 'log_add_time':
> | error.c:52:17: error: 'error_log_time' undeclared (first use in this
> function)
> |   ret =3D snprintf(error_log_time.str, sizeof(error_log_time.str),
> |                  ^
> | error.c:52:17: note: each undeclared identifier is reported only once f=
or
> each function it appears in
> | make[3]: *** [error.lo] Error 1
> | make[3]: *** Waiting for unfinished jobs....
>=20
> After grepping URCU_TLS in the source I could see it was used elsewhere w=
ith
> accessor macros so I used the following patch which fixes the compiler
> error.
>=20
> I'm not familiar with the code so I was wondering if this is the correct
> fix?
>=20
> Best Regards,
> Martin
>=20
> From 8a2789962fb22e92f8e9b46747c4d56cdaae04ca Mon Sep 17 00:00:00 2001
> From: Martin Townsend <martin.townsend@xsilon.com>
> Date: Fri, 27 Jun 2014 11:41:03 +0100
> Subject: [PATCH] fixed compile error mising URCU_TLS
>=20
> ---
>  src/common/error.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/common/error.c b/src/common/error.c
> index 418fc47..92852f9 100644
> --- a/src/common/error.c
> +++ b/src/common/error.c
> @@ -49,14 +49,14 @@ const char *log_add_time(void)
>      }
>=20
>      /* Format time in the TLS variable. */
> -    ret =3D snprintf(error_log_time.str, sizeof(error_log_time.str),
> +    ret =3D snprintf(URCU_TLS(error_log_time).str,
> sizeof(URCU_TLS(error_log_time).str),
>              "%02d:%02d:%02d.%06ld",
>              tm.tm_hour, tm.tm_min, tm.tm_sec, tp.tv_nsec);
>      if (ret < 0) {
>          goto error;
>      }
>=20
> -    return error_log_time.str;
> +    return URCU_TLS(error_log_time).str;
>=20
>  error:
>      /* Return an empty string on error so logging is not affected. */
> --=20
> 1.9.1
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--TmwHKJoIRFM7Mu/A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTvaqYXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02to0H/R6HUQXcqlLr/TO74AP6pD9P
pnFk9azSMYCxgcfXk0RB1iTRjfMou5LMGQ/4ZS456Ch/kXH0scOqF08GqzO2n7w2
LBpbVdy1bZpedDoWOEEKvCG21jDrPLrCFA1SKeWiis9KzeHd8QoYSUbJxjW7tzLp
micxdofs1NkeHHPq42RF54rl+W3JozM3ZwEY8mP+eVqAcPV7i24QWyEtpKxlj996
45NEQW2g42vv7yHX8MlVRzbyOXgLMzAitPXJ9thCDdBRbsjS0OS1RIXvNNTE+Akh
977OOOo6edwaFAh3rlE74vXJAMVdYxwDUtmpXKr1OPtR0HhcaNzZ+HabN1jxEVM=
=zTW7
-----END PGP SIGNATURE-----

--TmwHKJoIRFM7Mu/A--


--===============1043246407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1043246407==--
