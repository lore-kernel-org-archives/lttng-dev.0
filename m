From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Don't output to stdout
	from lttng-ctl
Date: Wed, 7 May 2014 14:41:34 -0400
Message-ID: <20140507184134.GF8212__19741.4033850238$1399488164$gmane$org@thessa>
References: <1399487265-21097-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0790787689=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1Wi6mp-0007Xy-7B
 for lttng-dev@lists.lttng.org; Wed, 07 May 2014 14:41:52 -0400
In-Reply-To: <1399487265-21097-1-git-send-email-jeremie.galarneau@efficios.com>
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


--===============0790787689==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7cm2iqirTL37Ot+N"
Content-Disposition: inline


--7cm2iqirTL37Ot+N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

On 07 May (14:27:45), J=E9r=E9mie Galarneau wrote:
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  src/bin/lttng/commands/stop.c | 29 ++++++++++++++++++++++++-----
>  src/lib/lttng-ctl/lttng-ctl.c |  7 -------
>  2 files changed, 24 insertions(+), 12 deletions(-)
>=20
> diff --git a/src/bin/lttng/commands/stop.c b/src/bin/lttng/commands/stop.c
> index 60a1dac..cb45f12 100644
> --- a/src/bin/lttng/commands/stop.c
> +++ b/src/bin/lttng/commands/stop.c
> @@ -79,11 +79,7 @@ static int stop_tracing(void)
>  		session_name =3D opt_session_name;
>  	}
> =20
> -	if (opt_no_wait) {
> -		ret =3D lttng_stop_tracing_no_wait(session_name);
> -	} else {
> -		ret =3D lttng_stop_tracing(session_name);
> -	}
> +	ret =3D lttng_stop_tracing_no_wait(session_name);
>  	if (ret < 0) {
>  		switch (-ret) {
>  		case LTTNG_ERR_TRACE_ALREADY_STOPPED:
> @@ -96,6 +92,29 @@ static int stop_tracing(void)
>  		goto free_name;
>  	}
> =20
> +	if (!opt_no_wait) {
> +		_MSG("Waiting for data availability");
> +		fflush(stdout);
> +		do {
> +			ret =3D lttng_data_pending(session_name);
> +			if (ret < 0) {
> +				/* Return the data available call error. */
> +				goto error;
> +			}
> +
> +			/*
> +			 * Data sleep time before retrying (in usec). Don't sleep if the call
> +			 * returned value indicates availability.
> +			 */
> +			if (ret) {
> +				usleep(DEFAULT_DATA_AVAILABILITY_WAIT_TIME);
> +				_MSG(".");
> +				fflush(stdout);
> +			}
> +		} while (ret !=3D 0);
> +		MSG("");
> +	}
> +
>  	ret =3D CMD_SUCCESS;
> =20
>  	MSG("Tracing stopped for session %s", session_name);
> diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
> index 756fd6b..272c702 100644
> --- a/src/lib/lttng-ctl/lttng-ctl.c
> +++ b/src/lib/lttng-ctl/lttng-ctl.c
> @@ -579,9 +579,6 @@ static int _lttng_stop_tracing(const char *session_na=
me, int wait)
>  		goto end;
>  	}
> =20
> -	_MSG("Waiting for data availability");
> -	fflush(stdout);
> -
>  	/* Check for data availability */
>  	do {
>  		data_ret =3D lttng_data_pending(session_name);
> @@ -597,13 +594,9 @@ static int _lttng_stop_tracing(const char *session_n=
ame, int wait)
>  		 */
>  		if (data_ret) {
>  			usleep(DEFAULT_DATA_AVAILABILITY_WAIT_TIME);
> -			_MSG(".");
> -			fflush(stdout);
>  		}
>  	} while (data_ret !=3D 0);
> =20
> -	MSG("");
> -
>  end:
>  error:
>  	return ret;
> --=20
> 1.9.2
>=20

--7cm2iqirTL37Ot+N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTan5eXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02FzwH/1GhzWUiAzbgfmD9xU/mm6eL
zQ23YAIt7vxch3pcM5XtgM5JTasn7F0HIoP39DgTg1Ijxp3iAlDX3vE6BUGS+Hty
stW9wbEaHLV/52FZziigzKcM/XkQ0AzzGiI06yJa/5bGufnjnu5X8ABYDUdz+Jar
1U/2J8QuGkBa0OGiywjqesdXpaGa2S7AZeQF/rwS1oPaai480lNQBjocW+6d/0Ah
9hby0I5BB+9ifqg+NPOLE3lBVZKY/5ENZVb3/cLEjk8rAHJDAjT3t/BwdL5P4jiK
7wS6hXkPwVjnjFU1gma42AI+FBf+6IN7nPOsoyKE4msKscfk9xEdYaCsIM4BzVM=
=d/+e
-----END PGP SIGNATURE-----

--7cm2iqirTL37Ot+N--


--===============0790787689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0790787689==--
