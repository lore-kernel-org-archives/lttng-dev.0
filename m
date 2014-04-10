From: David Goulet <dgoulet@efficios.com>
Subject: Re: [RFC Patch Tools 0/4] Configurable lttng-probe
 modules
Date: Thu, 10 Apr 2014 15:45:51 -0400
Message-ID: <20140410194551.GD28773__35003.3616334715$1397159224$gmane$org@dalia>
References: <cover.1396521858.git.jan.glauber@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0484273378=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WYKvD-0003Yd-Jl
 for lttng-dev@lists.lttng.org; Thu, 10 Apr 2014 15:46:09 -0400
In-Reply-To: <cover.1396521858.git.jan.glauber@gmail.com>
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


--===============0484273378==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Content-Disposition: inline


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03 Apr (12:57:43), Jan Glauber wrote:
> Hi LTTng'ers,
>=20
> I've asked briefly for the configurable probes feature at the Tracing sum=
mit,
> here is an RFC how we could implement it.
>=20
> Why I want to have this feature:
> Currently the LTTng probes that are loaded when a session is created are =
defined
> in a static list. If the user wants to change the loaded probes (for inst=
ance
> disable the very noisy rcu) then lttng-tools must be recompiled or the mo=
dules must
> be blacklisted or deleted. I also found that in our embedded environment =
the default
> busybox configuration is to disable the blacklist feature, so blacklistin=
g is not an
> option.
>=20
> Therefore I want to have a more flexible way of defining which probes to =
load
> on session start. We could use an environment variable that (if present)
> overrides the default and only loads the probes named in the variable.
>=20
> Patch 1 is a cleanup and patch 2 & 3 are preparation for the feature in p=
atch 4.
> Please review and give feedback if this approach is feasible.

Hi Jan,

First of all, thanks for this! Except some syntax issue, this looks
great! Sorry took a while to respond, busy busy improving lttng :P.

Before we go further in mergin this, I see you took the approach of
adding an env. variable to provide the list of probes you want to load.
Right now in the upstream master (for 2.5), we have the support for a
configuration file for lttng-sessiond. Could it be a way you would
prefer (or use) instead of env. var? I understand that embedded stuff, a
conf file might not be preferable.

Anyhow, I'm comfortable merging this and adding this env. var but an
option in the configuration file could also be awesome! :)

One thing that would be great if you have a minute, is to send me a
patch for the man page update of that new variable.

Cheers!
David

>=20
> thanks,
> Jan
> ---
> Harman Becker Automotive GmbH
> System Profiling & Optimizing Team
>=20
>=20
> Jan Glauber (4):
>   Use common functions for module loading and unloading
>   Seperate probe modules from control modules
>   Remove required parameter from module parameters
>   Dynamic probe list support
>=20
>  src/bin/lttng-sessiond/kern-modules.h |    3 +-
>  src/bin/lttng-sessiond/modprobe.c     |  292 ++++++++++++++++++---------=
------
>  src/common/defaults.h                 |    3 +
>  src/common/utils.c                    |   10 ++
>  src/common/utils.h                    |    1 +
>  5 files changed, 172 insertions(+), 137 deletions(-)
>=20
> --=20
> 1.7.9.5
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTRvTvXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02GbAH/3p5vpYDLRNUB+vo0/kkh1nK
GeSXKam2C6hoclPs0GaWG13aJQcyQoEtMlViUIS/7KMLYRyoRyxOONPjSsy2nr4O
FdH1p8pFLmsPafVlBIkjrruG3chGYDYQIrl0CPhzNMkymburlPd+DnRgkPNtYpQF
SKa4mTyQFipHbsxGPQhLp0Q6cL6Vo4OAmEuhLvnzaK4GIc2DhTtfVvAoci+JTmlC
GopX6CkhkGQ8CCVhqJJqINXXp5wmfA1ACITe9NhmLxdOrooDvHAZpbG1EzCWwyOR
mAZ9CmP4xd1Ho07DZMLdBGxittjR+c6hY27BKGjc60QT3JA94iE7AjU7uzwoIFw=
=XjNJ
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--


--===============0484273378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0484273378==--
