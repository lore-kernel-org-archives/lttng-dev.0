From: =?UTF-8?B?UmFwaGHDq2wgQmVhbW9udGU=?= <raphael.beamonte@gmail.com>
Subject: Re: [lttng-tools PATCH] Add a git version line in LTTng
 versions compiled from git sources.
Date: Tue, 12 Mar 2013 22:12:20 -0400
Message-ID: <513FE084.7030405__27719.8961507112$1363140812$gmane$org@gmail.com>
References: <513FA045.401@efficios.com>
	<963e75cf2cdaa8ccf854f3d34932d5fc1f2c1103.1363140466.git.raphael.beamonte@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1840599116=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <raphael.beamonte@gmail.com>) id 1UFbBB-0005hT-Tp
	for lttng-dev@lists.lttng.org; Tue, 12 Mar 2013 22:12:34 -0400
Received: by mail-ob0-f179.google.com with SMTP id un3so536260obb.24
	for <lttng-dev@lists.lttng.org>; Tue, 12 Mar 2013 19:12:28 -0700 (PDT)
In-Reply-To: <963e75cf2cdaa8ccf854f3d34932d5fc1f2c1103.1363140466.git.raphael.beamonte@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?B?UmFwaGHDq2wgQmVhbW9udGU=?= <raphael.beamonte@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1840599116==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2XEAODWDQGTOALABDXVSL"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2XEAODWDQGTOALABDXVSL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

This version adds a line "Git version" to "LTTng --help". The value of
this line is calculated during "make" and then defined in a GIT_VERSION
macro.
It also works for versions without Git as it will just not define the
GIT_VERSION value. The black point is that the "test" is made each time
we "make" the tool. This can be corrected but I'm not sure it's
necessary as this one is well working.

If this patch is ok for you, I can apply an identical patch to UST and
babeltrace.

Rapha=C3=ABl

On 2013-03-12 22:07, Rapha=C3=ABl Beamonte wrote:
> Signed-off-by: Rapha=C3=ABl Beamonte <raphael.beamonte@gmail.com>
> ---
>  src/bin/lttng/Makefile.am |    6 +++++-
>  src/bin/lttng/lttng.c     |    6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/bin/lttng/Makefile.am b/src/bin/lttng/Makefile.am
> index 21eebab..1b1219b 100644
> --- a/src/bin/lttng/Makefile.am
> +++ b/src/bin/lttng/Makefile.am
> @@ -1,5 +1,9 @@
> +git_version_string=3D$$(git describe --long --all 2>/dev/null)
> +git_version=3D$$(test -n "${git_version_string}" && echo "-DGIT_VERSIO=
N=3D\"${git_version_string}\"")
> +
>  AM_CPPFLAGS =3D -I$(top_srcdir)/include -I$(top_srcdir)/src \
> -			  -DINSTALL_BIN_PATH=3D\""$(bindir)"\"
> +			  -DINSTALL_BIN_PATH=3D\""$(bindir)"\" \
> +			  ${git_version}
> =20
>  bin_PROGRAMS =3D lttng
> =20
> diff --git a/src/bin/lttng/lttng.c b/src/bin/lttng/lttng.c
> index 8562144..28f8fec 100644
> --- a/src/bin/lttng/lttng.c
> +++ b/src/bin/lttng/lttng.c
> @@ -81,7 +81,11 @@ static struct cmd_struct commands[] =3D  {
> =20
>  static void usage(FILE *ofp)
>  {
> -	fprintf(ofp, "LTTng Trace Control " VERSION" - " VERSION_NAME"\n\n");=

> +	fprintf(ofp, "LTTng Trace Control " VERSION" - " VERSION_NAME"\n");
> +#ifdef GIT_VERSION
> +	fprintf(ofp, "Git version: " GIT_VERSION"\n");
> +#endif
> +	fprintf(ofp, "\n");
>  	fprintf(ofp, "usage: lttng [OPTIONS] <COMMAND> [<ARGS>]\n");
>  	fprintf(ofp, "\n");
>  	fprintf(ofp, "Options:\n");
>=20


--=20
Rapha=C3=ABl Beamonte.
Information Systems and Telecommunications Engineer (UTT, France)
Specialized in Mobile Technologies and Embedded Systems
M.A.Sc. Student in Computer Engineering (Polytechnique Montr=C3=A9al, Can=
ada)
(33)-(0)6 10 97 27 25 - (1) 438 938-6879 - raphael.beamonte@gmail.com


------enig2XEAODWDQGTOALABDXVSL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRP+CJAAoJECV+8Ygg/tEoMQ8P/0jqplUsZ0QkBE0xXmumswqD
2wOK0ylDOCMPRccLvqkceRiwrSau9a9cjUbPKkx8CNvVWerjBw/eYeUJig5Zfu3L
AmTkDZqWgNQr2qIatNTHc5bJRb8xMs3EbWdh4gKOPGuXJ9TtHCJ75tYHsYEzydhR
aQdscpSeBdEGFGHCpoZaitxhOTrMzPpv/YP7WNWU3TwcDlieE5ji4ElFI4wQNEPd
fAxI66IaJOGcatZWVZZPVKGchIqvtXB2e39l2qjbEf6nB6xFMW38bzU7wH5t/W2a
uyNukvS8SoqTnmu9Vl6BYhW0Z942e4Wy2rlVTw23MfWXLPAnT8wnTqluoCHAXLYm
AyUUuERoqSigkXEKHiCt8zCcoXTVb7vUo2GypvadWJBpmqYUM5j/vfM0A8cfWQ4x
D9H+DF0ZuxPBHr5XahLpP9Htrhp0C9DCfMgxvPsezcRiIHkMXMMKzAiXXY6fc7Ur
PVx2U2WjczLLf3x+VIjXpWesbXTnP+Bq4jIGnGA4Ewv+4tuvc71Eu2CgIU1/+XRp
K7sn8DiNqs4rFuRa2dkPbTB12r9iGpFfp5FDtnn+Ptvi1ORR20EWk17R3CfjdE21
yZUvXlbLB3FjewW8JqD0Tq8ozWUfPxcn91Ak9nN9VpcSDgrnlrFxFOKRUoVDK9W6
yd8PApFjvvN+4eLuoi3j
=RHKA
-----END PGP SIGNATURE-----

------enig2XEAODWDQGTOALABDXVSL--


--===============1840599116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1840599116==--
