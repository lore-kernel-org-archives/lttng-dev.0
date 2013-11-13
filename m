From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Warn that kernel loglevels
 are unsupported
Date: Wed, 13 Nov 2013 16:59:51 -0500
Message-ID: <20131113215951.GF7694__29843.5391429395$1384380060$gmane$org@dalia>
References: <1384375438-5095-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1645667379=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VgiTf-0004Cd-VZ
	for lttng-dev@lists.lttng.org; Wed, 13 Nov 2013 17:00:05 -0500
In-Reply-To: <1384375438-5095-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1645667379==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ChQOR20MqfxkMJg9"
Content-Disposition: inline


--ChQOR20MqfxkMJg9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

On 13 Nov (15:43:58), J=E9r=E9mie Galarneau wrote:
> Warn the user when the log level option is used when the kernel domain
> is selected. Also, don't show the log level in the confirmation message
> when kernel events are selected.
>=20
> Fixes Bug #645
>=20
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  src/bin/lttng/commands/enable_events.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>=20
> diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/comma=
nds/enable_events.c
> index a7b70c3..2dff63b 100644
> --- a/src/bin/lttng/commands/enable_events.c
> +++ b/src/bin/lttng/commands/enable_events.c
> @@ -346,6 +346,9 @@ static int enable_events(char *session_name)
>  			ret =3D CMD_ERROR;
>  			goto error;
>  		}
> +		if (opt_loglevel) {
> +			WARN("Kernel loglevels are not supported.");
> +		}
>  	}
> =20
>  	/* Create lttng domain */
> @@ -419,7 +422,7 @@ static int enable_events(char *session_name)
> =20
>  			switch (opt_event_type) {
>  			case LTTNG_EVENT_TRACEPOINT:
> -				if (opt_loglevel) {
> +				if (opt_loglevel && dom.type !=3D LTTNG_DOMAIN_KERNEL) {
>  					MSG("All %s tracepoints are enabled in channel %s for loglevel %s",
>  							get_domain_str(dom.type),
>  							print_channel_name(channel_name),
> @@ -428,7 +431,6 @@ static int enable_events(char *session_name)
>  					MSG("All %s tracepoints are enabled in channel %s",
>  							get_domain_str(dom.type),
>  							print_channel_name(channel_name));
> -
>  				}
>  				break;
>  			case LTTNG_EVENT_SYSCALL:
> @@ -438,7 +440,7 @@ static int enable_events(char *session_name)
>  				}
>  				break;
>  			case LTTNG_EVENT_ALL:
> -				if (opt_loglevel) {
> +				if (opt_loglevel && dom.type !=3D LTTNG_DOMAIN_KERNEL) {
>  					MSG("All %s events are enabled in channel %s for loglevel %s",
>  							get_domain_str(dom.type),
>  							print_channel_name(channel_name),
> @@ -533,12 +535,6 @@ static int enable_events(char *session_name)
>  				goto error;
>  			}
> =20
> -			if (opt_loglevel) {
> -				MSG("Kernel loglevels are not supported.");
> -				ret =3D CMD_UNSUPPORTED;
> -				goto error;
> -			}
> -
>  			/* kernel loglevels not implemented */
>  			ev.loglevel_type =3D LTTNG_EVENT_LOGLEVEL_ALL;
>  		} else if (opt_userspace) {		/* User-space tracer action */
> --=20
> 1.8.4.2
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--ChQOR20MqfxkMJg9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJSg/ZXXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02glAH/2MuSBzrb7xuODb421qDZoMC
q3xT2gcwhgQqbUBoyUcbwN5K2pJMFDCbG8IzAymp2ItB+hzNPfTcKd1ah8OAkHKG
/m5XnaG9DLVyw4PT2tCNcNxTNGihoX+p2u6CZ83laU9KylxDqYmhpfk8xkTzYAp3
Yxwd1fJTTrMfuH1aKOnAvgb0U7TZmToPDrxmxoHG6uvqzesUTjCBdJAC1TzVLq5+
dj3I3ylhNN1Zi2PisepBUw7d0WTSke4jXl4kkI0vwvVok7+134/dy7ey9FGfjXQX
78k9RzQzyxDEheMWE9HxgJgAkeaHVbl/eRw7VONDk/b7Pf44dcnTnDQJNxm0Q18=
=dAD0
-----END PGP SIGNATURE-----

--ChQOR20MqfxkMJg9--


--===============1645667379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1645667379==--
