From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: scanf unbounded input
Date: Thu, 20 Feb 2014 22:53:04 -0500
Message-ID: <1392954784-17787-1-git-send-email-mathieu.desnoyers__9763.76622352309$1392954860$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mathieu.desnoyers@efficios.com>) id 1WGhAq-00019H-2I
	for lttng-dev@lists.lttng.org; Thu, 20 Feb 2014 22:53:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.efficios.com (Postfix) with ESMTP id 6340934018A
	for <lttng-dev@lists.lttng.org>; Fri, 21 Feb 2014 03:53:16 +0000 (UTC)
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

Awaiting a proper cleanup (introducing nscanf), do what we can to
validate the scanf input using its utterly broken API.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 src/bin/lttng/commands/enable_events.c   |   13 ++++++++++---
 src/bin/lttng/conf.c                     |    7 ++++++-
 src/lib/lttng-ctl/filter/filter-parser.y |   31 ++++++++++++++++++++++--------
 3 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/commands/enable_events.c
index 29a399e..bd2d997 100644
--- a/src/bin/lttng/commands/enable_events.c
+++ b/src/bin/lttng/commands/enable_events.c
@@ -30,6 +30,10 @@
 #include "../command.h"
 #include <src/common/sessiond-comm/sessiond-comm.h>
 
+#if (LTTNG_SYMBOL_NAME_LEN == 256)
+#define LTTNG_SYMBOL_NAME_LEN_SCANF_IS_A_BROKEN_API	"255"
+#endif
+
 static char *opt_event_list;
 static int opt_event_type;
 static const char *opt_loglevel;
