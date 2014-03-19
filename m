From: dgoulet@efficios.com
Subject: Re: [PATCH lttng-tools] Fix: Remove overly restrictive
 asserts in create_session()
Date: Wed, 19 Mar 2014 13:28:28 -0400
Message-ID: <20140319172828.GB21645__14212.8104031601$1395250155$gmane$org@thessa>
References: <1395242726-31883-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1516076676=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WQKI9-00074E-2i
	for lttng-dev@lists.lttng.org; Wed, 19 Mar 2014 13:28:41 -0400
In-Reply-To: <1395242726-31883-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie_Galarneau_=3Cjeremie=2Egalarneau=40efficios?=@smtp.ini-tech.com, =?iso-8859-1?B?LmNvbT4=?=@smtp.ini-tech.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1516076676==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged and the two subsequent fixes also!

David

On 19 Mar (11:25:26), J=E9r=E9mie Galarneau wrote:
> The current assertions only allow sessions containing all three
> domain types to be created. The pointers are already checked at
> ln 1242.
>=20
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  src/common/config/config.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/src/common/config/config.c b/src/common/config/config.c
> index a890c9d..13af2f1 100644
> --- a/src/common/config/config.c
> +++ b/src/common/config/config.c
> @@ -1186,9 +1186,6 @@ int create_session(const char *name,
>  	xmlNodePtr consumer_output_node;
> =20
>  	assert(name);
> -	assert(kernel_domain);
> -	assert(ust_domain);
> -	assert(jul_domain);
> =20
>  	if (output_node) {
>  		consumer_output_node =3D xmlFirstElementChild(output_node);
> --=20
> 1.9.0
>=20

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTKdO8XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02UCEIAJIRyTrBOmXMgkAh5NrO4/2I
Ge1cf7nz4azm1ppnR3fE4q27ScTYDNX7dLCwbgmvtX+h4KjhaJFW/Cdc02Oo3+Xf
MUJEJGsVNvxg6GARctGPgN6KLibCiYpmvCrcxAiCLWNs2J4QAYV8dtYVeSvpnDh/
hQB9Qev19giaS6a+A6bec9uUldpMidB95rB1w4p56EVl8WIQA8F7vzm5kVbO3zfJ
eTfv9onP/NifFLPEHxB36eozzF5vvoDE+i3mmXYuV80ALE5nUoRf6nTTbDcO+5UF
fXPcwIpm/vbvySdit8nV6O7q5V64NQKp2jxPhxNBvqEjczsPml364OWOyiUr35I=
=xor4
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--


--===============1516076676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1516076676==--
