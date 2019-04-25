From: Yannick Lamarre <ylamarre@efficios.com>
Subject: [PATCH lttng-tools v6 5/8] Fix: hang in thread_rotation
 when using compat-poll
Date: Thu, 25 Apr 2019 18:23:31 -0400
Message-ID: <20190425222334.30349-6-ylamarre__4390.04603992856$1556231213$gmane$org@efficios.com>
References: <20190425222334.30349-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44qsCn4q7Lz1L3w
 for <lttng-dev@lists.lttng.org>; Thu, 25 Apr 2019 18:23:49 -0400 (EDT)
In-Reply-To: <20190425222334.30349-1-ylamarre@efficios.com>
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

Add missing verification to prevent a blocking read on an empty fd.

Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
---
 src/bin/lttng-sessiond/rotation-thread.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/bin/lttng-sessiond/rotation-thread.c b/src/bin/lttng-sessiond/rotation-thread.c
index 6669372d..b86b1668 100644
--- a/src/bin/lttng-sessiond/rotation-thread.c
+++ b/src/bin/lttng-sessiond/rotation-thread.c
@@ -974,6 +974,10 @@ void *thread_rotation(void *data)
 			int fd = LTTNG_POLL_GETFD(&thread.events, i);
 			uint32_t revents = LTTNG_POLL_GETEV(&thread.events, i);
 
+			if (!revents) {
+				/* No activity for this FD (poll implementation). */
+				continue;
+			}
 			DBG("[rotation-thread] Handling fd (%i) activity (%u)",
 					fd, revents);
 
-- 
2.11.0
