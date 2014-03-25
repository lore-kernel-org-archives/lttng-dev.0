From: David Goulet <dgoulet@efficios.com>
Subject: Re: Regarding Bug #633 - utils_parse_size_suffix
 suffers from several problems
Date: Tue, 25 Mar 2014 10:22:50 -0400
Message-ID: <20140325142250.GA7702__38091.9904601344$1395757438$gmane$org@thessa>
References: <CAEEAEzW+g222Z1Lhem2W=UpVrNnc7m+=4OULcRXH3J1gqmYqrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0245180503=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WSSFm-0005xi-Vd
	for lttng-dev@lists.lttng.org; Tue, 25 Mar 2014 10:23:04 -0400
In-Reply-To: <CAEEAEzW+g222Z1Lhem2W=UpVrNnc7m+=4OULcRXH3J1gqmYqrw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Sandeep K Chaudhary <babbusandy2006@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============0245180503==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21 Mar (00:22:57), Sandeep K Chaudhary wrote:
> Hi guys,
>=20
> I checked the fix suggested in the bug description and it is correct.
>=20
> Changing
>=20
> ret =3D regcomp(&regex, "^\\(0x\\)\\{0,1\\}[0-9][0-9]*\\([kKMG]\\{0,1\\}\=
\)$", 0);
>=20
> to
>=20
> ret =3D regcomp(&regex,
> "^(((0x|0X)[0-9A-Fa-f]+)|(0[0-7]*)|([1-9][0-9]*))[kKMG]?$", REG_EXTENDED);
>=20
> will take care of the following three problems that exist in the first re=
gex
>=20
>=20
>    - It accepts a leading 0 (without a following x or X) to represent an
>    octal value, but simultaneously accepts the digits 8 and 9 in said oct=
al
>    value (this yields -1).
>    - It does not support the leading 0X hexadecimal indicator but does
>    support a leading 0x (see following).
>    - It accepts a leading 0x to represent an hexadecimal value but rejects
>    the a..f and A..F digits in said value.
>=20
>=20
> Please let me know your views, and then I can submit a patch for this.

Unfortunately I don't speak regex well enough to tell you if this is
absolutely correct but what you should do with your patch is add unit
test(s) that fix the three problems you list here.

Most probably in:

	tests/unit/test_utils_parse_size_suffix.c

Cheers!
David

>=20
> Thanks and regards,
> Sandeep.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTMZE6XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02U6IH/An9FIc6DYeC7uf+IKcbib2Q
soeKqErefI40EjjwVAmRsXWwAjq7EmDN1efp6gswbA+O9ReM3HSKpTv0ncr78z9v
clcZMfs6f1yL/6bruy1u3Uoj2W2DzSHd94Qe4LkA1/BAAkRS5lsXuA2YV3daYP2Z
bI9XIhdKyMwSQGtfycPdWTTlgzkhIq1TToBJECzPBvba3lPy0HpShZzH+F7IPUzF
1VDZj6DNNdnyMZK+o0yakb2OWPNxSctBebBhrg9ECJb3ZLdItR/7hjftgmRQK3n4
CWF9y/k1FKNmgBhuhN/l44ceDnYik882oDF9ayx6EkqXEBaxSMH060fgjAvOwoA=
=1O7k
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--


--===============0245180503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0245180503==--
