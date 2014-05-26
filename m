From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Documentation: document
 tracefile max size discarded event limitation
Date: Mon, 26 May 2014 14:06:30 -0400
Message-ID: <20140526180630.GC7840__13475.9341519841$1401127674$gmane$org@thessa>
References: <48CF5AC71E61DB46B70D0F388054EFFD359ADD47@VAL-E-01.valcartier.drdc-rddc.gc.ca>
 <126483794.21654.1400765712145.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1212904584=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WozIF-0002DW-Pk
 for lttng-dev@lists.lttng.org; Mon, 26 May 2014 14:06:45 -0400
In-Reply-To: <126483794.21654.1400765712145.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, Daniel Thibault <Daniel.Thibault@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org


--===============1212904584==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kA1LkgxZ0NN7Mz3A"
Content-Disposition: inline


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22 May (13:35:12), Mathieu Desnoyers wrote:
> ----- Original Message -----
> > From: "Daniel Thibault" <Daniel.Thibault@drdc-rddc.gc.ca>
> > To: lttng-dev@lists.lttng.org
> > Cc: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "David Goulet=
" <dgoulet@efficios.com>
> > Sent: Thursday, May 22, 2014 9:01:20 AM
> > Subject: RE:  [lttng-dev] [PATCH lttng-tools] Documentation: document t=
racefile max size discarded event limitation
> >=20
> > ----------------------------------------------------------------------
> > Date: Wed, 21 May 2014 12:10:24 -0400
> > From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > To: David Goulet <dgoulet@efficios.com>
> >=20
> > diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
> > index 55fbae6..4a1de2c 100644
> > --- a/src/bin/lttng/commands/enable_channels.c
> > +++ b/src/bin/lttng/commands/enable_channels.c
> > @@ -136,6 +136,8 @@ static void usage(FILE *ofp)
> >  	fprintf(ofp, "  -C, --tracefile-size SIZE\n");
> >  	fprintf(ofp, "                           Maximum size of each tracefi=
le
> >  	within a stream (in bytes). 0 means unlimited.\n");
> >  	fprintf(ofp, "                               (default: %u)\n",
> >  	DEFAULT_CHANNEL_TRACEFILE_SIZE);
> > +	fprintf(ofp, "                           Note: traces generated with =
this
> > option may inaccurately report\n");
> > +	fprintf(ofp, "                           discarded events as per CTF
> > 1.8.\n");
> >  	fprintf(ofp, "  -W, --tracefile-count COUNT\n");
> >  	fprintf(ofp, "                           Used in conjunction with -C
> >  	option, this will limit the number\n");
> >  	fprintf(ofp, "                           of files created to the spec=
ified
> >  	count. 0 means unlimited.\n");
> > ----------------------------------------------------------------------
> >=20
> >    "as per CTF 1.8" leaves the impression that the misreporting is
> >    "mandated".  I suspect this is not what is meant here.  Maybe "as of"
> >    instead of "as per"?
>=20
> Yes. David can you fix ?

Fixes!

David

>=20
> Thanks,
>=20
> Mathieu
>=20
> >=20
> > Daniel U. Thibault
> > Protection des syst=E8mes et contremesures (PSC) | Systems Protection &
> > Countermeasures (SPC)
> > Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Criti=
cal Cyber
> > Security (MCCS)
> > R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence=
 R&D
> > Canada - Valcartier (DRDC Valcartier)
> > 2459 route de la Bravoure
> > Qu=E9bec QC  G3J 1X5
> > CANADA
> > Vox : (418) 844-4000 x4245
> > Fax : (418) 844-4538
> > NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> > Gouvernement du Canada | Government of Canada
> > <http://www.valcartier.drdc-rddc.gc.ca/>
> >=20
>=20
> --=20
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

--kA1LkgxZ0NN7Mz3A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTg4KmXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I021YwIAJJi8YODAfcKxwc7nZhp8NFe
tKCFtCN0Zw9Pu5TxJ+y/qORA8Hl5eli0+cCHSBSmAOJ/srYlHbdxWKV5892i775+
g5ufobTrZxCs5n1WtYBD7zZ9BKrym1Zy8e7uz53PyZtKeFmkOB9FtJHpgYhhzRPK
SWkWRYtVodz/RQcU68KSgDdTkCDfbFLDM/QrhRatq5/MiS3HB6yUPVTaxqGZiKfs
0+9b1gO8hAckrF9Q3Q4hDA/yM7Qw3w+GmzWjqNoFKqcO1QSwjphSGa7i9QVRMTcD
BsCTYIq0h5eCrywBCewuZRNh3C4WRANQKyOzca4OP10YuFJ0aIn5X+p9bnIsGn4=
=4RBu
-----END PGP SIGNATURE-----

--kA1LkgxZ0NN7Mz3A--


--===============1212904584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1212904584==--
