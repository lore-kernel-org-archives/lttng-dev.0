From: Zifei Tong <soariez@gmail.com>
Subject: [lttng-tools PATCH] Fix filter parser segmentation
	fault with bison 3.0
Date: Fri, 16 Aug 2013 20:05:25 +0800
Message-ID: <1376654725-31219-1-git-send-email-soariez__180.767503525381$1376654782$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <soariez@gmail.com>) id 1VAImj-0006K3-Rs
	for lttng-dev@lists.lttng.org; Fri, 16 Aug 2013 08:05:43 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so1817053pab.1
	for <lttng-dev@lists.lttng.org>; Fri, 16 Aug 2013 05:05:36 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Replace deprecated YYLEX_PARAM with %lex-param

Tested with bison 2.7 and bison 3.0

Signed-off-by: Zifei Tong <soariez@gmail.com>
---
 src/lib/lttng-ctl/filter/filter-ast.h    |  3 ---
 src/lib/lttng-ctl/filter/filter-parser.y | 13 +++++++------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/src/lib/lttng-ctl/filter/filter-ast.h b/src/lib/lttng-ctl/filter/filter-ast.h
index 4fb60d0..405c668 100644
--- a/src/lib/lttng-ctl/filter/filter-ast.h
+++ b/src/lib/lttng-ctl/filter/filter-ast.h
@@ -39,9 +39,6 @@
 // data is a pointer to a 'SParserParam' structure
 //#define YYPARSE_PARAM	parser_ctx
 
-// the argument for the 'yylex' function
-#define YYLEX_PARAM	((struct filter_parser_ctx *) parser_ctx)->scanner
-
 #ifndef YY_TYPEDEF_YY_SCANNER_T
 #define YY_TYPEDEF_YY_SCANNER_T
 typedef void* yyscan_t;
diff --git a/src/lib/lttng-ctl/filter/filter-parser.y b/src/lib/lttng-ctl/filter/filter-parser.y
index 3f30134..29e2866 100644
--- a/src/lib/lttng-ctl/filter/filter-parser.y
+++ b/src/lib/lttng-ctl/filter/filter-parser.y
@@ -40,9 +40,9 @@ LTTNG_HIDDEN
 int filter_parser_debug = 0;
 
 LTTNG_HIDDEN
-int yyparse(struct filter_parser_ctx *parser_ctx);
+int yyparse(struct filter_parser_ctx *parser_ctx, yyscan_t scanner);
 LTTNG_HIDDEN
-int yylex(union YYSTYPE *yyval, struct filter_parser_ctx *parser_ctx);
+int yylex(union YYSTYPE *yyval, yyscan_t scanner);
 LTTNG_HIDDEN
 int yylex_init_extra(struct filter_parser_ctx *parser_ctx, yyscan_t * ptr_yy_globals);
 LTTNG_HIDDEN
@@ -188,7 +188,7 @@ static struct filter_node *make_op_node(struct filter_parser_ctx *scanner,
 }
 
 LTTNG_HIDDEN
-void yyerror(struct filter_parser_ctx *parser_ctx, const char *str)
+void yyerror(struct filter_parser_ctx *parser_ctx, yyscan_t scanner, const char *str)
 {
 	fprintf(stderr, "error %s\n", str);
 }
@@ -201,7 +201,7 @@ int yywrap(void)
 
 #define parse_error(parser_ctx, str)				\
 do {								\
-	yyerror(parser_ctx, YY_("parse error: " str "\n"));	\
+	yyerror(parser_ctx, parser_ctx->scanner, YY_("parse error: " str "\n"));	\
 	YYERROR;						\
 } while (0)
 
@@ -238,7 +238,7 @@ static void filter_ast_free(struct filter_ast *ast)
 LTTNG_HIDDEN
 int filter_parser_ctx_append_ast(struct filter_parser_ctx *parser_ctx)
 {
-	return yyparse(parser_ctx);
+	return yyparse(parser_ctx, parser_ctx->scanner);
 }
 
 LTTNG_HIDDEN
@@ -301,7 +301,8 @@ void filter_parser_ctx_free(struct filter_parser_ctx *parser_ctx)
 %define api.pure
 	/* %locations */
 %parse-param {struct filter_parser_ctx *parser_ctx}
-%lex-param {struct filter_parser_ctx *parser_ctx}
+%parse-param {yyscan_t scanner}
+%lex-param {yyscan_t scanner}
 %start translation_unit
 %token CHARACTER_CONSTANT_START SQUOTE STRING_LITERAL_START DQUOTE
 %token ESCSEQ CHAR_STRING_TOKEN
-- 
1.8.3.4
