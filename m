From: David Goulet <dgoulet@efficios.com>
Subject: Re: network namespace and LTTng
Date: Thu, 23 Oct 2014 09:26:23 -0400
Message-ID: <20141023132623.GD10437__3748.81963148273$1414070825$gmane$org@thessa>
References: <0C794A2958AD524DAB4175408F839BD322F48A@ESESSMB109.ericsson.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0705081572=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XhIPM-0001ly-WF
 for lttng-dev@lists.lttng.org; Thu, 23 Oct 2014 09:26:30 -0400
In-Reply-To: <0C794A2958AD524DAB4175408F839BD322F48A@ESESSMB109.ericsson.se>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anette =?iso-8859-1?Q?Sch=F6tt?= <anette.schott@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============0705081572==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6Nae48J/T25AfBN4"
Content-Disposition: inline


--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23 Oct (07:10:06), Anette Sch=F6tt wrote:
> Hi,
>=20
> I have a question regarding network namespace and LTTng 'live streaming'.
>=20
> Can you see any problems to have a user application using UST tracing in =
one network namespace and the lttng-sessiond daemon executing in another na=
mespace?

Hello!

UST tracing talks with the session daemon with a Unix socket which is
*not* part of a network namespace. Thus, two completely different
network namespace, it should work fine.

Thanks
David

>=20
> Regards
> Anette

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--6Nae48J/T25AfBN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBCABmBQJUSQH/XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02IvMH/ROG/YNY840RfmL/9pDyRQ+C
BOpjdpXBeIir5hI9AMmA0ZAbOl3KzYgtC8KVCcuR7PeC3wOuzhMaHPGqFV549VAM
R+Q812GrXJJzeZRgvOul64yH+vYu4MAacYAUGgIZzpSHU8rFndUMiMygplbGn+Lq
3lK/Kdq5zzgRnBi66wpw1UcU7OazWXAx7rOkW67ZY37MReKo3flQaqvwgVOcNGRs
pEBUlhT5OIS14/Q1dV4/QKNnWns2LrT8Gr68fc1N+h6XbhLMqjHZCVxlTECWcAJ1
1TKTIp1+x5TZukk1Y1VOGy6/OtPWMjvLEGyWKd3OYw9eZ8L7EOOYApUIHSJJq30=
=f17A
-----END PGP SIGNATURE-----

--6Nae48J/T25AfBN4--


--===============0705081572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0705081572==--
