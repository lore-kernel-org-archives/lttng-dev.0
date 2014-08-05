From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Warn that wildcards must be
 used as the last character in a string
Date: Tue, 5 Aug 2014 17:03:56 -0400
Message-ID: <20140805210356.GB5855__5925.36256085641$1407272716$gmane$org@dalia>
References: <1407175829-23486-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0890623824=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XElts-0003TZ-At
 for lttng-dev@lists.lttng.org; Tue, 05 Aug 2014 17:04:10 -0400
In-Reply-To: <1407175829-23486-1-git-send-email-jeremie.galarneau@efficios.com>
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


--===============0890623824==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged and the two other patches following this email.

On 04 Aug (14:10:27), J=E9r=E9mie Galarneau wrote:
> Wildcards are currently only supported as the last character
> in a string literal used in an event filter. This rule is not
> checked which may confuse users who expect complete wildcard
> support in filter expressions.
>=20
> An error is now reported and the filter string is treated
> as invalid.
>=20
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  src/lib/lttng-ctl/filter/Makefile.am               |   1 +
>  src/lib/lttng-ctl/filter/filter-ast.h              |   1 +
>  .../filter/filter-visitor-ir-validate-string.c     | 148 +++++++++++++++=
++++++
>  src/lib/lttng-ctl/lttng-ctl.c                      |   6 +
>  4 files changed, 156 insertions(+)
>  create mode 100644 src/lib/lttng-ctl/filter/filter-visitor-ir-validate-s=
tring.c
>=20
> diff --git a/src/lib/lttng-ctl/filter/Makefile.am b/src/lib/lttng-ctl/fil=
ter/Makefile.am
> index 4ff345a..71a53c1 100644
> --- a/src/lib/lttng-ctl/filter/Makefile.am
> +++ b/src/lib/lttng-ctl/filter/Makefile.am
> @@ -14,6 +14,7 @@ libfilter_la_SOURCES =3D filter-lexer.l filter-parser.y=
 \
>  	filter-visitor-xml.c \
>  	filter-visitor-generate-ir.c \
>  	filter-visitor-ir-check-binary-op-nesting.c \
> +	filter-visitor-ir-validate-string.c \
>  	filter-visitor-generate-bytecode.c \
>  	align.h \
>  	bug.h \
> diff --git a/src/lib/lttng-ctl/filter/filter-ast.h b/src/lib/lttng-ctl/fi=
lter/filter-ast.h
> index 405c668..7f1883f 100644
> --- a/src/lib/lttng-ctl/filter/filter-ast.h
> +++ b/src/lib/lttng-ctl/filter/filter-ast.h
> @@ -186,5 +186,6 @@ int filter_visitor_bytecode_generate(struct filter_pa=
rser_ctx *ctx);
>  void filter_bytecode_free(struct filter_parser_ctx *ctx);
>  int filter_visitor_ir_check_binary_op_nesting(struct filter_parser_ctx *=
ctx);
>  int filter_visitor_ir_check_binary_comparator(struct filter_parser_ctx *=
ctx);
> +int filter_visitor_ir_validate_string(struct filter_parser_ctx *ctx);
> =20
>  #endif /* _FILTER_AST_H */
> diff --git a/src/lib/lttng-ctl/filter/filter-visitor-ir-validate-string.c=
 b/src/lib/lttng-ctl/filter/filter-visitor-ir-validate-string.c
