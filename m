From: David Goulet <dgoulet@efficios.com>
Subject: Re: [MI-prototype] MI: mi-lttng into libcommon,
 global option lttng_mi_opt , command version
Date: Wed, 26 Mar 2014 09:56:39 -0400
Message-ID: <20140326135639.GA8104__45699.5007269599$1395842256$gmane$org@thessa>
References: <20140321172505.GA9511@gmail.com> <20140325144745.GB7702@thessa>
	<20140325184906.GA1538@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1786451345=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WSoK0-00007v-61
	for lttng-dev@lists.lttng.org; Wed, 26 Mar 2014 09:56:49 -0400
In-Reply-To: <20140325184906.GA1538@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============1786451345==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > +/*
> > >   *  cmd_version
> > >   */
> > >  int cmd_version(int argc, const char **argv)
> > >  {
> > >  	int opt, ret =3D CMD_SUCCESS;
> > >  	static poptContext pc;
> > > +	struct mi_writer *writer =3D NULL;
> > > +	struct lttng_version version;
> > > =20
> > >  	pc =3D poptGetContext(NULL, argc, argv, long_options, 0);
> > >  	poptReadDefaultConfig(pc, 0);
> > > @@ -78,12 +97,58 @@ int cmd_version(int argc, const char **argv)
> > >  		}
> > >  	}
> > > =20
> > > -	MSG("lttng version " VERSION " - " VERSION_NAME);
> > > -	MSG("\n" VERSION_DESCRIPTION "\n");
> > > -	MSG("Web site: http://lttng.org");
> > > -	MSG("\nlttng is free software and under the GPL license and part LG=
PL");
> > > +	if (lttng_opt_mi) {
> >=20
> > I would go for a function to print the mi like maybe "print_mi()" since
> > this *may* change depending on what output type we use. For now, only
> > one but let's think ahead :) and this allow to handle the mi writer
> > destruction in one specific call also, cleaner in the long run I think.
> Okai, we got a patch comming for list ( need some cleanup, internal
> code review and 2 features) but you might want to check the way we
> incorporate the mi into the command and tell us what you think. Cause
> with your comment I think we are heading the wrong way.
> https://github.com/PSRCode/lttng-tools-dev/commit/23b3a771083dc9abbf80aa9=
a46087b0ea9fd5959

What I meant here is to simply have a static function in the same file
that do this job below. This is just easier in terms of code separation
in the long run so keep everything but move it to a function that
handles "mi printouts".

Cheers!
David

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTMtyXXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02NzsH/00IYRs4wORrOishlhRrBP3a
Cq9PQqRxRtuDihflboLwLJufNZi2Ogxn9kljrq5/IoLpOe1B2vmg+4bGMlAUXewC
vq2h7FSpLtRQDDWmmZh/MdPClArIrQU9o5WD7wrn9B/NZk9zYXEPVuUFdwDiIjl2
DdSvGa7NltfCq+LAORXEeHJoq53jIQJzvTd16vJN3eLSf6YyVCX68XhD98OfvqFs
u3MkO38Z227kOHj2dNadWMt29Sql8mlJVpEP3a0WMBkGM32jtkFxH08wJXvzu8fQ
rp6AHce9e8jfKEc3IpILyuxgZ/2TGJfg/prrDXX/JFIHQkk+6EYXMEpEALd/jyg=
=QeSC
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--


--===============1786451345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1786451345==--
