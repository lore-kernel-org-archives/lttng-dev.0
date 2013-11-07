From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 21/28] Collate lttng_enable_event*
	code
Date: Thu,  7 Nov 2013 12:22:00 +0200
Message-ID: <1383819727-6843-2-git-send-email-jp_ikaheimonen__37895.4095220708$1383820032$gmane$org@mentor.com>
References: <1383819727-6843-1-git-send-email-jp_ikaheimonen@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMjF-0007cY-S9
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:23 -0500
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1VeMjA-0006FD-Cr from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:22:16 -0800
In-Reply-To: <1383819727-6843-1-git-send-email-jp_ikaheimonen@mentor.com>
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

Because the function lttng_enable_event_with_exclusions() can also
handle the duties of lttng_enable_event and lttng_enable_event_with_filter
as special cases, there's no need to have the same code duplicated in
each function. Let the other two functions fall the generic function
lttng_enable_event_with_exclusions() instead.

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 src/lib/lttng-ctl/lttng-ctl.c | 171 +-----------------------------------------
 1 file changed, 4 insertions(+), 167 deletions(-)

diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
index 21173ca..9a21605 100644
--- a/src/lib/lttng-ctl/lttng-ctl.c
+++ b/src/lib/lttng-ctl/lttng-ctl.c
@@ -673,36 +673,8 @@ int lttng_add_context(struct lttng_handle *handle,
 int lttng_enable_event(struct lttng_handle *handle,
 		struct lttng_event *ev, const char *channel_name)
 {
-	struct lttcomm_session_msg lsm;
-
-	if (handle == NULL || ev == NULL) {
-		return -LTTNG_ERR_INVALID;
-	}
-
-	memset(&lsm, 0, sizeof(lsm));
-
-	/* If no channel name, send empty string. */
-	if (channel_name == NULL) {
-		lttng_ctl_copy_string(lsm.u.enable.channel_name, "",
-				sizeof(lsm.u.enable.channel_name));
-	} else {
-		lttng_ctl_copy_string(lsm.u.enable.channel_name, channel_name,
-				sizeof(lsm.u.enable.channel_name));
-	}
-
-	lttng_ctl_copy_lttng_domain(&lsm.domain, &handle->domain);
-
-	if (ev->name[0] != '\0') {
-		lsm.cmd_type = LTTNG_ENABLE_EVENT;
-	} else {
-		lsm.cmd_type = LTTNG_ENABLE_ALL_EVENT;
-	}
-	memcpy(&lsm.u.enable.event, ev, sizeof(lsm.u.enable.event));
-
-	lttng_ctl_copy_string(lsm.session.name, handle->session_name,
-			sizeof(lsm.session.name));
-
-	return lttng_ctl_ask_sessiond(&lsm, NULL);
+	return lttng_enable_event_with_exclusions(handle, ev, channel_name,
+			NULL, 0, NULL);
 }
 
 /*
@@ -715,143 +687,8 @@ int lttng_enable_event_with_filter(struct lttng_handle *handle,
 		struct lttng_event *event, const char *channel_name,
 		const char *filter_expression)
 {
-	struct lttcomm_session_msg lsm;
-	struct filter_parser_ctx *ctx;
-	FILE *fmem;
-	int ret = 0;
-
-	if (!filter_expression) {
-		/*
-		 * Fall back to normal event enabling if no filter
-		 * specified.
-		 */
-		return lttng_enable_event(handle, event, channel_name);
-	}
-
-	/*
-	 * Empty filter string will always be rejected by the parser
-	 * anyway, so treat this corner-case early to eliminate
-	 * lttng_fmemopen error for 0-byte allocation.
-	 */
-	if (handle == NULL || filter_expression[0] == '\0') {
-		return -LTTNG_ERR_INVALID;
-	}
-
-	/*
-	 * casting const to non-const, as the underlying function will
-	 * use it in read-only mode.
-	 */
-	fmem = lttng_fmemopen((void *) filter_expression,
-			strlen(filter_expression), "r");
-	if (!fmem) {
-		fprintf(stderr, "Error opening memory as stream\n");
-		return -LTTNG_ERR_FILTER_NOMEM;
-	}
-	ctx = filter_parser_ctx_alloc(fmem);
-	if (!ctx) {
-		fprintf(stderr, "Error allocating parser\n");
-		ret = -LTTNG_ERR_FILTER_NOMEM;
-		goto alloc_error;
-	}
-	ret = filter_parser_ctx_append_ast(ctx);
-	if (ret) {
-		fprintf(stderr, "Parse error\n");
-		ret = -LTTNG_ERR_FILTER_INVAL;
-		goto parse_error;
-	}
-	ret = filter_visitor_set_parent(ctx);
-	if (ret) {
-		fprintf(stderr, "Set parent error\n");
-		ret = -LTTNG_ERR_FILTER_INVAL;
-		goto parse_error;
-	}
-	if (print_xml) {
-		ret = filter_visitor_print_xml(ctx, stdout, 0);
-		if (ret) {
-			fflush(stdout);
-			fprintf(stderr, "XML print error\n");
-			ret = -LTTNG_ERR_FILTER_INVAL;
-			goto parse_error;
-		}
-	}
-
-	dbg_printf("Generating IR... ");
-	fflush(stdout);
-	ret = filter_visitor_ir_generate(ctx);
-	if (ret) {
-		fprintf(stderr, "Generate IR error\n");
-		ret = -LTTNG_ERR_FILTER_INVAL;
-		goto parse_error;
-	}
-	dbg_printf("done\n");
-
-	dbg_printf("Validating IR... ");
-	fflush(stdout);
-	ret = filter_visitor_ir_check_binary_op_nesting(ctx);
-	if (ret) {
-		ret = -LTTNG_ERR_FILTER_INVAL;
-		goto parse_error;
-	}
-	dbg_printf("done\n");
-
-	dbg_printf("Generating bytecode... ");
-	fflush(stdout);
-	ret = filter_visitor_bytecode_generate(ctx);
-	if (ret) {
-		fprintf(stderr, "Generate bytecode error\n");
-		ret = -LTTNG_ERR_FILTER_INVAL;
-		goto parse_error;
-	}
-	dbg_printf("done\n");
-	dbg_printf("Size of bytecode generated: %u bytes.\n",
-		bytecode_get_len(&ctx->bytecode->b));
-
-	memset(&lsm, 0, sizeof(lsm));
-
-	lsm.cmd_type = LTTNG_ENABLE_EVENT_WITH_FILTER;
-
-	/* If no channel name, send empty string. */
-	if (channel_name == NULL) {
-		lttng_ctl_copy_string(lsm.u.enable.channel_name, "",
-				sizeof(lsm.u.enable.channel_name));
-	} else {
-		lttng_ctl_copy_string(lsm.u.enable.channel_name, channel_name,
-				sizeof(lsm.u.enable.channel_name));
-	}
-
-	/* Copy event name */
-	if (event) {
-		memcpy(&lsm.u.enable.event, event, sizeof(lsm.u.enable.event));
-	}
-
-	lsm.u.enable.bytecode_len = sizeof(ctx->bytecode->b)
-			+ bytecode_get_len(&ctx->bytecode->b);
-
-	lttng_ctl_copy_lttng_domain(&lsm.domain, &handle->domain);
-
-	lttng_ctl_copy_string(lsm.session.name, handle->session_name,
-			sizeof(lsm.session.name));
-
-	ret = lttng_ctl_ask_sessiond_varlen(&lsm, &ctx->bytecode->b,
-				lsm.u.enable.bytecode_len, NULL);
-
-	filter_bytecode_free(ctx);
-	filter_ir_free(ctx);
-	filter_parser_ctx_free(ctx);
-	if (fclose(fmem) != 0) {
-		perror("fclose");
-	}
-	return ret;
-
-parse_error:
-	filter_bytecode_free(ctx);
-	filter_ir_free(ctx);
-	filter_parser_ctx_free(ctx);
-alloc_error:
-	if (fclose(fmem) != 0) {
-		perror("fclose");
-	}
-	return ret;
+	return lttng_enable_event_with_exclusions(handle, event, channel_name,
+			filter_expression, 0, NULL);
 }
 
 /*
-- 
1.8.1.2
