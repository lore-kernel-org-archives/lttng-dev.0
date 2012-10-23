From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Fix: Possible memory leaks when
	creating filter IR root node
Date: Tue, 23 Oct 2012 15:36:17 -0400
Message-ID: <1351020977-18412-1-git-send-email-christian.babeux__19681.8372155123$1351021034$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TQkHA-0000Rk-64
	for lttng-dev@lists.lttng.org; Tue, 23 Oct 2012 15:36:32 -0400
Received: by mail-ia0-f176.google.com with SMTP id h11so3751377iae.35
	for <lttng-dev@lists.lttng.org>; Tue, 23 Oct 2012 12:36:26 -0700 (PDT)
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


Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
---
 src/lib/lttng-ctl/filter/filter-visitor-generate-ir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/lib/lttng-ctl/filter/filter-visitor-generate-ir.c b/src/lib/lttng-ctl/filter/filter-visitor-generate-ir.c
index eec78fc..84122c9 100644
--- a/src/lib/lttng-ctl/filter/filter-visitor-generate-ir.c
+++ b/src/lib/lttng-ctl/filter/filter-visitor-generate-ir.c
@@ -46,9 +46,11 @@ struct ir_op *make_op_root(struct ir_op *child, enum ir_side side)
 	case IR_DATA_UNKNOWN:
 	default:
 		fprintf(stderr, "[error] Unknown root child data type\n");
+		free(op);
 		return NULL;
 	case IR_DATA_STRING:
 		fprintf(stderr, "[error] String cannot be root data type\n");
+		free(op);
 		return NULL;
 	case IR_DATA_NUMERIC:
 	case IR_DATA_FIELD_REF:
-- 
1.7.12.2
