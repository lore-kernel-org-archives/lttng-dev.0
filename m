From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH v2] Fix: alignment problems on targets not
 supporting unaligned access.
Date: Wed, 28 May 2014 09:39:49 -0400
Message-ID: <20140528133949.GA7798__29322.04162139$1401284461$gmane$org@thessa>
References: <1400202607-10904-1-git-send-email-rongqing.li@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1666580799=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1Wpe5H-0001c2-Sq
 for lttng-dev@lists.lttng.org; Wed, 28 May 2014 09:40:05 -0400
In-Reply-To: <1400202607-10904-1-git-send-email-rongqing.li@windriver.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: rongqing.li@windriver.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1666580799==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

Thanks
David

On 16 May (09:10:07), rongqing.li@windriver.com wrote:
> From: Fredrik Markstr=F6m <fredrik.markstrom@gmail.com>
>=20
> Accessing floats, doubles and 64 bit int at unaligned addresses is not
> supported on all configurations of arm processors and if it is it's
> emulated and slow. This patch replaces direct assignments with memcpy.
>=20
> Signed-off-by: Fredrik Markstr=F6m <fredrik.markstrom@gmail.com>
> Signed-off-by: Roy Li <rongqing.li@windriver.com>
> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c =
b/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c
> index 762d604..8c6dc96 100644
> --- a/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c
> +++ b/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c
> @@ -222,7 +222,7 @@ int visit_node_load(struct filter_parser_ctx *ctx, st=
ruct ir_op *node)
>  		if (!insn)
>  			return -ENOMEM;
>  		insn->op =3D FILTER_OP_LOAD_S64;
> -		*(int64_t *) insn->data =3D node->u.load.u.num;
> +		memcpy(insn->data, &node->u.load.u.num, sizeof(int64_t));
>  		ret =3D bytecode_push(&ctx->bytecode, insn, 1, insn_len);
>  		free(insn);
>  		return ret;
> @@ -237,7 +237,7 @@ int visit_node_load(struct filter_parser_ctx *ctx, st=
ruct ir_op *node)
>  		if (!insn)
>  			return -ENOMEM;
>  		insn->op =3D FILTER_OP_LOAD_DOUBLE;
> -		*(double *) insn->data =3D node->u.load.u.flt;
> +		memcpy(insn->data, &node->u.load.u.flt, sizeof(double));
>  		ret =3D bytecode_push(&ctx->bytecode, insn, 1, insn_len);
>  		free(insn);
>  		return ret;
> --=20
> 1.7.10.4
>=20

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTheclXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02vQ8IAIgWZlUCX8bPFO4Jdf6d0KoB
rmeDKeQAeORcXLy/3AsAd3gLCfjLtOnXr3JErFACaoouXgbU+eKXadhlbnhswmm/
tqAu9lE4cZdx2vZ6d8RkoyfJSyojIKYtYaYyXmziiRUaZgXztpPFxOJug2aiDYF+
sAwvMiCdmanlVrEq5NxloK525b0KQ9PLocnwjA6V4YzN88mwSK0mj8C2+6afmzrn
BW5YTwOYG+b5H/bXRp2isXkrCH2C32YTVq5BsMCE0IKPlL3irnRrdDz6QSZQbcBI
ELa28dpbxB2E+JK6ZLKy/5xLRIIUxYcgvdrL1f216nMz91kG7JfxV8kP+Snbri0=
=FswZ
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--


--===============1666580799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1666580799==--
