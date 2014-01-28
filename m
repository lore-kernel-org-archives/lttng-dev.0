From: Florian Lohoff <f@zz.de>
Subject: Re: urcu hang in cds_lfht_add
Date: Tue, 28 Jan 2014 22:01:50 +0100
Message-ID: <20140128210150.GE19393__10095.4106230803$1390942980$gmane$org@pax.zz.de>
References: <20140128202413.GC19393@pax.zz.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1780996402=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from pax.zz.de ([88.198.69.77])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <flo@pax.zz.de>) id 1W8Fn5-000677-TB
	for lttng-dev@lists.lttng.org; Tue, 28 Jan 2014 16:01:57 -0500
In-Reply-To: <20140128202413.GC19393@pax.zz.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1780996402==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8vCeF2GUdMpe9ZbK"
Content-Disposition: inline


--8vCeF2GUdMpe9ZbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2014 at 09:24:13PM +0100, Florian Lohoff wrote:
>=20
> Hi,
>=20
> i am using urcu hashes for indexing network packets. I am currently
> reading a pcap file for replaying so i am single threaded right now.
> I am indexing the same packet in multiple different hashes.
>=20
> I have now added call_rcu for freeing structures and now i experience
> hangs.
>=20
> As soon as i remove the call_rcu the code runs through. with the call_rcu
> it hangs after a couple thousand packets in an cds_lfht_add.
>=20
> As i find RCU still a little mind twisting i fail to find a path
> for debugging.
>=20
> Ah - this is urcu 0.7.7 on Debian/Wheezy amd64

Using 0.8.1 with DEBUG_RCU, adding a second thread calling synchronize_rcu =
regularly
gave an assert sometimes which showed some broken state.

Disabling the last free() caused the process to finish so=20
i found a small bug causing a removal on a hash to fail.

I freed the memory and there was your hash corruption.

Sorry for the noise ...

Flo
--=20
Florian Lohoff                                                 f@zz.de

--8vCeF2GUdMpe9ZbK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBUugavpDdQSDLCfIvAQhs+g//bsodcxpH5HyHbtgmDcg9nxgbGniKoMON
q/hD9KoMtVEii7dcolcXu5mSRuwr5Jxi6m8CpT1CUAvhPNdlxs+bolEd67E/EkoI
e/oeKjDMe5A9jZ8+C2SZNiAp+hx7YM4Ad50U1dTmHTwztPMBwfQCQ/BeCdBeskUT
sxQlJ9v+aNOWcFWEfMqAwbr+Vg535uGoEqTY903t4ntJG2JOqMegq7IQe/1WQRUD
4eRjHKYuwCXCa3oRu+DXB6oX+AmUzq7WEP5iL4DAM8JYYIFuRAUzGPlnP53Lo2KN
kg8VfXuYOs23YCsfwZkfAVkZhI6uSWmEPmaxe7jY5Snw9pznHK7onz+GkEEglu/p
xk3aFJxiFcCw0Zvhy+A5vFwl7HkvX1/KewtOtKN9HlhfsX3eTFcon/rC6e17D3NL
2zwuIT7qdd1E1wjS1EaXKeim/yrxW2CRuoRkx+dsT0e9DIjn0QN+41SEQQPc5liO
Ex3u3+9xarKtMrmZxWk3IQpBN2MzPvS5qelC1vPkyuCvBm9R25NzvnPgdexyIFsK
+EF8MtXtjD14zHBiTfhFYrR52do3mwgn1bQfdsKhTfSHbXSShTi8lKe0HiA9Tq1v
AU5bLS8g5gGGAykUG+R8ArkkyDbLqO5j0ddKoc0WQf5s+wIr4BGDxqOxain1c1BM
JENO9m+WeVI=
=s0pe
-----END PGP SIGNATURE-----

--8vCeF2GUdMpe9ZbK--


--===============1780996402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1780996402==--
