From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH babeltrace 2/3] Fix: CTF parser: accept signed
	constant literals
Date: Tue,  9 Feb 2016 13:27:23 -0500
Message-ID: <1455042444-23148-2-git-send-email-mathieu.desnoyers__13463.8487863869$1455042560$gmane$org@efficios.com>
References: <1455042444-23148-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mathieu.desnoyers@efficios.com>) id 1aTD1A-0007do-BA
 for lttng-dev@lists.lttng.org; Tue, 09 Feb 2016 13:28:06 -0500
In-Reply-To: <1455042444-23148-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Those are inaccurately rejected by the parser due to this bug. This
affects environment variables and loglevel values.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 formats/ctf/metadata/ctf-visitor-generate-io-struct.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
index 4b17198..1831b2d 100644
--- a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
+++ b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
@@ -219,7 +219,6 @@ int get_unary_signed(struct bt_list_head *head, int64_t *value)
 
 	bt_list_for_each_entry(node, head, siblings) {
 		if (node->type != NODE_UNARY_EXPRESSION
-				|| node->u.unary_expression.type != UNARY_UNSIGNED_CONSTANT
 				|| (node->u.unary_expression.type != UNARY_UNSIGNED_CONSTANT && node->u.unary_expression.type != UNARY_SIGNED_CONSTANT)
 				|| node->u.unary_expression.link != UNARY_LINK_UNKNOWN
 				|| i != 0)
-- 
2.1.4
