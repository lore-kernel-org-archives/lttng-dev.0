From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: report UST consumer
 channel creation error
Date: Thu, 25 Sep 2014 11:33:58 -0400
Message-ID: <20140925153358.GB23466__23080.6441199549$1411659297$gmane$org@thessa>
References: <1411403948-24108-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0671388662=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XXB3V-0006as-57
 for lttng-dev@lists.lttng.org; Thu, 25 Sep 2014 11:34:06 -0400
In-Reply-To: <1411403948-24108-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0671388662==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

On 22 Sep (12:39:08), Mathieu Desnoyers wrote:
> The session daemon reports no error whatsoever when the consumer daemon
> fails to create a channel. We don't want to print errors when failing to
> send the channel to the UST application though, because the application
> may be concurrently exiting. So only print those errors when receiving
> reply from the consumerd.
>=20
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  src/bin/lttng-sessiond/ust-app.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/us=
t-app.c
> index 4a7fada..f8e9693 100644
> --- a/src/bin/lttng-sessiond/ust-app.c
> +++ b/src/bin/lttng-sessiond/ust-app.c
> @@ -2450,6 +2450,8 @@ static int create_channel_per_uid(struct ust_app *a=
pp,
>  		/* Create the buffer registry channel object. */
>  		ret =3D create_buffer_reg_channel(reg_uid->registry, ua_chan, &reg_cha=
n);
>  		if (ret < 0) {
> +			ERR("Error creating the UST channel \"%s\" registry instance",
> +				ua_chan->name);
>  			goto error;
>  		}
>  		assert(reg_chan);
> @@ -2461,6 +2463,9 @@ static int create_channel_per_uid(struct ust_app *a=
pp,
>  		ret =3D do_consumer_create_channel(usess, ua_sess, ua_chan,
>  				app->bits_per_long, reg_uid->registry->reg.ust);
>  		if (ret < 0) {
> +			ERR("Error creating UST channel \"%s\" on the consumer daemon",
> +				ua_chan->name);
> +
>  			/*
>  			 * Let's remove the previously created buffer registry channel so
>  			 * it's not visible anymore in the session registry.
> @@ -2477,6 +2482,8 @@ static int create_channel_per_uid(struct ust_app *a=
pp,
>  		 */
>  		ret =3D setup_buffer_reg_channel(reg_uid->registry, ua_chan, reg_chan);
>  		if (ret < 0) {
> +			ERR("Error setting up UST channel \"%s\"",
> +				ua_chan->name);
>  			goto error;
>  		}
> =20
> @@ -2485,6 +2492,10 @@ static int create_channel_per_uid(struct ust_app *=
app,
>  	/* Send buffers to the application. */
>  	ret =3D send_channel_uid_to_ust(reg_chan, app, ua_sess, ua_chan);
>  	if (ret < 0) {
> +		/*
> +		 * Don't report error to the console, since it may be
> +		 * caused by application concurrently exiting.
> +		 */
>  		goto error;
>  	}
> =20
> @@ -2519,6 +2530,8 @@ static int create_channel_per_pid(struct ust_app *a=
pp,
>  	/* Create and add a new channel registry to session. */
>  	ret =3D ust_registry_channel_add(registry, ua_chan->key);
>  	if (ret < 0) {
> +		ERR("Error creating the UST channel \"%s\" registry instance",
> +			ua_chan->name);
>  		goto error;
>  	}
> =20
> @@ -2526,11 +2539,17 @@ static int create_channel_per_pid(struct ust_app =
*app,
>  	ret =3D do_consumer_create_channel(usess, ua_sess, ua_chan,
>  			app->bits_per_long, registry);
>  	if (ret < 0) {
> +		ERR("Error creating UST channel \"%s\" on the consumer daemon",
> +			ua_chan->name);
>  		goto error;
>  	}
> =20
>  	ret =3D send_channel_pid_to_ust(app, ua_sess, ua_chan);
>  	if (ret < 0) {
> +		/*
> +		 * Don't report error to the console, since it may be
> +		 * caused by application concurrently exiting.
> +		 */
>  		goto error;
>  	}
> =20
> --=20
> 2.1.0
>=20

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJUJDXmXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02O98H/3rla17tlfh55fWhIFqprG3k
QzyNwB+clO9BIxuqvWY3z0no0XdgZt45+WwIligtMvOmhT8wvD0cP0ZjOlFCv82Z
nuJvzesjTIpnVgyow+eM7R4X6mmEEpwmky5uMg+U76xJfQCfON1NeVmLoKILPFDZ
vVa017BTkdXMi68VVwKEjhk6Yc/uJgQymHHUOhizTsWidET3OE9S8nxLm29K+9eR
I7wU/IcVOk2RslCcqGmPx8wjJGPd/mL5oEDFu5q67LU8pJSPMD4NybkjolpEcr2h
JgLT8EM+Vbwj6XUE3RrZ/nW4ZJO4lnrs4b3YRs0KYsvKUGkwwY/Yg8XfntEW3dQ=
=m/1W
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--


--===============0671388662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0671388662==--
