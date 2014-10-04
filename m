From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: FD leak in accept error
	handling
Date: Sat, 4 Oct 2014 09:27:39 -0400
Message-ID: <20141004132739.GA6774__26759.5109333799$1412429299$gmane$org@thessa>
References: <1411861762-17552-1-git-send-email-mathieu.desnoyers@efficios.com>
 <42225267.2928.1412429042743.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1998915670=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XaPND-0001p6-Ui
 for lttng-dev@lists.lttng.org; Sat, 04 Oct 2014 09:27:48 -0400
In-Reply-To: <42225267.2928.1412429042743.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1998915670==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

That has been fix.

commit 475cd9fa36ab2ad108f94bb8292bdcdbbbc6e38f

This was a coverity issue fixed on sept. 30th.

David

On 04 Oct (13:24:02), Mathieu Desnoyers wrote:
> Bump.
>=20
> ----- Original Message -----
> > From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> > To: dgoulet@efficios.com
> > Cc: lttng-dev@lists.lttng.org, "Mathieu Desnoyers" <mathieu.desnoyers@e=
fficios.com>
> > Sent: Saturday, September 27, 2014 7:49:22 PM
> > Subject: [PATCH lttng-tools] Fix: FD leak in accept error handling
> >=20
> > *** CID 1241799:  Resource leak  (RESOURCE_LEAK)
> > /src/common/sessiond-comm/inet.c: 324 in lttcomm_accept_inet_sock()
> > 318
> > 319     end:
> > 320             return new_sock;
> > 321
> > 322     error:
> > 323             free(new_sock);
> > >>>     CID 1241799:  Resource leak  (RESOURCE_LEAK)
> > >>>     Handle variable "new_fd" going out of scope leaks the handle.
> > 324             return NULL;
> > 325     }
> > 326
> > 327     /*
> > 328      * Make the socket listen using LTTNG_SESSIOND_COMM_MAX_LISTEN.
> > 329      */
> >=20
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > ---
> >  src/common/sessiond-comm/inet.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/src/common/sessiond-comm/inet.c
> > b/src/common/sessiond-comm/inet.c
> > index cf06ecb..4e34ad0 100644
> > --- a/src/common/sessiond-comm/inet.c
> > +++ b/src/common/sessiond-comm/inet.c
> > @@ -272,7 +272,7 @@ error_connect:
> >  LTTNG_HIDDEN
> >  struct lttcomm_sock *lttcomm_accept_inet_sock(struct lttcomm_sock *soc=
k)
> >  {
> > -	int new_fd;
> > +	int new_fd, closeret;
> >  	socklen_t len;
> >  	struct lttcomm_sock *new_sock;
> >  	unsigned long timeout;
> > @@ -305,10 +305,18 @@ struct lttcomm_sock *lttcomm_accept_inet_sock(str=
uct
> > lttcomm_sock *sock)
> > =20
> >  		ret =3D lttcomm_setsockopt_rcv_timeout(new_fd, timeout);
> >  		if (ret) {
> > +			closeret =3D close(new_fd);
> > +			if (closeret) {
> > +				PERROR("close");
> > +			}
> >  			goto error;
> >  		}
> >  		ret =3D lttcomm_setsockopt_snd_timeout(new_fd, timeout);
> >  		if (ret) {
> > +			closeret =3D close(new_fd);
> > +			if (closeret) {
> > +				PERROR("close");
> > +			}
> >  			goto error;
> >  		}
> >  	}
> > --
> > 2.1.0
> >=20
> >=20
>=20
> --=20
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJUL/XLXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02IR0H/2DQmDAgvW1IFuZO8PW9PFFN
/oNypGn2pCaxKKuYc/0tbSjazsWOJp/cbDByCCZ3zBM7AMPB/efk+sq/YIC+52vX
YeB7sO5FJG99KNh+Vmu655de40KXjFBUF5qvNe5mUt3XH250WVDVfXCmaSJWrh3M
0PcnNO674tylLqUDBYuyiz4cv/2JYBDsCNgaF62E9wqjZT2MvmznX7rkbnv2jCKE
D03F4IeVrRxYUWI2+jwMR+96I++YFisTbo4+PnoCduvGEVpg5m+BlWk3tnO+v6aK
vLPHHmi9OZHYY1T0jhtZ8AK5r/NDpLt3vvQLvyIFpD1gynmo1UAjJkruvZ91xUY=
=odhM
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--


--===============1998915670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1998915670==--
