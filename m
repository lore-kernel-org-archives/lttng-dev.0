From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: replace 1 for true in
 libxml checking
Date: Mon, 14 Apr 2014 10:50:08 -0400
Message-ID: <20140414145008.GB431__38387.0480269708$1397487074$gmane$org@thessa>
References: <20140414144238.GA14396@psrcode-MS-7693>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1743476947=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WZiDE-0001fg-M6
 for lttng-dev@lists.lttng.org; Mon, 14 Apr 2014 10:50:26 -0400
In-Reply-To: <20140414144238.GA14396@psrcode-MS-7693>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1743476947==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

On 14 Apr (10:42:38), Jonathan Rajotte wrote:
> Initial bug on ./configure:
> checking for libxml - version >=3D 2.7.6... yes (version 2.9.1)
> ./configure: line 5137: 1: command not found
>=20
> Signed-off-by: Jonathan Rajotte <jonathan.r.julien@gmail.com>
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index 54f82cf..a8fd7f7 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -147,7 +147,7 @@ AC_CHECK_LIB([popt], [poptGetContext], [],
>  	[AC_MSG_ERROR([Cannot find libpopt. Use [LDFLAGS]=3D-Ldir to specify it=
s location.])]
>  )
> =20
> -AM_PATH_XML2(2.7.6, 1, AC_MSG_ERROR(No supported version of libxml2 foun=
d.))
> +AM_PATH_XML2(2.7.6, true, AC_MSG_ERROR(No supported version of libxml2 f=
ound.))
> =20
>  # Check for libuuid
>  AC_CHECK_LIB([uuid], [uuid_generate],
> --=20
> 1.8.3.2
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTS/WgXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I0235kIAKm3qDuD7s/Qxg0o+cgST8yT
Ff1Z46g+UY8SXY4C8mfFNWF2JuOIhtBKmB2QZMgUuSrCZB60GAtgwId2fLV9iGar
iia+FTAofoXOQIHHhkLKGr8z/Ez/HCQ4+Uj3afneYnS5bVQ0eBOiya6O2UG96tI6
HLKfoT4zIKHhrwwxo6ksq1FHeTGMPwlhy/HpyOoevmvbvFlJiQv7sy3eW98tFClz
2Nbp0cMjf7eW+7Tp3tB0DyZjxITjJhXDScyiGzdurb+3VOG0Qv1cOIZfRMblWu8W
FLYbUyESXvOig3E0Tx5d6SfSRIbvyKD16CNH/CE2VLZf+HOaq7X+a/AeW7y2VWY=
=/EPf
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--


--===============1743476947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1743476947==--
