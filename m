From: David Goulet <dgoulet@efficios.com>
Subject: Re: "lttng enable-event" fails
Date: Tue, 24 Jun 2014 09:53:19 -0400
Message-ID: <20140624135319.GB11698__20819.7849490263$1403618050$gmane$org@thessa>
References: <53A91EF9.1050006@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0497914241=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WzRA6-0006eB-7T
 for lttng-dev@lists.lttng.org; Tue, 24 Jun 2014 09:53:26 -0400
In-Reply-To: <53A91EF9.1050006@wanadoo.fr>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0497914241==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24 Jun (08:47:21), Thierry Bultel wrote:
> Hi,
>=20
> I am using lttng (2.4.1), target is ARM Cortex A9; compiler is gcc-4.7.3,
> but I have the same issue with gcc-4.8.2
> The kernel is Freescale's 3.0.35-4.1.0
>=20
>=20
> lttng fails to start:
>=20
> [root@buildroot ~]# lttng create
> Session auto-19700319-135920 created.
> Traces will be written in /root/lttng-traces/auto-19700319-135920
> [root@buildroot~]# lttng enable-event --kernel --all
> PERROR [5831/5915]: wait: Success (in run_as_clone() at runas.c:243)
> Error: Trace directory creation error
> Error: Events: Kernel create session failed (channel channel0, session
> auto-19700319-135920)
>=20
> My analysis show that lttng attempts to create the trace directory, when
> "lttng enable-event" is called.
> To do so, it uses a slave thread that performs a kind of "mkdir -p" ,
> that thread is spawned via a call to "clone"
> and the father waits for it via "waitpid".
>=20
> When the slave returns, waitpid says it is not completed. Added a little
> code to shows that the thread
> is killed with SIGSEGV at the time it calls "return"
>=20
> Changing it to call "exit" instead, makes it a little better, but other
> numerous errors come when
> calling "lttng start"
>=20
> Did anyone encounter such an issue ?

Hrm, tbh I never tried lttng-tools on ARM but if a SIGSEGV is raised you
should be able to get a core dump and with gdb we can understand which
callsite failed badly.

Thanks!
David

>=20
> Best regards
> Thierry Bultel
>=20
>=20
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTqYLPXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02deAH/RXRm8xGDx5fDDjvkwDCQIpL
boCek+8/13Jt4347nqGczzZTTUlKMtjwbrUEdBqZqjIPGXwMqt/uHvNdcjIEinwV
d81W6zLojVv2sz/PIIj/5r7bbvXGVnG0lLrVMq24/4agmZNShRn7aBMfJADfeqCk
hZNdmIpiKU20o6iWBIOAi+qseO63eaN5MtC8xqO6v6VwrLy9Zits3oQ7nvJtPs7M
zN4iRyT0EwA7tSJ11kD5OR+duiSBtG/2rdknEs48ri6UYIVlwA7zQ43alLkAqFYK
AcRfVETgGl/lHTs8U4h810ylBb1uqD6aCtYurjwVLmXikZ7KrwC/sWA/GvCYBzc=
=IHQ6
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--


--===============0497914241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0497914241==--
