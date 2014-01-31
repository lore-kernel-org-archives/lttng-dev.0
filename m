From: Florian Lohoff <f@zz.de>
Subject: URCU accessing rcu_head->func
Date: Fri, 31 Jan 2014 21:16:32 +0100
Message-ID: <20140131201632.GA32482__19590.8585483723$1391199455$gmane$org@pax.zz.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0939119038=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from pax.zz.de ([88.198.69.77])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <flo@pax.zz.de>) id 1W9KVu-0006Gs-7x
	for lttng-dev@lists.lttng.org; Fri, 31 Jan 2014 15:16:40 -0500
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


--===============0939119038==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

i am having multiple timer which can issue a call_rcu on an object using
an rcu_head.

It can happen than an object is already on the call_rcu list
for destruction and another timer fires.

So i am doing something like this.

	if (!rs->rcuhead.func) {
		call_rcu(&rs->rcuhead, free_obj);
	}

I have a feeling in my gut that this didnt blow up
just by accident and i am doing something utterly stupid.

I am in the read side critical section so my structure
cant appear under my feet but the above can be racy at
best.

What would be the best way to achieve something like:

	"queue for call_rcu if not already queued"

Another flag with an atomic inc or something?

Flo
--=20
Florian Lohoff                                                 f@zz.de

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBUuwEoJDdQSDLCfIvAQiy8Q//bWEV3EGt/515OK7ucK1Sjaaalz1s19xd
68sqcz9KsC66VaX+79V3RnDBNABDL95l3SYHjyOXGZ7Yie7dA3EqOhCzqlPO/NVR
mjDh6qTPtZucebjAms5nQAan3vGHKcanPzPF3tspne5EEZ58FM6vI8gpqQMvH6zE
VhrFDFebwumi/1CgJMaIrLXMTMv4SvS9ppqMA42F0dn+wso1lNb9OCcM69uhdu8i
7r021opn6CRVGqN8Mh0nhHBRAwQXiMgLnt8cf9DVBliw3V6wO5yJbPpAdOIOI66Y
1NV8b+/xhTPBPTX1PTXqesgn7PxOk36pP3yWAJ8oAbVuos3r1065B4BuKibHFa6z
z9tmI1q5/Nc9H3wt4zlD7PMWMaJquNz4JUtbhMToc1LtTazoMeIOgMCrWUBHtwFw
OQGynX1CIGi2yODjPRSfeckNarjPLNxdzmjURyzaQnbITI+AA4Z4SArjMi4VoDSt
4PaOnLKdM54pEtOXmi7VxBtG0x/ZcIunEVrpWu1PTa2aQbSxqQORbAK5Y5nfdQ5/
VAo6SlTGEdQGiTJ+ykb7X90zwRUyp+tHrY93pYRwmA+wnjJL+gY2EfaXwbaVHU1R
Ft3NdPECUMbdU0X6Wbl/bRH6cMtw+U6USzP1zs2ncH5cjJeDHOpcfuQKDhQ0o/9b
OECjDLdfr94=
=K9Ux
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--


--===============0939119038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0939119038==--
