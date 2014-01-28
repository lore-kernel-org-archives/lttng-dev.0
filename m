From: Florian Lohoff <f@zz.de>
Subject: urcu hang in cds_lfht_add
Date: Tue, 28 Jan 2014 21:24:13 +0100
Message-ID: <20140128202413.GC19393__4349.53642911768$1390940714$gmane$org@pax.zz.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1536387249=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from pax.zz.de ([88.198.69.77])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <flo@pax.zz.de>) id 1W8FCh-0005nt-07
	for lttng-dev@lists.lttng.org; Tue, 28 Jan 2014 15:24:20 -0500
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


--===============1536387249==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
Content-Disposition: inline


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

i am using urcu hashes for indexing network packets. I am currently
reading a pcap file for replaying so i am single threaded right now.
I am indexing the same packet in multiple different hashes.

I have now added call_rcu for freeing structures and now i experience
hangs.

As soon as i remove the call_rcu the code runs through. with the call_rcu
it hangs after a couple thousand packets in an cds_lfht_add.

As i find RCU still a little mind twisting i fail to find a path
for debugging.

Ah - this is urcu 0.7.7 on Debian/Wheezy amd64

currently i do

rcu_init
rcu_register_thread

h1=3Dcds_lfht_new
h2=3Dcds_lfht_new
h3=3Dcds_lfht_new

for each packet {
 rcu_lock

 res=3Dcds_lfht_add_replace(h1, Pn, ..)

 if (res) {

  cds_lfht_lookup(h2 ...
   cds_lfht_next_duplicate
    cds_lfht_del

  cds_lfht_lookup(h3 ...
   cds_lfht_next_duplicate
    cds_lfht_del

  call_rcu(... res)
 }

 cds_lfht_add(h2, Pn
 cds_lfht_add(h3, Pn

 rcu_unlock
}

Flo
--=20
Florian Lohoff                                                 f@zz.de

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIUAwUBUugR7ZDdQSDLCfIvAQi0mw/3VCDCsD0BxkF5tvEnOH60wMjAbvzS7XPq
GNVCodxD2sczFrrQFXcuFbq9RUl1L09F58pLwXRM0fP6kihYjVC86zMiBCAqyqvr
SrsQwGruZ93cd5JXMRDgccnGckh+JkXCdYiJvLMjF5YB9dRLKxMHu47fRH3PO6Z1
F+f3ii0UW47O5Wus6WcWdvXfHhbBGXbJZMN4k586t437ZQKTShsKcTyQTUZ5nTJf
bDc9Y/2QS7zR7pjcUf0jaONemO+YPPekjpGAg0cYnRNngzyfR/CrZ2SVMbeu5zNQ
tExaALCVGPG6ox0xLIdJrDS1slHo76foxUXTtpdk6XJzUZR+nY/vXkXzg3UbTtUD
ohHDr95Zw86xwa4nyLux0nQamAjQ3SfNZ/Cr4jbdg2u08NHPZtiG03GmXcs/iaE2
Y5QhhrcMN6INfZC1IZmTkbxHmYmCJ/Odz/Xsufcu0P0pV37SqQ2Lzkr5md9rPv3Q
IGGbP8QVdycUxf6WK4twnR1RdejBgYPUnjUVRkml7/g1XLqJfBsfJnt++QRoWR2c
u/X+HNQwtkG403m5ksd0c4cTx1OKeF4GEhUoN6xH3ZchqBA368O9c4RKNOARGVDn
1mEN5fzftgwvQspyADCTtqToymmdToHEbBYlTapVaIa+2oA53/FEUUToDn1zy/Gk
KMCODuDpig==
=Y8lZ
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--


--===============1536387249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1536387249==--
