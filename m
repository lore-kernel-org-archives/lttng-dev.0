From: David Goulet <dgoulet@efficios.com>
Subject: Re: Questions about JUL (was: Re:  lttng-dev Digest,
 Vol 67, Issue 48)
Date: Tue, 4 Feb 2014 14:13:17 -0500
Message-ID: <20140204191317.GF13440__41554.4959520504$1391541267$gmane$org@thessa>
References: <48CF5AC71E61DB46B70D0F388054EFFD267DE218@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1791864586=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WAlR0-0000tE-79
	for lttng-dev@lists.lttng.org; Tue, 04 Feb 2014 14:13:32 -0500
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD267DE218@VAL-E-02.valcartier.drdc-rddc.gc.ca>
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


--===============1791864586==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
Content-Disposition: inline


--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04 Feb (18:59:02), Thibault, Daniel wrote:
> ----------------------------------------------------------------------
> Date: Tue, 4 Feb 2014 12:17:36 -0500
> From: David Goulet <dgoulet@efficios.com>
> To: Jim Dumont <jim.dumont@ericsson.com>
> Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
>=20
> >> 3) add-context: does --jul have the same possible context types as --u=
serspace (i.e. ip, pthread_id, procname, vpid, vtid)?
> >
> > Nope.
>=20
>    What are the possible context types then?  Or is it just that you can'=
t apply a filter to a jul event?

None, you can't add a context to the JUL domain.

>=20
> >> 4) enable-channel:
> >> 4.1) Are the --jul --subbuf-size, --num-subbuf and --read-timer defaul=
ts the same as with --userspace?
> >
> > Nope. JUL uses it's internal channel so basically enable channel does N=
OT support the jul domain thus not having -j in the help/man.
>=20
>    So you turn jul events on and off using enable/disable-event --all ins=
tead?  This is getting a tad confusing: jul events force you to use only en=
able/disable-event but kernel syscalls force you to use only enable/disable=
-channel...

No. For JUL you enable "Logger" names from the JUL API. For instance:

$ lttng enable-event -j MyLogger
or to enable all loggers
$ lttng enable-event -j -a

Using the lttng-ctl API, -a =3D=3D "*".

For the kernel syscalls, yeah well this is a tracer limitation that we
can't enable/disable specific syscalls but fortunately this year we'll
bring this feature! :)

>=20
> >> 4.4) If yes, won't they all degenerate to the virtual machine's user a=
nd process IDs?
> >
> > Not sure I understand this one?
>=20
>    A Java application is interpreted and runs in a Java virtual machine (=
JVM).  The userID and processID of any jul events are thus likely to be tho=
se of the JVM process.  I would expect Java apps launched by separate users=
 to launch separate JVM instances, but I would also expect two separate Jav=
a apps launched by the same user to share a single JVM (the user's) and, th=
erefore, their process IDs.  This could get fun with multi-threaded Java ap=
ps.

Hrm, I've not observed that. If a specific Linux user with let say UID =3D
1000, the Java application registering to the session deamon is set with
UID =3D 1000. Don't forget that the JUL support uses JNI to link with
lttng-ust and that library registers as a the user.

>=20
> > Now after answering all this, I feel like either creating a lttng-jul m=
an page or adding a special section in "lttng.1" for the JUL domain explain=
ing all this. Thoughts?
>=20
>    We definitely need an additional section in "lttng.1".

Agreed. I'll be updating lttng.1 before the stable release.

THanks!
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
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJS8TvNXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I025O4H/2IYFPe6Tn7SwWYj48k82SgT
xjUV3uwnVHE7mz+t77A7vwvfOlEAJ8ykcN4xQ9wJRsGCAUtBPZsUnKtm1cOwCX3Z
2OwMui93a3QXxWpLZbqCX+HPwNzIUKUolwJtbPimQVOHW65qJdPm7EWPoXTM7pkf
rB47W+T0wILJWSl/BurIOWywQH9rMm0LsjwQV5sQGZRxTQkQ7gxhiMf4+u04NL1C
FtxOQ9SMn79lP0UHIBvFXCXGJn+uuCfUrWWXF+HaIUTvvSWNJzew8mUtNUdt1UcZ
VXR7VD1mVIoUzzoFxumUJzKsz+V0g2i8aNiN7wND+b1uExclAp8NHavwID5L4l4=
=xpP9
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--


--===============1791864586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1791864586==--
