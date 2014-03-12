From: David Goulet <dgoulet@efficios.com>
Subject: Re: Working on some bugs
Date: Wed, 12 Mar 2014 10:26:46 -0400
Message-ID: <20140312142646.GA10776__31165.6520505951$1394634483$gmane$org@thessa>
References: <CAEEAEzWcPk788kF=BptjeGsG=hrWyeK1tcUAM4Fq9GAwZYPXhQ@mail.gmail.com>
	<20140311162201.GE7727@thessa>
	<CAEEAEzX3KOz0JDGGee20f2CBtFuPhrRUX2m2hzhut5WObGVBuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0530232146=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WNk7T-0008Mh-Mr
	for lttng-dev@lists.lttng.org; Wed, 12 Mar 2014 10:27:01 -0400
In-Reply-To: <CAEEAEzX3KOz0JDGGee20f2CBtFuPhrRUX2m2hzhut5WObGVBuw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Sandeep K Chaudhary <babbusandy2006@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0530232146==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11 Mar (23:59:57), Sandeep K Chaudhary wrote:
> >> http://bugs.lttng.org/issues/621
> >
> > This one should be quite straight forward. There is already version
> > check for the create_session command I think. Here is your starting
> > point.
> >
>    I don't see the version check in create_session in create.c or
> session_create in session.c. Though I can see that in function
> relay_send_version in main.c, there is check for the major version (at
> line 1432).

main.c +1097 (relay_create_session)

>=20
>          if (reply.major !=3D be32toh(msg.major)) {
>=20
> Is this what you meant? Please let me know. Thanks !
>=20
> > lttng-tools:
> > * src/bin/lttng-relayd/cmd-*
> > * src/bin/lttng-relayd/main.c

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTIG6mXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02QpwIAMvJ5S5DAT+eVL9hm4x9YMro
YIR9oj4kgZs6FE7OnuSqOXqDVSmWb5bpm8cJaJHdX9ClT4EMTgApJuU2a3EpszIB
3bVT58UKXQZxkZ+k6pijCVPqiL9wuXqUBzfX3RZdqxHeJZwbFjYMNfe2stGlPOOb
pxzy/uEBEwBSGpvbJNwrv2cK0p0DjsmoqUtqgJpm2v27YbaVVvUnukPh2St7jsd5
G91pRKBexkl271l82kFU65o04gjdqvC7uQytJD6g5POWe3kW/t/e6PEGK7Qf4o5G
ED8Il4LOpD+qTL7wKGbhJNyP30Iq1qGuLUt4wMzgzgEq1f/9bMDBQIh8xgtfV90=
=/8B+
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--


--===============0530232146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0530232146==--
