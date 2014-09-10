From: David Goulet <dgoulet@efficios.com>
Subject: Re: Odd file and path in lttng-tools tarball
Date: Wed, 10 Sep 2014 16:24:18 -0400
Message-ID: <20140910202418.GQ8256__35961.1692875207$1410380725$gmane$org@thessa>
References: <48CF5AC71E61DB46B70D0F388054EFFD4EC61B86@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1049424096=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XRoRG-0008RM-Nx
 for lttng-dev@lists.lttng.org; Wed, 10 Sep 2014 16:24:32 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD4EC61B86@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============1049424096==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pd495SECmvzXpBRb"
Content-Disposition: inline


--pd495SECmvzXpBRb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10 Sep (20:14:56), Thibault, Daniel wrote:
>    In the almost-current tarball for lttng-tools (2.5.0-rc2-93, 6e7241f) =
(current version is 2.5.0-rc2-101, 883d80f), there is an odd file present, =
presumably a leftover from testing:
>=20
> tests/regression/tools/save-load/ /tmp/tmp.eAJ1f0oCZE/test-42/save-42.ltt=
ng

Hrm ... I don't see that in any 2.5.0-rcX tarball...

Maybe it was created on your side? Is the tarball matching the gpg
signature also once downloaded?

Cheers!
David

>=20
>    (Note the folder named ' ')
>=20
>    Surely that does not belong?  It has been there since the 24 Mar 2014 =
e02b109 commit (2.4.0-rc2-184).
>=20
> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Ce=
ntre
> 2459 route de la Bravoure
> Qu=E9bec QC=A0 G3J 1X5
> CANADA
> Vox=A0: (418) 844-4000 x4245
> Fax=A0: (418) 844-4538
> NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada=A0| Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--pd495SECmvzXpBRb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJUELNyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02nHoH/jhUh8vPPLtatxktfws6ft+B
YqxoswQnQBMDIX+a6BphNWagJ5GnvHgyZ1gyw7nlQzviaPLd0RYAZ3sQdh+EaCmh
E/rawpmdwjxCNvZXimnl7nB9lOxBViM57/HQtpV7O3sVwkPv4Ic5NaRfWU+p4XmO
vTKa7DNEZlzxNfvi3U190uc8l4Id9rfR3cufLc7Lar2XBWlzYeFLM+8gdXP11t+4
MlYnGbnORdKmEGmSzQnvsQhSXxXJFd3EkVM8ivU4YL9FFb19q1OIIW83lzoanPkR
FiPhTjacku9YAywMNfZ+3JUnslIROr7oSlwUGe/XlhfzTOccDpSoxSNT43NkzyM=
=4esk
-----END PGP SIGNATURE-----

--pd495SECmvzXpBRb--


--===============1049424096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1049424096==--
