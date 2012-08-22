From: David Goulet <david.goulet@polymtl.ca>
Subject: Re: [PATCH lttng-tools] Filter: Handle the unary
 bitwise not operator (~) with an unsupported op error
Date: Wed, 22 Aug 2012 11:04:41 -0400
Message-ID: <5034F509.5020503__6645.31726292825$1345647929$gmane$org@polymtl.ca>
References: <1345642443-30197-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <david.goulet@polymtl.ca>) id 1T4CUC-0008Sw-TK
	for lttng-dev@lists.lttng.org; Wed, 22 Aug 2012 11:04:49 -0400
In-Reply-To: <1345642443-30197-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org, mathieu.desnoyers@efficios.com, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

Merged!

Thanks!

On 22/08/12 09:34 AM, Christian Babeux wrote:
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com> --- 
> src/lib/lttng-ctl/filter-ast.h                 |  1 + 
> src/lib/lttng-ctl/filter-parser.y              |  5 +++++ 
> src/lib/lttng-ctl/filter-visitor-generate-ir.c | 12 ++++++++++++ 3 files
> changed, 18 insertions(+)
> 
> diff --git a/src/lib/lttng-ctl/filter-ast.h
> b/src/lib/lttng-ctl/filter-ast.h index 97793c0..1767164 100644 ---
> a/src/lib/lttng-ctl/filter-ast.h +++ b/src/lib/lttng-ctl/filter-ast.h @@
> -91,6 +91,7 @@ enum unary_op_type { AST_UNARY_PLUS, AST_UNARY_MINUS, 
> AST_UNARY_NOT, +	AST_UNARY_BIN_NOT, };
> 
> enum ast_link_type { diff --git a/src/lib/lttng-ctl/filter-parser.y
> b/src/lib/lttng-ctl/filter-parser.y index 4ee1d9a..d3be4be 100644 ---
> a/src/lib/lttng-ctl/filter-parser.y +++
> b/src/lib/lttng-ctl/filter-parser.y @@ -481,6 +481,11 @@ unary_operator $$
> = make_node(parser_ctx, NODE_UNARY_OP); $$->u.unary_op.type =
> AST_UNARY_NOT; } +	| NOT_BIN +		{ +			$$ = make_node(parser_ctx,
> NODE_UNARY_OP); +			$$->u.unary_op.type = AST_UNARY_BIN_NOT; +		} ;
> 
> multiplicative_expression diff --git
> a/src/lib/lttng-ctl/filter-visitor-generate-ir.c
> b/src/lib/lttng-ctl/filter-visitor-generate-ir.c index 899713e..d23372f
> 100644 --- a/src/lib/lttng-ctl/filter-visitor-generate-ir.c +++
> b/src/lib/lttng-ctl/filter-visitor-generate-ir.c @@ -652,6 +652,8 @@
> static struct ir_op *make_unary_op(struct filter_parser_ctx *ctx, struct
> filter_node *node, enum ir_side side) { +	const char *op_str = "?"; + 
> switch (node->u.unary_op.type) { case AST_UNARY_UNKNOWN: default: @@ -703,7
> +705,17 @@ struct ir_op *make_unary_op(struct filter_parser_ctx *ctx, } 
> return op; } +	case AST_UNARY_BIN_NOT: +	{ +		op_str = "~"; +		goto
> error_not_supported; +	} } + +error_not_supported: +	fprintf(stderr,
> "[error] %s: unary operation '%s' not supported\n", +		__func__, op_str); +
> return NULL; }
> 
> static
