From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] urcu: fix deprecation warning with new glibc
Date: Mon, 1 Jun 2015 17:16:27 +0200
Message-ID: <556C774B.8090206__947.419406338845$1433172294$gmane$org@pengutronix.de>
References: <1433164590-9078-1-git-send-email-mkl@pengutronix.de>
 <1237864258.1418.1433168737082.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2004796685=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mkl@pengutronix.de>) id 1YzRSN-0006pa-6D
 for lttng-dev@lists.lttng.org; Mon, 01 Jun 2015 11:17:00 -0400
In-Reply-To: <1237864258.1418.1433168737082.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2004796685==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Jni3OlCbPspF7IWDE383taRAqEVPL1vCf"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Jni3OlCbPspF7IWDE383taRAqEVPL1vCf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/01/2015 04:25 PM, Mathieu Desnoyers wrote:
> ----- On Jun 1, 2015, at 3:16 PM, Marc Kleine-Budde mkl@pengutronix.de =
wrote:
>=20
>> This patch fixes the following warning:
>>
>> /usr/include/features.h:148:3: warning: #warning "_BSD_SOURCE and _SVI=
D_SOURCE
>> are deprecated, use _DEFAULT_SOURCE" [-Wcpp]
>> # warning "_BSD_SOURCE and _SVID_SOURCE are deprecated, use _DEFAULT_S=
OURCE"
>=20
> And why does this patch just add _DEFAULT_SOURCE without removing _BSD_=
SOURCE ?
> Is it the intended transition path ? Is it documented somewhere ?

=46rom http://man7.org/linux/man-pages/man7/feature_test_macros.7.html:

_BSD_SOURCE (deprecated since glibc 2.20)
[...]
Since glibc 2.20, this macro is deprecated.  It now has the
              same effect as defining _DEFAULT_SOURCE, but generates a co=
m=E2=80=90
              pile-time warning (unless _DEFAULT_SOURCE is also defined).=

              Use _DEFAULT_SOURCE instead.  To allow code that requires
              _BSD_SOURCE in glibc 2.19 and earlier and _DEFAULT_SOURCE i=
n
              glibc 2.20 and later to compile without warnings, define bo=
th
              _BSD_SOURCE and _DEFAULT_SOURCE.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Jni3OlCbPspF7IWDE383taRAqEVPL1vCf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVbHdLAAoJEP5prqPJtc/Hq8YIAKFNv2JpdiBh3iKVQQ2eJwRa
OS60+8q/f2FzMgJ7rn3nXS2lJTjNClcUr5MnCyrEM5ZfF4LRyk0BGLnYtpbgt6vk
zk6tLcP8Uc5zZ3C5yPySeVzqycZMTLAZL+4SLjuWNhmDt0xpdwZUrdCSpBxPwBlZ
YEPwVc0T681z7CBThcizHfDjTPmn6hWAMDoBkTsqkFtw3u1L433bDYWcTR7qZWPq
j/x7q7FkW19GkLOhxHDNMZcKm5/3FDY9qupwZ/NNeKygWJOblfcPmSEd7ABxSa81
EYrdFRKMHf9mkPSoMqYHhk5NzWWgHgyoTPKBPzPfLe+SuR22dMGXl6SxKevMSR0=
=kILJ
-----END PGP SIGNATURE-----

--Jni3OlCbPspF7IWDE383taRAqEVPL1vCf--


--===============2004796685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2004796685==--
