From: Rolf Eike Beer <eb@emlix.com>
Subject: Re: Wrong "ar" used when cross-building lttng
Date: Mon, 18 Nov 2019 09:10:13 +0100
Message-ID: <8118904.6pNFUeu9c4__39084.8499302351$1574091320$gmane$org@devpool35>
References: <2357817.GzqeBO7jDX@devpool35> <4096513.X5kWAsihKE@devpool35>
 <50ff7646-3ca9-0fdd-f9bf-6bfa8e63bad3@simark.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5707936801677229298=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx1.emlix.com (mx1.emlix.com [188.40.240.192])
 by lists.lttng.org (Postfix) with ESMTPS id 47GhTY6vVlzrsV
 for <lttng-dev@lists.lttng.org>; Mon, 18 Nov 2019 03:10:25 -0500 (EST)
Received: from mailer.emlix.com (unknown [81.20.119.6])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id C9B265FB2A
 for <lttng-dev@lists.lttng.org>; Mon, 18 Nov 2019 09:10:17 +0100 (CET)
In-Reply-To: <50ff7646-3ca9-0fdd-f9bf-6bfa8e63bad3@simark.ca>
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

--===============5707936801677229298==
Content-Type: multipart/signed; boundary="nextPart1965398.yEgYi22VSo"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart1965398.yEgYi22VSo
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Freitag, 15. November 2019, 16:34:33 CET schrieb Simon Marchi:
> On 2019-11-15 3:18 a.m., Rolf Eike Beer wrote:
> > Simon Marchi wrote:
> >> On 2019-11-14 11:24 a.m., Rolf Eike Beer wrote:
> >>> I have not checked latest git, but maybe you may want to fix this
> >>> warning,
> >>> too?
> >>>=20
> >>> With 2.11.0 release tarball:
> >>>=20
> >>> -./configure: line 24663: test: -eq: unary operator expected
> >>=20
> >> Hmm I don't remember seeing this error, and I don't see it now.
> >>=20
> >> Could you please try with master?  If it still happens, you can try to
> >> find from which line of the configure.ac or an m4 file this line comes
> >> from.  I presume it won't be too hard to fix.
> >=20
> > Sorry, my fault. If I had looked a little closer I could have given you
> > the
> >=20
> > context:
> >  checking for tput... /usr/bin/tput
> >  tput: No value for $TERM and no -T specified
> >=20
> > ./configure: line 24663: test: -eq: unary operator expected
> >=20
> > When the package is built inside our automated buildsystem these variab=
les
> > are not set because this is no interactive shell. If I build with an
> > interactive shell these warnings are in fact not there.
>=20
> It still sounds like the "test" command should be improved, it should not
> fail with an invalid syntax.  Can you give us the relevant lines of
> configure around 24663, and if possible match them to the source lines in
> configure.ac and/or one of the m4 files in the m4 directory?

The line in configure is this:

    if test -n "$PS1" && test `"$pprint_tput" colors` -eq 256 && test -t 1;=
=20
then :

Which seems to be one of these 3 lines from configure.ac:

PPRINT_INIT
PPRINT_SET_INDENT(1)
PPRINT_SET_TS(38)

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source
--nextPart1965398.yEgYi22VSo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCXdJR5QAKCRCr5FH7Xu2t
/MyfBACA1wc7m18R2Vsxx6rMlWl+FFKu6Am10rZXFCBruNjh3NYpuz11puhk+VaG
l0nI3zEQwVSvUUdgMiznv7jB66KPoZjQFhCqXDI3wPxjDwt5nbD+T8kZNx2d5073
u9/MauZjUKwc12qAEdfGsTutT0JqtBuRGE1jbB0tHIjMn6fvVQ==
=TLAA
-----END PGP SIGNATURE-----

--nextPart1965398.yEgYi22VSo--




--===============5707936801677229298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5707936801677229298==--
