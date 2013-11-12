From: David Goulet <dgoulet@efficios.com>
Subject: Re: LTTng packages in Debian sid out of sync
Date: Tue, 12 Nov 2013 10:39:03 -0500
Message-ID: <20131112153903.GC7321__2363.81841027669$1384270828$gmane$org@thessa>
References: <630558869.45441.1382211345502.JavaMail.zimbra@efficios.com>
	<856849325.45462.1382211994767.JavaMail.zimbra@efficios.com>
	<20131019211009.GA83292@helmut.local>
	<300817690.45707.1382242504740.JavaMail.zimbra@efficios.com>
	<20131020134521.GA97360@helmut.local>
	<1084047903.45979.1382281219903.JavaMail.zimbra@efficios.com>
	<20131020160434.GA2011@helmut.local>
	<20131103231921.GA6958@shaniqua>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0330080090=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VgG3c-0003aK-2c
	for lttng-dev@lists.lttng.org; Tue, 12 Nov 2013 10:39:18 -0500
In-Reply-To: <20131103231921.GA6958@shaniqua>
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


--===============0330080090==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03 Nov (18:19:21), Jon Bernard wrote:
> * Jon Bernard <jbernard@debian.org> wrote:
> > * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > > ----- Original Message -----
> > > > From: "Jon Bernard" <jbernard@debian.org>
> > > > To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> > > > Cc: "St=E9phane Graber" <stgraber@ubuntu.com>, "Alexandre Montplais=
ir" <alexmonthy@voxpopuli.im>,
> > > > lttng-dev@lists.lttng.org
> > > > Sent: Sunday, October 20, 2013 9:45:21 AM
> > > > Subject: Re: LTTng packages in Debian sid out of sync
> > > >=20
> > > [...]
> > > >=20
> > > > That is not exactly what I intended to convey, let me be more direc=
t about my
> > > > view.  I completely agree that sid should have 2.3.x immediately.  =
I also
> > > > agree
> > > > that 2.3 should be targeted for testing, and therefore the next sta=
ble
> > > > release.
> > >=20
> > > Allright :) I'm glad we're on the same page, sorry for the misunderst=
anding.
> >=20
> > No worries.  I'll add that future releases (like the upcoming 2.4) will
> > be prepared and tested all together prior to upload - to hopefully avoid
> > the previous situation/nightmare that I managed to get myself into.
> >=20
> > There can still be a sizable amount of work for 2.3 to fully land into
> > testing, so that is my primary focus.  The freeze deadline is fast
> > approaching, so I will be keeping a close eye on things as they
> > progress.  As things settle I'll post status here.
>=20
> lttng-tools 2.3.0 was just accepted, so on sid (unstable) we should now b=
e at
> version 2.3.0 across the board.  Things look pretty good to me, but if an=
yone
> has time to test the packages and let me know if something's missing, str=
uctured
> incorrectly, or not behaving as expected - that would be awesome.

Why is lttng-tools depending on "lttng-modules-dkms"? It should not, it
should only be a suggested package.

http://packages.debian.org/sid/lttng-tools

Thanks!
David

>=20
> Cheers,
>=20
> --=20
> Jon
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJSgkuXXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02S1AH/0Nk+PwXGp3uqcNrcCCxOg6E
E+T3hioAIe17wU92E64DMpz7lbt+DLQD/cDhbaddHLqGvPE//1ujQSJ588QFnbjT
rbJcL7ZwTYUNMqRO1suuDdzq+EhvDBLEnWyth0LIN2jbaOvfmsdhbISNRv4Sgqbx
YQs2ZG2y2drOhW3ZnPd1vP89O1aTT//VcHAkW8rYRrruWGOdOKXrQCdRlFpp4z/w
J5kTT2106jis+lmy9VvOGVCS481KSxcwsi3c3SjpOTKDjsBTI+LLzQJZShCueOnV
6PvSwPiYtgkblQGCMVG8LXWmjtEoN6BZ/zyGpvfc+ZfCUC5Wb9Y1RbTuA8/Z3YY=
=0XYp
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--


--===============0330080090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0330080090==--
