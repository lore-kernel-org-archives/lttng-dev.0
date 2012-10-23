From: Christian Babeux <christian.babeux@efficios.com>
Subject: [PATCH lttng-tools] Fix: Handle the unary bitwise
	negation operator (~) in the XML printer
Date: Tue, 23 Oct 2012 15:36:41 -0400
Message-ID: <1351021001-18480-1-git-send-email-christian.babeux__18760.9225082726$1351021046$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TQkHV-0000Si-KO
	for lttng-dev@lists.lttng.org; Tue, 23 Oct 2012 15:36:53 -0400
Received: by mail-ie0-f176.google.com with SMTP id k11so6763540iea.35
	for <lttng-dev@lists.lttng.org>; Tue, 23 Oct 2012 12:36:48 -0700 (PDT)
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
 src/lib/lttng-ctl/filter/filter-visitor-xml.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/lib/lttng-ctl/filter/filter-visitor-xml.c b/src/lib/lttng-ctl/filter/filter-visitor-xml.c
index 90a336d..1d14f2e 100644
--- a/src/lib/lttng-ctl/filter/filter-visitor-xml.c
+++ b/src/lib/lttng-ctl/filter/filter-visitor-xml.c
@@ -235,6 +235,9 @@ int recursive_visit_print(struct filter_node *node, FILE *stream, int indent)
 		case AST_UNARY_NOT:
 			fprintf(stream, "\"!\"");
 			break;
+		case AST_UNARY_BIN_NOT:
+			fprintf(stream, "\"~\"");
+			break;
 		}
 		fprintf(stream, ">\n");
 		ret = recursive_visit_print(node->u.unary_op.child,
-- 
1.7.12.2
