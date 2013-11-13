From: David Goulet <dgoulet@efficios.com>
Subject: Re: LTTng packages in Debian sid out of sync
Date: Wed, 13 Nov 2013 16:09:38 -0500
Message-ID: <20131113210938.GC7694__21344.9611714625$1384377059$gmane$org@dalia>
References: <630558869.45441.1382211345502.JavaMail.zimbra@efficios.com>
	<856849325.45462.1382211994767.JavaMail.zimbra@efficios.com>
	<20131019211009.GA83292@helmut.local>
	<300817690.45707.1382242504740.JavaMail.zimbra@efficios.com>
	<20131020134521.GA97360@helmut.local>
	<1084047903.45979.1382281219903.JavaMail.zimbra@efficios.com>
	<20131020160434.GA2011@helmut.local>
	<20131103231921.GA6958@shaniqua> <20131112153903.GC7321@thessa>
	<20131113210223.GA6682@shaniqua>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1763591942=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Vghh4-0006cq-TD
	for lttng-dev@lists.lttng.org; Wed, 13 Nov 2013 16:09:53 -0500
In-Reply-To: <20131113210223.GA6682@shaniqua>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>, Alexandre Montplaisir <alexmonthy@voxpopuli.im>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1763591942==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Content-Disposition: inline


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13 Nov (16:02:23), Jon Bernard wrote:
> * David Goulet <dgoulet@efficios.com> wrote:
> > On 03 Nov (18:19:21), Jon Bernard wrote:
> > > * Jon Bernard <jbernard@debian.org> wrote:
> > > > * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > > > > ----- Original Message -----
> > > > > > From: "Jon Bernard" <jbernard@debian.org>
> > > > > > To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> > > > > > Cc: "St=E9phane Graber" <stgraber@ubuntu.com>, "Alexandre Montp=
laisir" <alexmonthy@voxpopuli.im>,
> > > > > > lttng-dev@lists.lttng.org
> > > > > > Sent: Sunday, October 20, 2013 9:45:21 AM
> > > > > > Subject: Re: LTTng packages in Debian sid out of sync
> > > > > >=20
> > > > > [...]
> > > > > >=20
> > > > > > That is not exactly what I intended to convey, let me be more d=
irect about my
> > > > > > view.  I completely agree that sid should have 2.3.x immediatel=
y.  I also
> > > > > > agree
> > > > > > that 2.3 should be targeted for testing, and therefore the next=
 stable
> > > > > > release.
> > > > >=20
> > > > > Allright :) I'm glad we're on the same page, sorry for the misund=
erstanding.
> > > >=20
> > > > No worries.  I'll add that future releases (like the upcoming 2.4) =
will
> > > > be prepared and tested all together prior to upload - to hopefully =
avoid
> > > > the previous situation/nightmare that I managed to get myself into.
> > > >=20
> > > > There can still be a sizable amount of work for 2.3 to fully land i=
nto
> > > > testing, so that is my primary focus.  The freeze deadline is fast
> > > > approaching, so I will be keeping a close eye on things as they
> > > > progress.  As things settle I'll post status here.
> > >=20
> > > lttng-tools 2.3.0 was just accepted, so on sid (unstable) we should n=
ow be at
> > > version 2.3.0 across the board.  Things look pretty good to me, but i=
f anyone
> > > has time to test the packages and let me know if something's missing,=
 structured
> > > incorrectly, or not behaving as expected - that would be awesome.
> >=20
> > Why is lttng-tools depending on "lttng-modules-dkms"? It should not, it
> > should only be a suggested package.
> >=20
> > http://packages.debian.org/sid/lttng-tools
>=20
> If you scroll down a bit, you'll see that it is a suggestion for all of
> the current architectures.  I fixed this in the last upload, but the
> packages view is misleading.  The powerpcspe should be removed, and
> armel is failing - so the latest version is not being considered.
>=20
> Once things settle, that view will look as it should.

Awesome Jon, thanks!

David

>=20
> --=20
> Jon

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJSg+qSXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I023mEH/RanY4PVe4kN06hsPkqZdTmU
MiQmeL4pctDcQIU+pvaPXZL0rFPiDrTWssKAkE+7BDQKWX+BSs9pSPaTj8vRtUU6
x+vvH+uYFMukgNfeNFMIk2UzgTYdHSroQof1Rb7ujCA8BdaQV7e7WBzGSf/r6Q/a
MA6Qf2ozsohLtNjYh9/xqQYpuE8JL3h4oQEKU4HLdcOGjgCuRkW/r5W+d0eH7Yyg
vLPbdjTPlLAXW75aXTzbAH9bGdcLLCM11ar294+OkrT//r4u7Jilc3hlEP5XS0UR
+OSrihTKdusvLDZQZ/oz7hQ3veP/tbrrIvSHF0eJnhzd4ahZqfmPVDpX564bQYY=
=ZoFm
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--


--===============1763591942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1763591942==--
