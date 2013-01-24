From: Julien Desfossez <jdesfossez@efficios.com>
Subject: [BABELTRACE PATCH 01/18] BT_HIDDEN macro
Date: Thu, 24 Jan 2013 16:21:33 -0500
Message-ID: <1359062510-7557-1-git-send-email-jdesfossez__10258.5828550675$1359062570$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1TyUFG-0008DA-8v
	for lttng-dev@lists.lttng.org; Thu, 24 Jan 2013 16:22:02 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: mathieu.desnoyers@efficios.com
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

This macro will be used across the codebase to set the visibility of a
function to hidden.
Updated also the functions that were setting the attribute manually.

Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
---
 formats/ctf/metadata/ctf-lexer.l         |    2 +-
 formats/ctf/metadata/ctf-parser.y        |   22 +++++++++++-----------
 formats/ctf/metadata/ctf-scanner.h       |    2 +-
 include/babeltrace/babeltrace-internal.h |    5 +++++
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/formats/ctf/metadata/ctf-lexer.l b/formats/ctf/metadata/ctf-lexer.l
index 26aa1bc..2209a86 100644
--- a/formats/ctf/metadata/ctf-lexer.l
+++ b/formats/ctf/metadata/ctf-lexer.l
@@ -31,7 +31,7 @@
 #include "ctf-parser.h"
 #include "ctf-ast.h"
 
-__attribute__((visibility("hidden")))
+BT_HIDDEN
 void setstring(struct ctf_scanner *scanner, YYSTYPE *lvalp, const char *src);
 
 static void yyunput (int c, register char * yy_bp , yyscan_t yyscanner)
diff --git a/formats/ctf/metadata/ctf-parser.y b/formats/ctf/metadata/ctf-parser.y
index e7dfd80..72b0978 100644
--- a/formats/ctf/metadata/ctf-parser.y
+++ b/formats/ctf/metadata/ctf-parser.y
@@ -39,7 +39,7 @@
 #include "ctf-parser.h"
 #include "ctf-ast.h"
 
-__attribute__((visibility("hidden")))
+BT_HIDDEN
 int yydebug;
 
 /* Join two lists, put "add" at the end of "head".  */
@@ -55,15 +55,15 @@ _bt_list_splice_tail (struct bt_list_head *add, struct bt_list_head *head)
 	}
 }
 
-__attribute__((visibility("hidden")))
+BT_HIDDEN
 int yyparse(struct ctf_scanner *scanner);
-__attribute__((visibility("hidden")))
+BT_HIDDEN
 int yylex(union YYSTYPE *yyval, struct ctf_scanner *scanner);
-__attribute__((visibility("hidden")))
+BT_HIDDEN
 int yylex_init_extra(struct ctf_scanner *scanner, yyscan_t * ptr_yy_globals);
-__attribute__((visibility("hidden")))
+BT_HIDDEN
 int yylex_destroy(yyscan_t yyscanner);
-__attribute__((visibility("hidden")))
+BT_HIDDEN
 void yyrestart(FILE * in_str, yyscan_t scanner);
 
 struct gc_string {
@@ -101,7 +101,7 @@ static const char *node_type_to_str[] = {
 	[ NODE_STRUCT ] = "NODE_STRUCT",
 };
 
-__attribute__((visibility("hidden")))
+BT_HIDDEN
 const char *node_type(struct ctf_node *node)
 {
 	if (node->type < NR_NODE_TYPES)
@@ -132,7 +132,7 @@ static struct gc_string *gc_string_alloc(struct ctf_scanner *scanner,
  * gsrc will be garbage collected immediately, and gstr might be.
  * Should only be used to append characters to a string literal or constant.
  */
-__attribute__((visibility("hidden")))
+BT_HIDDEN
 struct gc_string *gc_string_append(struct ctf_scanner *scanner,
 				   struct gc_string *gstr,
 				   struct gc_string *gsrc)
@@ -211,7 +211,7 @@ static int lookup_type(struct ctf_scanner_scope *s, const char *id)
 	return ret;
 }
 
-__attribute__((visibility("hidden")))
+BT_HIDDEN
 int is_type(struct ctf_scanner *scanner, const char *id)
 {
 	struct ctf_scanner_scope *it;
@@ -815,13 +815,13 @@ static int set_parent_node(struct ctf_node *node,
 	return 0;
 }
 
-__attribute__((visibility("hidden")))
+BT_HIDDEN
 void yyerror(struct ctf_scanner *scanner, const char *str)
 {
 	fprintf(stderr, "error %s\n", str);
 }
  
-__attribute__((visibility("hidden")))
+BT_HIDDEN
 int yywrap(void)
 {
 	return 1;
diff --git a/formats/ctf/metadata/ctf-scanner.h b/formats/ctf/metadata/ctf-scanner.h
index d5650d0..21010fd 100644
--- a/formats/ctf/metadata/ctf-scanner.h
+++ b/formats/ctf/metadata/ctf-scanner.h
@@ -49,7 +49,7 @@ struct ctf_ast *ctf_scanner_get_ast(struct ctf_scanner *scanner)
 	return scanner->ast;
 }
 
-__attribute__((visibility("hidden")))
+BT_HIDDEN
 int is_type(struct ctf_scanner *scanner, const char *id);
 
 #endif /* _CTF_SCANNER_H */
diff --git a/include/babeltrace/babeltrace-internal.h b/include/babeltrace/babeltrace-internal.h
index c567d39..6b6fcec 100644
--- a/include/babeltrace/babeltrace-internal.h
+++ b/include/babeltrace/babeltrace-internal.h
@@ -45,6 +45,11 @@ extern int babeltrace_verbose, babeltrace_debug;
 #define likely(x)	__builtin_expect(!!(x), 1)
 #define unlikely(x)	__builtin_expect(!!(x), 0)
 
+/*
+ * BT_HIDDEN: set the hidden attribute for internal functions
+ */
+#define BT_HIDDEN __attribute__((visibility("hidden")))
+
 struct trace_descriptor;
 struct trace_collection {
 	GPtrArray *array;	/* struct trace_descriptor */
-- 
1.7.10.4
