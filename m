From: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Subject: [PATCH lttng-tools 20/28] Send enable-event commands
	with exclusion data
Date: Thu,  7 Nov 2013 12:21:59 +0200
Message-ID: <1383819727-6843-1-git-send-email-jp_ikaheimonen__37711.7674368948$1383819988$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1VeMjE-0007cE-IC
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 05:22:22 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1VeMj9-0006F2-3V from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 07 Nov 2013 02:22:15 -0800
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

Create new function lttng_enable_event_with_exclusions().
This function deals with the various permutations of data that are
possible to accompany the enable-event command:
- all events / some events
- no filter / a filter
- no exclusions / some exclusions

The function generates the appropriate command structures and data
and sends it to the session.

Signed-off-by: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
---
 include/lttng/lttng.h         |  17 ++++
 src/lib/lttng-ctl/lttng-ctl.c | 208 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 225 insertions(+)

diff --git a/include/lttng/lttng.h b/include/lttng/lttng.h
index 0307536..255f7c4 100644
--- a/include/lttng/lttng.h
+++ b/include/lttng/lttng.h
@@ -573,6 +573,23 @@ extern int lttng_enable_event_with_filter(struct lttng_handle *handle,
 		const char *filter_expression);
 
 /*
+ * Create or enable an event with a filter and/or exclusions.
+ *
+ * If the event you are trying to enable does not exist, it will be created,
+ * else it is enabled.
+ * If ev is NULL, all events are enabled with the filter and exclusion options.
+ * If channel_name is NULL, the default channel is used (channel0) and created
+ * if not found.
+ * If filter_expression is NULL, an event without associated filter is
+ * created.
+ * If exclusion count is zero, the event will be created without exclusions.
+ */
+extern int lttng_enable_event_with_exclusions(struct lttng_handle *handle,
+		struct lttng_event *event, const char *channel_name,
+		const char *filter_expression,
+		int exclusion_count, char **exclusion_names);
+
+/*
  * Create or enable a channel.
  *
  * The chan and handle params can not be NULL.
diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
index 83a46a4..21173ca 100644
--- a/src/lib/lttng-ctl/lttng-ctl.c
+++ b/src/lib/lttng-ctl/lttng-ctl.c
@@ -855,6 +855,214 @@ alloc_error:
 }
 
 /*
+ * Enable event(s) for a channel, possibly with exclusions and a filter.
+ * If no event name is specified, all events are enabled.
+ * If no channel name is specified, the default name is used.
+ * If filter expression is not NULL, the filter is set for the event.
+ * If exclusion count is not zero, the exclusions are set for the event.
+ * Returns size of returned session payload data or a negative error code.
+ */
+int lttng_enable_event_with_exclusions(struct lttng_handle *handle,
+		struct lttng_event *ev, const char *channel_name,
+		const char *filter_expression,
+		int exclusion_count, char **exclusion_list)
+{
+	struct lttcomm_session_msg lsm;
+	char *varlen_data;
+	int ret = 0;
+	struct filter_parser_ctx *ctx = NULL;
+	FILE *fmem = NULL;
+
+	if (handle == NULL || ev == NULL) {
+		return -LTTNG_ERR_INVALID;
+	}
+
+	/* Empty filter string will always be rejected by the parser
+	 * anyway, so treat this corner-case early to eliminate
+	 * lttng_fmemopen error for 0-byte allocation.
+	 */
+	if (filter_expression && filter_expression[0] == '\0') {
+		return -LTTNG_ERR_INVALID;
+	}
+
+	memset(&lsm, 0, sizeof(lsm));
+
+	/* If no channel name, send empty string. */
+	if (channel_name == NULL) {
+		lttng_ctl_copy_string(lsm.u.enable.channel_name, "",
+				sizeof(lsm.u.enable.channel_name));
+	} else {
+		lttng_ctl_copy_string(lsm.u.enable.channel_name, channel_name,
+				sizeof(lsm.u.enable.channel_name));
+	}
+
+	lttng_ctl_copy_lttng_domain(&lsm.domain, &handle->domain);
+
+	/* figure out correct command type, based on if we have a filter or exclusions */
+	if (exclusion_count == 0) {
+		if (filter_expression == NULL) {
+			if (ev->name[0] != '\0') {
+				lsm.cmd_type = LTTNG_ENABLE_EVENT;
+			} else {
+				lsm.cmd_type = LTTNG_ENABLE_ALL_EVENT;
+			}
+		} else {
+			lsm.cmd_type = LTTNG_ENABLE_EVENT_WITH_FILTER;
+		}
+	} else {
+		lsm.cmd_type = LTTNG_ENABLE_EVENT_WITH_EXCLUSION;
+	}
+
+	memcpy(&lsm.u.enable.event, ev, sizeof(lsm.u.enable.event));
+
+	lttng_ctl_copy_string(lsm.session.name, handle->session_name,
+			sizeof(lsm.session.name));
+	lsm.u.enable.exclusion_count = exclusion_count;
+	lsm.u.enable.bytecode_len = 0;
+
+	if (exclusion_count == 0 && filter_expression == NULL) {
+		ret = lttng_ctl_ask_sessiond(&lsm, NULL);
+		return ret;
+	}
+
+	/*
+	 * We have either a filter or some exclusions, so we need to set up
+	 * a variable-length memory block from where to send the data
+	 */
+
+	/* Parse filter expression */
+	if (filter_expression != NULL) {
+
+		/*
+		 * casting const to non-const, as the underlying function will
+		 * use it in read-only mode.
+		 */
+		fmem = lttng_fmemopen((void *) filter_expression,
+				strlen(filter_expression), "r");
+		if (!fmem) {
+			fprintf(stderr, "Error opening memory as stream\n");
+			return -LTTNG_ERR_FILTER_NOMEM;
+		}
+		ctx = filter_parser_ctx_alloc(fmem);
+		if (!ctx) {
+			fprintf(stderr, "Error allocating parser\n");
+			ret = -LTTNG_ERR_FILTER_NOMEM;
+			goto filter_alloc_error;
+		}
+		ret = filter_parser_ctx_append_ast(ctx);
+		if (ret) {
+			fprintf(stderr, "Parse error\n");
+			ret = -LTTNG_ERR_FILTER_INVAL;
+			goto parse_error;
+		}
+		ret = filter_visitor_set_parent(ctx);
+		if (ret) {
+			fprintf(stderr, "Set parent error\n");
+			ret = -LTTNG_ERR_FILTER_INVAL;
+			goto parse_error;
+		}
+		if (print_xml) {
+			ret = filter_visitor_print_xml(ctx, stdout, 0);
+			if (ret) {
+				fflush(stdout);
+				fprintf(stderr, "XML print error\n");
+				ret = -LTTNG_ERR_FILTER_INVAL;
+				goto parse_error;
+			}
+		}
+
+		dbg_printf("Generating IR... ");
+		fflush(stdout);
+		ret = filter_visitor_ir_generate(ctx);
+		if (ret) {
+			fprintf(stderr, "Generate IR error\n");
+			ret = -LTTNG_ERR_FILTER_INVAL;
+			goto parse_error;
+		}
+		dbg_printf("done\n");
+
+		dbg_printf("Validating IR... ");
+		fflush(stdout);
+		ret = filter_visitor_ir_check_binary_op_nesting(ctx);
+		if (ret) {
+			ret = -LTTNG_ERR_FILTER_INVAL;
+			goto parse_error;
+		}
+		dbg_printf("done\n");
+
+		dbg_printf("Generating bytecode... ");
+		fflush(stdout);
+		ret = filter_visitor_bytecode_generate(ctx);
+		if (ret) {
+			fprintf(stderr, "Generate bytecode error\n");
+			ret = -LTTNG_ERR_FILTER_INVAL;
+			goto parse_error;
+		}
+		dbg_printf("done\n");
+		dbg_printf("Size of bytecode generated: %u bytes.\n",
+			bytecode_get_len(&ctx->bytecode->b));
+
+		lsm.u.enable.bytecode_len = sizeof(ctx->bytecode->b)
+				+ bytecode_get_len(&ctx->bytecode->b);
+	}
+
+	/* Allocate variable length data */
+	if (lsm.u.enable.exclusion_count != 0) {
+		varlen_data = zmalloc(lsm.u.enable.bytecode_len
+				+ LTTNG_SYMBOL_NAME_LEN * exclusion_count);
+		if (!varlen_data) {
+			ret = -LTTNG_ERR_EXCLUSION_NOMEM;
+			goto varlen_alloc_error;
+		}
+		/* Put exclusion names first in the data */
+		while (exclusion_count--) {
+			strncpy(varlen_data + LTTNG_SYMBOL_NAME_LEN * exclusion_count,
+					*(exclusion_list + exclusion_count),
+					LTTNG_SYMBOL_NAME_LEN);
+		}
+		/* Add filter bytecode next */
+		if (lsm.u.enable.bytecode_len != 0) {
+			memcpy(varlen_data + LTTNG_SYMBOL_NAME_LEN * lsm.u.enable.exclusion_count,
+					&ctx->bytecode->b,
+					lsm.u.enable.bytecode_len);
+		}
+	} else {
+		/* no exclusions - use the already allocated filter bytecode */
+		varlen_data = (char *)(&ctx->bytecode->b);
+	}
+
+	ret = lttng_ctl_ask_sessiond_varlen(&lsm, varlen_data,
+			LTTNG_SYMBOL_NAME_LEN * lsm.u.enable.exclusion_count
+					+ lsm.u.enable.bytecode_len,
+			NULL);
+
+	if (lsm.u.enable.exclusion_count != 0) {
+		free(varlen_data);
+	}
+
+varlen_alloc_error:
+	if (filter_expression) {
+		filter_bytecode_free(ctx);
+		filter_ir_free(ctx);
+		filter_parser_ctx_free(ctx);
+		if (fclose(fmem) != 0) {
+			perror("fclose");
+		}
+	}
+	return ret;
+
+parse_error:
+	filter_bytecode_free(ctx);
+	filter_ir_free(ctx);
+	filter_parser_ctx_free(ctx);
+filter_alloc_error:
+	if (fclose(fmem) != 0) {
+		perror("fclose");
+	}
+	return ret;
+}
+
+/*
  *  Disable event(s) of a channel and domain.
  *  If no event name is specified, all events are disabled.
  *  If no channel name is specified, the default 'channel0' is used.
-- 
1.8.1.2
