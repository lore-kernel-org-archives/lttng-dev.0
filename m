From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Remove unused tracepoint in
 high-throughput test
Date: Wed, 12 Mar 2014 11:20:21 -0400
Message-ID: <20140312152021.GC10776__17513.113623909$1394637691$gmane$org@thessa>
References: <1394617450-7418-1-git-send-email-zifeitong@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0973111426=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WNkxK-0000RG-7j
	for lttng-dev@lists.lttng.org; Wed, 12 Mar 2014 11:20:35 -0400
In-Reply-To: <1394617450-7418-1-git-send-email-zifeitong@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Zifei Tong <zifeitong@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0973111426==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged! Thanks!

David

On 12 Mar (17:44:10), Zifei Tong wrote:
> Signed-off-by: Zifei Tong <zifeitong@gmail.com>
> ---
>  tests/regression/ust/high-throughput/tp.h | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/tests/regression/ust/high-throughput/tp.h b/tests/regression=
/ust/high-throughput/tp.h
> index b43cb4e..4c0edf7 100644
> --- a/tests/regression/ust/high-throughput/tp.h
> +++ b/tests/regression/ust/high-throughput/tp.h
> @@ -39,11 +39,6 @@ TRACEPOINT_EVENT(tp, tptest,
>  	)
>  )
> =20
> -TRACEPOINT_EVENT(tp, tptest_sighandler,
> -	TP_ARGS(),
> -	TP_FIELDS()
> -)
> -
>  #endif /* _TRACEPOINT_TP_H */
> =20
>  #undef TRACEPOINT_INCLUDE_FILE
> --=20
> 1.9.0
>=20

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTIHs1XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02ImQIAMBDf2Y6a35QNrtSHahWoZA/
kQxnX1Y4hBKcpeqi3aJ/THKi3HWdp6VOLiWYo8eL8FE0iwjpb5RcNgmbif0AXRv1
U5wXm1BDbK9QP/gMBe5hlgs2UX6dQCzRpSQTOuUfFHD2tigHQoj/J0osu5VEMfV1
2mMIjN6di+xEzs0ikJkePzT5PqPhWW23KuAGjPlsnq729hhoYCXWJ0LplnFB8Duq
LWCXYwhrp/Y/rfJ/le8uk18Z/GTPAlEHC5S7FWXya1lpL80tsZO3qNE1xvVTLWpc
RhlLx6lcH04M7xAdB84Ro6o9bzCNZv8YVIsx6kzIxShGBAfRT2dfgFwdPm8Yd9A=
=Msx/
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--


--===============0973111426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0973111426==--