> new file mode 100644
> index 0000000..34b4b19
> --- /dev/null
> +++ b/src/lib/lttng-ctl/filter/filter-visitor-ir-validate-string.c
> @@ -0,0 +1,148 @@
> +/*
> + * filter-visitor-ir-validate-string.c
> + *
> + * LTTng filter IR validate string
> + *
> + * Copyright 2014 - J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.co=
m>
> + *
> + * This library is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU Lesser General Public License, version 2.1=
 only,
> + * as published by the Free Software Foundation.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public Lice=
nse
> + * along with this library; if not, write to the Free Software Foundatio=
n,
> + * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <stdlib.h>
> +#include <assert.h>
> +#include <errno.h>
> +#include <inttypes.h>
> +#include "filter-ast.h"
> +#include "filter-parser.h"
> +#include "filter-ir.h"
> +
> +enum parse_char_result {
> +	PARSE_CHAR_UNKNOWN =3D -2,
> +	PARSE_CHAR_WILDCARD =3D -1,
> +	PARSE_CHAR_NORMAL =3D 0,
> +};
> +
> +static
> +enum parse_char_result parse_char(const char **p)
> +{
> +	switch (**p) {
> +	case '\\':
> +		(*p)++;
> +		switch (**p) {
> +		case '\\':
> +		case '*':
> +			return PARSE_CHAR_NORMAL;
> +		default:
> +			return PARSE_CHAR_UNKNOWN;
> +		}
> +	case '*':
> +		return PARSE_CHAR_WILDCARD;
> +	default:
> +		return PARSE_CHAR_NORMAL;
> +	}
> +}
> +
> +static
> +int validate_string(struct ir_op *node)
> +{
> +	switch (node->op) {
> +	case IR_OP_UNKNOWN:
> +	default:
> +		fprintf(stderr, "[error] %s: unknown op type\n", __func__);
> +		return -EINVAL;
> +
> +	case IR_OP_ROOT:
> +		return validate_string(node->u.root.child);
> +	case IR_OP_LOAD:
> +	{
> +		int ret =3D 0;
> +
> +		if (node->data_type =3D=3D IR_DATA_STRING) {
> +			const char *str;
> +
> +			assert(node->u.load.u.string);
> +			str =3D node->u.load.u.string;
> +
> +			/*
> +			 * Make sure that if a non-escaped wildcard is
> +			 * present, it is the last character of the string.
> +			 */
> +			for (;;) {
> +				enum parse_char_result res;
> +
> +				if (!(*str)) {
> +					break;
> +				}
> +
> +				res =3D parse_char(&str);
> +				str++;
> +
> +				switch (res) {
> +				case PARSE_CHAR_WILDCARD:
> +				{
> +					if (*str) {
> +						/*
> +						 * Found a wildcard followed by non-null
> +						 * character; unsupported.
> +						 */
> +						ret =3D -EINVAL;
> +						fprintf(stderr,
> +							"Wildcards may only be used as the last character of a string in =
a filter.\n");
> +						goto end_load;
> +					}
> +					break;
> +				}
> +				case PARSE_CHAR_UNKNOWN:
> +					ret =3D -EINVAL;
> +					fprintf(stderr,
> +						"Unsupported escape character detected.\n");
> +					goto end_load;
> +				case PARSE_CHAR_NORMAL:
> +				default:
> +					break;
> +				}
> +			}
> +		}
> +end_load:
> +		return ret;
> +	}
> +	case IR_OP_UNARY:
> +		return validate_string(node->u.unary.child);
> +	case IR_OP_BINARY:
> +	{
> +		int ret =3D validate_string(node->u.binary.left);
> +
> +		if (ret)
> +			return ret;
> +		return validate_string(node->u.binary.right);
> +	}
> +	case IR_OP_LOGICAL:
> +	{
> +		int ret;
> +
> +		ret =3D validate_string(node->u.logical.left);
> +		if (ret)
> +			return ret;
> +		return validate_string(node->u.logical.right);
> +	}
> +	}
> +}
> +
> +int filter_visitor_ir_validate_string(struct filter_parser_ctx *ctx)
> +{
> +	return validate_string(ctx->ir_root);
> +}
> diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
> index 536d41b..b9dc1ef 100644
> --- a/src/lib/lttng-ctl/lttng-ctl.c
> +++ b/src/lib/lttng-ctl/lttng-ctl.c
> @@ -825,6 +825,12 @@ static int generate_filter(char *filter_expression,
>  		ret =3D -LTTNG_ERR_FILTER_INVAL;
>  		goto parse_error;
>  	}
> +	/* Validate strings used as literals in the expression */
> +	ret =3D filter_visitor_ir_validate_string(ctx);
> +	if (ret) {
> +		ret =3D -LTTNG_ERR_FILTER_INVAL;
> +		goto parse_error;
> +	}
>  	dbg_printf("done\n");
> =20
>  	dbg_printf("Generating bytecode... ");
> --=20
> 2.0.3
>=20

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJT4Ua8XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02pgQH/0f5hSvqO68i5qqc30WYOasP
2Lsj3F8Rgh55u3pC9kIG3J8GFeZjT4OXbummluk3jADOmCsqV/1LTp4ck0wSE0YB
xDArpHFrJnSaiNgHQqpXpRvXBM37dacdTXrY7athOZ8TwQE0SE67KoCG2BobLAro
xzxfbUqebCD5k26b1cH5ONbUQZZbhe4GELypUKnknPHhMyawQEqk9cE/k043rAfX
V72Vg0QuQP9pt1tH1KOtElWlVlun87dzw3LyX1jhwNUy4iaUjnC5gfkcl9LkbgX7
ycSe2dNb4OPiCm4hYRss0jz14r5pG07DKB3mlpq7bvKGV2hJiOnOtVuU4SWPL+U=
=xn30
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--


--===============0890623824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0890623824==--
