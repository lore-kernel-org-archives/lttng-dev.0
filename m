From: David Goulet <dgoulet@efficios.com>
Subject: Re: Extract lttng trace from kernel coredump
Date: Tue, 14 Jan 2014 13:42:43 -0500
Message-ID: <20140114184243.GC8177__33560.9204289087$1389725352$gmane$org@thessa>
References: <52D46B33.4010401@acm.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1114404018=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1W38wt-0007Xx-7K
	for lttng-dev@lists.lttng.org; Tue, 14 Jan 2014 13:42:56 -0500
In-Reply-To: <52D46B33.4010401@acm.org>
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


--===============1114404018==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Content-Disposition: inline


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13 Jan (16:39:47), Corey Minyard wrote:
> I'm working on a feature to allow an lttng trace to be extracted from a
> kernel coredump, and I'm wondering the best way to proceed.  I've looked
> at extracting from the existing data structures, but that would require
> something to always have a trace file open and it looks more than a
> little complicated.  I was thinking instead of having a different trace
> channel for configuring this coredump and some globals to point to the
> various data structures.  Would that be the best way to pursue this?  Is
> there a better way, perhaps?

Oh yes we do actually already have a way to do that :)

Please see:
https://git.lttng.org/?p=3Dlttng-tools.git;a=3Dtree;f=3Dextras/core-handler=
;h=3D29ded89a71fd36e159d671ca1f405cea394f8683;hb=3DHEAD

With the snapshot feature, it's quite easy to do that. Hope that helps
you with what you are trying to achieve.

Cheers!
David

>=20
> Thanks,
>=20
> -corey
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJS1YUjXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02dsIH/Ag/Ct9D8qWGDMJ+aAPVzEQ4
7BiEQeOrr4hAlcWb+W4nevkF/yokdYFZgRapT8jN5W7pdRf4A07507ipHpI/GRPt
faXmoandGxWwGBwI/8Y+Mn2QBWKgbmBe82I8MXwd/vsWnxyREAEzPt9C0vE0kzlp
vY5OcV9QHzT6voTySgyfmXOJDNKRDzk2hsrcyjAqLMpKYDV/PpQkRJ4xFJvQfBhp
ITW37po3AYZsR9YsRZsbaKkPlEOvtSO6JAjp7JM2EEve0nC5Zbhl3sXE9/qz+W1y
eiSNe20T8O6VeYF4h9oXFTojnMOUegzGXpmJzFfDfEcFik2AIqSTCftNFKmI8Rs=
=rAqB
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--


--===============1114404018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1114404018==--
