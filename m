From: Rolf Eike Beer <eb@emlix.com>
Subject: Re: Wrong "ar" used when cross-building lttng
Date: Thu, 14 Nov 2019 17:24:38 +0100
Message-ID: <3241563.NbJrRt7XGO__24461.2829572119$1573748789$gmane$org@devpool35>
References: <2357817.GzqeBO7jDX@devpool35>
 <2e655403-71d2-ee11-3675-d9ad81d6fe85@simark.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5068348415382414498=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx1.emlix.com (mx1.emlix.com [188.40.240.192])
 by lists.lttng.org (Postfix) with ESMTPS id 47DRdm28vxzrXX
 for <lttng-dev@lists.lttng.org>; Thu, 14 Nov 2019 11:24:43 -0500 (EST)
Received: from mailer.emlix.com (unknown [81.20.119.6])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id 0506A5FD33
 for <lttng-dev@lists.lttng.org>; Thu, 14 Nov 2019 17:24:42 +0100 (CET)
In-Reply-To: <2e655403-71d2-ee11-3675-d9ad81d6fe85@simark.ca>
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

--===============5068348415382414498==
Content-Type: multipart/signed; boundary="nextPart1834589.XSYue2n15a"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart1834589.XSYue2n15a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Simon Marchi wrote:
> On 2019-11-14 2:58 a.m., Rolf Eike Beer wrote:
> > The unprefixed version of "ar" is being used, leading to this error:
> >=20
> > arm-unknown-linux-gnueabi-gcc  -I. -Wall -I../../../include/ -I../../../
> > include/ \
> >=20
> >         -O2 -g -march=3Darmv7-a -mtune=3Dcortex-a9 -mfpu=3Dneon-fp16 -m=
float-
> >=20
> > abi=3Dhard -mthumb-interwork -pipe
> > -Wl,--no-copy-dt-needed-entries,--as-needed - Wl,--build-id -Wdate-time
> > -c -o lttng-ust-provider-hello.o tp.c
> > ar -rc lttng-ust-provider-hello.a lttng-ust-provider-hello.o
> > make[4]: ar: Command not found
> >=20
> > I fixed it for the moment with "make AR=3Darm-unknown-linux-gnueabi-ar"=
, but
> > ideally this would not be needed.
> >=20
> > Greetings,
> >=20
> > Eike
>=20
> Hi Rofl,
>=20
> Indeed, I can see the problem.
>=20
> Can you please try the patch below?  It adds an autoconf check for ar and
> then passes it as an environment variable to the Makefiles of doc/example=
s.

Works for me.

I have not checked latest git, but maybe you may want to fix this warning,=
=20
too?

With 2.11.0 release tarball:

=2D./configure: line 24663: test: -eq: unary operator expected

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
--nextPart1834589.XSYue2n15a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCXc1/xgAKCRCr5FH7Xu2t
/DsuA/9cavIOBWyXdPeI6NTqqqlQ9eAL41pom0jwxH392aQOx6y2UXI/fyvihuiC
1VWbt1c8vrw8YKYu6DzQctKSQ1kQGEk1HdYI34y2OcE2gmH6yHExNmo/00BMvSYm
Zi17ZzMzMSb2lpOex3L/ZLvmYhAwixJt8F6OS6gSkp9ym9bgNA==
=//JC
-----END PGP SIGNATURE-----

--nextPart1834589.XSYue2n15a--




--===============5068348415382414498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5068348415382414498==--
