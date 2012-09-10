From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [commit for review] Fix recent filter regressions
Date: Mon, 10 Sep 2012 10:54:31 -0400
Message-ID: <20120910145431.GA15712__3826.54962963915$1347288904$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TB5Ng-0006UT-Hj
	for lttng-dev@lists.lttng.org; Mon, 10 Sep 2012 10:54:32 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: christian.babeux@efficios.com
Cc: lttng-dev@lists.lttng.org, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

Hi!

Please review this patch from my pull queue for lttng-tools. As soon as
we get your Acked-by, David will pull it.

Thanks,

Mathieu

commit 0efe3e86f1143393016e1ab7623827c06c466e9f
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Sep 10 10:45:41 2012 -0400

    Fix filter: fix recent regressions
    
    Fix:
    commit d93c4f1ffcffa73102e3299276f2f83951a68c36
    Author: Christian Babeux <christian.babeux@efficios.com>
    Date:   Thu Sep 6 13:40:19 2012 -0400
    
        Fix: Accept bytecode of length 65536 bytes
    
    Broke the filter: it changed the reloc table format, without knowledge
    of UST, and without good reason: it should stay { uint16_t, string } --
    it does not need a uint32_t offset. Add a check for the value returned
    by bytecode_get_len() when populating the reloc table.
    
    Fix:
    commit 5ddb0a08c5c3ca917b025032b864d78e53c7c68a
    Author: Christian Babeux <christian.babeux@efficios.com>
    Date:   Mon Aug 27 14:48:21 2012 -0400
    
        Fix: Generation of bytecode longer than 32768 bytes fails
    
    Mixed the concepts of "len" and "alloc_len". It was therefore not
    checking the bounds correctly, and was not zeroing the memory range
    expected to be zeroed, causing out-of-bound array access.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

diff --git a/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c b/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c
index 332a387..0d65585 100644
--- a/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c
+++ b/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c
@@ -94,21 +94,21 @@ int32_t bytecode_reserve(struct lttng_filter_bytecode_alloc **fb, uint32_t align
 {
 	int32_t ret;
 	uint32_t padding = offset_align((*fb)->b.len, align);
+	uint32_t new_len = (*fb)->b.len + padding + len;
+	uint32_t new_alloc_len = sizeof(struct lttng_filter_bytecode) + new_len;
+	uint32_t old_alloc_len = (*fb)->alloc_len;
 
-	if ((*fb)->b.len + padding + len > LTTNG_FILTER_MAX_LEN)
+	if (new_len > LTTNG_FILTER_MAX_LEN)
 		return -EINVAL;
 
-	if ((*fb)->b.len + padding + len > (*fb)->alloc_len) {
-		uint32_t new_len =
-			max_t(uint32_t, 1U << get_count_order((*fb)->b.len + padding + len),
-				(*fb)->alloc_len << 1);
-		uint32_t old_len = (*fb)->alloc_len;
-
-		*fb = realloc(*fb, sizeof(struct lttng_filter_bytecode_alloc) + new_len);
+	if (new_alloc_len > old_alloc_len) {
+		new_alloc_len =
+			max_t(uint32_t, 1U << get_count_order(new_alloc_len), old_alloc_len << 1);
+		*fb = realloc(*fb, new_alloc_len);
 		if (!*fb)
 			return -ENOMEM;
-		memset(&(*fb)->b.data[old_len], 0, new_len - old_len);
-		(*fb)->alloc_len = new_len;
+		memset(&((char *) *fb)[old_alloc_len], 0, new_alloc_len - old_alloc_len);
+		(*fb)->alloc_len = new_alloc_len;
 	}
 	(*fb)->b.len += padding;
 	ret = (*fb)->b.len;
@@ -239,7 +239,7 @@ int visit_node_load(struct filter_parser_ctx *ctx, struct ir_op *node)
 		uint32_t insn_len = sizeof(struct load_op)
 			+ sizeof(struct field_ref);
 		struct field_ref ref_offset;
-		uint32_t reloc_offset;
+		uint16_t reloc_offset;
 
 		insn = calloc(insn_len, 1);
 		if (!insn)
@@ -249,6 +249,9 @@ int visit_node_load(struct filter_parser_ctx *ctx, struct ir_op *node)
 		memcpy(insn->data, &ref_offset, sizeof(ref_offset));
 		/* reloc_offset points to struct load_op */
 		reloc_offset = bytecode_get_len(&ctx->bytecode->b);
+		if (reloc_offset > LTTNG_FILTER_MAX_LEN - 1) {
+			return -EINVAL;
+		}
 		ret = bytecode_push(&ctx->bytecode, insn, 1, insn_len);
 		if (ret) {
 			free(insn);

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
