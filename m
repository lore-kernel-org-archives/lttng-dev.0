From: Khem Raj <raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Bogus openembedded gcc patch
Date: Tue, 26 Jan 2016 11:28:34 -0500
Message-ID: <51287CFC-6F3C-43B1-9190-84F3B20C192E@gmail.com>
References: <1037243108.4336.1453770172960.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: multipart/mixed; boundary="===============0012240325=="
Return-path: <openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
In-Reply-To: <1037243108.4336.1453770172960.JavaMail.zimbra-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/openembedded-core/>
List-Post: <mailto:openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
List-Help: <mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=subscribe>
Sender: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
Errors-To: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
To: Mathieu Desnoyers <mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>
Cc: lttng-dev <lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org>, openembedded-core <openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
List-Id: lttng-dev@lists.lttng.org


--===============0012240325==
Content-Type: multipart/signed; boundary="Apple-Mail=_2677B631-FCB6-4CAB-8353-1DA5EABE02F1"; protocol="application/pgp-signature"; micalg=pgp-sha1


--Apple-Mail=_2677B631-FCB6-4CAB-8353-1DA5EABE02F1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Jan 25, 2016, at 8:02 PM, Mathieu Desnoyers =
<mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org> wrote:
>=20
> Hi,
>=20
> We are noticing the presence of the following patch in various
> openembedded gcc versions:
>=20
> 0024-PR-target-32219.patch
>=20
> "=46rom e0d15f4f8bf28c351b9215ca37f1caa24df0e1fd Mon Sep 17 00:00:00 =
2001
> From: Khem Raj <raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Date: Fri, 29 Mar 2013 09:18:54 +0400
> Subject: [PATCH 24/35] PR target/32219
>=20
> * varasm.c (default_binds_local_p_1): Weak data is not local.
>=20
> Signed-off-by: Bernhard Reutner-Fischer <rep.dot.nop-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Khem Raj <raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> Upstream-Status: Backport"
>=20
> However, contrarily to its "Backport" status, that patch is
> not upstream in gcc, and we're starting to wonder if this
> would be the patch that breaks handling of start/stop automatic
> hidden symbols we use in lttng-ust.
>=20
> We are only experiencing problems on the various openembedded
> compilers, but on no other distro (with same compiler versions),
> which leads us to suspect a buggy distro-specific gcc patch.
>=20
> We've been testing with openembedded gcc-4.9.2-r0.
>=20
> The original gold linker issue that this patch was trying to
> address seems to have been fixed in the gold linke since
> then.
>=20
> Refs:
> http://lists.lttng.org/pipermail/lttng-dev/2014-May/023112.html
> https://gcc.gnu.org/ml/gcc-help/2014-05/msg00042.html
> =
http://cgit.openembedded.org/openembedded-core/commit/?id=3D3cb2b003db7371=
b3a47d02c08352a262e1e419b4
> https://sourceware.org/bugzilla/show_bug.cgi?id=3D15435
>=20
> Thoughts ?

OE has defaulted to gcc5 since last release, and gold issue is fixed in =
binutils 2.25
which is what we use in 2.0 as well so it might be OK to unbolt this =
fix. Although I am not sure
about the original problem reported in PR32219 is fixed for gcc 4.9 if =
we remove this fix.
Have you narrowed down your issue to this patch ? if not, then it would =
be good to do so

>=20
> Thanks,
>=20
> Mathieu
>=20
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com


--Apple-Mail=_2677B631-FCB6-4CAB-8353-1DA5EABE02F1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAlannrYACgkQuwUzVZGdMxRNbwCeNGhVKoTwhyOySRAGpPID+xLQ
HusAoIgKdi9T/+D4SusXmbR/ALHB9t9R
=/Ibh
-----END PGP SIGNATURE-----

--Apple-Mail=_2677B631-FCB6-4CAB-8353-1DA5EABE02F1--

--===============0012240325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
_______________________________________________
Openembedded-core mailing list
Openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
http://lists.openembedded.org/mailman/listinfo/openembedded-core

--===============0012240325==--
