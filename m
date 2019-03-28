From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [PATCH lttng-tools] Clean-up: Remove double buffer
 initialisation
Date: Thu, 28 Mar 2019 15:07:43 -0400
Message-ID: <20190328190743.4146-1-ylamarre__46628.3902221889$1553800091$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44VZBg6qgfz185f
 for <lttng-dev@lists.lttng.org>; Thu, 28 Mar 2019 15:07:55 -0400 (EDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
 src/lib/lttng-ctl/lttng-ctl.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
index 165fef4d..92634c00 100644
--- a/src/lib/lttng-ctl/lttng-ctl.c
+++ b/src/lib/lttng-ctl/lttng-ctl.c
@@ -1078,7 +1078,11 @@ int lttng_enable_event_with_exclusions(struct lttng_handle *handle,
 	unsigned int free_filter_expression = 0;
 	struct filter_parser_ctx *ctx = NULL;
 
-	memset(&send_buffer, 0, sizeof(send_buffer));
+	/*
+	 * We have either a filter or some exclusions, so we need to set up
+	 * a variable-length memory block from where to send the data.
+	 */
+	lttng_dynamic_buffer_init(&send_buffer);
 
 	/*
 	 * Cast as non-const since we may replace the filter expression
@@ -1128,12 +1132,6 @@ int lttng_enable_event_with_exclusions(struct lttng_handle *handle,
 	lsm.u.enable.exclusion_count = exclusion_count;
 	lsm.u.enable.bytecode_len = 0;
 
-	/*
-	 * We have either a filter or some exclusions, so we need to set up
-	 * a variable-length memory block from where to send the data.
-	 */
-	lttng_dynamic_buffer_init(&send_buffer);
-
 	/* Parse filter expression. */
 	if (filter_expression != NULL || handle->domain.type == LTTNG_DOMAIN_JUL
 			|| handle->domain.type == LTTNG_DOMAIN_LOG4J
-- 
2.11.0
