From: =?UTF-8?B?UmFwaGHDq2wgQmVhbW9udGU=?= <raphael.beamonte@gmail.com>
Subject: Re: [PATCH] Add a git version information in LTTng
 versions compiled from git sources
Date: Wed, 13 Mar 2013 23:16:17 -0400
Message-ID: <51414101.4080809__38385.4724154391$1363231030$gmane$org@gmail.com>
References: <5140A719.6020003@gmail.com>
	<1363230220-11071-1-git-send-email-raphael.beamonte@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0686342846=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <raphael.beamonte@gmail.com>) id 1UFyeX-00012K-9f
	for lttng-dev@lists.lttng.org; Wed, 13 Mar 2013 23:16:25 -0400
Received: by mail-ia0-f175.google.com with SMTP id o25so1571591iad.34
	for <lttng-dev@lists.lttng.org>; Wed, 13 Mar 2013 20:16:19 -0700 (PDT)
In-Reply-To: <1363230220-11071-1-git-send-email-raphael.beamonte@gmail.com>
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
--===============0686342846==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2URIXSGUJJPXXIHGIEVCX"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2URIXSGUJJPXXIHGIEVCX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2013-03-13 23:03, Rapha=C3=ABl Beamonte wrote:
> Signed-off-by: Rapha=C3=ABl Beamonte <raphael.beamonte@gmail.com>
> ---
>  include/Makefile.am              |   20 +++++++++++++++++++-
>  include/lttng/version.h          |   25 +++++++++++++++++++++++++
>  src/bin/lttng-sessiond/main.c    |    5 +++++
>  src/bin/lttng/commands/version.c |    4 ++++
>  src/bin/lttng/lttng.c            |    7 ++++++-
>  5 files changed, 59 insertions(+), 2 deletions(-)
>  create mode 100644 include/lttng/version.h

Ok, this is a new try. This one uses shell script in the Makefile of the
include directory to verify and change (only if necessary) the value of
the GIT_VERSION define. It allows the sessiond/main.c,
commands/version.c and lttng.c files to be the only one to need
re-compilation for versioning when the git version changes.

I thought at first to put the content of the shell script in a
version.sh file that would be called, but I wasn't sure the idea of
calling an external shell script at make would be better that directly
put the operations in the makefile.

One thing I'm not sure about is that currently, the version.h needs to
be versioned but perhaps should be in the .gitignore file to only save
the "original" version file in the repository. There could be another
solution if you think it's better : generating the version.h file with
the bash script at first run. In this case, I think the version.sh shell
script should perhaps be a better solution.



------enig2URIXSGUJJPXXIHGIEVCX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQUEBAAoJECV+8Ygg/tEoM24P/1MdGxfMCGvThIlJaNpirLM7
SbxS5VuTCxFj4Y0StIVYTy3qEfg8TKKdpLhviaSPOBiVmbUlyks9sxp7iHxkXt0L
73g08O7R1Pvnp7gutclMJBABVdaz40wKvk4LX8m/RERP1RJj5mD5NHDqxtMq5wnp
r3kIz9NrT332+0EB3Ky/5t8Qtc/iyOhoSeY5qMp5RpG3p5Lwdx2ahXboab/kic23
lMc3A1+rXII8rni2KT8JNv+jOkBcmq+4BVNZ13qGIauc3Dte2K6j5f/B4o05UtOS
SutuwDam4nJjPKIxn6E6XXMTVEme5kq8LkI5Giz3sUj2vHhel1h+CFDnI8+0LTR3
O30RZ13Uz76Ui/eTDjbG85Rf3Dano5m+fZ7CEBT7qCdrleeJNArU9SSimxoMNgbp
j6bYeD489qXbU4/0wly1IdBsTAiwhU9P2zEUbK/bED9m3IjFFXbrh77EjPgyC7NI
c2AgGkqvsdVHJVqIRh2s8A0gzf8ChxxBUErpyudEWJT1LMkIb82lY1UoIQ1Vpn1b
4CpQPl7HeKmIdV3/8J4lNa2qF8CYwt+i/ycUuQ6CpLwgCgRV9Hsu+ztcHE96UvVa
IST16fD4O7BOpg1kAcgq0dLhBIiEOzatwY4Jg3cQyJfwI0l05Hg2mOumxayK6spP
Y67U2KaqLoyMseh63YwS
=AmIS
-----END PGP SIGNATURE-----

------enig2URIXSGUJJPXXIHGIEVCX--


--===============0686342846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0686342846==--
