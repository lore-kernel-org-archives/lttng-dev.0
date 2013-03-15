From: Yao Qi <yao@codesourcery.com>
Subject: [PATCH] Teach babeltrace understand "native" and
	"network" for byte_order
Date: Fri, 15 Mar 2013 17:52:17 +0800
Message-ID: <1363341137-26956-1-git-send-email-yao__22167.1540210538$1363341291$gmane$org@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Yao_Qi@mentor.com>) id 1UGRKI-0007Sa-82
	for lttng-dev@lists.lttng.org; Fri, 15 Mar 2013 05:53:26 -0400
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1UGRKC-0002B6-87 from Yao_Qi@mentor.com
	for lttng-dev@lists.lttng.org; Fri, 15 Mar 2013 02:53:20 -0700
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

Hi,
We wrote byte_order in metadata either "le" or "be", according to the
host endianness.  Today, when I check the ctf specification, I find
"native" fits our needs well.  However, after I replace "le" with
"native" in metadata, I got the following error message:

  [error] get_trace_byte_order: unexpected string "native". Should be "native", "network", "be" or "le".

This patch teaches babeltrace understand "native" and "network".  With
this patch applied, the output looks right now.  Let me know if I need
run testsuite, and how.

Signed-off-by: Yao Qi <yao@codesourcery.com>
---
 .../ctf/metadata/ctf-visitor-generate-io-struct.c  |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
index 9bcc170..cea2877 100644
--- a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
+++ b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
@@ -1227,6 +1227,10 @@ int get_trace_byte_order(FILE *fd, int depth, struct ctf_node *unary_expression)
 		byte_order = BIG_ENDIAN;
 	else if (!strcmp(unary_expression->u.unary_expression.u.string, "le"))
 		byte_order = LITTLE_ENDIAN;
+	else if (!strcmp(unary_expression->u.unary_expression.u.string, "native"))
+		byte_order = BYTE_ORDER;
+	else if (!strcmp(unary_expression->u.unary_expression.u.string, "network"))
+		byte_order = BIG_ENDIAN;
 	else {
 		fprintf(fd, "[error] %s: unexpected string \"%s\". Should be \"be\" or \"le\".\n",
 			__func__, unary_expression->u.unary_expression.u.string);
-- 
1.7.7.6
