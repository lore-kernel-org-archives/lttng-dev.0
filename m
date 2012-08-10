From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [LTTNG-TOOLS PATCH] Fix: protect visibility of
	filter-parser functions
Date: Fri, 10 Aug 2012 17:19:53 -0400
Message-ID: <1344633593-5990-1-git-send-email-jdesfossez__10006.9880173125$1344633686$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1Szwcr-0008VS-Pd
	for lttng-dev@lists.lttng.org; Fri, 10 Aug 2012 17:20:10 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com, mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Some functions share the same name between ctf-parser/lexer and
filter-parser/lexer.

This patch protects the visibility of the functions with the same name
to avoid linkage confusions.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 src/lib/lttng-ctl/filter-parser.y |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/lib/lttng-ctl/filter-parser.y b/src/lib/lttng-ctl/filter-parser.y
index ea43352..8be5e43 100644
--- a/src/lib/lttng-ctl/filter-parser.y
+++ b/src/lib/lttng-ctl/filter-parser.y
@@ -32,13 +32,19 @@
 #include "filter-ast.h"
 #include "filter-parser.h"
 
+__attribute__((visibility("protected")))
 int yydebug;
 int filter_parser_debug = 0;
 
+__attribute__((visibility("protected")))
 int yyparse(struct filter_parser_ctx *parser_ctx);
+__attribute__((visibility("protected")))
 int yylex(union YYSTYPE *yyval, struct filter_parser_ctx *parser_ctx);
+__attribute__((visibility("protected")))
 int yylex_init_extra(struct filter_parser_ctx *parser_ctx, yyscan_t * ptr_yy_globals);
+__attribute__((visibility("protected")))
 int yylex_destroy(yyscan_t yyparser_ctx);
+__attribute__((visibility("protected")))
 void yyrestart(FILE * in_str, yyscan_t parser_ctx);
 
 struct gc_string {
@@ -55,6 +61,7 @@ static const char *node_type_to_str[] = {
 	[ NODE_UNARY_OP ] = "NODE_UNARY_OP",
 };
 
+__attribute__((visibility("protected")))
 const char *node_type(struct filter_node *node)
 {
 	if (node->type < NR_NODE_TYPES)
@@ -85,6 +92,7 @@ static struct gc_string *gc_string_alloc(struct filter_parser_ctx *parser_ctx,
  * gsrc will be garbage collected immediately, and gstr might be.
  * Should only be used to append characters to a string literal or constant.
  */
+__attribute__((visibility("protected")))
 struct gc_string *gc_string_append(struct filter_parser_ctx *parser_ctx,
 				   struct gc_string *gstr,
 				   struct gc_string *gsrc)
@@ -114,6 +122,7 @@ struct gc_string *gc_string_append(struct filter_parser_ctx *parser_ctx,
 	return gstr;
 }
 
+__attribute__((visibility("protected")))
 void setstring(struct filter_parser_ctx *parser_ctx, YYSTYPE *lvalp, const char *src)
 {
 	lvalp->gs = gc_string_alloc(parser_ctx, strlen(src) + 1);
@@ -175,11 +184,13 @@ static struct filter_node *make_op_node(struct filter_parser_ctx *scanner,
 	return node;
 }
 
+__attribute__((visibility("protected")))
 void yyerror(struct filter_parser_ctx *parser_ctx, const char *str)
 {
 	fprintf(stderr, "error %s\n", str);
 }
  
+__attribute__((visibility("protected")))
 int yywrap(void)
 {
 	return 1;
-- 
1.7.10.4
