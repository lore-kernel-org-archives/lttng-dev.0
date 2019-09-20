From: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Subject: [PATCH lttng-tools] Refactor: remove logically dead code
Date: Fri, 20 Sep 2019 11:40:37 -0400
Message-ID: <20190920154037.74966-1-jonathan.rajotte-julien__23320.1329525158$1568994123$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46ZdGM3HHlzqQY
 for <lttng-dev@lists.lttng.org>; Fri, 20 Sep 2019 11:40:43 -0400 (EDT)
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

Fixes coverity #1400681

Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
---
 src/common/session-descriptor.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/src/common/session-descriptor.c b/src/common/session-descriptor.c
index 208eb46ff..713731c3e 100644
--- a/src/common/session-descriptor.c
+++ b/src/common/session-descriptor.c
@@ -550,14 +550,8 @@ lttng_session_descriptor_live_create(
 	struct lttng_session_descriptor_live *descriptor;
 
 	descriptor = _lttng_session_descriptor_live_create(name, live_timer_us);
-	if (!descriptor) {
-		goto error;
-	}
 
 	return descriptor ? &descriptor->base : NULL;
-error:
-	lttng_session_descriptor_destroy(descriptor ? &descriptor->base : NULL);
-	return NULL;
 }
 
 struct lttng_session_descriptor *
-- 
2.17.1
