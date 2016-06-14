From: "D'Alessandro, Luke K" <ldalessa@indiana.edu>
Subject: Re: urcu AC_FUNC_MALLOC fails for cross-compile
Date: Tue, 14 Jun 2016 16:26:51 +0000
Message-ID: <AB895F8E-7C42-43C6-AA36-CAE3B353E86A__30530.2340341315$1465921961$gmane$org@indiana.edu>
References: <A96D5DC1-9242-4C88-ADE1-150DCAE62C54@indiana.edu>
 <418211441.35787.1465921264498.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6595811809387320370=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from hartman.uits.indiana.edu (belushi.uits.indiana.edu
 [129.79.1.188])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id C1FDFA3876
 for <lttng-dev@lists.lttng.org>; Tue, 14 Jun 2016 16:26:52 +0000 (UTC)
In-Reply-To: <418211441.35787.1465921264498.JavaMail.zimbra@efficios.com>
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
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6595811809387320370==
Content-Language: en-US
Content-Type: multipart/signed;
	boundary="Apple-Mail=_E43CFDF3-8A7C-4CA0-9BA5-649FF382E7B1";
	protocol="application/pgp-signature"; micalg=pgp-sha512

--Apple-Mail=_E43CFDF3-8A7C-4CA0-9BA5-649FF382E7B1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Jun 14, 2016, at 12:21 PM, Mathieu Desnoyers =
<mathieu.desnoyers@efficios.com> wrote:
>=20
> ----- On Jun 14, 2016, at 12:12 PM, Luke K D'Alessandro =
ldalessa@indiana.edu wrote:
>=20
>> The AC_FUNC_MALLOC depends on some runtime results which doesn't work =
when cross
>> compiling. Google has a bit to say about this and basically the fix =
is to stop
>> using the macro. Is there a specific purpose for this check, or could =
it just
>> be eliminated from configure.ac?
>=20
> If we remove this check, we need to ensure that URCU does not depend
> on malloc(0) returning non-NULL anywhere.

Okay, I=E2=80=99m not sure what the implications are this for you. We =
have a test infrastructure that tries to download, build, and link =
liburcu using a cross compiler for 32-bit arm platforms, but it fails =
because of this check. I will try and figure out how to get a binary =
version of liburcu installed permanently somewhere that the cross =
compiler toolchain can find.

Thanks,
Luke

>=20
> Thanks,
>=20
> Mathieu
>=20
>>=20
>> Thanks,
>> Luke
>>=20
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>=20
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com


--Apple-Mail=_E43CFDF3-8A7C-4CA0-9BA5-649FF382E7B1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJXYDBLAAoJEJ9t5ApCTtG0D08P/AvtMKN6d57GLkKZBWJSgCbl
kCp27vOWu6haz7BBcTDItTm3QmW9fyk5QQulNbmALffj28DnO5sn5gS5N7xSYpW9
nZO/9K38A89e++eoh+qAi+MdA4kT2FkGIeXFuxWJ4CaSKmL86WGRO3P+2ZQSQpxN
t1tYXGKzAzgeL14S5HGkCjVI0wlhtobrwxa4qA9VYZWkvOr8lRqBSG7tvnAxpUEd
Feuj4Ek6p7d09OuYtv6gk+428mc3t4RB9a+86WRG3lYw5f6cW587gWxlQqqHELYa
A0IFUqzzCflmfHNPe88nHrcEA+9EDrVAXNE4ZB7LBJPAEC7ljbxN035xNTneVyYX
1W6x3wl/aFDuyS7huxiC+qUQEg0QbBj6PviljYiiHsu3p6iXmDsaI8pI0FHPOFlc
t9OVMG9SZAgpZeKKUJtJVzQGZq9goKnfJUaNlhi7mM+ifGBu87wjBAc9ULwtfk1Q
Ql1LIGLzA9jD1/vjzN49ZvH+h/YIetQZK6YA8DdDDJe2E4S0ZATizU685jZH71Wk
RKBra/lNUfCEztitQNveUBsWOt74XLweJFcLDstvr9jLTH3F7+9BaHIvnC0FVD1t
VGeFWoYVT28knpa1saZcGUJ8dxR6F1+eXiltwf4gctFh+3PfsuzIXUixgVHylcrG
yBzs4R4AfDGAuKHHu4U1
=urrA
-----END PGP SIGNATURE-----

--Apple-Mail=_E43CFDF3-8A7C-4CA0-9BA5-649FF382E7B1--

--===============6595811809387320370==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6595811809387320370==--
