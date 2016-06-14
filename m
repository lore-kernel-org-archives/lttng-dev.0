From: "D'Alessandro, Luke K" <ldalessa@indiana.edu>
Subject: urcu AC_FUNC_MALLOC fails for cross-compile
Date: Tue, 14 Jun 2016 16:12:51 +0000
Message-ID: <A96D5DC1-9242-4C88-ADE1-150DCAE62C54__16978.9491490976$1465921344$gmane$org@indiana.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2768095091290249804=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from hartman.uits.indiana.edu (belushi.uits.indiana.edu
 [129.79.1.188])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 3A775A386B
 for <lttng-dev@lists.lttng.org>; Tue, 14 Jun 2016 16:12:53 +0000 (UTC)
Received: from in-cci-exch0a.ads.iu.edu (in-cci-exch0a.ads.iu.edu
 [10.234.33.137])
 by mssg-relay.indiana.edu (8.14.7/8.14.4/IU Campus Communications Team) with
 ESMTP id u5EGCqGQ024318
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Tue, 14 Jun 2016 12:12:52 -0400
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2768095091290249804==
Content-Language: en-US
Content-Type: multipart/signed;
	boundary="Apple-Mail=_BA9E0754-4577-4089-B751-741AD36CF1DA";
	protocol="application/pgp-signature"; micalg=pgp-sha512

--Apple-Mail=_BA9E0754-4577-4089-B751-741AD36CF1DA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

The AC_FUNC_MALLOC depends on some runtime results which doesn't work =
when cross compiling. Google has a bit to say about this and basically =
the fix is to stop using the macro. Is there a specific purpose for this =
check, or could it just be eliminated from configure.ac?

Thanks,
Luke

--Apple-Mail=_BA9E0754-4577-4089-B751-741AD36CF1DA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJXYC0DAAoJEJ9t5ApCTtG0n3gP/1W8esspu/Q2SGY7V8gVDs2h
4+xrGHN9BUddknxxQolNs+n/U4F+KWhaxexHLq+xFlJRPb0GHs7IoMJHL5UkSsNO
iylQ9wWgXrWQj/lyvuba445MPKgKURmNX6aD3vvdFkjZB3Pdol+4liuprVJyc6Ff
+XbreTnH8hvueSh4YGhSLuf0CgVPNq8mTHwrzPpDLd91IscE5kSmvQCC/FivGTo2
IB/YTVWt8HlPgZxBVTS5kl05Prv5UVuFNNIzqxCIYWmVPYuXBdEBBHO0Ek8vUPnS
E2nzI4LeUSsSQgVPG+AeUCZJigvKSbHUWlpg368N9cijR/uhAPjARXWCGfgSpUwk
rYsBTFSaUALg8Dw7m09BPk9j5zjYnbkhLSoDyup9xR21xdv8morFQX+JWEQdhjGX
YsN1eLQZBxfvkRbOORKIjwWqGS5VqSV1gc7Yfu/YuqQ5DzM56RQBBcswOSKGlIBC
i8U4Z/w54W0DWhp0VSsFI3BM1NRI2GFmBqODznojiIKv4wBmcn781yiEu7KoQnHO
sbUWXuE35Rf1nkb0NCOR0dGMvVeOc1iBGopFZbboT2Y4OpxS2DS3I11f0I2AZWAN
UVfZ4Saycw6QGm1LiKEZcnO2Sxm/IzkKn+rweE9n9JNWim9oryWWDlBMY6YnlnhZ
DMboSfG5ZvLYlgTuuyS0
=SXSh
-----END PGP SIGNATURE-----

--Apple-Mail=_BA9E0754-4577-4089-B751-741AD36CF1DA--

--===============2768095091290249804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2768095091290249804==--
