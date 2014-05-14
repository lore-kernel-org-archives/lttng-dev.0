From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Docs: Add a section documenting
 lttng-sessiond's -l/--load option
Date: Wed, 14 May 2014 13:47:25 -0400
Message-ID: <20140514174725.GJ17172__28474.4940851398$1400089744$gmane$org@thessa>
References: <1400089566-22198-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0068061160=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ns236805.ip-192-99-35.net ([192.99.35.19]
 helo=smtp.ini-tech.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WkdHE-00033U-Pk
 for lttng-dev@lists.lttng.org; Wed, 14 May 2014 13:47:42 -0400
In-Reply-To: <1400089566-22198-1-git-send-email-jeremie.galarneau@efficios.com>
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


--===============0068061160==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KjX7LgAomYr70Ka9"
Content-Disposition: inline


--KjX7LgAomYr70Ka9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

On 14 May (13:46:06), J=E9r=E9mie Galarneau wrote:
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  doc/man/lttng-sessiond.8 | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/doc/man/lttng-sessiond.8 b/doc/man/lttng-sessiond.8
> index 633cf81..e6e37a0 100644
> --- a/doc/man/lttng-sessiond.8
> +++ b/doc/man/lttng-sessiond.8
> @@ -116,6 +116,9 @@ Specify path for the 64-bit UST consumer daemon binary
>  .TP
>  .BR "    --consumerd64-libdir=3DPATH
>  Specify path for the 64-bit UST consumer daemon libraries
> +.TP
> +.BR "-l, --load PATH
> +Specify path from which to load session configurations
>  .SH "ENVIRONMENT VARIABLES"
> =20
>  .PP
> --=20
> 1.9.2
>=20

--KjX7LgAomYr70Ka9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTc6wtXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02WMkH/jZhcP9Wn4ykQzppjS+KrOyJ
K+nP+tFSqbLzGlPPg4qHW5pREQJfmu8fr2lTLP+s8O9HEgQEHOBi/oNqajNUhbn0
+rlOZyHCt5zpsKQ88X7cbRKLQI9yQSFHWEtwfGGt8ZMR78gpxzJ0/uU9wR7QE6S8
LaxjMRAlemxzpjsR+ufEHzzIrxo1jwzQ832XaEkalbZl+p2OYymuCLMgzvoJvJbc
iCpe0F0zbjEgSzwUJxspRphkXQ72FJpYTX5lqT+AxRvzW+AttL8oyWEeID5NGPAp
hyE28E8BoYDJ5bNaLlaW4FIkdDhwY6psjPTjx14jAgKKD7Y/zm5ojmeCBkaoo+M=
=HLvt
-----END PGP SIGNATURE-----

--KjX7LgAomYr70Ka9--


--===============0068061160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0068061160==--
