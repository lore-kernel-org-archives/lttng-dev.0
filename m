From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: Suppress a compiler	warning
	(always-false condition)
Date: Wed, 15 May 2013 02:11:30 -0400
Message-ID: <20130515061130.GB16392__6554.82488587058$1368598323$gmane$org@Krystal>
References: <1368569334-6700-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UcUw0-0001Tx-16
	for lttng-dev@lists.lttng.org; Wed, 15 May 2013 02:11:32 -0400
Content-Disposition: inline
In-Reply-To: <1368569334-6700-1-git-send-email-jeremie.galarneau@efficios.com>
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

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> Clang reports an always-false condition (checking if an unsigned value < =
0)
> caused by a type mismatch in ctf-visitor-generate-io-struct.c.

manually split into 2 commits (cleanups is a separate commit).

merged,

Thanks,

Mathieu

> =

> Remove trailing whitespaces.
> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  formats/ctf/metadata/ctf-visitor-generate-io-struct.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> =

> diff --git a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c b/form=
ats/ctf/metadata/ctf-visitor-generate-io-struct.c
> index 0002fe4..c4208b7 100644
> --- a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
> +++ b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
> @@ -649,7 +649,7 @@ int ctf_typedef_visit(FILE *fd, int depth, struct dec=
laration_scope *scope,
>  	bt_list_for_each_entry(iter, type_declarators, siblings) {
>  		struct bt_declaration *type_declaration;
>  		int ret;
> -	=

> +
>  		type_declaration =3D ctf_type_declarator_visit(fd, depth,
>  					type_specifier_list,
>  					&identifier, iter,
> @@ -865,7 +865,6 @@ struct bt_declaration *ctf_declaration_struct_visit(F=
ILE *fd,
>  		if (name) {
>  			if (bt_lookup_struct_declaration(g_quark_from_string(name),
>  						      declaration_scope)) {
> -				=

>  				fprintf(fd, "[error] %s: struct %s already declared in scope\n", __f=
unc__, name);
>  				return NULL;
>  			}
> @@ -936,7 +935,6 @@ struct bt_declaration *ctf_declaration_variant_visit(=
FILE *fd,
>  		if (name) {
>  			if (bt_lookup_variant_declaration(g_quark_from_string(name),
>  						       declaration_scope)) {
> -				=

>  				fprintf(fd, "[error] %s: variant %s already declared in scope\n", __=
func__, name);
>  				return NULL;
>  			}
> @@ -1105,7 +1103,6 @@ struct bt_declaration *ctf_declaration_enum_visit(F=
ILE *fd, int depth,
>  		if (name) {
>  			if (bt_lookup_enum_declaration(g_quark_from_string(name),
>  						    declaration_scope)) {
> -				=

>  				fprintf(fd, "[error] %s: enum %s already declared in scope\n", __fun=
c__, name);
>  				return NULL;
>  			}
> @@ -1233,7 +1230,7 @@ int get_boolean(FILE *fd, int depth, struct ctf_nod=
e *unary_expression)
>  		fprintf(fd, "[error] %s: unexpected unary expression type\n",
>  			__func__);
>  		return -EINVAL;
> -	} =

> +	}
>  =

>  }
>  =

> @@ -1479,9 +1476,9 @@ struct bt_declaration *ctf_declaration_floating_poi=
nt_visit(FILE *fd, int depth,
>  		struct ctf_trace *trace)
>  {
>  	struct ctf_node *expression;
> -	uint64_t alignment =3D 1, exp_dig =3D 0, mant_dig =3D 0,
> -		byte_order =3D trace->byte_order;
> -	int has_alignment =3D 0, has_exp_dig =3D 0, has_mant_dig =3D 0;
> +	uint64_t alignment =3D 1, exp_dig =3D 0, mant_dig =3D 0;
> +	int byte_order =3D trace->byte_order, has_alignment =3D 0,
> +		has_exp_dig =3D 0, has_mant_dig =3D 0;
>  	struct declaration_float *float_declaration;
>  =

>  	bt_list_for_each_entry(expression, expressions, siblings) {
> -- =

> 1.8.2.2
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
