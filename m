From: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@polymtl.ca>
Subject: Re: [PATCH lttng-tools] lttng cli: Accept human
 readable sizes for --subbuf-size
Date: Tue, 02 Apr 2013 22:52:54 -0400
Message-ID: <515B9986.7080802__508.07820302925$1364957637$gmane$org@polymtl.ca>
References: <1364935514-11042-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1529428301=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <nashii@gmail.com>) id 1UNDox-00036r-KB
	for lttng-dev@lists.lttng.org; Tue, 02 Apr 2013 22:53:07 -0400
Received: by mail-ie0-f169.google.com with SMTP id qd14so1190903ieb.14
	for <lttng-dev@lists.lttng.org>; Tue, 02 Apr 2013 19:53:02 -0700 (PDT)
In-Reply-To: <1364935514-11042-1-git-send-email-simon.marchi@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1529428301==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2DGICDEUBPFSDQABVNEAR"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2DGICDEUBPFSDQABVNEAR
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-04-02 16:45, Simon Marchi wrote:
> --subbuf-size accepts sizes such as:
>=20
> - 123 -> 123
> - 123k or 123K -> 123 * 1024
> - 123m or 123M -> 123 * 1024 * 1024
> - 123g or 123G -> 123 * 1024 * 1024 * 1024

I don't really like using non-SI prefixes such as "K", "m" or "g" (well,
in fact "m" is an SI prefix but for milli, not mega).
I think that would be better to only use "k", "M" and "G".


------enig2DGICDEUBPFSDQABVNEAR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRW5mLAAoJECV+8Ygg/tEo9CYP/jgksvrlxm28qslwkp/CnSY+
cOMx00BXgqgkXZp1XrBy3cBGe27XYMdsYUoALCXIV4gSGnORoefafcZ06JqW5KYU
LUANgcDvwzYCpRx5OVXB+H15Ndoi3GQiHi7CuER7RHzIVHYMdv2sqhFMiKVLMNQg
tm+S461MvBw23rgGG323WQF7araKnsCTV5iT/0964WUjdiiBt0b2bjNQ0O9BTNWM
T6wMa8kxSZKC7TtqlhXMP94hYRAdA/1/f9rwTxf80o81zNrrUuu2A26qavLuG4w8
vETdIlBTyrB1ouULnMl/dF+eOdGL0/VbRIpmP5AndHsSvfn3iVWKz4JPZbms2PEh
lA+htHISj7xCjUs6pZqNs8IVgLOxdN8y+CdOTNSQX59CKfqhBV+RpsINS+ebZPx5
rd1dtRNn+FbMllTKCVOzVDULavV904QVX+nffsb7MQCDnwF5FS6WpdkTjb6rAm8H
coFBlVvIuXGHAk6tTxa7uVzaSWdoSrFnY/kKrVt21uY/2Wg9SPhJIN9kJ5DclARX
kr/M0jI4X8wki1pUQ1Y3Q6YiJVCuv1HV6D6YPlNloXmLme1syHONOxAxY17/mIyY
ZiUAjgMTbA1+soViO1SheAY33fWH4DWTXepnkPgRrTaddScXKCVwXiZ5Yi/8nTd9
B9YQMtjE1sULGt6xEtik
=z6cD
-----END PGP SIGNATURE-----

------enig2DGICDEUBPFSDQABVNEAR--


--===============1529428301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1529428301==--
