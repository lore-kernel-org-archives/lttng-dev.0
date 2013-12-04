From: David Goulet <dgoulet@efficios.com>
Subject: Re: Buffer multiplicity in user-space
Date: Wed, 4 Dec 2013 10:55:39 -0500
Message-ID: <20131204155539.GB7654__2406.96617770499$1386172625$gmane$org@thessa>
References: <48CF5AC71E61DB46B70D0F388054EFFD267B2978@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1078915119=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VoEnt-0005KN-W7
	for lttng-dev@lists.lttng.org; Wed, 04 Dec 2013 10:56:11 -0500
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD267B2978@VAL-E-02.valcartier.drdc-rddc.gc.ca>
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


--===============1078915119==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04 Dec (15:42:17), Thibault, Daniel wrote:
>    I'd appreciate a confirmation (or correction) of my understanding of b=
uffer multiplicity in user-space.  Assume we have just the root session man=
ager running, and we've created a single session and enabled all user-space=
 events in the default channel channel0.
>=20
>    In per-userID mode, if instrumented apps are running under several use=
r IDs, we will have one buffer (set of sub-buffers) per user ID, collecting=
 that userID's channel's events, and the consumer daemon simply round-robin=
s servicing the buffers to the matching sub-traces (lttng-traces/session-na=
me/ust/uid/1001/64-bit/channel0_0, lttng-traces/session-name/ust/uid/1002/6=
4-bit/channel0_0, etc.).
>=20
>    Similarly, in per-processID mode, the buffer organization is the same =
except that we have a buffer per process ID (regardless of each process's o=
wning userID), and the consumer daemon round-robins between a greater numbe=
r of buffers, dispatching the records to more sub-traces (lttng-traces/sess=
ion-name/ust/pid/app1-1001/channel0_0, lttng-traces/session-name/ust/pid/ap=
p2-1001/channel0_0, lttng-traces/session-name/ust/pid/app1-1002/channel0_0,=
 etc.).
>=20
>    In this latter case, don't we potentially run into a lot of overhead i=
f a multitude of short-lived processes occurs (i.e. going through the busin=
ess of creating a buffer every time)?  Is the buffer creation triggered by =
the process's registration with the session daemon, and does this slow the =
process start up (i.e. does the registration call return immediately or doe=
s it wait until the buffer is ready?)?  If the registration call returns im=
mediately, what happens if the process emits an event before the buffer cre=
ation is complete?

Starting with the first question (about overhead), yes with per PID it
adds way more overhead since each process needs its own set of buffers.
At registration, the session daemon ask the consumer to create buffers
according with some properties asked by the application. Once done, the
consumer sends back the reference to the session daemon and then sends
that ref. to the application. From that point on, the application can
start tracing and be assured that the first event will be collected.

The UST registration blocks the application's main() until that process
is completed meaning until the "registration done" message is received
=66rom the session daemon. Thus, the application *can't* emit an event
during that time. Once it does, the sessiond/consumerd are already all
set to handle tracing for that application.

This is a "slow" process in the sense that with per-PID, if you have let
say very short live applications and a huge number of them (in the
thousands), that puts a lot of contention on the session daemon to
create and cleanup apps concurrently thus possibly slowing down quite a
bit. That's the tradeoff to accept some tracing guarantees.

Of course there is always optimization to improve that process but we
are not there yet.

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

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJSn1B7XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02Mn4IAKU+sjEprQlTSfmhW2wJPutv
12w4//SGNMtSBuVvAaeUDBxXF5yuYC1pH0uJkKKzz2+w2oI0QYVIoA/ixSkXMSQb
JIqjfI2IhBiZZUS2gukygy8TfLTpuD/LsjYqgIuxO5iPQ5q+dit2JveT5cCGSEtn
VHXvgEEVA+kLT7dlLaFTq/L6cwHm4AQQ9mRh5kFzkNk/KyS3MfB83lpQzALxsKo+
4vJCxNi6NeOdnqjbxx9L3baPMgcuSQZ0wBQlg6LJkZSaSPCSlMZbX/KQFoTeawMz
RnWT5fq91ekhWk+cFxCw0l9/2zUTrgWrCZV3miVeRGTCBtrEcw/cuN8XN6nr1nA=
=5jjO
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--


--===============1078915119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1078915119==--
