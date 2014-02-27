From: David Goulet <dgoulet@efficios.com>
Subject: Re: error in generation of trace files
Date: Thu, 27 Feb 2014 08:42:47 -0500
Message-ID: <20140227134247.GA7407__15406.2786292799$1393508643$gmane$org@thessa>
References: <CAB7sTjgY9OpaQG-Cs2gnHA6s3+hHuutkP=6wPPVq5TkfdY-hng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0118415203=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WJ1El-0006XA-R4
	for lttng-dev@lists.lttng.org; Thu, 27 Feb 2014 08:43:01 -0500
In-Reply-To: <CAB7sTjgY9OpaQG-Cs2gnHA6s3+hHuutkP=6wPPVq5TkfdY-hng@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mariya Rampurawala <mariya.r26@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0118415203==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27 Feb (16:36:24), Mariya Rampurawala wrote:
> Hello,
>  I'm new to lttng. I use ubuntu 13.10. While performing basic operations,
> on command lttng view, i get the following error.
> [error] Cannot open any trace for reading.
>=20
> [error] opening trace "/home/mariya/lttng-traces/mysession-20140227-16335=
3"
> for reading.
>=20
> [error] none of the specified trace paths could be opened.
>=20
>=20
> the o/p of the command "lttng-sessiond --verbose" is as follows
>=20
> DEBUG3: Creating LTTng run directory: /home/mariya/.lttng [in
> create_lttng_rundir() at main.c:3692]
> DEBUG1: Client socket path /home/mariya/.lttng/client-lttng-sessiond [in
> main() at main.c:3995]
> DEBUG1: Application socket path /home/mariya/.lttng/apps-lttng-sessiond [=
in
> main() at main.c:3996]
> DEBUG1: LTTng run directory path: /home/mariya/.lttng [in main() at
> main.c:3997]
> Error: Already running daemon.
>=20
> Could you please help me solve the error and proceed with my project?

Hi,

So like the error says, you have an already dunnring daemon but that
shouldn't stop you from tracing stuff.

Can you provide step by step the command you did and from there we can
help you out more easily. The -vvv to the session daemon are good
information to have also!

Thanks!
David

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTD0DXXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02d54H/3t9d7MKZd+0rYomb4FKHhbV
uhHRgEkj9y5KAN6Gi+21uD9M1y4wN1I6v+PDJTYPTz3Fl9wmKDR9gWD7IcPZSc5U
NBgpD7nAenyZL+Dp7F1K94KTdoTnT7XVq1hTCj84Thbiptfo2r7B8xa+pGchzR4Z
7G98wwV6KEY92TsCLDvjFhxjoxfJ2QuDLiQFcxb7vQxNkBG197J4FXDaOOniw+K3
8L9hZpMJlDABgcqt/KmXHsxzs2Oor0TS0Kud2dClqcTkwNhEFLqfFP+4DFXkQamY
2L9qWMKBJtRXC1sZyuDXVKvLMpNV14vSyUSFmm/h/iHF85dAc/WLyjudZmV+WHg=
=OSp+
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--


--===============0118415203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0118415203==--
