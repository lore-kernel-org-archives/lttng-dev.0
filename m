From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: [lttng-tools PATCH] Fix filter parser segmentation
 fault with bison 3.0
Date: Fri, 16 Aug 2013 11:11:46 -0400
Message-ID: <520E4132.1020109__35312.5712172643$1376665973$gmane$org@gmail.com>
References: <1376654725-31219-1-git-send-email-soariez@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-gh0-f176.google.com ([209.85.160.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1VALgw-0000Ia-CQ
	for lttng-dev@lists.lttng.org; Fri, 16 Aug 2013 11:11:59 -0400
Received: by mail-gh0-f176.google.com with SMTP id z17so291748ghb.35
	for <lttng-dev@lists.lttng.org>; Fri, 16 Aug 2013 08:11:48 -0700 (PDT)
In-Reply-To: <1376654725-31219-1-git-send-email-soariez@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Also tested on CentOS6 with bison 2.4

On 2013-08-16 08:05, Zifei Tong wrote:
> Replace deprecated YYLEX_PARAM with %lex-param
>
> Tested with bison 2.7 and bison 3.0
>
> Signed-off-by: Zifei Tong <soariez@gmail.com>
> ---
>  src/lib/lttng-ctl/filter/filter-ast.h    |  3 ---
>  src/lib/lttng-ctl/filter/filter-parser.y | 13 +++++++------
>  2 files changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/src/lib/lttng-ctl/filter/filter-ast.h b/src/lib/lttng-ctl/filter/filter-ast.h
> index 4fb60d0..405c668 100644
> --- a/src/lib/lttng-ctl/filter/filter-ast.h
> +++ b/src/lib/lttng-ctl/filter/filter-ast.h
> @@ -39,9 +39,6 @@
>  // data is a pointer to a 'SParserParam' structure
>  //#define YYPARSE_PARAM	parser_ctx
>  
> -// the argument for the 'yylex' function
> -#define YYLEX_PARAM	((struct filter_parser_ctx *) parser_ctx)->scanner
> -
>  #ifndef YY_TYPEDEF_YY_SCANNER_T
>  #define YY_TYPEDEF_YY_SCANNER_T
>  typedef void* yyscan_t;
> diff --git a/src/lib/lttng-ctl/filter/filter-parser.y b/src/lib/lttng-ctl/filter/filter-parser.y
> index 3f30134..29e2866 100644
> --- a/src/lib/lttng-ctl/filter/filter-parser.y
> +++ b/src/lib/lttng-ctl/filter/filter-parser.y
> @@ -40,9 +40,9 @@ LTTNG_HIDDEN
>  int filter_parser_debug = 0;
>  
>  LTTNG_HIDDEN
> -int yyparse(struct filter_parser_ctx *parser_ctx);
> +int yyparse(struct filter_parser_ctx *parser_ctx, yyscan_t scanner);
>  LTTNG_HIDDEN
> -int yylex(union YYSTYPE *yyval, struct filter_parser_ctx *parser_ctx);
> +int yylex(union YYSTYPE *yyval, yyscan_t scanner);
>  LTTNG_HIDDEN
>  int yylex_init_extra(struct filter_parser_ctx *parser_ctx, yyscan_t * ptr_yy_globals);
>  LTTNG_HIDDEN
> @@ -188,7 +188,7 @@ static struct filter_node *make_op_node(struct filter_parser_ctx *scanner,
>  }
>  
>  LTTNG_HIDDEN
> -void yyerror(struct filter_parser_ctx *parser_ctx, const char *str)
> +void yyerror(struct filter_parser_ctx *parser_ctx, yyscan_t scanner, const char *str)
>  {
>  	fprintf(stderr, "error %s\n", str);
>  }
> @@ -201,7 +201,7 @@ int yywrap(void)
>  
>  #define parse_error(parser_ctx, str)				\
>  do {								\
> -	yyerror(parser_ctx, YY_("parse error: " str "\n"));	\
> +	yyerror(parser_ctx, parser_ctx->scanner, YY_("parse error: " str "\n"));	\
>  	YYERROR;						\
>  } while (0)
>  
> @@ -238,7 +238,7 @@ static void filter_ast_free(struct filter_ast *ast)
>  LTTNG_HIDDEN
>  int filter_parser_ctx_append_ast(struct filter_parser_ctx *parser_ctx)
>  {
> -	return yyparse(parser_ctx);
> +	return yyparse(parser_ctx, parser_ctx->scanner);
>  }
>  
>  LTTNG_HIDDEN
> @@ -301,7 +301,8 @@ void filter_parser_ctx_free(struct filter_parser_ctx *parser_ctx)
>  %define api.pure
>  	/* %locations */
>  %parse-param {struct filter_parser_ctx *parser_ctx}
> -%lex-param {struct filter_parser_ctx *parser_ctx}
> +%parse-param {yyscan_t scanner}
> +%lex-param {yyscan_t scanner}
>  %start translation_unit
>  %token CHARACTER_CONSTANT_START SQUOTE STRING_LITERAL_START DQUOTE
>  %token ESCSEQ CHAR_STRING_TOKEN
