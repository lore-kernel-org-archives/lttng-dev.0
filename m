From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tool] Fix: missing context type string
 in save for ust context
Date: Thu, 12 Jun 2014 14:03:15 -0400
Message-ID: <20140612180315.GE8011__42676.2727242478$1402596356$gmane$org@thessa>
References: <1402343139-32428-1-git-send-email-jonathan.r.julien@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1882238723=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1Wv9LN-0001oD-Dm
 for lttng-dev@lists.lttng.org; Thu, 12 Jun 2014 14:03:23 -0400
In-Reply-To: <1402343139-32428-1-git-send-email-jonathan.r.julien@gmail.com>
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


--===============1882238723==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WK3l2KTTmXPVedZ6"
Content-Disposition: inline


--WK3l2KTTmXPVedZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

On 09 Jun (15:45:39), Jonathan Rajotte Julien wrote:
> Return string for LTTNG_UST_CONTEXT_PERF_THREAD_COUNTER was missing and
> caused an error on save when a context of PERF_THREAD_COUNTER type was
> present (Error: Invalid parameter).
>=20
> Fixes #804
>=20
> Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
> ---
>  src/bin/lttng-sessiond/save.c          | 4 ++++
>  src/common/config/config-session-abi.h | 1 +
>  src/common/config/config.c             | 1 +
>  3 files changed, 6 insertions(+)
>=20
> diff --git a/src/bin/lttng-sessiond/save.c b/src/bin/lttng-sessiond/save.c
> index 18d303c..8afdbb5 100644
> --- a/src/bin/lttng-sessiond/save.c
> +++ b/src/bin/lttng-sessiond/save.c
> @@ -258,8 +258,12 @@ const char *get_ust_context_type_string(
>  	case LTTNG_UST_CONTEXT_PTHREAD_ID:
>  		context_type_string =3D config_event_context_pthread_id;
>  		break;
> +	case LTTNG_UST_CONTEXT_PERF_THREAD_COUNTER:
> +		context_type_string =3D config_event_context_perf_thread_counter;
> +		break;
>  	default:
>  		context_type_string =3D NULL;
> +		break;
>  	}
> =20
>  	return context_type_string;
> diff --git a/src/common/config/config-session-abi.h b/src/common/config/c=
onfig-session-abi.h
> index 3c51883..0efd391 100644
> --- a/src/common/config/config-session-abi.h
> +++ b/src/common/config/config-session-abi.h
> @@ -106,5 +106,6 @@ const char * const config_event_context_vppid;
>  const char * const config_event_context_pthread_id;
>  const char * const config_event_context_hostname;
>  const char * const config_event_context_ip;
> +const char * const config_event_context_perf_thread_counter;
> =20
>  #endif /* CONFIG_SESSION_INTERNAL_H */
> diff --git a/src/common/config/config.c b/src/common/config/config.c
> index cdc044d..4d855bf 100644
> --- a/src/common/config/config.c
> +++ b/src/common/config/config.c
> @@ -154,6 +154,7 @@ const char * const config_event_context_vppid =3D "VP=
PID";
>  const char * const config_event_context_pthread_id =3D "PTHREAD_ID";
>  const char * const config_event_context_hostname =3D "HOSTNAME";
>  const char * const config_event_context_ip =3D "IP";
> +const char * const config_event_context_perf_thread_counter =3D "PERF_TH=
READ_COUNTER";
> =20
>  struct consumer_output {
>  	int enabled;
> --=20
> 2.0.0
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--WK3l2KTTmXPVedZ6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTmetjXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02H0cH/0j5YMID5uz69YYrIvn4L/9E
lLDBw8iH2f85J65Pxwyoz0SlD8vhqZYHlf8zp27cAqrq4XUe3Ex0S5kZyBrk9GXm
StcwRWvQNK713IeVtJQ4tT7rPEKYqaieUoUkj+7D8iHaMCl16EymPX9C4jmFsstk
DDEPIXLexLTTKb8Uc+ZmfQfcZTvw2IFzIWGL0jsB4fiks8uOmCVPBzruBJvfjFPc
WXiFmgencWTKRatCxXxlY7qfvrdewoujbY1AZH0CLslO2y44BsdVvtfAGwHcQjMF
kffR29HWIfGsVZLRsgcPPGi1DZ9mPXZc/KK3wNfhJ3/PyA+TUsabVUWo0aqfO68=
=yn/1
-----END PGP SIGNATURE-----

--WK3l2KTTmXPVedZ6--


--===============1882238723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1882238723==--
