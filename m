From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [lttng-tools PATCH] Add a git version line in	LTTng
	versions compiled from git sources.
Date: Wed, 13 Mar 2013 09:26:33 -0400
Message-ID: <20130313132633.GA15843__2244.11018793962$1363181247$gmane$org@Krystal>
References: <513FA045.401@efficios.com>
	<963e75cf2cdaa8ccf854f3d34932d5fc1f2c1103.1363140466.git.raphael.beamonte@gmail.com>
	<513FE084.7030405@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1823978760=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UFlhT-0002sr-2Z
	for lttng-dev@lists.lttng.org; Wed, 13 Mar 2013 09:26:35 -0400
In-Reply-To: <513FE084.7030405@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?Rapha=EBl?= Beamonte <raphael.beamonte@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1823978760==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Rapha=EBl Beamonte (raphael.beamonte@gmail.com) wrote:
> Hello,
>=20
> This version adds a line "Git version" to "LTTng --help". The value of
> this line is calculated during "make" and then defined in a GIT_VERSION
> macro.
> It also works for versions without Git as it will just not define the
> GIT_VERSION value. The black point is that the "test" is made each time
> we "make" the tool. This can be corrected but I'm not sure it's
> necessary as this one is well working.
>=20
> If this patch is ok for you, I can apply an identical patch to UST and
> babeltrace.

Does the entire project needs to be rebuilt at every commit then, or
just one or two files ?

Thanks,

Mathieu

>=20
> Rapha=EBl
>=20
> On 2013-03-12 22:07, Rapha=EBl Beamonte wrote:
> > Signed-off-by: Rapha=EBl Beamonte <raphael.beamonte@gmail.com>
> > ---
> >  src/bin/lttng/Makefile.am |    6 +++++-
> >  src/bin/lttng/lttng.c     |    6 +++++-
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/src/bin/lttng/Makefile.am b/src/bin/lttng/Makefile.am
> > index 21eebab..1b1219b 100644
> > --- a/src/bin/lttng/Makefile.am
> > +++ b/src/bin/lttng/Makefile.am
> > @@ -1,5 +1,9 @@
> > +git_version_string=3D$$(git describe --long --all 2>/dev/null)
> > +git_version=3D$$(test -n "${git_version_string}" && echo "-DGIT_VERSIO=
N=3D\"${git_version_string}\"")
> > +
> >  AM_CPPFLAGS =3D -I$(top_srcdir)/include -I$(top_srcdir)/src \
> > -			  -DINSTALL_BIN_PATH=3D\""$(bindir)"\"
> > +			  -DINSTALL_BIN_PATH=3D\""$(bindir)"\" \
> > +			  ${git_version}
> > =20
> >  bin_PROGRAMS =3D lttng
> > =20
> > diff --git a/src/bin/lttng/lttng.c b/src/bin/lttng/lttng.c
> > index 8562144..28f8fec 100644
> > --- a/src/bin/lttng/lttng.c
> > +++ b/src/bin/lttng/lttng.c
> > @@ -81,7 +81,11 @@ static struct cmd_struct commands[] =3D  {
> > =20
> >  static void usage(FILE *ofp)
> >  {
> > -	fprintf(ofp, "LTTng Trace Control " VERSION" - " VERSION_NAME"\n\n");
> > +	fprintf(ofp, "LTTng Trace Control " VERSION" - " VERSION_NAME"\n");
> > +#ifdef GIT_VERSION
> > +	fprintf(ofp, "Git version: " GIT_VERSION"\n");
> > +#endif
> > +	fprintf(ofp, "\n");
> >  	fprintf(ofp, "usage: lttng [OPTIONS] <COMMAND> [<ARGS>]\n");
> >  	fprintf(ofp, "\n");
> >  	fprintf(ofp, "Options:\n");
> >=20
>=20
>=20
> --=20
> Rapha=EBl Beamonte.
> Information Systems and Telecommunications Engineer (UTT, France)
> Specialized in Mobile Technologies and Embedded Systems
> M.A.Sc. Student in Computer Engineering (Polytechnique Montr=E9al, Canada)
> (33)-(0)6 10 97 27 25 - (1) 438 938-6879 - raphael.beamonte@gmail.com
>=20



> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFRQH6JPyWo/juummgRAo4AAJ42/9VoccIU/1GbUJgjiLggVTnImACgsCxX
DZfs62W4ksmKCgTYWOHyqqA=
=jbGX
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--


--===============1823978760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1823978760==--
