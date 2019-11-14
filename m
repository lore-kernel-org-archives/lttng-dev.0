From: Rolf Eike Beer <eb@emlix.com>
Subject: Wrong "ar" used when cross-building lttng
Date: Thu, 14 Nov 2019 08:58:36 +0100
Message-ID: <2357817.GzqeBO7jDX__44833.0490429484$1573744937$gmane$org@devpool35>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4075043727174893423=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx1.emlix.com (mx1.emlix.com [188.40.240.192])
 by lists.lttng.org (Postfix) with ESMTPS id 47DDZt678Jz1SXD
 for <lttng-dev@lists.lttng.org>; Thu, 14 Nov 2019 03:06:30 -0500 (EST)
Received: from mailer.emlix.com (unknown [81.20.119.6])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id 04FA75FACF
 for <lttng-dev@lists.lttng.org>; Thu, 14 Nov 2019 08:58:41 +0100 (CET)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============4075043727174893423==
Content-Type: multipart/signed; boundary="nextPart1944331.v22AYEsccN"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart1944331.v22AYEsccN
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

The unprefixed version of "ar" is being used, leading to this error:

arm-unknown-linux-gnueabi-gcc  -I. -Wall -I../../../include/ -I../../../
include/ \
        -O2 -g -march=3Darmv7-a -mtune=3Dcortex-a9 -mfpu=3Dneon-fp16 -mfloa=
t-
abi=3Dhard -mthumb-interwork -pipe -Wl,--no-copy-dt-needed-entries,--as-nee=
ded -
Wl,--build-id -Wdate-time -c -o lttng-ust-provider-hello.o tp.c
ar -rc lttng-ust-provider-hello.a lttng-ust-provider-hello.o
make[4]: ar: Command not found

I fixed it for the moment with "make AR=3Darm-unknown-linux-gnueabi-ar", bu=
t=20
ideally this would not be needed.

Greetings,

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source
--nextPart1944331.v22AYEsccN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCXc0JLAAKCRCr5FH7Xu2t
/JnlA/9BuBUu+SNN3O25pT+It1ZgUQ9c+h6+bpEWukkhyMoQwUy1KBPpzjGk2/hD
QZdQsXX4AvxXXeP48hqgK2KpI7DO+fiuOApL6fg2tOfIlwNawKfEZ4NY+H0qhEVW
/Ps0SE94onTaDqW96NkuQG3AHqFdlVU2LrC3sSUClS8Cbf48Lw==
=W1tJ
-----END PGP SIGNATURE-----

--nextPart1944331.v22AYEsccN--




--===============4075043727174893423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4075043727174893423==--