@@ -226,6 +230,7 @@ static int parse_probe_opts(struct lttng_event *ev, char *opt)
 {
 	int ret;
 	char s_hex[19];
+#define S_HEX_LEN_SCANF_IS_A_BROKEN_API "18"	/* 18 is (19 - 1) (\0 is extra) */
 	char name[LTTNG_SYMBOL_NAME_LEN];
 
 	if (opt == NULL) {
@@ -234,7 +239,8 @@ static int parse_probe_opts(struct lttng_event *ev, char *opt)
 	}
 
 	/* Check for symbol+offset */
-	ret = sscanf(opt, "%[^'+']+%s", name, s_hex);
+	ret = sscanf(opt, "%" LTTNG_SYMBOL_NAME_LEN_SCANF_IS_A_BROKEN_API
+			"[^'+']+%" S_HEX_LEN_SCANF_IS_A_BROKEN_API "s", name, s_hex);
 	if (ret == 2) {
 		strncpy(ev->attr.probe.symbol_name, name, LTTNG_SYMBOL_NAME_LEN);
 		ev->attr.probe.symbol_name[LTTNG_SYMBOL_NAME_LEN - 1] = '\0';
@@ -252,7 +258,8 @@ static int parse_probe_opts(struct lttng_event *ev, char *opt)
 
 	/* Check for symbol */
 	if (isalpha(name[0])) {
-		ret = sscanf(opt, "%s", name);
+		ret = sscanf(opt, "%" LTTNG_SYMBOL_NAME_LEN_SCANF_IS_A_BROKEN_API "s",
+			name);
 		if (ret == 1) {
 			strncpy(ev->attr.probe.symbol_name, name, LTTNG_SYMBOL_NAME_LEN);
 			ev->attr.probe.symbol_name[LTTNG_SYMBOL_NAME_LEN - 1] = '\0';
@@ -265,7 +272,7 @@ static int parse_probe_opts(struct lttng_event *ev, char *opt)
 	}
 
 	/* Check for address */
-	ret = sscanf(opt, "%s", s_hex);
+	ret = sscanf(opt, "%" S_HEX_LEN_SCANF_IS_A_BROKEN_API "s", s_hex);
 	if (ret > 0) {
 		if (*s_hex == '\0') {
 			ERR("Invalid probe address %s", s_hex);
diff --git a/src/bin/lttng/conf.c b/src/bin/lttng/conf.c
index 5a0da9d..55ed635 100644
--- a/src/bin/lttng/conf.c
+++ b/src/bin/lttng/conf.c
@@ -186,6 +186,9 @@ char *config_read_session_name(char *path)
 	int ret;
 	FILE *fp;
 	char var[NAME_MAX], *session_name;
+#if (NAME_MAX == 255)
+#define NAME_MAX_SCANF_IS_A_BROKEN_API	"254"
+#endif
 
 	session_name = malloc(NAME_MAX);
 	if (session_name == NULL) {
@@ -202,7 +205,9 @@ char *config_read_session_name(char *path)
 	}
 
 	while (!feof(fp)) {
-		if ((ret = fscanf(fp, "%[^'=']=%s\n", var, session_name)) != 2) {
+		if ((ret = fscanf(fp, "%" NAME_MAX_SCANF_IS_A_BROKEN_API
+				"[^'=']=%" NAME_MAX_SCANF_IS_A_BROKEN_API "s\n",
+				var, session_name)) != 2) {
 			if (ret == -1) {
 				ERR("Missing session=NAME in config file.");
 				goto error_close;
diff --git a/src/lib/lttng-ctl/filter/filter-parser.y b/src/lib/lttng-ctl/filter/filter-parser.y
index 29e2866..d746f78 100644
--- a/src/lib/lttng-ctl/filter/filter-parser.y
+++ b/src/lib/lttng-ctl/filter/filter-parser.y
@@ -34,6 +34,11 @@
 
 #include <common/macros.h>
 
+#define WIDTH_u64_SCANF_IS_A_BROKEN_API	"20"
+#define WIDTH_o64_SCANF_IS_A_BROKEN_API	"22"
+#define WIDTH_x64_SCANF_IS_A_BROKEN_API	"17"
+#define WIDTH_lg_SCANF_IS_A_BROKEN_API	"4096"	/* Hugely optimistic approximation */
+
 LTTNG_HIDDEN
 int yydebug;
 LTTNG_HIDDEN
@@ -399,29 +404,39 @@ primary_expression
 		{
 			$$ = make_node(parser_ctx, NODE_EXPRESSION);
 			$$->u.expression.type = AST_EXP_CONSTANT;
-			sscanf(yylval.gs->s, "%" PRIu64,
-			       &$$->u.expression.u.constant);
+			if (sscanf(yylval.gs->s, "%" WIDTH_u64_SCANF_IS_A_BROKEN_API SCNu64,
+					&$$->u.expression.u.constant) != 1) {
+				parse_error(parser_ctx, "cannot scanf decimal constant");
+			}
 		}
 	|	OCTAL_CONSTANT
 		{
 			$$ = make_node(parser_ctx, NODE_EXPRESSION);
 			$$->u.expression.type = AST_EXP_CONSTANT;
-			sscanf(yylval.gs->s, "0%" PRIo64,
-			       &$$->u.expression.u.constant);
+			if (!strcmp(yylval.gs->s, "0")) {
+				$$->u.expression.u.constant = 0;
+			} else if (sscanf(yylval.gs->s, "0%" WIDTH_o64_SCANF_IS_A_BROKEN_API SCNo64,
+					&$$->u.expression.u.constant) != 1) {
+				parse_error(parser_ctx, "cannot scanf octal constant");
+			}
 		}
 	|	HEXADECIMAL_CONSTANT
 		{
 			$$ = make_node(parser_ctx, NODE_EXPRESSION);
 			$$->u.expression.type = AST_EXP_CONSTANT;
-			sscanf(yylval.gs->s, "0x%" PRIx64,
-			       &$$->u.expression.u.constant);
+			if (sscanf(yylval.gs->s, "0x%" WIDTH_x64_SCANF_IS_A_BROKEN_API SCNx64,
+					&$$->u.expression.u.constant) != 1) {
+				parse_error(parser_ctx, "cannot scanf hexadecimal constant");
+			}
 		}
 	|	FLOAT_CONSTANT
 		{
 			$$ = make_node(parser_ctx, NODE_EXPRESSION);
 			$$->u.expression.type = AST_EXP_FLOAT_CONSTANT;
-			sscanf(yylval.gs->s, "%lg",
-			       &$$->u.expression.u.float_constant);
+			if (sscanf(yylval.gs->s, "%" WIDTH_lg_SCANF_IS_A_BROKEN_API "lg",
+					&$$->u.expression.u.float_constant) != 1) {
+				parse_error(parser_ctx, "cannot scanf float constant");
+			}
 		}
 	|	STRING_LITERAL_START DQUOTE
 		{
-- 
1.7.10.4
