From: Stefan Hajnoczi via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [PATCH] Fix: tracepoint.h: define SDT_USE_VARIADIC
 in pkg-config CFLAGS
Date: Mon, 29 Jun 2020 17:26:00 +0100
Message-ID: <20200629162600.GA54368@stefanha-x1.localdomain>
References: <20200624160934.205881-1-stefanha@redhat.com>
 <1673641132.14590.1593205320791.JavaMail.zimbra@efficios.com>
Reply-To: Stefan Hajnoczi <stefanha@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1616598457040829311=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by lists.lttng.org (Postfix) with ESMTPS id 49wXvf1Dxtz177q
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jun 2020 12:27:26 -0400 (EDT)
In-Reply-To: <1673641132.14590.1593205320791.JavaMail.zimbra@efficios.com>
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

--===============1616598457040829311==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2020 at 05:02:00PM -0400, Michael Jeanson wrote:
> I proposed a patch here[1] that addresses this problem in a generic way b=
y
> duplicating the macro and namespacing it under LTTNG_. Honestly this is m=
ore
> of an sdt bug, the STAP_PROBEV should be in it's own include guard outsid=
e
> of _SYS_SDT_H or in it's own header file but we have to work with what's =
there.
>=20
> Can you have a look at the patch and confirm that it fixes your problem?

Great, glad there is already a fix under review.

When I try out the patch the application does not compile. The error
messages are the same as without the patch because _LTTNG_SDT_PROBE() is
not defined. Was that supposed to be _SDT_PROBE() instead?

The application compiles successfully after replacing _LTTNG_SDT_PROBE()
with _SDT_PROBE().

Stefan

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl76FhgACgkQnKSrs4Gr
c8gFkQgAg8trelUbnEi0DjxQuLTrnTjYUwxU9Jp5jM6mYe1qmRc4m3hmZJ//cLk8
PEdvQq+NOlOK0SLRVRr3NAsiDeBXSSBluwWS+OLqKEEU9JS5EZONhdItZMvNSEpM
3htfPRd4rARs0BJOVU3uclLZxwDVSf3JhuGb4eTMBIiYQjjeHRykMCWLqXINMzxg
YXtlI5orgyfhXv5ryKYcb+I2T7mN2a5hVTjrho05edvoecCTK/at/Heag0AVmNwe
DcOytPFQ2AQ0LHc7Kly2kLZcC8c0ELp2tmc2H2JRgxVn/33ZexSGRDc550dAV3ua
O+B6+gyPhoIIzCVegSydrO/YGnS34w==
=zTzy
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--


--===============1616598457040829311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1616598457040829311==--
