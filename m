From: David Goulet <dgoulet@efficios.com>
Subject: Re: No trace files are generated for UST
Date: Mon, 9 Dec 2013 15:48:05 -0500
Message-ID: <20131209204805.GA5152__8382.12666935778$1386622147$gmane$org@thessa>
References: <6CFA219DE9CAD940989B83CA579159F91B43ACBFBE@SGSINEXC014.vestas.net>
	<48CF5AC71E61DB46B70D0F388054EFFD267B2DCF@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<6CFA219DE9CAD940989B83CA579159F91B43ACC0B6@SGSINEXC014.vestas.net>
	<48CF5AC71E61DB46B70D0F388054EFFD267B2DF5@VAL-E-02.valcartier.drdc-rddc.gc.ca>
	<6CFA219DE9CAD940989B83CA579159F91B43ACC0C1@SGSINEXC014.vestas.net>
	<CA+jJMxt-D9CEFVhH93Q7iy=0W1KRsynBA9is-AP3L0+Dpq11Cg@mail.gmail.com>
	<6CFA219DE9CAD940989B83CA579159F91B43ACC0FD@SGSINEXC014.vestas.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1514022027=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Vq7kT-0005ga-Ut
	for lttng-dev@lists.lttng.org; Mon, 09 Dec 2013 15:48:20 -0500
In-Reply-To: <6CFA219DE9CAD940989B83CA579159F91B43ACC0FD@SGSINEXC014.vestas.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Manikandan Govindaswamy <magov@vestas.com>
Cc: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============1514022027==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07 Dec (06:16:14), Manikandan Govindaswamy wrote:
> Please find the log for the --verbose-consumer attached.

With the log file you provided, *no* application registered to the
session daemon meaning probably that lttng-ust is either not called or
not linked at all.

By adding this in front, you should have quite an amount of debug being
printed out on stderr. If not, you have a problem with maybe the
LD_PRELOAD path or lttng-ust linking else provide those logs :).

LTTNG_UST_DEBUG=3D1 ./sample

Cheers!
David

>=20
> Regards,
> GMK.
>=20
> -----Original Message-----
> From: jeremie.galarneau@gmail.com [mailto:jeremie.galarneau@gmail.com] On=
 Behalf Of J=E9r=E9mie Galarneau
