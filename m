From: David Goulet <dgoulet@efficios.com>
Subject: Re: Current Trace File Location
Date: Tue, 29 Oct 2013 12:02:31 -0400
Message-ID: <20131029160231.GB6784__32262.0279076093$1383062624$gmane$org@thessa>
References: <CAN7pGtu1BtOibd4nj--7z45ye7QeBHCpCRmavwBL52AnNg-y7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0053187486=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VbBke-0006r2-9c
	for lttng-dev@lists.lttng.org; Tue, 29 Oct 2013 12:02:45 -0400
In-Reply-To: <CAN7pGtu1BtOibd4nj--7z45ye7QeBHCpCRmavwBL52AnNg-y7g@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Steppe <msteppe91@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0053187486==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29 Oct (11:59:04), Michael Steppe wrote:
> Hello,
>=20
> I am not sure if this is where I ask my questions to the developers but I
> thought I'd give it a go.
>=20
> I am able to create a kernel trace, enable all events for the trace, star=
t,
> stop and destroy the trace. But let's say I have two traces running on the
> same machine:
>=20
> [user@localhost ~]$ lttng create trace1
> [user@localhost ~]$ lttng create trace2
> [user@localhost ~]$ lttng create trace3
>=20
> As I am sure you know, the .lttngrc file is populated with ONLY the latest
> created trace name (trace3).
>=20
> Now let's say I change my mind after creating these traces and wish to
> destroy them all. If I use the destroy command...
>=20
> [user@localhost ~]$ lttng destroy
>=20
> ...with no argument, it defaults to the .lttngrc file and destroys trace3=
 as
> well as the .lttngrc file. This means that the next time I run lttng
> destroy I get the error that it cannot find the .lttngrc file and asks if=
 I
> created a session. Well we still have trace1 and trace2 in the background
> somewhere because if I try to:
>=20
> [user@localhost ~]$ lttng create trace1
>=20
> I get told that there is already a trace with that name.
>=20
> My question to you is, where are all the traces stored until they are
> destroyed? LTT obviously knows that trace1 and trace2 are still "running"
> because it won't let me create another with the same name until I destroy
> it. I know that I could say:
>=20
> [user@localhost ~]$ lttng destroy trace1
> [user@localhost ~]$ lttng destroy trace2
>=20
> but I am writing an Eclipse plugin to do this tracing without the terminal
> so the trace name will be based off of the time of day the user runs it a=
nd
> therefore I cannot hardcode the name in.
>=20
> Is there a "destroy all" command that I am missing?

lttng destroy -a :)

David

>=20
> Thanks!!
> Michael

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJSb9wXXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02/UcH+wW9XgM0DxLJ+r0X53TAVzg/
n6qeaarnKUHy+kQkB+AKCDVEaKvsyCjR1agfAYgAOXrviPdQFPckKkjcFJ4IQMsT
7vpq53Aq96FTEe6QSPscBdfTaBNHhfMUgb24fkkssc/6/R5QmpkHg6Epse272HMv
LmiFX0EG9HqkHjXnYwIxU/IJ7eqb56AxRvTkyUt6QjETb2sxyk4a7f2yxAxSxnhm
CyOVHUspAMoAk2QQbTgp5waAgXjTKOaajV+oS+aIIMu+VV/uPGSR0HIvyDzcdviE
t0GjSVwjXQPGNCLIFgoIzG1jjSJzomGA1reigbQ7SlSkJ6V/JlbEt/yuTfbwrvg=
=Owd9
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--


--===============0053187486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0053187486==--
