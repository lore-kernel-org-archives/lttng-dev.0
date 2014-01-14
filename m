From: David Goulet <dgoulet@efficios.com>
Subject: Re: Extract lttng trace from kernel coredump
Date: Tue, 14 Jan 2014 15:44:00 -0500
Message-ID: <20140114204400.GD8177__9481.73114234141$1389732309$gmane$org@thessa>
References: <52D46B33.4010401@acm.org> <20140114184243.GC8177@thessa>
	<52D5A08F.4020204@acm.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1996103452=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1W3AqG-00008G-Pl
	for lttng-dev@lists.lttng.org; Tue, 14 Jan 2014 15:44:14 -0500
In-Reply-To: <52D5A08F.4020204@acm.org>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Corey Minyard <minyard@acm.org>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1996103452==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14 Jan (14:39:43), Corey Minyard wrote:
> On 01/14/2014 12:42 PM, David Goulet wrote:
> > On 13 Jan (16:39:47), Corey Minyard wrote:
> >> I'm working on a feature to allow an lttng trace to be extracted from a
> >> kernel coredump, and I'm wondering the best way to proceed.  I've look=
ed
> >> at extracting from the existing data structures, but that would require
> >> something to always have a trace file open and it looks more than a
> >> little complicated.  I was thinking instead of having a different trace
> >> channel for configuring this coredump and some globals to point to the
> >> various data structures.  Would that be the best way to pursue this?  =
Is
> >> there a better way, perhaps?
> > Oh yes we do actually already have a way to do that :)
> >
> > Please see:
> > https://git.lttng.org/?p=3Dlttng-tools.git;a=3Dtree;f=3Dextras/core-han=
dler;h=3D29ded89a71fd36e159d671ca1f405cea394f8683;hb=3DHEAD
> >
> > With the snapshot feature, it's quite easy to do that. Hope that helps
> > you with what you are trying to achieve.
>=20
> I did see that, but it seems to be for an application coredump.  I was
> looking for something that would work for a kernel coredump.  So that if
> the kernel crashes, you can use kdump to extract the kernel core and
> then extract the LTT buffers from that.  The idea is that if the kernel
> crashes, you can get some idea of what was happening before the crash.

Oh I misunderstood, my appology. For that I have no idea how to proceed.
Mathieu Desnoyers might be able to answer that since I'm pretty sure it
has been at some point in time discussed.

CCing him.

Cheers!
David

>=20
>=20
> Thanks,
>=20
> -corey
>=20
> > Cheers!
> > David
> >
> >> Thanks,
> >>
> >> -corey
> >>
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>=20

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJS1aGQXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02kEAH/0NY0tkkG9UF6YcT2dm9jBQ4
4sfuSUxzTkBYQcZcLyKSJ7b9EnNed3n0Vfm7t6AnL6jmbuAJoIlHsDDV4i+fwIdt
2DJXydNTUmm6TLVisq4QyRRhB5MfOANRf0SgRZhF9DYbRR/HGTeMYcrSbKPV2YEo
4wQv6px2v+LHYtdojTJqvDrHHHJX069Vq44jV/Yh/AQwkv1cObmeqS/GiKyQywRA
vFPErZwjaGkpN0LTquIgHRC3AxFLCZ4OdP5vcLdO18WE3zfsHt6VcAMZ4OLlVwwW
eQpoNxyG74hGlt1DPoN6Xu0mbtmfnFt656YTqlv1e6cmmmVb0LidusYNBMa/qBY=
=R43b
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--


--===============1996103452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1996103452==--
