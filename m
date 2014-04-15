From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Better error reporting when a
 snapshot record size is too small
Date: Tue, 15 Apr 2014 10:44:08 -0400
Message-ID: <20140415144408.GB7829__28914.2238478691$1397573124$gmane$org@thessa>
References: <1397572329-7168-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0924110461=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1Wa4az-0001la-1p
 for lttng-dev@lists.lttng.org; Tue, 15 Apr 2014 10:44:27 -0400
In-Reply-To: <1397572329-7168-1-git-send-email-jeremie.galarneau@efficios.com>
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


--===============0924110461==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15 Apr (10:32:09), J=E9r=E9mie Galarneau wrote:
> Print an error message when a snapshot record is made with a
> max size smaller than the subbuffers. This limitation is now
> documented in the man page.

Why is this not done on the session daemon side? Like "Oh you provided
me with a wrong max size" type of error message.

Because here this fixes the issue only on the command line side but a
user using the API would still fail somehow silently or ... ?

Not that I don't like the approach here but I just need to know if there
is a specific reason it's done on the lttng client side only. This patch
adds two calls that can exchange quite a bit of data with the sessiond
(list domains and channels) so unless there is no other way, I would go
for a sessiond side validation instead.

Cheers!
David

>=20
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  doc/man/lttng.1                   |  4 ++-
>  src/bin/lttng/commands/snapshot.c | 59 +++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 62 insertions(+), 1 deletion(-)
>=20
> diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
> index 972f71c..bf1b67e 100644
> --- a/doc/man/lttng.1
> +++ b/doc/man/lttng.1
> @@ -787,7 +787,9 @@ List the output of a session. Attributes of the outpu=
t are printed.
>  Snapshot a session's buffer(s) for all domains. If an URL is specified, =
it is
>  used instead of a previously added output. Specifying only a name or/and=
 a max
>  size will override the current output values. For instance, you can reco=
rd a
> -snapshot with a custom maximum size or with a different name.
> +snapshot with a custom maximum size or with a different name. However, t=
he
> +max size must be high enough to contain a complete subbuffer. See the
> +--subbuf-size switch for default subbuffer sizes.
> =20
>  .nf
>  $ lttng snapshot add-output -n mysnapshot file:///data/snapshot
> diff --git a/src/bin/lttng/commands/snapshot.c b/src/bin/lttng/commands/s=
napshot.c
> index c704eee..7fda949 100644
> --- a/src/bin/lttng/commands/snapshot.c
> +++ b/src/bin/lttng/commands/snapshot.c
> @@ -125,6 +125,56 @@ static int count_arguments(const char **argv)
>  	return i;
>  }
> =20
> +static uint64_t get_largest_subbuf()
> +{
> +	int domain_count;
> +	int channel_count;
> +	int domain_idx;
> +	int channel_idx;
> +	struct lttng_domain *domains;
> +	uint64_t largest_subbuf =3D 0;
> +
> +	domain_count =3D lttng_list_domains(current_session_name, &domains);
> +	if (domain_count < 0) {
> +		ERR("Unable to list session %s's domains",
> +			current_session_name);
> +		goto end;
> +	}
> +
> +	for (domain_idx =3D 0; domain_idx < domain_count; domain_idx++) {
> +		struct lttng_channel *channels;
> +		struct lttng_handle *handle =3D lttng_create_handle(
> +			current_session_name, &domains[domain_idx]);
> +
> +		if (!handle) {
> +			ERR("Unable to create handle for session %s",
> +				current_session_name);
> +			goto end;
> +		}
> +
> +		channel_count =3D lttng_list_channels(handle, &channels);
> +		if (channel_count < 0) {
> +			ERR("Unable to list channels for session %s",
> +				current_session_name);
> +			goto end;
> +		}
> +
> +		for (channel_idx =3D 0; channel_idx < channel_count;
> +			channel_idx++) {
> +			if (channels[channel_idx].attr.subbuf_size >
> +				largest_subbuf) {
> +				largest_subbuf =3D
> +					channels[channel_idx].attr.subbuf_size;
> +			}
> +		}
> +		free(channels);
> +		lttng_destroy_handle(handle);
> +	}
> +end:
> +	free(domains);
> +	return largest_subbuf;
> +}
> +
>  /*
>   * Create a snapshot output object from arguments using the given URL.
>   *
> @@ -160,6 +210,15 @@ static struct lttng_snapshot_output *create_output_f=
rom_args(const char *url)
>  	}
> =20
>  	if (opt_max_size) {
> +		/* Validate that the max size can contain one subbuffer. */
> +		uint64_t largest_subbuf =3D get_largest_subbuf();
> +		if (largest_subbuf =3D=3D 0) {
> +			goto error;
> +		} else if (largest_subbuf > opt_max_size) {
> +			ERR("Snapshot size must be greater or equal to the largest subbuffer'=
s size (%zu).",
> +				largest_subbuf);
> +			goto error;
> +		}
>  		ret =3D lttng_snapshot_output_set_size(opt_max_size, output);
>  		if (ret < 0) {
>  			goto error;
> --=20
> 1.9.1
>=20

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTTUW4XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02QNQIAMAfWST5Uqg1RR8rUVLK8Y+G
GZtzDVMzo8nyXWdvL+dCujUMGDEiVKMN+rIKFgkOWhZjqlHxw8NPt1meyBxPrTXN
n6Hzf5bmTbeei0Gh/VYK2RxJWvjd8g2+X5kN/mUQuTR47qorngBO6rz/YETA4aLI
ZkqUPb07mqXIDhsZv79neP0m2b2ODO6C73NgJEMMtQQ4mr1tLvj7/jJQ/HO35R0a
ux/G0K/lIkPOwgfhhX5+Uphr4nQpBEF4JuFjJkK4r/ZTUpT03PQdaznhtxCvfkFy
8AVUj8bkO2M5Ui9JZRZzgPmM4C9hER719Szj4PYRaLmLXPsFXNLF9ut7LxMsB68=
=+gNF
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--


--===============0924110461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0924110461==--
