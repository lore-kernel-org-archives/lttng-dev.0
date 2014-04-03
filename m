From: David Goulet <dgoulet@efficios.com>
Subject: Re: lttng-sessiond: ht-cleanup.c:92: thread_ht_cleanup:
 Assertion `pollfd == ht_cleanup_pipe[0]' failed.
Date: Thu, 3 Apr 2014 10:32:16 -0400
Message-ID: <20140403143216.GA9339__32695.0499824763$1396535600$gmane$org@thessa>
References: <532AE51F.6030406@keymile.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1378831686=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WVigu-0000pM-I7
 for lttng-dev@lists.lttng.org; Thu, 03 Apr 2014 10:32:30 -0400
In-Reply-To: <532AE51F.6030406@keymile.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Gerlando Falauto <gerlando.falauto@keymile.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============1378831686==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20 Mar (13:54:55), Gerlando Falauto wrote:
> Hi,
>=20
> I'm trying to bring lttng-tools up to date, but I get the following messa=
ge:
>=20
> lttng-sessiond: ht-cleanup.c:92: thread_ht_cleanup: Assertion `pollfd =3D=
=3D
> ht_cleanup_pipe[0]' failed.
>=20
> I noticed this was already filed as a bug:
> http://redmine.dorsal.polymtl.ca/issues/747
>=20
> I tried implementing the solution proposed on the comment:
>=20
> >We should add a check to see if the revent is 0 at the beginning of
> >the loop, and continue to the next loop iteration if it is the case.
>=20
> But this doesn't seem to help.
>=20
> Any suggestion?

Sorry for the delay!

An approach here to debug this would be to first compile with -O0 to
remove any optimization from the compiler (simply add this to CFLAGS in
configure.ac).

Then, have some printf() that prints the revents + pollfd at each
iteration and see why revents =3D=3D 0 is not enough.

As stated in the bug report, poll() will make the loop iterate over all
fd thus this assert() is a bit hardcore considering that we didn't check
if an event was triggered before.

Please if you work on that, update the ticket so we can track the
progress! :)

Thanks!
David

>=20
> Thank you,
> Gerlando
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTPXDwXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02p0AH/i2NP4T3zvywvLTixcvv7r+y
q8K5OsSY43u0/h/izDtboTxjgpPbClyYiTDw469B8BrpB8Cp4Mj/P+diZ4yMDKe7
E0GMjd+T64XiA7g/O4nNehWw8x8t0NIM/I6dzQlJVJT2IsgJa88j+peP4dOQTuCt
UFvwdWHVxYklXz409dsXPHnbiqyAiBzEjzwDY8qfr63cZHmRkM7AENTUBrWPoP6q
SEFOUk6+DDUq2R2ZzX45rix7DfljLsx8yMQjim8y19usv6SPRs/pw3ybM2IJuGcZ
Qs0ddt/HB+/PfDJy3CW/2SGR7ExkQMfzSsPG88x13MCKKNm6k1jflPZrPBzsUcI=
=CVZS
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--


--===============1378831686==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1378831686==--
