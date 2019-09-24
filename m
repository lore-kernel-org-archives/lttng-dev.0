From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Fix: use newly created event filter
 for condition check
Date: Tue, 24 Sep 2019 10:53:16 -0400
Message-ID: <20190924145316.21302-1-jonathan.rajotte-julien__10174.4646135316$1569336830$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46d4266GQRzr4T
 for <lttng-dev@lists.lttng.org>; Tue, 24 Sep 2019 10:53:34 -0400 (EDT)
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

4c5e3185d75ffe90b04107744693964d9051fb6b introduced a regression while
fixing the filter and filter_expression ownership.

Setting the "filter" object to NULL prevents the call to
add_filter_app_ctx when needed.

We use the filter from the newly created event to
perform the check and the call to add_filter_app_ctx.

Fixes coverity #1399733

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/bin/lttng-sessiond/event.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/bin/lttng-sessiond/event.c b/src/bin/lttng-sessiond/event.c
index f32db4429..a8b7646da 100644
--- a/src/bin/lttng-sessiond/event.c
+++ b/src/bin/lttng-sessiond/event.c
@@ -513,8 +513,9 @@ int event_agent_enable(struct ltt_ust_session *usess,
 		created = 1;
 	}
 
-	if (created && filter) {
-		ret = add_filter_app_ctx(filter, filter_expression, agt);
+	if (created && aevent->filter) {
+		ret = add_filter_app_ctx(
+				aevent->filter, aevent->filter_expression, agt);
 		if (ret != LTTNG_OK) {
 			goto error;
 		}
-- 
2.17.1
