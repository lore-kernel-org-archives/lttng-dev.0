From: David Goulet <dgoulet@efficios.com>
Subject: Re: trace time out of order
Date: Wed, 25 Jun 2014 10:46:03 -0400
Message-ID: <20140625144603.GA2197__37.1330687359617$1403707633$gmane$org@dalia>
References: <d49b4b69-120a-427b-bcd0-abe7dbe48855@aliyun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0926190537=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WzoSh-0000BT-L0
 for lttng-dev@lists.lttng.org; Wed, 25 Jun 2014 10:46:17 -0400
In-Reply-To: <d49b4b69-120a-427b-bcd0-abe7dbe48855@aliyun.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============0926190537==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25 Jun (15:15:50), zhenyu.ren wrote:
> Hi,lttng-dev
>=20
>    I traced my rpc application. On the server side ,a thread reads a requ=
est from the socket and push the workitem to a queue(pushWorkItem tracepoin=
t after queuing),another thread will get the workitem from queue and proces=
s it(ProcessWorkItem tracepoint here). However, in the trace log,I saw the =
ProcessWorkItem before pushWorkItem.Is this a clock issue?
>=20
> [14:38:07.619841156] (+0.000000693)  arpc_server:ProcessWorkItem: { cpu_i=
d =3D 0 }, { vtid =3D 28581 }, { Item =3D 112046400 }                 A
> [14:38:07.619841558] (+0.000000402)  arpc_server:ProcessWorkItem: { cpu_i=
d =3D 12 }, { vtid =3D 28583 }, { Item =3D 112049088 }                B
> [14:38:07.619844551] (+0.000002993)  arpc_server:ProcessWorkItem: { cpu_i=
d =3D 9 }, { vtid =3D 28582 }, { Item =3D 72969600 }                   C
> [14:38:07.619845090] (+0.000000539)  arpc_server:pushWorkItem: { cpu_id =
=3D 3 }, { vtid =3D 28569 }, { Item =3D 112046400 }                      A
> [14:38:07.619846525] (+0.000001435)  sched_wakeup: { cpu_id =3D 12 }, { v=
tid =3D 28583 }, { comm =3D "", tid =3D 28581, prio =3D 120, success =3D 0,=
 target_cpu =3D 0 }
> [14:38:07.619846872] (+0.000000347)  arpc_server:pushWorkItem: { cpu_id =
=3D 7 }, { vtid =3D 28563 }, { Item =3D 72968352 }
> [14:38:07.619849172] (+0.000002300)  arpc_server:ProcessWorkItem: { cpu_i=
d =3D 19 }, { vtid =3D 28587 }, { Item =3D 72968352 }
> [14:38:07.619850525] (+0.000001353)  arpc_server:pushWorkItem: { cpu_id =
=3D 6 }, { vtid =3D 28564 }, { Item =3D 112049088 }                      B
> [14:38:07.619862696] (+0.000012171)  sched_switch: { cpu_id =3D 3 }, { vt=
id =3D 28569 }, { prev_comm =3D "pangu_chunkserv", prev_tid =3D 28569, prev=
_prio =3D 20, prev_state =3D 1, next_comm =3D "swapper", next_tid =3D 0, ne=
xt_prio =3D 20 }
> [14:38:07.619864494] (+0.000001798)  sched_switch: { cpu_id =3D 6 }, { vt=
id =3D 28564 }, { prev_comm =3D "pangu_chunkserv", prev_tid =3D 28564, prev=
_prio =3D 20, prev_state =3D 1, next_comm =3D "pangu_chunkserv", next_tid =
=3D 28568, next_prio =3D 20 }
> [14:38:07.619867101] (+0.000002607)  arpc_server:pushWorkItem: { cpu_id =
=3D 6 }, { vtid =3D 28568 }, { Item =3D 72969600 }                       C

Tbh, I doubt that the timestamp collected by lttng is skewed. My guess
would be that your threading might actually be racy making the Process
Work Item run before the push. Could that be possible?

Also, can you reproduce that each time or it looks like a race?

Cheers!
David

>=20
>=20
>=20
> ps: Hardware: 2 x Xeon E5-2430 0 2.20GHz(24HT) =EF=BC=8C 96G mem=20
>       urcu 0.8 lttng 2.3
>=20
> Thanks
> zhenyu.ren
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTquCrXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02IdQH/3gAUglFeaHnt67NnAMmKNX2
tBUjdnXYpAekeccz8rsLNk7qKFT1Gnw+w45mptck0ocAWe31vXVypzrxJqRtpCKR
xa8hd4YGUdoUBsUb4kMEHlRCf3BgeaGP+X0ItBs//8gm5ZY0c6j2GILkKlKi3e+z
Fn5tUzrEcUAFOpdimeRHSR5e24EqBcHKubaXPoQI3+J+RNDDudC8qQTLUIlp0MtI
sDRUYZ8cY5RCNtRIyqE/RtJAwdP3xZvylfRLoioIAq7tui7dL/sTKPeFkMCEKccw
T2iM7g2CnVQAqPumV3hJ4o/S5JjYimfKF9xKrvAmQ6jh9Xc9MYp9zJ0Bc0JaN0s=
=m73g
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--


--===============0926190537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0926190537==--
