From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH lttng-tools] Fix: memleak in liblttng-ctl
	visit_node_load()
Date: Fri, 14 Jun 2013 16:34:56 -0400
Message-ID: <20130614203456.GA31559__35621.5757121847$1371242132$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Unai1-0006yv-Du
	for lttng-dev@lists.lttng.org; Fri, 14 Jun 2013 16:34:57 -0400
Content-Disposition: inline
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

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
diff --git a/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c b/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c
index 785c113..762d604 100644
--- a/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c
+++ b/src/lib/lttng-ctl/filter/filter-visitor-generate-bytecode.c
@@ -263,6 +263,7 @@ int visit_node_load(struct filter_parser_ctx *ctx, struct ir_op *node)
 			insn->op = FILTER_OP_GET_CONTEXT_REF;
 			break;
 		default:
+			free(insn);
 			return -EINVAL;
 		}
 		ref_offset.offset = (uint16_t) -1U;

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
