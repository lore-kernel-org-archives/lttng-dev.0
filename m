From: David Goulet <dgoulet@efficios.com>
Subject: Re: The JUL domain
Date: Fri, 17 Jan 2014 11:10:49 -0500
Message-ID: <20140117161049.GB7926__46124.8844549575$1389975129$gmane$org@thessa>
References: <48CF5AC71E61DB46B70D0F388054EFFD267D8B4D@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1901886370=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1W4C0m-0006nC-2Y
	for lttng-dev@lists.lttng.org; Fri, 17 Jan 2014 11:11:17 -0500
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD267D8B4D@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============1901886370==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17 Jan (15:58:15), Thibault, Daniel wrote:
>    A quick question regarding the LTTng 2.4 jul domain:
>=20
>    Does its use mean another consumer daemon or two may be launched?  Sup=
pose I have a 64-bit system with some 32-bit apps, including both 32- and 6=
4-bit Java.

Yes.

> Suppose I run a 'tracing' group trace on the kernel, user-space and jul. =
Will I get five consumer daemons?  One for the kernel, one for 32-bit user-=
space events, one for 64-bit user-space events, one for 32-bit java.util.lo=
gging events and a last one for 64-bit java.util.logging events?

No, consumers are based on the bitness thus if 32-bit app, 64-bit app
and the kernel, you'll have two UST consumers and one kernel consumer.

The JUL domain means that you can enable Logger name in a Java
application through a Java Agent that uses a JNI library to use
lttng-ust which will register to the session daemon and have a full UST
setup process.

The Logger's data is mapped to a UST generic tracepoint (can be
expanded) so what the consumer do is the same as a UST domain.

Hope that clarifies.

Cheers!
David

>=20
> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D Canada - Valcartier (DRDC Valcartier)
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

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJS2VYJXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02uX4H/049vYsmZxrnZpNM00Yf4Lcv
suqTFiEllS7GmC2+k97ZIXLQYpPnfXyb7RLeU9cOK41SSI2tzmdcZ05vfBg2Mda7
yUfRCjafbICMDsj/mqHkDnZxASligNRO+BuIyuwMscyw35OPHbuslYKQ49QWM9wA
hK+iVKa29D3JaClu53eS15QDnNIHtyvqDp8R3745FKyR3wZi6QOBr8llqCxmnzTI
GtLLbUC7dPa/L20vqW/wOMRYZJ5fRsn9HNFX18jL8eTperjD2kUCSIRNDNmpK3oT
tIc5mB8Agf72yMwEeyRNO43btH6aHEHVK/F21MX7OBFRC5Nx8UiIXeGIdc38MqI=
=Wd3m
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--


--===============1901886370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1901886370==--
