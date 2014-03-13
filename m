From: David Goulet <dgoulet@efficios.com>
Subject: Re: Working on some bugs
Date: Thu, 13 Mar 2014 10:44:31 -0400
Message-ID: <20140313144431.GA8473__19459.6079680652$1394721952$gmane$org@thessa>
References: <CAEEAEzWcPk788kF=BptjeGsG=hrWyeK1tcUAM4Fq9GAwZYPXhQ@mail.gmail.com>
	<20140311162201.GE7727@thessa>
	<CAEEAEzX3KOz0JDGGee20f2CBtFuPhrRUX2m2hzhut5WObGVBuw@mail.gmail.com>
	<20140312142646.GA10776@thessa>
	<CAEEAEzXcwbJbv_izsQjL9VTUja2kUj+d_r9iufeqSN4GJvV4Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1787935230=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WO6sC-0004BN-Cb
	for lttng-dev@lists.lttng.org; Thu, 13 Mar 2014 10:44:45 -0400
In-Reply-To: <CAEEAEzXcwbJbv_izsQjL9VTUja2kUj+d_r9iufeqSN4GJvV4Fg@mail.gmail.com>
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


--===============1787935230==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12 Mar (22:59:20), Sandeep K Chaudhary wrote:
> Thanks for pointing it to me, David !
>=20
> However I see the following in relay_add_stream in main.c
>=20
>         switch (conn->minor) {
>         case 1: /* LTTng sessiond 2.1 */
>                 ret =3D cmd_recv_stream_2_1(conn, stream);
>                 break;
>         case 2: /* LTTng sessiond 2.2 */
>         default:
>                 ret =3D cmd_recv_stream_2_2(conn, stream);
>                 break;
>         }
>=20
> This means that it's calling either 'cmd_recv_stream_2_1' or
> 'cmd_recv_stream_2_2' depending on the minor version number. Is this not =
we
> want? Though I don't understand why it should be calling
> 'cmd_recv_stream_2_2' for minor versions other than 1. Is this correct
> behavior?

Yes so for now only the minor version matter since a major number other
than 2 can't be negotiated during the send_version step (the first thing
the relayd receives for a connection).

At some point in time, we would need to check the major number to here
so calling cmd_recv_stream_2_2(...) would make more sense. Maybe it's
something you want to do here before anything, adding a layer that
checks major + minor and calls the right one? Something that could be
generic enough so we don't have those ugly switch cases in each
command... ?

Cheers!
David

>=20
> Please let me know.
>=20
> Thanks and regards,
> Sandeep.

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTIcRPXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02g1YIAJ52zhJ+r7267ixs7qMiIW9R
OGToTRcQGYv1fXSapXNl1yolLbsV0i683xFtfG0UGy00k7W9Sq5JapSZCDzRlrHT
ZHbOW5DLJGEoQKMO9Oz21a64fNavMe8qSjVzVy7NloUapPRCNShcQTrGHsjaw/xz
yMDrIc6nIZdh8vSV1HS9KsT/UP/5g93pu7EdlYom1+Rx6z79+Hto38DrV0dfBXhS
i1A2u3AOpxeiI7pVhwh3H4kJ5t0wvIMAbUHZgBRpafZvvm55zS29VYYDsAq0ibzS
4mHJuBwpqBVvYODUwpmceHDY352IOxD8zGSDj6kbVDphQaK/gYN5UmgcQh3eOSI=
=jAxx
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--


--===============1787935230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1787935230==--
