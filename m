From: David Goulet <dgoulet@efficios.com>
Subject: Re: Build and test LTTng on Travis CI
Date: Tue, 26 Nov 2013 10:52:54 -0500
Message-ID: <20131126155254.GA7267__35182.038244284$1385481244$gmane$org@thessa>
References: <CAJ7wx-ER0ZaaGnCbyYzh95oS=8NG_QNy_wdX9PhUjEcRxQJ+dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0478964057=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VlKwh-0003qJ-Ek
	for lttng-dev@lists.lttng.org; Tue, 26 Nov 2013 10:53:09 -0500
In-Reply-To: <CAJ7wx-ER0ZaaGnCbyYzh95oS=8NG_QNy_wdX9PhUjEcRxQJ+dw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Zifei Tong <soariez@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============0478964057==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Zifei,

On 25 Nov (23:21:30), Zifei Tong wrote:
> Hi,
>=20
> I just made a travis script [1] to build and test LTTng on Travis CI.
> I think this might be useful in case you work on your own lttng fork
> and want to have a CI system to check your commits.
>=20
> The lttng test suite runs good with gcc on Travis CI [2], with minor
> changes [4] with respect to bug #666 [5] and the 50 minutes build time
> limit of Travis CI.
>=20
> However for clang build [3], the unit tests won't pass. And I can
> confirm this failure on my own machine. I've created #697 [6] on bug
> tracker with full backtraces.

I've pushed a travis file upstream in lttng-tools based on your version
[1] and I'm currently using it quite a bit with my development branch so
big thanks for that!

I've fixed most of the clang compiler issues, just need to investiguate
#697 [6] for the travis' test to succeed.

Bug 666 [5] is also fixed now so you don't need a custom patch for
travis-ci.org. A fast and a long UST snapshot tests were added where the
"make check" runs the fast one (only 10 snapshots in the loop version
the 1000 for the long).

Again, thank you! Cheers!
David

>=20
> Thanks !
>=20
> [1] https://raw.github.com/5kg/lttng-tools/travis-ci/.travis.yml
> [2] https://travis-ci.org/5kg/lttng-tools/jobs/14490911
> [3] https://travis-ci.org/5kg/lttng-tools/jobs/14490912
> [4] https://github.com/5kg/lttng-tools/commit/afad46a2e7497e7dd5101f170df=
278f8ded3a1f7
> [5] https://bugs.lttng.org/issues/666
> [6] https://bugs.lttng.org/issues/697
> --
> Best Regards,
> =E4=BB=9D=E5=AD=90=E9=A3=9E (Zifei Tong)
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJSlMPWXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02fWcH/jPHZBpskbZ872O4XCGo/jeU
h+QfqAPrC9syjX1ov8XxgqkSvvCaxoyOyQU2dImulmP2o6g2MIRiF/Zvh7kaHlQJ
CrwbA/OO9xHjLV1sKEy2Z0bbXNB6SAik/+zfnFMJOQWnZREeurR8mQz26iPbKeLi
ERrvmHAziudxaKkyw7M8ov+kpU0SNqcpD2u80pGlleAIUuA3/sxqUXjM1quyavP4
67zGMWdMR2IMANRlRnjpUwF61dnb9PDxaulqLpPNHMD0k4kweqAifzU7CNbGoTzk
muAcDdHAI3T2sJdLPIfrGXfVaUjhK6v4xPXqVlZrGkmTMZR/OeSJ8wlTtaWrtiQ=
=5pnu
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--


--===============0478964057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0478964057==--
