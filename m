From: =?UTF-8?B?UmFwaGHDq2wgQmVhbW9udGU=?= <raphael.beamonte@gmail.com>
Subject: Re: [lttng-tools PATCH] Add a git version information
 in LTTng versions compiled from git sources
Date: Fri, 15 Mar 2013 14:44:05 -0400
Message-ID: <51436BF5.4000501__34753.0600884513$1363373106$gmane$org@gmail.com>
References: <51421C12.5050907@gmail.com>
	<2f2984a90ab0b25a5b9e6259060fdd6c5c7bb00a.1363372839.git.raphael.beamonte@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0345899571=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <raphael.beamonte@gmail.com>) id 1UGZc2-0003dW-9C
	for lttng-dev@lists.lttng.org; Fri, 15 Mar 2013 14:44:18 -0400
Received: by mail-ia0-f171.google.com with SMTP id z13so3527386iaz.30
	for <lttng-dev@lists.lttng.org>; Fri, 15 Mar 2013 11:44:12 -0700 (PDT)
In-Reply-To: <2f2984a90ab0b25a5b9e6259060fdd6c5c7bb00a.1363372839.git.raphael.beamonte@gmail.com>
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
--===============0345899571==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2GJGOJVXIQWVCKBSGOJLW"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2GJGOJVXIQWVCKBSGOJLW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2013-03-15 14:40, Rapha=C3=ABl Beamonte wrote:
> Signed-off-by: Rapha=C3=ABl Beamonte <raphael.beamonte@gmail.com>
> ---
>  .gitignore                              |    2 ++
>  include/Makefile.am                     |   26 +++++++++++++++++++++++=
++-
>  include/version.h.tmpl                  |   27 +++++++++++++++++++++++=
++++
>  src/bin/lttng-sessiond/lttng-sessiond.h |   14 ++++++++++++++
>  src/bin/lttng-sessiond/main.c           |    2 +-
>  src/bin/lttng/commands/version.c        |    4 +++-
>  src/bin/lttng/lttng.c                   |    5 ++++-
>  src/bin/lttng/utils.h                   |   13 +++++++++++++
>  8 files changed, 89 insertions(+), 4 deletions(-)
>  create mode 100644 include/version.h.tmpl

This new version of the patch should answer to your last comments. Feel
free to give new comments and critics !

I just wasn't able to check the "make dist" as it seems broken in the
last commit of lttng-tools.

Rapha=C3=ABl


------enig2GJGOJVXIQWVCKBSGOJLW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQ2v6AAoJECV+8Ygg/tEowssP/3Gjm687ln2gusHtQF9WpAwc
J/ioi8eRkn0Gnub2/hYO77yCfMCWeZFu1PeVGNfbebNysffTTqREEanY9VakrYb4
GDtKmqZb/p4KgaUjQSN5K32zhWPRg3XorAyWmvSAS8e5kh0f6CDRRLQs1Sjkbjsp
LhPrYT2x0wWnEjqEqALUxa88lQZmiOUnkHHwSInX2z6pm+fJyxcTr1bVE2gmotzt
l9W77+dVmEgFF1tc9DRErowKb0iTKqZVCNrqEppF9o721gvZq4g6rwodtpAjryIh
j7/p7735PHxZYP0hy69zfYKN9VvdtxZ7j97UiMQTePExF7kUjhpVxssXEI4Uz8Lv
8ESEJv7/qg0rTHeYA5ild5QqICdfOK3pIhBFyf+VVTCgQKg6WZqiemLwK62B+V+l
7tikDkHKJDYsXCZjI7psTPUOZRVguuFYKnOO+da8LAuv+l1etDGHbCL6ng6XzYuE
YIAE4rWzBUQ36IMT2fdjdBs3k4CjetufzuAkMWQvGPsTTZ2XOokctD/o4gnNVHFj
J1xQcJWjAmjkHkssuLdjBVhFqwCuEhfHmkdHisn6RXm5T+P5rgqP2I/BQzZI7PtS
oU7Mi6caiMsINyK3L0i/Oly87MAaqL256DWGRzg9iyYynQkwkCjELjSoW566C39O
iiGS5ltnhAvPrfhoJOxQ
=6OP4
-----END PGP SIGNATURE-----

------enig2GJGOJVXIQWVCKBSGOJLW--


--===============0345899571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0345899571==--
