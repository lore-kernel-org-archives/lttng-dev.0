From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Don't report an error if
 no sessions are found with default options
Date: Mon, 12 May 2014 10:17:53 -0400
Message-ID: <20140512141753.GA7350__20192.8899194629$1399904354$gmane$org@thessa>
References: <1399565548-25453-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0789932641=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ns236805.ip-192-99-35.net ([192.99.35.19]
 helo=smtp.ini-tech.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1Wjr3L-0004Bq-Nf
 for lttng-dev@lists.lttng.org; Mon, 12 May 2014 10:18:09 -0400
In-Reply-To: <1399565548-25453-1-git-send-email-jeremie.galarneau@efficios.com>
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


--===============0789932641==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

And all three other fixes that followed this one:

Print an error message when a session fails to load
Fix: Possible out-of-bounds read
Fix: Ressource leak, missing fclose

Cheers!
David

On 08 May (12:12:28), J=E9r=E9mie Galarneau wrote:
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  src/common/config/config.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/src/common/config/config.c b/src/common/config/config.c
> index 8b34d02..df6f6a3 100644
> --- a/src/common/config/config.c
> +++ b/src/common/config/config.c
> @@ -2544,5 +2544,12 @@ int config_load_session(const char *path, const ch=
ar *session_name,
>  	}
>  end:
>  	fini_session_config_validation_ctx(&validation_ctx);
> +	if (ret =3D=3D -LTTNG_ERR_LOAD_SESSION_NOENT && !session_name && !path)=
 {
> +		/*
> +		 * Don't report an error if no sessions are found when called
> +		 * without a session_name or a search path.
> +		 */
> +		ret =3D 0;
> +	}
>  	return ret;
>  }
> --=20
> 1.9.2
>=20

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTcNgRXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02VScH/1oEMefhGizEImIJIdg89BQC
dJR2IABA60WwBf4e/aByqIqNg0vhiNxzsJTfo7owSibXdztXOBEeZcxOcesv1awg
vCNUf2jDP2B7BhpUBAmhBnYGoFmy/ojv6HGKBYayzf45/BlxacU8ukHg1+a9faQX
KrU+8WT/qx3o0sESe/P3Oi/vpYnXUi157dCTsREFvFGrivUz/zHYnW7pqr1FGN82
iRIl70eMW4KdZt/kRpGsKQb4cdfG6DkQJ9LBKuGEPNeaSkDffYgVpy3/XVV1FHEo
BpPiedB5O/NskSRZO00qNMzAWe7auFkuaBF5ORIR0ZWYRt68QnS8pF/Lwmqq+OM=
=aK55
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--


--===============0789932641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0789932641==--
