From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2] Override the session.xsd
 path with an environment variable
Date: Mon, 14 Apr 2014 10:34:58 -0400
Message-ID: <20140414143458.GC9369__25431.1212142513$1397486178$gmane$org@thessa>
References: <1397188683-25626-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1964568707=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WZhyZ-0001TN-Mx
 for lttng-dev@lists.lttng.org; Mon, 14 Apr 2014 10:35:17 -0400
In-Reply-To: <1397188683-25626-1-git-send-email-jeremie.galarneau@efficios.com>
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


--===============1964568707==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10 Apr (23:58:02), J=E9r=E9mie Galarneau wrote:
> The LTTNG_SESSION_CONFIG_XSD_PATH environment variable can be used
> to specify a path which contains the session configuration schema.
> This will allow save-load tests to be ran without installing
> the XSD on the system.
>=20
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  src/common/config/config.c | 37 ++++++++++++++++++++++++++++++++++++-
>  src/common/defaults.h      |  6 +++---
>  2 files changed, 39 insertions(+), 4 deletions(-)
>=20
> diff --git a/src/common/config/config.c b/src/common/config/config.c
> index e61791b..143e6f0 100644
> --- a/src/common/config/config.c
> +++ b/src/common/config/config.c
> @@ -569,12 +569,46 @@ void fini_session_config_validation_ctx(
>  }
> =20
>  static
> +char *get_session_config_xsd_path()
> +{
> +	char *xsd_path;
> +	const char *base_path =3D getenv(DEFAULT_SESSION_CONFIG_XSD_PATH_ENV);
> +	size_t base_path_len;
> +
> +	if (!base_path) {
> +		base_path =3D DEFAULT_SESSION_CONFIG_XSD_PATH;
> +	}
> +
> +	base_path_len =3D strlen(base_path);
> +	xsd_path =3D malloc(base_path_len +
> +		sizeof(DEFAULT_SESSION_CONFIG_XSD_FILENAME) + 1);
> +	if (!xsd_path) {
> +		goto end;
> +	}
> +
> +	strcpy(xsd_path, base_path);

strncpy() please, I won't accept patches with dangerous libc calls that
should burn in HELL! :P

> +	if (xsd_path[base_path_len - 1] !=3D '/') {
> +		xsd_path[base_path_len++] =3D '/';
> +	}
> +
> +	strcpy(xsd_path + base_path_len, DEFAULT_SESSION_CONFIG_XSD_FILENAME);

Same.

Cheers!
David

> +end:
> +	return xsd_path;
> +}
> +
> +static
>  int init_session_config_validation_ctx(
>  	struct session_config_validation_ctx *ctx)
>  {
>  	int ret;
> +	char *xsd_path =3D get_session_config_xsd_path();
> +
> +	if (!xsd_path) {
> +		ret =3D -LTTNG_ERR_NOMEM;
> +		goto end;
> +	}
> =20
> -	ctx->parser_ctx =3D xmlSchemaNewParserCtxt(DEFAULT_SESSION_CONFIG_XSD_P=
ATH);
> +	ctx->parser_ctx =3D xmlSchemaNewParserCtxt(xsd_path);
>  	if (!ctx->parser_ctx) {
>  		ERR("XSD parser context creation failed");
>  		ret =3D -LTTNG_ERR_LOAD_INVALID_CONFIG;
> @@ -606,6 +640,7 @@ end:
>  		fini_session_config_validation_ctx(ctx);
>  	}
> =20
> +	free(xsd_path);
>  	return ret;
>  }
> =20
> diff --git a/src/common/defaults.h b/src/common/defaults.h
> index 7acabf1..de61064 100644
> --- a/src/common/defaults.h
> +++ b/src/common/defaults.h
> @@ -125,9 +125,9 @@
>  #define DEFAULT_SESSION_SYSTEM_CONFIGPATH       DEFAULT_SYSTEM_CONFIGPAT=
H "/" \
>  	DEFAULT_SESSION_PATH
>  #define DEFAULT_SESSION_CONFIG_FILE_EXTENSION   ".lttng"
> -#define DEFAULT_SESSION_CONFIG_XSD_PATH         CONFIG_LTTNG_SYSTEM_DATA=
DIR \
> -	"/xml/lttng/session.xsd"
> -
> +#define DEFAULT_SESSION_CONFIG_XSD_FILENAME     "session.xsd"
> +#define DEFAULT_SESSION_CONFIG_XSD_PATH         CONFIG_LTTNG_SYSTEM_DATA=
DIR "/xml/lttng/"
> +#define DEFAULT_SESSION_CONFIG_XSD_PATH_ENV     "LTTNG_SESSION_CONFIG_XS=
D_PATH"
> =20
>  #define DEFAULT_GLOBAL_APPS_UNIX_SOCK \
>  	DEFAULT_LTTNG_RUNDIR "/" LTTNG_UST_SOCK_FILENAME
> --=20
> 1.9.2
>=20

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTS/ISXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I023jsH/38ymEO0bRSerhI+Da8gmO5L
ayKzXW8CLgIw9OhTHZVDlW26M+lyS0+kTPMJQkekhCBoAOyCD93TE3huPZpH2NOx
x2nLNq5s3suL1KkSgVvsrvPPFSIsM0SysNEafjbAnqZsjAidLTtbaGvLwo3g25xV
Eaj2793d5xNxWsviyrFpjwnvcbj+NAYJ9VssQt7PTTlXTqZHvK1nc40C4C2wiyI/
lUomPtHcP0mFwDRvYRCknbTU2XAQa60jRgr9OAR21VWPrC2t+Mell3wDBEhEnBuK
IfHsVjTr702XLDmFD8spAe6ELkZLCMWEmc1mdQ5niiGjjAikRccQj8UfgV9TdVk=
=uG4/
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--


--===============1964568707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1964568707==--
