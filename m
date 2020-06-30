From: Stefan Hajnoczi via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [PATCH] Fix: tracepoint.h: define SDT_USE_VARIADIC
 in pkg-config CFLAGS
Date: Tue, 30 Jun 2020 10:05:14 +0100
Message-ID: <20200630090514.GF81930@stefanha-x1.localdomain>
References: <20200624160934.205881-1-stefanha@redhat.com>
 <1673641132.14590.1593205320791.JavaMail.zimbra@efficios.com>
 <20200629162600.GA54368@stefanha-x1.localdomain>
 <1076462414.15458.1593448617213.JavaMail.zimbra@efficios.com>
Reply-To: Stefan Hajnoczi <stefanha@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5346269065248382552=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by lists.lttng.org (Postfix) with ESMTPS id 49wz3961BZz17FR
 for <lttng-dev@lists.lttng.org>; Tue, 30 Jun 2020 05:05:25 -0400 (EDT)
In-Reply-To: <1076462414.15458.1593448617213.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============5346269065248382552==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eDB11BtaWSyaBkpc"
Content-Disposition: inline

--eDB11BtaWSyaBkpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2020 at 12:36:57PM -0400, Michael Jeanson wrote:
> ----- On 29 Jun, 2020, at 12:26, Stefan Hajnoczi stefanha@redhat.com wrot=
e:
>=20
> > On Fri, Jun 26, 2020 at 05:02:00PM -0400, Michael Jeanson wrote:
> >> I proposed a patch here[1] that addresses this problem in a generic wa=
y by
> >> duplicating the macro and namespacing it under LTTNG_. Honestly this i=
s more
> >> of an sdt bug, the STAP_PROBEV should be in it's own include guard out=
side
> >> of _SYS_SDT_H or in it's own header file but we have to work with what=
's there.
> >>=20
> >> Can you have a look at the patch and confirm that it fixes your proble=
m?
> >=20
> > Great, glad there is already a fix under review.
> >=20
> > When I try out the patch the application does not compile. The error
> > messages are the same as without the patch because _LTTNG_SDT_PROBE() i=
s
> > not defined. Was that supposed to be _SDT_PROBE() instead?
> >=20
> > The application compiles successfully after replacing _LTTNG_SDT_PROBE(=
)
> > with _SDT_PROBE().
> >=20
> > Stefan
>=20
> Yes indeed, I reworked the patch after testing it and didn't catch this, =
I've
> just pushed an updated patch. Thanks for testing it and catching this.

Nice! Thanks for the fix.

Stefan

--eDB11BtaWSyaBkpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl77AEkACgkQnKSrs4Gr
c8h+3wf/fYSxd59E8rXAFfUn+xu4ZZHLgQk+fTBRO5avjH09rumgOZgyIiBPr5Ou
OV+ShA7uR7FcAAkV0holuMwLzh9ypxrb9/9pSWE7QPKtf/aCS7fQklXf1eFQF2BE
UIeE98wTSVDp8sCZqH/UvhA94756lAWXuaQxMWCLcqXpi/JGZBJY5+4OOy9E4evF
8XBYqaBXVfVQfQnM8rBgFuVEEiTiiCOwT2UTsTkD99PmJx9AhzvLU0J98jyDUVl/
MX6kNkDYksvvZiSWiNeBfxqqFexGlNdgr1nHm28+mBs2NiqzWmPfU4oV7T7UU56H
Vcd/+qzzNvpcKXMdXbxodIKsOKE7vw==
=rGB6
-----END PGP SIGNATURE-----

--eDB11BtaWSyaBkpc--


--===============5346269065248382552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5346269065248382552==--
