From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: measure UST clock offset
 with best sample (v2)
Date: Tue, 4 Feb 2014 14:14:37 -0500
Message-ID: <20140204191437.GI13440__30524.5136646137$1391541515$gmane$org@thessa>
References: <1391119590-16367-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1702135217=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WAlSH-0000uf-Ue
	for lttng-dev@lists.lttng.org; Tue, 04 Feb 2014 14:14:51 -0500
In-Reply-To: <1391119590-16367-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1702135217==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0XMZdl/q8hSSmFeD"
Content-Disposition: inline


--0XMZdl/q8hSSmFeD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged.

Backported to 2.4 and 2.3

On 30 Jan (17:06:30), Mathieu Desnoyers wrote:
> Fixes #729
>=20
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  src/bin/lttng-sessiond/ust-metadata.c |   55 ++++++++++++++++++++++++++-=
------
>  1 file changed, 44 insertions(+), 11 deletions(-)
>=20
> diff --git a/src/bin/lttng-sessiond/ust-metadata.c b/src/bin/lttng-sessio=
nd/ust-metadata.c
> index b0f83d2..f430ae1 100644
> --- a/src/bin/lttng-sessiond/ust-metadata.c
> +++ b/src/bin/lttng-sessiond/ust-metadata.c
> @@ -37,6 +37,13 @@
>  #define max_t(type, a, b)	((type) ((a) > (b) ? (a) : (b)))
>  #endif
> =20
> +#define NR_CLOCK_OFFSET_SAMPLES		10
> +
> +struct offset_sample {
> +	uint64_t offset;		/* correlation offset */
> +	uint64_t measure_delta;		/* lower is better */
> +};
> +
>  static inline
>  int fls(unsigned int x)
>  {
> @@ -490,31 +497,57 @@ int _lttng_event_header_declare(struct ust_registry=
_session *session)
>  	);
>  }
> =20
> -/*
> - * Approximation of NTP time of day to clock monotonic correlation,
> - * taken at start of trace.
> - * Yes, this is only an approximation. Yes, we can (and will) do better
> - * in future versions.
> - */
>  static
> -uint64_t measure_clock_offset(void)
> +int measure_single_clock_offset(struct offset_sample *sample)
>  {
> -	uint64_t offset, monotonic[2], realtime;
> +	uint64_t offset, monotonic[2], measure_delta, realtime;
>  	struct timespec rts =3D { 0, 0 };
>  	int ret;
> =20
>  	monotonic[0] =3D trace_clock_read64();
>  	ret =3D clock_gettime(CLOCK_REALTIME, &rts);
> -	if (ret < 0)
> -		return 0;
> +	if (ret < 0) {
> +		return ret;
> +	}
>  	monotonic[1] =3D trace_clock_read64();
> +	measure_delta =3D monotonic[1] - monotonic[0];
> +	if (measure_delta > sample->measure_delta) {
> +		/*
> +		 * Discard value if it took longer to read than the best
> +		 * sample so far.
> +		 */
> +		return 0;
> +	}
>  	offset =3D (monotonic[0] + monotonic[1]) >> 1;
>  	realtime =3D (uint64_t) rts.tv_sec * 1000000000ULL;
>  	realtime +=3D rts.tv_nsec;
>  	offset =3D realtime - offset;
> -	return offset;
> +	sample->offset =3D offset;
> +	sample->measure_delta =3D measure_delta;
> +	return 0;
>  }
> =20
> +/*
> + * Approximation of NTP time of day to clock monotonic correlation,
> + * taken at start of trace. Keep the measurement that took the less time
> + * to complete, thus removing imprecision caused by preemption.
> + */
> +static
> +uint64_t measure_clock_offset(void)
> +{
> +	int i;
> +	struct offset_sample offset_best_sample =3D {
> +		.offset =3D 0,
> +		.measure_delta =3D UINT64_MAX,
> +	};
> +
> +	for (i =3D 0; i < NR_CLOCK_OFFSET_SAMPLES; i++) {
> +		if (measure_single_clock_offset(&offset_best_sample)) {
> +			return 0;
> +		}
> +	}
> +	return offset_best_sample.offset;
> +}
> =20
>  /*
>   * Should be called with session registry mutex held.
> --=20
> 1.7.10.4
>=20

--0XMZdl/q8hSSmFeD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJS8TwdXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02EEUIAJnPJ+Xj/oxM+etaMEc9Xy1o
t1L2Lo08X08apnFIekGTmoj3iehrf9wnf7ftqElJ91ShCyh2Aqdv6ENj1PiAEXCC
Q7083HsD+ZPTCUVhXg+XQLMhmwZ6xHslZLoili2N1oQOt/sxEWW5Q0Qw+j3fCQBO
qVfWwWjzvhXH5uq0iyFJhaJZ9eU/5+zuoxKqAiAElVFL5v3v2i4lOA+qXg5awu/b
AAOg3KVRgcUIxN6VniT9u5GrqMWD4hpJyZWJQFvYwNK2dDYHjbipJUdKDgHeCPxy
WDXZxMjRbnh9mPfwNikOtiZsbzyyyujfQc/WmjTP2no/xeUnKK3FQ8eUWZARgVk=
=trJE
-----END PGP SIGNATURE-----

--0XMZdl/q8hSSmFeD--


--===============1702135217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1702135217==--
