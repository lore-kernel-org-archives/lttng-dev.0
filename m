From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tool] Fix: parse_prob_opts return the
 actual success of the function
Date: Wed, 3 Sep 2014 14:50:47 -0400
Message-ID: <20140903185047.GC1549__22774.8577054173$1409770412$gmane$org@dalia>
References: <1409168817-22679-1-git-send-email-jonathan.r.julien@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0479649831=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XPFdt-00080q-MF
 for lttng-dev@lists.lttng.org; Wed, 03 Sep 2014 14:50:59 -0400
In-Reply-To: <1409168817-22679-1-git-send-email-jonathan.r.julien@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0479649831==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged

On 27 Aug (15:46:57), Jonathan Rajotte Julien wrote:
> This bug have been triggered by the mi merging and the use of a
> command_ret in enable_events functions. Previously, enable_events was
> reusing the ret variable for another operation and always replacing ret.
> Parse_probe_event returned the last output of sscanf which represent
> the number of match and not the success of the operation.
>=20
> Fixes #830
>=20
> Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
> ---
>  src/bin/lttng/commands/enable_events.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>=20
> diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/comma=
nds/enable_events.c
> index f62dadb..3263c58 100644
> --- a/src/bin/lttng/commands/enable_events.c
> +++ b/src/bin/lttng/commands/enable_events.c
> @@ -247,26 +247,27 @@ static void usage(FILE *ofp)
>   */
>  static int parse_probe_opts(struct lttng_event *ev, char *opt)
>  {
> -	int ret;
> +	int ret =3D CMD_SUCCESS;
> +	int match;
>  	char s_hex[19];
>  #define S_HEX_LEN_SCANF_IS_A_BROKEN_API "18"	/* 18 is (19 - 1) (\0 is ex=
tra) */
>  	char name[LTTNG_SYMBOL_NAME_LEN];
> =20
>  	if (opt =3D=3D NULL) {
> -		ret =3D -1;
> +		ret =3D CMD_ERROR;
>  		goto end;
>  	}
> =20
>  	/* Check for symbol+offset */
> -	ret =3D sscanf(opt, "%" LTTNG_SYMBOL_NAME_LEN_SCANF_IS_A_BROKEN_API
> +	match =3D sscanf(opt, "%" LTTNG_SYMBOL_NAME_LEN_SCANF_IS_A_BROKEN_API
>  			"[^'+']+%" S_HEX_LEN_SCANF_IS_A_BROKEN_API "s", name, s_hex);
> -	if (ret =3D=3D 2) {
> +	if (match =3D=3D 2) {
>  		strncpy(ev->attr.probe.symbol_name, name, LTTNG_SYMBOL_NAME_LEN);
>  		ev->attr.probe.symbol_name[LTTNG_SYMBOL_NAME_LEN - 1] =3D '\0';
>  		DBG("probe symbol %s", ev->attr.probe.symbol_name);
>  		if (*s_hex =3D=3D '\0') {
>  			ERR("Invalid probe offset %s", s_hex);
> -			ret =3D -1;
> +			ret =3D CMD_ERROR;
>  			goto end;
>  		}
>  		ev->attr.probe.offset =3D strtoul(s_hex, NULL, 0);
> @@ -277,9 +278,9 @@ static int parse_probe_opts(struct lttng_event *ev, c=
har *opt)
> =20
>  	/* Check for symbol */
>  	if (isalpha(name[0])) {
> -		ret =3D sscanf(opt, "%" LTTNG_SYMBOL_NAME_LEN_SCANF_IS_A_BROKEN_API "s=
",
> +		match =3D sscanf(opt, "%" LTTNG_SYMBOL_NAME_LEN_SCANF_IS_A_BROKEN_API =
"s",
>  			name);
> -		if (ret =3D=3D 1) {
> +		if (match =3D=3D 1) {
>  			strncpy(ev->attr.probe.symbol_name, name, LTTNG_SYMBOL_NAME_LEN);
>  			ev->attr.probe.symbol_name[LTTNG_SYMBOL_NAME_LEN - 1] =3D '\0';
>  			DBG("probe symbol %s", ev->attr.probe.symbol_name);
> @@ -291,11 +292,11 @@ static int parse_probe_opts(struct lttng_event *ev,=
 char *opt)
>  	}
> =20
>  	/* Check for address */
> -	ret =3D sscanf(opt, "%" S_HEX_LEN_SCANF_IS_A_BROKEN_API "s", s_hex);
> -	if (ret > 0) {
> +	match =3D sscanf(opt, "%" S_HEX_LEN_SCANF_IS_A_BROKEN_API "s", s_hex);
> +	if (match > 0) {
>  		if (*s_hex =3D=3D '\0') {
>  			ERR("Invalid probe address %s", s_hex);
> -			ret =3D -1;
> +			ret =3D CMD_ERROR;
>  			goto end;
>  		}
>  		ev->attr.probe.addr =3D strtoul(s_hex, NULL, 0);
> @@ -306,7 +307,7 @@ static int parse_probe_opts(struct lttng_event *ev, c=
har *opt)
>  	}
> =20
>  	/* No match */
> -	ret =3D -1;
> +	ret =3D CMD_ERROR;
> =20
>  end:
>  	return ret;
> @@ -906,7 +907,7 @@ static int enable_events(char *session_name)
>  				break;
>  			case LTTNG_EVENT_PROBE:
>  				ret =3D parse_probe_opts(&ev, opt_probe);
> -				if (ret < 0) {
> +				if (ret) {
>  					ERR("Unable to parse probe options");
>  					ret =3D 0;
>  					goto error;
> @@ -914,7 +915,7 @@ static int enable_events(char *session_name)
>  				break;
>  			case LTTNG_EVENT_FUNCTION:
>  				ret =3D parse_probe_opts(&ev, opt_function);
> -				if (ret < 0) {
> +				if (ret) {
>  					ERR("Unable to parse function probe options");
>  					ret =3D 0;
>  					goto error;
> --=20
> 2.0.4
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJUB2MHXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I026hIIAMgyTtKsHMYF/ifdvy8ehUvV
zaPIOtaY0bcf3Q0qnkZjA+EjEnAETuQ40OAOYlBIIHBA+AcjbmECsFF4Lf/Oyx9R
90g2OZqsCkVeUdvWZie8OFXrKtuxBf3UXBr65o7iVfWgPDSzBrOykSktWKnveLNb
XgTQZ490RWqoz60UGSFTu7/4UM1bw97+/c0RJ17pp2193rh1UGAfb6RRhhlMge9/
JR1rR9O0PhLoERJvqPXZ8iSfwwfF237PAVX7F7Ft51TCEfKLF/d4rpoQ2Or0TX4U
kdLucb5BDMurwYmn3rCpZbaGmkno0/SE07Rs4XqfzuZ1eyiArP9SCUMlj46NS8k=
=2Btu
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--


--===============0479649831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0479649831==--
