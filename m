From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Add MIT license header to
	session.xsd
Date: Thu, 10 Apr 2014 15:35:13 -0400
Message-ID: <20140410193513.GC28773__43388.0146280446$1397158700$gmane$org@dalia>
References: <1396885657-8895-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0983217912=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WYKkv-0003S9-AZ
 for lttng-dev@lists.lttng.org; Thu, 10 Apr 2014 15:35:31 -0400
In-Reply-To: <1396885657-8895-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0983217912==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

On 07 Apr (11:47:37), J=E9r=E9mie Galarneau wrote:
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  src/common/config/session.xsd | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/src/common/config/session.xsd b/src/common/config/session.xsd
> index 58068ec..910f070 100644
> --- a/src/common/config/session.xsd
> +++ b/src/common/config/session.xsd
> @@ -1,3 +1,24 @@
> +<!--
> +Copyright (c) 2014 - J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.c=
om>
> +
> +Permission is hereby granted, free of charge, to any person obtaining a =
copy
> +of this software and associated documentation files (the "Software"), to=
 deal
> +in the Software without restriction, including without limitation the ri=
ghts
> +to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> +copies of the Software, and to permit persons to whom the Software is
> +furnished to do so, subject to the following conditions:
> +
> +The above copyright notice and this permission notice shall be included =
in
> +all copies or substantial portions of the Software.
> +
> +THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS =
OR
> +IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> +FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL =
THE
> +AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> +LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING =
FROM,
> +OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> +THE SOFTWARE.
> +-->
>  <?xml version=3D"1.0" encoding=3D"UTF-8"?>
>  <xs:schema xmlns:xs=3D"http://www.w3.org/2001/XMLSchema"
>  elementFormDefault=3D"qualified" version=3D"2.5">
> --=20
> 1.9.1
>=20

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTRvJxXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02yd0H/jOPPQoG63Vy2v9CJVISO62H
rjTe5ukTZ/IQtYh6NFs1zOnDcdz1fODo8ksQr92dkZ61cGQN2kkUJkpmj+WUifRa
szFDEO4MZP4BjqDlYDYu/D//54/JHTpudkA5vbEmlv63rxsfn4wtxH287xGpl4k0
ja6eglZUy6rckqUnlt7xC7gyc6iTUrHEwnBuQ5Sgg6h0XbdCCov00vPyn+4nSOWe
T4syeFOhjQccljIWRC6aBpnXIptlIZZKxwXy59MKYJiO/Jr2zejW53epDF+Bq3mR
HEAiQjvu0L0+kBpdRk5ttEF3y3A314cOY+COFeMi0MutmhnrzpjuL8YN6Du2hug=
=aA5+
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--


--===============0983217912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0983217912==--
