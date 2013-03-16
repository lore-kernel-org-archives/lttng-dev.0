From: =?UTF-8?B?UmFwaGHDq2wgQmVhbW9udGU=?= <raphael.beamonte@gmail.com>
Subject: Re: [lttng-tools PATCH] Add a git version information
 in LTTng versions compiled from git sources
Date: Sat, 16 Mar 2013 19:55:42 -0400
Message-ID: <5145067E.7020609__16685.842202469$1363478194$gmane$org@gmail.com>
References: <2f2984a90ab0b25a5b9e6259060fdd6c5c7bb00a.1363372839.git.raphael.beamonte@gmail.com>
	<16a0408728b4c746985844ecd893bd569b599641.1363477794.git.raphael.beamonte@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0927473870=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <raphael.beamonte@gmail.com>) id 1UH0x4-00007u-TX
	for lttng-dev@lists.lttng.org; Sat, 16 Mar 2013 19:55:51 -0400
Received: by mail-ia0-f170.google.com with SMTP id h8so4313628iaa.15
	for <lttng-dev@lists.lttng.org>; Sat, 16 Mar 2013 16:55:45 -0700 (PDT)
In-Reply-To: <16a0408728b4c746985844ecd893bd569b599641.1363477794.git.raphael.beamonte@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0927473870==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2WANUNUHXCIJSKXASHRVB"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2WANUNUHXCIJSKXASHRVB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2013-03-16 19:49, Rapha=C3=ABl Beamonte wrote:
> Signed-off-by: Rapha=C3=ABl Beamonte <raphael.beamonte@gmail.com>
> ---
>  .gitignore                              |    2 ++
>  include/Makefile.am                     |   45 +++++++++++++++++++++++=
+++++++-
>  include/version.h.tmpl                  |   27 +++++++++++++++++++
>  src/bin/lttng-sessiond/lttng-sessiond.h |   14 ++++++++++
>  src/bin/lttng-sessiond/main.c           |    2 +-
>  src/bin/lttng/commands/version.c        |    4 ++-
>  src/bin/lttng/lttng.c                   |    5 +++-
>  src/bin/lttng/utils.h                   |   13 +++++++++
>  8 files changed, 108 insertions(+), 4 deletions(-)
>  create mode 100644 include/version.h.tmpl

This new version of the patch adds comments in the Makefile.am to help
to understand the work of the shell routine.




------enig2WANUNUHXCIJSKXASHRVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRRQZ/AAoJECV+8Ygg/tEooOEQAISaRPARR4hA+akRoBmFvDSN
n03TAFDSwIfRpgsNfYm0MMZ8J9wMURFTfRJVGDdReCk3BC2FxDgwvsOuqqsFQNl+
HU7WYx/aq2RLP/uRWA5UmJcMVfm0n0+cAc0xaQreLfToPga6ufh3Qtng3NaBFD3r
fw5eeraN8A2PQiu6jOPlEvmp9LWpRugqKVaW+E2liSvVsdL1rj8h2JWd+8Zxs1yV
Aun57IU+zTfOLvd8WLCde0sldjgGoXSab8dhc3embxlI/fwNPq89OZZ1SRDJ1+87
wwuarYZdrecQKLHQhTr53K7flE4+o0UmIWSrXDctcrAhMHIaXLt11z9GARp9Sm1H
AmK3SyVrsNPjI6er5LFuyS+LiYB6xnCpedF4iw+UFevKXduc4lrjiJyIwBFXsVxF
eF3TnihSnUrXr3CmKx2I/fThBcAjlzlymJezwRF9S8HQGWsfuYaA2zqCEUcR2SHw
p3+lhTUT7eqkWLvJR1upT3N5n1SCnmL3oS5yPTI2FV1ohWySPPvPtVk4odSbKE3k
rmDsVAaN41fehKMBEHeS1eMahzQmGpPppZlvgshbzFdinUCEBVGGDycdgxPY2oZB
kAJsRFr+xlqqrAdfafyYBaCR5sJCeTs9gTmaQSTTKo9lLbGeBAzaQDtU54jgTeAz
IkKT7YjJKFet4KhA/s5h
=Hen2
-----END PGP SIGNATURE-----

------enig2WANUNUHXCIJSKXASHRVB--


--===============0927473870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0927473870==--
