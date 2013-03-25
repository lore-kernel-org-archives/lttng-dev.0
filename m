From: =?UTF-8?B?UmFwaGHDq2wgQmVhbW9udGU=?= <raphael.beamonte@gmail.com>
Subject: Re: [lttng-tools PATCH] Add a git version information
 in LTTng versions compiled from git sources
Date: Mon, 25 Mar 2013 11:55:42 -0400
Message-ID: <5150737E.6000300__22363.8389179998$1364227005$gmane$org@gmail.com>
References: <51505F7A.7060108@efficios.com>
	<0ab8866c5deb744279d9150823d24203a51851b1.1364226619.git.raphael.beamonte@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0815284242=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <raphael.beamonte@gmail.com>) id 1UK9kY-0008DJ-54
	for lttng-dev@lists.lttng.org; Mon, 25 Mar 2013 11:55:54 -0400
Received: by mail-ie0-f180.google.com with SMTP id a11so7273592iee.39
	for <lttng-dev@lists.lttng.org>; Mon, 25 Mar 2013 08:55:48 -0700 (PDT)
In-Reply-To: <0ab8866c5deb744279d9150823d24203a51851b1.1364226619.git.raphael.beamonte@gmail.com>
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
--===============0815284242==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2HRBUUOCWIAPHHHQJGHGP"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2HRBUUOCWIAPHHHQJGHGP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2013-03-25 10:30, David Goulet wrote:> Hi,
>
> Two things. First, the version.h.tmpl has to be added to EXTRA_DIST in
> include/Makefile.am

Done. And changed the "version.h" to "nodist_*_headers".

> Second thing, on line 86 of lttng.c, *never* *never* *never* pass a
> variable to printf without a format.
>
> fprintf(ofp, lttng_version);
>
> This is a huge vector attack to format strings. Furthermore, outside of=

> the git tree, there is a warning:
>
> lttng.c:86:2: warning: zero-length gnu_printf format string
> [-Wformat-zero-length]

My mistake, forgot to correct that... It's ok in the new patch.

Rapha=C3=ABl


------enig2HRBUUOCWIAPHHHQJGHGP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRUHOCAAoJECV+8Ygg/tEobd4P/jYqshEazlzM+ELFepoTzejv
qOrSozOAkKoFN8STHoI9PiWn40GXMPZPX7vp1AMT8iIMnozTLIf92OB9HqrdxmUE
V4qj/ZiQRNMU8wt4icGcq1YYEi2GVl467kxGJyZMmOVcP24xbPLlkcmLVqsOKWVY
hjPj00MvWjMi03tmr0g9KlXa4uVbwpH0HkcP2UqHremTR1peiSmyeW/5jyuZQVgc
Puzg2bs7z/9S1IKmZlRmC5BlNL1i9AQnV0Q0MVmZdRpS4wIx4ek5Uph8pSD/yu0z
2Y0BP690a6fLoRjiKQpP6Fe3yG0ulTHO+TtkPn5sUfXFOoMe0cn8+WTQ/vln73mV
I8kQlmQO3k9SVem7oEqVDItF6R2mPg8MNjbK0hJ3JYDynDhRsNUj3GL28XrE42hd
G9obXSnPi9hE+9zPlGmllksf+UhZyD4yM8lvXmumkMbg7NI65GQpewSgzUHuKPzD
WmvxopwiqEt7gzcg6I576Nft7w8UkhE5f5Tmgjj0Ive3mrtjWc4htyKw1RxmXGT6
UVPgqRIoNMW/gjskTRmY59aTwyHkeso3xb73N1T/CZz2iu6DnwV/MrCcIUvDbkzK
muylSdMDnDHcxyaPfG/BCW6ygan7VqchVkzHxwoiDxgrnQbl/Q1vGoqmI1kwBCEd
ePIY8JrYXrWYTYMHyi75
=4B/4
-----END PGP SIGNATURE-----

------enig2HRBUUOCWIAPHHHQJGHGP--


--===============0815284242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0815284242==--
