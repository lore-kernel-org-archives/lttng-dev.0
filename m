From: Rolf Eike Beer <eb@emlix.com>
Subject: Re: Wrong "ar" used when cross-building lttng
Date: Fri, 15 Nov 2019 09:18:38 +0100
Message-ID: <4096513.X5kWAsihKE__5918.26719917066$1573831897$gmane$org@devpool35>
References: <2357817.GzqeBO7jDX@devpool35> <3241563.NbJrRt7XGO@devpool35>
 <3c62ba15-bb2d-702e-86f4-90e8decc9fb1@simark.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3014116876383470931=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx1.emlix.com (mx1.emlix.com [188.40.240.192])
 by lists.lttng.org (Postfix) with ESMTPS id 47Drpg03vNzsZW
 for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2019 03:18:50 -0500 (EST)
Received: from mailer.emlix.com (unknown [81.20.119.6])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id A6F1C5F9B1
 for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2019 09:18:42 +0100 (CET)
In-Reply-To: <3c62ba15-bb2d-702e-86f4-90e8decc9fb1@simark.ca>
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

--===============3014116876383470931==
Content-Type: multipart/signed; boundary="nextPart2268531.uHNLZkHdNb"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2268531.uHNLZkHdNb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Simon Marchi wrote:
> On 2019-11-14 11:24 a.m., Rolf Eike Beer wrote:

> > I have not checked latest git, but maybe you may want to fix this warni=
ng,
> > too?
> >=20
> > With 2.11.0 release tarball:
> >=20
> > -./configure: line 24663: test: -eq: unary operator expected

> Hmm I don't remember seeing this error, and I don't see it now.
>=20
> Could you please try with master?  If it still happens, you can try to
> find from which line of the configure.ac or an m4 file this line comes
> from.  I presume it won't be too hard to fix.

Sorry, my fault. If I had looked a little closer I could have given you the=
=20
context:

 checking for tput... /usr/bin/tput
 tput: No value for $TERM and no -T specified
=2E/configure: line 24663: test: -eq: unary operator expected

When the package is built inside our automated buildsystem these variables =
are=20
not set because this is no interactive shell. If I build with an interactiv=
e=20
shell these warnings are in fact not there.

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source
--nextPart2268531.uHNLZkHdNb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCXc5fXgAKCRCr5FH7Xu2t
/NjHA/9/ILIQayfBzgjLwYz/oaUY1ryNRdz+yEntjJdiEKneSboQrLShnJQ4EVW1
kj1mWmL5oN9CRwqmK3ZxLEiopmfxhILwfWTIt3C0eT6TnHqqHrhJMfK7xlUVfSKo
gyFb9nrmJB5dGtTn23j7zQV+xAx5AYjklsgrKm+Lm8xbL4FPRw==
=5sdb
-----END PGP SIGNATURE-----

--nextPart2268531.uHNLZkHdNb--




--===============3014116876383470931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3014116876383470931==--
