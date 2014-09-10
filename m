From: David Goulet <dgoulet@efficios.com>
Subject: Re: Odd file and path in lttng-tools tarball
Date: Wed, 10 Sep 2014 16:40:45 -0400
Message-ID: <20140910204045.GS8256__41792.3146197156$1410381709$gmane$org@thessa>
References: <48CF5AC71E61DB46B70D0F388054EFFD4EC61B86@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <20140910202418.GQ8256@thessa>
 <48CF5AC71E61DB46B70D0F388054EFFD4EC62BA3@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1748008497=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XRohA-00008C-0p
 for lttng-dev@lists.lttng.org; Wed, 10 Sep 2014 16:40:57 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD4EC62BA3@VAL-E-02.valcartier.drdc-rddc.gc.ca>
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


--===============1748008497==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FQ9/qgh0YgB02Feu"
Content-Disposition: inline


--FQ9/qgh0YgB02Feu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10 Sep (20:28:48), Thibault, Daniel wrote:
> -----Message d'origine-----
> De=A0: David Goulet [mailto:dgoulet@efficios.com]=20
> Envoy=E9=A0: 10 septembre 2014 16:24
>=20
> > > tests/regression/tools/save-load/=20
> > > /tmp/tmp.eAJ1f0oCZE/test-42/save-42.lttng
> >
> > Hrm ... I don't see that in any 2.5.0-rcX tarball...
> >
> > Maybe it was created on your side? Is the tarball matching the gpg sign=
ature also once downloaded?
> >
> > David
>=20
>    Nope, not a local artefact.  You can see it in the gitweb interface ev=
erywhere.  Starting at for instance http://git.lttng.org/?p=3Dlttng-tools.g=
it;a=3Dtree;f=3Dtests/regression/tools/save-load;h=3Db792f337a7d13cf17b519b=
02de88db4d73b215f6;hb=3D883d80f9e038060bccf0512679eb366c7b245d14 you can sp=
ot the ' ' folder deep inside of which lies the save-42.lttng
>=20

Oh yeah you are right! I got it now! It's not in the released tarball
but in the tree.

I just fixed that! Big thanks for noticing it!

commit b1d7c00a0ce93d656ee2292f258828abe4c233c3

Cheers!
David

>    (Just in case the URL gets mangled by e-mail filters, here it is in bi=
ts:)
> http://
> git.lttng.org/
> ?p=3Dlttng-tools.git;
> a=3Dtree;
> f=3Dtests/regression/tools/save-load;
> h=3Db792f337a7d13cf17b519b02de88db4d73b215f6;
> hb=3D883d80f9e038060bccf0512679eb366c7b245d14
>=20
> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Ce=
ntre
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>

--FQ9/qgh0YgB02Feu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJUELdNXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I028c4H/iWUTffGXRI75kZVMvJ7otzL
9IyyKu/AgNbwm693bzHpdKhjHmKfC4ch6XgrSjgAc2PMhnlLIziaPJrWrb6W7hnO
9IApEhMWQWVK1q4RXDevWAM7DraVXgNzbMqn7UqChGUgu2JaWkFqC/DtSC0pcy2v
wadfpso6jMYW3WAdN3K0KFaNk4j90ScbLxe64IRdujKhfeBp2f5XmXvDLK8NAGx0
9N7jCqIWCKO8PMI5CzSzpV5B8t0MPDfKcTXcblkryQBBTL7J3J5Y+Mm4/2KWhCt4
hjZ2NfGgDi6wpR2SwQi4ihU/Tmquq5XFCZWnZ84GQil5Ogp6Q1IvrzDgeOrfuxQ=
=r+fD
-----END PGP SIGNATURE-----

--FQ9/qgh0YgB02Feu--


--===============1748008497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1748008497==--
