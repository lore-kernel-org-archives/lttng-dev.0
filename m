From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools v3 0/4] Dynamic probe list
	support
Date: Wed, 14 May 2014 16:47:30 -0400
Message-ID: <20140514204730.GD15072__29120.4997258776$1400100539$gmane$org@dalia>
References: <cover.1400077421.git.jan.glauber@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1182877159=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ns236805.ip-192-99-35.net ([192.99.35.19]
 helo=smtp.ini-tech.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1Wkg5b-0004Bp-2T
 for lttng-dev@lists.lttng.org; Wed, 14 May 2014 16:47:55 -0400
In-Reply-To: <cover.1400077421.git.jan.glauber@gmail.com>
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


--===============1182877159==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bjuZg6miEcdLYP6q"
Content-Disposition: inline


--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

I merged it with some minor syntax fixes mostly in modprobe.c. There is
one thing I don't accept at all is if/else without {}. Remember the goto
fail; bug :).

Anyhow, I fixed them to fit my OCD if/else issue. ;)

Big thanks for that, this is really great! I would love to improve that
with support in the "lttng" command line that could take a list and
spawn the sessiond with it. Also, the configuration file coming in 2.5
(currently in master).

Cheers!
David

On 14 May (16:26:28), Jan Glauber wrote:
> Hi David,
>=20
> here are the rebased patches (onto 88564da). There are no functional
> changes to the previous version.
>=20
> Jan Glauber (4):
>   Use common functions for module loading and unloading
>   Seperate probe modules from control modules
>   Remove required parameter from module parameters
>   Configurable kernel module probes support
>=20
>  doc/man/lttng-sessiond.8              |    7 +
>  src/bin/lttng-sessiond/kern-modules.h |    3 +-
>  src/bin/lttng-sessiond/main.c         |    5 +
>  src/bin/lttng-sessiond/modprobe.c     |  307 ++++++++++++++++++---------=
------
>  src/bin/lttng-sessiond/modprobe.h     |    2 +
>  src/common/defaults.h                 |    3 +
>  src/common/utils.c                    |   10 ++
>  src/common/utils.h                    |    1 +
>  8 files changed, 200 insertions(+), 138 deletions(-)
>=20
> --=20
> 1.7.9.5
>=20

--bjuZg6miEcdLYP6q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTc9ZiXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02i1wH/jUepXtlAq9wPSnvVmdqz+zF
sXvDKEAxql6rqk2R7zLFrIKm7erDhst42GYtqPdY2U/0R+AJoisF5wArlyBhX9ru
H77J60j63iXXt1P9cQV8puYQSIIry/gaKuzY8tXVGkx6ba9RNCkkZ45gdiNFT8Ah
i+Fz9bDnxQF00/VDiba4r9BqDOtxsN3Ce47ugP1dNow4EZQOwMsaab8eEE5J/XyK
/GqbeXAXIKeuol4+xDT+5IOfUkQ/ZN9zHhgjnHhK9J4meLIiXhnf/f7Fxqm8v0Ei
B1lRD2YxFau6T3/HGOEJoOO+BwVgbkg1hk/fbhaSXs6Y/m9SmnAImBoJy7Me5+A=
=YhOf
-----END PGP SIGNATURE-----

--bjuZg6miEcdLYP6q--


--===============1182877159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1182877159==--