> Sent: Friday, December 06, 2013 11:23 PM
> To: Manikandan Govindaswamy
> Cc: Thibault, Daniel; lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] No trace files are generated for UST
>=20
> Could you launch the session daemon in verbose mode and post the logs?
>=20
> lttng-sessiond -vvv --verbose-consumer
>=20
> On Fri, Dec 6, 2013 at 10:51 AM, Manikandan Govindaswamy
> <magov@vestas.com> wrote:
> > Yes, with that LD_PRELOAD sample able to run.
> >
> > root@/tmp/lttng-build-root/bin # ./lttng create app
> > Session app created.
> > Traces will be written in /root/lttng-traces/app-20131206-174935
> > root@/tmp/lttng-build-root/bin # dmesg
> > root@/tmp/lttng-build-root/bin # ./lttng enable-event -u -a
> > All UST events are enabled in channel channel0
> > root@/tmp/lttng-build-root/bin # ./lttng start
> > Tracing started for session app
> > root@/tmp/lttng-build-root/bin # cd ..
> > root@/tmp/lttng-build-root # cd ..
> > root@/tmp # LD_PRELOAD=3D/tmp/lttng-build-root/lib/liblttng-ust.so.0 ./=
sample
> > root@/tmp #
> > root@/tmp #
> > root@/tmp # cd lttng-build-root/
> > root@/tmp/lttng-build-root # cd bin/
> > root@/tmp/lttng-build-root/bin # ./lttng stop
> > Waiting for data availability
> > Tracing stopped for session app
> > root@/tmp/lttng-build-root/bin # dmesg
> > root@/tmp/lttng-build-root/bin # ./lttng destroy
> > Session app destroyed
> > root@/tmp/lttng-build-root/bin # cd /
> > root@/ # cd root/
> > root@~ # ls
> > lttng-traces
> > root@~ # cd lttng-traces/
> > root@~/lttng-traces # ls
> > root@~/lttng-traces #< no traces are generated>
> >
> > in ps -ef
> >
> > 28664 root       0:00 ./lttng-sessiond -vvv --consumerd64-path=3D/tmp/l=
ttng-build-root/lib/lttng/libexec/lttng-consumerd
> > 29027 root       0:00 lttng-consumerd --quiet -u --consumerd-cmd-sock /=
var/run/lttng/ustconsumerd64/command --consumerd-err-sock /var/run/lttng/us=
tconsumerd64/error
> >
> > Regards,
> > GMK.
> >
> >
> >
> > -----Original Message-----
> > From: Thibault, Daniel [mailto:Daniel.Thibault@drdc-rddc.gc.ca]
> > Sent: Friday, December 06, 2013 9:14 PM
> > To: Manikandan Govindaswamy; J=E9r=E9mie Galarneau
> > Cc: lttng-dev@lists.lttng.org
> > Subject: RE: [lttng-dev] No trace files are generated for UST
> >
> >> As I'm using the custom image on x86 machine, i've kept the lib in /tm=
p/lttng-build-root/lib folder and this sample able to see the library as we=
ll.
> >>
> >> And the same way I able to create the trace files for kernel but not f=
or ust. There were no dmesg as well.
> >>
> >> [...]
> >> root@/tmp # ldd sample
> >>         linux-vdso.so.1 (0x00007fff2a135000)
> >>         libdl.so.2 =3D> /lib64/libdl.so.2 (0x00007fe2cccb5000)
> >>         liblttng-ust.so.0 =3D> /tmp/lttng-build-root/lib/liblttng-ust.=
so.0 (0x00007fe2cca51000)
> >>         [...]
> >
> >    Try running sample using:
> >
> > LD_PRELOAD=3D/tmp/lttng-build-root/lib/liblttng-ust.so.0 ./sample
> >
> >    If the LD_PRELOAD succeeds, we will know at least that liblttng-ust =
is reachable by sample.
> >
> >    The modules have nothing to do with UST: kernel and user-space traci=
ng are essentially independent features.
> >
> > Daniel U. Thibault
> > Protection des syst=E8mes et contremesures (PSC) | Systems Protection &=
 Countermeasures (SPC)
> > Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Criti=
cal Cyber Security (MCCS)
> > R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence=
 R&D Canada - Valcartier (DRDC Valcartier)
> > 2459 route de la Bravoure
> > Qu=E9bec QC  G3J 1X5
> > CANADA
> > Vox : (418) 844-4000 x4245
> > Fax : (418) 844-4538
> > NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> > Gouvernement du Canada | Government of Canada <http://www.valcartier.dr=
dc-rddc.gc.ca/>
>=20
>=20
>=20
> --=20
> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com


> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJSpiyFXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02Gh8H/AzwZtZl/d0Vb6twtW9BZHMh
mbtH9QvJL6Zj0nETAbXmJRe768qACKSVKR9N6uL0G1C84vh3gY9pE5Hyl3SUlUeu
31Kr7kl6N7Qot4tH8Z5SSxIHZjMqt3lQtneTNIBTY5XJVyPKqWmjF7Qn2RwppVch
zn6i+/DZ+PjT21Bqoe9uRWu5joQ6XrvAYnEpd0a14uONxk4hnA+WH+2MjJhqkRLk
Jq0aGL/ioyGWcqjThroFyr8UG3REvdDjlHpodA7tROiqhBctF1HKC97VvkSA+pnx
AUZ1jNHgeTpCNOTWb3Wl6guLJTDjstEsdlh8QyK8JYvQ8OdMlekNb8gSQWPACc0=
=1GyT
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--


--===============1514022027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1514022027==--
