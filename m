From: Florian Lohoff <f@zz.de>
Subject: Re: URCU accessing rcu_head->func
Date: Mon, 3 Feb 2014 08:52:59 +0100
Message-ID: <20140203075259.GA25614__13643.7909598046$1391414026$gmane$org@pax.zz.de>
References: <20140131201632.GA32482@pax.zz.de>
	<582363683.17541.1391398658096.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0901551687=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from pax.zz.de ([88.198.69.77])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <flo@pax.zz.de>) id 1WAEKz-0000M1-AL
	for lttng-dev@lists.lttng.org; Mon, 03 Feb 2014 02:53:03 -0500
In-Reply-To: <582363683.17541.1391398658096.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org


--===============0901551687==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi, Mathieu,

On Mon, Feb 03, 2014 at 03:37:38AM +0000, Mathieu Desnoyers wrote:
> >=20
> > I am in the read side critical section so my structure
> > cant appear under my feet but the above can be racy at
> > best.
>=20
> I guess you meant "disappear" here ?

Yep

> > What would be the best way to achieve something like:
> >=20
> > 	"queue for call_rcu if not already queued"
> >=20
> > Another flag with an atomic inc or something?
>=20
> Indeed, the scheme you describe above seems to be racy, since there could=
 be
> two or more read-side critical sections accessing the same object concurr=
ently,
> and doing two call_rcu() enqueuing the same object (same linked list node=
) twice
> into the call_rcu lists will simply corrupt those lists.
>=20
> Let me first rephrase your intent here just to make sure I understand: yo=
u use
> RCU read-side to provide existence guarantee on the "rs" object, and you =
want
> to enqueue the object rcuhead with call_rcu() for deletion (free_obj) aft=
er a
> grace period has elapsed.
>=20
> Assuming you care about keeping this code path wait-free or lock-free (at=
 least),
> using uatomic_xchg() would allow you to set an atomic flag and know, from=
 the
> returned value, whether you "own" the object reclaim or not. You can then=
 decide
> whether or not call_rcu() needs to be called based on the value read by
> uatomic_xchg().
>=20
> You could do something similar with mutexes, but then you would lose the
> wait-freedom characteristic of this code path, which I am guessing is one
> key reason why you use RCU read-side lock and call_rcu() in the first pla=
ce.
>=20
> Does it make sense ?

I solved it a little different. I am using a RCU hash for keeping the=20
data structures and i simply took the reasult of cds_lfht_del
or cds_lfht_add_replace.

If i successfully remove my structure from the hash i queue for later
destruction. As the removal should only happen successfully once i should
be done.

Its just a little bit more tricky to get correct.=20

Flo
--=20
Florian Lohoff                                                 f@zz.de

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBUu9K25DdQSDLCfIvAQgV1Q/+OmDUNofwJ4lDBlKA97iGmVQO1rDlUj1I
FBiYPLbTZ7kXcUv+lsE6HC22PdUDocMqTf4nyqidfuS+XI99mSZN+Y3N59e2Y7f9
uqoN5gHf1jLx7wRqVGAIN9QcmiVJexXyTg31atKCDbfhXGwTx85dxz20Z7VY7E9+
wJP1Xd8WjU2Pm71e+Fk9CRz6d2yer8ds0SH67nX7Fdihl1PfZRc+YBTwTTlMFaeZ
zVtDI2fCDIwXTtztOHGOrw6wtdpsuvq6qqpVVV2DHQR74nMsTjoBdmFG31yp2rJK
Ol2tm3k/wdXDsFIyHjgsCIklSyuGxAj5CElo/R1Zwx5TsP22wuC57ehJiRmrvB3C
XBZePH7xIC2IYcXcBhQT1JF+0OUBMqDQie6BIO8sOktQbSBLJI2duoTKQC30l+0z
aVqpyrdPMPSZfAzyzr1f1WNQDwfD+tGpxmdpTFy9669ekhDEMn4oYq3Bwi9eG6e/
1JGB2JEpF1zperM8Gls4qW8EJkuXjs/uIb1wr35gsRczy+gYAoDtaaa+FEU06fbB
5VPM3Rrdf5p2AgygXCVxs0LyvDSJ+cAxQWgK25jNQqti+rKIQXz+ndjr4Fkk4nlJ
p5HDjHq4cMmf6zchSvA1rQ2WBVaGuFjzw7Q6UijqlMDhdmKp+DMLnFnlii5Suwa1
76jZrLAyqDg=
=cLrY
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--


--===============0901551687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0901551687==--
