From: David Goulet <dgoulet@efficios.com>
Subject: Re: [RFC Patch Tools 0/4] Configurable lttng-probe
 modules
Date: Mon, 14 Apr 2014 14:40:51 -0400
Message-ID: <20140414184051.GD32712__22900.4114204601$1397500943$gmane$org@thessa>
References: <cover.1396521858.git.jan.glauber@gmail.com>
 <20140410194551.GD28773@dalia> <20140411084046.GA15028@hal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1941827192=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WZloW-0003Ay-VM
 for lttng-dev@lists.lttng.org; Mon, 14 Apr 2014 14:41:10 -0400
In-Reply-To: <20140411084046.GA15028@hal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jan Glauber <jan.glauber@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1941827192==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kvUQC+jR9YzypDnK"
Content-Disposition: inline


--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11 Apr (10:40:47), Jan Glauber wrote:
> On Thu, Apr 10, 2014 at 03:45:51PM -0400, David Goulet wrote:
> > On 03 Apr (12:57:43), Jan Glauber wrote:
> > > Hi LTTng'ers,
> > >=20
> > > I've asked briefly for the configurable probes feature at the Tracing=
 summit,
> > > here is an RFC how we could implement it.
> > >=20
> > > Why I want to have this feature:
> > > Currently the LTTng probes that are loaded when a session is created =
are defined
> > > in a static list. If the user wants to change the loaded probes (for =
instance
> > > disable the very noisy rcu) then lttng-tools must be recompiled or th=
e modules must
> > > be blacklisted or deleted. I also found that in our embedded environm=
ent the default
> > > busybox configuration is to disable the blacklist feature, so blackli=
sting is not an
> > > option.
> > >=20
> > > Therefore I want to have a more flexible way of defining which probes=
 to load
> > > on session start. We could use an environment variable that (if prese=
nt)
> > > overrides the default and only loads the probes named in the variable.
> > >=20
> > > Patch 1 is a cleanup and patch 2 & 3 are preparation for the feature =
in patch 4.
> > > Please review and give feedback if this approach is feasible.
> >=20
> > Hi Jan,
> >=20
> > First of all, thanks for this! Except some syntax issue, this looks
> > great! Sorry took a while to respond, busy busy improving lttng :P.
>=20
> Hi David,
>=20
> thanks for reviewing! Also, I hope part of the improvement work was to de=
cide
> on the name for the 2.5 release ;-

Always a priority! :P

>=20
> > Before we go further in mergin this, I see you took the approach of
> > adding an env. variable to provide the list of probes you want to load.
> > Right now in the upstream master (for 2.5), we have the support for a
> > configuration file for lttng-sessiond. Could it be a way you would
> > prefer (or use) instead of env. var? I understand that embedded stuff, a
> > conf file might not be preferable.
>=20
> Actually a config file was my first thought also, but I only found the .l=
ttngrc
> which is generated when a session is started. Where is the sessiond confi=
g file
> located? I don't see a config file under /etc or in the home directory.

As of now, you have to pass it to the daemon:

  -f  --config                       Load daemon configuration file

For 2.5, we want to have a default config. file installed in /etc/lttng/
and provide also documentation on it with probably a man page.

We went with the INI file format so in our case here I can see a simple
option like:

modules =3D probe1, probe2, probe3, ...

and by default load ALL.

>=20
> > Anyhow, I'm comfortable merging this and adding this env. var but an
> > option in the configuration file could also be awesome! :)
> >
> > One thing that would be great if you have a minute, is to send me a
> > patch for the man page update of that new variable.
>=20
> I'll do that when we've decided about config file vs. env variable...

Yeah to be thorough, we should have an ENV. variable, command line
option and config option. ENV overrides cmdline which overrides config.

For now, I'm OK merging your patches but having at least the
configuration option in the config file for 2.5 would be very
appreciated.

Cheers!
David

>=20
> --Jan
>=20
>=20
> > Cheers!
> > David
> >=20
> > >=20
> > > thanks,
> > > Jan
> > > ---
> > > Harman Becker Automotive GmbH
> > > System Profiling & Optimizing Team
> > >=20
> > >=20
> > > Jan Glauber (4):
> > >   Use common functions for module loading and unloading
> > >   Seperate probe modules from control modules
> > >   Remove required parameter from module parameters
> > >   Dynamic probe list support
> > >=20
> > >  src/bin/lttng-sessiond/kern-modules.h |    3 +-
> > >  src/bin/lttng-sessiond/modprobe.c     |  292 ++++++++++++++++++-----=
----------
> > >  src/common/defaults.h                 |    3 +
> > >  src/common/utils.c                    |   10 ++
> > >  src/common/utils.h                    |    1 +
> > >  5 files changed, 172 insertions(+), 137 deletions(-)
> > >=20
> > > --=20
> > > 1.7.9.5
> > >=20
> > >=20
> > > _______________________________________________
> > > lttng-dev mailing list
> > > lttng-dev@lists.lttng.org
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>=20
>=20

--kvUQC+jR9YzypDnK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTTCuzXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02ojYIAJATgqmJgVJcPmOoLliY+anO
67xr9j++VkyVOk1mX873xyspqwtnZkouGoS3K6oPtDa6Ht1CZGeMTwKoFfjzoYvc
NBGID0+d7pXEK+VUENsRlC6JJmdwf1XQ2i6zabQtgOv2EauuTHegYPh/ODsbQujM
Fj4DiIE+uQX59O5nYQV7sjrisspCKtKqMcg9fpyOJesbeDAtJiCFUkhfitvBXPPP
oTo1ts+OTpZvZxGLDo0nXx7vHN7Bw+j5r4YxPOyL/8Ago6bMG16Yg70zXHRAN0r9
BFZ3LRghBSoyppu10YuBDwiflN1O9pTqmss1AiNbQLRFhNqAoe2cO2onjs9xpdo=
=cAET
-----END PGP SIGNATURE-----

--kvUQC+jR9YzypDnK--


--===============1941827192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1941827192==--
