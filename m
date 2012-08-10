From: David Goulet <david.goulet@polymtl.ca>
Subject: Re: [LTTNG-TOOLS PATCH] Fix: protect visibility of
 filter-parser functions
Date: Fri, 10 Aug 2012 17:22:02 -0400
Message-ID: <50257B7A.9060604__12614.6772680388$1344633765$gmane$org@polymtl.ca>
References: <1344633593-5990-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <david.goulet@polymtl.ca>) id 1Szwei-00005D-K0
	for lttng-dev@lists.lttng.org; Fri, 10 Aug 2012 17:22:04 -0400
In-Reply-To: <1344633593-5990-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Merged!

On 10/08/12 05:19 PM, Julien Desfossez wrote:
> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> Some functions share the same name between ctf-parser/lexer and 
> filter-parser/lexer.
> 
> This patch protects the visibility of the functions with the same name to
> avoid linkage confusions.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com> --- 
> src/lib/lttng-ctl/filter-parser.y |   11 +++++++++++ 1 file changed, 11
> insertions(+)
> 
> diff --git a/src/lib/lttng-ctl/filter-parser.y
> b/src/lib/lttng-ctl/filter-parser.y index ea43352..8be5e43 100644 ---
> a/src/lib/lttng-ctl/filter-parser.y +++
> b/src/lib/lttng-ctl/filter-parser.y @@ -32,13 +32,19 @@ #include
> "filter-ast.h" #include "filter-parser.h"
> 
> +__attribute__((visibility("protected"))) int yydebug; int
> filter_parser_debug = 0;
> 
> +__attribute__((visibility("protected"))) int yyparse(struct
> filter_parser_ctx *parser_ctx); +__attribute__((visibility("protected"))) 
> int yylex(union YYSTYPE *yyval, struct filter_parser_ctx *parser_ctx); 
> +__attribute__((visibility("protected"))) int yylex_init_extra(struct
> filter_parser_ctx *parser_ctx, yyscan_t * ptr_yy_globals); 
> +__attribute__((visibility("protected"))) int yylex_destroy(yyscan_t
> yyparser_ctx); +__attribute__((visibility("protected"))) void
> yyrestart(FILE * in_str, yyscan_t parser_ctx);
> 
> struct gc_string { @@ -55,6 +61,7 @@ static const char *node_type_to_str[]
> = { [ NODE_UNARY_OP ] = "NODE_UNARY_OP", };
> 
> +__attribute__((visibility("protected"))) const char *node_type(struct
> filter_node *node) { if (node->type < NR_NODE_TYPES) @@ -85,6 +92,7 @@
> static struct gc_string *gc_string_alloc(struct filter_parser_ctx
> *parser_ctx, * gsrc will be garbage collected immediately, and gstr might
> be. * Should only be used to append characters to a string literal or
> constant. */ +__attribute__((visibility("protected"))) struct gc_string
> *gc_string_append(struct filter_parser_ctx *parser_ctx, struct gc_string
> *gstr, struct gc_string *gsrc) @@ -114,6 +122,7 @@ struct gc_string
> *gc_string_append(struct filter_parser_ctx *parser_ctx, return gstr; }
> 
> +__attribute__((visibility("protected"))) void setstring(struct
> filter_parser_ctx *parser_ctx, YYSTYPE *lvalp, const char *src) { lvalp->gs
> = gc_string_alloc(parser_ctx, strlen(src) + 1); @@ -175,11 +184,13 @@
> static struct filter_node *make_op_node(struct filter_parser_ctx *scanner, 
> return node; }
> 
> +__attribute__((visibility("protected"))) void yyerror(struct
> filter_parser_ctx *parser_ctx, const char *str) { fprintf(stderr, "error
> %s\n", str); }
> 
> +__attribute__((visibility("protected"))) int yywrap(void) { return 1;
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJQJXt6AAoJEELoaioR9I0263gIALoOPhf7ldD7rgtOk+gRcHTM
HI/Rr7Fo2tsl8EzyRxpyy+2JZfAOoFAqG17VLAXQ9wozgS3KJ/wgvrRWIhEFvSPv
RWlahrg6XHscbrVD5Vf02+L3M0MG6MbaXNYFl2dpHdxKufbmOk3WWW7uxgHAVTpI
kWEyMvIeqphxiLqyEF9+LbW0pBQ2Sl/7AjFU6S7ZT5gAGo1EOp3F2LnBXQVBEI9s
TJY/rnM/pq0TZAXMRuAY7eALzYYVq6oQ00MAaAgdxk/+ElA9KLd6TxlNOR+orpqD
Txp5a1QYTPnavW+6htiq4iQCqDozTy5z1nMoJXuR9Q7UirKjxKfk7DD+baVz7lI=
=gdS3
-----END PGP SIGNATURE-----
